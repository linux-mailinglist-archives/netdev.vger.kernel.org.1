Return-Path: <netdev+bounces-183204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7AA8B61A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFF74445A3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D14226D15;
	Wed, 16 Apr 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtUlhWKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B5238C00
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797313; cv=none; b=L4DocLK0eFLfK7/NGH4WHgZTIw89aBFkT8hflRyIHy7pZru5uQCrDntHQlDXU/2dEIRDvowqfd8ZAB11ngGtJ/jmomKOfpP5omxMahz3wBKHj1rtmgWm/MhlSPo2ztfA7SBgzFWpDl5+1c6dG5cW5pZ63sr3n02gk+O8UHfDKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797313; c=relaxed/simple;
	bh=AmixYYDH1ZKvvrGtK8hvhxMkDVtSKsVn6a+Mo+h0VmA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/uboWMCylNA2BAyzdM5i/yyFl0fWlpQjqdEzF1bxBFNe5FR2iQ37NVBWv1C9iYWf1xEcyZk2vNgCKBcab/X5Y29426DYcMzyuRJA+2XeRE1DMPirZPb+Pcjs7Ia1GMvgDcxQQWEmk3BgJNISVRHpox+0vmGK1cUGDlwbch+PkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtUlhWKG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22651aca434so55026295ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744797311; x=1745402111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=InEo4fDcRL9q31V6DTrhwJjfPEkjK1fc2RFFHanel/w=;
        b=QtUlhWKGZG5pKFHWMHY3mgzFldxvj2mhQ4Onx1ED6bC+R04mckvU9JyV40Ippo98w2
         x2m6kMilScmneBw6WQWcCPDuC9G6g/MBpOLZOZn5Fm7gZcVHK9uv9nWTgFn6Dx5ILG8X
         R7VQ14tctwwHFrLfLvki21WqNrizlDTCf96+71XZxkKt2HIp+b0gvweI9er/QLn+om9O
         I5woub+FIkvF09H3CvXefyq40trUI3P4sPSvZWQWHx77UwXQHJ/7jTSs1hk0uHiIQjNz
         fYeJL/DDEriNG7y3tDUPyLqlRwsUFVcz8DnkV+3Ljpmz7o++Jx7Ia/p6ikFwPuEJsFII
         J8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797311; x=1745402111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InEo4fDcRL9q31V6DTrhwJjfPEkjK1fc2RFFHanel/w=;
        b=xE9kERY5vlxdRCp5WkEcoDGG75aXiLx/sg/uiFg+8dehH0XP4GyYcvcGh6lWsdvzL0
         jI9i3JJiAEcqmog6QRRS2bTaKZqYwbmYSZ02Rg3sK1UPkjZ1afMGJO2yWgneN/IZwtP8
         eKF6vrZRJskrNHQUUaDl2K2dAuzy7dnRK4t235JKCl/7NMNuQncxbDA4peTNacOBY2/t
         hL+iNfDO3aRkr95e4w37dlOvlpDkUjsN2luP6PfQKt4dpfjexYYYRrxXK5vvaDTZH7lm
         Tr5L2QEsmgayh6cbMCfRsX6PNtP0iL8Op2PSHMEUgE3dXBJfLzUdNjNvZeSk7KSgfH/B
         6sMA==
X-Forwarded-Encrypted: i=1; AJvYcCWZHfZjXeF+ha047W5nPGBqDzZFCmXAjkWnd0RnwdrxaS+1lkZ7OR1cG1mvu/voggXpJzv4K4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCzjS0qort0YgXqR5SJ+3EUhnSTpp4Y+gFiHaGdObU8CYbi55
	jnClnRw5LYeXrijq74e+9LRlLZYnFvFqk2hc0E6FPmtwKbjIUivfjeNvxiWLW40ng7qKqJkTWWr
	izdoBlg==
