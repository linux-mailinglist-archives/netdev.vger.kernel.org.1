Return-Path: <netdev+bounces-291384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPVIFeN+FGowNwcAu9opvQ
	(envelope-from <netdev+bounces-291384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:54:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0965CD153
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2285303B6EF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0623F54A0;
	Mon, 25 May 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QggBvHIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE93ACF11;
	Mon, 25 May 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727901; cv=none; b=ST0pC9B+i6ZxSToS0GBa5962skrxx57TfrpVVtWWR2L+Qy+eNQ3LBYd3YBc67SZH6M6NNMpHf/JQqSa8IVLfqtk0T647zepyXmV2O0OTIPlIrqa3cjVKV+WTrfoc/o0ZnZ/k7FCGilaQjFWpLd1Gla1PkaigNJEcCxqPk/UuoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727901; c=relaxed/simple;
	bh=admae0ikcPZmndy4BF7pn5X3ZSqnpP8hq0sKDNqalmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr09s1x04RuzfQsNbEbz763RHYAEOHJtLJx02DUSwM6x8ctXe2c+sqo0QVjWDhhJyxs67yopLFhMcrtYkdhiqrF+6kmjazhUJNsaQWFv5trNU7RTn7byWyHRlIUyV6ECnAZjODiYe83z8zM2hOJDuMtFZp4Xv/itqt8DAXhhmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QggBvHIa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D91F00A3E;
	Mon, 25 May 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727900;
	bh=T5lTmWuuWaMPiOjTHMCXGVFaJdiWeerfyg6lzH6gsP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QggBvHIaRoKo1wymS4OJr18A2jiubdvZg1DPmgLT31hCAa4LCABnnD9G2QUIfERjv
	 kNOjsdhHjKpHXrhloBejUh4AB47B0vtSPnx20sqWfPnzkoB64/oNSKlcz+HxHRM5KR
	 wojjGXJq7h/xGvLfS/3y+c4lafrpSrnptWlT8NNrjz/LYV58CEw21sm+pKArvmFhE+
	 iXDjaqP3tc4D7Km8MflxUkY6sFwzmN4MLmSLsadQCv8OQM+UJjud/0nHTVFZVBVQgi
	 dAT6psDcD5eUrmN7lLdLELIdEkewtS5zdLyZMabFDEDiClTl3IKBugrLgVpZYcKe4k
	 26/b3oEZg0Lcg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:22 -0400
Subject: [PATCH net v3 8/8] net/handshake: Drain pending requests at net
 namespace exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-8-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Z3FNtFN+AsR1CzlrdFXZjc/eykqu5b0u0GKUw75gq6k=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4S3jAuaw2WLUG21fibHEltq6Hlp6vrIUqsS
 75whnEpAOqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 l8ocEACY9buDtmzu4r2zV+YM5nwGIgw1W073jhnqcbhNN9aZVn+MJ8q+rnsEf1bd5e/1PNsd5Yq
 QEG8o7efxnzRPGbxzccXNsw3GI9G+qNzFyRS6r+6iT6A2m4TH9kbYE6tXk6hql73P68m+bK8SlW
 zCNYt00H/pm4lhAfw4EhUf8D2FHgtNjtUhJHpy/5zku+n5E4pN3B9nMit1wlQi4fHJu5Dn8fSPT
 GrABns7n4yaH3GQsLWiLMmR+IPoh/qjX4tTEdQXfTiUoKQzuQLXktOcTPS6QfErHUxxESm9KbwE
 lTdGlnt2lfRNcGulIUnuqnfiWoSXEMeOznXgS9/6UfUpogQF5f13kUC+q3YhgK9raWDM39o7Kq8
 BXTIntkahJe/NW8O7CExHRs8gYTiajHMV1aJszUposW9bdIOo4fh1YxpeyHsk9sS+Wi7R5ttca4
 Fv0QvEbqKJw40e6c6IpDLCQDQcTEJAvu2cQA294xi3tJeA20O+rQVFLxvxpG/SQLm9+m0TR3U+w
 5SE48quDp91yYat+LIhCz3CbewT1qhKwPwo4FKyLwqN2he8tHJXq9nFBuLDXxFhL4i3Bv3/z/9c
 g8Mm74dskNAx7uKuQxzAXCIKBf+wd6NVSOq6BBPh6HayjyGKIBRjGQgPfhU9PxTkktQhe5q3xjx
 TobcID3QYJC2MYw==
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
	TAGGED_FROM(0.00)[bounces-291384-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9F0965CD153
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
drain has already taken ownership; handshake_complete()'s existing
test_and_set on HANDSHAKE_F_REQ_COMPLETED still arbitrates
between drain and cancel for who calls the consumer's hp_done. Use
list_del_init() rather than list_del() in the drain so req->hr_list
does not carry LIST_POISON after drain releases the entry.

The DRAINING guard in remove_pending() makes cancel return false,
but cancel still falls through to test_and_set_bit on
HANDSHAKE_F_REQ_COMPLETED and drops the request's hr_file reference.
Without another pin, if that is the last reference, sk_destruct frees
the request while it is still linked on the drain loop's local list.
Pin each request's hr_file under hn_lock before releasing the list,
and drop that drain pin after the loop finishes with the request.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/netlink.c | 10 ++++++++--
 net/handshake/request.c |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 21d6cbd52fcd..3fd4fef9bab1 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -201,13 +201,19 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
+	list_for_each_entry(req, &requests, hr_list)
+		get_file(req->hr_file);
 	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
+		struct file *file;
+
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		file = req->hr_file;
+		list_del_init(&req->hr_list);
 		handshake_complete(req, -ETIMEDOUT, NULL);
+		fput(file);
 	}
 }
 
diff --git a/net/handshake/request.c b/net/handshake/request.c
index bd3d9467ab91..cd30d54d0501 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -163,13 +163,16 @@ static void __remove_pending_locked(struct handshake_net *hn,
  * otherwise %false.
  *
  * If @req was on a pending list, it has not yet been accepted.
+ * Returns %false when the net namespace is draining; the drain
+ * loop has taken ownership of the pending list.
  */
 static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
 	spin_lock_bh(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}

-- 
2.54.0


