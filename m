Return-Path: <netdev+bounces-289149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEP8DGpaC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF3572417
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C03B3023C59
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766538C421;
	Mon, 18 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUtEEY+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE338BF72;
	Mon, 18 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128699; cv=none; b=VdrLNIpXjprkXepK0kAoYhGjeqJ8Q2HfUY0IAU7wVZwiKbVcBD4awjZgLEWs2IbiY3kkTkfP/tUx48z3XEmMf5NKylREO4iiQ4oX2xChUieIUiHXgQxY5MQIMUX2cJU9ga3BszE5JZJSV60MJdrcIz0a1KxKIZa9QaJBRTFRdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128699; c=relaxed/simple;
	bh=hgylRra5SSNtfmzy04GJNbjsLYncRF3SakSvhGTvpuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoDsw7NQzlW9srGWo29pEIAJPoKNKXGOwLQHb/5UbtsSb00fSh+nCkvTAsazvMrrnJ6xGGU6zMVlMMo1VxJt8dVgmaZ/BNT/K0kLDS2LNsBOkT7rGN282lWMkjJrS4LQlyaDGrGu5WzsclVF/W3Go6QiXpHpGs7bATTm3Hg70Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUtEEY+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98510C2BCC6;
	Mon, 18 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128699;
	bh=hgylRra5SSNtfmzy04GJNbjsLYncRF3SakSvhGTvpuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aUtEEY+kmISJQY20w36zrf1KkRyJt+KP12sVbg5eNwap2HYhpEx4ugWu40klk3YU/
	 dSZtfIf+zSbGl53JgE6BVJxC1fArcefPflhTgZiOgtdWal4b50WO4VLGs+xw3bFFww
	 JDvyWVVCZYgnrOsv1HBPQllTEa2Zuhk/TALPpLYG+4iEuEvuY6ip8HwFNILXSsyYnU
	 9ESZNvaPAey1uWANdJ2S2DqKsKOJfLJtBxQ4dGh1eNFdxYlvJVIznn55Lghp19D/hp
	 KWCejzWtSJWJMeMP+zrqGLXOoRImw2DOziNKIICI7L76E9zeRWcIYinHxSXgLGphlY
	 gBFro23LGF75A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:32 -0400
Subject: [PATCH net 5/7] net/handshake: hand off the pinned file reference
 to accept_doit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5791;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=w1dTXaM4JxhmgKUJhboSvvCMGmysOGdKEWX7jO4D4+Y=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1ZdxiRBhfJsdPC0vPM5Ru3R5j+bz/kgGSL
 qLFHuLri1+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l0mZD/9/eU/NS/i+EkkR7oOEpqvuVUSgnAwEWlCEQpnjdO+nDo17si0U766Ond8mJnDT8ICuzBI
 3+wR3K80QyYS2/W/NGPrQxOBpo8KkH06HlYpg118wtBVHwPvzHHaQ6agQ/ZbB5S8nu6FnzdzCwm
 JG/buhSHi1Q+okPU/seR8a04ae2SyygT0ZOSfySZ8Wrfi1gm8EFCxeVHcyQD1utFE5IFdtlR5gQ
 ogFGfGTW7EtvuHOQKNfUi8CINx7yJLDOoS4jsjOOnt1ke/4ey+PxKvuNvLJvJmISI3YV0MEfLZ/
 H7saeC++Hjr+ZMuCJaySmDR4h20+D76XP2PZJwevsHnGkCVmG/FULHsEM/fdLxHX83BeC8ef+Df
 Q3DEATNSS8CwtiBAv5zwE5rN2u5+iQTm7ZjKfjzxGg4U7nusuJYb/PZreFzzTLdThCUkXvobUHI
 +nEhVfD6hlBAbUyBgzrbAQLoNeAUws7pWRknesS9Ys2henwlaKWPKVsujvDAWrgnraj+N0C+dvi
 V46Dp/VA2Aix4tHz9PwnGkluzgdjzsXkXdRN87/cgteXhpwbFkkxbONi8XXugSIBoXLgJMJ9UFm
 p11+mVACC9edYNMc6Pi+Dx02kSnOX/aMElqsGKjdwD11weSH62iCo+UxJE5wgo30T30YhM3s3Xd
 nzz7pEB/f2lrxog==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-289149-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:email,oracle.com:mid,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 1EBF3572417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handshake_req_next() removes the request from the per-net
