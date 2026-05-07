Return-Path: <netdev+bounces-285250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AdAEbNx/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:04:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A124E732C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3827430599C1
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2F3EFD35;
	Thu,  7 May 2026 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dCmv25SK"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D483EE1C7;
	Thu,  7 May 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151507; cv=none; b=nSs0kCIgzKGOP4Q7TEasQOVtue9BYY9ZaLE/a2XKtzazs6APEeIMVnFG1Xs0hnDSQDwDuF9SzVYuWkyzwCnyRHRz5ONnKKoVY68mN35p7G2EpjldiufqzdmTCL+3HULarDfOAk9+Of1ivftL//Jm5jcUMN2uVDjA1ljVbm51pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151507; c=relaxed/simple;
	bh=RJx8yhwyyKw2tKxOBBz3jJnsb9wrnWIwoTtaruw98bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXsMdzGwOeTic/5JK18+pTXSfBG39go2v0MENxSpt2SZj1Qoe1u7/iepC+TNk0LiDL63Il/vMENuxKwA3FA+AiYqeeOIu2gEYwhKK5Vgoavihtuln8lAgEoTlUiYyCJtis4geglMnhkWPPWz4NT7ADMv9okJ2bpNmNONI4MOs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dCmv25SK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=y/EA2/PCsQAddgwb1sb6mzsTdkaIHJzx7OFo9Hnm4N0=; b=dCmv25SKnKO3b69v5xL80cPTw5
	d1AyYymWz93zxgGzv6i468rczlcVbf6dtsTTVhHYR5H1w9Wqk+S0I9lZRdcQXxkhLkWYFYVhZAm70
	WV9Yu/+sxyIdK10+wvv9plcAZJaZafjmoAhpzhrwh+19N0IxEEVLOvpEXRH979KtziH2a9n43gn++
	5Laq845onavaUUoKYp97oFg08p4Qv8lYRO8kirxg1C13UBe91pJSHx+eakmXWsUxxfPQDodKenJUz
	B4hV4XWktPTEBhvdyem/+ZXpKl2zfVpFeyXKUJVFzX+JKApv6uYiA9kT1McEuhTJ4ANNPHNIsMMkU
	GPVi5+Gg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQh-004Jnn-2b;
	Thu, 07 May 2026 10:58:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 03:57:51 -0700
Subject: [PATCH net-next v2 2/5] llc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two-v2-2-5873111d9c12@debian.org>
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
In-Reply-To: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=leitao@debian.org;
 h=from:subject:message-id; bh=RJx8yhwyyKw2tKxOBBz3jJnsb9wrnWIwoTtaruw98bM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAwfqfpks/pRKw84mfvYsa5iaWR7Jp9SrCwQ
 KBSCkkS326JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bcubD/4rmF3eEtMrOEkNLZoWz6ZDk67BgnrhZrl94boopDn/TdwZQol/wOp0KCsgsEwroL7hRZl
 hS4va9u0zyobqWRZHl9d37zFo+H66kSxjDcWr31jhozGyGs2RaS4UkF1Iti3I3wCaklhs3OQBFH
 gDaKtUnlTb2o4+L42xoyguWBukuIU6gJ6CpJQIEf+lWxNaJx/l8y2xrgcrTbqqcF2GrWsIJNLii
 eqSBzQuGSiql2jfjjR+arJviTQQoyFzAWND9CZgWqz3ZU+VI32vrwyucfMUEPQxNzPAcOmou/dS
 TlgmxFErTBPW+Op0SiddQ6AnyBL61Xv4fqUPaE2M5URwl/hDI52FropY1xGcYRTnIBLQ5p523VN
 wYrOI3UN2yM82hOrmKngQWIHAAkZ8B9RGhlRUSopE/IyEPfxplv1RM3Y81/ZXhLWeq8ONljKVfP
 eGiVjNzrokvDRG3gSt/CP36oQ0MJCkAqbTFh0tX5pUe0odh5PuHzZa6mdJ2FMdnO9VKTXNxoh+C
 ARwhhamwRigRF7Oxmaj5c5bvIehtptKzVLhX6Plbpejjrzg9VOP3KmwjRiafZn5OUlCFDdvOv3q
 dvvDEQe24+w/7QD/E1mUbsIaRA4gehGeyuFCBVcEdh6dZYy3DOUeQ1sKxYuOfa80oL0PFtSLn+D
 LBfytmXJ44G8kzw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: D6A124E732C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285250-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert LLC socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/llc/af_llc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 1b210db3119e8..35278c519a305 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/llc.h>
 #include <net/llc_sap.h>
@@ -1166,25 +1167,21 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
  *	@sock: Socket to get information from.
  *	@level: Socket level user is requesting operations on.
  *	@optname: Operation name.
- *	@optval: Variable to return operation data in.
- *	@optlen: Length of optval.
+ *	@opt: sockopt context with iterator and length for returning data.
  *
  *	Get connection specific socket information.
  */
 static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
-			     char __user *optval, int __user *optlen)
+			     sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	int val = 0, len = 0, rc = -EINVAL;
+	int val = 0, len, rc = -EINVAL;
 
 	lock_sock(sk);
 	if (unlikely(level != SOL_LLC))
 		goto out;
-	rc = get_user(len, optlen);
-	if (rc)
-		goto out;
-	rc = -EINVAL;
+	len = opt->optlen;
 	if (len != sizeof(int))
 		goto out;
 	switch (optname) {
@@ -1212,7 +1209,8 @@ static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
 		goto out;
 	}
 	rc = 0;
-	if (put_user(len, optlen) || copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		rc = -EFAULT;
 out:
 	release_sock(sk);
@@ -1239,7 +1237,7 @@ static const struct proto_ops llc_ui_ops = {
 	.listen      = llc_ui_listen,
 	.shutdown    = llc_ui_shutdown,
 	.setsockopt  = llc_ui_setsockopt,
-	.getsockopt  = llc_ui_getsockopt,
+	.getsockopt_iter = llc_ui_getsockopt,
 	.sendmsg     = llc_ui_sendmsg,
 	.recvmsg     = llc_ui_recvmsg,
 	.mmap	     = sock_no_mmap,

-- 
2.52.0


