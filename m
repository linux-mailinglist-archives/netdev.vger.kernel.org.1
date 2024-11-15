Return-Path: <netdev+bounces-145261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C509CDFD0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B73B2524D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2C1C232B;
	Fri, 15 Nov 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Y2ZqxBpU"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E11C07E0;
	Fri, 15 Nov 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676997; cv=none; b=AxRkNp3tj0g42wRVZq4QJ8ZQkTb8h9c9qRnnaRzUeopmuX4Qc7RtZwVzZwQkhHBELw+zTNJ9F4QC/jYr2oYp8a0LNS6DM90CuzjWErmGgD6042nQxf0Rjbx29CA0pPsp0p4lIfxsQQs0TTZTGRbrzSPGM5TuzFVEUqOgdxEWcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676997; c=relaxed/simple;
	bh=R0e2lD9hYGen4Y8VTZ7bCGsqmYxvts7UG7DMdpEEVqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HY4BnOBuVwSvH+6fHssqS4GwpKdiUmXsrDsbyWhZ9GDx+t7PVaTv4nmcCPkwncKAQlcNvLMcQNxv4Vis64gRM78BogkpWclT4OSnLZ14/VFjlei89479O0ZeeiCr7Gp+EkjZr42EqZCinfkly+aKeCYu33gVlIpye4HrC4pjBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Y2ZqxBpU; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHz-007mgo-VL; Fri, 15 Nov 2024 14:23:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=t2tsciqjgCdRIWyolIsU3qlfT2M4ZG2x2AeURI07ryw=; b=Y2ZqxBpUIpCzdrJ2WQ0KRE7oT4
	764Ue+xFhAjFgSiewhDZj7KDXAEuVBG6R6uDh/Vwz91YPny6YIzoyWbnDeaBLeRrIfRBydf5sQ1wt
	oPeoWH22dfSZVE2Vg9h/4WZT5n5IiHmaVc7hrUjT3X5f9jtoSHHbq+ivYzg1U8zu4wjF2J41JNMgN
	rSUaLlM3R07DTG4Z7QjwUWgsugH2qprnel7JDfc03v8nUVAXCh7512Zp30VL1rV/yrXWyMqjKPjog
	wfbjPUmwJpsEQQE45mOPt5ngMKmWfsNDvYnvlR/bsx7XyulIwML5Hpgdu2RYhIMT91kOepTepDdb6
	4rx9LK+Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHz-0001ov-JI; Fri, 15 Nov 2024 14:23:07 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwHi-00BIK5-4P; Fri, 15 Nov 2024 14:22:50 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 14:21:40 +0100
Subject: [PATCH net v2 1/4] Bluetooth: Improve setsockopt() handling of
 malformed user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v2-1-9b1254c18b7a@rbox.co>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
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
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
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


