Return-Path: <netdev+bounces-290507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD0/OvwpD2paHQYAu9opvQ
	(envelope-from <netdev+bounces-290507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC25A8A7C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A1D31B5278
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CA371063;
	Thu, 21 May 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj4BNh0A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B536C0C3;
	Thu, 21 May 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374843; cv=none; b=AUbpLDMo/w94VnKIpU+oIUraBOr2WY19gNIk6/8YejQsD3JhHDRhL5ysMuZYfHkmXkZj7guVHA7FnU8u+tuy2TIthO3K3bc2h+g+Pv+TQ7wOlxVIgUADufPOZPuC/rVcvX41qxNGinh2vhHP5dn4sYeKi9CYW/mk6VbwMOC0Ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374843; c=relaxed/simple;
	bh=+znPby9RitWTd8GSixM/579HsomeqmEVwYRK4Eoeygw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JepwCUVX3z9qqSLreMtUZNEy1P3z3JV9kcTXeZzrvuSWrS7PrYQjjcBGDcADK+dQiK2sbv5SqQwx0gZgNF40ruhcG01L3NUU5i6Ii+YS0uDcj/jXU6fKs9Gsp2/AiKfM3ol4qk1u8VBQCc1hInp1KNNvpG62mRHtbgJFj6xz4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj4BNh0A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0FC1F00A3B;
	Thu, 21 May 2026 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374842;
	bh=88ToqLzOsLRgPD+7KytIGI/hBC10CZr8uP3juS6Bygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jj4BNh0AL06WtaHwm2ADa9PrpZrPZqm7bCXg53TvtX1vS7B7Fn+s1GFYjP4lMwhxs
	 x0SrGwmw4majV1ZNTSvgSyQXDhmI19eEeMXU1Mt8YJaem72h56vbCHjJDPmfQaaj/y
	 iX/paOwiljZTebpUDpEUolgB+FtiOIhvSS3d7RDDS/vB5lHTwlarh9JgjsDKDElQ97
	 1qL9u0RVnsxeuGztKNfv4xCLzplKGC/aIQsgfAyzZdeqztSiKCNvrNRKX7MfxSPko+
	 Xzv7+CbvFlBHdHkF9rzR6oih0BLFpT81o4wmX8c0w1ojieVK50uexGXZGLZRSouKQT
	 s0pV1YoEjx0HQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:07 -0400
Subject: [PATCH net v2 1/7] net/handshake: Drain pending requests at net
 namespace exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-1-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=04KxU8BkirXW/POxVEKdC3sZ1vgwrSdYMhG+EtdWBHc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr32pW2kt6Upg1oWjwfpGLaSnWNlCAnGGwer
 QavL+dDI+WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l2/UD/9pdiwh9wCfLZ8WoZQzibT3XZMF4BuHTOmH++OEqJaywFI1lSVGJoERuNxsQ7ee7Hk1pMi
 XqUsPYhhokBAayDRI8E3eb27fPrWdOzceGNuuWeV1PlK7BRcKqyRNkS7nN9MU9qcDtzzOL5fWIU
 0vcOTNDw1IMAoUITBj63ZSqtfEAWj1FNN+RD4ujiFFZG4D8hvMKfL4G0h7asnBxr6iN/AfUjkZC
 d0A9dTqLlQKMaY6SCtKl6+a3zwgwr2AXs8MX+ZzMd8JhNBLtTQUTi5JmG7jGsN/jPl4pHcbYG9k
 KmONC2ofYTCP8Y4Gpm3kHHTr3mM/SiKXLpzLU9YheMznkBI+E7kRqfsw30o4MdmUfHMGzzhQ02h
 tiGGrtO5RWz/nttxJ5of0yhldrXbGz8LzP3nszJ+Gyx2r4O12hnonzHYdZ2UqtW0w2vT8ZQ4hh9
 r5H7dpV7j1S9FroM2227Pmk+0cmQ0eVPJfHcLTQ6t6WPjujAUh8cJA6bA7L87zlUGJJ5oDOSxP7
 qWiGrXz70MRo6jVCnNIpm505/gs9Gi/hOZ/Ur0FNGZNGW2LnYPED+S8+glugJPAUFqbj1T3G4ig
 3HUaWl0X7I6hp8/8IswAeU1ZCIKsh0tX4r6KRt1rGMVbPVHYIBtgyCCz4bMsGXpxYEOV06yNerH
 PwQO+MxKy8+tVaw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290507-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54CC25A8A7C
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
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


