Return-Path: <netdev+bounces-178849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40ACA79335
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8084173066
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026D1990BA;
	Wed,  2 Apr 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNJ98kdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F80198E75
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611309; cv=none; b=m5W7j2MeFsND93A3+pd9hb/BCob2DqzlEVhDayF+uAaR1LKRs/AGjbxVh40yPgaB/Exv1llUXwKc8o0ZuYcXUYbYe5oDumlm9RLwvcvSOuMv01vwdT1l4I4dl7CJCYnLcV5as1Oc9OwVPPa61sDKH/V6v1PP++Jc0imIR9BUEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611309; c=relaxed/simple;
	bh=ASGfdhX3k9dJLmVK1k3GHGI9EXnD92JevJJhXYn3e9U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rv5ySxDLYFpDjiyocN8Pgn90DVDKdYYexWW6DSxOYT95auj4HeP8Wlty+8LBnwgNHB0Nls+fCQ0W3rijXGkQ74r5J6CcK+zX/yQIZaSWaI5FHZfFl8Z9rl84ojdgCSceYs+/NCbpJMq1pI78cO2ThZjXt92qa7C9spF4RH3aI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNJ98kdl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a7aceeaso515165ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743611307; x=1744216107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11c1kNcqbP6MqoCK7+Gzq8Uhztec/eqhGAQKiMTpHok=;
        b=KNJ98kdlVckmj9UDWLgOgXRUrplBhUuOFWEhCE/1fO5v2e1YGa0hzBfqEAltgAlmrR
         kJv4+3+URgOORJ+aDPvFNpQ5y1iR5TWJfMf1idj78g1ArFSCX/okpvZbQ0Zfhq9fPaes
         8EuhugzZsp21hfBzPlaks80Y+dV1G3ymY2Z9jfbRQN89yZKwoXaE1sx8lFxfzRyIkgTI
         /Idw1kMME2mwGcUgTq5jI85iYGoIeSUo9vPk0lYhex+D+K6zw4AyMYzmBy7H8a2CawM7
         8+87+Cxv3tcvkbKD2/1YqbA+OtsCjTV9RCZpf/jfc5/Ku8YFwK9qlauBl3HRqawQMcMq
         RUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611307; x=1744216107;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11c1kNcqbP6MqoCK7+Gzq8Uhztec/eqhGAQKiMTpHok=;
        b=Cu0dw7m06zcM5uKYlPk4PR5GJwR3GkshwF7lK5criIRxbtRkNvmijlBnNHrAfrtQR7
         sD1r2GtVEic6knhNIgJuVS4X+UY8M0ZWgcEm4dvATT/QC2qn9Z+P3w/pH0ss2mGEb7y5
         xxsIFlGxLncn73235b0urA/ag9X9bjAp0fc4n/L/xETbKSX6AUWBjrV9mOhhbCbLMdO3
         FXcFHHrKhpLxiybfPdiNMD3mSurWOHelyMujDjwxfxhSINqe+0MXvVg0FaOwKM3h2KHg
         UalauThSRU0q7uhXGSUrHffjqxySmQg744DMo1BozJe3MDsD1YHXFluqnsdehxKmhnjn
         o7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXaszXD+QprTrYxwYAGEQfzAHOKVklB5B7YwFq/b4nQD7PzcoYzsjizWAV0sM6m5w73hT2Ql44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGOVj+vP7AYrQ2/LvxRetNZwl7wSq0qNQll5qiucm7Kcyk3Zr
	RkBD8jihirceNQQApsymouLiiQHG8HUZqU864bcydEhmLnzsb/Azmrp19VX1EgeR3sGofP9dhM+
	Rq/LplA==
X-Google-Smtp-Source: AGHT+IFWEVM26nWhKTmcRs27xc4x5P78/M0Gu8fFWKjc9MeSe72cY4HBNTUq235I7EmfHmHQKlBZ98YyeSEj
X-Received: from plpl14.prod.google.com ([2002:a17:903:3dce:b0:223:4c5f:3494])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2350:b0:223:628c:199
 with SMTP id d9443c01a7336-2292fa1adeemr222285535ad.52.1743611306858; Wed, 02
 Apr 2025 09:28:26 -0700 (PDT)
Date: Thu,  3 Apr 2025 00:26:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402162737.3271704-1-chharry@google.com>
Subject: [PATCH] Bluetooth: Introduce HCI Driver Packet
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
- Define the btusb driver command HCI_DRV_OP_SWITCH_ALT_SETTING which
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

 drivers/bluetooth/btusb.c       | 112 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_drv_pkt.h |  62 ++++++++++++++++++
 include/net/bluetooth/hci.h     |   1 +
 include/net/bluetooth/hci_mon.h |   2 +
 net/bluetooth/hci_core.c        |   2 +
 net/bluetooth/hci_sock.c        |  12 +++-
 6 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bluetooth/hci_drv_pkt.h

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5012b5ff92c8..644a0f13f8ee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -26,6 +26,7 @@
 #include "btbcm.h"
 #include "btrtl.h"
 #include "btmtk.h"
+#include "hci_drv_pkt.h"
 
 #define VERSION "0.8"
 
@@ -2151,6 +2152,111 @@ static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
 	return 0;
 }
 
