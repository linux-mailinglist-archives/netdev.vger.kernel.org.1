Return-Path: <netdev+bounces-291380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNOjHpZ+FGowNwcAu9opvQ
	(envelope-from <netdev+bounces-291380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:53:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE5F5CD12D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05635302C933
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403863F5BC7;
	Mon, 25 May 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHbfblQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3B3ACF11;
	Mon, 25 May 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727897; cv=none; b=i+/OML7xLi8aibMSEoSdYPDl5XwTLdCurEGwtlHMr9e/FKM+gL+F0sU82w0ZvrKtunDX2Xo4D464ZdSEqcSuxA8M2Dg6ThOMTzTDT6nmZgkFO2plJ3QmiIY/JVgulCE+pwhSe+bwRN4wu9WSpdeMgqOPzw7G21joV6+IHqnNBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727897; c=relaxed/simple;
	bh=ahCDHvnraIM/YPLXB08i+LNRolaPwp3Gi1MmXjGGfVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fApirgMSeGrO3ECGu2Syq0DIZX/UD066VFpqo7ADih/7yjaOcM4q6WlPb8BvNzb23X3t4fyxCDoxKMqbr9385s9KyI345+G2UtJCQecmDOOyNNSGylh+fyoF9mIII13upU7q4GiIEFw9sRlpT6rc1RQjdDPQrpAv4k8qnkfGit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHbfblQ3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071E81F00A3D;
	Mon, 25 May 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727895;
	bh=BPjDo10S887bSPVJhYz4yWvRvQklleA02L2Ry0oTIsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KHbfblQ36AU6m8mu2HguODunjPJdEk+H6bSQpGHxau+NR0QjuGs6uA8h/r+e0+1JF
	 tpNVAXDRO6ABwcDsiHu099yloAxwFqB4kA3h22qHDzQ2SBnL66G9jVhi5sXau4CK9c
	 C6llwXmMCn4Z8mKDKGjpkdYaN2D64OT4JWM2utu9ff3ULz06BpWke2wmnhnKrqrdsO
	 1MLPnJXePKZluCjZwfOdVgx4dfIxQ72uEfLzjrWl35TK+/h9ZCNENVv6/bGFzNVXCj
	 xfGrJaE1/JOts5hfdWUuZrWIY7U9Qmt6IFkLKm8il5zCo0PNvZU6ZIKOGIJMMe1dpA
	 UNxHNE5oyxISg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:18 -0400
Subject: [PATCH net v3 4/8] net/handshake: Take a long-lived file reference
 at submit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-4-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6447;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+1prmDhWQHrMcouwQ0dhboReMWGy9F0eBSrAz5MJ7eA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4SXmTfN0cmsOFooQ11mtEh1lTXcGCygyzez
 mo1ikR11hCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 l1tCD/9p3N1kxM0kF7cAxinwr93ndOIVMgfJEuJ3nyJsVNrGgHYEgbKR4ZmuU4egW8gxFXesfBa
 BPXBrBwxEYq6ywZa7H8MB9K/tjYzHxdpgs+hIOqIjm8uJO+q8s80N8uMYx5AcH0r35+VeKAxRbV
 CyGh+9ISRdDrTixDDFadIyzghJ3IkvP2RnIUOS/oOop4oCWMvIEyc+GABRdh3GMWDQVnCSCwSwU
 0Ptl+WxCallwsbdVA2rB7yONNMP01vHxFVkqPi7cNaG2gQimd78GGTFb1hfiTLBwfFUhvLOSqO3
 cNki0R9UzUsHyR0x9heynn4MCB857/AFRLZaY/k1FlLtknaKSKYc6KBBVMNiSTrcrPsvT3UHXTt
 k50Z4Ksj3IK3iAkKjdV2ZX2eNi7mih2W4Mx7QVW7RGMwFkMeeanXwY8djh2Cv8qHvPfLYUPB25n
 Qfvd7JQJfKrF+zV2Ev79lzJGRZwY49M0uRDs5on3o60MLurH8nHxpg+47wiGfbyzmfX5DOlOxnc
 8ojPHqzaDBGZ3Oi9BPSyZpumUAg7udhMAhpdy9W4FcV/v+WgBYfqHnCA1fhPFUKkDldCn6GV2J6
 vec7Dh7WLowSEXbjWwVDcnc7HM49fadhVU6hrO7lS90/UkMRRftPDf/0BOfTzhd9kELDGuYIktO
 jqE/of0wQSwEDwA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291380-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAE5F5CD12D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handshake_nl_accept_doit() needs the file pointer backing
req->hr_sk->sk_socket to survive the window between
handshake_req_next() and the subsequent FD_PREPARE() and get_file().
The submit-side sock_hold() does not provide that.  sk_refcnt keeps
struct sock alive, but struct socket is owned by sock->file: when
the consumer fputs the last file reference, sock_release() tears
the socket down regardless of any sock_hold.

Add an hr_file pointer to struct handshake_req and acquire an
explicit reference on sock->file during handshake_req_submit().
handshake_complete() and handshake_req_cancel() release the
reference on the completion-bit-winning path.

The submit error path must also release the file reference, but
after rhashtable insertion a concurrent handshake_req_cancel() can
discover the request and race the error path.  Gate the error-path
cleanup -- sk_destruct restoration, fput, and request destruction
-- with test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED), the same
serialization handshake_complete() and handshake_req_cancel()
already use.  When cancel has already claimed ownership, the submit
error path returns without touching the request; socket teardown
handles final destruction.

