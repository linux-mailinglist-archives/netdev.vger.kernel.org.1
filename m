Return-Path: <netdev+bounces-291069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEWdAIhpEWrKlgYAu9opvQ
	(envelope-from <netdev+bounces-291069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BF5BDFD9
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6609230393A0
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AD3750BD;
	Sat, 23 May 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIjwluaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07F372B3B
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525878; cv=none; b=Jr9R5YGbkDD0UlQ9ltu9rvEdOD2ahp6t66qbH0WfU5ZjbHgfzUdJgJancuPjRZQmn8ejjc9nj/h/YIPOSEqoLMiSmXbhdszHLtjWEBhOj7zEpqQ99q5NR35+AI4Esg2gqXMF64hgjXTkDccRlol6ZAep0gnq6NNlEPatj9qUMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525878; c=relaxed/simple;
	bh=9oprkoi7DYWuhOMzKA+2R6TB07z0WZogt1+14SSTfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJJDPgieTso+1zS4quLmNoFxKgS6c/74scPj/vVmrPxnIKTRyK2NycAL3K7nPF4YOqe7P/644wE63PhQN7yAYEftMj/CoOV5OQYas8aD/PFHh14+wVeMDpKykmBSaYxsVvZKgsO298MQCxxzlrHUCD1zAntQg2UrAPzr/QCFqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIjwluaq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd85ebb368fso1193803666b.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525869; x=1780130669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4rV8mWsiC13Dx8VjcnY9lCfoJOx46rnsUI+A7HjLZs=;
        b=lIjwluaqBJDB/+VydAS4YfCvv30WMZgGPRPKmSCa+G0hQdkEb2KMZUwQ+94kSfhsJS
         GegRh2VHd5nLk1FcWaiUsUv7qdx0FkzRU2jlSSi7jYPNCN9diDoxnWLJ5nyNul2E12Q1
         jNLR8n+HxIGGgsm932h+yLb6paRvrI58b6gEBXGrZ7NblPKV3HOYw5EYXRnj+fFu75vd
         ckY2hEjJraIIO58+03bgTDgZC+0oWFnCl6Hde/Hw3HugRQTJyaki8WyAIU7gBR7W+MlI
         QOHptVd74+xXeoE55vpQ6XYbWW5T5uy59xVUbaOVQDXkSWPAnTJb8hQheXrQG8zAKbrW
         ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525869; x=1780130669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4rV8mWsiC13Dx8VjcnY9lCfoJOx46rnsUI+A7HjLZs=;
        b=h93wGOYJmiMInjY2c9mokpciFihvvkrGG1Q5lp8DrVoGtM0XF5gD7DEFrAfH8Eq0us
         3LekLd1PebTw4kgbbdGdgZ94/Jh9l0M9f89tvldu/jzH4RNuzVZ84Sq6pOO2WSEB5Lac
         4xWC4HR+i1mJBXMjqVnIrkZtY8Ldj80kyaWKB/kdn9yQStwG/oOZZNvRXilY0Eg7Y7w2
         yxqfZgxjVwsduFxQ0SsejbGY0QgsKUDGyYc/mWW4osQG8W6tJxZ9cS6duIS2toqBTB4W
         7G/NUZgruxqRV6XnYJix6+Ua3hIud0fEyMyhqWrZpqMjQ4ngN9kOudWvLsqM8BXmIteA
         X1gw==
X-Gm-Message-State: AOJu0YwH+now/QQcmT0W89vWV7j5obP+FF61cxH1OXNl9B1qfyh0We3X
	A7i38m2bGl5jC2e1wCNvfMwxDU+za4MOBSsc6FmR8QEHTnxmLhyrrKID
X-Gm-Gg: Acq92OEXzePM8/wPPriYcr8QAoVetEpaqSTHUN6nh830i1/ULyiQNSSy3HAoGoKymzE
	M6eIrUqlKed2WkUxjuQzBGuCIojnPLyYCo7UO/we48XRjWNxrieGQksso1VU2vg5ExwyxxNsjbp
	fLOWKNdJh1vzborYPQHQR2dAaCf0BmFXLjSzXhmOjfoQBhqyENGC1Hm9ATa5sq3LrHQeoVTsc7E
	XLQKrrDBkKA5Ufq89Gya8pXe7L/wfO4iZRe5eyYSmMrsAzQwNAUcD/iNc062jbEX3SOwGANahzl
	DHUx2u73PqSUi9olPVzY+9rGS30Ie0mcS4Y/Fuy7vpJmBaoJD8yR9l7R2Xh3q3F0qJrJLesMrpo
	m/hMVSKpg7a1wOjOOgmGrcT6DtqzlStOThcHXwSjUJeCCcezrs48yRBrO41VVpu3DCz3O7FLTq0
	x3ElG9VSt5JAFC
X-Received: by 2002:a17:907:1c28:b0:bd6:6f5e:ea6f with SMTP id a640c23a62f3a-bdd237f5752mr401948666b.19.1779525869132;
        Sat, 23 May 2026 01:44:29 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d70a5sm154042966b.48.2026.05.23.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:44:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] net: usb: Add Infineon XMM6260 Baseband modem support
