Return-Path: <netdev+bounces-286293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dKgpFOGSAGoDKgEAu9opvQ
	(envelope-from <netdev+bounces-286293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:14:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F15048F0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690DA300A600
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399335AC3F;
	Sun, 10 May 2026 14:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2BB190462
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422492; cv=none; b=KCTOMPuK4OcfDHPpehAQXgUWiOR56LhVmHaYuOcos/gLgKtO6D5DZL6r9Z92cP8lYIBj6hnxQR5ltfdThAnzjrVV4ut3Cx6uqRj+EQ5t2nbCTYe8GpJ5lrSqhY13OXIEnSgXGLwQqwHW5KYWOaYI8xgTN/2Zr0dGS+ldi5oF4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422492; c=relaxed/simple;
	bh=R30grWO549djSMfpvOKe2WVC4lW2ek0PoXw2vUBOhgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4dq6d++aNJHyQJj8IWnUA8gwBn4t4+7v5fvORKzpE+MAky6vNf3VKDPiULxuNAi3FjabJCgnI07heVMAx49xOjV9MLMOwyFw1g96cTpcYNEtHTI/pQeIpXfafHd++LrqbaCN4Nl8CUO12erptvSSG7RG093J6yjDYq4soajrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADHNfaykgBqubgBAQ--.2426S2;
	Sun, 10 May 2026 22:14:10 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	caoruide123@gmail.com,
	enjou1224z@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] mptcp: fix request ownership when cloning reqsk
Date: Sun, 10 May 2026 22:14:03 +0800
Message-ID: <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADHNfaykgBqubgBAQ--.2426S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4fXr4DCr4UWr4fKrW3ZFb_yoW3CrykpF
	4DKrWayrs3XFyxKFs3JFWDZr1Ygw4SkrZxtw45Kw4SyrsrtrsakF1kXF4UZrW3CF48Kr98
	XF4qgwnrXFnF9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0DCWoARmUAwwADsP
X-Rspamd-Queue-Id: 336F15048F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-286293-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fb.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.498];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
subflow_req->msk, but the cloned request does not take a new reference.

Both the original and the cloned request can later drop the same msk in
subflow_req_destructor(), and a migrated request may keep a dangling msk
pointer after the original owner has already been released.

MP_CAPABLE requests have a similar ownership issue for token_node. The
original request is hashed in the token table, and inet_reqsk_clone()
raw-copies the hlist pointers into the clone. The clone must not inherit
that hashed state on migration failure, and the token ownership must move
only after the new req has actually replaced the old one in the ehash.

Fix both cases while keeping the change local to MPTCP and the TCP
migration path: grab a reference for cloned subflow requests that carry an
msk, clear any raw-copied token hash state from the clone, and move the
hashed token request ownership only after migration succeeds.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
  - drop the generic request_sock clone callback
  - call MPTCP directly from inet_reqsk_clone() under the TCP protocol check
  - keep cloned MP_JOIN requests holding an msk reference
  - clear raw-copied MP_CAPABLE token hash state in the clone
  - move MP_CAPABLE token ownership only after successful req migration
  - avoid exposing token internals to inet_connection_sock.c
  - update the commit message accordingly
  - v1 link: https://lore.kernel.org/all/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com/

 include/net/mptcp.h             | 14 ++++++++++++++
 net/ipv4/inet_connection_sock.c | 12 ++++++++++--
 net/mptcp/protocol.h            |  2 ++
 net/mptcp/subflow.c             | 20 ++++++++++++++++++++
 net/mptcp/token.c               | 25 +++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e4..4bb24963afef 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -219,6 +219,10 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
+void mptcp_subflow_reqsk_migrated(struct request_sock *req,
+				  struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -314,6 +318,16 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
+					     struct request_sock *new_req)
+{
+}
+
+static inline void mptcp_subflow_reqsk_migrated(struct request_sock *req,
+						struct request_sock *new_req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e961936b6be7..578471bb8a2b 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -17,6 +17,7 @@
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
 #include <net/route.h>
+#include <net/mptcp.h>
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
@@ -951,8 +952,13 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 	/* We need not acquire fastopenq->lock
 	 * because the child socket is locked in inet_csk_listen_stop().
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
-		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (tcp_rsk(nreq)->tfo_listener)
+			rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+
+		if (rsk_is_mptcp(req))
+			mptcp_subflow_reqsk_clone(req, nreq);
+	}
 
 	return nreq;
 }
@@ -1115,6 +1121,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 			goto no_ownership;
 		}
 
+		if (rsk_is_mptcp(oreq))
+			mptcp_subflow_reqsk_migrated(oreq, nreq);
 		__NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQSUCCESS);
 		reqsk_migrate_reset(oreq);
 		reqsk_queue_removed(&inet_csk(oreq->rsk_listener)->icsk_accept_queue, oreq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ec15e503da8b..ca1ca2334e1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,6 +1038,8 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(struct request_sock *req);
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req);
 int mptcp_token_new_connect(struct sock *ssk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4ff5863aa9fd..e4c1d2bb4783 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,26 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req;
+
+	subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+
+	/* Raw-cloned token hash state must not survive failed migrations. */
+	mptcp_token_init_request(new_req);
+}
+
+void mptcp_subflow_reqsk_migrated(struct request_sock *req,
+				  struct request_sock *new_req)
+{
+	mptcp_token_move_request(req, new_req);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f1a50f367add..8f92a57c26e5 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -207,6 +207,31 @@ void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 	spin_unlock_bh(&bucket->lock);
 }
 
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (hlist_nulls_unhashed(&subflow_req->token_node))
+		return;
+
+	bucket = token_bucket(subflow_req->token);
+	spin_lock_bh(&bucket->lock);
+	/* Migrate the pending MP_CAPABLE token ownership to the cloned req. */
+	pos = __token_lookup_req(bucket, subflow_req->token);
+	if (!WARN_ON_ONCE(pos != subflow_req))
+		hlist_nulls_replace_init_rcu(&subflow_req->token_node,
+					     &new_subflow_req->token_node);
+	else
+		mptcp_token_init_request(new_req);
+	spin_unlock_bh(&bucket->lock);
+}
+
 bool mptcp_token_exists(u32 token)
 {
 	struct hlist_nulls_node *pos;
-- 
2.34.1


