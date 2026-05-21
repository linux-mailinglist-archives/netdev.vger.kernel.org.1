Return-Path: <netdev+bounces-290509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NvmNVwjD2rPGAYAu9opvQ
	(envelope-from <netdev+bounces-290509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF785A8383
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 429F033778EB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF47372058;
	Thu, 21 May 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOWcSJRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C3372044;
	Thu, 21 May 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374846; cv=none; b=t1EVjkHQHAkuP194Qr7FXtxuZtGSdOpKAu5xQSkcWmiCIgfg99J+cAM3h90CE+74qQDkdfeKFPfzW5tyyDaJRPlRf6B8bTXHjqXFE6svY2PHqaAx/t+STO3xsjOIPkFKkSjie7SREIdOuK5efnjbRpdjFNtuoNZG5g3tCk7EKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374846; c=relaxed/simple;
	bh=2DY7Ra8d6rJlVuc13jJLUfjCKZRbR+Hz3uSM6MnJOa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZLtwZ4Z+2EcZXtZOt0TfyrK72g/2oAKxMid6fz41RF1QcedD3RiKVuuDyMzBP8aiEHpmo8bpgtByvU6wIbAE2VEVDW1gmEIiT2mFQlO/PnK8ATFkELoXNcPnVGZgHdAkyr3dypgCbOQvmZ+84pgE0jEnwORjy3s6VRyPBpNr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOWcSJRD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889801F000E9;
	Thu, 21 May 2026 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374844;
	bh=i2SZSJUf2NV4EctzBZ/cDMhFH6YJ7t05gUxyzd6xfiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZOWcSJRDTvcdXSAVLw6t/qv9vxS8DiAyhvLO9HkFUsWLbyIQ+B6f1Lua1EFN1unmx
	 NvDLeQARps4Gmnl9NKEUYKnr3iiOBH67pWu6PI9uSrITOU8qTbex+I5x3i2wGwjuRz
	 ckzoKVdpP5RI0gesX2U28nHrZyXMV+2TnJjRu4tDGJqi862SlSYkbCfVwr11V5ROSH
	 pP+wpf4acZenqJgT9SNDTERyxSZ4gDCGXYLvb+/+hFEyGPNIJDeh6eLYLOiLmAkrp6
	 tAfq4LKIUpXClQus3L1mfOyDLw8qUpskV9hm+vKKXKn/70Y0qEHwwR582UYEhI+iek
	 MG3WFy9s5Zd9Q==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:09 -0400
Subject: [PATCH net v2 3/7] net/handshake: Pass negative errno through
 handshake_complete()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-3-b9dadc472840@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7743;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=D4oZ0DWDixENc8Fy5b2rZ/3tFMsz/mKnf8J1xU3pfvY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr3/M81Q3iZt5bCKuddKHB75Z+rJJnIKX4L1
 h9xkaHbsoeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l1U5EACpnBiJC69Xcui5h96EXDSZ7bzmgWEbbVchIzGlf3onpIKWRM73BzGiXsTtaTRsFWv6HNu
 5/8KCWJ9jThjysBstzG8FAdyYbPMORNOxogz+BsPSBdmDHQlh9EexweZX7evHBA3dDyvaVq5cnr
 qcfqDBUaSM9sYOQFrEigRORhU6h8J14ZM5w0i0vkYUJsOvnVWD+IB+RvWQTwuTp2P3URUptoQjf
 lE5uXB0zobdC1wE+FIH4eaCWdegtbKL4HS7QuNC9iwJ40OmDOJQbeYPeuyuOx0tZlQWgd1Lu8vJ
 XiJ8hFtJT67Q9fyFqfEF35wRrepK36pvbPedUP9CeYAHiSPzB/3qtkVMjkC1L07wTbwblK01Btr
 8/tOWtvB8Sy7+TgPSrwcwd4xhuUpNt0KW1QtQfZZui6sakS/kU6BmRosdcKB4pi/lAtgDdwHwGJ
 k+moDM0gWTXfplE8RWZwBA6kBJc01OAug7GdOLj0lvNzwmz8lzxxbo353BjdlZQlQRCIZOKHf5t
 O56bWshiEaJ0cdQgbkjUg8MFnVusXCLHiX4KJnZiZpqFEDu40JtWyZ7xH3uQQHD+PV9sJJaH1wb
 yNR/h9Pag+ZoaFyXT2HtlY887HaeyDS0CwQlrlyJpjxL6mY0oBsP8MU6Cg3nu3+mFXykAVvNo/Z
 DEgGIoB6c0ig3/g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290509-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5BF785A8383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handshake_complete() declares status as unsigned int and
tls_handshake_done() negates that value (-status) before handing
it to the TLS consumer. Consumers match on negative errno
constants -- xs_tls_handshake_done() has

	switch (status) {
	case 0:
	case -EACCES:
	case -ETIMEDOUT:
		lower_transport->xprt_err = status;
		break;
	default:
		lower_transport->xprt_err = -EACCES;
	}

so the API as designed expects callers to pass positive errno
values that the tlshd shim then negates.

Three internal callers in handshake_nl_accept_doit(), the
net-exit drain, and a kunit test follow kernel convention and
pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
implicit conversion to unsigned int turns -ETIMEDOUT into
0xFFFFFF92; the subsequent -status in tls_handshake_done()
wraps back to 110, the consumer's switch falls through, and
the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.

Fix the API rather than the call sites. The natural kernel
convention is negative errno in, negative errno out. Change
handshake_complete() and hp_done to take int status, drop the
negation in tls_handshake_done(), and negate once in
handshake_nl_done_doit() where status arrives from the wire
as an unsigned netlink attribute. The three internal callers
were already correct under that convention and need no change.

At the same wire boundary, declare MAX_ERRNO as the netlink
policy upper bound for HANDSHAKE_A_DONE_STATUS. Attribute
validation rejects out-of-range values before
handshake_nl_done_doit() runs, and negating a bounded u32 there
stays within int range -- closing the UBSAN-visible signed-
integer overflow that an unconstrained u32 would invoke.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/netlink/specs/handshake.yaml | 8 ++++++++
 net/handshake/genl.c                       | 3 ++-
 net/handshake/genl.h                       | 1 +
 net/handshake/handshake-test.c             | 2 +-
 net/handshake/handshake.h                  | 4 ++--
 net/handshake/netlink.c                    | 2 +-
 net/handshake/request.c                    | 2 +-
 net/handshake/tlshd.c                      | 4 ++--
 8 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..1024297b3851 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,12 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    type: const
+    name: max-errno
+    value: 4095
+    header: linux/err.h
+    scope: kernel
   -
     type: enum
     name: handler-class
@@ -80,6 +86,8 @@ attribute-sets:
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..4b20cd9cdd0e 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -10,6 +10,7 @@
 #include "genl.h"
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
@@ -18,7 +19,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
-	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index 8d3e18672daf..46b65f131669 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info);
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..df3948e807a0 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -25,7 +25,7 @@ static int test_accept_func(struct handshake_req *req, struct genl_info *info,
 	return 0;
 }
 