Date: Sat, 23 May 2026 11:44:07 +0300
Message-ID: <20260523084408.50346-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260523084408.50346-1-clamor95@gmail.com>
References: <20260523084408.50346-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,modem_work.work:url]
X-Rspamd-Queue-Id: 533BF5BDFD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Infineon/Intel XMM6260 is a 3G-focused, slim modem platform designed
for smartphones, data cards, and Machine-to-Machine (M2M) applications.
The modem is usually connected via the application processor's USB line
in HSIC mode; however, to work properly, the modem must control this line

Dmesg with modem appearing on LG Optimus Vu (P895):

[    9.427014] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    9.431488] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    9.457197] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    9.460370] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.16
[    9.468470] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.475597] usb usb1: Product: EHCI Host Controller
[    9.480508] usb usb1: Manufacturer: Linux 6.16.0+ ehci_hcd
[    9.485913] usb usb1: SerialNumber: ci_hdrc.1
[    9.490862] hub 1-0:1.0: USB hub found
[    9.494005] hub 1-0:1.0: 1 port detected
[    9.657191] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    9.844726] usb 1-1: New USB device found, idVendor=1519, idProduct=0020, bcdDevice=12.74
[    9.850530] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    9.857594] usb 1-1: Product: HSIC Device
[    9.861606] usb 1-1: Manufacturer: Comneon
[    9.865627] usb 1-1: SerialNumber: 0123456789
[    9.908739] cdc_acm 1-1:1.0: ttyACM0: USB ACM device

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/net/usb/Kconfig            |  15 ++
 drivers/net/usb/Makefile           |   1 +
 drivers/net/usb/baseband-xmm6260.c | 378 +++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 drivers/net/usb/baseband-xmm6260.c

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 52a5c0922c79..d54d8db752df 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -642,4 +642,19 @@ config USB_RTL8153_ECM
 	  CONFIG_USB_RTL8152 is not set, or the RTL8153 device is not
 	  supported by r8152 driver.
 
+config USB_NET_XMM6260
+	tristate "Infineon XMM626X Baseband HSPA/HSUPA modem"
+	depends on USB_CHIPIDEA && (RFKILL || RFKILL=n)
+	help
+	  Select this if you want to use an Infineon XMM626X modem, found in
+	  devices such as the LG Optimus 4X P880, LG Optimus Vu P895, Samsung
+	  Galaxy S II (GT-I9100), and Galaxy Nexus (GT-I9250). This driver
+	  handles the modem configuration and provides a stable way to expose
+	  the modem's USB interface. To establish a connection, you will first
+	  need a userspace program to send the correct commands to the modem
+	  through its CDC ACM port, as well as a DHCP client.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called baseband-xmm6260.
+
 endif # USB_NET_DRIVERS
diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
index 4964f7b326fb..ffa532c7d7d6 100644
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_USB_NET_CDC_MBIM)	+= cdc_mbim.o
 obj-$(CONFIG_USB_NET_CH9200)	+= ch9200.o
 obj-$(CONFIG_USB_NET_AQC111)	+= aqc111.o
 obj-$(CONFIG_USB_RTL8153_ECM)	+= r8153_ecm.o
