Return-Path: <netdev+bounces-289145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMUiBn1aC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A057242C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A0DA3047042
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0E389DED;
	Mon, 18 May 2026 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irqI/Qzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FE3890F0;
	Mon, 18 May 2026 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128695; cv=none; b=n5LifMg9qnkTc0p/A4eYxHhmUbY3Csa1k7+hCVVVRqBIhX0iB17gEPgqFuPnNAGjyIHDeXTjlbZzQwBQrTexTQYXLlfnDCpoXMqHA4avdT3Q8c/vJEA4ilRHVz7UTbxUZ+Yqqt2sV+i/1MFKDzfeoPyxIngNYu9bKGIwO7INWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128695; c=relaxed/simple;
	bh=0YOQDMaHT00FKrFsX3Z/0Ptk2GGsNAdEsx0Aednt3vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q61vZP4xCsZD9cdhlY3+9tSzUjb84UYHOfqBbz3InQJ6NEMD5pKQlZ7cMxpha3WLwykPqdvFCuvH6XjVLUlmmCEFe/8F0K28uYW7EtbP0ShVLXvWU81IbZYh0yJzW6X2L6mmdh2T7sh6WPKgxQ+6ReRqPG324lEDFusq+G+nw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irqI/Qzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93329C2BCC9;
	Mon, 18 May 2026 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128695;
	bh=0YOQDMaHT00FKrFsX3Z/0Ptk2GGsNAdEsx0Aednt3vU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=irqI/Qztz8OAr2RKRGxuoauBWFUNOZmyNRY9ISirfqlh6+9JkN+/5hl36antDW7z1
	 O2EMizJc3vfwAig7jMfGGnfeyVZltxtd2pXeYoHZph3Hfi7/lvKIpU07M2fEh4y0zB
	 9EOo1pf7P7YzHatGLw60xu2ZSgwJM41IPreD2lI9vNqllXVY9JYtBIiYk54lFruIix
	 bwhvMLQ3WTMVy3fkHy+BmJe6DJKYwYjgutR62up8WYhtMmQ2IGeoHHhm8zetrY00Wh
	 IcHlneIYhHkoikzK6FrRzg1B8y5D/urvTggDhJ31KYKNVOEz0L13z/seEmVYsSwGGV
	 +D6Lst6OORp6A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:28 -0400
Subject: [PATCH net 1/7] net/handshake: Drain pending requests at net
 namespace exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2OOqFmnaiOfw920Y/fXorACxTz+mTKmYAHcv24KvEz8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l037A5xZFYEOIS4Xr2DLGvlKw+3mxHKJS4O
 QgftrnkcjOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdAAKCRAzarMzb2Z/
 lz3rEAC38pQdHEPcs2An+Dv1D2iD2znOAUn74Xwu13/2fvl2dv+klzQDkfFGUtrunNSFipzV5Ux
 GzK6ecKZM640frfVkH6iseOhsweUi4NId6fsMZ0PojZEMxuRy6DnTBbzL2AH65kWr39LtxsnZI4
 azewUAU9IwKNEzNGdnZ7v+pjI2nIsFN2agmsm0LRHS7H4f6G/8c8bv45HVEzHmVYUI1C9X0gZ8Z
 O0LHUAr6DGVj3C3oD0ceRLse02oEqi7ssN+jdeR+k9BaAXX8AUXdKFtIjBUAsKT/JQoAFeyJ3uL
 zNOo1p97TExnqzw+noNM/h2XAGrSd6ekkyDTzZG2zlFDe64HjPRM8FheAe6Ma8qAwPxMexNMjWn
 JJe/eYOs9J/H+Wt/CDWZR1qoQDfD1ZQzOc2cU9DeLl7Ojeg1Slg6/1oA+nCtLZD7M2vxb7J2TWH
 7Ui74JFamUvJkUJVb14Wgoa+kNF5/14c2/Y78vHURLYloqbdavuNLrVKcLvNwgurwCyYmQgivyQ
 MGxHrOy3SmBodZs/fLm1eqZAY+daMAuPjEdK+sQkZusFLW9Bco7H1uhgaZ22Kqva6alBEKCQXe4
 uyPY+0ZD6NJ4wyrhWM0zVhmOURw8IR6jNSChSoeLJpyx+vTesmd3C3DAThugtb1i2Gmcb75str3
 1WTX5cR0jxZA3Zw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289145-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 811A057242C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The arguments to list_splice_init() in handshake_net_exit() are
reversed. The call moves the local empty "requests" list onto
hn->hn_requests, leaving the local list empty, so the subsequent
drain loop runs zero iterations. Pending handshake requests that
had not yet been accepted are not torn down when the net namespace
is destroyed; each one keeps a reference on a socket file and on
the handshake_req allocation.

Pass the source and destination in the documented order
(list_splice_init(list, head) moves list onto head) so the pending
list is transferred to the local scratch list and drained through
handshake_complete().

Fixing the splice direction exposes a list-corruption race. After
the splice each req->hr_list still has non-empty link pointers,
threading the stack-local scratch list rather than hn_requests.
A concurrent handshake_req_cancel() -- for example, from sunrpc's
TLS timeout on a kernel socket whose netns reference was not
taken -- finds the request through the rhashtable, calls
remove_pending(), and sees !list_empty(&req->hr_list).
__remove_pending_locked() then list_del_init()s an entry off the
scratch list while the drain iterates, corrupting it. The same
call arriving after the drain loop has run list_del() on an
entry hits LIST_POISON instead.

Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
hn_lock and report not-found when drain is in progress. The
drain has already taken ownership; handshake_complete()'s
existing test_and_set on HANDSHAKE_F_REQ_COMPLETED still
arbitrates between drain and cancel for who calls the consumer's
hp_done. Use list_del_init() rather than list_del() in the drain
so req->hr_list does not carry LIST_POISON after drain releases
the entry.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/netlink.c | 4 ++--
 net/handshake/request.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..a8dd848371ff 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -204,12 +204,12 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
 	spin_unlock(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		list_del_init(&req->hr_list);
 
 		/*
 		 * Requests on this list have not yet been
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..cebafcc341d2 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -168,7 +168,8 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 	bool ret = false;
 
 	spin_lock(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}

-- 
2.54.0