X-Google-Smtp-Source: AGHT+IGlWFEHgcXVhtD8bhrbBEorI+mmSq2kg9Nl2j3VREL+nCdIzhb+JaqrWa/36cmimrphtXHeb9bFV40l
X-Received: from plqw3.prod.google.com ([2002:a17:902:a703:b0:220:da6b:5d08])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3284:b0:220:e338:8d2
 with SMTP id d9443c01a7336-22c358ddb8bmr15086005ad.21.1744797310972; Wed, 16
 Apr 2025 02:55:10 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:53:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416095505.769906-1-chharry@google.com>
Subject: [PATCH v2 1/4] Bluetooth: Introduce HCI Driver protocol
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

This patch adds the infrastructure that allow the user space program to
talk to Bluetooth drivers directly:
- Define the new packet type HCI_DRV_PKT which is specifically used for
  communication between the user space program and the Bluetooth drviers
- hci_send_frame intercepts the packets and invokes drivers' HCI Drv
  callbacks (so far only defined for btusb)
- 2 kinds of events to user space: Command Status and Command Complete,
  the former simply returns the status while the later may contain
  additional response data.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v2:
- Specifying drvier specific commands by hci_opcode_ogf

 drivers/bluetooth/btusb.c        |  69 ++++++++++++++++++--
 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   3 +
 include/net/bluetooth/hci_drv.h  |  76 ++++++++++++++++++++++
 include/net/bluetooth/hci_mon.h  |   2 +
 net/bluetooth/Makefile           |   3 +-
 net/bluetooth/hci_core.c         |  10 +++
 net/bluetooth/hci_drv.c          | 104 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c         |  12 +++-
 9 files changed, 271 insertions(+), 9 deletions(-)
 create mode 100644 include/net/bluetooth/hci_drv.h
 create mode 100644 net/bluetooth/hci_drv.c

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a9b89bcea22..79a944cdb662 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -21,6 +21,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_drv.h>
 
 #include "btintel.h"
 #include "btbcm.h"
@@ -3754,6 +3755,61 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+static const struct {
+	u16 opcode;
+	const char *desc;
+} btusb_hci_drv_supported_commands[] = {
+	/* Common commands */
+	{ HCI_DRV_OP_READ_INFO, "Read Info" },
+};
+static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
+				   u16 data_len)
+{
+	struct hci_drv_rp_read_info *rp;
+	size_t rp_size;
+	int err, i;
+	u16 opcode, num_supported_commands =
+		ARRAY_SIZE(btusb_hci_drv_supported_commands);
+
+	rp_size = sizeof(*rp) + num_supported_commands * 2;
+
+	rp = kmalloc(rp_size, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	strscpy_pad(rp->driver_name, btusb_driver.name);
+
+	rp->num_supported_commands = cpu_to_le16(num_supported_commands);
+	for (i = 0; i < num_supported_commands; i++) {
+		opcode = btusb_hci_drv_supported_commands[i].opcode;
+		bt_dev_info(hdev,
+			    "Supported HCI Drv command (0x%02x|0x%04x): %s",
+			    hci_opcode_ogf(opcode),
+			    hci_opcode_ocf(opcode),
+			    btusb_hci_drv_supported_commands[i].desc);
+		rp->supported_commands[i] = cpu_to_le16(opcode);
+	}
+
+	err = hci_drv_cmd_complete(hdev, HCI_DRV_OP_READ_INFO,
+				   HCI_DRV_STATUS_SUCCESS, rp, rp_size);
+
+	kfree(rp);
+	return err;
+}
+
+static const struct hci_drv_handler btusb_hci_drv_common_handlers[] = {
+	{ btusb_hci_drv_read_info,	HCI_DRV_READ_INFO_SIZE },
+};
+
+static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] = {};
+
+static struct hci_drv btusb_hci_drv = {
+	.common_handler_count	= ARRAY_SIZE(btusb_hci_drv_common_handlers),
+	.common_handlers	= btusb_hci_drv_common_handlers,
+	.specific_handler_count	= ARRAY_SIZE(btusb_hci_drv_specific_handlers),
+	.specific_handlers	= btusb_hci_drv_specific_handlers,
+};
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3893,12 +3949,13 @@ static int btusb_probe(struct usb_interface *intf,
 		data->reset_gpio = reset_gpio;
 	}
 
