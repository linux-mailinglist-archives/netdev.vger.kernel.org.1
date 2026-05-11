Return-Path: <netdev+bounces-286600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IIVASqzAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDA50C1A0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAE48305D3BD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D63DD500;
	Mon, 11 May 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n2TpzTCL"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C93DD508;
	Mon, 11 May 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496151; cv=none; b=RFZchxVu3AlzAuO0W5t1abEG8N3+OrZmET/3fi25a/bs2FbJIO/6h4jbRBKrEyiPJzXQ7p+u3Qbf9fmH2HkhaCiyKhGJFPSo4M9K5mb2n3v/nU+ZHvke5gaPTIoNi9QqKLoVy15hkKjcxuJhQQgVm8zU/SCfxTYCxnGc6NGrToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496151; c=relaxed/simple;
	bh=2v3FBFlG0XjBuZMc0nVvHHUoBstblBc5qcpRFYUU7T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZreS+ETHg7CabAruqdfF0oNFUCBgyR2sPsTdv7PT2zZ7gT/navKJAZE27tKBZ1qd32/W0LBnaSG69EDl61T2oQOIa1SLsgF6YPv7rAZnvQo6p3pG6Sx5rN7W95x72Ltb4ohru3uWickMQmeJ3Zb44nr4RclJXWnKNBuqihLL+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n2TpzTCL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QAkqmhjFVXqkWVmRDV9dUjrCOzlfdfwg7GpIXw4OrOw=; b=n2TpzTCL9WZHyUB1VoqpHIA7cR
	9gWayzdYjs9j2mMrAAASbwLKzVsPBGcyLMcECrfO1Pdt0qxiGTdlcDsy2mXUE+UeU9VzpwX9xcBwV
	ExkYg4q9e0OpcgnB7w8aGm53hAcLXZtRRHVnhxeD/LU6+05WDQ6vENwOJoCF7YI0Y9ZvJvKPSlVq2
	XYh3RIlQr1SHiZXxA2dvQDk7/Ij8bgEbgDRKcnY4swMwpDLK87ZLOGxzQG6ET2duWABbjoqtwTpu+
	BHcMRUp/Fz5v7ab7aY+5vaCIQnD9u/5orN3C9a3g+2rANeoI6hSQQba3dvAx4awwDDHHxOK4u5gkK
	PLccj2Xw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5j-001Xfg-1S;
	Mon, 11 May 2026 10:42:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:52 -0700
Subject: [PATCH net-next 7/7] Bluetooth: SCO: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-7-1461fa8786ab@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6695; i=leitao@debian.org;
 h=from:subject:message-id; bh=2v3FBFlG0XjBuZMc0nVvHHUoBstblBc5qcpRFYUU7T4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvhTNKsxlDIAZ9Oy0sozpCh7jvpR+nSrGxE
 EN+NbLU2+6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bUUKEACCgVHYWDI1YNs83RqJUFptMRuH5b1FJ/OiODCtwePAZ7xVnnWk7okAzurHC2xj7qFErGq
 0TQuGqSo7L5IcyeCacDc7CSpUZBUOAOIjKqBvZZkze9Z4176nPU2JQOZdWr8NSmXcJhCMbFatpf
 tyBM+D/TLXTAqDLrWm3hZmSmJH9ys4NPRanLi5W35DG+VskLXPxysn1oQOPpqeELb/LaSoBYlHX
 haeaYb+ObA9537aCBVMf0uQFUQH0xgyjXsIEddmQZ/zBgSIzuGaQjNtXYdTeZ/Sb5lFa/KMFszT
 OgeYj7mumBIi6pW0KaOJKj/V8OP+euH9Fhd7IkG/wvxdk51vkaHUoWvM1X0Fiz05N7FSNzEwOhK
 URAuEQ5HU30+ug8bZgN0S2YdqtbxzL8e/L0OCDsWWAJroRuFk06p8QjIdUEIo8RB0fZaz067YsF
 yfSKciJxiue2hURkAvcKEG4hpVR6k6Aj5wJnF3f9wEO+77cyTeT0giHytum1JtMeqkHpRQ5Toyh
 JDcrjB5AJT5uQW90AqG7epGwTi0BOl8OWC/i4QFoTGxca1Hd7RkxM+YZuzkjjS86qbC2EPbZmgQ
 wNdahqx/RcvgG5/ZMVCAzsmlgRURm1+bdzt5njkiutwaKHQ6/3HF/A5DnTbx1YTiT1T2zbOoB9J
 g6u1toquG/Rp78A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 92DDA50C1A0
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
	TAGGED_FROM(0.00)[bounces-286600-lists,netdev=lfdr.de];
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

