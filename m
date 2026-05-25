Return-Path: <netdev+bounces-291304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELjkEYc8FGrCLAcAu9opvQ
	(envelope-from <netdev+bounces-291304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:11:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BC5CA504
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A02C830128E8
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7D3603D1;
	Mon, 25 May 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="vf1IwRLp"
X-Original-To: netdev@vger.kernel.org
Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525A3812D3;
	Mon, 25 May 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711108; cv=none; b=rT4fBacztSMcR4UUvmcFTWz13EjFuwWeFfgja04E1WTa6rWZ7oFgpKc5CA4ylLZIWScPzHD6awx9kzar39ac8jJZHAgssbz8YUVWri9OccBQbr7k9sVhhax4uLY2d/AO99tI3LlBGubzX/9JM+62XqUBsQ3ufK0AzzzooOJVxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711108; c=relaxed/simple;
	bh=yh+/UfLiqBwqQ3sjftqkvE0efFCAz71iDWkf+c5wSI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gMt1F8bQ+Z+p+nCdR4Iqn9xBz8/teZqkLQ7Kzbn07Vpe8AxfYiPnpwHRPwWVfjvtCfwi24LIasADzt8t+1fST/KYR8GMI3u1QJ1+iA15LvEBSRy91G+Ci+HZEOBi6Wv4StjfC0vHFAyevsks2b6WK3nyKRMYANAF1HtqZnc4QR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=vf1IwRLp; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Received: by chaosmail.tech (Postfix) id D770C1C7F11;
	Mon, 25 May 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1779711096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ua2hjTXYJSmbP4jngVjvQ645Iiscu/cT4lcalp5VRsc=;
	b=vf1IwRLpq6GKsKuzT83xNShYQs+LE/xxKTKVAy30GqmZIpbbBAgs5NDf2QHesHNgc/wBHk
	blpx4kymWHrH7E3V7PrBW284VGpVYVqDb2g351eJAYDW/ghuckcX6zEX70VWQ+S56wkqPC
	+R37tr+jpMnxmkYDhtpPtfIV6w+X6mQ=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Mon, 25 May 2026 14:11:16 +0200
Subject: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMyw6CMBBFf4XM2pq+bNGV/2FcQJnCJEJJaxoN4
 d8trFzo8tzccxZIGAkTXKoFImZKFKYC6lCBG5qpR0ZdYZBcGq65ZW10I5sjBdYaxdE4p2qlofz
 niJ5ee+t2LzxQeob43tNZbOuvShZMMK/qVlhljdH82o8NPY4ujLBVsvxrymIqb/UJO6/Pjf821
 3X9AKQsh3fcAAAA
X-Change-ID: 20260407-brcm-prio-b630e6cc3834
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779711095; l=7497;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=yh+/UfLiqBwqQ3sjftqkvE0efFCAz71iDWkf+c5wSI0=;
 b=a6xCWP9LECyK5zy/7vv2VP8inEAuz74w69uAdL7ZOPiE2ce0gIklmeUsrnRYI0d/wuj9UE4lO
 /F0ssoAk+5/ArUgDq8K2X9HpVCGW3Q/nhsdzeA04qMKVLWe1pIw2FZ4
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chaosmail.tech,reject];
	R_DKIM_ALLOW(-0.20)[chaosmail.tech:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291304-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@chaosmail.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[chaosmail.tech:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A24BC5CA504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
streams carrying audio to be set as "high priority" using a vendor
specific command to prevent 10-ish second-long dropouts whenever
something does a device scan. This patch sends the command when the
socket priority is set to TC_PRIO_INTERACTIVE, as BlueZ does for audio.

From experimenting with the hardware - this command is not suitable for
per-skb priority switching, as prioritization is done on the handle
level, with this command reconfiguring certain radio timings, and
dropping to low priority in order to send a low packet on the same
handle as an audio stream is being played on causes the same kind of
dropout it is supposed to avoid. In addition, the hardware is rather
picky about when this command can be sent, as sending it during
connection open results in a timeout. The vendor stacks solve it by
having high-level visibility into what a connection is used for and
sending it from userspace when it is known that an audio stream is
about to start. As we can't have that visibility without introducing a
new ioctl, the socket priority is used as proxy.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
Changes in v3:
- use a struct for command data
- Link to v2: https://lore.kernel.org/r/20260407-brcm-prio-v2-1-3f745edf49af@gmail.com

Changes in v2:
- new ioctl got nack-ed, so let's use sk_priority as the trigger
- Link to v1: https://lore.kernel.org/r/20260407-brcm-prio-v1-1-f38b17376640@gmail.com
---
 MAINTAINERS                      |  2 ++
 drivers/bluetooth/hci_bcm4377.c  |  2 ++
 include/net/bluetooth/hci_core.h | 15 +++++++++++++++
 net/bluetooth/Kconfig            |  7 +++++++
 net/bluetooth/Makefile           |  1 +
 net/bluetooth/brcm.c             | 38 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/brcm.h             | 19 +++++++++++++++++++
 net/bluetooth/hci_core.c         |  4 ++++
 8 files changed, 88 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10e8253181d3..da4d12ec70d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2581,6 +2581,8 @@ F:	include/dt-bindings/pinctrl/apple.h
 F:	include/linux/mfd/macsmc.h
 F:	include/linux/soc/apple/*
 F:	include/uapi/drm/asahi_drm.h
+F:	net/bluetooth/brcm.c
+F:	net/bluetooth/brcm.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635945..5f79920c0306 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2397,6 +2397,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (bcm4377->hw->broken_le_ext_adv_report_phy)
 		hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY);
 
+	hci_set_brcm_capable(hdev);
+
 	pci_set_drvdata(pdev, bcm4377);
 	hci_set_drvdata(hdev, bcm4377);
 	SET_HCIDEV_DEV(hdev, &pdev->dev);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..53ebb2ae898f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -642,6 +642,10 @@ struct hci_dev {
 	bool			aosp_quality_report;
 #endif
 
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+	bool			brcm_capable;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -756,6 +760,10 @@ struct hci_conn {
 
 	unsigned int	sent;
 
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+	bool		brcm_high_prio;
+#endif
+
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
 
@@ -1791,6 +1799,13 @@ static inline void hci_set_aosp_capable(struct hci_dev *hdev)
 #endif
 }
 
+static inline void hci_set_brcm_capable(struct hci_dev *hdev)
+{
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+	hdev->brcm_capable = true;
+#endif
+}
+
 static inline void hci_devcd_setup(struct hci_dev *hdev)
 {
 #ifdef CONFIG_DEV_COREDUMP
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index ee6457d1a5ee..b611942c7b8f 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -107,6 +107,13 @@ config BT_AOSPEXT
 	  This options enables support for the Android Open Source
 	  Project defined HCI vendor extensions.
 
+config BT_BRCMEXT
+	bool "Enable Broadcom extensions"
+	depends on BT
+	help
+	  This option enables support for the Broadcom defined HCI
+	  vendor extensions.
+
 config BT_DEBUGFS
 	bool "Export Bluetooth internals in debugfs"
 	depends on BT && DEBUG_FS
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 41049b280887..d402645dfb7d 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -23,5 +23,6 @@ bluetooth-$(CONFIG_BT_LE) += iso.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
 bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
+bluetooth-$(CONFIG_BT_BRCMEXT) += brcm.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/brcm.c b/net/bluetooth/brcm.c
new file mode 100644
index 000000000000..299d83d465c3
--- /dev/null
+++ b/net/bluetooth/brcm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 The Asahi Linux Contributors
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "brcm.h"
+
+struct brcm_prio_cmd {
+	__le16 handle;
+	u8 enable;
+} __packed;
+
+int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
+			   bool enable)
+{
+	struct sk_buff *skb;
+	struct brcm_prio_cmd cmd;
+
+	if (!hdev->brcm_capable)
+		return 0;
+
+	if (conn->brcm_high_prio == enable)
+		return 0;
+
+	cmd.handle = cpu_to_le16(conn->handle);
+	cmd.enable = !!enable;
+
+	skb = hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), &cmd, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	conn->brcm_high_prio = enable;
+	kfree_skb(skb);
+	return 0;
+}
diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
new file mode 100644
index 000000000000..2290fc6cf798
--- /dev/null
+++ b/net/bluetooth/brcm.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 The Asahi Linux Contributors
+ */
+
+#if IS_ENABLED(CONFIG_BT_BRCMEXT)
+
+int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
+			   bool enable);
+
+#else
+
+static inline int brcm_set_high_priority(struct hci_dev *hdev,
+					 struct hci_conn *conn, bool enable)
+{
+	return 0;
+}
+
+#endif
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c46c1236ebfa..0e74bad496a2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -46,6 +46,7 @@
 #include "msft.h"
 #include "aosp.h"
 #include "hci_codec.h"
+#include "brcm.h"
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
@@ -3696,6 +3697,9 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
+			if (skb->priority == TC_PRIO_INTERACTIVE)
+				brcm_set_high_priority(hdev, chan->conn, true);
+
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 

---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id: 20260407-brcm-prio-b630e6cc3834

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>


