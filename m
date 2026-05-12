Return-Path: <netdev+bounces-287105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKtiI5oLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C351F28A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4FAB302AB46
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7E4D2EC5;
	Tue, 12 May 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="icEEmoCy"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEF4CA277;
	Tue, 12 May 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584386; cv=none; b=WU9bkXMp5+gYsuteEyUO2t4oLxEVt5xVYWhvbRv/sSxTZuJ87lBaXLYnADH7U4Ezu3nlsiQ/kDBszlPDUyH7Nqv9Hx3tnILV1fyom+l6Y/0dGHP7/v7630p3PtwvLmpqkvmOnUxyk8oybJX4Kj9Sfi1OPGFGP2DK1MNhGTlRJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584386; c=relaxed/simple;
	bh=2v3FBFlG0XjBuZMc0nVvHHUoBstblBc5qcpRFYUU7T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndTc6izgPcFVKrqWEZlm1xD9EAXneew2ODQYGlWJyib+RF4qvsWyToGu9PojX0RpEBNPnyKYEkKqixglSaM7yRUDpX/fZEEXc/CPdVFCAIjaBOvxiM+VhdUY6UIQ6SjoTQVR21cQVa0llGhjE5dcGxfcsJIvUASUzB2M5hw3yM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=icEEmoCy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QAkqmhjFVXqkWVmRDV9dUjrCOzlfdfwg7GpIXw4OrOw=; b=icEEmoCyygM8noKLMoIRrvVITd
	CAWy7Ix6wAcbol/UrwbYgi9XyCxpqZzDNrJ45NqNvs3TZHLUjoyiXb8WhjgYDTXcY61abZk2+25lf
	ISCiv5iTtZ/oJBLz4b1P8vvMpMCFu9ayk2rS2PC/yY3e6Z9gS7o3WHpVeIk6yWJOK+hvHTfDml250
	48F4FSsWfsQEkdpulzGtXh8XQGNashq8JzVRiUIF7NRcg5pHMvnx9w0/fGq7TXO5234QGtxs1lEfA
	zx31i1EWNtSZiV59TfzhTl0RgAFzprB4ELhVj58qM27pz1dGcyeONCSk7YCAzY9jJx1zd8JNfa+Vo
	h7J5L7tw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2o-002Krf-2A;
	Tue, 12 May 2026 11:12:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 04:12:21 -0700
Subject: [PATCH net-next v2 6/6] Bluetooth: SCO: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-getsock_three-v2-6-30b7b22ef14c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6695; i=leitao@debian.org;
 h=from:subject:message-id; bh=2v3FBFlG0XjBuZMc0nVvHHUoBstblBc5qcpRFYUU7T4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsbU95wiOSOFMiV4tHtQrZCyd2DmUI0/pM7t
 XKE2/SqxLiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGwAKCRA1o5Of/Hh3
 bRMzD/wJzDebz0Li02MwVF4TMs59AVjzwFrtgjEJq20MwjMRhMZoKpt0vxFi3Ir84RvlEZhLJB7
 FMf9E9y80qvL5tu09zPhxHZyKXVQDDmkMfrHEFsZ8SI8nIJC/maBqrThR6vS38ty1UY6QeEOiz1
 AJaAstJsAeCP2aTv16VfSb6t9IXFEV+ke7xnPtgami7Q3LzyT0LLmtY8BBiHm8fd9LbFfBpE/5g
 QyRECgN5kRiIY9FsAApk+t2skz5k3Nl8dLUV0E6bwsSYsi7/cijCKTHPHLh5ew9dUoXPuTmFgEP
 J8nWAU/oRwmNoCy2/2XZXFek424oqCNWVkBjByfrmvQIYaqJZa2okR1y/pBGcJNswZcNVgZf86A
 uW1vYPHqwcIgZfyPAfsyAK+amehiXTwFRr3YaEVo47JoWxGLuICDLRC42aYE3tc4aZhaIZKKQeW
 kN7wjlSNteWQ7/XP98jXxbqUPOlqvd3gAmmnLpoNrLqzJB2+SVjX4Ktn+LDwR5glr53TNhxioFn
 yk4TIclgIi77EH427h3rdjNaxrPUPb0LFKii+B+36Aj4sYhknIoXm990bA8wXMPzNe7o4KnPJce
 viQQyYFh2hxpJBqx4X2F+1Pol3LbnaVZgHkLfv0O6MMMirrDy0nJXyQqh4EJH3tjf43LMhdqcWu
 cIMJ8iCVnQQfQjA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 599C351F28A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287105-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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