Convert SCO socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Drop the open-coded ptr cursor in BT_CODEC; iter_out advances on
  every copy_to_iter() naturally
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/sco.c | 59 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index eba44525d41d9..37dcba9edfab6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -28,6 +28,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1072,7 +1073,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int sco_sock_getsockopt_old(struct socket *sock, int optname,
-				   char __user *optval, int __user *optlen)
+				   sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
@@ -1082,8 +1083,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	lock_sock(sk);
 
@@ -1101,7 +1101,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 		BT_DBG("mtu %u", opts.mtu);
 
 		len = min(len, sizeof(opts));
-		if (copy_to_user(optval, (char *)&opts, len))
+		if (copy_to_iter(&opts, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -1119,7 +1119,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *)&cinfo, len))
+		if (copy_to_iter(&cinfo, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -1134,15 +1134,15 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 }
 
 static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int len, val, err = 0;
 	struct bt_voice voice;
 	u32 phys;
 	int buf_len;
 	struct codec_list *c;
-	u8 num_codecs, i, __user *ptr;
+	u8 num_codecs, i;
 	struct hci_dev *hdev;
 	struct hci_codec_caps *caps;
 	struct bt_codec codec;
@@ -1150,10 +1150,9 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	BT_DBG("sk %p", sk);
 
 	if (level == SOL_SCO)
-		return sco_sock_getsockopt_old(sock, optname, optval, optlen);
+		return sco_sock_getsockopt_old(sock, optname, opt);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	lock_sock(sk);
 
@@ -1165,8 +1164,9 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *)optval))
+		val = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 
 		break;
@@ -1175,7 +1175,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		voice.setting = sco_pi(sk)->setting;
 
 		len = min_t(unsigned int, len, sizeof(voice));
-		if (copy_to_user(optval, (char *)&voice, len))
+		if (copy_to_iter(&voice, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -1188,13 +1188,15 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
 
-		if (put_user(phys, (u32 __user *) optval))
+		if (copy_to_iter(&phys, sizeof(phys), &opt->iter_out) !=
+		    sizeof(phys))
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
 
@@ -1205,7 +1207,9 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
+		val = sco_pi(sk)->conn->mtu;
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 		break;
 
@@ -1252,13 +1256,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			hci_dev_put(hdev);
 			return -ENOBUFS;
 		}
-		ptr = optval;
 
-		if (put_user(num_codecs, ptr)) {
+		if (copy_to_iter(&num_codecs, sizeof(num_codecs),
+				 &opt->iter_out) != sizeof(num_codecs)) {
 			hci_dev_put(hdev);
 			return -EFAULT;
 		}
-		ptr += sizeof(num_codecs);
 
 		/* Iterate all the codecs supported over SCO and populate
 		 * codec data
@@ -1275,11 +1278,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			if (err < 0)
 				break;
 			codec.num_caps = c->num_caps;
-			if (copy_to_user(ptr, &codec, sizeof(codec))) {
+			if (copy_to_iter(&codec, sizeof(codec), &opt->iter_out)
+			    != sizeof(codec)) {
 				err = -EFAULT;
 				break;
 			}
-			ptr += sizeof(codec);
 
 			/* find codec capabilities data length */
 			len = 0;
@@ -1289,11 +1292,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			}
 
 			/* copy codec capabilities data */
-			if (len && copy_to_user(ptr, c->caps, len)) {
+			if (len &&
+			    copy_to_iter(c->caps, len, &opt->iter_out) != len) {
 				err = -EFAULT;
 				break;
 			}
-			ptr += len;
 		}
 
 		hci_dev_unlock(hdev);
@@ -1301,8 +1304,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		lock_sock(sk);
 
-		if (!err && put_user(buf_len, optlen))
-			err = -EFAULT;
+		if (!err)
+			opt->optlen = buf_len;
 
 		break;
 
@@ -1577,7 +1580,7 @@ static const struct proto_ops sco_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= sco_sock_shutdown,
 	.setsockopt	= sco_sock_setsockopt,
-	.getsockopt	= sco_sock_getsockopt
+	.getsockopt_iter = sco_sock_getsockopt
 };
 
 static const struct net_proto_family sco_sock_family_ops = {

-- 
2.53.0-Meta


