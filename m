Return-Path: <netdev+bounces-285251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AfEIHtw/Gm8QAAAu9opvQ
	(envelope-from <netdev+bounces-285251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03544E722C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC662300B980
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1C3F0779;
	Thu,  7 May 2026 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s+771muP"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118B3EDAA0;
	Thu,  7 May 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151516; cv=none; b=Zg0KkZoXJadG6zruFQuCxJfBkoLWMcT1zmslj/68GhxJ78p3/c1q/eS1v0ekRPdzNTyF4ow2ZGZE8Th0hLaHuT9AzJznuulMJa8pA8hoZS4+IKFypMzQYw0IqXGXeqvim5HI31g08BujyOr+7c1qxqUFFo+JZdqEmgXczHjXRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151516; c=relaxed/simple;
	bh=zG28dLa82KI1lzShfY3rVVpEFZ+TVN568W1asXUfa1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzMwpyQFcFyFpWKrGdCkF5CxrAol8Mv1LTxhrYFQr9itO587iuv8MN8/rLIfy2ZcgWA/4g0FuVyhQ6SGIBSfuO0tP/GVi6Kl4+9exN89DdCso7eF6tnD8pKTjUCM4zSJWgenXm7BskEzKAOUEZrCn6cNf+0WS3zssTkVHfSyeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s+771muP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NP5/GPNNYVvl09+fUCecdYA0YTlPK9rRi3V66nkG7X8=; b=s+771muPDjepXw2HDGXQ98pBO3
	uUssHv+YMmJ1B9zrwGwP9cbbj6My2vAeNkd7mW3GVBKn8KCKO3BSPsRgSh5B/VigSQ1mSDBEyAJYs
	OjRlKgN8WoeAlFWTzeaxjTOilPOgiWMOcwFUvjSQYvb9klRBXUvHVJIyEYgcSM2Y5lciN+TtnwHW1
	pJNMKHH1Lotc5I0g8LVoCtHuwQokA1Xu5eXwwd0kY/kF48SpBH6r+pAJzOgYrR3xnkCauB/HZVt1G
	H6FEm75uUqMbU8Uncj3gA5U6WSrpPC7LROuSWc1Mse1tXYNEqbyjw2DnFWpw6AMkU7+lP4Vsl4hky
	y9fgsXSg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQq-004JoM-1s;
	Thu, 07 May 2026 10:58:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 03:57:53 -0700
Subject: [PATCH net-next v2 4/5] kcm: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two-v2-4-5873111d9c12@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=leitao@debian.org;
 h=from:subject:message-id; bh=zG28dLa82KI1lzShfY3rVVpEFZ+TVN568W1asXUfa1w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAwBG2tg3sd9zjraiLLiWFTcPIVts8RqyB2/
 z+E47876NaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bWR4EACSUmUdPtpoyifbDZWdmxNPFCwIQ1elMni0s09qUoufVqEzyBMoBSPt/B0D8HW/khz7Ljr
 tZVHqCiTnq+dP9RA9NwKbmfMPQFsSFZ5L+azGNj5AAvjfaw6q27HM/lzoR87uwOk58W6pFVu5Yh
 vuthEbsr4ID4NuTIBZHWJoxT14txI5lIS/u6Rllwh88aC8x78UUpUjMaBANVoEuBLL0gW8s5AOC
 CQtZwNMfZ9X66wo7l7kaWxWLbf7uSbJeqM1DvCkVjEaPNzaDUlydp/+oIqv8CmvYHhEzd+xgXP4
 jw4qLm+Nrv14XrG6CkeQEzCrXzP863VSifRVjHTgJlpK6NDpoaKiQCH62TDArna4K0n30KtNo/K
 KEhQBfa9f0+2tQSGyqAjREryUswKE0gajF3vJnK8tRiKzkOqDDTPzYtkUrTieuKaf217SbFUhuh
 jRjPIQILPnC9/6VbPb7ovGKbCH43ZSEz7lrJ3KLtOUiA7LINljxg+mZk5bor8KX7wcjLBAMBs+f
 kVFYLR8bQqmZGMf4f5/ysKt3ag+eCsmjioBfpC8oqpHexN3C6oW+R7BbXRpLKc7VaFwIDjFwJ/7
 PM1uMz5eLBgyavmwjp/WND18BtqqYEH0B2EhTg2v8ljvJdeKuML6tmx5MSnYDRKo+1WKsaIXJY1
 jbLG3o4b7mSVOTw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: F03544E722C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285251-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert KCM socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/kcm/kcmsock.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 3912e75079f5e..b273213cc68d1 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -24,6 +24,7 @@
 #include <linux/workqueue.h>
 #include <linux/syscalls.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/kcm.h>
 #include <net/netns/generic.h>
@@ -1167,7 +1168,7 @@ static int kcm_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int kcm_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct kcm_sock *kcm = kcm_sk(sock->sk);
 	int val, len;
@@ -1175,9 +1176,7 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_KCM)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1191,9 +1190,8 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -1755,7 +1753,7 @@ static const struct proto_ops kcm_dgram_ops = {
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	kcm_setsockopt,
-	.getsockopt =	kcm_getsockopt,
+	.getsockopt_iter = kcm_getsockopt,
 	.sendmsg =	kcm_sendmsg,
 	.recvmsg =	kcm_recvmsg,
 	.mmap =		sock_no_mmap,
@@ -1776,7 +1774,7 @@ static const struct proto_ops kcm_seqpacket_ops = {
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	kcm_setsockopt,
-	.getsockopt =	kcm_getsockopt,
+	.getsockopt_iter = kcm_getsockopt,
 	.sendmsg =	kcm_sendmsg,
 	.recvmsg =	kcm_recvmsg,
 	.mmap =		sock_no_mmap,

-- 
2.52.0


