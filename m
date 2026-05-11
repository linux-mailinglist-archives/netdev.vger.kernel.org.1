Return-Path: <netdev+bounces-286598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAADNOKyAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03250C134
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79CFA30450B6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D533D9DB6;
	Mon, 11 May 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KGbNomyD"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095A3DA7E1;
	Mon, 11 May 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496141; cv=none; b=bhc29KR72ebdcssAxYArtoPDj50fSgd2p0pXhPDJ4z1dU4tQpAzPD1eN2bdnBOHR4mPgmiXVJ2/ejABFeXXro1Exg53EZNYzbh0b4Udkk+mQSOxrLTwCIjjd5OBo1YF4zozpKKo6buy975Ym6rjuS56CXWHq+LsJE6JxHCSDdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496141; c=relaxed/simple;
	bh=RXdB+OMQFTCr5HzIoLQwuXJ2Je8Y6jzyknXHxP/EeU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmW1ea5x10d8xDEvDR4k/PGiB0iAL94s5UIvStKxh4CWtVpH0/XMIn2/I241jTq9OgNAbS170fLIjLeY6ho69xpV/wE45AiQkrSoXMbnlQK+O3LhGd7I7t0WyZba70UiHyoEqmhrHeldBfMNoi9NdVLz6zUrm/DC1nbZQamK9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KGbNomyD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=PChf6X3S5FarPKzj6gSzmKmcK2boYjPK7wX3EmPoPfk=; b=KGbNomyDofxT5by6oMOWTOch/4
	7GGypw/deFIEdYGb6H6xfWkw66LvTur5vfoiN7GIugv1ZMKcCJHYDspXmxbuPA6aKAD/RDiKV6tcE
	SJk9uPBv7cBy4G0IaLkOn9NnG0TWbBAARFNdO2L7dWEhf1tgpRwEzJHGfjP/qmVjqx/VD+ZSV99iu
	gDgQZoSCoHRauAFwvpiSec6GhcEYwGMh7TQe9N3JBrLTnk/+oKNmcMEFfpyQXcbniT3xnCfV8mnjh
	a24GDzyYDRjThFt8rDgqfl+JEOTheZ5xfWyCZrju5CeMXeGtM9SsBc9zzSxbWR/7gkD+OG0RVLuzs
	3tzKcdNw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5a-001XfG-19;
	Mon, 11 May 2026 10:42:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:50 -0700
Subject: [PATCH net-next 5/7] Bluetooth: L2CAP: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-5-1461fa8786ab@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6748; i=leitao@debian.org;
 h=from:subject:message-id; bh=RXdB+OMQFTCr5HzIoLQwuXJ2Je8Y6jzyknXHxP/EeU0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvJmMtbVOKd0Z8OTzscHxhc5xGD8vaNS86c
 jnCm+7b6GqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bdxbD/4wCYhs2ZKr5RXPE3tR+1i6gr309KqrDWOZsYx/XoQDCorjxeU1HI09B+KYzyrKe1UYyqt
 d0xoMc/X+B3Oard88+IWvHkNCUUE0Qt0CkQh6R/AsuqLwBPb9AjpQrFRheHStgY3K2YwnjXzUix
 a2x6WwwWTQ0Fy7A0oQTYpLfLEEtNCpgBYViZQQdkCUpcHmv9HT90yntnMt2/lZNJOx6q13xbCwm
 dVN86TxeTRjlWiqFTvq/ms5nIRR3dupzd4Agt+mzMxwWjXM8GRWyr1JCJs9hEEkG2jLioapEPtv
 /PERtS6F0RZ4OWm9OwW55cuoN2K5AEi2yXARFjvXhcLc/ArY++x/JIwb+VQ3Ipun5g2GnZXpud/
 oxCvqvA6lqL3Qr8U+4zBFXIXn7sE/mZby9cmeejEFm1leA84e8TzJJmZbl9H2dtz/QuzhSifyRH
 UUw7uEcfC6rtiOmN+WjK1PeaYyAaLX61rpHXbgKzmYm96rIpiTgPje0ABNr4XoOqP2CsuwtsyZF
 mZZsGwTtkhp8OoRDW0RMxxWf2KacsvW6m83QIR+luH2Jqpp0TNnYUFHwI2SlO59nKGXgSnNUB9J
 tHPZJ9GqnQxU4d1G/CXNe6k3qmFh3KOuuMvY8AhWI2vTVlc9Ewe3EE3Uw5NkjjLF684KaopkL12
 D1F/ZN1BJ3CtMnA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 8D03250C134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286598-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert L2CAP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