-static void test_done_func(struct handshake_req *req, unsigned int status,
+static void test_done_func(struct handshake_req *req, int status,
 			   struct genl_info *info)
 {
 }
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..2289b0e274f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -57,7 +57,7 @@ struct handshake_proto {
 	int			(*hp_accept)(struct handshake_req *req,
 					     struct genl_info *info, int fd);
 	void			(*hp_done)(struct handshake_req *req,
-					   unsigned int status,
+					   int status,
 					   struct genl_info *info);
 	void			(*hp_destroy)(struct handshake_req *req);
 };
@@ -86,7 +86,7 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index a8dd848371ff..18e1268efc7e 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -160,7 +160,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 
 	status = -EIO;
 	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
-		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+		status = -(int)nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
 	sockfd_put(sock);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index cebafcc341d2..93cec5f0e16e 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -285,7 +285,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..3dd99982150f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -93,7 +93,7 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
  *
  */
 static void tls_handshake_done(struct handshake_req *req,
-			       unsigned int status, struct genl_info *info)
+			       int status, struct genl_info *info)
 {
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
@@ -104,7 +104,7 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
-	treq->th_consumer_done(treq->th_consumer_data, -status,
+	treq->th_consumer_done(treq->th_consumer_data, status,
 			       treq->th_peerid[0]);
 }
 

-- 
2.54.0


