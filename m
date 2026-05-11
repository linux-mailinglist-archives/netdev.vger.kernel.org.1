Return-Path: <netdev+bounces-286595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI5dGu2zAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B550C2DA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11400307BF2C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7733D9DC7;
	Mon, 11 May 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="g/wkbaBd"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED083D9034;
	Mon, 11 May 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496130; cv=none; b=OfpmsQcUXvSd1CJFUV2hqcYd3wASi/kuZTL7T/WS6559IS5fQoqFABDSxu8Z+wmJofZfPg8Vd1OhmHWLGDaWDFhDezAyPBNHiMolTNBIjzFLkLIg0gj0yANPNyCQvtxzlrxr3mj/KnEFMLVQ3QPmNQwmHKcmMfffoZfHBGi+BSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496130; c=relaxed/simple;
	bh=HK+Sfftx5xMXf/ohhSVSyX4kM0dUiUEr9WG/OrDiAs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhUNQfi3wN09Unc/js+osizJJg4j/V68v1C0N7kQJN5/TQQ0x4z9wYYLq19gSwMIQobckjqWYbtXLZ4OIiyyIkDFmzbyRyATYf4hFTiL0V7pbXN8yBDK3XZoRTlvQe46BNyiLcpStf5lH23KqI/BjKc/3rPMK4ErDVTLgL9X5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=g/wkbaBd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=sNHiQxq5X7Gs6FyItbbqpwShrdRtmwW2a3t0q+1JSZQ=; b=g/wkbaBdFOHm91JvefHdoy5ud9
	p5v8TZzN/DMCukdNZjsIeFsieIXB4eOXXy6kDX0kdVhEL2EcQ3T1Qol95YXc6CJzQsMQ7uTnkEZq0
	EzxxwYbmIhWZVvMM927MO9r4HX9Hke4Afuf/DEcUL0KrnH/72NDyIaZEfTkUM/ROvmo58MT8FR+Lo
	lJ8NEgjOZ45n4K6o1BDaZ32OubvAgovuGc2hbXPz7e3OlYOZj73CLdwLLRY8pUSh4V883IG1AZJG4
	J0LN0leWktw2BNXEJZBNHob51rmqbrYrPC1OeEOGMI0FlLypZpH3mxxrCRAl9uo43NjmWVYLFJ08f
	ARlp4UpQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5M-001XeM-2t;
	Mon, 11 May 2026 10:42:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:47 -0700
Subject: [PATCH net-next 2/7] Bluetooth: hci_sock: convert to
 getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-2-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=leitao@debian.org;
 h=from:subject:message-id; bh=HK+Sfftx5xMXf/ohhSVSyX4kM0dUiUEr9WG/OrDiAs0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvSaQLGnX5LVHbMVVMrHqrPGGOy4+JXxlNm
 9lf7mz4Dg6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bQMSEACJ/0kZ/zh2Mj8zhtifHJfEz4aXrzSk0KNnqGYxzRDZtBGJpwWa8wyhM1mbWbuD7g979Er
 yVT1VPfSqbwPbQ53C8waCFx2sbz2fLUWsXXB0pF5UkE3NKQRdK0EUJ1NXCaBSNotrY/TwiJrtAp
 x3XgV2wrM1J0FpceKPDgp16hLkUBmhk4KS0axotlNHyJNqSvmePuFrJ4idjLXL1KvaViSu36sLn
 nIXu1AWa6pr4U6BAuTlyGe6KJ3qSeAGv6lKihzbEOKp22DDznSb47nY4T8LOSeWyfAuzkUu/utn
 nJ67arySqaLVU4bv17klFQ80leCpQogwQ7BjfdD0s0egQf/5nRajb9/B7dT6+8kplrTSJUKS66J
 keRyi5euAAtthi+zaYLduDChYDiIBDeH1Ji52xHGfEXedGr6ko3YY9E+13y3+VmSX6pmlQ/88pW
 Bb7qlJdzSLmHnm9OiGzHIMxLI95DtUkWnaDV4gesn9hrA5bpXkF1WQaAoQjDtydCqg5jZjPDt8U
 Bzd2OAZDIiZG8wLSMXTQMtqUMYmRq8eo7Mq5mD2YSL44hrnQY5866sARG8rVUqiEtdciKcGxG4/
 da1s7HNNPT//5FmladNN6ifGJvSQzAc/4Abthq/MOpBZHkGV/UUoIWsaA+0lN8mT25pfy9BPeGn
 o9E8wJYiSaOdSQQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: AF2B550C2DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286595-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert HCI socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

The sockopt_t parameter is named sopt rather than opt to avoid
collision with the existing local int opt used by HCI_DATA_DIR and
HCI_TIME_STAMP.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/hci_sock.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1823c06ba8940..61fec674a2078 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
+#include <linux/uio.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -2063,7 +2064,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
-				   char __user *optval, int __user *optlen)
+				   sockopt_t *sopt)
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
@@ -2071,8 +2072,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -2088,7 +2088,8 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, (int __user *)optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -2098,7 +2099,8 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, (int __user *)optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -2114,7 +2116,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, sizeof(uf));
-		if (copy_to_user(optval, &uf, len))
+		if (copy_to_iter(&uf, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 		break;
 
@@ -2129,16 +2131,16 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	u16 mtu;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
 	if (level == SOL_HCI)
-		return hci_sock_getsockopt_old(sock, level, optname, optval,
-					       optlen);
+		return hci_sock_getsockopt_old(sock, level, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
@@ -2148,7 +2150,9 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case BT_SNDMTU:
 	case BT_RCVMTU:
-		if (put_user(hci_pi(sk)->mtu, (u16 __user *)optval))
+		mtu = hci_pi(sk)->mtu;
+		if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=
+		    sizeof(mtu))
 			err = -EFAULT;
 		break;
 
@@ -2185,7 +2189,7 @@ static const struct proto_ops hci_sock_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= hci_sock_setsockopt,
-	.getsockopt	= hci_sock_getsockopt,
+	.getsockopt_iter = hci_sock_getsockopt,
 	.connect	= sock_no_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,

-- 
2.53.0-Meta