-	hdev->open   = btusb_open;
-	hdev->close  = btusb_close;
-	hdev->flush  = btusb_flush;
-	hdev->send   = btusb_send_frame;
-	hdev->notify = btusb_notify;
-	hdev->wakeup = btusb_wakeup;
+	hdev->open    = btusb_open;
+	hdev->close   = btusb_close;
+	hdev->flush   = btusb_flush;
+	hdev->send    = btusb_send_frame;
+	hdev->notify  = btusb_notify;
+	hdev->wakeup  = btusb_wakeup;
+	hdev->hci_drv = &btusb_hci_drv;
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5115da34f881..dd80f1a398be 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -31,6 +31,7 @@
 #include <linux/rculist.h>
 
 #include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_drv.h>
 #include <net/bluetooth/hci_sync.h>
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/coredump.h>
@@ -613,6 +614,8 @@ struct hci_dev {
 	struct list_head	monitored_devices;
 	bool			advmon_pend_notify;
 
+	struct hci_drv		*hci_drv;
+
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
 #endif
diff --git a/include/net/bluetooth/hci_drv.h b/include/net/bluetooth/hci_drv.h
new file mode 100644
index 000000000000..2f01c44f05ec
--- /dev/null
+++ b/include/net/bluetooth/hci_drv.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Google Corporation
+ */
+
+#ifndef __HCI_DRV_H
+#define __HCI_DRV_H
+
+#include <linux/types.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+
+struct hci_drv_cmd_hdr {
+	__le16	opcode;
+	__le16	len;
+} __packed;
+
+struct hci_drv_ev_hdr {
+	__le16	opcode;
+	__le16	len;
+} __packed;
+
+#define HCI_DRV_EV_CMD_STATUS	0x0000
+struct hci_drv_ev_cmd_status {
+	__le16	opcode;
+	__u8	status;
+} __packed;
+
+#define HCI_DRV_EV_CMD_COMPLETE	0x0001
+struct hci_drv_ev_cmd_complete {
+	__le16	opcode;
+	__u8	status;
+	__u8	data[];
+} __packed;
+
+#define HCI_DRV_STATUS_SUCCESS			0x00
+#define HCI_DRV_STATUS_UNSPECIFIED_ERROR	0x01
+#define HCI_DRV_STATUS_UNKNOWN_COMMAND		0x02
+#define HCI_DRV_STATUS_INVALID_PARAMETERS	0x03
+
+#define HCI_DRV_MAX_DRIVER_NAME_LENGTH	32
+
+/* Common commands that make sense on all drivers start from 0x0000 */
+#define HCI_DRV_OP_READ_INFO	0x0000
+#define HCI_DRV_READ_INFO_SIZE	0
+struct hci_drv_rp_read_info {
+	__u8	driver_name[HCI_DRV_MAX_DRIVER_NAME_LENGTH];
+	__le16	num_supported_commands;
+	__le16	supported_commands[];
+} __packed;
+
+/* Driver specific OGF (Opcode Group Field)
+ * Commands in this group may have different meanings across different drivers.
+ */
+#define HCI_DRV_OGF_DRIVER_SPECIFIC	0x01
+
+int hci_drv_cmd_status(struct hci_dev *hdev, u16 cmd, u8 status);
+int hci_drv_cmd_complete(struct hci_dev *hdev, u16 cmd, u8 status, void *rp,
+			 size_t rp_len);
+int hci_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *cmd_skb);
+
+struct hci_drv_handler {
+	int (*func)(struct hci_dev *hdev, void *data, u16 data_len);
+	size_t data_len;
+};
+
+struct hci_drv {
+	size_t common_handler_count;
+	const struct hci_drv_handler *common_handlers;
+
+	size_t specific_handler_count;
+	const struct hci_drv_handler *specific_handlers;
+};
+
+#endif /* __HCI_DRV_H */
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
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 5a3835b7dfcd..a7eede7616d8 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -14,7 +14,8 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	ecdh_helper.o mgmt_util.o mgmt_config.o hci_codec.o eir.o hci_sync.o
+	ecdh_helper.o mgmt_util.o mgmt_config.o hci_codec.o eir.o hci_sync.o \
+	hci_drv.o
 
 bluetooth-$(CONFIG_DEV_COREDUMP) += coredump.o
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..2815b2d7d28d 100644
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
@@ -3019,6 +3021,14 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -EINVAL;
 	}
 
