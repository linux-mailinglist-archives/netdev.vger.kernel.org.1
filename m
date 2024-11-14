Return-Path: <netdev+bounces-145100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAC9C9627
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA141F2274F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199AC1B4F1A;
	Thu, 14 Nov 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="jYQUfgiT"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F15139CFA;
	Thu, 14 Nov 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627213; cv=none; b=IyyuKRoN8Z0Kk6pjjgFgWsg3BCBSjuUQpXkD1RInE17/M1FjeLMRwR8QOyUXUZ/6PR/YIbIiiVPcNQYbX+M3YgSlMLHJqIRjGVJ6p3b6xlXlxzL/xhwze9KYzDhzXSJ7gEbmz0V29TGubr2vjwxLX9ZnF1zZFGFh2bbNVuy0SKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627213; c=relaxed/simple;
	bh=XiVkAKZeNOXyxtB0/ouvIlxIsYq4rpFRwn2Uwvpa9m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XdQ/97eI8Y4Fryb7DijRqLnceZkEmcQULa+Z3ny7ZVrjbBbMu0p2oc/86e9xNSv7q2XNGdi3bh3bhdr9kzltR5yisOKoFjosIKXkS37u6cpPZXXD+KvezoSWpZ3Yb7Dl1aGWd3RRmJ9toFcxvJ0XRJNlsF8fX5jr7TA4ODcj9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=jYQUfgiT; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKu-005ygZ-6q; Fri, 15 Nov 2024 00:33:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=3Oz2/EjSsMROZvWyTEumvBbQl1eTzTAKrVZe7Su+TDU=; b=jYQUfgiTcNtuqoma9G7Q87QwkO
	Dnyu/pBPBxgJUQghUWRcFrmQqTfOzwg/TkMiY8LvuM/YZOvahZaRWZW2saPE7eXGHRcm9WpSIaRg5
	6Y1abzxtu8tNhUcX3FHqqvEIKldl+oOZ9jkCD2s4ZCI7FQ3ooNb/kQpWFSyX8KhazeOsJ0D8CDEho
	nFYsPM64JKSEkbryae2iAiHPea3KNct9Wp5oMWKxNNEkYHRk0CS6AXPvjmz7l78ujJJEQRG4pVq/B
	/asG+NHmBpbp2DdtWBe1sm/QIDj0eDK17GKwCEi//eY4yG4TVbglFiCVyt8eLbUrLZxu8ZoZalFVb
	QotCXvsQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKo-0004BT-Qx; Fri, 15 Nov 2024 00:33:10 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKP-008nXm-Iv; Fri, 15 Nov 2024 00:32:45 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 00:27:24 +0100
Subject: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

The bt_copy_from_sockptr() return value is being misinterpreted by most
users: a non-zero result is mistakenly assumed to represent an error code,
but actually indicates the number of bytes that could not be copied.

Remove bt_copy_from_sockptr() and adapt callers to use
copy_safe_from_sockptr().

For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
scrub parts of uninitialized buffer.

Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
and hci_sock_setsockopt().

Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/net/bluetooth/bluetooth.h |  9 ---------
 net/bluetooth/hci_sock.c          | 14 +++++++-------
 net/bluetooth/iso.c               | 10 +++++-----
 net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
 net/bluetooth/rfcomm/sock.c       |  9 ++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 6 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f66bc85c6411dd5d49eca7756577fea05feaf144..e6760c11f007752ff05792f1de09b70bfb57213c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -590,15 +590,6 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	return skb;
 }
 
-static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
-				       sockptr_t src, size_t src_size)
-{
-	if (dst_size > src_size)
-		return -EINVAL;
-
-	return copy_from_sockptr(dst, src, dst_size);
-}
-
 int bt_to_errno(u16 code);
 __u8 bt_status(int err);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2272e1849ebd894a6b83f665d8fa45610778463c..022b86797acdc56a6e9b85f24f4c98a0247831c9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1926,7 +1926,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
-				   sockptr_t optval, unsigned int len)
+				   sockptr_t optval, unsigned int optlen)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -1943,7 +1943,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1954,7 +1954,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 		break;
 
 	case HCI_TIME_STAMP:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1974,7 +1974,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 			uf.event_mask[1] = *((u32 *) f->event_mask + 1);
 		}
 
-		err = bt_copy_from_sockptr(&uf, sizeof(uf), optval, len);
+		err = copy_safe_from_sockptr(&uf, sizeof(uf), optval, optlen);
 		if (err)
 			break;
 
@@ -2005,7 +2005,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-			       sockptr_t optval, unsigned int len)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -2015,7 +2015,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	if (level == SOL_HCI)
 		return hci_sock_setsockopt_old(sock, level, optname, optval,
-					       len);
+					       optlen);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
@@ -2035,7 +2035,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			goto done;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7a83e400ac77a0a0df41b206643bae6fc031631b..5f278971d7fa25b32b6f70a5fc5a7500db0fdc99 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1503,7 +1503,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1514,7 +1514,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1533,7 +1533,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		err = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
 		if (err)
 			break;
 
@@ -1554,8 +1554,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(iso_pi(sk)->base, optlen, optval,
-					   optlen);
+		err = copy_safe_from_sockptr(iso_pi(sk)->base, optlen, optval,
+					     optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee591a5624f5fbfbf28f2a80d399372..5ab203b55ab7e2c0682349a6eab9620e3e8a024c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -755,7 +755,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		err = copy_safe_from_sockptr(&opts, sizeof(opts), optval,
+					     optlen);
 		if (err)
 			break;
 
@@ -800,7 +801,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -909,7 +910,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
 		if (err)
 			break;
 
@@ -956,7 +957,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -970,7 +971,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1004,7 +1005,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		err = copy_safe_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
 		if (err)
 			break;
 
@@ -1015,7 +1016,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1046,7 +1047,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		err = copy_safe_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
 		if (err)
 			break;
 
@@ -1076,7 +1077,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		err = copy_safe_from_sockptr(&mode, sizeof(mode), optval,
+					     optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & RFCOMM_LM_FIPS) {
 			err = -EINVAL;
@@ -685,7 +684,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
 		if (err)
 			break;
 
@@ -703,7 +702,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1c7252a3686694284b0b1e1101e3d16b90d906c4..700abb639a554521b9b5d46298d5ed926d228470 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -853,7 +853,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -872,8 +872,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		voice.setting = sco_pi(sk)->setting;
 
-		err = bt_copy_from_sockptr(&voice, sizeof(voice), optval,
-					   optlen);
+		err = copy_safe_from_sockptr(&voice, sizeof(voice), optval,
+					     optlen);
 		if (err)
 			break;
 
@@ -898,7 +898,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -941,7 +941,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(buffer, optlen, optval, optlen);
+		err = copy_struct_from_sockptr(buffer, sizeof(buffer), optval,
+					       optlen);
 		if (err) {
 			hci_dev_put(hdev);
 			break;

-- 
2.46.2


