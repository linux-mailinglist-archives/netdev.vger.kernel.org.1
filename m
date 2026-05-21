Return-Path: <netdev+bounces-290510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMpDBg0qD2paHQYAu9opvQ
	(envelope-from <netdev+bounces-290510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFC5A8A9E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F14D31BD684
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BC37206E;
	Thu, 21 May 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzpyOOff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A806372049;
	Thu, 21 May 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374846; cv=none; b=nbkN67fvNBryMm7i2BFFm0YWIpOZT8Cg79ko1IHPGZw5DgPBmffLCIAvNGKwMum+irm1Z1DyaRPEmOHSfLkaAKQ/iGVXZaui9sEK0esv1PqgEC8OMoRCohOSnoMw5D/gosRgeoEnD5zFyNsTPHjdqRAbw3Q+6p+fj+9wYF09JhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374846; c=relaxed/simple;
	bh=WpsEsKQlqqi+Q8hpcPMm+eX9pzuRkqBHFFVBWp/bBJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rne1mVyfWZr1i0DzsSYDUZHggwVQEvRAphZ6mjbVa2WC7IFJvtjOG7H1U1gNKB2zI0jsxw7FQyUA4GHvx0DJvIcJX6/bqtRxC439pORefMHcBONI6pHkApwvCAc/V3xYOLnG22EBNLxt+TCldEwi6Vp8YazzaOqxL4z+eFx9LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzpyOOff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992671F00A3C;
	Thu, 21 May 2026 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374845;
	bh=21j6wtvcFA+GRGELWMitdJk5M39RTYQ9AsL6lrYPK6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lzpyOOffSM7S0Kw0Avs7NYxIZnzponQerJpqZkVGduShcrTInpGmeswrvHi1UHtz4
	 4+XBlAUA3/qmth5HkfWIR0MjixKtkKjVItmZ0uK9lcRHowXnuooO/M2yCrXs4bOUW8
	 hbL4jPmWx7HW4V5OFLpREYMivbB1FntdaYRh+7Vhh1zhzvrNpjfLd5nizfiy9rQDfT
	 CdCYQKDSoVGxF5SH9Ika9F5IQng0BnPlt15eC60TJGQd1jaQdevjVIAktrWx/qj802
	 BkMRycB369oyh4WDKfJhZkMFP/gEGvBU41UvD5yuh09ficQ4xYhs2t1+P+jgS/b6G0
	 55QT0ApyQrYlg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:10 -0400
Subject: [PATCH net v2 4/7] net/handshake: Take a long-lived file reference
 at submit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-4-b9dadc472840@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5280;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fOAILlkKSpljatm8qDuCiH6tgK9RZ5Eb5IrSzyam3sM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr39u3YY8FyWNtMyGSzpjpsS4/RmGatWc+tn
 Km2dNEqgT+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l+XCEACpxUeTQhYcISgeVJIaWxE/Ts4rlB71bknABwWtvmvObF1BCPP80u/91mbeREgTAeaiLx+
 4cBLucfDktQsnkcDZybHGPYSTcozRgVA35PA61bZJjJ6mb/RwGxtCbFyQ679z7I/3sGRVQO72Vq
 6nrG0xk/WFNAFTK/FIqfGgSfd2ZPqa7jmohu7h/d7cLaU77MERqr7hlXIx0WBmosuVf9gHEmYdC
 nIueAuycwnrQsIto6kwM7lSksjyKfB2yIEwVnjEMv11jZanyRUXW+553JCNFSgcQ7MvqDTivpWG
 adCGscHz+326D43R1AylQToavQivDhlkeowEXyGjEGbo+FS0D7dwHXQIY/62PrZmOnydruJHWeK
 thQK0XvdpsOIVMxgKip7KIsV5o2ImmklNJ/M911iRSNmp0HBKEG2AUFPQsZGKBh7PifLka8PxYo
 qogyyB+aJOvrlxLmZBi6vwUdjwBg+eqrzEUAXc/mkaf4/hMlGABEOm+8J7msKbnaRb0ZsJVMNFE
 ZIhWlH6s26hoD7BmC0abTsqZ5baynw3CcAibmrDEmGjfXOVe5vIUsofXfyS1Yq82frTrOpzHeDt
 1Qo9ZUzTKG7w/2Qg7lw0od/EI2+L/yxrP+V2D1QPu9O6LApPnjbgi182GqMHz7cCeFmVpu5yvIc
 3rJ6JO1/Wy2OC1Q==
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
	TAGGED_FROM(0.00)[bounces-290510-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A6FFC5A8A9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handshake_nl_accept_doit() needs the file pointer backing
req->hr_sk->sk_socket to survive the window between
handshake_req_next() and the subsequent FD_PREPARE() and get_file().
The submit-side sock_hold() does not provide that. sk_refcnt keeps
struct sock alive, but struct socket is owned by sock->file: when
the consumer fputs the last file reference, sock_release() tears
the socket down regardless of any sock_hold.

Prepare for a fix by adding an hr_file pointer to struct
handshake_req and acquiring an explicit reference on sock->file
during handshake_req_submit(). Release the reference on the
completion-bit-winning path of handshake_complete() and
handshake_req_cancel(), and on the submit error paths that destroy
the request before it has been published.

The accept-side dereferences are not yet retargeted; that change
comes in the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/handshake.h |  2 ++
 net/handshake/netlink.c   |  6 ------
 net/handshake/request.c   | 27 ++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

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
index 18e1268efc7e..f395bfc7ff8c 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -210,12 +210,6 @@ static void __net_exit handshake_net_exit(struct net *net)
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
 		list_del_init(&req->hr_list);
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
index 93cec5f0e16e..b076ae539422 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
+#include <linux/file.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
@@ -219,6 +220,12 @@ EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
  * A negative return value from handshake_req_submit() means that
  * no completion callback will be done and that @req has been
  * destroyed.
+ *
+ * The caller must hold a reference on @sock->file for the duration
+ * of this call. Once the request is published to the accept side, a
+ * concurrent completion or cancellation may release the request's pin on
+ * @sock->file; the caller's reference is what keeps @sock->sk valid until
+ * handshake_req_submit() returns.
  */
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags)
@@ -237,6 +244,14 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
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
 
@@ -268,7 +283,11 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
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
@@ -280,6 +299,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	/* Restore original destructor so socket teardown still runs on failure */
 	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
+	fput(req->hr_file);
 	handshake_req_destroy(req);
 	return ret;
 }
@@ -292,11 +312,15 @@ void handshake_complete(struct handshake_req *req, int status,
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
@@ -345,6 +369,7 @@ bool handshake_req_cancel(struct sock *sk)
 
 	/* Handshake request is no longer pending */
 	sock_put(sk);
+	fput(req->hr_file);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);

-- 
2.54.0