+	if (hci_skb_pkt_type(skb) == HCI_DRV_PKT) {
+		// Intercept HCI Drv packet here and don't go with hdev->send
+		// callabck.
+		err = hci_drv_process_cmd(hdev, skb);
+		kfree_skb(skb);
+		return err;
+	}
+
 	err = hdev->send(hdev, skb);
 	if (err < 0) {
 		bt_dev_err(hdev, "sending frame failed (%d)", err);
diff --git a/net/bluetooth/hci_drv.c b/net/bluetooth/hci_drv.c
new file mode 100644
index 000000000000..3c011edc7fd8
--- /dev/null
+++ b/net/bluetooth/hci_drv.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google Corporation
+ */
+
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_drv.h>
+
+int hci_drv_cmd_status(struct hci_dev *hdev, u16 cmd, u8 status)
+{
+	struct hci_drv_ev_hdr *hdr;
+	struct hci_drv_ev_cmd_status *ev;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->opcode = __cpu_to_le16(HCI_DRV_EV_CMD_STATUS);
+	hdr->len = __cpu_to_le16(sizeof(*ev));
+
+	ev = skb_put(skb, sizeof(*ev));
+	ev->opcode = __cpu_to_le16(cmd);
+	ev->status = status;
+
+	hci_skb_pkt_type(skb) = HCI_DRV_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL(hci_drv_cmd_status);
+
+int hci_drv_cmd_complete(struct hci_dev *hdev, u16 cmd, u8 status, void *rp,
+			 size_t rp_len)
+{
+	struct hci_drv_ev_hdr *hdr;
+	struct hci_drv_ev_cmd_complete *ev;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->opcode = __cpu_to_le16(HCI_DRV_EV_CMD_COMPLETE);
+	hdr->len = __cpu_to_le16(sizeof(*ev) + rp_len);
+
+	ev = skb_put(skb, sizeof(*ev));
+	ev->opcode = __cpu_to_le16(cmd);
+	ev->status = status;
+
+	skb_put_data(skb, rp, rp_len);
+
+	hci_skb_pkt_type(skb) = HCI_DRV_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL(hci_drv_cmd_complete);
+
+int hci_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_drv_cmd_hdr *hdr;
+	const struct hci_drv_handler *handler = NULL;
+	u16 opcode, len, ogf, ocf;
+
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr)
+		return -EILSEQ;
+
+	opcode = __le16_to_cpu(hdr->opcode);
+	len = __le16_to_cpu(hdr->len);
+	if (len != skb->len)
+		return -EILSEQ;
+	ogf = hci_opcode_ogf(opcode);
+	ocf = hci_opcode_ocf(opcode);
+
+	if (!hdev->hci_drv)
+		return hci_drv_cmd_status(hdev, opcode,
+					  HCI_DRV_STATUS_UNKNOWN_COMMAND);
+
+	if (ogf != HCI_DRV_OGF_DRIVER_SPECIFIC) {
+		if (opcode < hdev->hci_drv->common_handler_count)
+			handler = &hdev->hci_drv->common_handlers[opcode];
+	} else {
+		if (ocf < hdev->hci_drv->specific_handler_count)
+			handler = &hdev->hci_drv->specific_handlers[ocf];
+	}
+
+	if (!handler || !handler->func)
+		return hci_drv_cmd_status(hdev, opcode,
+					  HCI_DRV_STATUS_UNKNOWN_COMMAND);
+
+	if (len != handler->data_len)
+		return hci_drv_cmd_status(hdev, opcode,
+					  HCI_DRV_STATUS_INVALID_PARAMETERS);
+
+	return handler->func(hdev, skb->data, len);
+}
+EXPORT_SYMBOL(hci_drv_process_cmd);
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
2.49.0.604.gff1f9ca942-goog


