Return-Path: <netdev+bounces-287103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KQ8A9ILA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:15:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C651F2B8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6518630237C1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0114C8FF8;
	Tue, 12 May 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LKPRWCBA"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB44C77CA;
	Tue, 12 May 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584377; cv=none; b=J+UWasSI36H7xLW4dwRtSolNt1NBrNDhF8Cn2g6sdmACAMnBvwyGmnjGHUFM6bxP2a1FB6kk48jOfTt87p+YYzJBp0u0Ktsr4QVVjh6IWAjwRDX+s/cul2NsWAaPMB4iYRjbficprnenGBTNSxwjRVYJogi+JEWd4LAJ78y+zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584377; c=relaxed/simple;
	bh=gB0St4CQxpXU7gKF9rXtafb1OmVyY/D/UPam9e+oqso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7eL70s1ZB4eD1exNM/NkdcxuDOAdcQDv/LO6kFt9F8ylkSWb8jR/CFCSJTXd1lM28RT60ex+PghxzWY/X2go60JR3Y9MfrbnVhV5o0E6mt+rOqf3/UAsznoBjXGX5E9fwtWv/4v80FBEjEmNmRSyqFeskDHkAWkDdmiUWoDIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LKPRWCBA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=JpTg0E3qD/O8DeTaZUSnQmT3HKvGWqiv+8u7BGQ9VJ0=; b=LKPRWCBAC2hyXBPAD8C11iwkE2
	03MuAUKgo8NHqAmFr9U7LCtRYW6DFlRo1uvOt7eEgmWFdhthczO8ec94r9zw/n1/ClwY6CJY3D4rC
	Ds+/6x/FtncN/3PTx9/kWK8giM/s7eTqER6HfNz5o+H1zPQKJCJPNUCpKluuBIGdvEI5Boly0ynwp
	Tr9LqWijY5vOpT3VFRbDi5LOnpYzd+GYTee8cOqffD5gg1A9mXSS6euC4vhlgiVk6UTnXB2CjuAEe
	CyNLey8ApQrk59f8U9Ivu+NmsXOiWAct1dl2ReXcQyN/j4GvWSzfk3KnuvA9+QKVH93mt/RCvdeyV
	7VJk8Yag==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2f-002KrE-21;
	Tue, 12 May 2026 11:12:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 04:12:19 -0700
Subject: [PATCH net-next v2 4/6] Bluetooth: RFCOMM: convert to
 getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-getsock_three-v2-4-30b7b22ef14c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=leitao@debian.org;
 h=from:subject:message-id; bh=gB0St4CQxpXU7gKF9rXtafb1OmVyY/D/UPam9e+oqso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsbSlHBuCyV0Iex8JpSX1NlX8R0S6ZpxyFj9
 mHgXi51wv+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGwAKCRA1o5Of/Hh3
 bV2hD/9yUWKl+T/j3Gkf4xO1awNWtObVqfcYIygFEes3EduMBmyAEkbWMrOaCGrm4CszwGW7pvo
 P0U0VCIBRVE7HdDsAq5pggMXMAOUkyAs7q3SJs8pnYtAZJFcmR9/updokY1St4dA4FyyQC/QkkD
 xhUJphXP6WRvyI0q8Lj5VK5Ty8ACEgaVaDjjshnZH3ilNrfruI2W+HZ0Z5codzEVun41dnHL28T
 DEtZfFj+Z5DMTkAPWqeR3mwYXSzphL3Sn1RU+BEsvlTK+X3eYgrCMxNrDhF+evkMw10/qYBCfdO
 WeHngPII5XeUDAuyNZ9Jr+xVj9IpNyNs+2ic+eaBMQHhfRSvvVT2yoR5OSf5c67LL5RlzzL/x7T
 tq5pcjgdi4iahZndEcdNX5nwOym8WQbsvUGRuf7zs/rTzlEAUD8sMI2cULjEnmjGRJXMN2cRcB2
 CeJRdaUFwRIPbBoe6tu+KPZISxlOaOd9vAoIzHodrq9wT43Ksd+yTYN36xeevk+easwcsye90lb
 jzBPwjQ9IyXN57JqlKBZ3BPXQJ/BG41zZ2OF+YP6XGM/Xx1XdThsEr3T2QC43PNASR1mf7g5L93
 EqYAj2GYcir4QjoueLb2EtQ6dQRH7Ht/rvtIo6IkKsnnJ+jkY4Wbj6ChOqGYRS+/xW/TN4sxmaF
 RqoC6Nt25Lml7Iw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 254C651F2B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287103-lists,netdev=lfdr.de];
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

Convert RFCOMM socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

The sockopt_t parameter is named sopt rather than opt to avoid
collision with the existing local u32 opt used by RFCOMM_LM.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/rfcomm/sock.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6f590..9b22e4240ed14 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -723,7 +724,8 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
-static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
+static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
+				      sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct sock *l2cap_sk;
@@ -735,8 +737,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -765,7 +766,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		if (rfcomm_pi(sk)->role_switch)
 			opt |= RFCOMM_LM_MASTER;
 
-		if (put_user(opt, (u32 __user *) optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -785,7 +787,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
+		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -799,23 +801,24 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	return err;
 }
 
-static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname,
+				  sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
 	size_t len;
+	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
 	if (level == SOL_RFCOMM)
-		return rfcomm_sock_getsockopt_old(sock, optname, optval, optlen);
+		return rfcomm_sock_getsockopt_old(sock, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -830,7 +833,7 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 		sec.key_size = 0;
 
 		len = min(len, sizeof(sec));
-		if (copy_to_user(optval, (char *) &sec, len))
+		if (copy_to_iter(&sec, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -841,8 +844,9 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *) optval))
+		opt = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -1014,7 +1018,7 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.recvmsg	= rfcomm_sock_recvmsg,
 	.shutdown	= rfcomm_sock_shutdown,
 	.setsockopt	= rfcomm_sock_setsockopt,
-	.getsockopt	= rfcomm_sock_getsockopt,
+	.getsockopt_iter = rfcomm_sock_getsockopt,
 	.ioctl		= rfcomm_sock_ioctl,
 	.gettstamp	= sock_gettstamp,
 	.poll		= bt_sock_poll,

-- 
2.53.0-Meta