+obj-$(CONFIG_USB_NET_XMM6260)	+= baseband-xmm6260.o
diff --git a/drivers/net/usb/baseband-xmm6260.c b/drivers/net/usb/baseband-xmm6260.c
new file mode 100644
index 000000000000..557ec79f5e2a
--- /dev/null
+++ b/drivers/net/usb/baseband-xmm6260.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2011 NVIDIA Corporation
+ * Copyright (C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/rfkill.h>
+#include <linux/usb.h>
+
+#define BASEBAND_XMM_INIT_DELAY		5000
+
+#define BASEBAND_PRODUCT_ID_XMM6260	0x0020
+#define BASEBAND_VENDOR_ID_COMNEON	0x1519
+
+/*
+ * Starting from ver 1145 modem starts in the IPC_AP_WAKE_IRQ_READY state.
+ * AP wake interrupt keeps low util CP starts to initiate its HSIC hw. AP wake
+ * interrupt goes up during CP HSIC init (BASEBAND_XMM_IPC_AP_WAKE_INIT1 state)
+ * at this point Host USB bus must be configured in order for modem to set
+ * properly. Then interrupt goes down when CP HSIC is ready
+ * (BASEBAND_XMM_IPC_AP_WAKE_INIT2 state) and at this point XMM6260 USB device
+ * should appear and be accessible for further work. In case it does not, the
+ * cycle must repeat.
+ */
+
+/* bits [0:2] */
+enum baseband_xmm_ipc_ap_wake_state {
+	BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY,
+	BASEBAND_XMM_IPC_AP_WAKE_INIT1,
+	BASEBAND_XMM_IPC_AP_WAKE_INIT2,
+	BASEBAND_XMM_IPC_AP_WAKE_L,
+	BASEBAND_XMM_IPC_AP_WAKE_H,
+	BASEBAND_XMM_IPC_AP_WAKE_UNINIT,
+	BASEBAND_XMM_IPC_AP_WAKE_MASK = 7,
+};
+
+#define BASEBAND_XMM_IPC_AP_WAKE_MAX	3
+
+#define BASEBAND_XMM_STATE_POWERED	3 /* Tracks regulator state */
+#define BASEBAND_XMM_STATE_PROTECTED	4 /* Prevents rfkill from access */
+#define BASEBAND_XMM_STATE_PRESENT	5 /* Tracks USB device presence */
+#define BASEBAND_XMM_STATE_POWEROFF	6 /* Prevents poweroff recursive call */
+#define BASEBAND_XMM_STATE_MAX		8
+
+struct baseband_xmm_data {
+	struct device *dev;
+	struct rfkill *rfkill_dev;
+	struct pwrseq_desc *pwrseq;
+
+	DECLARE_BITMAP(state, BASEBAND_XMM_STATE_MAX);
+	int irq;
+
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *enable_gpio;
+
+	struct gpio_desc *ipc_cp_gpio;
+	struct gpio_desc *ipc_ap_gpio;
+
+	struct regulator *vbat_supply;
+
+	struct delayed_work modem_work;
+	struct notifier_block nb;
+};
+
+static int get_ipc_ap_wake(struct baseband_xmm_data *priv)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < BASEBAND_XMM_IPC_AP_WAKE_MAX; i++)
+		ret |= (test_bit(i, priv->state) << i);
+
+	return ret;
+}
+
+static void set_ipc_ap_wake(struct baseband_xmm_data *priv,
+			    enum baseband_xmm_ipc_ap_wake_state state)
+{
+	for (int i = 0; i < BASEBAND_XMM_IPC_AP_WAKE_MAX; i++)
+		if (state & BIT(i))
+			set_bit(i, priv->state);
+		else
+			clear_bit(i, priv->state);
+}
+
+static void baseband_xmm_reset(struct baseband_xmm_data *priv)
+{
+	int ret;
+
+	set_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
+
+	if (!test_bit(BASEBAND_XMM_STATE_POWERED, priv->state)) {
+		ret = regulator_enable(priv->vbat_supply);
+		if (ret)
+			dev_err(priv->dev,
+				"failed to enable vbat power supply\n");
+
+		set_bit(BASEBAND_XMM_STATE_POWERED, priv->state);
+	}
+
+	gpiod_set_value_cansleep(priv->enable_gpio, 0);
+	msleep(50);
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	msleep(200);
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+
+	msleep(50);
+
+	/* falling edge trigger to CP */
+	gpiod_set_value_cansleep(priv->enable_gpio, 1);
+	usleep_range(50, 100);
+	gpiod_set_value_cansleep(priv->enable_gpio, 0);
+	msleep(20);
+}
+
+static void baseband_xmm_poweroff(struct baseband_xmm_data *priv)
+{
+	/*
+	 * The test_bit check prevents poweroff from being recursively
+	 * called during USB device deregistration. USB device
+	 * deregistration can be triggered by the driver by calling this
+	 * function or by some external event. The first case will cause
+	 * a recursive call by the notifier if not handled, while the
+	 * second case requires this call to handle the USB controller
+	 * properly.
+	 */
+	if (test_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state))
+		return;
+
+	set_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
+	set_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state);
+
+	pwrseq_power_off(priv->pwrseq);
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+
+	if (test_bit(BASEBAND_XMM_STATE_POWERED, priv->state)) {
+		regulator_disable(priv->vbat_supply);
+		clear_bit(BASEBAND_XMM_STATE_POWERED, priv->state);
+	}
+	set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY);
+
+	clear_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
+	clear_bit(BASEBAND_XMM_STATE_PRESENT, priv->state);
+	clear_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state);
+}
+
+static int baseband_xmm_usb_notifier_call(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct baseband_xmm_data *priv =
+		container_of(nb, struct baseband_xmm_data, nb);
+	struct usb_device *udev;
+	u16 product, vendor;
+
+	if (action == USB_BUS_ADD || action == USB_BUS_REMOVE)
+		return NOTIFY_OK;
+
+	udev = data;
+	product = le16_to_cpu(udev->descriptor.idProduct);
+	vendor = le16_to_cpu(udev->descriptor.idVendor);
+
+	switch (action) {
+	case USB_DEVICE_ADD:
+		/* Infineon XMM6260 ID 1519:0020 */
+		if (vendor == BASEBAND_VENDOR_ID_COMNEON &&
+		    product == BASEBAND_PRODUCT_ID_XMM6260) {
+			cancel_delayed_work_sync(&priv->modem_work);
+			clear_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
+			set_bit(BASEBAND_XMM_STATE_PRESENT, priv->state);
+		}
+		break;
+
+	case USB_DEVICE_REMOVE:
+		/* Infineon XMM6260 ID 1519:0020 */
+		if (vendor == BASEBAND_VENDOR_ID_COMNEON &&
+		    product == BASEBAND_PRODUCT_ID_XMM6260)
+			baseband_xmm_poweroff(priv);
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int baseband_xmm_set_block(void *data, bool blocked)
+{
+	struct baseband_xmm_data *priv = data;
+
+	if (test_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state))
+		return -EBUSY;
+
+	if (blocked && test_bit(BASEBAND_XMM_STATE_PRESENT, priv->state))
+		baseband_xmm_poweroff(priv);
+	else if (!blocked && !test_bit(BASEBAND_XMM_STATE_PRESENT, priv->state))
+		baseband_xmm_reset(priv);
+
+	return 0;
+}
+
+static const struct rfkill_ops baseband_xmm_rfkill_ops = {
+	.set_block = baseband_xmm_set_block,
+};
+
+static void baseband_xmm_work(struct work_struct *work)
+{
+	struct baseband_xmm_data *priv =
+		container_of(work, struct baseband_xmm_data, modem_work.work);
+
+	baseband_xmm_poweroff(priv);
+};
+
+static irqreturn_t baseband_hostwake_interrupt(int irq, void *dev_id)
+{
+	struct baseband_xmm_data *priv = dev_id;
+	int state = gpiod_get_value(priv->ipc_ap_gpio);
+
+	switch (get_ipc_ap_wake(priv)) {
+	case BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY:
+		if (!state) {
+			set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_INIT1);
+			pwrseq_power_on(priv->pwrseq);
+		}
+		break;
+
+	case BASEBAND_XMM_IPC_AP_WAKE_INIT1:
+		if (state) {
+			set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_INIT2);
+			schedule_delayed_work(&priv->modem_work,
+					      msecs_to_jiffies(BASEBAND_XMM_INIT_DELAY));
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int baseband_xmm_probe(struct platform_device *pdev)
+{
+	struct baseband_xmm_data *priv;
+	struct device *dev = &pdev->dev;
+	unsigned long irqflags;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
+	priv->vbat_supply = devm_regulator_get(dev, "vbat");
+	if (IS_ERR(priv->vbat_supply))
+		return dev_err_probe(dev, PTR_ERR(priv->vbat_supply),
+				     "failed to get vbat regulator\n");
+
+	/* Own modem gpios */
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	priv->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->enable_gpio),
+				     "failed to get enable GPIO\n");
+
+	/* CP - AP connections */
+	priv->ipc_cp_gpio = devm_gpiod_get_optional(dev, "cp-wake",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(priv->ipc_cp_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->ipc_cp_gpio),
+				     "failed to get CP wake GPIO\n");
+
+	priv->ipc_ap_gpio = devm_gpiod_get_optional(dev, "ap-wake", GPIOD_IN);
+	if (IS_ERR(priv->ipc_ap_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->ipc_ap_gpio),
+				     "failed to get AP wake GPIO\n");
+
+	/* Modem power sequence */
+	priv->pwrseq = devm_pwrseq_get(dev, "modem-power");
+	if (IS_ERR(priv->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(priv->pwrseq),
+				     "failed to get modem pwrseq");
+
+	bitmap_zero(priv->state, BASEBAND_XMM_STATE_MAX);
+	INIT_DELAYED_WORK(&priv->modem_work, baseband_xmm_work);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
+
+	/*
+	 * Systems using device tree should set up interrupt via DT,
+	 * the rest will use the default edge both interrupt.
+	 */
+	irqflags = dev->of_node ? 0 : IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+
+	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
+					&baseband_hostwake_interrupt,
+					IRQF_ONESHOT | irqflags,
+					"modem-hostwake", priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register IRQ %d\n", priv->irq);
+
+	priv->rfkill_dev = rfkill_alloc("xmm-modem", dev, RFKILL_TYPE_WWAN,
+					&baseband_xmm_rfkill_ops, priv);
+	if (!priv->rfkill_dev)
+		return -ENOMEM;
+
+	ret = rfkill_register(priv->rfkill_dev);
+	if (ret) {
+		rfkill_destroy(priv->rfkill_dev);
+		return dev_err_probe(dev, ret,
+				     "failed to register WWAN rfkill\n");
+	}
+
+	priv->nb.notifier_call = baseband_xmm_usb_notifier_call;
+	usb_register_notify(&priv->nb);
+
+	return 0;
+}
+
+static void baseband_xmm_remove(struct platform_device *pdev)
+{
+	struct baseband_xmm_data *priv = platform_get_drvdata(pdev);
+
+	rfkill_unregister(priv->rfkill_dev);
+	rfkill_destroy(priv->rfkill_dev);
+
+	disable_irq(priv->irq);
+	cancel_delayed_work_sync(&priv->modem_work);
+
+	usb_unregister_notify(&priv->nb);
+	baseband_xmm_poweroff(priv);
+}
+
+static const struct of_device_id baseband_xmm_match[] = {
+	{ .compatible = "infineon,xmm6260" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, baseband_xmm_match);
+
+static struct platform_driver baseband_xmm_driver = {
+	.driver = {
+		.name = "baseband-xmm6260",
+		.of_match_table = baseband_xmm_match,
+	},
+	.probe = baseband_xmm_probe,
+	.remove = baseband_xmm_remove,
+};
+module_platform_driver(baseband_xmm_driver);
+
+MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Baseband Infineon XMM6260 driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