The sockopt_t parameter is named sopt rather than opt to avoid
collision with the existing local u32 opt used by L2CAP_LM. The same
naming is reused for the new u32 helper in l2cap_sock_getsockopt(),
with mtu and mval helpers covering the u16 and u8 cases.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/l2cap_sock.c | 61 ++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf590a67d3641..dede550d60319 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -31,6 +31,7 @@
 #include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -433,7 +434,7 @@ static int l2cap_get_mode(struct l2cap_chan *chan)
 }
 
 static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
-				     char __user *optval, int __user *optlen)
+				     sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
@@ -445,8 +446,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -488,7 +488,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
 		len = min(len, sizeof(opts));
-		if (copy_to_user(optval, (char *) &opts, len))
+		if (copy_to_iter(&opts, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -520,7 +520,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			opt |= L2CAP_LM_RELIABLE;
 
-		if (put_user(opt, (u32 __user *) optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -538,7 +539,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
+		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -553,25 +554,26 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 }
 
 static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
-				 char __user *optval, int __user *optlen)
+				 sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	struct bt_power pwr;
-	u32 phys;
 	int len, mode, err = 0;
+	u32 opt;
+	u16 mtu;
+	u8 mval;
 
 	BT_DBG("sk %p", sk);
 
 	if (level == SOL_L2CAP)
-		return l2cap_sock_getsockopt_old(sock, optname, optval, optlen);
+		return l2cap_sock_getsockopt_old(sock, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -595,7 +597,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, sizeof(sec));
-		if (copy_to_user(optval, (char *) &sec, len))
+		if (copy_to_iter(&sec, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -606,15 +608,17 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *) optval))
+		opt = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
 
 	case BT_FLUSHABLE:
-		if (put_user(test_bit(FLAG_FLUSHABLE, &chan->flags),
-			     (u32 __user *) optval))
+		opt = test_bit(FLAG_FLUSHABLE, &chan->flags);
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -629,13 +633,15 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		pwr.force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 
 		len = min_t(unsigned int, len, sizeof(pwr));
-		if (copy_to_user(optval, (char *) &pwr, len))
+		if (copy_to_iter(&pwr, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (put_user(chan->chan_policy, (u32 __user *) optval))
+		opt = chan->chan_policy;
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -650,7 +656,9 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(chan->omtu, (u16 __user *) optval))
+		mtu = chan->omtu;
+		if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=
+		    sizeof(mtu))
 			err = -EFAULT;
 		break;
 
@@ -660,7 +668,9 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(chan->imtu, (u16 __user *) optval))
+		mtu = chan->imtu;
+		if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=
+		    sizeof(mtu))
 			err = -EFAULT;
 		break;
 
@@ -670,9 +680,10 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		phys = hci_conn_get_phy(chan->conn->hcon);
+		opt = hci_conn_get_phy(chan->conn->hcon);
 
-		if (put_user(phys, (u32 __user *) optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -693,7 +704,9 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(mode, (u8 __user *) optval))
+		mval = mode;
+		if (copy_to_iter(&mval, sizeof(mval), &sopt->iter_out) !=
+		    sizeof(mval))
 			err = -EFAULT;
 		break;
 
@@ -2000,7 +2013,7 @@ static const struct proto_ops l2cap_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= l2cap_sock_shutdown,
 	.setsockopt	= l2cap_sock_setsockopt,
-	.getsockopt	= l2cap_sock_getsockopt
+	.getsockopt_iter = l2cap_sock_getsockopt
 };
 
 static const struct net_proto_family l2cap_sock_family_ops = {

-- 
2.53.0-Meta


