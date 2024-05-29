Return-Path: <netdev+bounces-98890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9F8D2F12
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C651F23187
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20E6D1AB;
	Wed, 29 May 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCW7ykqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771129406
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969693; cv=none; b=sDDS7b2nGOoaNTXXF6XNJyfk2iVyveqS0oPt0g6urt8na49bkBedT54u4XsjZdOW+VL1NEk4mmEhaXA5VSJFnEz2bg//VGKndHzyNbWkG6qGwAHUiSrcRaSAE7Sh8D0uO1UfQmErQRFtO2WmuVl5HlXf24tDU1asUsFYHk+HsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969693; c=relaxed/simple;
	bh=zym3tUwtiYR8zYQgibS2+Y150IoTCHY5DOSeSq7T3eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ee3/6CiBYdJchnRcL35pqog1SoBfqUSMi1VCQbCDnrBiOdzbzXIFMRIIo/8AWbb/3S5jX49NPO18pKgtPceOPLTmvgBdr2M8v4xE9ZsJTDFZ1Q2oqug5WIvAOWnK3yMe5Sq+Qw2omf/1q0PGuOd867+AYjOAFKN39y6UCdZUhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gCW7ykqr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so1450648a91.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716969691; x=1717574491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVq2KJ9dea8wW5boM9m8tHQKn0zHGu+v5LBWfvftWo4=;
        b=gCW7ykqrmBCaqxlE5FhEJUR2CPudlMfs2P++YuTBLw68Lm40PtdlYMGazahdhYHFyN
         WSJ83FMaZpgq3nUfI6uSLRqz7/bRA5GBC65dVChXKS4prLZ5FCnwMuerVfv0yQqRocpy
         ddhVmVU6q57X/KSZ4MuxzSzPXpCNwf1mGEIGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969691; x=1717574491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVq2KJ9dea8wW5boM9m8tHQKn0zHGu+v5LBWfvftWo4=;
        b=pNOdHZ6XhqQJJYBCgwrvCN43JmWrT3fx2gpFdnF7PusWf9c72KiyFMufOlhYuFe1Y9
         lsY0jqTZyQIbgYfoQ9So3tZI8S9QcLzO1sp7rVOA7U39iOFe21l+sgIP1iCFsWRShhFx
         LDvIon0klv9H2b9yig3FmvW+rDLXRA64G4ug6g31jXq8ClJwGOZiyg4cnw8f8Ic49Dkf
         WiHAkCQmObAh2PSQ7fnQzU1vGd8h4La7TXRRqeiMEmZCUVLTHwZv9gGfgZEXd/wDHJZi
         uXxzDUMXIWIc5P1+rqKbSLcJhA0OGGFD3H5WzHG0+YBPb6+0Ul57q/Z0rHyfWw1CBreM
         UUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXWMCTZyAD8IqqFmCJg4XGHiK0QNjAGph9f0rRClvJQ2gnQlll78FXAV2FKpeH6CrsC2BysIwxmiPvOuNFtVJK+hHWjtxcD
X-Gm-Message-State: AOJu0YwR6eSzev+eRbLGXvT9QkFKX8VzODJJKpCno8JllsKT8un45GgP
	ueZ1y/scCjkYhzUUUxqHTkW1ioTxThHmVjuGAfpRG/RXB2gXzwkjZwLBTKWjiQ==
X-Google-Smtp-Source: AGHT+IFJIBHO9vbLZGX06VSoaM42TaXLOL5RDP14AaDs4hAwKfUErS+OgMbuv7sPgrV09hcryjaVfw==
X-Received: by 2002:a17:90b:182:b0:2c1:424c:1721 with SMTP id 98e67ed59e1d1-2c1424c1a3emr327872a91.3.1716969690812;
        Wed, 29 May 2024 01:01:30 -0700 (PDT)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2bfa0222b3fsm6658020a91.30.2024.05.29.01.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:01:30 -0700 (PDT)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	horms@kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Add vendor-specific packet classification for ISO data
Date: Wed, 29 May 2024 08:00:00 +0000
Message-ID: <20240529080123.2146946-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HCI raw sockets are opened, the Bluetooth kernel module doesn't
track CIS/BIS connections. User-space applications have to identify
ISO data by maintaining connection information and look up the mapping
for each ACL data packet received. Besides, btsnoop log captured in
kernel couldn't tell ISO data from ACL data in this case.

To avoid additional lookups, this patch introduces vendor-specific
packet classification for Intel BT controllers to distinguish
ISO data packets from ACL data packets.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested LE audio unicast recording on a ChromeOS device with Intel AX211

Changes in v4:
- Only register classify_pkt_type on AX211 (GfP2) and BE200 (GaP).

Changes in v3:
- Move Intel's classify_pkt_type implementation from btusb.c to btintel.c.

Changes in v2:
- Adds vendor-specific packet classificaton in hci_dev.
- Keeps reclassification in hci_recv_frame.

 drivers/bluetooth/btintel.c      | 25 +++++++++++++++++++++++--
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 27e03951e68b..ff33e1aa2929 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2549,6 +2549,24 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 	data->acpi_reset_method = btintel_acpi_reset_method;
 }
 
+#define BTINTEL_ISODATA_HANDLE_BASE 0x900
+
+static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/*
+	 * Distinguish ISO data packets form ACL data packets
+	 * based on their connection handle value range.
+	 */
+	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)
+			return HCI_ISODATA_PKT;
+	}
+
+	return hci_skb_pkt_type(skb);
+}
+
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
@@ -2989,11 +3007,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		err = btintel_bootloader_setup(hdev, &ver);
 		btintel_register_devcoredump_support(hdev);
 		break;
+	case 0x18: /* GfP2 */
+	case 0x1c: /* GaP */
+		/* Re-classify packet type for controllers with LE audio */
+		hdev->classify_pkt_type = btintel_classify_pkt_type;
+		fallthrough;
 	case 0x17:
-	case 0x18:
 	case 0x19:
 	case 0x1b:
-	case 0x1c:
 	case 0x1e:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9231396fe96f..7b7068a84ff7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -649,6 +649,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3ee9ff17624..8b817a99cefd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);
 
+static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (hdev->classify_pkt_type)
+		return hdev->classify_pkt_type(hdev, skb);
+
+	return hci_skb_pkt_type(skb);
+}
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	u8 dev_pkt_type;
+
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
 
+	/* Check if the driver agree with packet type classification */
+	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
+	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
+		hci_skb_pkt_type(skb) = dev_pkt_type;
+	}
+
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
-- 
2.45.1.288.g0e0cd299f1-goog


