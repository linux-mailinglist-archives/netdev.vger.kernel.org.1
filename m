Return-Path: <netdev+bounces-285252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOLQB7Nw/GmkQAAAu9opvQ
	(envelope-from <netdev+bounces-285252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D24E7259
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFFB93006100
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EC3F0AA1;
	Thu,  7 May 2026 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QhNPzIsK"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38783EF0C4;
	Thu,  7 May 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151516; cv=none; b=HwIOQImeJ+B/YxQyiRCxYyEvZkPbeTNAsvV0TLVn0uG6LDuXrSd2VU4/6OrL+ApH9A4jJZIdgj5ieiCqe+egRVqnFoEmRferXikJC/DtzVP9BUXI7u906LKFWAkm9GCqPLSx8dMaIxyVvexam3Mxw34Q5Gn6+PneaGDcHq9CrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151516; c=relaxed/simple;
	bh=4lTzgyDQklQCacFgdaLB2vq4HJBX9MTWUlTxqnOaSwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4fO6O5o5sDfMtkotXa6sXKu+itJdoLcMKIDvTc96nLkSO/KS6adfvsHeE9lm9MrLXi7+LbbdCfIxW3QrHrEZJ5XUxdMYEkj92HU4OWDgJvFi1dFoGe3Axv+QvJ4IcCmUTXz1Cs6IXY5mtCubSoA4VynhFgaCPyJSn1CPUBLWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QhNPzIsK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=j20jcOAexDrO00aqKPg7FRsy8ym9GIdX6jyLAXGErlo=; b=QhNPzIsKeWhPs0rwyo0shY3Cu4
	TYWnCJ3irAKXoTv3RGmzpmw9/89S/bj5LZNbodrMytweLU+ReutweryybY8s4JM44chahAlg3c7JE
	cxbMGGZZ5jGemKPFlWnwsxHDP9M8R1xIWlSt4lhTjIYb6suiS7ww/iKkZM9fTNFgtJbxu1ojEah52
	o7DzBTBqCwexs/iUpzz+RstF/VzIeju7ELkPgjuEfxuMsSH+GgxFZe7mfvsELq5zq4CQ4TX981uAU
	EdZaneOMyACoqA7g5r/ivRYlgxn5j+fQTM7BWn15A39Bpm5bu+KFQVaCykW6EzXluEn/Yh1LNOU3Z
	Ep716X/g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQm-004Jnz-0a;
	Thu, 07 May 2026 10:58:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 03:57:52 -0700
Subject: [PATCH net-next v2 3/5] x25: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two-v2-3-5873111d9c12@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=leitao@debian.org;
 h=from:subject:message-id; bh=4lTzgyDQklQCacFgdaLB2vq4HJBX9MTWUlTxqnOaSwg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAwmLgwf7Kben+MgWxW4FeTeaTJZ8T1nW71h
 x66WN5/omiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bfE8D/9ln2RF2jgXwQmyofT5OQJQz3WLHW4suC/Vm6ifqs+elQq9dYCkWgWfxEHg0hYaJb3gXiG
 I+OvbOmRvhgdl9aHo5rhElscs/NLIV4oL1ul80nam+GE5S2ruEnMWJ3Pv7y/pX9dWR6npei822S
 HQv1wJyumNv01PoPX7Xpu1/lVFkFtgmtlUmSLI3l3aH3DjdrW8/pM0W2ty3Z8aTO7Wq+NVed0u/
 PJasaXujbbz33Xg0WM2A3gsbu+R8sNPlbHAApskaExF0Q5hXq/M65mwtaH5KDu1XFh5i9JOVW03
 iudPl99cYe7N0CUejnZXcF94TRTKQJ0vGgFPEiR43cBNfVnjUpDZ+Hd/IurtKur4wuajleuktpR
 MjqeIqzZvev1lpi8Y3vI3GQZYz5KlXdWBrwpv5cBWJy/81R1xcqCXcavkplMBSanphLLCZiG647
 TqKTYx8kHqs9z85bp/caiUlLCUYlGaiHosoyybQssYlACyQ0NE0eYVGd44m9TDP4WMRanfKR7qt
 o7ibrY3jI0Me0h81NeLsQMymZ4trTmoLNxGySmTARHnQr+c1g8QAHH/7MzCN8tiV6AzWY5z0vBH
 3oO1aVRVGsLa37MHN/Fkv/HspTuFGNPdE1YZxWrhXZI+icPqtzm+5GTR2J1cFzGuBItWZ6tsE3d
 HdicnwRI/A72ZJw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: F14D24E7259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285252-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert X.25 socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/x25/af_x25.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index af8762b24039d..c31d2af5dd223 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -53,6 +53,7 @@
 #include <linux/init.h>
 #include <linux/compat.h>
 #include <linux/ctype.h>
+#include <linux/uio.h>
 
 #include <net/x25.h>
 #include <net/compat.h>
@@ -448,7 +449,7 @@ static int x25_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int x25_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	int val, len, rc = -ENOPROTOOPT;
@@ -456,22 +457,17 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_X25 || optname != X25_QBITINCL)
 		goto out;
 
-	rc = -EFAULT;
-	if (get_user(len, optlen))
-		goto out;
+	len = opt->optlen;
 
 	rc = -EINVAL;
 	if (len < 0)
 		goto out;
 
 	len = min_t(unsigned int, len, sizeof(int));
-
-	rc = -EFAULT;
-	if (put_user(len, optlen))
-		goto out;
+	opt->optlen = len;
 
 	val = test_bit(X25_Q_BIT_FLAG, &x25_sk(sk)->flags);
-	rc = copy_to_user(optval, &val, len) ? -EFAULT : 0;
+	rc = copy_to_iter(&val, len, &opt->iter_out) != len ? -EFAULT : 0;
 out:
 	return rc;
 }
@@ -1753,7 +1749,7 @@ static const struct proto_ops x25_proto_ops = {
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,
-	.getsockopt =	x25_getsockopt,
+	.getsockopt_iter = x25_getsockopt,
 	.sendmsg =	x25_sendmsg,
 	.recvmsg =	x25_recvmsg,
 	.mmap =		sock_no_mmap,

-- 
2.52.0


