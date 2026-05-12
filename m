Return-Path: <netdev+bounces-287102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEoHD6wLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B251F29A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB239301F288
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEC4C77C3;
	Tue, 12 May 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D3oBSZTg"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F86368D4A;
	Tue, 12 May 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584373; cv=none; b=Nd33NDqXaIwctRGGYidPCwIVwvSiwbEYBO4hsT8XIARVlpDoxQYCDX2InTcvccJX5wj8xrity5YKF/X1sPXdl8GzqmZ/MIvNtg5zaVn2Lt5hJCtkm8coRi60fD18tDskufYdm7sYbVSaPYevToNOrAOGyi44VatSUvKmY3hQoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584373; c=relaxed/simple;
	bh=zv4ypYBlXlacgkjArTcJ+qxpcgQPje6jIqRBAe1SKOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0vQuQJZmeCAV4HHegIps5Vf7GQAHOgxMqmr4+FLn5B80gB+M9L28YjWaelkX2GDFoXrzc3A8wOTCRgOnAVsmtguRNyqBBmCWNsk7AG3jNhUFQrsHaHmIDviEMebOv53E1rmUvLHnpClmhScSp3hoYhy30ItNugRbfkmAELbK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D3oBSZTg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=tnpW3RxsYB3WXMtCFMcp7qbYXymVb+70PXZPn7pH3Mw=; b=D3oBSZTgxSgJixQ4vOx8DUjNdp
	vliDSqIUiuD6uZEa/T1bXmYx1cCOmY8VI44es+uOmDNhatzON4AziHWc7DGbI++4qOnRTfgRMvXZH
	Eok4mQKrSMMT7zt18Rb18LJf+CRNaWo7lBSeqHQbjX2JiaGTzvvaNGjoirm2U9p3SCn6EttfN3P6+
	/ewJCJErfvd0iFJIcuF7dYtcCQnBhU7N3rJV0qyZL/aZFYmoqYdRaGAGf9uRFHcHMl/sniysShAWG
	K39zXW1N/MsmWo8aQO2zXJGWRk8ZszcO+UDTNR6Fxmk2RfSGsvjUI6Ow17Kr4SdMieRroXvXYqn7c
	Q5rKEzTQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2b-002Kr4-1C;
	Tue, 12 May 2026 11:12:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 04:12:18 -0700
Subject: [PATCH net-next v2 3/6] Bluetooth: ISO: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-getsock_three-v2-3-30b7b22ef14c@debian.org>
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=leitao@debian.org;
 h=from:subject:message-id; bh=zv4ypYBlXlacgkjArTcJ+qxpcgQPje6jIqRBAe1SKOc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsbP2nUfsYddSe95/5fBUcRp+0X/+LZuNMWm
 SmcErDaNGuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGwAKCRA1o5Of/Hh3
 bbVKD/4tSCwA2KUnjhEi/99ESk65fM8iPU2yDG4Xg0UcHWqVK4OziKL0s4XdezVkmQl+ENhqpqg
 ilFSCvJRBoIZEGVrdedRcnx4nOFapAWzruFRpT2s8qCDFstG293sgfYYKouhXPsZdl+WuukLd2g
 /diDtyUKp9Ne/TnwgcrNw6brGiuuGBF8eg9B4HiJc6IN+0KU/qNEJIHeeyGkynG+PX1cOjtMv9h
 yChZuY/KpNd5FFvsg7KxAPB3fCEAM8D+CnncrcHrbH0TF2OZ24RvbjzkrEY7YMpoi1gAmbxPw0u
 rT+hXkg9AwG/Mem8wBKV8oCtQ6IqIxpZamI7zlOT0DEXOuc0Wqoj1bs9sROT8kxUFKzfnW4XVrs
 2kInnZdzBTBo3XcXgbZ7T6wJwwdhBihIUMFwXOfh345TzKyWf2XLW7suhwEDBU1jbw8/9/uRPKC
 e7WpB7PgMAg7Jhct93rjdwtHxe3AevhrX3+63Y4lvVXn0gfp/tGuL2Ibl6V7TKg4fKhWJ2uXtKA
 knnJGUeeyF1DBT63XqXPlQogqMff2bZRYpFcNRDed8lRgPTdR4uetp2LRTGV87Kz244fYzIKQHo
 5UrEdLm8WgyY1+jNWtfOhSAKy7rU/zu9Ume9/1LXfDTpKE2rpA/7tWA1CvIk6VtdTVgEAkaN4o8
 4ZY4bM4ZpB9MwFQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 849B251F29A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287102-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert ISO socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/iso.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe8724..0d792d36bb5ac 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1842,18 +1843,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
 	struct bt_iso_qos *qos;
+	int len, val, err = 0;
 	u8 base_len;
 	u8 *base;
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	lock_sock(sk);
 
@@ -1864,15 +1864,17 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *)optval))
+		val = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 
 		break;
 
 	case BT_PKT_STATUS:
-		if (put_user(test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags),
-			     (int __user *)optval))
+		val = test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 		break;
 
@@ -1880,7 +1882,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		qos = iso_sock_get_qos(sk);
 
 		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_user(optval, qos, len))
+		if (copy_to_iter(qos, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -1896,9 +1898,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, base_len);
-		if (copy_to_user(optval, base, len))
-			err = -EFAULT;
-		if (put_user(len, optlen))
+		opt->optlen = len;
+		if (copy_to_iter(base, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -2660,7 +2661,7 @@ static const struct proto_ops iso_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= iso_sock_shutdown,
 	.setsockopt	= iso_sock_setsockopt,
-	.getsockopt	= iso_sock_getsockopt
+	.getsockopt_iter = iso_sock_getsockopt
 };
 
 static const struct net_proto_family iso_sock_family_ops = {

-- 
2.53.0-Meta


