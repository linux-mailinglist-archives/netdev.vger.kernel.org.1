Return-Path: <netdev+bounces-296722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rKeSACAtJ2rdswIAu9opvQ
	(envelope-from <netdev+bounces-296722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499E65A937
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qMTgEpKk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296722-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8DB3081E99
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65F3A9628;
	Mon,  8 Jun 2026 20:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10B3AB498
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952293; cv=none; b=TKXQK1+BbB+MBde/GSCHbX63RypZRIpaYVOSzU1dJWFNFsWVGkTJVWsyg7IAzbuNZuXNJhk7PKFAeD60pYYgk1RFSbIUKu4vYpJGvNWGoxgmp9UkZz3PXHV2QkCyhSH3Qjrgdy+kVKYIfcWE4LSV1IwvqJ1N/Z47pJD9daJ0zYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952293; c=relaxed/simple;
	bh=DiQDk0XRK9TJFnJs8isQNa0H/yWgiB0aziM0XkpqyH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZivFaZHu7oPQcs+xwVI56ey93gb7nPgqNX1KG8Meao89GZckYdCEwEBPsPh1YBHN49FnLiR3/dXOPDaCJ8nVbqYRv4W62snHKEhiAXqZzsz4TdFIZyyGkudHm3EJdpF00v04ac9+ZeiVnomqU2AGm4+4uVU5+h+u7jnEGnNbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMTgEpKk; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b915ded5so41078845e9.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952288; x=1781557088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB69XNQgqspSqvNSR2ZWhQpJcg7eDF0eEGRuFtAUC8k=;
        b=qMTgEpKkahm87WdzhGkpdnVOj2gOYsN6JsaYYbb6r0528z7DNHBbXfIcCNItPFN9B4
         aUbWG3CjZD6BBGAq+rPTbxxmLKgS5aJfHhj1flAQ3zEUpPPyZ0TweiAS/iGlsdq4fwT0
         c7UujnJgWlErr9lX3IKZ6hv4H+TdBDSSBhtxCUg8ihYajv2lhWOr4WbXIlpMpyn1vGrj
         3mhYbS02Ri1YLY0xzNKKdX2nXBijt8t9hWO4Zp1hJcnUhR5ESxxezunBjwaxxF98c1do
         Zk5Ak7b69vrPfM3L/iFpGRu2r+iW4YL+/PcW5jc2xNItn61zy+TSgEt9OURXxkaDyhHW
         PuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952288; x=1781557088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BB69XNQgqspSqvNSR2ZWhQpJcg7eDF0eEGRuFtAUC8k=;
        b=I8KMmLpzxuyKthwfnUPpA2q0a9gj0+7fZK2Zum/9qQhOi6aazuM7AAmgxUJNb+KSRj
         RZAqgrHKU076pzB11FnMcRUMj//kDnj/r8kWqBt+KSLFCvigeduBv64H1XAx7Mqo0LM+
         Bi6EEcF0+PKl85UZLQXpXVjajNTshH9Mu4j9Z0EQjBYW7Dt4cO5c+SLSEic5EYWJNSJ9
         4LiwIabxh3vAOlGj5Va7uWw5aI+UM6Td30q52XFFKwHFTgcd+y4dn8e+nqm6C3nksRbb
         vMMmBRawUmFO1h1Y67Q7cjzUt/evZjdMePQlCATJgPruX4bnayM5HiHeI8+muDZKShKY
         pbOA==
X-Gm-Message-State: AOJu0YwA3qDiWhjPE8sesEt3Iu0Z04ImoyW8bNVMa/BvdrLgzCcRSkEz
	JpjTjaaXB/CfPhnNYGiS+YNz14EcY/Cjp7RUr9rY37obG4I58g5J1yujI/fmSQ==
X-Gm-Gg: Acq92OExdxy9qF+2uSI/3XHeWwEkF5ou+fCHyhBRa0yGjCg3tFZedAop2CkuUNw6rhN
	6LSiIeo6vL+AfPvWb2LtQTnwvl8bmjN1XUdMeZ3Pmk1LR97WUY7Lt1h8i72BQbQzelWD2ySNkBT
	sfeXIwILWZ+YPLlMADRLbpJETR26GUGzM5RuM+TANz8JzY1gwcwuMotSxMKNiyvS95KDDuRcQiB
	Z4aOXY28+mBna1kSIwqXCaVduT945An8krUm0VaM/1bDmoQG4lMDLDWkc1aQ19qkmxZyiCg1c72
	27HthfkEs/tdjjOtqvIv/qEzw8bkSwoIr1C2p08Ljl0jVBuShctHXrgfYxZVrJ6QdvBbrc80YUY
	P14lTqaZ8S0sb4Gd8QPiIj25XwPc6VO9OfTnLDSSNntLe5A2ePsPQA4GsIqkNG3Lu+Mb+ur94uw
	2v7A3G53GqU9M82Js3mXQNeQfQ4z8okv9tIdcl
X-Received: by 2002:a05:600c:8b83:b0:490:b58b:a8ca with SMTP id 5b1f17b1804b1-490c263fd08mr289795285e9.27.1780952287516;
        Mon, 08 Jun 2026 13:58:07 -0700 (PDT)
Received: from builder ([2001:9e8:f105:6a16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d4891csm231011875e9.1.2026.06.08.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:58:07 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU driver
Date: Mon,  8 Jun 2026 20:57:57 +0000
Message-ID: <20260608205758.1830521-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608205758.1830521-1-jelonek.jonas@gmail.com>
References: <20260608205758.1830521-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-296722-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1499E65A937

A range of PoE switches use a small microcontroller on the PCB to front
the actual PSE silicon. The host CPU talks to that MCU over I2C/SMBus or
UART using a fixed 12-byte request/response protocol with a trailing
checksum; the PSE chips are managed by the MCU and are not accessed
directly. The same protocol family is spoken by Realtek and Broadcom PSE
MCUs, diverging in opcode numbering and a few response layouts, which the
driver abstracts behind a per-dialect opcode table and parser hooks
selected by the compatible. The specific PSE chip behind the MCU is
detected at runtime and only influences per-chip constants (power scaling
and the per-port cap).

The driver is split into a shared core and two transport modules:

- PSE_REALTEK: protocol, message framing, dialect machinery, and the
  pse_controller_ops glue.
- PSE_REALTEK_I2C / PSE_REALTEK_UART: transport modules registering the
  MCU on an I2C bus or a serdev port respectively.

The realtek-* file names and PSE_REALTEK* symbols reflect the platform
this setup appears on rather than vendor scope: this MCU front-end is
found almost exclusively on Realtek-based switches. Broadcom PSE MCUs
speak the same protocol family and are supported by the same shared core
through the dialect abstraction, so the realtek-* naming is kept rather
than splitting the code or renaming to a vendor-neutral scheme. For the
same reason the device tree compatibles live under one vendor prefix,
realtek,pse-mcu-rtk and realtek,pse-mcu-bcm, with the suffix selecting the
dialect.

Power budgeting is left to the MCU firmware; the driver advertises
PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 MAINTAINERS                           |    7 +
 drivers/net/pse-pd/Kconfig            |   28 +
 drivers/net/pse-pd/Makefile           |    3 +
 drivers/net/pse-pd/realtek-pse-core.c | 1002 +++++++++++++++++++++++++
 drivers/net/pse-pd/realtek-pse-i2c.c  |  164 ++++
 drivers/net/pse-pd/realtek-pse-uart.c |  147 ++++
 drivers/net/pse-pd/realtek-pse.h      |   70 ++
 7 files changed, 1421 insertions(+)
 create mode 100644 drivers/net/pse-pd/realtek-pse-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse.h

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..4adc929b7d01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22484,6 +22484,13 @@ S:	Maintained
 F:	include/sound/rt*.h
 F:	sound/soc/codecs/rt*
 
+REALTEK/BROADCOM PSE MCU DRIVER
+M:	Jonas Jelonek <jelonek.jonas@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
+F:	drivers/net/pse-pd/realtek-pse*
+
 REALTEK OTTO WATCHDOG
 M:	Sander Vanheule <sander@svanheule.net>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 7ef29657ee5d..b065b19db126 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -13,6 +13,34 @@ menuconfig PSE_CONTROLLER
 
 if PSE_CONTROLLER
 
+config PSE_REALTEK
+	tristate
+	help
+	  Shared core for the Realtek/Broadcom PSE MCU driver. This is
+	  selected automatically by the transport options below.
+
+config PSE_REALTEK_I2C
+	tristate "Realtek/Broadcom PSE MCU driver (I2C transport)"
+	depends on I2C
+	select PSE_REALTEK
+	help
+	  Driver for the microcontroller (MCU) that fronts the PSE
+	  hardware on switches with Realtek or Broadcom PSE chips, attached
+	  via I2C/SMBus. The MCU exposes a message-based protocol; the actual
+	  PSE silicon is not accessed directly. To compile this driver as a
+	  module, choose M here: the module will be called realtek-pse-i2c.
+
+config PSE_REALTEK_UART
+	tristate "Realtek/Broadcom PSE MCU driver (UART transport)"
+	depends on SERIAL_DEV_BUS
+	select PSE_REALTEK
+	help
+	  Driver for the microcontroller (MCU) that fronts the PSE
+	  hardware on switches with Realtek or Broadcom PSE chips, attached
+	  via UART. The MCU exposes a message-based protocol; the actual PSE
+	  silicon is not accessed directly. To compile this driver as a
+	  module, choose M here: the module will be called realtek-pse-uart.
+
 config PSE_REGULATOR
 	tristate "Regulator based PSE controller"
 	help
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index cc78f7ea7f5f..ad6ebf50fd56 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -3,6 +3,9 @@
 
 obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
 
+obj-$(CONFIG_PSE_REALTEK) += realtek-pse-core.o
+obj-$(CONFIG_PSE_REALTEK_I2C) += realtek-pse-i2c.o
+obj-$(CONFIG_PSE_REALTEK_UART) += realtek-pse-uart.o
 obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
 obj-$(CONFIG_PSE_SI3474) += si3474.o
diff --git a/drivers/net/pse-pd/realtek-pse-core.c b/drivers/net/pse-pd/realtek-pse-core.c
new file mode 100644
index 000000000000..711f85aebf5e
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-core.c
@@ -0,0 +1,1002 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for the microcontroller (MCU) fronting Realtek or Broadcom PSE
+ * chips. Both vendors' MCUs speak a closely related 12-byte fixed-frame
+ * management protocol; this driver covers both via a per-dialect opcode
+ * table and response parsers.
+ *
+ * Many PoE switch designs put a dedicated microcontroller in front of the
+ * actual PSE silicon: the host CPU talks to the MCU over I2C/SMBus or
+ * UART, and the MCU in turn manages the PSE chips on the board. The MCU
+ * speaks a small message-based protocol (12-byte fixed-size frames; opcode
+ * + arg + 9 payload bytes + checksum). The PSE chips themselves are not
+ * accessed directly; everything goes through MCU commands.
+ *
+ * This driver targets that architecture for the Realtek-family protocol.
+ * Two dialects are supported: Realtek MCUs managing RTL823x/RTL8239* PSE
+ * chips, and Broadcom MCUs managing BCM590xx PSE chips. The two share
+ * frame format and a sum-mod-256 checksum but diverge on opcode numbers
+ * and on a few response layouts; this is handled by the per-dialect
+ * opcode table and parser hooks.
+ *
+ * Out of scope: PSE chips that are interfaced directly from the host
+ * without a management MCU, MCU designs that speak an unrelated protocol
+ * family, and "dumb PSE" modes where no host control is wired up at all.
+ * Those, if and when they show up in the kernel, belong in separate
+ * drivers under drivers/net/pse-pd/.
+ *
+ * This core module implements the protocol, decoding/encoding of MCU
+ * responses, and the pse_controller_ops integration. Transport modules
+ * (realtek-pse-i2c, realtek-pse-uart) provide the send/recv callbacks.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/unaligned.h>
+
+#include "realtek-pse.h"
+
+#define RTPSE_DEVICE_ID_RTL8238B	0x0138
+#define RTPSE_DEVICE_ID_RTL8239		0x0039
+#define RTPSE_DEVICE_ID_RTL8239C	0x0139
+#define RTPSE_DEVICE_ID_BCM59111	0xe111
+#define RTPSE_DEVICE_ID_BCM59121	0xe121
+
+#define RTPSE_PORT_STS_DISABLED		0x00
+#define RTPSE_PORT_STS_SEARCHING	0x01
+#define RTPSE_PORT_STS_DELIVERING	0x02
+#define RTPSE_PORT_STS_FAULT		0x04
+#define RTPSE_PORT_STS_REQUESTING	0x06
+
+/* RTPSE_PORT_SET_POWER_LIMIT_TYPE values */
+#define RTPSE_PORT_PW_LIMIT_TYPE_USER	0x02
+
+#define RTPSE_MAX_PORTS			48
+#define RTPSE_PORT_MAX_PRIORITY		3
+
+enum rtpse_cmd {
+	RTPSE_CMD_MCU_SET_GLOBAL_STATE,
+	RTPSE_CMD_MCU_GET_SYSTEM_INFO,
+	RTPSE_CMD_MCU_GET_EXT_CONFIG,
+
+	RTPSE_CMD_PORT_ENABLE,
+	RTPSE_CMD_PORT_SET_POWER_LIMIT_TYPE,
+	RTPSE_CMD_PORT_SET_POWER_LIMIT,
+	RTPSE_CMD_PORT_SET_POWER_LIMIT_EXT,
+	RTPSE_CMD_PORT_SET_PRIORITY,
+	RTPSE_CMD_PORT_GET_STATUS,
+	RTPSE_CMD_PORT_GET_POWER_STATS,
+	RTPSE_CMD_PORT_GET_CONFIG,
+	RTPSE_CMD_PORT_GET_EXT_CONFIG,
+
+	RTPSE_NUM_CMDS,
+};
+
+struct rtpse_opcode {
+	u8 op;
+	bool valid;
+};
+
+/* Shorthand for the designated-initializer entries in dialect opcode tables. */
+#define RTPSE_OP(opc)	{ .op = (opc), .valid = true }
+
+/* Forward-declared so dialects can supply response parsers (defined below). */
+struct rtpse_mcu_info;
+struct rtpse_port_status;
+
+struct rtpse_mcu_dialect {
+	struct rtpse_opcode opcode[RTPSE_NUM_CMDS];
+
+	/*
+	 * Response parsers. Each dialect must supply its own; the core calls
+	 * these unconditionally rather than carrying a default that would
+	 * silently mis-decode bytes from a dialect that forgot to set them.
+	 */
+	int (*parse_system_info)(const u8 *payload, struct rtpse_mcu_info *info);
+	int (*parse_port_class)(const struct rtpse_port_status *status);
+	const char *(*mcu_type_str)(unsigned int mcu_type);
+};
+
+/*
+ * Per-compatible match data: selected by the DT/I2C compatible, it bundles
+ * the protocol dialect with attachment quirks that the exact MCU silicon
+ * does not determine (only its firmware protocol and the host bus do).
+ */
+struct rtpse_match_data {
+	const struct rtpse_mcu_dialect *dialect;
+	/* I2C framing must come from DT (realtek,i2c-protocol); else SMBus. */
+	bool i2c_proto_dt_required;
+};
+
+struct rtpse_chip_info {
+	const char *name;
+	u16 device_id;
+	u32 max_mW_per_port;
+	enum rtpse_cmd pw_set_cmd;	/* command used by set_pw_limit */
+	u32 pw_set_lsb_mW;		/* LSB of pw_set_cmd value, in mW */
+	u32 pw_read_lsb_mW;		/* LSB of ext_config.max_power read-back, in mW */
+};
+
+/* Parsed MCU response structures (decoded from rtpse_mcu_msg replies) */
+
+struct rtpse_mcu_info {
+	u8 max_ports;
+	bool system_enable;
+	u16 device_id;
+	u8 sw_ver;
+	u8 mcu_type;
+	u8 config_status;
+	u8 ext_ver;
+};
+
+struct rtpse_mcu_ext_config {
+	u8 uvlo;
+	u8 ovlo;
+	bool prealloc_enable;
+	u8 num_of_pses;
+};
+
+struct rtpse_port_status {
+	u8 sts1;
+	u8 sts2;
+	u8 sts3;
+};
+
+struct rtpse_port_measurement {
+	u16 voltage_raw;	/* 64.45mV/LSB */
+	u16 current_raw;	/* 1mA/LSB */
+	u16 temperature_raw;	/* T(mC) = 1250 * (220 - raw) */
+	u16 power_raw;		/* 100mW/LSB */
+};
+
+struct rtpse_port_config {
+	bool enable;
+	u8 function_mode;
+	u8 detection_type;
+	u8 cls_type;
+	u8 disconnect_type;
+	u8 pair_type;
+};
+
+struct rtpse_port_ext_config {
+	u8 inrush_mode;
+	u8 limit_type;
+	u8 max_power;
+	u8 priority;
+	u8 chip_addr;
+	u8 channel;
+};
+
+static const struct rtpse_chip_info rtl8238b_info = {
+	.device_id = RTPSE_DEVICE_ID_RTL8238B,
+	.max_mW_per_port = 30000,
+	.name = "RTL8238B",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+static const struct rtpse_chip_info rtl8239_info = {
+	.device_id = RTPSE_DEVICE_ID_RTL8239,
+	.max_mW_per_port = 90000,
+	.name = "RTL8239",
+	.pw_read_lsb_mW = 400,
+	.pw_set_cmd = RTPSE_CMD_PORT_SET_POWER_LIMIT_EXT,
+	.pw_set_lsb_mW = 400,
+};
+
+static const struct rtpse_chip_info rtl8239c_info = {
+	.device_id = RTPSE_DEVICE_ID_RTL8239C,
+	.max_mW_per_port = 90000,
+	.name = "RTL8239C",
+	.pw_read_lsb_mW = 400,
+	.pw_set_cmd = RTPSE_CMD_PORT_SET_POWER_LIMIT_EXT,
+	.pw_set_lsb_mW = 400,
+};
+
+static const struct rtpse_chip_info bcm59111_info = {
+	.device_id = RTPSE_DEVICE_ID_BCM59111,
+	.max_mW_per_port = 30000,
+	.name = "BCM59111",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+static const struct rtpse_chip_info bcm59121_info = {
+	.device_id = RTPSE_DEVICE_ID_BCM59121,
+	.max_mW_per_port = 60000,	/* 802.3bt Type 3 */
+	.name = "BCM59121",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+/* Helpers and basic functions */
+
+static inline struct rtpse_ctrl *to_rtpse_ctrl(struct pse_controller_dev *pcdev)
+{
+	return container_of(pcdev, struct rtpse_ctrl, pcdev);
+}
+
+bool rtpse_needs_i2c_proto(const struct rtpse_match_data *match)
+{
+	return match->i2c_proto_dt_required;
+}
+EXPORT_SYMBOL_GPL(rtpse_needs_i2c_proto);
+
+static inline void rtpse_mcu_msg_init(struct rtpse_mcu_msg *msg, u8 opcode)
+{
+	memset(msg, 0xff, sizeof(*msg));
+	msg->opcode = opcode;
+}
+
+static u8 rtpse_checksum(const u8 *buf, size_t len)
+{
+	u8 sum = 0;
+
+	while (len--)
+		sum += *buf++;
+	return sum;
+}
+
+static int rtpse_do_xfer(struct rtpse_ctrl *pse, struct rtpse_mcu_msg *req,
+			 struct rtpse_mcu_msg *resp)
+{
+	int ret;
+
+	req->checksum = rtpse_checksum((u8 *)req, RTPSE_MCU_MSG_SIZE - 1);
+
+	scoped_guard(mutex, &pse->mutex) {
+		ret = pse->transport->send(pse, req);
+		if (ret)
+			return ret;
+
+		/*
+		 * The MCU needs a fixed amount of time between receiving a request
+		 * and having the response ready, regardless of how the bytes get to
+		 * us. Pace the transaction here so each transport can keep its recv
+		 * path simple: a single bounded wait rather than a generic retry.
+		 */
+		msleep(RTPSE_MCU_RESPONSE_MS);
+
+		memset(resp, 0, sizeof(*resp));
+		ret = pse->transport->recv(pse, req, resp);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Explicit MCU error opcodes (observed on the BCM dialect; harmless
+	 * to check for RTL too). Catch these before the generic opcode/CRC
+	 * mismatch path so callers see a meaningful errno.
+	 */
+	switch (resp->opcode) {
+	case 0xfd:	return -EBADE;		/* request incomplete */
+	case 0xfe:	return -EBADMSG;	/* MCU-reported checksum error */
+	case 0xff:	return -EAGAIN;		/* MCU not ready */
+	}
+
+	if (resp->opcode != req->opcode ||
+	    resp->checksum != rtpse_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int rtpse_port_query(struct rtpse_ctrl *pse, unsigned int port, u8 opcode,
+			    struct rtpse_mcu_msg *resp)
+{
+	struct rtpse_mcu_msg req;
+	int ret;
+
+	rtpse_mcu_msg_init(&req, opcode);
+	req.payload[0] = port;
+
+	ret = rtpse_do_xfer(pse, &req, resp);
+	if (ret)
+		return ret;
+
+	if (resp->payload[0] != port)
+		return -EIO;
+
+	return 0;
+}
+
+static int rtpse_port_cmd(struct rtpse_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
+{
+	struct rtpse_mcu_msg req, resp;
+	int ret;
+
+	rtpse_mcu_msg_init(&req, opcode);
+	req.payload[0] = port;
+	req.payload[1] = arg;
+
+	ret = rtpse_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	if (resp.payload[0] != port || resp.payload[1] != 0)
+		return -EIO;
+
+	return 0;
+}
+
+/* Global operations */
+
+static int rtpse_mcu_get_info(struct rtpse_ctrl *pse, struct rtpse_mcu_info *info)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_MCU_GET_SYSTEM_INFO];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	ret = rtpse_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	return pse->dialect->parse_system_info(resp.payload, info);
+}
+
+static int rtpse_mcu_get_ext_config(struct rtpse_ctrl *pse, struct rtpse_mcu_ext_config *config)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_MCU_GET_EXT_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	ret = rtpse_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	config->uvlo = resp.payload[0];
+	config->ovlo = resp.payload[5];
+	config->prealloc_enable = (resp.payload[1] == 0x1);
+	config->num_of_pses = resp.payload[6];
+
+	return 0;
+}
+
+static int rtpse_set_global_state(struct rtpse_ctrl *pse, bool enable)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_MCU_SET_GLOBAL_STATE];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	req.payload[0] = enable ? 0x1 : 0x0;
+
+	ret = rtpse_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	return (resp.payload[0] == 0x0) ? 0 : -EIO;
+}
+
+/* Port operations */
+
+static int rtpse_port_get_status(struct rtpse_ctrl *pse, unsigned int port,
+				 struct rtpse_port_status *status)
+{
+	const struct rtpse_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_GET_STATUS];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	status->sts1 = resp.payload[1];
+	status->sts2 = resp.payload[2];
+	status->sts3 = resp.payload[3];
+
+	return 0;
+}
+
+static int rtpse_port_get_measurement(struct rtpse_ctrl *pse, unsigned int port,
+				      struct rtpse_port_measurement *measurement)
+{
+	const struct rtpse_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_GET_POWER_STATS];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	measurement->voltage_raw = get_unaligned_be16(&resp.payload[1]);
+	measurement->current_raw = get_unaligned_be16(&resp.payload[3]);
+	measurement->temperature_raw = get_unaligned_be16(&resp.payload[5]);
+	measurement->power_raw = get_unaligned_be16(&resp.payload[7]);
+
+	return 0;
+}
+
+static int rtpse_port_get_config(struct rtpse_ctrl *pse, unsigned int port,
+				 struct rtpse_port_config *config)
+{
+	const struct rtpse_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_GET_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	config->enable = (resp.payload[1] == 1);
+	config->function_mode = resp.payload[2];
+	config->detection_type = resp.payload[3];
+	config->cls_type = resp.payload[4];
+	config->disconnect_type = resp.payload[5];
+	config->pair_type = resp.payload[6];
+
+	return 0;
+}
+
+static int rtpse_port_get_ext_config(struct rtpse_ctrl *pse, unsigned int port,
+				     struct rtpse_port_ext_config *config)
+{
+	const struct rtpse_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_GET_EXT_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	config->inrush_mode = resp.payload[1];
+	config->limit_type = resp.payload[2];
+	config->max_power = resp.payload[3];
+	config->priority = resp.payload[4];
+	config->chip_addr = resp.payload[5];
+	config->channel = resp.payload[6];
+
+	return 0;
+}
+
+static int rtpse_port_set_state(struct rtpse_ctrl *pse, unsigned int port, bool enable)
+{
+	const struct rtpse_opcode *opc;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_ENABLE];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	return rtpse_port_cmd(pse, port, opc->op, enable ? 0x1 : 0x0);
+}
+
+/*
+ * PSE controller ops
+ *
+ * @id is the PSE PI index from DT, used directly as the MCU port number.
+ * This assumes 0-based, contiguous MCU port addressing. Boards whose PSE
+ * outputs are wired to the chip at an offset would need a PI-index ->
+ * MCU-port mapping here.
+ */
+
+static int rtpse_port_get_admin_state(struct pse_controller_dev *pcdev, int id,
+				      struct pse_admin_state *admin_state)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_config config;
+	int ret;
+
+	ret = rtpse_port_get_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	admin_state->c33_admin_state = config.enable ? ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED :
+						       ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+	return 0;
+}
+
+static int rtpse_port_get_pw_status(struct pse_controller_dev *pcdev, int id,
+				    struct pse_pw_status *pw_status)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_status status;
+	int ret;
+
+	ret = rtpse_port_get_status(pse, id, &status);
+	if (ret)
+		return ret;
+
+	switch (status.sts1) {
+	case RTPSE_PORT_STS_DISABLED:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
+		break;
+	case RTPSE_PORT_STS_SEARCHING:
+	case RTPSE_PORT_STS_REQUESTING:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
+		break;
+	case RTPSE_PORT_STS_DELIVERING:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+		break;
+	case RTPSE_PORT_STS_FAULT:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
+		break;
+	default:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int rtpse_port_get_pw_class(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_status status;
+	int ret;
+
+	ret = rtpse_port_get_status(pse, id, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * sts2 carries detection+classification only when sts1 is not a
+	 * fault state; in fault states it encodes the fault type instead.
+	 * Treat the two reserved sts1 codes (0x3, 0x5) as faults too, since
+	 * the datasheet hints at "other fault" beyond the explicit 0x4.
+	 */
+	switch (status.sts1) {
+	case RTPSE_PORT_STS_DISABLED:
+	case RTPSE_PORT_STS_SEARCHING:
+	case RTPSE_PORT_STS_DELIVERING:
+	case RTPSE_PORT_STS_REQUESTING:
+		return pse->dialect->parse_port_class(&status);
+	default:
+		return 0;
+	}
+}
+
+static int rtpse_port_get_actual_pw(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_measurement measurement;
+	int ret;
+
+	ret = rtpse_port_get_measurement(pse, id, &measurement);
+	if (ret)
+		return ret;
+
+	/* 100mW per LSB */
+	return measurement.power_raw * 100U;
+}
+
+static int rtpse_port_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_measurement measurement;
+	int ret;
+	u32 uV;
+
+	ret = rtpse_port_get_measurement(pse, id, &measurement);
+	if (ret)
+		return ret;
+
+	/* 64.45mV per LSB */
+	uV = (u32)measurement.voltage_raw * 64450U;
+	return min_t(u32, uV, INT_MAX);
+}
+
+static int rtpse_port_enable(struct pse_controller_dev *pcdev, int id)
+{
+	return rtpse_port_set_state(to_rtpse_ctrl(pcdev), id, true);
+}
+
+static int rtpse_port_disable(struct pse_controller_dev *pcdev, int id)
+{
+	return rtpse_port_set_state(to_rtpse_ctrl(pcdev), id, false);
+}
+
+static int rtpse_port_get_pw_limit(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_ext_config config;
+	int ret;
+
+	ret = rtpse_port_get_ext_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	return config.max_power * pse->chip->pw_read_lsb_mW;
+}
+
+static int rtpse_port_set_pw_limit(struct pse_controller_dev *pcdev, int id, int max_mW)
+{
+	const struct rtpse_opcode *type_opc, *val_opc;
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	const struct rtpse_chip_info *chip = pse->chip;
+	unsigned int prg_val;
+	int ret;
+
+	if (max_mW < 0 || max_mW > chip->max_mW_per_port)
+		return -ERANGE;
+
+	type_opc = &pse->dialect->opcode[RTPSE_CMD_PORT_SET_POWER_LIMIT_TYPE];
+	val_opc = &pse->dialect->opcode[chip->pw_set_cmd];
+	if (!type_opc->valid || !val_opc->valid)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Switch the port to user-defined limit mode first, then program the
+	 * limit value. If the second cmd fails, the port is left in
+	 * user-defined mode but with the previous limit value; the next
+	 * successful set_pw_limit call recovers it.
+	 */
+	ret = rtpse_port_cmd(pse, id, type_opc->op, RTPSE_PORT_PW_LIMIT_TYPE_USER);
+	if (ret)
+		return ret;
+
+	prg_val = min_t(unsigned int, max_mW / chip->pw_set_lsb_mW, 0xff);
+
+	return rtpse_port_cmd(pse, id, val_opc->op, prg_val);
+}
+
+static int rtpse_port_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
+					  struct pse_pw_limit_ranges *out)
+{
+	struct ethtool_c33_pse_pw_limit_range *range;
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+
+	range = kzalloc_obj(*range, GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	range[0].min = 0;
+	range[0].max = pse->chip->max_mW_per_port;
+
+	out->c33_pw_limit_ranges = range;
+	return 1;
+}
+
+static int rtpse_port_get_prio(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	struct rtpse_port_ext_config config;
+	int ret;
+
+	ret = rtpse_port_get_ext_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	return config.priority;
+}
+
+static int rtpse_port_set_prio(struct pse_controller_dev *pcdev, int id, unsigned int prio)
+{
+	struct rtpse_ctrl *pse = to_rtpse_ctrl(pcdev);
+	const struct rtpse_opcode *opc;
+
+	if (prio > RTPSE_PORT_MAX_PRIORITY)
+		return -ERANGE;
+
+	opc = &pse->dialect->opcode[RTPSE_CMD_PORT_SET_PRIORITY];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	return rtpse_port_cmd(pse, id, opc->op, prio);
+}
+
+static const struct pse_controller_ops rtpse_ops = {
+	.pi_get_admin_state = rtpse_port_get_admin_state,
+	.pi_get_pw_status = rtpse_port_get_pw_status,
+	.pi_get_pw_class = rtpse_port_get_pw_class,
+	.pi_get_actual_pw = rtpse_port_get_actual_pw,
+	.pi_enable = rtpse_port_enable,
+	.pi_disable = rtpse_port_disable,
+	.pi_get_voltage = rtpse_port_get_voltage,
+	.pi_get_pw_limit = rtpse_port_get_pw_limit,
+	.pi_set_pw_limit = rtpse_port_set_pw_limit,
+	.pi_get_pw_limit_ranges = rtpse_port_get_pw_limit_ranges,
+	.pi_get_prio = rtpse_port_get_prio,
+	.pi_set_prio = rtpse_port_set_prio,
+};
+
+static int rtpse_discover(struct rtpse_ctrl *pse, struct rtpse_mcu_info *info)
+{
+	struct rtpse_mcu_ext_config ext_config;
+	unsigned long deadline;
+	int ret;
+
+	/*
+	 * The MCU may not answer on the bus yet right after power-up or
+	 * enable-gpios assertion: depending on the transport it either stays
+	 * silent (-ETIMEDOUT) or does not ACK its address at all (-ENXIO /
+	 * -EREMOTEIO). Retry within a bounded wall-time window so a slow boot
+	 * still probes, while a genuinely unresponsive MCU fails with its real
+	 * error instead of deferring forever and masking it.
+	 */
+	deadline = jiffies + msecs_to_jiffies(RTPSE_MCU_BOOT_TIMEOUT_MS);
+	do {
+		ret = rtpse_mcu_get_info(pse, info);
+		if (ret != -ETIMEDOUT && ret != -ENXIO &&
+		    ret != -EREMOTEIO && ret != -EAGAIN)
+			break;
+		msleep(RTPSE_MCU_BOOT_RETRY_MS);
+	} while (time_before(jiffies, deadline));
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
+
+	switch (info->device_id) {
+	case RTPSE_DEVICE_ID_RTL8238B:
+		pse->chip = &rtl8238b_info;
+		break;
+	case RTPSE_DEVICE_ID_RTL8239:
+		pse->chip = &rtl8239_info;
+		break;
+	case RTPSE_DEVICE_ID_RTL8239C:
+		pse->chip = &rtl8239c_info;
+		break;
+	case RTPSE_DEVICE_ID_BCM59111:
+		pse->chip = &bcm59111_info;
+		break;
+	case RTPSE_DEVICE_ID_BCM59121:
+		pse->chip = &bcm59121_info;
+		break;
+	default:
+		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
+				     info->device_id);
+	}
+
+	if (!info->max_ports || info->max_ports > RTPSE_MAX_PORTS)
+		return dev_err_probe(pse->dev, -EINVAL,
+				     "MCU reports invalid port count %u\n", info->max_ports);
+
+	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
+
+	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
+		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
+		 info->device_id, info->max_ports, ext_config.num_of_pses);
+	return 0;
+}
+
+static void rtpse_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+int rtpse_register(struct rtpse_ctrl *pse)
+{
+	const struct rtpse_match_data *match;
+	struct gpio_desc *enable_gpio;
+	struct rtpse_mcu_info info;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct rtpse_mcu_msg) != RTPSE_MCU_MSG_SIZE);
+
+	ret = devm_mutex_init(pse->dev, &pse->mutex);
+	if (ret)
+		return ret;
+
+	match = device_get_match_data(pse->dev);
+	if (!match)
+		return dev_err_probe(pse->dev, -ENODEV, "missing match data\n");
+	pse->dialect = match->dialect;
+
+	/*
+	 * Catch a dialect that forgot to set one of the required hooks at
+	 * probe time, rather than NULL-deref'ing later from a fast path.
+	 */
+	if (!pse->dialect ||
+	    !pse->dialect->parse_system_info ||
+	    !pse->dialect->parse_port_class ||
+	    !pse->dialect->mcu_type_str)
+		return dev_err_probe(pse->dev, -EINVAL,
+				     "dialect for chip is incomplete\n");
+
+	pse->poe_supply = devm_regulator_get(pse->dev, "power");
+	if (IS_ERR(pse->poe_supply))
+		return dev_err_probe(pse->dev, PTR_ERR(pse->poe_supply),
+				     "failed to get PoE supply\n");
+
+	enable_gpio = devm_gpiod_get_optional(pse->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(pse->dev, PTR_ERR(enable_gpio),
+				     "failed to get enable gpio\n");
+
+	ret = rtpse_discover(pse, &info);
+	if (ret)
+		return ret;
+
+	if (!info.system_enable) {
+		ret = rtpse_set_global_state(pse, true);
+		/* Dialects without a global-state concept (e.g. BCM) return
+		 * -EOPNOTSUPP; treat that as "no separate enable required".
+		 */
+		if (ret && ret != -EOPNOTSUPP)
+			return dev_err_probe(pse->dev, ret,
+					     "failed to enable PSE system\n");
+	}
+
+	ret = regulator_enable(pse->poe_supply);
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to enable PoE supply\n");
+
+	ret = devm_add_action_or_reset(pse->dev, rtpse_regulator_disable, pse->poe_supply);
+	if (ret)
+		return ret;
+
+	/*
+	 * Depending on the MCU firmware configuration (which might be different
+	 * for every board), it isn't known whether the PoE subsystem is active or
+	 * inactive by default. At this stage, the PSE chips might already deliver
+	 * power to PDs without any explicit enable.
+	 */
+
+	pse->pcdev.owner    = THIS_MODULE;
+	pse->pcdev.ops      = &rtpse_ops;
+	pse->pcdev.dev      = pse->dev;
+	pse->pcdev.types    = ETHTOOL_PSE_C33;
+	pse->pcdev.nr_lines = info.max_ports;
+	pse->pcdev.pis_prio_max = RTPSE_PORT_MAX_PRIORITY;
+	pse->pcdev.supp_budget_eval_strategies = PSE_BUDGET_EVAL_STRAT_DYNAMIC;
+
+	return devm_pse_controller_register(pse->dev, &pse->pcdev);
+}
+EXPORT_SYMBOL_GPL(rtpse_register);
+
+static int rtpse_rtl_parse_system_info(const u8 *payload, struct rtpse_mcu_info *info)
+{
+	info->max_ports = payload[1];
+	info->system_enable = (payload[2] == 0x1);
+	info->device_id = get_unaligned_be16(&payload[3]);
+	info->sw_ver = payload[5];
+	info->mcu_type = payload[6];
+	info->config_status = payload[7];
+	info->ext_ver = payload[8];
+	return 0;
+}
+
+static int rtpse_rtl_parse_port_class(const struct rtpse_port_status *status)
+{
+	/* Class lives in the upper nibble of sts2. */
+	return FIELD_GET(GENMASK(7, 4), status->sts2);
+}
+
+static const char *rtpse_rtl_mcu_type_str(unsigned int mcu_type)
+{
+	switch (mcu_type) {
+	case 0x00:	return "GigaDevice GD32F310";
+	case 0x01:	return "GigaDevice GD32F230";
+	case 0x02:	return "GigaDevice GD32F303";
+	case 0x03:	return "GigaDevice GD32F103";
+	case 0x04:	return "GigaDevice GD32E103";
+	case 0x10:	return "Nuvoton M0516";
+	case 0x11:	return "Nuvoton M0564";
+	case 0x12:	return "Nuvoton NUC029";
+	default:	return "unknown";
+	}
+}
+
+static int rtpse_bcm_parse_system_info(const u8 *payload, struct rtpse_mcu_info *info)
+{
+	info->max_ports = payload[1];
+	/* BCM has no explicit system_enable byte; the closest analog is the
+	 * "remote enable" bit in the system-status flags at payload[7].
+	 */
+	info->system_enable = !!(payload[7] & BIT(2));
+	info->device_id = get_unaligned_be16(&payload[3]);
+	info->sw_ver = payload[5];
+	info->mcu_type = payload[6];
+	info->config_status = payload[7];
+	info->ext_ver = payload[8];
+	return 0;
+}
+
+static int rtpse_bcm_parse_port_class(const struct rtpse_port_status *status)
+{
+	/* BCM puts the detected class in payload[3] (== sts3) directly.
+	 * Mask to the low nibble; class is 0..8 and any high bits would be
+	 * noise.
+	 */
+	return status->sts3 & 0x0f;
+}
+
+static const char *rtpse_bcm_mcu_type_str(unsigned int mcu_type)
+{
+	switch (mcu_type) {
+	case 0x00:	return "ST Micro ST32F100";
+	case 0x01:	return "Nuvoton M05xx LAN";
+	case 0x02:	return "ST Micro STF030C8";
+	case 0x03:	return "Nuvoton M058SAN";
+	case 0x04:	return "Nuvoton NUC122";
+	default:	return "unknown";
+	}
+}
+
+/* Map each logical command the core issues to its per-dialect opcode. */
+static const struct rtpse_mcu_dialect rtpse_dialect_rtk = {
+	.parse_system_info = rtpse_rtl_parse_system_info,
+	.parse_port_class  = rtpse_rtl_parse_port_class,
+	.mcu_type_str      = rtpse_rtl_mcu_type_str,
+	.opcode = {
+		[RTPSE_CMD_MCU_SET_GLOBAL_STATE]	= RTPSE_OP(0x00),
+		[RTPSE_CMD_MCU_GET_SYSTEM_INFO]		= RTPSE_OP(0x40),
+		[RTPSE_CMD_MCU_GET_EXT_CONFIG]		= RTPSE_OP(0x4a),
+
+		[RTPSE_CMD_PORT_ENABLE]			= RTPSE_OP(0x01),
+		[RTPSE_CMD_PORT_SET_POWER_LIMIT_TYPE]	= RTPSE_OP(0x12),
+		[RTPSE_CMD_PORT_SET_POWER_LIMIT]	= RTPSE_OP(0x13),
+		[RTPSE_CMD_PORT_SET_POWER_LIMIT_EXT]	= RTPSE_OP(0x14),
+		[RTPSE_CMD_PORT_SET_PRIORITY]		= RTPSE_OP(0x15),
+		[RTPSE_CMD_PORT_GET_STATUS]		= RTPSE_OP(0x42),
+		[RTPSE_CMD_PORT_GET_POWER_STATS]	= RTPSE_OP(0x44),
+		[RTPSE_CMD_PORT_GET_CONFIG]		= RTPSE_OP(0x48),
+		[RTPSE_CMD_PORT_GET_EXT_CONFIG]		= RTPSE_OP(0x49),
+	},
+};
+
+static const struct rtpse_mcu_dialect rtpse_dialect_bcm = {
+	.parse_system_info = rtpse_bcm_parse_system_info,
+	.parse_port_class  = rtpse_bcm_parse_port_class,
+	.mcu_type_str      = rtpse_bcm_mcu_type_str,
+	.opcode = {
+		[RTPSE_CMD_MCU_GET_SYSTEM_INFO]		= RTPSE_OP(0x20),
+		[RTPSE_CMD_MCU_GET_EXT_CONFIG]		= RTPSE_OP(0x2b),
+
+		[RTPSE_CMD_PORT_ENABLE]			= RTPSE_OP(0x00),
+		[RTPSE_CMD_PORT_SET_POWER_LIMIT_TYPE]	= RTPSE_OP(0x15),
+		[RTPSE_CMD_PORT_SET_POWER_LIMIT]	= RTPSE_OP(0x16),
+		[RTPSE_CMD_PORT_SET_PRIORITY]		= RTPSE_OP(0x1a),
+		[RTPSE_CMD_PORT_GET_STATUS]		= RTPSE_OP(0x21),
+		[RTPSE_CMD_PORT_GET_POWER_STATS]	= RTPSE_OP(0x30),
+		[RTPSE_CMD_PORT_GET_CONFIG]		= RTPSE_OP(0x25),
+		[RTPSE_CMD_PORT_GET_EXT_CONFIG]		= RTPSE_OP(0x26),
+	},
+};
+
+const struct rtpse_match_data rtpse_rtk_data = {
+	.dialect = &rtpse_dialect_rtk,
+	.i2c_proto_dt_required = true,
+};
+EXPORT_SYMBOL_GPL(rtpse_rtk_data);
+
+const struct rtpse_match_data rtpse_bcm_data = {
+	.dialect = &rtpse_dialect_bcm,
+};
+EXPORT_SYMBOL_GPL(rtpse_bcm_data);
+
+MODULE_DESCRIPTION("Realtek/Broadcom PSE MCU driver (core)");
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/pse-pd/realtek-pse-i2c.c b/drivers/net/pse-pd/realtek-pse-i2c.c
new file mode 100644
index 000000000000..8b9c31cbdfe9
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-i2c.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
+
+#include "realtek-pse.h"
+
+/*
+ * The core has already waited RTPSE_MCU_RESPONSE_MS before calling us, so
+ * the response is normally ready on the very first read. For commands the
+ * MCU produces more slowly, keep polling at the typical response cadence
+ * up to the worst-case ceiling.
+ */
+#define RTPSE_I2C_RETRY_MS	RTPSE_MCU_RESPONSE_MS
+#define RTPSE_I2C_MAX_TRIES	(RTPSE_MCU_RESPONSE_MAX_MS / RTPSE_I2C_RETRY_MS)
+
+static int rtpse_i2c_smbus_send(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+
+	/* Send opcode as SMBus command byte; remaining 11 bytes as block data */
+	return i2c_smbus_write_i2c_block_data(client, req->opcode, RTPSE_MCU_MSG_SIZE - 1,
+					      (u8 *)req + 1);
+}
+
+static int rtpse_i2c_smbus_recv(struct rtpse_ctrl *pse,
+				const struct rtpse_mcu_msg *req,
+				struct rtpse_mcu_msg *resp)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	int tries, ret;
+
+	for (tries = 0; tries < RTPSE_I2C_MAX_TRIES; tries++) {
+		if (tries > 0)
+			msleep(RTPSE_I2C_RETRY_MS);
+
+		/* MCU needs 0x00 as command byte for read */
+		ret = i2c_smbus_read_i2c_block_data(client, 0x00,
+						    RTPSE_MCU_MSG_SIZE,
+						    (u8 *)resp);
+		if (ret < 0)
+			return ret;
+		if (ret == RTPSE_MCU_MSG_SIZE && resp->opcode == req->opcode)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct rtpse_transport_ops rtpse_i2c_smbus_ops = {
+	.send = rtpse_i2c_smbus_send,
+	.recv = rtpse_i2c_smbus_recv,
+};
+
+static int rtpse_i2c_native_send(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	int ret;
+
+	ret = i2c_master_send(client, (const u8 *)req, RTPSE_MCU_MSG_SIZE);
+	if (ret < 0)
+		return ret;
+	return ret == RTPSE_MCU_MSG_SIZE ? 0 : -EIO;
+}
+
+static int rtpse_i2c_native_recv(struct rtpse_ctrl *pse,
+				 const struct rtpse_mcu_msg *req,
+				 struct rtpse_mcu_msg *resp)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	int tries, ret;
+
+	for (tries = 0; tries < RTPSE_I2C_MAX_TRIES; tries++) {
+		if (tries > 0)
+			msleep(RTPSE_I2C_RETRY_MS);
+
+		ret = i2c_master_recv(client, (u8 *)resp, RTPSE_MCU_MSG_SIZE);
+		if (ret < 0)
+			return ret;
+		if (ret == RTPSE_MCU_MSG_SIZE && resp->opcode == req->opcode)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct rtpse_transport_ops rtpse_i2c_native_ops = {
+	.send = rtpse_i2c_native_send,
+	.recv = rtpse_i2c_native_recv,
+};
+
+static int rtpse_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct rtpse_match_data *match;
+	struct rtpse_ctrl *pse;
+	bool use_native = false;
+	int ret;
+
+	match = device_get_match_data(dev);
+	if (!match)
+		return dev_err_probe(dev, -ENODEV, "missing match data\n");
+
+	if (rtpse_needs_i2c_proto(match)) {
+		const char *proto;
+
+		ret = device_property_read_string(dev, "realtek,i2c-protocol", &proto);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing required \"realtek,i2c-protocol\" property\n");
+
+		if (!strcmp(proto, "i2c"))
+			use_native = true;
+		else if (!strcmp(proto, "smbus"))
+			use_native = false;
+		else
+			return dev_err_probe(dev, -EINVAL,
+					     "unknown realtek,i2c-protocol \"%s\"\n", proto);
+	}
+
+	if (use_native) {
+		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+				"plain-I2C MCU protocol requires I2C-capable adapter\n");
+	} else {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+					     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+				"SMBus MCU protocol requires SMBus I2C-block support\n");
+	}
+
+	pse = devm_kzalloc(dev, sizeof(*pse), GFP_KERNEL);
+	if (!pse)
+		return -ENOMEM;
+
+	pse->dev = dev;
+	pse->transport = use_native ? &rtpse_i2c_native_ops : &rtpse_i2c_smbus_ops;
+
+	return rtpse_register(pse);
+}
+
+static const struct of_device_id rtpse_i2c_of_match[] = {
+	{ .compatible = "realtek,pse-mcu-rtk", .data = &rtpse_rtk_data },
+	{ .compatible = "realtek,pse-mcu-bcm", .data = &rtpse_bcm_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtpse_i2c_of_match);
+
+static struct i2c_driver rtpse_i2c_driver = {
+	.driver = {
+		.name		= "realtek-pse-i2c",
+		.of_match_table	= rtpse_i2c_of_match,
+	},
+	.probe		= rtpse_i2c_probe,
+};
+module_i2c_driver(rtpse_i2c_driver);
+
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_DESCRIPTION("Realtek/Broadcom PSE MCU driver (I2C transport)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/pse-pd/realtek-pse-uart.c b/drivers/net/pse-pd/realtek-pse-uart.c
new file mode 100644
index 000000000000..27fa7e0c3f95
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-uart.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/serdev.h>
+#include <linux/string.h>
+
+#include "realtek-pse.h"
+
+#define RTPSE_UART_BAUD_DEFAULT	19200
+#define RTPSE_UART_TX_TIMEOUT		msecs_to_jiffies(100)
+#define RTPSE_UART_RX_TIMEOUT		msecs_to_jiffies(RTPSE_MCU_RESPONSE_MAX_MS)
+
+struct rtpse_uart {
+	struct rtpse_ctrl pse;
+	struct serdev_device *serdev;
+	struct completion rx_done;
+	size_t rx_len;
+	u8 rx_buf[RTPSE_MCU_MSG_SIZE];
+};
+
+#define to_rtpse_uart(p)  container_of(p, struct rtpse_uart, pse)
+
+/*
+ * No frame alignment is performed here: a stray byte arriving during
+ * transmission, or a truncated/extra-byte frame, will misalign the next
+ * response. The misaligned frame then fails opcode/checksum validation
+ * in the core (-EBADMSG); the following _send resets rx_len and
+ * resyncs. Net cost is one lost transaction per glitch.
+ */
+static size_t rtpse_uart_receive(struct serdev_device *serdev,
+				 const u8 *buf, size_t count)
+{
+	struct rtpse_uart *ctx = serdev_device_get_drvdata(serdev);
+	size_t take;
+
+	take = min(count, sizeof(ctx->rx_buf) - ctx->rx_len);
+	if (take == 0)
+		return count;  /* drop overflow bytes */
+
+	memcpy(ctx->rx_buf + ctx->rx_len, buf, take);
+	ctx->rx_len += take;
+
+	if (ctx->rx_len == sizeof(ctx->rx_buf))
+		complete(&ctx->rx_done);
+
+	return take;
+}
+
+static const struct serdev_device_ops rtpse_uart_serdev_ops = {
+	.receive_buf = rtpse_uart_receive,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int rtpse_uart_send(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req)
+{
+	struct rtpse_uart *ctx = to_rtpse_uart(pse);
+	int written;
+
+	/* clear any leftover rx state before transmitting */
+	reinit_completion(&ctx->rx_done);
+	ctx->rx_len = 0;
+
+	written = serdev_device_write(ctx->serdev, (const u8 *)req, sizeof(*req),
+				      RTPSE_UART_TX_TIMEOUT);
+	if (written < 0)
+		return written;
+	if (written != sizeof(*req))
+		return -EIO;
+
+	return 0;
+}
+
+static int rtpse_uart_recv(struct rtpse_ctrl *pse,
+			   const struct rtpse_mcu_msg *req,
+			   struct rtpse_mcu_msg *resp)
+{
+	struct rtpse_uart *ctx = to_rtpse_uart(pse);
+
+	if (!wait_for_completion_timeout(&ctx->rx_done, RTPSE_UART_RX_TIMEOUT))
+		return -ETIMEDOUT;
+
+	if (ctx->rx_len != sizeof(*resp))
+		return -EIO;
+
+	memcpy(resp, ctx->rx_buf, sizeof(*resp));
+	return 0;
+}
+
+static const struct rtpse_transport_ops rtpse_uart_transport_ops = {
+	.send = rtpse_uart_send,
+	.recv = rtpse_uart_recv,
+};
+
+static int rtpse_uart_probe(struct serdev_device *serdev)
+{
+	u32 speed = RTPSE_UART_BAUD_DEFAULT;
+	struct device *dev = &serdev->dev;
+	struct rtpse_uart *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->serdev = serdev;
+	ctx->pse.dev = dev;
+	ctx->pse.transport = &rtpse_uart_transport_ops;
+	init_completion(&ctx->rx_done);
+
+	serdev_device_set_drvdata(serdev, ctx);
+	serdev_device_set_client_ops(serdev, &rtpse_uart_serdev_ops);
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to open serdev\n");
+
+	fwnode_property_read_u32(dev_fwnode(dev), "current-speed", &speed);
+	serdev_device_set_baudrate(serdev, speed);
+	serdev_device_set_flow_control(serdev, false);
+	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+
+	return rtpse_register(&ctx->pse);
+}
+
+static const struct of_device_id rtpse_uart_of_match[] = {
+	{ .compatible = "realtek,pse-mcu-rtk", .data = &rtpse_rtk_data },
+	{ .compatible = "realtek,pse-mcu-bcm", .data = &rtpse_bcm_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtpse_uart_of_match);
+
+static struct serdev_device_driver rtpse_uart_driver = {
+	.driver = {
+		.name = "realtek-pse-uart",
+		.of_match_table = rtpse_uart_of_match,
+	},
+	.probe  = rtpse_uart_probe,
+};
+module_serdev_device_driver(rtpse_uart_driver);
+
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_DESCRIPTION("Realtek/Broadcom PSE MCU driver (UART transport)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/pse-pd/realtek-pse.h b/drivers/net/pse-pd/realtek-pse.h
new file mode 100644
index 000000000000..812e62b1752b
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _REALTEK_PSE_H
+#define _REALTEK_PSE_H
+
+#include <linux/mutex.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/types.h>
+
+/*
+ * Time the MCU itself needs between accepting a request and having a
+ * response ready. These are properties of the MCU firmware, not of the
+ * underlying transport: the core paces transactions by RTPSE_MCU_RESPONSE_MS
+ * and both transports size their per-transaction recv ceiling from
+ * RTPSE_MCU_RESPONSE_MAX_MS, since some commands are documented as
+ * needing up to ~1s to produce a reply.
+ */
+#define RTPSE_MCU_RESPONSE_MS			25
+#define RTPSE_MCU_RESPONSE_MAX_MS		1000
+
+/*
+ * Total time to keep retrying the first MCU read at probe, and the pause
+ * between attempts. Right after enable-gpios is asserted the MCU may not
+ * answer on the bus yet; give it a bounded window to come up before
+ * declaring the probe failed.
+ */
+#define RTPSE_MCU_BOOT_TIMEOUT_MS		3000
+#define RTPSE_MCU_BOOT_RETRY_MS			100
+
+#define RTPSE_MCU_MSG_SIZE			12
+
+struct rtpse_mcu_msg {
+	u8 opcode;
+	u8 seq_num;
+	u8 payload[9];
+	u8 checksum;
+} __packed;
+
+/* Opaque to transports; defined in realtek-pse-core.c. */
+struct rtpse_mcu_dialect;
+struct rtpse_match_data;
+struct rtpse_chip_info;
+struct rtpse_ctrl;
+
+struct rtpse_transport_ops {
+	int (*send)(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req);
+	int (*recv)(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req,
+		    struct rtpse_mcu_msg *resp);
+};
+
+struct rtpse_ctrl {
+	struct device *dev;
+	struct pse_controller_dev pcdev;
+	struct mutex mutex; /* serializes MCU request/response transactions */
+	const struct rtpse_mcu_dialect *dialect;
+	const struct rtpse_chip_info *chip;
+	const struct rtpse_transport_ops *transport;
+
+	struct regulator *poe_supply;
+};
+
+int rtpse_register(struct rtpse_ctrl *pse);
+
+/* Whether the I2C transport must read "realtek,i2c-protocol" from DT. */
+bool rtpse_needs_i2c_proto(const struct rtpse_match_data *match);
+
+extern const struct rtpse_match_data rtpse_rtk_data;
+extern const struct rtpse_match_data rtpse_bcm_data;
+
+#endif
-- 
2.51.0


