Return-Path: <netdev+bounces-178606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F130FA77C7C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38E616AF44
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302D1E47B3;
	Tue,  1 Apr 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2OyV5Rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E4202C26
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515072; cv=none; b=BSwABbjOEax+Lq7a3i2VnouUN0LRF9oqSnNmAVCAM9A7XXGwO3aecBlU2dKwqzHnjlJRFl/t8TEo2nSnNJ+soxIrYMlJ/ORs5ml28Ok9CoJji2QSf0j0L0wJldfCb98nGrBw0q7lSSMuXnmE3MOEN6HCKKoHZay1rcEmP3FlZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515072; c=relaxed/simple;
	bh=8bpp/MaW8+ZTtpUqf2IhtZcsfdQiRx/Eafa08qoqHbo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q0U5jw7XftZNR4E7pKmSwFLzD792K/Dy873OkA5roDp1uxI4IOd7qJ+vGdcUoy3BXZ+hfbxtui3/6B+jQqQVVVr1xmO2G9xHEas3MCIep1DueIT19SdBJLo0wBjO2ViRd7GyX4mGKOrOm5iM85SWcIUJ/A9Psbz/xtABMknp1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2OyV5Rq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3054210ce06so8683924a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743515070; x=1744119870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZyEbqOkrSD6TU4NwMw2CtJ+zlTXsk1fSPsK0Ogdp3/c=;
        b=U2OyV5Rqw8FO3nK2Kw6mr0+FS0XOL2u/CvjZ0uwKKRWZb17Cs5xuqJ465s6hFQ66Bl
         K7R30hUZez+z3LX5FPn5UueO6tFMvJULtD49dHxbm8nwjOo7MeI9Np/6TYZ+827HIyia
         H1MW4iPPWsxfvJ5ZlaVOjF8i42Qamwj2U3e841Uu7mdKAl/hZ2P/CFkJPtqYE5EgrtzF
         d17VRfSNnfqiVHQccqG1lGI8VnDmv+WC0wTLnVd+dF+OijM62VVIreoOnYjqvNl016SV
         UxoVFVYmEql3rdsnGZyeWRfxOMOxT8OHplycNT/IU/hDtQM7GTUDoCCrDzmTwuAfj3jm
         sUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515070; x=1744119870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyEbqOkrSD6TU4NwMw2CtJ+zlTXsk1fSPsK0Ogdp3/c=;
        b=RnRcd/xEVug3Tr1KoakAWxCOrOkZq1iG6ovEZDp13d4BOYlTOxiEO6vMHAn2sCUhlq
         ie1sIvQOuySQ/aLucB7Mq03+ZmoSNRYRha/znE4QNYg3JrRpsSLIHQGqXCuhQuiZta31
         55DvzlsAe+iP+7yEWW/+N0YEzED+W0in4aYLR/N8NR/TIWsE7AKcSyioiTvlAw/lJ6cs
         gOGZy6uonZ+iB9ZYp4cWqRybucIBv50r2Yzbg3vd2pWglHyTGTKjKFlZsIF/uKc36EwO
         2MkfbdDzHkWyB+1MXbpjQfRpFOT8CNWMJtnuG91r20qyLjJ7nQuiFbIyFmVty8EPvCqH
         3FGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwYQUa2Hn8iOo+8kJ/uS5x0Wkr3x/wDw8Ue+ghm2SOkwy25VC5qgadD1QaA5Z10TqCHgzc4Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkEGbok/ntTGr5e1+cjidZ1amn8hQxqLR+QT6Qk7LR66hxC4t
	MO2ncCQAOeGM6qT5zb0MflxowtVU6vPrEQDYrL/jcUF93SehFR+X1i/mvXXzRjcDMmrc8FtgKvj
	pg1GJpA==
X-Google-Smtp-Source: AGHT+IHdNj17IzfPxuNN9wWBGf+SCwwzrruftH70/zxd2bKdhdb2VT0VeYc7kAxS7tGQlGM1MK8F7pOfJkAn
X-Received: from pjp4.prod.google.com ([2002:a17:90b:55c4:b0:2ea:3a1b:f493])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:2fe:a515:4a98
 with SMTP id 98e67ed59e1d1-3053217848bmr18928134a91.31.1743515069900; Tue, 01
 Apr 2025 06:44:29 -0700 (PDT)
Date: Tue,  1 Apr 2025 21:44:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401134424.3725875-1-chharry@google.com>
Subject: [PATCH] Bluetooth: Add driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
SCO data through USB Bluetooth chips, it's observed that with the patch
HFP is flaky on most of the existing USB Bluetooth controllers: Intel
chips sometimes send out no packet for Transparent codec; MTK chips may
generate SCO data with a wrong handle for CVSD codec; RTK could split
the data with a wrong packet size for Transparent codec; ... etc.

To address the issue above one needs to reset the altsetting back to
zero when there is no active SCO connection, which is the same as the
BlueZ behavior, and another benefit is the bus doesn't need to reserve
bandwidth when no SCO connection.