pending list and drops hn_lock before handshake_nl_accept_doit()
reads req->hr_sk->sk_socket and dereferences sock->file (once in
FD_PREPARE() and again in get_file()).  In that window a
consumer running tls_handshake_cancel() followed by sockfd_put()
(svc_sock_free) or __fput_sync() (xs_reset_transport) releases
sock->file.  sock_release() then runs sock_orphan(), zeroing
sk_socket, and frees the struct socket.  The accept-side code
either reads NULL through sk_socket or chases freed memory.

The submit-side sock_hold() does not prevent this.  sk_refcnt
protects struct sock, but struct socket and sock->file are
independently refcounted via the file descriptor the consumer
owns.  Pinning sk leaves sock and sock->file unprotected.

Retarget the accept-side dereferences at req->hr_file, which was
pinned at submit time, instead of req->hr_sk->sk_socket->file.
Pinning on its own is not sufficient: a consumer that cancels
between handshake_req_next() returning and accept_doit reaching
FD_PREPARE() takes the !remove_pending() branch in
handshake_req_cancel() and drops hr_file before the accept side
takes its own reference.  Hand off an additional file reference
inside handshake_req_next(), under hn_lock, so the accept side
operates on a reference that no concurrent handshake_req_cancel()
can revoke.  FD_PREPARE() consumes that handed-off reference,
either by transferring it to the new fd in fd_publish() or by
dropping it in the cleanup destructor on error; the explicit
get_file() that previously balanced FD_PREPARE() is therefore
redundant and goes away.

Update handshake_req_cancel_test2 and _test3 to simulate the
FD_PREPARE() consumption with an fput() so the kunit file-count
assertions stay balanced.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake-test.c |  8 ++++++++
 net/handshake/netlink.c        |  7 ++-----
 net/handshake/request.c        | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index df3948e807a0..9cc7a95f4120 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -375,6 +375,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
@@ -417,6 +421,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 0d5871f4bd67..086d5439c155 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -92,7 +92,6 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
-	struct socket *sock;
 	int class, err;
 
 	err = -EOPNOTSUPP;
@@ -107,15 +106,13 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
 	if (req) {
-		sock = req->hr_sk->sk_socket;
-
-		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
 		if (fdf.err) {
+			fput(req->hr_file); /* drop ref from handshake_req_next() */
 			err = fdf.err;
 			goto out_complete;
 		}
 
-		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
 		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
 		if (err)
 			goto out_complete; /* Automatic cleanup handles fput */
diff --git a/net/handshake/request.c b/net/handshake/request.c
index b076ae539422..d24b55af1a0a 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -179,6 +179,17 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 	return ret;
 }
 
+/**
+ * handshake_req_next - Return the next queued handshake request
+ * @hn: per-net handshake state
+ * @class: handler class to match
+ *
+ * On a non-NULL return, the caller owns an extra reference
+ * on @req->hr_file.  FD_PREPARE() consumes it on success; on
+ * the FD_PREPARE() failure path the caller must fput() it.
+ *
+ * Return: pointer to a removed handshake_req, or NULL.
+ */
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 {
 	struct handshake_req *req, *pos;
@@ -189,6 +200,13 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
 		__remove_pending_locked(hn, pos);
+		/* Hand off a file reference to the accept side under
+		 * hn_lock.  A concurrent handshake_req_cancel() can drop
+		 * hr_file before accept reaches FD_PREPARE(); this extra
+		 * reference keeps the file alive until FD_PREPARE() takes
+		 * ownership.
+		 */
+		get_file(pos->hr_file);
 		req = pos;
 		break;
 	}

-- 
2.54.0