The accept-side dereferences are not yet retargeted; that change
comes in the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake.h |  2 ++
 net/handshake/netlink.c   |  6 ------
 net/handshake/request.c   | 42 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index 2289b0e274f4..da61cadd1ad3 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -24,6 +24,7 @@ enum hn_flags_bits {
 	HANDSHAKE_F_NET_DRAINING,
 };
 
+struct file;
 struct handshake_proto;
 
 /* One handshake request */
@@ -32,6 +33,7 @@ struct handshake_req {
 	struct rhash_head		hr_rhash;
 	unsigned long			hr_flags;
 	const struct handshake_proto	*hr_proto;
+	struct file			*hr_file;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 039344979de9..1a5821eb7184 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -210,12 +210,6 @@ static void __net_exit handshake_net_exit(struct net *net)
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
 		list_del(&req->hr_list);
-
-		/*
-		 * Requests on this list have not yet been
-		 * accepted, so they do not have an fd to put.
-		 */
-
 		handshake_complete(req, -ETIMEDOUT, NULL);
 	}
 }
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 97f9f8239949..da064511ab86 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
+#include <linux/file.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
@@ -215,9 +216,16 @@ EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
  * A zero return value from handshake_req_submit() means that
  * exactly one subsequent completion callback is guaranteed.
  *
- * A negative return value from handshake_req_submit() means that
- * no completion callback will be done and that @req has been
- * destroyed.
+ * A negative return value from handshake_req_submit() guarantees that
+ * no completion callback will occur and that @req is no longer owned by
+ * the caller. If cancellation wins the completion race after the request
+ * has been published, final destruction is deferred until socket teardown.
+ *
+ * The caller must hold a reference on @sock->file for the duration
+ * of this call. Once the request is published to the accept side, a
+ * concurrent completion or cancellation may release the request's pin on
+ * @sock->file; the caller's reference is what keeps @sock->sk valid until
+ * handshake_req_submit() returns.
  */
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags)
@@ -236,6 +244,14 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		kfree(req);
 		return -EINVAL;
 	}
+
+	/*
+	 * Pin sock->file for the lifetime of the request so the
+	 * accept side does not race a consumer that releases the
+	 * socket while a handshake is pending.
+	 */
+	req->hr_file = get_file(sock->file);
+
 	req->hr_odestruct = req->hr_sk->sk_destruct;
 	req->hr_sk->sk_destruct = handshake_sk_destruct;
 
@@ -267,7 +283,11 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/* Prevent socket release while a handshake request is pending */
+	/*
+	 * Pin struct sock so sk_destruct does not run until the
+	 * handshake completion path releases it; struct socket is
+	 * held separately via hr_file above.
+	 */
 	sock_hold(req->hr_sk);
 
 	trace_handshake_submit(net, req, req->hr_sk);
@@ -276,10 +296,13 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 out_unlock:
 	spin_unlock_bh(&hn->hn_lock);
 out_err:
-	/* Restore original destructor so socket teardown still runs on failure */
-	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
-	handshake_req_destroy(req);
+	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		/* Restore original destructor so socket teardown still runs. */
+		req->hr_sk->sk_destruct = req->hr_odestruct;
+		fput(req->hr_file);
+		handshake_req_destroy(req);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(handshake_req_submit);
@@ -291,11 +314,15 @@ void handshake_complete(struct handshake_req *req, int status,
 	struct net *net = sock_net(sk);
 
 	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		struct file *file = req->hr_file;
+
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
 		/* Handshake request is no longer pending */
 		sock_put(sk);
+
+		fput(file);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
@@ -344,6 +371,7 @@ bool handshake_req_cancel(struct sock *sk)
 
 	/* Handshake request is no longer pending */
 	sock_put(sk);
+	fput(req->hr_file);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);

-- 
2.54.0