This patch introduces a fundamental solution that lets the user space
program to configure the altsetting freely:
- Define the new packet type HCI_DRV_PKT which is specifically used for
  communication between the user space program and the Bluetooth drviers
- Define the btusb driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING which
  indicates the expected altsetting from the user space program
- btusb intercepts the command and adjusts the Isoc endpoint
  correspondingly

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3, and TRANS alt6) could pass the stress HFP test narrow
band speech and wide band speech.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c       | 67 +++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h     |  1 +
 include/net/bluetooth/hci_mon.h |  2 +
 net/bluetooth/hci_core.c        |  2 +
 net/bluetooth/hci_sock.c        | 14 +++++--
 5 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5012b5ff92c8..a7bc64e86661 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2151,6 +2151,67 @@ static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
 	return 0;
 }
 
+static struct sk_buff *btusb_drv_response(u8 opcode, size_t data_len)
+{
+	struct sk_buff *skb;
+
+	/* btusb driver response starts with 1 oct of the opcode,
+	 * and followed by the command specific data.
+	 */
+	skb = bt_skb_alloc(1 + data_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_put_u8(skb, opcode);
+	hci_skb_pkt_type(skb) = HCI_DRV_PKT;
+
+	return skb;
+}
+
+static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts);
+
+#define BTUSB_DRV_CMD_SWITCH_ALT_SETTING 0x35
+
+static int btusb_drv_cmd(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* btusb driver command starts with 1 oct of the opcode,
+	 * and followed by the command specific data.
+	 */
+	if (!skb->len)
+		return -EILSEQ;
+
+	switch (skb->data[0]) {
+	case BTUSB_DRV_CMD_SWITCH_ALT_SETTING: {
+		struct sk_buff *resp;
+		int status;
+
+		/* Response data: Total 1 Oct
+		 *   Status: 1 Oct
+		 *     0 = Success
+		 *     1 = Invalid command
+		 *     2 = Other errors
+		 */
+		resp = btusb_drv_response(BTUSB_DRV_CMD_SWITCH_ALT_SETTING, 1);
+		if (!resp)
+			return -ENOMEM;
+
+		if (skb->len != 2 || skb->data[1] > 6) {
+			status = 1;
+		} else {
+			status = btusb_switch_alt_setting(hdev, skb->data[1]);
+			if (status)
+				status = 2;
+		}
+		skb_put_u8(resp, status);
+
+		kfree_skb(skb);
+		return hci_recv_frame(hdev, resp);
+	}
+	}
+
+	return -EILSEQ;
+}
+
 static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -2192,6 +2253,9 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_DRV_PKT:
+		return btusb_drv_cmd(hdev, skb);
 	}
 
 	return -EILSEQ;
@@ -2669,6 +2733,9 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_DRV_PKT:
+		return btusb_drv_cmd(hdev, skb);
 	}
 
 	return -EILSEQ;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a8586c3058c7..e297b312d2b7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -494,6 +494,7 @@ enum {
 #define HCI_EVENT_PKT		0x04
 #define HCI_ISODATA_PKT		0x05
 #define HCI_DIAG_PKT		0xf0
+#define HCI_DRV_PKT		0xf1
 #define HCI_VENDOR_PKT		0xff
 
 /* HCI packet types */
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 082f89531b88..bbd752494ef9 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -51,6 +51,8 @@ struct hci_mon_hdr {
 #define HCI_MON_CTRL_EVENT	17
 #define HCI_MON_ISO_TX_PKT	18
 #define HCI_MON_ISO_RX_PKT	19
+#define HCI_MON_DRV_TX_PKT	20
+#define HCI_MON_DRV_RX_PKT	21
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..bb4e1721edc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2911,6 +2911,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	case HCI_ISODATA_PKT:
 		break;
+	case HCI_DRV_PKT:
+		break;
 	default:
 		kfree_skb(skb);
 		return -EINVAL;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 022b86797acd..0bc4f77ed17b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -234,7 +234,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT)
+			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_DRV_PKT)
 				continue;
 		} else {
 			/* Don't send frame to other channel types */
@@ -391,6 +392,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			opcode = cpu_to_le16(HCI_MON_ISO_TX_PKT);
 		break;
+	case HCI_DRV_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_DRV_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_DRV_TX_PKT);
+		break;
 	case HCI_DIAG_PKT:
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
 		break;
@@ -1806,7 +1813,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	if (len < 4 || len > hci_pi(sk)->mtu)
+	if (len > hci_pi(sk)->mtu)
 		return -EINVAL;
 
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
@@ -1860,7 +1867,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (hci_skb_pkt_type(skb) != HCI_COMMAND_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
-		    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT) {
+		    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_DRV_PKT) {
 			err = -EINVAL;
 			goto drop;
 		}
-- 
2.49.0.472.ge94155a9ec-goog