+static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts);
+
+static int btusb_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *cmd_skb)
+{
+	struct hci_drv_cmd_hdr *hdr;
+	u16 opcode, cmd_len;
+
+	hdr = skb_pull_data(cmd_skb, sizeof(*hdr));
+	if (!hdr)
+		return -EILSEQ;
+
+	opcode = le16_to_cpu(hdr->opcode);
+	cmd_len = le16_to_cpu(hdr->len);
+	if (cmd_len != cmd_skb->len)
+		return -EILSEQ;
+
+	switch (opcode) {
+	case HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMMANDS: {
+		struct hci_drv_resp_read_supported_driver_commands *resp;
+		struct sk_buff *resp_skb;
+		struct btusb_data *data = hci_get_drvdata(hdev);
+		int ret;
+		u16 num_commands = 1; /* SUPPORTED_DRIVER_COMMANDS */
+
+		if (data->isoc)
+			num_commands++; /* SWITCH_ALT_SETTING */
+
+		resp_skb = hci_drv_skb_alloc(
+			opcode, sizeof(*resp) + num_commands * sizeof(__le16),
+			GFP_KERNEL);
+		if (!resp_skb)
+			return -ENOMEM;
+
+		resp = skb_put(resp_skb,
+			       sizeof(*resp) + num_commands * sizeof(__le16));
+		resp->status = HCI_DRV_STATUS_SUCCESS;
+		resp->num_commands = cpu_to_le16(num_commands);
+		resp->commands[0] =
+			cpu_to_le16(HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMMANDS);
+
+		if (data->isoc)
+			resp->commands[1] =
+				cpu_to_le16(HCI_DRV_OP_SWITCH_ALT_SETTING);
+
+		ret = hci_recv_frame(hdev, resp_skb);
+		if (ret)
+			return ret;
+
+		kfree_skb(cmd_skb);
+		return 0;
+	}
+	case HCI_DRV_OP_SWITCH_ALT_SETTING: {
+		struct hci_drv_cmd_switch_alt_setting *cmd;
+		struct hci_drv_resp_status *resp;
+		struct sk_buff *resp_skb;
+		int ret;
+		u8 status;
+
+		resp_skb = hci_drv_skb_alloc(opcode, sizeof(*resp), GFP_KERNEL);
+		if (!resp_skb)
+			return -ENOMEM;
+
+		cmd = skb_pull_data(cmd_skb, sizeof(*cmd));
+		if (!cmd || cmd_skb->len || cmd->new_alt > 6) {
+			status = HCI_DRV_STATUS_INVALID_PARAMETERS;
+		} else {
+			ret = btusb_switch_alt_setting(hdev, cmd->new_alt);
+			if (ret)
+				status = HCI_DRV_STATUS_UNSPECIFIED_ERROR;
+			else
+				status = HCI_DRV_STATUS_SUCCESS;
+		}
+
+		resp = skb_put(resp_skb, sizeof(*resp));
+		resp->status = status;
+
+		ret = hci_recv_frame(hdev, resp_skb);
+		if (ret)
+			return ret;
+
+		kfree_skb(cmd_skb);
+		return 0;
+	}
+	default: {
+		struct hci_drv_resp_status *resp;
+		struct sk_buff *resp_skb;
+		int ret;
+
+		resp_skb = hci_drv_skb_alloc(opcode, sizeof(*resp), GFP_KERNEL);
+		if (!resp_skb)
+			return -ENOMEM;
+
+		resp = skb_put(resp_skb, sizeof(*resp));
+		resp->status = HCI_DRV_STATUS_UNKNOWN_COMMAND;
+
+		ret = hci_recv_frame(hdev, resp_skb);
+		if (ret)
+			return ret;
+
+		kfree_skb(cmd_skb);
+		return 0;
+	}
+	}
+}
+
 static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -2192,6 +2298,9 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_DRV_PKT:
+		return btusb_drv_process_cmd(hdev, skb);
 	}
 
 	return -EILSEQ;
@@ -2669,6 +2778,9 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			return PTR_ERR(urb);
 
 		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_DRV_PKT:
+		return btusb_drv_process_cmd(hdev, skb);
 	}
 
 	return -EILSEQ;
diff --git a/drivers/bluetooth/hci_drv_pkt.h b/drivers/bluetooth/hci_drv_pkt.h
new file mode 100644
index 000000000000..800e0090f816
--- /dev/null
+++ b/drivers/bluetooth/hci_drv_pkt.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Google Corporation
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+
+struct hci_drv_cmd_hdr {
+	__le16	opcode;
+	__le16	len;
+} __packed;
+
+struct hci_drv_resp_hdr {
+	__le16	opcode;
+	__le16	len;
+} __packed;
+
+struct hci_drv_resp_status {
+	__u8	status;
+} __packed;
+
+#define HCI_DRV_STATUS_SUCCESS			0x00
+#define HCI_DRV_STATUS_UNSPECIFIED_ERROR	0x01
+#define HCI_DRV_STATUS_UNKNOWN_COMMAND		0x02
+#define HCI_DRV_STATUS_INVALID_PARAMETERS	0x03
+
+/* Common commands that make sense on all drivers start from 0x0000. */
+
+#define HCI_DRV_OP_READ_SUPPORTED_DRIVER_COMMANDS	0x0000
+struct hci_drv_resp_read_supported_driver_commands {
+	__u8	status;
+	__le16	num_commands;
+	__le16	commands[];
+} __packed;
+
+/* btusb specific commands start from 0x1135.
+ * No particular reason - It's my lucky number.
+ */
+
+#define HCI_DRV_OP_SWITCH_ALT_SETTING	0x1135
+struct hci_drv_cmd_switch_alt_setting {
+	__u8	new_alt;
+} __packed;
+
+static inline struct sk_buff *hci_drv_skb_alloc(u16 opcode, u16 plen, gfp_t how)
+{
+	struct hci_drv_resp_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + plen, how);
+	if (!skb)
+		return NULL;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->opcode = __cpu_to_le16(opcode);
+	hdr->len = __cpu_to_le16(plen);
+
+	hci_skb_pkt_type(skb) = HCI_DRV_PKT;
+
+	return skb;
+}
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
index 022b86797acd..428ee5c7de7e 100644
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
2.49.0.504.g3bcea36a83-goog


