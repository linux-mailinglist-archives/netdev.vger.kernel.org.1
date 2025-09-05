Return-Path: <netdev+bounces-220464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F4B46223
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27A1A6696A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76B23BCE7;
	Fri,  5 Sep 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8fjoRRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9D2749ED;
	Fri,  5 Sep 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096288; cv=none; b=HRTzgHuDmNLgdwSHzLUIIIUgqMamV7WTq9TpqVVaOOAFTsgvOluMqkH8nq5KUdyRii5vawKeHex41sND9MXmYC13EBygqWr1ivhJUD+lT/Y3oEFonkmCJWK0nAu8/HfNla65rlO2R36cXJ5jfayxX32PdDGU0+CNpJ2tmx3KCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096288; c=relaxed/simple;
	bh=4mNxFx03S+x5y2xAeF2XZGkziReXpfjvemAEamdcxf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtwAwOirzeTB6vXV66s4KXBmBd9H1Na54f+nQu3q20uAgJOEpnVjw239WMZSBgU454RTLv881G9wlS677yz8PTwfKK24SbwKGJROEXItd9w8EBIzSfyu6odIcxKin3pcWr3xsKaTA2IoZrz919thNRSuozWqz0zqpueMwbJUICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8fjoRRm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7724cacc32bso1977206b3a.0;
        Fri, 05 Sep 2025 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757096282; x=1757701082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfFmOysOOhjxNEKAgqjUG78luBsR/eiomj2c6cOwBqc=;
        b=R8fjoRRm5UPpOlJVWelvcWOc400H0oBpyBrcRV4YAI+keLDZr2rmsMQPn0OAeuhXcl
         M6Viie+aZt2O3VNIF40b+PdWoV/Rtcnd2QNKTTUKlE2HDUZ1o1G8VuB8V8/sqSJUu8Z5
         WPXXnWcnSWVuiiMoQ49oELkgj89IZFwojeHjMGIelh/K0Kin5PcViaZQMM2mzTfZFcwT
         nMsevvFSICe3+LVS7+CBXwox5U9gKJrsGQoVT8R1j6hi2/Q/85Bqn+8gMlVyGw0Wai7B
         8BQ6bJCSe2KPgkMWEQoxvuFntjvZCdtC20zbjQ9kxXmQmgbuLPB+GZFWlnQe3l4ZcZY0
         Dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096282; x=1757701082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfFmOysOOhjxNEKAgqjUG78luBsR/eiomj2c6cOwBqc=;
        b=iEPGuB4dnHr39zXDoIwu97j6Ql5zLp5nvA4jb+Uasv7ItlZegpFU4ix+SruzSErHVy
         Lh1txwgcMcgWOYor2t4ZjJx5RSOrgReJT2/sl8jpt2jf5ukqJWV8uJdPrAgBWzkJGPhG
         RFtoISEofKjJQ3BnFZB+F8cJR3qPthG6cn0V7UsU4L+/bKNUG150SifjDppMGu0TgiR6
         iVKmNyfcKUXHapohGiJ/9XnrfuPCjE06byppbNaFYtYUhpjygT9QPbhgT02j1eUxMKOu
         Fra2SjRx2BTF/eGHturfQ8wbQ1LYbmGmHJ1ybFFDOC1F9m0Eo0LPtuTfadKkuMRKmlQA
         mqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8XDtgOWFHIL4fzMs27Y3+Koyw/4nqK7QEhJSYvCVWMMVM9SXxrPr6dJdYDvaRIQE5eBh/J0jgKUHD+P02@vger.kernel.org, AJvYcCXE1KjqLTq3QL+7QrvkG5BktHuGtdAPLnOS/e+XW5Ce/IFiT3Xs0RyN7QP+1u5d8BFdYmw6beApmQmd@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5UeKkHGyGg0RPHsUirp9g/59WskUuBIvtCkr7H9r7emd0qBB
	+zPTnrhz0l0DWUha59QhliS4LGRabNcQP0IIKdULCXbhSATPLQc5+XpTVj3wAYzM2Aw=
X-Gm-Gg: ASbGncsdJOLb744+h7qGMyZMAIwxOBr58t2tlUYkaUcsYqFcE7uKfy17EWl75eZCoFz
	UMZxfsCHGtWtW3jqhe8/IfLPC2P/2mj5cFxMdWlWeJKIBA11G6p908mwqYOEi1O1Q9p1xvsPn4s
	5NBk1slH/AIy9wF6fOuh0zuNUOodUz0GmofQM/I27OSgcU7u1WmlrRkCwv3IdxUdvnDYaVMfGa/
	lT3V9gWeEF5InSqWnTJTaCGO0pF4nYESo2e4DL9kGIyH3XCM+jliJ/Nxv06zTJz2DJb9crh/ZIG
	iBXzdTzb1bA4ORDCxKVlRwyVtyEoCQBGFYRpdp7scXCz4Hoh3tTS8LAezchYCiwVC/+p+xTbYH5
	eP5sXxbilgPzCfQ9ev2/1QIy+4vzDlw==
X-Google-Smtp-Source: AGHT+IE4ZnDESYP2KghaHlyOpui/cgqegEUE0Di7a+QsycWx6cz7FJW8A+TGFxdhAse2XsxXvxobyQ==
X-Received: by 2002:a05:6a20:3ca7:b0:24f:22af:ea26 with SMTP id adf61e73a8af0-24f22afec1emr5621855637.45.1757096280950;
        Fri, 05 Sep 2025 11:18:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3282dd2sm19964031a12.44.2025.09.05.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:18:00 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Sat,  6 Sep 2025 02:17:23 +0800
Message-ID: <20250905181728.3169479-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905181728.3169479-1-mmyangfl@gmail.com>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT921x is a series of ethernet switches developed by Shanghai
Motorcomm Electronic Technology, including:

  - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs
  - YT9213NB / YT9214NB: 2 GbE PHYs
  - YT9218N / YT9218MB: 8 GbE PHYs

and up to 2 GMACs.

Driver verified on a stock wireless router with IPQ5018 + YT9215S.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/Kconfig  |    7 +
 drivers/net/dsa/Makefile |    1 +
 drivers/net/dsa/yt921x.c | 3004 ++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  593 ++++++++
 4 files changed, 3605 insertions(+)
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index ec759f8cb0e2..1b789daab34c 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -152,4 +152,11 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 	  This enables support for the Vitesse VSC7385, VSC7388, VSC7395
 	  and VSC7398 SparX integrated ethernet switches, connected over
 	  a CPU-attached address bus and work in memory-mapped I/O mode.
+
+config NET_DSA_YT921X
+	tristate "Motorcomm YT9215 ethernet switch chip support"
+	select NET_DSA_TAG_YT921X
+	help
+	  This enables support for the Motorcomm YT9215 ethernet switch
+	  chip.
 endmenu
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index cb9a97340e58..dc81769fa92b 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx-core.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
+obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
 obj-y				+= microchip/
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
new file mode 100644
index 000000000000..3d97346ba29e
--- /dev/null
+++ b/drivers/net/dsa/yt921x.c
@@ -0,0 +1,3004 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Motorcomm YT921x Switch
+ *
+ * Should work on YT9213/YT9214/YT9215/YT9218, but only tested on YT9215+SGMII,
+ * be sure to do your own checks before porting to another chip.
+ *
+ * Copyright (c) 2025 David Yang
+ */
+
+#include <linux/if_bridge.h>
+#include <linux/if_hsr.h>
+#include <linux/if_vlan.h>
+#include <linux/iopoll.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <net/dsa.h>
+
+#include "yt921x.h"
+
+#define MIB_DESC(_size, _offset, _name, _unstructured) \
+	{_size, _offset, _name, _unstructured}
+
+static const struct yt921x_mib_desc yt921x_mib_descs[] = {
+	MIB_DESC(1, 0x00, "RxBroadcast", false),	/* rx broadcast pkts */
+	MIB_DESC(1, 0x04, "RxPause", false),		/* rx pause pkts */
+	MIB_DESC(1, 0x08, "RxMulticast", false),	/* rx multicast pkts, excluding pause and OAM */
+	MIB_DESC(1, 0x0c, "RxCrcErr", false),		/* rx crc err pkts, len >= 64B */
+
+	MIB_DESC(1, 0x10, "RxAlignErr", false),		/* rx pkts with odd number of bytes */
+	MIB_DESC(1, 0x14, "RxUnderSizeErr", false),	/* rx crc ok pkts, len < 64B */
+	MIB_DESC(1, 0x18, "RxFragErr", false),		/* rx crc err pkts, len < 64B */
+	MIB_DESC(1, 0x1c, "RxPktSz64", false),		/* rx pkts, len == 64B */
+
+	MIB_DESC(1, 0x20, "RxPktSz65To127", false),	/* rx pkts, len >= 65B and <= 127B */
+	MIB_DESC(1, 0x24, "RxPktSz128To255", false),	/* rx pkts, len >= 128B and <= 255B */
+	MIB_DESC(1, 0x28, "RxPktSz256To511", false),	/* rx pkts, len >= 256B and <= 511B */
+	MIB_DESC(1, 0x2c, "RxPktSz512To1023", false),	/* rx pkts, len >= 512B and <= 1023B */
+
+	MIB_DESC(1, 0x30, "RxPktSz1024To1518", false),	/* rx pkts, len >= 1024B and <= 1518B */
+	MIB_DESC(1, 0x34, "RxPktSz1519ToMax", false),	/* rx pkts, len >= 1519B */
+	MIB_DESC(2, 0x38, "RxGoodBytes", false),	/* total bytes of rx ok pkts */
+	/* 0x3c */
+
+	MIB_DESC(2, 0x40, "RxBadBytes", true),		/* total bytes of rx err pkts */
+	/* 0x44 */
+	MIB_DESC(2, 0x48, "RxOverSzErr", false),	/* rx pkts, len > mac frame size */
+	/* 0x4c */
+
+	MIB_DESC(1, 0x50, "RxDropped", false),		/* rx dropped pkts, excluding crc err and pause */
+	MIB_DESC(1, 0x54, "TxBroadcast", false),	/* tx broadcast pkts */
+	MIB_DESC(1, 0x58, "TxPause", false),		/* tx pause pkts */
+	MIB_DESC(1, 0x5c, "TxMulticast", false),	/* tx multicast pkts, excluding pause and OAM */
+
+	MIB_DESC(1, 0x60, "TxUnderSizeErr", false),	/* tx pkts, len < 64B */
+	MIB_DESC(1, 0x64, "TxPktSz64", false),		/* tx pkts, len == 64B */
+	MIB_DESC(1, 0x68, "TxPktSz65To127", false),	/* tx pkts, len >= 65B and <= 127B */
+	MIB_DESC(1, 0x6c, "TxPktSz128To255", false),	/* tx pkts, len >= 128B and <= 255B */
+
+	MIB_DESC(1, 0x70, "TxPktSz256To511", false),	/* tx pkts, len >= 256B and <= 511B */
+	MIB_DESC(1, 0x74, "TxPktSz512To1023", false),	/* tx pkts, len >= 512B and <= 1023B */
+	MIB_DESC(1, 0x78, "TxPktSz1024To1518", false),	/* tx pkts, len >= 1024B and <= 1518B */
+	MIB_DESC(1, 0x7c, "TxPktSz1519ToMax", false),	/* tx pkts, len >= 1519B */
+
+	MIB_DESC(2, 0x80, "TxGoodBytes", false),	/* total bytes of tx ok pkts */
+	/* 0x84 */
+	MIB_DESC(2, 0x88, "TxCollision", false),	/* collisions before 64B */
+	/* 0x8c */
+
+	MIB_DESC(1, 0x90, "TxExcessiveCollistion", false),	/* aborted pkts due to too many colls */
+	MIB_DESC(1, 0x94, "TxMultipleCollision", false),	/* multiple collision for one pkt */
+	MIB_DESC(1, 0x98, "TxSingleCollision", false),	/* one collision for one pkt */
+	MIB_DESC(1, 0x9c, "TxPkt", false),		/* tx ok pkts */
+
+	MIB_DESC(1, 0xa0, "TxDeferred", false),		/* delayed pkts due to defer signal */
+	MIB_DESC(1, 0xa4, "TxLateCollision", false),	/* collisions after 64B */
+	MIB_DESC(1, 0xa8, "RxOAM", true),		/* rx OAM pkts */
+	MIB_DESC(1, 0xac, "TxOAM", true),		/* tx OAM pkts */
+};
+
+struct yt921x_info {
+	const char *name;
+	u16 major;
+	/* Unknown, seems to be plain enumeration */
+	u8 mode;
+	u8 extmode;
+	/* Ports with integral GbE PHYs, not including MCU Port 10 */
+	u16 internal_mask;
+	/* TODO: see comments in yt921x_dsa_phylink_get_caps() */
+	u16 external_mask;
+};
+
+static const struct yt921x_info yt921x_infos[] = {
+	{
+		"YT9215SC", YT9215_MAJOR, 1, 0,
+		YT921X_PORT_MASK_INT0_n(5),
+		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+	},
+	{
+		"YT9215S", YT9215_MAJOR, 2, 0,
+		YT921X_PORT_MASK_INT0_n(5),
+		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+	},
+	{
+		"YT9215RB", YT9215_MAJOR, 3, 0,
+		YT921X_PORT_MASK_INT0_n(5),
+		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+	},
+	{
+		"YT9214NB", YT9215_MAJOR, 3, 2,
+		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
+		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+	},
+	{
+		"YT9213NB", YT9215_MAJOR, 3, 3,
+		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
+		YT921X_PORT_MASK_EXT1,
+	},
+	{
+		"YT9218N", YT9218_MAJOR, 0, 0,
+		YT921X_PORT_MASK_INT0_n(8),
+		0,
+	},
+	{
+		"YT9218MB", YT9218_MAJOR, 1, 0,
+		YT921X_PORT_MASK_INT0_n(8),
+		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+	},
+	{}
+};
+
+#define YT921X_NAME	"yt921x"
+
+#define YT921X_VID_UNWARE	4095
+
+#define YT921X_POLL_SLEEP_US	10000
+#define YT921X_POLL_TIMEOUT_US	100000
+
+/* Interval should be:
+ *   - small enough to avoid overflow of 32bit MIBs
+ *   - large enough to avoid polling too often
+ *   - not too small to provide reasonably up-to-date stats
+ */
+#define YT921X_STATS_INTERVAL_JIFFIES	(3 * HZ)
+
+struct yt921x_reg_mdio {
+	struct mii_bus *bus;
+	int addr;
+	/* SWITCH_ID_1 / SWITCH_ID_0 of the device
+	 *
+	 * This is a way to multiplex multiple devices on the same MII phyaddr
+	 * and should be configurable in DT. However, MDIO core simply doesn't
+	 * allow multiple devices over one reg addr, so this is a fixed value
+	 * for now until a solution is found.
+	 *
+	 * Keep this because we need switchid to form MII regaddrs anyway.
+	 */
+	unsigned char switchid;
+};
+
+/* TODO: SPI/I2C */
+
+#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
+#define to_device(priv) ((priv)->ds.dev)
+
+/* Prepare for read/write operations. Not a lock primitive despite underlying
+ * implementations may perform a lock (could be a no-op if the bus supports
+ * native atomic operations on internal ASIC registers).
+ *
+ * To serialize register operations, use yt921x_lock() instead.
+ */
+static void yt921x_reg_acquire(struct yt921x_priv *priv)
+{
+	if (priv->smi_ops->acquire)
+		priv->smi_ops->acquire(priv->smi_ctx);
+}
+
+/* Release the bus before any time-consuming operations for other participants
+ * on the same bus, for example before read_poll_timeout().
+ */
+static void yt921x_reg_release(struct yt921x_priv *priv)
+{
+	if (priv->smi_ops->release)
+		priv->smi_ops->release(priv->smi_ctx);
+}
+
+static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
+{
+	return priv->smi_ops->read(priv->smi_ctx, reg, valp);
+}
+
+/* You should manage the bus ownership yourself and use yt921x_reg_read()
+ * directly, except for register polling with read_poll_timeout(); see examples
+ * below.
+ */
+static int yt921x_reg_read_managed(struct yt921x_priv *priv, u32 reg, u32 *valp)
+{
+	int res;
+
+	yt921x_reg_acquire(priv);
+	res = yt921x_reg_read(priv, reg, valp);
+	yt921x_reg_release(priv);
+
+	return res;
+}
+
+static int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
+{
+	return priv->smi_ops->write(priv->smi_ctx, reg, val);
+}
+
+static int
+yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	int res;
+	u32 v;
+	u32 u;
+
+	res = yt921x_reg_read(priv, reg, &v);
+	if (res)
+		return res;
+
+	u = v;
+	u &= ~mask;
+	u |= val;
+	if (u == v)
+		return 0;
+
+	return yt921x_reg_write(priv, reg, u);
+}
+
+static int yt921x_reg_set_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, 0, mask);
+}
+
+static int yt921x_reg_clear_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, 0);
+}
+
+static int
+yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
+}
+
+/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
+ * you are to write only the lower / upper 32 bits.
+ *
+ * There is no such restriction for reading, but we still provide 64-bit read
+ * wrappers so that we always handle u64 values.
+ */
+
+static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+{
+	u32 lo;
+	u32 hi;
+	int res;
+
+	res = yt921x_reg_read(priv, reg, &lo);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, reg + 4, &hi);
+	if (res)
+		return res;
+
+	*valp = ((u64)hi << 32) | lo;
+	return 0;
+}
+
+static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 val)
+{
+	int res;
+
+	res = yt921x_reg_write(priv, reg, (u32)val);
+	if (res)
+		return res;
+	return yt921x_reg_write(priv, reg + 4, (u32)(val >> 32));
+}
+
+static int
+yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, u64 mask, u64 val)
+{
+	int res;
+	u64 v;
+	u64 u;
+
+	res = yt921x_reg64_read(priv, reg, &v);
+	if (res)
+		return res;
+
+	u = v;
+	u &= ~mask;
+	u |= val;
+	if (u == v)
+		return 0;
+
+	return yt921x_reg64_write(priv, reg, u);
+}
+
+static int yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, u64 mask)
+{
+	return yt921x_reg64_update_bits(priv, reg, mask, 0);
+}
+
+static void yt921x_reg_mdio_acquire(void *context)
+{
+	struct yt921x_reg_mdio *mdio = context;
+	struct mii_bus *bus = mdio->bus;
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+}
+
+static void yt921x_reg_mdio_release(void *context)
+{
+	struct yt921x_reg_mdio *mdio = context;
+	struct mii_bus *bus = mdio->bus;
+
+	mutex_unlock(&bus->mdio_lock);
+}
+
+static void yt921x_reg_mdio_verify(u32 reg, u16 val, bool lo)
+{
+	const char *desc;
+
+	switch (val) {
+	case 0xfade:
+		desc = "which is likely from a non-existent register";
+		break;
+	case 0xdead:
+		desc = "which is likely a data race condition";
+		break;
+	default:
+		return;
+	}
+
+	/* Skip registers which are likely to have any valid values */
+	switch (reg) {
+	case YT921X_MAC_ADDR_HI2:
+	case YT921X_MAC_ADDR_LO4:
+	case YT921X_FDB_OUT0:
+	case YT921X_FDB_OUT1:
+		return;
+	}
+
+	pr_warn("%s: Read 0x%x at 0x%x %s32, %s; "
+		"consider reporting a bug if this happens again\n",
+		__func__, val, reg, lo ? "lo" : "hi", desc);
+}
+
+static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
+{
+	struct yt921x_reg_mdio *mdio = context;
+	struct mii_bus *bus = mdio->bus;
+	int addr = mdio->addr;
+	u32 reg_addr;
+	u32 reg_data;
+	u32 val;
+	int res;
+
+	WARN_ON(!mutex_is_locked(&bus->mdio_lock));
+
+	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
+		   YT921X_SMI_READ;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)(reg >> 16));
+	if (res)
+		return res;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)reg);
+	if (res)
+		return res;
+
+	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
+		   YT921X_SMI_READ;
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		return res;
+	yt921x_reg_mdio_verify(reg, res, false);
+	val = (u16)res;
+	res = __mdiobus_read(bus, addr, reg_data);
+	if (res < 0)
+		return res;
+	yt921x_reg_mdio_verify(reg, res, true);
+	val = (val << 16) | (u16)res;
+
+	*valp = val;
+	return 0;
+}
+
+static int yt921x_reg_mdio_write(void *context, u32 reg, u32 val)
+{
+	struct yt921x_reg_mdio *mdio = context;
+	struct mii_bus *bus = mdio->bus;
+	int addr = mdio->addr;
+	u32 reg_addr;
+	u32 reg_data;
+	int res;
+
+	WARN_ON(!mutex_is_locked(&bus->mdio_lock));
+
+	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
+		   YT921X_SMI_WRITE;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)(reg >> 16));
+	if (res)
+		return res;
+	res = __mdiobus_write(bus, addr, reg_addr, (u16)reg);
+	if (res)
+		return res;
+
+	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
+		   YT921X_SMI_WRITE;
+	res = __mdiobus_write(bus, addr, reg_data, (u16)(val >> 16));
+	if (res)
+		return res;
+	res = __mdiobus_write(bus, addr, reg_data, (u16)val);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
+	.acquire = yt921x_reg_mdio_acquire,
+	.release = yt921x_reg_mdio_release,
+	.read = yt921x_reg_mdio_read,
+	.write = yt921x_reg_mdio_write,
+};
+
+/* TODO: SPI/I2C */
+
+/* Acquire the exclusive ownership of the driver AND prepare the bus for
+ * register operations. Do not lock priv->lock alone unless you do not modify
+ * registers for sure.
+ */
+static void yt921x_lock(struct yt921x_priv *priv)
+{
+	mutex_lock(&priv->lock);
+	yt921x_reg_acquire(priv);
+}
+
+static void yt921x_unlock(struct yt921x_priv *priv)
+{
+	yt921x_reg_release(priv);
+	mutex_unlock(&priv->lock);
+}
+
+static int yt921x_intif_wait(struct yt921x_priv *priv)
+{
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_INT_MBUS_OP, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_MBUS_OP_START) != 0) {
+		yt921x_reg_release(priv);
+		res = read_poll_timeout(yt921x_reg_read_managed, res,
+					(val & YT921X_MBUS_OP_START) == 0,
+					YT921X_POLL_SLEEP_US,
+					YT921X_POLL_TIMEOUT_US,
+					true, priv, YT921X_INT_MBUS_OP, &val);
+		yt921x_reg_acquire(priv);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_READ;
+	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_INT_MBUS_DIN, &val);
+	if (res)
+		return res;
+
+	if ((u16)val != val)
+		dev_err(dev,
+			"%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
+			__func__, port, reg, val);
+	*valp = (u16)val;
+	return 0;
+}
+
+static int
+yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+{
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_intif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_WRITE;
+	res = yt921x_reg_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_DOUT, val);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	return yt921x_intif_wait(priv);
+}
+
+static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	u16 val;
+	int res;
+
+	if (port >= YT921X_PORT_NUM)
+		return 0xffff;
+
+	yt921x_lock(priv);
+	res = yt921x_intif_read(priv, port, reg, &val);
+	yt921x_unlock(priv);
+
+	if (res)
+		return res;
+	return val;
+}
+
+static int
+yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	int res;
+
+	if (port >= YT921X_PORT_NUM)
+		return 0;
+
+	yt921x_lock(priv);
+	res = yt921x_intif_write(priv, port, reg, data);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
+{
+	struct device *dev = to_device(priv);
+	struct mii_bus *mbus;
+	int res;
+
+	mbus = devm_mdiobus_alloc(dev);
+	if (!mbus)
+		return -ENOMEM;
+
+	mbus->name = "YT921x internal MDIO bus";
+	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	mbus->priv = priv;
+	mbus->read = yt921x_mbus_int_read;
+	mbus->write = yt921x_mbus_int_write;
+	mbus->parent = dev;
+	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
+
+	if (!mnp)
+		res = devm_mdiobus_register(dev, mbus);
+	else
+		res = devm_of_mdiobus_register(dev, mbus, mnp);
+	if (res)
+		return res;
+
+	priv->mbus_int = mbus;
+
+	return 0;
+}
+
+static int yt921x_extif_wait(struct yt921x_priv *priv)
+{
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_EXT_MBUS_OP, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_MBUS_OP_START) != 0) {
+		yt921x_reg_release(priv);
+		res = read_poll_timeout(yt921x_reg_read_managed, res,
+					(val & YT921X_MBUS_OP_START) == 0,
+					YT921X_POLL_SLEEP_US,
+					YT921X_POLL_TIMEOUT_US,
+					true, priv, YT921X_EXT_MBUS_OP, &val);
+		yt921x_reg_acquire(priv);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_extif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_READ;
+	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_EXT_MBUS_DIN, &val);
+	if (res)
+		return res;
+
+	if ((u16)val != val)
+		dev_err(dev,
+			"%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
+			__func__, port, reg, val);
+	*valp = (u16)val;
+	return 0;
+}
+
+static int
+yt921x_extif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+{
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_extif_wait(priv);
+	if (res)
+		return res;
+
+	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
+	       YT921X_MBUS_CTRL_TYPE_M | YT921X_MBUS_CTRL_OP_M;
+	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
+	       YT921X_MBUS_CTRL_TYPE_C22 | YT921X_MBUS_CTRL_WRITE;
+	res = yt921x_reg_update_bits(priv, YT921X_EXT_MBUS_CTRL, mask, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_DOUT, val);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_EXT_MBUS_OP, YT921X_MBUS_OP_START);
+	if (res)
+		return res;
+
+	return yt921x_extif_wait(priv);
+}
+
+static int yt921x_mbus_ext_read(struct mii_bus *mbus, int port, int reg)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	u16 val;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_extif_read(priv, port, reg, &val);
+	yt921x_unlock(priv);
+
+	if (res)
+		return res;
+	return val;
+}
+
+static int
+yt921x_mbus_ext_write(struct mii_bus *mbus, int port, int reg, u16 data)
+{
+	struct yt921x_priv *priv = mbus->priv;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_extif_write(priv, port, reg, data);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
+{
+	struct device *dev = to_device(priv);
+	struct mii_bus *mbus;
+	int res;
+
+	mbus = devm_mdiobus_alloc(dev);
+	if (!mbus)
+		return -ENOMEM;
+
+	mbus->name = "YT921x external MDIO bus";
+	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s@ext", dev_name(dev));
+	mbus->priv = priv;
+	/* TODO: c45? */
+	mbus->read = yt921x_mbus_ext_read;
+	mbus->write = yt921x_mbus_ext_write;
+	mbus->parent = dev;
+
+	if (!mnp)
+		res = devm_mdiobus_register(dev, mbus);
+	else
+		res = devm_of_mdiobus_register(dev, mbus, mnp);
+	if (res)
+		return res;
+
+	priv->mbus_ext = mbus;
+
+	return 0;
+}
+
+static int yt921x_mib_read(struct yt921x_priv *priv, int port, void *data)
+{
+	unsigned char *buf = data;
+	int res = 0;
+
+	for (size_t i = 0; i < sizeof(struct yt921x_mib_raw);
+	     i += sizeof(u32)) {
+		res = yt921x_reg_read(priv, YT921X_MIBn_DATA0(port) + i,
+				      (u32 *)&buf[i]);
+		if (res)
+			break;
+	}
+	return res;
+}
+
+static void yt921x_poll_mib(struct work_struct *work)
+{
+	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
+						    mib_read.work);
+	struct yt921x_priv *priv = (void *)(pp - pp->index) -
+				   offsetof(struct yt921x_priv, ports);
+	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
+	struct device *dev = to_device(priv);
+	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_raw raw;
+	int port = pp->index;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_mib_read(priv, port, &raw);
+	yt921x_unlock(priv);
+
+	if (res) {
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+		delay *= 4;
+		goto end;
+	}
+
+	spin_lock(&pp->stats_lock);
+
+	/* Handle overflow of 32bit MIBs */
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+		u32 *rawp = (u32 *)((u8 *)&raw + desc->offset);
+		u64 *valp = &((u64 *)mib)[i];
+		u64 newval;
+
+		if (desc->size > 1) {
+			newval = ((u64)rawp[0] << 32) | rawp[1];
+		} else {
+			newval = (*valp & ~(u64)U32_MAX) | *rawp;
+			if (*rawp < (u32)*valp)
+				newval += (u64)1 << 32;
+		}
+
+		*valp = newval;
+	}
+
+	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
+			mib->rx_128_255byte + mib->rx_256_511byte +
+			mib->rx_512_1023byte + mib->rx_1024_1518byte +
+			mib->rx_jumbo;
+	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
+			mib->tx_128_255byte + mib->tx_256_511byte +
+			mib->tx_512_1023byte + mib->tx_1024_1518byte +
+			mib->tx_jumbo;
+
+	spin_unlock(&pp->stats_lock);
+
+end:
+	schedule_delayed_work(&pp->mib_read, delay);
+}
+
+static void
+yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+		       uint8_t *data)
+{
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (desc->unstructured)
+			ethtool_puts(&data, desc->name);
+	}
+}
+
+static void
+yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+	size_t j;
+
+	spin_lock(&pp->stats_lock);
+
+	j = 0;
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (!desc->unstructured)
+			continue;
+
+		data[j] = ((u64 *)mib)[i];
+		j++;
+	}
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	int cnt;
+
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	cnt = 0;
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (desc->unstructured)
+			cnt++;
+	}
+
+	return cnt;
+}
+
+static void
+yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
+			     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+
+	spin_lock(&pp->stats_lock);
+
+	mac_stats->FramesTransmittedOK = pp->tx_frames;
+	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
+	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
+	mac_stats->FramesReceivedOK = pp->rx_frames;
+	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
+	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
+	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
+	mac_stats->FramesWithDeferredXmissions = mib->tx_deferred;
+	mac_stats->LateCollisions = mib->tx_late_collisions;
+	mac_stats->FramesAbortedDueToXSColls = mib->tx_aborted_errors;
+	/* mac_stats->FramesLostDueToIntMACXmitError */
+	/* mac_stats->CarrierSenseErrors */
+	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
+	/* mac_stats->FramesLostDueToIntMACRcvError */
+	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
+	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
+	/* mac_stats->FramesWithExcessiveDeferral */
+	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
+	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
+	/* mac_stats->InRangeLengthErrors */
+	/* mac_stats->OutOfRangeLengthField */
+	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static void
+yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+
+	spin_lock(&pp->stats_lock);
+
+	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
+	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	/* ctrl_stats->UnsupportedOpcodesReceived */
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, YT921X_FRAME_SIZE_MAX },
+	{}
+};
+
+static void
+yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
+			  struct ethtool_rmon_stats *rmon_stats,
+			  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+
+	*ranges = yt921x_rmon_ranges;
+
+	spin_lock(&pp->stats_lock);
+
+	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
+	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
+	rmon_stats->fragments = mib->rx_alignment_errors;
+	/* rmon_stats->jabbers */
+
+	rmon_stats->hist[0] = mib->rx_64byte;
+	rmon_stats->hist[1] = mib->rx_65_127byte;
+	rmon_stats->hist[2] = mib->rx_128_255byte;
+	rmon_stats->hist[3] = mib->rx_256_511byte;
+	rmon_stats->hist[4] = mib->rx_512_1023byte;
+	rmon_stats->hist[5] = mib->rx_1024_1518byte;
+	rmon_stats->hist[6] = mib->rx_jumbo;
+
+	rmon_stats->hist_tx[0] = mib->tx_64byte;
+	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
+	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
+	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
+	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
+	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
+	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static void
+yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
+		       struct rtnl_link_stats64 *stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+
+	spin_lock(&pp->stats_lock);
+
+	stats->rx_length_errors = mib->rx_undersize_errors +
+				  mib->rx_fragment_errors;
+	stats->rx_over_errors = mib->rx_oversize_errors;
+	stats->rx_crc_errors = mib->rx_crc_errors;
+	stats->rx_frame_errors = mib->rx_alignment_errors;
+	/* stats->rx_fifo_errors */
+	/* stats->rx_missed_errors */
+
+	stats->tx_aborted_errors = mib->tx_aborted_errors;
+	/* stats->tx_carrier_errors */
+	stats->tx_fifo_errors = mib->tx_undersize_errors;
+	/* stats->tx_heartbeat_errors */
+	stats->tx_window_errors = mib->tx_late_collisions;
+
+	stats->rx_packets = pp->rx_frames;
+	stats->tx_packets = pp->tx_frames;
+	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
+	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
+	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
+			   stats->rx_crc_errors + stats->rx_frame_errors;
+	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
+			   stats->tx_window_errors;
+	stats->rx_dropped = mib->rx_dropped;
+	/* stats->tx_dropped */
+	stats->multicast = mib->rx_multicast;
+	stats->collisions = mib->tx_collisions;
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static void
+yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
+			   struct ethtool_pause_stats *pause_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib = &pp->mib;
+
+	spin_lock(&pp->stats_lock);
+
+	pause_stats->tx_pause_frames = mib->tx_pause;
+	pause_stats->rx_pause_frames = mib->rx_pause;
+
+	spin_unlock(&pp->stats_lock);
+}
+
+static int
+yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
+{
+	struct device *dev = to_device(priv);
+	bool enable = e->eee_enabled;
+	u16 new_mask;
+	int res;
+
+	/* Enable / disable global EEE */
+	new_mask = priv->eee_ports_mask;
+	new_mask &= ~BIT(port);
+	new_mask |= !enable ? 0 : BIT(port);
+
+	if (!!new_mask != !!priv->eee_ports_mask) {
+		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_FUNC,
+					     YT921X_PON_STRAP_EEE, !!new_mask);
+		if (res)
+			return res;
+		res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_VAL,
+					     YT921X_PON_STRAP_EEE, !!new_mask);
+		if (res)
+			return res;
+	}
+
+	priv->eee_ports_mask = new_mask;
+
+	/* Enable / disable port EEE */
+	res = yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
+				     YT921X_EEE_CTRL_ENn(port), enable);
+	if (res)
+		return res;
+	res = yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
+				     YT921X_EEE_VAL_DATA, enable);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+
+	return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) != 0;
+}
+
+static int
+yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_set_eee(priv, port, e);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	/* Only serves as packet filter, since the frame size is always set to
+	 * maximum after reset
+	 */
+
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct device *dev = to_device(priv);
+	int frame_size;
+	int res;
+
+	frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN;
+	if (dsa_port_is_cpu(dp))
+		frame_size += YT921X_TAG_LEN;
+
+	yt921x_lock(priv);
+	res = yt921x_reg_update_bits(priv, YT921X_MACn_FRAME(port),
+				     YT921X_MAC_FRAME_SIZE_M,
+				     YT921X_MAC_FRAME_SIZE(frame_size));
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	/* Only called for user ports, exclude tag len here */
+	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
+}
+
+static void
+yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 mask;
+	int res;
+
+	yt921x_lock(priv);
+	if (mirror->ingress)
+		mask = YT921X_MIRROR_IGR_PORTn(port);
+	else
+		mask = YT921X_MIRROR_EGR_PORTn(port);
+	res = yt921x_reg_clear_bits(priv, YT921X_MIRROR, mask);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
+			port, res);
+}
+
+static int
+yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
+			   struct dsa_mall_mirror_tc_entry *mirror,
+			   bool ingress, struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	yt921x_lock(priv);
+	do {
+		u32 srcs;
+		u32 dst;
+
+		if (ingress)
+			srcs = YT921X_MIRROR_IGR_PORTn(port);
+		else
+			srcs = YT921X_MIRROR_EGR_PORTn(port);
+		dst = YT921X_MIRROR_PORT(mirror->to_local_port);
+
+		res = yt921x_reg_read(priv, YT921X_MIRROR, &val);
+		if (res)
+			break;
+
+		/* other mirror tasks & different dst port -> conflict */
+		if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
+				    YT921X_MIRROR_IGR_PORTS_M)) != 0 &&
+		    (val & YT921X_MIRROR_PORT_M) != dst) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Sniffer port is already configured,"
+					   " delete existing rules & retry");
+			res = -EBUSY;
+			break;
+		}
+
+		ctrl = val & ~YT921X_MIRROR_PORT_M;
+		ctrl |= srcs;
+		ctrl |= dst;
+
+		if (ctrl != val)
+			res = yt921x_reg_write(priv, YT921X_MIRROR, ctrl);
+	} while (0);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
+{
+	struct device *dev = to_device(priv);
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_FDB_RESULT, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_FDB_RESULT_DONE) == 0) {
+		yt921x_reg_release(priv);
+		res = read_poll_timeout(yt921x_reg_read_managed, res,
+					(val & YT921X_FDB_RESULT_DONE) != 0,
+					YT921X_POLL_SLEEP_US,
+					YT921X_POLL_TIMEOUT_US,
+					true, priv, YT921X_FDB_RESULT,
+					&val);
+		yt921x_reg_acquire(priv);
+		if (res) {
+			dev_err(dev, "FDB probably stucked\n");
+			return res;
+		}
+	}
+
+	*valp = val;
+	return 0;
+}
+
+static int
+yt921x_fdb_in01(struct yt921x_priv *priv, const unsigned char *addr,
+		u16 vid, u32 ctrl1)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+	res = yt921x_reg_write(priv, YT921X_FDB_IN0, ctrl);
+	if (res)
+		return res;
+
+	ctrl = ctrl1 | YT921X_FDB_IO1_FID(vid) | (addr[4] << 8) | addr[5];
+	return yt921x_reg_write(priv, YT921X_FDB_IN1, ctrl);
+}
+
+static int
+yt921x_fdb_has(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
+	       u16 *indexp)
+{
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_fdb_in01(priv, addr, vid, 0);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	res = yt921x_reg_write(priv, YT921X_FDB_IN2, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_FDB_OP_OP_GET_ONE | YT921X_FDB_OP_START;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_FDB_RESULT_NOTFOUND) != 0) {
+		*indexp = YT921X_FDB_NUM;
+		return 0;
+	}
+
+	*indexp = FIELD_GET(YT921X_FDB_RESULT_INDEX_M, val);
+	return 0;
+}
+
+static int
+yt921x_fdb_read(struct yt921x_priv *priv, unsigned char *addr, u16 *vidp,
+		u16 *ports_maskp, u16 *indexp, u8 *statusp)
+{
+	struct device *dev = to_device(priv);
+	u16 index;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 val;
+	int res;
+
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_FDB_RESULT_NOTFOUND) != 0) {
+		*ports_maskp = 0;
+		return 0;
+	}
+	index = FIELD_GET(YT921X_FDB_RESULT_INDEX_M, val);
+
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &data1);
+	if (res)
+		return res;
+	if ((data1 & YT921X_FDB_IO1_STATUS_M) ==
+	    YT921X_FDB_IO1_STATUS_INVALID) {
+		*ports_maskp = 0;
+		return 0;
+	}
+
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT0, &data0);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT2, &data2);
+	if (res)
+		return res;
+
+	addr[0] = data0 >> 24;
+	addr[1] = data0 >> 16;
+	addr[2] = data0 >> 8;
+	addr[3] = data0;
+	addr[4] = data1 >> 8;
+	addr[5] = data1;
+	*vidp = FIELD_GET(YT921X_FDB_IO1_FID_M, data1);
+	*indexp = index;
+	*ports_maskp = FIELD_GET(YT921X_FDB_IO2_EGR_PORTS_M, data2);
+	*statusp = FIELD_GET(YT921X_FDB_IO1_STATUS_M, data1);
+
+	dev_dbg(dev,
+		"%s: index 0x%x, mac %02x:%02x:%02x:%02x:%02x:%02x, "
+		"vid %d, ports 0x%x, status %d\n",
+		__func__, *indexp, addr[0], addr[1], addr[2], addr[3],
+		addr[4], addr[5], *vidp, *ports_maskp, *statusp);
+	return 0;
+}
+
+static int
+yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
+		dsa_fdb_dump_cb_t *cb, void *data)
+{
+	unsigned char addr[ETH_ALEN];
+	u8 status;
+	u16 pmask;
+	u16 index;
+	u32 ctrl;
+	u16 vid;
+	int res;
+
+	ctrl = YT921X_FDB_OP_INDEX(0) | YT921X_FDB_OP_MODE_INDEX |
+	       YT921X_FDB_OP_OP_GET_ONE | YT921X_FDB_OP_START;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+	res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index, &status);
+	if (res)
+		return res;
+	if ((pmask & ports_mask) != 0 && (addr[0] & 1) == 0) {
+		res = cb(addr, vid,
+			 status == YT921X_FDB_ENTRY_STATUS_STATIC, data);
+		if (res)
+			return res;
+	}
+
+	ctrl = YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	res = yt921x_reg_write(priv, YT921X_FDB_IN2, ctrl);
+	if (res)
+		return res;
+
+	index = 0;
+	do {
+		ctrl = YT921X_FDB_OP_INDEX(index) | YT921X_FDB_OP_MODE_INDEX |
+		       YT921X_FDB_OP_NEXT_TYPE_UCAST_PORT |
+		       YT921X_FDB_OP_OP_GET_NEXT | YT921X_FDB_OP_START;
+		res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+		if (res)
+			return res;
+
+		res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index,
+				      &status);
+		if (res)
+			return res;
+		if (!pmask)
+			break;
+
+		if ((pmask & ports_mask) != 0 && (addr[0] & 1) == 0) {
+			res = cb(addr, vid,
+				 status == YT921X_FDB_ENTRY_STATUS_STATIC,
+				 data);
+			if (res)
+				return res;
+		}
+
+		/* Never call GET_NEXT with 4095, otherwise it will hang
+		 * forever until a reset!
+		 */
+	} while (index < YT921X_FDB_NUM - 1);
+
+	return 0;
+}
+
+static int
+yt921x_fdb_flush_raw(struct yt921x_priv *priv, u16 ports_mask, u16 vid,
+		     bool flush_static)
+{
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	if (vid < 4096) {
+		ctrl = YT921X_FDB_IO1_FID(vid);
+		res = yt921x_reg_write(priv, YT921X_FDB_IN1, ctrl);
+		if (res)
+			return res;
+	}
+
+	ctrl = YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	res = yt921x_reg_write(priv, YT921X_FDB_IN2, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_FDB_OP_OP_FLUSH | YT921X_FDB_OP_START;
+	if (vid >= 4096)
+		ctrl |= YT921X_FDB_OP_FLUSH_PORT;
+	else
+		ctrl |= YT921X_FDB_OP_FLUSH_PORT_VID;
+	if (flush_static)
+		ctrl |= YT921X_FDB_OP_FLUSH_STATIC;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_fdb_flush_port(struct yt921x_priv *priv, int port, bool flush_static)
+{
+	return yt921x_fdb_flush_raw(priv, BIT(port), 4096, flush_static);
+}
+
+static int
+yt921x_fdb_add_index_in12(struct yt921x_priv *priv, u16 index, u16 ctrl1,
+			  u16 ctrl2)
+{
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	res = yt921x_reg_write(priv, YT921X_FDB_IN1, ctrl1);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_FDB_IN2, ctrl2);
+	if (res)
+		return res;
+
+	ctrl = YT921X_FDB_OP_INDEX(index) | YT921X_FDB_OP_MODE_INDEX |
+	       YT921X_FDB_OP_OP_ADD | YT921X_FDB_OP_START;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+
+	return yt921x_fdb_wait(priv, &val);
+}
+
+static int
+yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
+	       u16 ports_mask)
+{
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	ctrl = YT921X_FDB_IO1_STATUS_STATIC;
+	res = yt921x_fdb_in01(priv, addr, vid, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	res = yt921x_reg_write(priv, YT921X_FDB_IN2, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_FDB_OP_OP_ADD | YT921X_FDB_OP_START;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+
+	return yt921x_fdb_wait(priv, &val);
+}
+
+static int
+yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
+		 u16 vid, u16 ports_mask)
+{
+	u16 index;
+	u32 ctrl1;
+	u32 ctrl2;
+	u32 ctrl;
+	u32 val2;
+	u32 val;
+	int res;
+
+	/* Check for presence */
+	res = yt921x_fdb_has(priv, addr, vid, &index);
+	if (res)
+		return res;
+	if (index >= YT921X_FDB_NUM)
+		return 0;
+
+	/* Check if action required */
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT2, &val2);
+	if (res)
+		return res;
+
+	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	if (ctrl2 == val2)
+		return 0;
+	if ((ctrl2 & YT921X_FDB_IO2_EGR_PORTS_M) == 0) {
+		ctrl = YT921X_FDB_OP_OP_DEL | YT921X_FDB_OP_START;
+		res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+		if (res)
+			return res;
+
+		return yt921x_fdb_wait(priv, &val);
+	}
+
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &ctrl1);
+	if (res)
+		return res;
+
+	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+}
+
+static int
+yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
+		u16 ports_mask)
+{
+	u16 index;
+	u32 ctrl1;
+	u32 ctrl2;
+	u32 val1;
+	u32 val2;
+	int res;
+
+	/* Check for presence */
+	res = yt921x_fdb_has(priv, addr, vid, &index);
+	if (res)
+		return res;
+	if (index >= YT921X_FDB_NUM)
+		return yt921x_fdb_add(priv, addr, vid, ports_mask);
+
+	/* Check if action required */
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &val1);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT2, &val2);
+	if (res)
+		return res;
+
+	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
+	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
+	ctrl2 = val2 | YT921X_FDB_IO2_EGR_PORTS(ports_mask);
+	if (ctrl1 == val1 && ctrl2 == val2)
+		return 0;
+
+	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+}
+
+static int
+yt921x_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
+			 dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	yt921x_lock(priv);
+	/* Hardware FDB is shared for fdb and mdb, "bridge fdb show"
+	 * only wants to see unicast
+	 */
+	res = yt921x_fdb_dump(priv, BIT(port), cb, data);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_fdb_flush_port(priv, port, false);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "clear FDB for",
+			port, res);
+}
+
+static int
+yt921x_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 ctrl;
+	int res;
+
+	/* AGEING reg is set in 5s step */
+	ctrl = msecs / 5000;
+
+	/* Handle case with 0 as val to NOT disable learning */
+	if (!ctrl)
+		ctrl = 1;
+	else if (ctrl > 0xffff)
+		ctrl = 0xffff;
+
+	yt921x_lock(priv);
+	res = yt921x_reg_write(priv, YT921X_AGEING, ctrl);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_fdb_del(struct dsa_switch *ds, int port,
+			const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_fdb_leave(priv, addr, vid, BIT(port));
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_fdb_add(struct dsa_switch *ds, int port,
+			const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_fdb_join(priv, addr, vid, BIT(port));
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_mdb_del(struct dsa_switch *ds, int port,
+			const struct switchdev_obj_port_mdb *mdb,
+			struct dsa_db db)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const unsigned char *addr = mdb->addr;
+	struct device *dev = to_device(priv);
+	u16 vid = mdb->vid;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_fdb_leave(priv, addr, vid, BIT(port));
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
+			const struct switchdev_obj_port_mdb *mdb,
+			struct dsa_db db)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const unsigned char *addr = mdb->addr;
+	struct device *dev = to_device(priv);
+	u16 vid = mdb->vid;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_fdb_join(priv, addr, vid, BIT(port));
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	u16 pvid;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_PORT_VLAN_CTRL_CVID_M;
+	if (!vlan_filtering || !dp->bridge) {
+		ctrl = YT921X_PORT_VLAN_CTRL_CVID(YT921X_VID_UNWARE);
+	} else {
+		br_vlan_get_pvid(dp->bridge->dev, &pvid);
+		ctrl = YT921X_PORT_VLAN_CTRL_CVID(pvid);
+	}
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
+				     mask, ctrl);
+	if (res)
+		return res;
+
+	mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED |
+	       YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
+	ctrl = 0;
+	if (vlan_filtering) {
+		/* Do not drop tagged frames here; let VLAN_IGR_FILTER do it */
+		if (!pvid)
+			ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
+	}
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL1(port),
+				     mask, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_reg_toggle_bits(priv, YT921X_VLAN_IGR_FILTER,
+				     YT921X_VLAN_IGR_FILTER_PORTn(port),
+				     vlan_filtering);
+	if (res)
+		return res;
+
+	/* Turn on / off VLAN awareness */
+	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
+	if (!vlan_filtering)
+		ctrl = 0;
+	else
+		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
+				     mask, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
+{
+	u64 mask64;
+
+	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
+		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+
+	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
+}
+
+static int
+yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
+{
+	u64 mask64;
+	u64 ctrl64;
+
+	mask64 = YT921X_VLAN_CTRL_PORTn(port) |
+		 YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
+	ctrl64 = mask64;
+
+	mask64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	if (untagged)
+		ctrl64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+
+	return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
+					mask64, ctrl64);
+}
+
+static int
+yt921x_pvid_clear(struct yt921x_priv *priv, int port)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	bool vlan_filtering;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	vlan_filtering = dsa_port_is_vlan_filtering(dp);
+
+	mask = YT921X_PORT_VLAN_CTRL_CVID_M;
+	if (!vlan_filtering)
+		ctrl = YT921X_PORT_VLAN_CTRL_CVID(YT921X_VID_UNWARE);
+	else
+		ctrl = YT921X_PORT_VLAN_CTRL_CVID(0);
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
+				     mask, ctrl);
+	if (res)
+		return res;
+
+	if (vlan_filtering) {
+		mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
+		res = yt921x_reg_set_bits(priv, YT921X_PORTn_VLAN_CTRL1(port),
+					  mask);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_pvid_set(struct yt921x_priv *priv, int port, u16 vid)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	bool vlan_filtering;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	vlan_filtering = dsa_port_is_vlan_filtering(dp);
+
+	if (vlan_filtering) {
+		mask = YT921X_PORT_VLAN_CTRL_CVID_M;
+		ctrl = YT921X_PORT_VLAN_CTRL_CVID(vid);
+		res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+	}
+
+	mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
+	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_VLAN_CTRL1(port), mask);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
+			       bool vlan_filtering,
+			       struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return 0;
+
+	yt921x_lock(priv);
+	res = yt921x_vlan_filtering(priv, port, vlan_filtering);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_vlan_del(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_vlan *vlan)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u16 vid = vlan->vid;
+	u16 pvid;
+	int res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return 0;
+
+	yt921x_lock(priv);
+	do {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+
+		res = yt921x_vlan_del(priv, port, vid);
+		if (res)
+			break;
+
+		if (dp->bridge) {
+			br_vlan_get_pvid(dp->bridge->dev, &pvid);
+			if (pvid == vid)
+				res = yt921x_pvid_clear(priv, port);
+		}
+	} while (0);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_vlan *vlan,
+			 struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u16 vid = vlan->vid;
+	u16 pvid;
+	int res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return 0;
+
+	yt921x_lock(priv);
+	do {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+
+		res = yt921x_vlan_add(priv, port, vid,
+				      (vlan->flags &
+				       BRIDGE_VLAN_INFO_UNTAGGED) != 0);
+		if (res)
+			break;
+
+		if (dp->bridge) {
+			if ((vlan->flags & BRIDGE_VLAN_INFO_PVID) != 0) {
+				res = yt921x_pvid_set(priv, port, vid);
+			} else {
+				br_vlan_get_pvid(dp->bridge->dev, &pvid);
+				if (pvid == vid)
+					res = yt921x_pvid_clear(priv, port);
+			}
+		}
+	} while (0);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	ctrl = ~priv->cpu_ports_mask;
+	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
+	if (res)
+		return res;
+	pp->bridge_mask = priv->cpu_ports_mask | BIT(port);
+
+	/* Turn off FDB learning to prevent FDB pollution */
+	mask = YT921X_PORT_LEARN_DIS;
+	res = yt921x_reg_set_bits(priv, YT921X_PORTn_LEARN(port), mask);
+	if (res)
+		return res;
+
+	/* Turn off VLAN awareness */
+	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
+	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_IGR_TPID(port), mask);
+	if (res)
+		return res;
+
+	mask = YT921X_PORT_VLAN_CTRL_CVID_M;
+	ctrl = YT921X_PORT_VLAN_CTRL_CVID(YT921X_VID_UNWARE);
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
+				     mask, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_fdb_flush_port(priv, port, true);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt921x_userport_bridge(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	mask = YT921X_PORT_LEARN_DIS;
+	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_LEARN(port), mask);
+	if (res)
+		return res;
+
+	res = yt921x_fdb_flush_port(priv, port, true);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt921x_isolate(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	mask = BIT(port);
+	for (int i = 0; i < YT921X_PORT_NUM; i++) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		if ((BIT(i) & priv->cpu_ports_mask) != 0 || i == port)
+			continue;
+
+		res = yt921x_reg_set_bits(priv, YT921X_PORTn_ISOLATION(i),
+					  mask);
+		if (res)
+			return res;
+
+		pp->bridge_mask &= ~mask;
+	}
+
+	return 0;
+}
+
+/* Make sure to include the CPU port in ports_mask, or your bridge will
+ * not have it.
+ */
+static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
+{
+	unsigned long targets_mask = ports_mask & ~priv->cpu_ports_mask;
+	u32 isolated_mask;
+	u32 ctrl;
+	int port;
+	int res;
+
+	isolated_mask = 0;
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		if (pp->isolated)
+			isolated_mask |= BIT(port);
+	}
+
+	/* Block from non-cpu bridge ports ... */
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		/* to non-bridge ports */
+		ctrl = ~ports_mask;
+		/* to isolated ports when isolated */
+		if (pp->isolated)
+			ctrl |= isolated_mask;
+		/* to itself when non-hairpin */
+		if (!pp->hairpin)
+			ctrl |= BIT(port);
+		else
+			ctrl &= ~BIT(port);
+
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+
+		pp->bridge_mask = ports_mask;
+	}
+
+	return 0;
+}
+
+static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
+{
+	int res;
+
+	res = yt921x_userport_standalone(priv, port);
+	if (res)
+		return res;
+
+	res = yt921x_isolate(priv, port);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
+{
+	int res;
+
+	res = yt921x_userport_bridge(priv, port);
+	if (res)
+		return res;
+
+	res = yt921x_bridge(priv, ports_mask);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_bridge_flags(struct yt921x_priv *priv, int port,
+		    struct switchdev_brport_flags flags)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	bool do_flush;
+	u32 mask;
+	int res;
+
+	if ((flags.mask & BR_LEARNING) != 0) {
+		bool learning = (flags.val & BR_LEARNING) != 0;
+
+		mask = YT921X_PORT_LEARN_DIS;
+		res = yt921x_reg_toggle_bits(priv, YT921X_PORTn_LEARN(port),
+					     mask, !learning);
+		if (res)
+			return res;
+	}
+
+	/* BR_FLOOD, BR_MCAST_FLOOD: see the comment where ACT_UNK_ACTn_TRAP
+	 * is set
+	 */
+
+	/* BR_BCAST_FLOOD: we can filter bcast, but cannot trap them */
+
+	do_flush = false;
+	if ((flags.mask & BR_HAIRPIN_MODE) != 0) {
+		pp->hairpin = (flags.val & BR_HAIRPIN_MODE) != 0;
+		do_flush = true;
+	}
+	if ((flags.mask & BR_ISOLATED) != 0) {
+		pp->isolated = (flags.val & BR_ISOLATED) != 0;
+		do_flush = true;
+	}
+	if (do_flush) {
+		res = yt921x_bridge(priv, pp->bridge_mask);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_dsa_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				 struct switchdev_brport_flags flags,
+				 struct netlink_ext_ack *extack)
+{
+	if ((flags.mask & ~(BR_HAIRPIN_MODE | BR_LEARNING | BR_FLOOD |
+			    BR_MCAST_FLOOD | BR_ISOLATED)) != 0)
+		return -EINVAL;
+	return 0;
+}
+
+static int
+yt921x_dsa_port_bridge_flags(struct dsa_switch *ds, int port,
+			     struct switchdev_brport_flags flags,
+			     struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return 0;
+
+	yt921x_lock(priv);
+	res = yt921x_bridge_flags(priv, port, flags);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static void
+yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return;
+
+	yt921x_lock(priv);
+	res = yt921x_bridge_leave(priv, port);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "unbridge",
+			port, res);
+}
+
+static int
+yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
+			    struct dsa_bridge bridge, bool *tx_fwd_offload,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	struct dsa_port *dp;
+	u16 ports_mask;
+	int res;
+
+	ports_mask = 0;
+	dsa_switch_for_each_user_port(dp, ds)
+		if (dsa_port_offloads_bridge_dev(dp, bridge.dev))
+			ports_mask |= BIT(dp->index);
+	ports_mask |= priv->cpu_ports_mask;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0)
+		return 0;
+
+	yt921x_lock(priv);
+	res = yt921x_bridge_join(priv, port, ports_mask);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int yt921x_port_down(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	mask = YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
+	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_CTRL(port), mask);
+	if (res)
+		return res;
+
+	if (yt921x_port_is_external(port)) {
+		mask = YT921X_SGMII_LINK;
+		res = yt921x_reg_clear_bits(priv, YT921X_SGMIIn(port), mask);
+		if (res)
+			return res;
+
+		mask = YT921X_XMII_LINK;
+		res = yt921x_reg_clear_bits(priv, YT921X_XMIIn(port), mask);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
+	       phy_interface_t interface, int speed, int duplex,
+	       bool tx_pause, bool rx_pause)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	switch (speed) {
+	case SPEED_10:
+		ctrl = YT921X_PORT_SPEED_10;
+		break;
+	case SPEED_100:
+		ctrl = YT921X_PORT_SPEED_100;
+		break;
+	case SPEED_1000:
+		ctrl = YT921X_PORT_SPEED_1000;
+		break;
+	case SPEED_10000:
+		ctrl = YT921X_PORT_SPEED_10000;
+		break;
+	case SPEED_2500:
+		ctrl = YT921X_PORT_SPEED_2500;
+		break;
+	default:
+		dev_err(dev, "Unsupported speed %d\n", speed);
+		break;
+	}
+	if (duplex == DUPLEX_FULL)
+		ctrl |= YT921X_PORT_DUPLEX_FULL;
+	if (tx_pause)
+		ctrl |= YT921X_PORT_TX_PAUSE;
+	if (rx_pause)
+		ctrl |= YT921X_PORT_RX_PAUSE;
+	ctrl |= YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
+	res = yt921x_reg_write(priv, YT921X_PORTn_CTRL(port), ctrl);
+	if (res)
+		return res;
+
+	if (yt921x_port_is_external(port)) {
+		mask = YT921X_SGMII_SPEED_M;
+		switch (speed) {
+		case SPEED_10:
+			ctrl = YT921X_SGMII_SPEED_10;
+			break;
+		case SPEED_100:
+			ctrl = YT921X_SGMII_SPEED_100;
+			break;
+		case SPEED_1000:
+			ctrl = YT921X_SGMII_SPEED_1000;
+			break;
+		case SPEED_10000:
+			ctrl = YT921X_SGMII_SPEED_10000;
+			break;
+		case SPEED_2500:
+			ctrl = YT921X_SGMII_SPEED_2500;
+			break;
+		}
+		mask |= YT921X_SGMII_DUPLEX_FULL;
+		if (duplex == DUPLEX_FULL)
+			ctrl |= YT921X_SGMII_DUPLEX_FULL;
+		mask |= YT921X_SGMII_TX_PAUSE;
+		if (tx_pause)
+			ctrl |= YT921X_SGMII_TX_PAUSE;
+		mask |= YT921X_SGMII_RX_PAUSE;
+		if (rx_pause)
+			ctrl |= YT921X_SGMII_RX_PAUSE;
+		mask |= YT921X_SGMII_LINK;
+		ctrl |= YT921X_SGMII_LINK;
+		res = yt921x_reg_update_bits(priv, YT921X_SGMIIn(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+
+		mask = YT921X_XMII_LINK;
+		res = yt921x_reg_set_bits(priv, YT921X_XMIIn(port), mask);
+		if (res)
+			return res;
+
+		switch (speed) {
+		case SPEED_10:
+			ctrl = YT921X_MDIO_POLLING_SPEED_10;
+			break;
+		case SPEED_100:
+			ctrl = YT921X_MDIO_POLLING_SPEED_100;
+			break;
+		case SPEED_1000:
+			ctrl = YT921X_MDIO_POLLING_SPEED_1000;
+			break;
+		case SPEED_10000:
+			ctrl = YT921X_MDIO_POLLING_SPEED_10000;
+			break;
+		case SPEED_2500:
+			ctrl = YT921X_MDIO_POLLING_SPEED_2500;
+			break;
+		}
+		if (duplex == DUPLEX_FULL)
+			ctrl |= YT921X_MDIO_POLLING_DUPLEX_FULL;
+		ctrl |= YT921X_MDIO_POLLING_LINK;
+		res = yt921x_reg_write(priv, YT921X_MDIO_POLLINGn(port), ctrl);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
+		   phy_interface_t interface)
+{
+	struct device *dev = to_device(priv);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	if (!yt921x_port_is_external(port)) {
+		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
+			dev_err(dev, "Wrong mode %d on port %d\n",
+				interface, port);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	switch (interface) {
+	/* SGMII */
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		mask = YT921X_SGMII_CTRL_PORTn(port);
+		res = yt921x_reg_set_bits(priv, YT921X_SGMII_CTRL, mask);
+		if (res)
+			return res;
+
+		mask = YT921X_XMII_CTRL_PORTn(port);
+		res = yt921x_reg_clear_bits(priv, YT921X_XMII_CTRL, mask);
+		if (res)
+			return res;
+
+		mask = YT921X_SGMII_MODE_M;
+		switch (interface) {
+		case PHY_INTERFACE_MODE_SGMII:
+			ctrl = YT921X_SGMII_MODE_SGMII_PHY;
+			break;
+		case PHY_INTERFACE_MODE_100BASEX:
+			ctrl = YT921X_SGMII_MODE_100BASEX;
+			break;
+		case PHY_INTERFACE_MODE_1000BASEX:
+			ctrl = YT921X_SGMII_MODE_1000BASEX;
+			break;
+		case PHY_INTERFACE_MODE_2500BASEX:
+			ctrl = YT921X_SGMII_MODE_2500BASEX;
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+		res = yt921x_reg_update_bits(priv, YT921X_SGMIIn(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+
+		break;
+	/* add XMII support here */
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return 0;
+}
+
+static void
+yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int port = dp->index;
+	int res;
+
+	cancel_delayed_work(&priv->ports[port].mib_read);
+
+	yt921x_lock(priv);
+	res = yt921x_port_down(priv, port);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "bring down",
+			port, res);
+}
+
+static void
+yt921x_phylink_mac_link_up(struct phylink_config *config,
+			   struct phy_device *phydev, unsigned int mode,
+			   phy_interface_t interface, int speed, int duplex,
+			   bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int port = dp->index;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_port_up(priv, port, mode, interface, speed, duplex,
+			     tx_pause, rx_pause);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "bring up",
+			port, res);
+
+	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+}
+
+static void
+yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int port = dp->index;
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_port_config(priv, port, mode, state->interface);
+	yt921x_unlock(priv);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "config",
+			port, res);
+}
+
+static void
+yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
+			    struct phylink_config *config)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const struct yt921x_info *info = priv->info;
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000;
+
+	if ((info->internal_mask & BIT(port)) != 0) {
+		/* Port 10 for MCU should probably go here too. But since that
+		 * is untested yet, turn it down for the moment by letting it
+		 * fall to the default branch.
+		 */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+	} else if ((info->external_mask & BIT(port)) != 0) {
+		/* TODO: external ports may support SGMII only, XMII only, or
+		 * SGMII + XMII depending on the chip. However, we can't get
+		 * the accurate config table due to lack of document, thus
+		 * we simply declare SGMII + XMII and rely on the correctness
+		 * of devicetree for now.
+		 */
+
+		/* SGMII */
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_100BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+
+		/* XMII */
+
+		/* Not tested. To add support for XMII:
+		 *   - Add proper interface modes below
+		 *   - Handle them in yt921x_port_config()
+		 */
+	}
+	/* no such port: empty supported_interfaces causes phylink to turn it
+	 * down
+	 */
+}
+
+static int yt921x_port_setup(struct yt921x_priv *priv, int port)
+{
+	u32 ctrl;
+	int res;
+
+	res = yt921x_userport_standalone(priv, port);
+	if (res)
+		return res;
+
+	if ((priv->cpu_ports_mask & BIT(port)) != 0) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+		pp->bridge_mask = 0;
+	}
+
+	return 0;
+}
+
+static enum dsa_tag_protocol
+yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
+			    enum dsa_tag_protocol m)
+{
+	return DSA_TAG_PROTO_YT921X;
+}
+
+static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	yt921x_lock(priv);
+	res = yt921x_port_setup(priv, port);
+	yt921x_unlock(priv);
+
+	return res;
+}
+
+static int yt921x_edata_out(struct yt921x_priv *priv, u32 *valp)
+{
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_EDATA_DATA, &val);
+	if (res)
+		return res;
+	if ((val & YT921X_EDATA_DATA_STATUS_M) != YT921X_EDATA_DATA_IDLE) {
+		yt921x_reg_release(priv);
+		res = read_poll_timeout(yt921x_reg_read_managed, res,
+					(val & YT921X_EDATA_DATA_STATUS_M) ==
+					YT921X_EDATA_DATA_IDLE,
+					YT921X_POLL_SLEEP_US,
+					YT921X_POLL_TIMEOUT_US,
+					true, priv, YT921X_EDATA_DATA, &val);
+		yt921x_reg_acquire(priv);
+		if (res)
+			return res;
+	}
+
+	*valp = val;
+	return 0;
+}
+
+static int yt921x_edata_wait(struct yt921x_priv *priv)
+{
+	u32 val;
+
+	return yt921x_edata_out(priv, &val);
+}
+
+static int
+yt921x_edata_read_cont(struct yt921x_priv *priv, u8 addr, u8 *valp)
+{
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	ctrl = YT921X_EDATA_CTRL_ADDR(addr) | YT921X_EDATA_CTRL_READ;
+	res = yt921x_reg_write(priv, YT921X_EDATA_CTRL, ctrl);
+	if (res)
+		return res;
+	res = yt921x_edata_out(priv, &val);
+	if (res)
+		return res;
+
+	*valp = FIELD_GET(YT921X_EDATA_DATA_DATA_M, val);
+	return 0;
+}
+
+static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
+{
+	int res;
+
+	res = yt921x_edata_wait(priv);
+	if (res)
+		return res;
+	return yt921x_edata_read_cont(priv, addr, valp);
+}
+
+static int yt921x_detect(struct yt921x_priv *priv)
+{
+	struct device *dev = to_device(priv);
+	const struct yt921x_info *info;
+	u8 extmode;
+	u32 chipid;
+	u32 major;
+	u32 mode;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
+	if (res)
+		return res;
+
+	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
+
+	for (info = yt921x_infos; info->name; info++)
+		if (info->major == major)
+			goto found_major;
+
+	dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
+	return -ENODEV;
+
+found_major:
+	res = yt921x_reg_read(priv, YT921X_CHIP_MODE, &mode);
+	if (res)
+		return res;
+	res = yt921x_edata_read(priv, YT921X_EDATA_EXTMODE, &extmode);
+	if (res)
+		return res;
+
+	for (; info->name; info++)
+		if (info->major == major && info->mode == mode &&
+		    info->extmode == extmode)
+			goto found_chip;
+
+	dev_err(dev, "Unsupported chipid 0x%x with chipmode 0x%x 0x%x\n",
+		chipid, mode, extmode);
+	return -ENODEV;
+
+found_chip:
+	/* Print chipid here since we are interested in lower 16 bits */
+	dev_info(dev,
+		 "Motorcomm %s ethernet switch, chipid: 0x%x, "
+		 "chipmode: 0x%x 0x%x\n",
+		 info->name, chipid, mode, extmode);
+
+	priv->info = info;
+	return 0;
+}
+
+static int yt921x_setup(struct yt921x_priv *priv)
+{
+	struct device *dev = to_device(priv);
+	struct dsa_switch *ds = &priv->ds;
+	unsigned long cpu_ports_mask;
+	u64 ctrl64;
+	u16 eth_p_tag;
+	u32 ctrl;
+	int port;
+	u32 val;
+	int res;
+
+	/* Check for Tag EtherType; do it after reset in case you
+	 * messed it up before.
+	 */
+	res = yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
+	if (res)
+		return res;
+	eth_p_tag = FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
+	if (eth_p_tag != ETH_P_YT921X) {
+		dev_err(dev, "Tag type 0x%x != 0x%x\n", eth_p_tag,
+			ETH_P_YT921X);
+		/* Despite being possible, we choose not to configure
+		 * CPU_TAG_TPID, since there is no way it differs from
+		 * the default after a reset, unless you have the wrong
+		 * chip.
+		 */
+		return -EINVAL;
+	}
+
+	/* Enable DSA */
+	priv->cpu_ports_mask = dsa_cpu_ports(ds);
+
+	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
+	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
+	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
+	if (res)
+		return res;
+
+	/* Enable and clear MIB */
+	res = yt921x_reg_set_bits(priv, YT921X_FUNC, YT921X_FUNC_MIB);
+	if (res)
+		return res;
+
+	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
+	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_CPU_COPY_TO_EXT_CPU;
+	res = yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
+	if (res)
+		return res;
+
+	ctrl = GENMASK(10, 0);
+	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
+	if (res)
+		return res;
+
+	/* YT921x does not support native DSA port bridging, so we use port
+	 * isolation to emulate port bridging. However, be especially careful
+	 * that port isolation takes _after_ FDB lookups, i.e. if an FDB entry
+	 * (from another bridge) is matched and the destination port (in another
+	 * bridge) is blocked, the packet will be dropped instead of flooding to
+	 * the DSA "bridged" ports, thus we need to rescue those unknown packets
+	 * with software switch.
+	 *
+	 * If there is no more than one bridge, we might be able to drop them
+	 * directly given some conditions are met, but for now we trap them in
+	 * all cases.
+	 */
+	ctrl = 0;
+	for (int i = 0; i < YT921X_PORT_NUM; i++)
+		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
+	/* Except for CPU ports, if any packets are sent via CPU ports without
+	 * being tagged, they should be dropped.
+	 */
+	cpu_ports_mask = priv->cpu_ports_mask;
+	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
+		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
+		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
+	}
+	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT921X_ACT_UNK_MCAST, ctrl);
+	if (res)
+		return res;
+
+	/* Tagged VID 0 should be treated as untagged, which confuses the
+	 * hardware a lot
+	 */
+	ctrl64 = YT921X_VLAN_CTRL_LEARN_DIS | YT921X_VLAN_CTRL_PORTS_M;
+	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrl64);
+	if (res)
+		return res;
+
+	/* Miscellaneous */
+	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
+	if (res)
+		return res;
+
+	res = yt921x_reg_read(priv, YT921X_PON_STRAP_CAP, &priv->pon_strap_cap);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt921x_dsa_setup(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	u32 val;
+	int res;
+
+	yt921x_lock(priv);
+	do {
+		res = yt921x_detect(priv);
+		if (res)
+			break;
+
+		/* Reset */
+		res = yt921x_reg_write(priv, YT921X_RST, YT921X_RST_HW);
+		if (res)
+			break;
+	} while (0);
+	yt921x_unlock(priv);
+	if (res)
+		return res;
+
+	/* RST_HW is almost same as GPIO hard reset, so we need this delay. */
+	fsleep(YT921X_RST_DELAY_US);
+
+	res = read_poll_timeout(yt921x_reg_read_managed, res, val == 0,
+				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
+				false, priv, YT921X_RST, &val);
+	if (res)
+		return res;
+
+	/* Register the internal mdio bus. Nodes for internal ports should have
+	 * proper phy-handle pointing to their PHYs. Not enabling the internal
+	 * bus is possible, though pretty wired, if they do not use internal
+	 * ports.
+	 */
+	child = of_get_child_by_name(np, "mdio");
+	if (!child) {
+		priv->mbus_int = NULL;
+	} else {
+		res = yt921x_mbus_int_init(priv, child);
+		of_node_put(child);
+		if (res)
+			return res;
+	}
+
+	/* External mdio bus is optional */
+	child = of_get_child_by_name(np, "mdio-external");
+	if (!child) {
+		priv->mbus_ext = NULL;
+	} else {
+		res = yt921x_mbus_ext_init(priv, child);
+		of_node_put(child);
+		if (res)
+			return res;
+
+		dev_err(dev, "Untested external mdio bus\n");
+		return -ENODEV;
+	}
+
+	yt921x_lock(priv);
+	res = yt921x_setup(priv);
+	yt921x_unlock(priv);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static const struct phylink_mac_ops yt921x_phylink_mac_ops = {
+	.mac_link_down	= yt921x_phylink_mac_link_down,
+	.mac_link_up	= yt921x_phylink_mac_link_up,
+	.mac_config	= yt921x_phylink_mac_config,
+};
+
+static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
+	/* mib */
+	.get_strings		= yt921x_dsa_get_strings,
+	.get_ethtool_stats	= yt921x_dsa_get_ethtool_stats,
+	.get_sset_count		= yt921x_dsa_get_sset_count,
+	.get_eth_mac_stats	= yt921x_dsa_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= yt921x_dsa_get_eth_ctrl_stats,
+	.get_rmon_stats		= yt921x_dsa_get_rmon_stats,
+	.get_stats64		= yt921x_dsa_get_stats64,
+	.get_pause_stats	= yt921x_dsa_get_pause_stats,
+	/* eee */
+	.support_eee		= yt921x_dsa_support_eee,
+	.set_mac_eee		= yt921x_dsa_set_mac_eee,
+	/* mtu */
+	.port_change_mtu	= yt921x_dsa_port_change_mtu,
+	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* mirror */
+	.port_mirror_del	= yt921x_dsa_port_mirror_del,
+	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* fdb */
+	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
+	.port_fast_age		= yt921x_dsa_port_fast_age,
+	.set_ageing_time	= yt921x_dsa_set_ageing_time,
+	.port_fdb_del		= yt921x_dsa_port_fdb_del,
+	.port_fdb_add		= yt921x_dsa_port_fdb_add,
+	.port_mdb_del		= yt921x_dsa_port_mdb_del,
+	.port_mdb_add		= yt921x_dsa_port_mdb_add,
+	/* vlan */
+	.port_vlan_filtering	= yt921x_dsa_port_vlan_filtering,
+	.port_vlan_del		= yt921x_dsa_port_vlan_del,
+	.port_vlan_add		= yt921x_dsa_port_vlan_add,
+	/* bridge */
+	.port_pre_bridge_flags	= yt921x_dsa_port_pre_bridge_flags,
+	.port_bridge_flags	= yt921x_dsa_port_bridge_flags,
+	.port_bridge_leave	= yt921x_dsa_port_bridge_leave,
+	.port_bridge_join	= yt921x_dsa_port_bridge_join,
+	/* port */
+	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
+	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
+	.port_setup		= yt921x_dsa_port_setup,
+	/* chip */
+	.setup			= yt921x_dsa_setup,
+};
+
+static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
+{
+	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(&priv->ds);
+}
+
+static void yt921x_mdio_remove(struct mdio_device *mdiodev)
+{
+	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
+
+	if (!priv)
+		return;
+
+	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		cancel_delayed_work_sync(&pp->mib_read);
+	}
+
+	mutex_destroy(&priv->lock);
+
+	dsa_unregister_switch(&priv->ds);
+}
+
+static int yt921x_mdio_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct yt921x_reg_mdio *mdio;
+	struct yt921x_priv *priv;
+	struct dsa_switch *ds;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mdio = devm_kzalloc(dev, sizeof(*mdio), GFP_KERNEL);
+	if (!mdio)
+		return -ENOMEM;
+
+	mdio->bus = mdiodev->bus;
+	mdio->addr = mdiodev->addr;
+	mdio->switchid = 0;
+
+	priv->smi_ops = &yt921x_reg_ops_mdio;
+	priv->smi_ctx = mdio;
+	mutex_init(&priv->lock);
+
+	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		pp->index = i;
+		spin_lock_init(&pp->stats_lock);
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+	}
+
+	ds = &priv->ds;
+	ds->dev = dev;
+	ds->assisted_learning_on_cpu_port = true;
+	ds->priv = priv;
+	ds->ops = &yt921x_dsa_switch_ops;
+	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
+	ds->num_ports = YT921X_PORT_NUM;
+
+	mdiodev_set_drvdata(mdiodev, priv);
+
+	return dsa_register_switch(ds);
+}
+
+static const struct of_device_id yt921x_of_match[] = {
+	{ .compatible = "motorcomm,yt9215" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, yt921x_of_match);
+
+static struct mdio_driver yt921x_mdio_driver = {
+	.probe = yt921x_mdio_probe,
+	.remove = yt921x_mdio_remove,
+	.shutdown = yt921x_mdio_shutdown,
+	.mdiodrv.driver = {
+		.name = YT921X_NAME,
+		.of_match_table = yt921x_of_match,
+	},
+};
+
+mdio_module_driver(yt921x_mdio_driver);
+
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
+MODULE_DESCRIPTION("Driver for Motorcomm YT921x Switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
new file mode 100644
index 000000000000..068742df35b7
--- /dev/null
+++ b/drivers/net/dsa/yt921x.h
@@ -0,0 +1,593 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 David Yang
+ */
+
+#ifndef __YT921X_H
+#define __YT921X_H
+
+#include <net/dsa.h>
+
+#define YT921X_SMI_SWITCHID_M		GENMASK(3, 2)
+#define  YT921X_SMI_SWITCHID(x)			FIELD_PREP(YT921X_SMI_SWITCHID_M, (x))
+#define YT921X_SMI_AD			BIT(1)
+#define  YT921X_SMI_ADDR			0
+#define  YT921X_SMI_DATA			YT921X_SMI_AD
+#define YT921X_SMI_RW			BIT(0)
+#define  YT921X_SMI_WRITE			0
+#define  YT921X_SMI_READ			YT921X_SMI_RW
+
+#define YT921X_SWITCHID_NUM		4
+
+#define YT921X_RST			0x80000
+#define  YT921X_RST_HW				BIT(31)
+#define  YT921X_RST_SW				BIT(1)
+#define YT921X_FUNC			0x80004
+#define  YT921X_FUNC_MIB			BIT(1)
+#define YT921X_CHIP_ID			0x80008
+#define  YT921X_CHIP_ID_MAJOR			GENMASK(31, 16)
+#define YT921X_EXT_CPU_PORT		0x8000c
+#define  YT921X_EXT_CPU_PORT_TAG_EN		BIT(15)
+#define  YT921X_EXT_CPU_PORT_PORT_EN		BIT(14)
+#define  YT921X_EXT_CPU_PORT_PORT_M		GENMASK(3, 0)
+#define   YT921X_EXT_CPU_PORT_PORT(x)			FIELD_PREP(YT921X_EXT_CPU_PORT_PORT_M, (x))
+#define YT921X_CPU_TAG_TPID		0x80010
+#define  YT921X_CPU_TAG_TPID_TPID_M		GENMASK(15, 0)
+/* Same as ETH_P_YT921X, but this represents the true HW default, while the
+ * former is a local convention chosen by us.
+ */
+#define   YT921X_CPU_TAG_TPID_TPID_DEFAULT		0x9988
+#define YT921X_PVID_SEL			0x80014
+#define  YT921X_PVID_SEL_SVID_PORTn(port)	BIT(port)
+#define YT921X_SGMII_CTRL		0x80028
+#define  YT921X_SGMII_CTRL_PORTn_TEST(port)	BIT((port) - 3)
+#define  YT921X_SGMII_CTRL_PORTn(port)		BIT((port) - 8)
+#define YT921X_IO_LEVEL		0x80030
+#define  YT9215_IO_LEVEL_NORMAL_M		GENMASK(5, 4)
+#define   YT9215_IO_LEVEL_NORMAL(x)			FIELD_PREP(YT9215_IO_LEVEL_NORMAL_M, (x))
+#define   YT9215_IO_LEVEL_NORMAL_3V3			YT9215_IO_LEVEL_NORMAL(0)
+#define   YT9215_IO_LEVEL_NORMAL_1V8			YT9215_IO_LEVEL_NORMAL(3)
+#define  YT9215_IO_LEVEL_RGMII1_M		GENMASK(3, 2)
+#define   YT9215_IO_LEVEL_RGMII1(x)			FIELD_PREP(YT9215_IO_LEVEL_RGMII1_M, (x))
+#define   YT9215_IO_LEVEL_RGMII1_3V3			YT9215_IO_LEVEL_RGMII1(0)
+#define   YT9215_IO_LEVEL_RGMII1_2V5			YT9215_IO_LEVEL_RGMII1(1)
+#define   YT9215_IO_LEVEL_RGMII1_1V8			YT9215_IO_LEVEL_RGMII1(2)
+#define  YT9215_IO_LEVEL_RGMII0_M		GENMASK(1, 0)
+#define   YT9215_IO_LEVEL_RGMII0(x)			FIELD_PREP(YT9215_IO_LEVEL_RGMII0_M, (x))
+#define   YT9215_IO_LEVEL_RGMII0_3V3			YT9215_IO_LEVEL_RGMII0(0)
+#define   YT9215_IO_LEVEL_RGMII0_2V5			YT9215_IO_LEVEL_RGMII0(1)
+#define   YT9215_IO_LEVEL_RGMII0_1V8			YT9215_IO_LEVEL_RGMII0(2)
+#define  YT9218_IO_LEVEL_RGMII1_M		GENMASK(5, 4)
+#define   YT9218_IO_LEVEL_RGMII1(x)			FIELD_PREP(YT9218_IO_LEVEL_RGMII1_M, (x))
+#define   YT9218_IO_LEVEL_RGMII1_3V3			YT9218_IO_LEVEL_RGMII1(0)
+#define   YT9218_IO_LEVEL_RGMII1_2V5			YT9218_IO_LEVEL_RGMII1(1)
+#define   YT9218_IO_LEVEL_RGMII1_1V8			YT9218_IO_LEVEL_RGMII1(2)
+#define  YT9218_IO_LEVEL_RGMII0_M		GENMASK(3, 2)
+#define   YT9218_IO_LEVEL_RGMII0(x)			FIELD_PREP(YT9218_IO_LEVEL_RGMII0_M, (x))
+#define   YT9218_IO_LEVEL_RGMII0_3V3			YT9218_IO_LEVEL_RGMII0(0)
+#define   YT9218_IO_LEVEL_RGMII0_2V5			YT9218_IO_LEVEL_RGMII0(1)
+#define   YT9218_IO_LEVEL_RGMII0_1V8			YT9218_IO_LEVEL_RGMII0(2)
+#define  YT9218_IO_LEVEL_NORMAL_M		GENMASK(1, 0)
+#define   YT9218_IO_LEVEL_NORMAL(x)			FIELD_PREP(YT9218_IO_LEVEL_NORMAL_M, (x))
+#define   YT9218_IO_LEVEL_NORMAL_3V3			YT9218_IO_LEVEL_NORMAL(0)
+#define   YT9218_IO_LEVEL_NORMAL_1V8			YT9218_IO_LEVEL_NORMAL(3)
+#define YT921X_MAC_ADDR_HI2		0x80080
+#define YT921X_MAC_ADDR_LO4		0x80084
+#define YT921X_SGMIIn(port)		(0x8008c + 4 * ((port) - 8))
+#define  YT921X_SGMII_MODE_M			GENMASK(9, 7)
+#define   YT921X_SGMII_MODE(x)				FIELD_PREP(YT921X_SGMII_MODE_M, (x))
+#define   YT921X_SGMII_MODE_SGMII_MAC			YT921X_SGMII_MODE(0)
+#define   YT921X_SGMII_MODE_SGMII_PHY			YT921X_SGMII_MODE(1)
+#define   YT921X_SGMII_MODE_1000BASEX			YT921X_SGMII_MODE(2)
+#define   YT921X_SGMII_MODE_100BASEX			YT921X_SGMII_MODE(3)
+#define   YT921X_SGMII_MODE_2500BASEX			YT921X_SGMII_MODE(4)
+#define   YT921X_SGMII_MODE_BASEX			YT921X_SGMII_MODE(5)
+#define  YT921X_SGMII_RX_PAUSE			BIT(6)
+#define  YT921X_SGMII_TX_PAUSE			BIT(5)
+#define  YT921X_SGMII_LINK			BIT(4)  /* force link */
+#define  YT921X_SGMII_DUPLEX_FULL		BIT(3)
+#define  YT921X_SGMII_SPEED_M			GENMASK(2, 0)
+#define   YT921X_SGMII_SPEED(x)				FIELD_PREP(YT921X_SGMII_SPEED_M, (x))
+#define   YT921X_SGMII_SPEED_10				YT921X_SGMII_SPEED(0)
+#define   YT921X_SGMII_SPEED_100			YT921X_SGMII_SPEED(1)
+#define   YT921X_SGMII_SPEED_1000			YT921X_SGMII_SPEED(2)
+#define   YT921X_SGMII_SPEED_10000			YT921X_SGMII_SPEED(3)
+#define   YT921X_SGMII_SPEED_2500			YT921X_SGMII_SPEED(4)
+#define YT921X_PORTn_CTRL(port)		(0x80100 + 4 * (port))
+#define  YT921X_PORT_CTRL_PAUSE_AN		BIT(10)
+#define YT921X_PORTn_STATUS(port)	(0x80200 + 4 * (port))
+#define  YT921X_PORT_LINK			BIT(9)  /* CTRL: auto negotiation */
+#define  YT921X_PORT_HALF_PAUSE			BIT(8)  /* Half-duplex back pressure mode */
+#define  YT921X_PORT_DUPLEX_FULL		BIT(7)
+#define  YT921X_PORT_RX_PAUSE			BIT(6)
+#define  YT921X_PORT_TX_PAUSE			BIT(5)
+#define  YT921X_PORT_RX_MAC_EN			BIT(4)
+#define  YT921X_PORT_TX_MAC_EN			BIT(3)
+#define  YT921X_PORT_SPEED_M			GENMASK(2, 0)
+#define   YT921X_PORT_SPEED(x)				FIELD_PREP(YT921X_PORT_SPEED_M, (x))
+#define   YT921X_PORT_SPEED_10				YT921X_PORT_SPEED(0)
+#define   YT921X_PORT_SPEED_100				YT921X_PORT_SPEED(1)
+#define   YT921X_PORT_SPEED_1000			YT921X_PORT_SPEED(2)
+#define   YT921X_PORT_SPEED_10000			YT921X_PORT_SPEED(3)
+#define   YT921X_PORT_SPEED_2500			YT921X_PORT_SPEED(4)
+#define YT921X_PON_STRAP_FUNC		0x80320
+#define YT921X_PON_STRAP_VAL		0x80324
+#define YT921X_PON_STRAP_CAP		0x80328
+#define  YT921X_PON_STRAP_EEE			BIT(16)
+#define  YT921X_PON_STRAP_LOOP_DETECT		BIT(7)
+#define YT921X_MDIO_POLLINGn(port)	(0x80364 + 4 * ((port) - 8))
+#define  YT921X_MDIO_POLLING_DUPLEX_FULL	BIT(4)
+#define  YT921X_MDIO_POLLING_LINK		BIT(3)
+#define  YT921X_MDIO_POLLING_SPEED_M		GENMASK(2, 0)
+#define   YT921X_MDIO_POLLING_SPEED(x)			FIELD_PREP(YT921X_MDIO_POLLING_SPEED_M, (x))
+#define   YT921X_MDIO_POLLING_SPEED_10			YT921X_MDIO_POLLING_SPEED(0)
+#define   YT921X_MDIO_POLLING_SPEED_100			YT921X_MDIO_POLLING_SPEED(1)
+#define   YT921X_MDIO_POLLING_SPEED_1000		YT921X_MDIO_POLLING_SPEED(2)
+#define   YT921X_MDIO_POLLING_SPEED_10000		YT921X_MDIO_POLLING_SPEED(3)
+#define   YT921X_MDIO_POLLING_SPEED_2500		YT921X_MDIO_POLLING_SPEED(4)
+#define YT921X_SENSOR			0x8036c
+#define  YT921X_SENSOR_TEMP			BIT(18)
+#define YT921X_TEMP			0x80374
+#define YT921X_CHIP_MODE		0x80388
+#define  YT921X_CHIP_MODE_MODE			GENMASK(1, 0)
+#define YT921X_XMII_CTRL		0x80394
+#define  YT921X_XMII_CTRL_PORTn(port)		BIT(9 - (port))  /* Yes, it's reversed */
+#define YT921X_XMIIn(port)		(0x80400 + 8 * ((port) - 8))
+#define  YT921X_XMII_MODE_M			GENMASK(31, 29)
+#define   YT921X_XMII_MODE(x)				FIELD_PREP(YT921X_XMII_MODE_M, (x))
+#define   YT921X_XMII_MODE_MII				YT921X_XMII_MODE(0)
+#define   YT921X_XMII_MODE_REVMII			YT921X_XMII_MODE(1)
+#define   YT921X_XMII_MODE_RMII				YT921X_XMII_MODE(2)
+#define   YT921X_XMII_MODE_REVRMII			YT921X_XMII_MODE(3)
+#define   YT921X_XMII_MODE_RGMII			YT921X_XMII_MODE(4)
+#define   YT921X_XMII_MODE_DISABLE			YT921X_XMII_MODE(5)
+#define  YT921X_XMII_LINK			BIT(19)  /* force link */
+#define  YT921X_XMII_EN				BIT(18)
+#define  YT921X_XMII_SOFT_RST			BIT(17)
+#define  YT921X_XMII_RGMII_TX_DELAY_150PS_M	GENMASK(16, 13)
+#define   YT921X_XMII_RGMII_TX_DELAY_150PS(x)		FIELD_PREP(YT921X_XMII_RGMII_TX_DELAY_150PS_M, (x))
+#define  YT921X_XMII_TX_CLK_IN			BIT(11)
+#define  YT921X_XMII_RX_CLK_IN			BIT(10)
+#define  YT921X_XMII_RGMII_TX_DELAY_2NS		BIT(8)
+#define  YT921X_XMII_RGMII_TX_CLK_OUT		BIT(7)
+#define  YT921X_XMII_RGMII_RX_DELAY_150PS_M	GENMASK(6, 3)
+#define   YT921X_XMII_RGMII_RX_DELAY_150PS(x)		FIELD_PREP(YT921X_XMII_RGMII_RX_DELAY_150PS_M, (x))
+#define  YT921X_XMII_RMII_PHY_TX_CLK_OUT	BIT(2)
+#define  YT921X_XMII_REVMII_TX_CLK_OUT		BIT(1)
+#define  YT921X_XMII_REVMII_RX_CLK_OUT		BIT(0)
+
+#define YT921X_MACn_FRAME(port)		(0x81008 + 0x1000 * (port))
+#define  YT921X_MAC_FRAME_SIZE_M		GENMASK(21, 8)
+#define   YT921X_MAC_FRAME_SIZE(x)			FIELD_PREP(YT921X_MAC_FRAME_SIZE_M, (x))
+
+#define YT921X_EEEn_VAL(port)		(0xa0000 + 4 * (port))
+#define  YT921X_EEE_VAL_DATA			BIT(1)
+
+#define YT921X_EEE_CTRL			0xb0000
+#define  YT921X_EEE_CTRL_ENn(port)		BIT(port)
+
+#define YT921X_MIB_CTRL			0xc0004
+#define  YT921X_MIB_CTRL_CLEAN			BIT(30)
+#define  YT921X_MIB_CTRL_PORT_M			GENMASK(6, 3)
+#define   YT921X_MIB_CTRL_PORT(x)			FIELD_PREP(YT921X_MIB_CTRL_PORT_M, (x))
+#define  YT921X_MIB_CTRL_ONE_PORT		BIT(1)
+#define  YT921X_MIB_CTRL_ALL_PORT		BIT(0)
+#define YT921X_MIBn_DATA0(port)		(0xc0100 + 0x100 * (port))
+#define YT921X_MIBn_DATAm(port, x)	(YT921X_MIBn_DATA0(port) + 4 * (x))
+
+#define YT921X_EDATA_CTRL		0xe0000
+#define  YT921X_EDATA_CTRL_ADDR_M		GENMASK(15, 8)
+#define   YT921X_EDATA_CTRL_ADDR(x)			FIELD_PREP(YT921X_EDATA_CTRL_ADDR_M, (x))
+#define  YT921X_EDATA_CTRL_OP_M			GENMASK(3, 0)
+#define   YT921X_EDATA_CTRL_OP(x)			FIELD_PREP(YT921X_EDATA_CTRL_OP_M, (x))
+#define   YT921X_EDATA_CTRL_READ			YT921X_EDATA_CTRL_OP(5)
+#define YT921X_EDATA_DATA		0xe0004
+#define  YT921X_EDATA_DATA_DATA_M			GENMASK(31, 24)
+#define  YT921X_EDATA_DATA_STATUS_M		GENMASK(3, 0)
+#define   YT921X_EDATA_DATA_STATUS(x)			FIELD_PREP(YT921X_EDATA_DATA_STATUS_M, (x))
+#define   YT921X_EDATA_DATA_IDLE			YT921X_EDATA_DATA_STATUS(3)
+
+#define YT921X_EXT_MBUS_OP		0x6a000
+#define YT921X_INT_MBUS_OP		0xf0000
+#define  YT921X_MBUS_OP_START			BIT(0)
+#define YT921X_EXT_MBUS_CTRL		0x6a004
+#define YT921X_INT_MBUS_CTRL		0xf0004
+#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
+#define   YT921X_MBUS_CTRL_PORT(x)			FIELD_PREP(YT921X_MBUS_CTRL_PORT_M, (x))
+#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
+#define   YT921X_MBUS_CTRL_REG(x)			FIELD_PREP(YT921X_MBUS_CTRL_REG_M, (x))
+#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
+#define   YT921X_MBUS_CTRL_TYPE(x)			FIELD_PREP(YT921X_MBUS_CTRL_TYPE_M, (x))
+#define   YT921X_MBUS_CTRL_TYPE_C22			YT921X_MBUS_CTRL_TYPE(4)
+#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */
+#define   YT921X_MBUS_CTRL_OP(x)			FIELD_PREP(YT921X_MBUS_CTRL_OP_M, (x))
+#define   YT921X_MBUS_CTRL_WRITE			YT921X_MBUS_CTRL_OP(1)
+#define   YT921X_MBUS_CTRL_READ				YT921X_MBUS_CTRL_OP(2)
+#define YT921X_EXT_MBUS_DOUT		0x6a008
+#define YT921X_INT_MBUS_DOUT		0xf0008
+#define YT921X_EXT_MBUS_DIN		0x6a00c
+#define YT921X_INT_MBUS_DIN		0xf000c
+
+#define YT921X_PORTn_EGR(port)		(0x100000 + 4 * (port))
+#define  YT921X_PORT_EGR_TPID_CTAG_M		GENMASK(5, 4)
+#define   YT921X_PORT_EGR_TPID_CTAG(x)			FIELD_PREP(YT921X_PORT_EGR_TPID_CTAG_M, (x))
+#define  YT921X_PORT_EGR_TPID_STAG_M		GENMASK(3, 2)
+#define   YT921X_PORT_EGR_TPID_STAG(x)			FIELD_PREP(YT921X_PORT_EGR_TPID_STAG_M, (x))
+#define YT921X_TPID_EGRn(x)		(0x100300 + 4 * (x))	/* [0, 3] */
+#define  YT921X_TPID_EGR_TPID_M			GENMASK(15, 0)
+
+#define YT921X_VLAN_IGR_FILTER		0x180280
+#define  YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP(port)	BIT((port) + 11)
+#define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
+#define YT921X_PORTn_ISOLATION(port)	(0x180294 + 4 * (port))
+#define  YT921X_PORT_ISOLATION_BLOCKn(port)	BIT(port)
+#define YT921X_PORTn_LEARN(port)	(0x1803d0 + 4 * (port))
+#define  YT921X_PORT_LEARN_VID_LEARN_MULTI_EN	BIT(22)
+#define  YT921X_PORT_LEARN_VID_LEARN_MODE	BIT(21)
+#define  YT921X_PORT_LEARN_VID_LEARN_EN		BIT(20)
+#define  YT921X_PORT_LEARN_SUSPEND_COPY_EN	BIT(19)
+#define  YT921X_PORT_LEARN_SUSPEND_DROP_EN	BIT(18)
+#define  YT921X_PORT_LEARN_DIS			BIT(17)
+#define  YT921X_PORT_LEARN_LIMIT_EN		BIT(16)
+#define  YT921X_PORT_LEARN_LIMIT_M		GENMASK(15, 8)
+#define   YT921X_PORT_LEARN_LIMIT(x)			FIELD_PREP(YT921X_PORT_LEARN_LIMIT_M, (x))
+#define  YT921X_PORT_LEARN_DROP_ON_EXCEEDED	BIT(2)
+#define  YT921X_PORT_LEARN_MODE_M		GENMASK(1, 0)
+#define   YT921X_PORT_LEARN_MODE(x)			FIELD_PREP(YT921X_PORT_LEARN_MODE_M, (x))
+#define   YT921X_PORT_LEARN_MODE_AUTO			YT921X_PORT_LEARN_MODE(0)
+#define   YT921X_PORT_LEARN_MODE_AUTO_AND_COPY		YT921X_PORT_LEARN_MODE(1)
+#define   YT921X_PORT_LEARN_MODE_CPU_CONTROL		YT921X_PORT_LEARN_MODE(2)
+#define YT921X_AGEING			0x180440
+#define  YT921X_AGEING_INTERVAL_M		GENMASK(15, 0)
+#define YT921X_FDB_IN0			0x180454
+#define YT921X_FDB_IN1			0x180458
+#define YT921X_FDB_IN2			0x18045c
+#define YT921X_FDB_OP			0x180460
+#define  YT921X_FDB_OP_INDEX_M			GENMASK(22, 11)
+#define   YT921X_FDB_OP_INDEX(x)			FIELD_PREP(YT921X_FDB_OP_INDEX_M, (x))
+#define  YT921X_FDB_OP_MODE_INDEX		BIT(10)  /* mac+fid / index */
+#define  YT921X_FDB_OP_FLUSH_MCAST		BIT(9)  /* ucast / mcast */
+#define  YT921X_FDB_OP_FLUSH_M			GENMASK(8, 7)
+#define   YT921X_FDB_OP_FLUSH(x)			FIELD_PREP(YT921X_FDB_OP_FLUSH_M, (x))
+#define   YT921X_FDB_OP_FLUSH_ALL			YT921X_FDB_OP_FLUSH(0)
+#define   YT921X_FDB_OP_FLUSH_PORT			YT921X_FDB_OP_FLUSH(1)
+#define   YT921X_FDB_OP_FLUSH_PORT_VID			YT921X_FDB_OP_FLUSH(2)
+#define   YT921X_FDB_OP_FLUSH_VID			YT921X_FDB_OP_FLUSH(3)
+#define  YT921X_FDB_OP_FLUSH_STATIC		BIT(6)
+#define  YT921X_FDB_OP_NEXT_TYPE_M		GENMASK(5, 4)
+#define   YT921X_FDB_OP_NEXT_TYPE(x)			FIELD_PREP(YT921X_FDB_OP_NEXT_TYPE_M, (x))
+#define   YT921X_FDB_OP_NEXT_TYPE_UCAST_PORT		YT921X_FDB_OP_NEXT_TYPE(0)
+#define   YT921X_FDB_OP_NEXT_TYPE_UCAST_VID		YT921X_FDB_OP_NEXT_TYPE(1)
+#define   YT921X_FDB_OP_NEXT_TYPE_UCAST			YT921X_FDB_OP_NEXT_TYPE(2)
+#define   YT921X_FDB_OP_NEXT_TYPE_MCAST			YT921X_FDB_OP_NEXT_TYPE(3)
+#define  YT921X_FDB_OP_OP_M			GENMASK(3, 1)
+#define   YT921X_FDB_OP_OP(x)				FIELD_PREP(YT921X_FDB_OP_OP_M, (x))
+#define   YT921X_FDB_OP_OP_ADD				YT921X_FDB_OP_OP(0)
+#define   YT921X_FDB_OP_OP_DEL				YT921X_FDB_OP_OP(1)
+#define   YT921X_FDB_OP_OP_GET_ONE			YT921X_FDB_OP_OP(2)
+#define   YT921X_FDB_OP_OP_GET_NEXT			YT921X_FDB_OP_OP(3)
+#define   YT921X_FDB_OP_OP_FLUSH			YT921X_FDB_OP_OP(4)
+#define  YT921X_FDB_OP_START			BIT(0)
+#define YT921X_FDB_RESULT		0x180464
+#define  YT921X_FDB_RESULT_DONE			BIT(15)
+#define  YT921X_FDB_RESULT_NOTFOUND		BIT(14)
+#define  YT921X_FDB_RESULT_OVERWRITED		BIT(13)
+#define  YT921X_FDB_RESULT_INDEX_M		GENMASK(11, 0)
+#define   YT921X_FDB_RESULT_INDEX(x)			FIELD_PREP(YT921X_FDB_RESULT_INDEX_M, (x))
+#define YT921X_FDB_OUT0			0x1804b0
+#define  YT921X_FDB_IO0_ADDR_HI4_M		GENMASK(31, 0)
+#define YT921X_FDB_OUT1			0x1804b4
+#define  YT921X_FDB_IO1_EGR_INT_PRI_EN		BIT(31)
+#define  YT921X_FDB_IO1_STATUS_M		GENMASK(30, 28)
+#define   YT921X_FDB_IO1_STATUS(x)			FIELD_PREP(YT921X_FDB_IO1_STATUS_M, (x))
+#define   YT921X_FDB_IO1_STATUS_INVALID			YT921X_FDB_IO1_STATUS(0)
+#define   YT921X_FDB_IO1_STATUS_MIN_TIME		YT921X_FDB_IO1_STATUS(1)
+#define   YT921X_FDB_IO1_STATUS_MOVE_AGING_MAX_TIME	YT921X_FDB_IO1_STATUS(3)
+#define   YT921X_FDB_IO1_STATUS_MAX_TIME		YT921X_FDB_IO1_STATUS(5)
+#define   YT921X_FDB_IO1_STATUS_PENDING			YT921X_FDB_IO1_STATUS(6)
+#define   YT921X_FDB_IO1_STATUS_STATIC			YT921X_FDB_IO1_STATUS(7)
+#define  YT921X_FDB_IO1_FID_M			GENMASK(27, 16)  /* filtering ID (VID) */
+#define   YT921X_FDB_IO1_FID(x)				FIELD_PREP(YT921X_FDB_IO1_FID_M, (x))
+#define  YT921X_FDB_IO1_ADDR_LO2_M		GENMASK(15, 0)
+#define YT921X_FDB_OUT2			0x1804b8
+#define  YT921X_FDB_IO2_MOVE_AGING_STATUS_M	GENMASK(31, 30)
+#define  YT921X_FDB_IO2_IGR_DROP		BIT(29)
+#define  YT921X_FDB_IO2_EGR_PORTS_M		GENMASK(28, 18)
+#define   YT921X_FDB_IO2_EGR_PORTS(x)			FIELD_PREP(YT921X_FDB_IO2_EGR_PORTS_M, (x))
+#define  YT921X_FDB_IO2_EGR_DROP		BIT(17)
+#define  YT921X_FDB_IO2_COPY_TO_CPU		BIT(16)
+#define  YT921X_FDB_IO2_IGR_INT_PRI_EN		BIT(15)
+#define  YT921X_FDB_IO2_INT_PRI_M		GENMASK(14, 12)
+#define   YT921X_FDB_IO2_INT_PRI(x)			FIELD_PREP(YT921X_FDB_IO2_INT_PRI_M, (x))
+#define  YT921X_FDB_IO2_NEW_VID_M		GENMASK(11, 0)
+#define   YT921X_FDB_IO2_NEW_VID(x)			FIELD_PREP(YT921X_FDB_IO2_NEW_VID_M, (x))
+#define YT921X_FILTER_UNK_UCAST		0x180508
+#define YT921X_FILTER_UNK_MCAST		0x18050c
+#define YT921X_FILTER_MCAST		0x180510
+#define YT921X_FILTER_BCAST		0x180514
+#define  YT921X_FILTER_PORTS_M			GENMASK(10, 0)
+#define   YT921X_FILTER_PORTS(x)			FIELD_PREP(YT921X_FILTER_PORTS_M, (x))
+#define  YT921X_FILTER_PORTn(port)		BIT(port)
+#define YT921X_VLAN_EGR_FILTER		0x180598
+#define  YT921X_VLAN_EGR_FILTER_PORTn(port)	BIT(port)
+#define YT921X_CPU_COPY			0x180690
+#define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
+#define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
+#define  YT921X_CPU_COPY_TO_EXT_CPU		BIT(0)
+#define YT921X_ACT_UNK_UCAST		0x180734
+#define YT921X_ACT_UNK_MCAST		0x180738
+#define  YT921X_ACT_UNK_MCAST_BYPASS_DROP_RMA	BIT(23)
+#define  YT921X_ACT_UNK_MCAST_BYPASS_DROP_IGMP	BIT(22)
+#define  YT921X_ACT_UNK_ACTn_M(port)		GENMASK(2 * (port) + 1, 2 * (port))
+#define   YT921X_ACT_UNK_ACTn(port, x)			((x) << (2 * (port)))
+#define   YT921X_ACT_UNK_ACTn_FORWARD(port)		YT921X_ACT_UNK_ACTn(port, 0)  /* flood */
+#define   YT921X_ACT_UNK_ACTn_TRAP(port)		YT921X_ACT_UNK_ACTn(port, 1)  /* steer to CPU */
+#define   YT921X_ACT_UNK_ACTn_DROP(port)		YT921X_ACT_UNK_ACTn(port, 2)  /* discard */
+#define   YT921X_ACT_UNK_ACTn_COPY(port)		YT921X_ACT_UNK_ACTn(port, 3)  /* flood and copy */
+#define YT921X_FDB_HW_FLUSH		0x180958
+#define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
+
+#define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
+#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK(50, 40)
+#define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
+#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT((port) + 40)
+#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK(39, 36)
+#define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
+#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT(35)
+#define  YT921X_VLAN_CTRL_FID_M			GENMASK(34, 23)
+#define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
+#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT(22)
+#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT(21)
+#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK(20, 18)
+#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK(17, 7)
+#define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
+#define  YT921X_VLAN_CTRL_PORTn(port)		BIT((port) + 7)
+#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT(6)
+#define  YT921X_VLAN_CTRL_METER_EN		BIT(5)
+#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK(4, 0)
+
+#define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
+#define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
+#define YT921X_PORTn_IGR_TPID(port)	(0x210010 + 4 * (port))
+#define  YT921X_PORT_IGR_TPIDn_STAG_M		GENMASK(7, 4)
+#define  YT921X_PORT_IGR_TPIDn_STAG(x)		BIT((x) + 4)
+#define  YT921X_PORT_IGR_TPIDn_CTAG_M		GENMASK(3, 0)
+#define  YT921X_PORT_IGR_TPIDn_CTAG(x)		BIT(x)
+
+#define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_EN	BIT(30)
+#define  YT921X_PORT_VLAN_CTRL_SVID_M		GENMASK(29, 18)
+#define   YT921X_PORT_VLAN_CTRL_SVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_SVID_M, (x))
+#define  YT921X_PORT_VLAN_CTRL_CVID_M		GENMASK(17, 6)
+#define   YT921X_PORT_VLAN_CTRL_CVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_CVID_M, (x))
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_M	GENMASK(5, 3)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_M	GENMASK(2, 0)
+#define YT921X_PORTn_VLAN_CTRL1(port)	(0x230080 + 4 * (port))
+#define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_EN	BIT(8)
+#define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_PROFILE_ID_M	GENMASK(7, 4)
+#define  YT921X_PORT_VLAN_CTRL1_SVLAN_DROP_TAGGED	BIT(3)
+#define  YT921X_PORT_VLAN_CTRL1_SVLAN_DROP_UNTAGGED	BIT(2)
+#define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED	BIT(1)
+#define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED	BIT(0)
+
+#define YT921X_MIRROR			0x300300
+#define  YT921X_MIRROR_IGR_PORTS_M		GENMASK(26, 16)
+#define   YT921X_MIRROR_IGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_IGR_PORTS_M, (x))
+#define  YT921X_MIRROR_IGR_PORTn(port)		BIT((port) + 16)
+#define  YT921X_MIRROR_EGR_PORTS_M		GENMASK(14, 4)
+#define   YT921X_MIRROR_EGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_EGR_PORTS_M, (x))
+#define  YT921X_MIRROR_EGR_PORTn(port)		BIT((port) + 4)
+#define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
+#define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
+
+#define YT921X_REG_END			0x400000  /* as long as reg space is below this */
+
+#define YT921X_TAG_LEN			8
+
+#define YT921X_EDATA_EXTMODE		0xfb
+#define YT921X_EDATA_LEN		0x100
+
+#define YT921X_FDB_NUM		4096
+
+enum yt921x_fdb_entry_status {
+	YT921X_FDB_ENTRY_STATUS_INVALID = 0,
+	YT921X_FDB_ENTRY_STATUS_MIN_TIME = 1,
+	YT921X_FDB_ENTRY_STATUS_MOVE_AGING_MAX_TIME = 3,
+	YT921X_FDB_ENTRY_STATUS_MAX_TIME = 5,
+	YT921X_FDB_ENTRY_STATUS_PENDING = 6,
+	YT921X_FDB_ENTRY_STATUS_STATIC = 7,
+};
+
+#define YT921X_PVID_DEFAULT		1
+
+#define YT921X_FRAME_SIZE_MAX		0x2400  /* 9216 */
+
+/* required for a hard reset */
+#define YT921X_RST_DELAY_US		10000
+
+struct yt921x_mib_desc {
+	unsigned int size;
+	unsigned int offset;
+	const char *name;
+	bool unstructured;
+};
+
+struct yt921x_mib_raw {
+	u32 rx_broadcast;
+	u32 rx_pause;
+	u32 rx_multicast;
+	u32 rx_crc_errors;
+
+	u32 rx_alignment_errors;
+	u32 rx_undersize_errors;
+	u32 rx_fragment_errors;
+	u32 rx_64byte;
+
+	u32 rx_65_127byte;
+	u32 rx_128_255byte;
+	u32 rx_256_511byte;
+	u32 rx_512_1023byte;
+
+	u32 rx_1024_1518byte;
+	u32 rx_jumbo;
+	u32 rx_good_bytes_hi;
+	u32 rx_good_bytes_lo;
+
+	u32 rx_bad_bytes_hi;
+	u32 rx_bad_bytes_lo;
+	u32 rx_oversize_errors_hi;
+	u32 rx_oversize_errors_lo;
+
+	u32 rx_dropped;
+	u32 tx_broadcast;
+	u32 tx_pause;
+	u32 tx_multicast;
+
+	u32 tx_undersize_errors;
+	u32 tx_64byte;
+	u32 tx_65_127byte;
+	u32 tx_128_255byte;
+
+	u32 tx_256_511byte;
+	u32 tx_512_1023byte;
+	u32 tx_1024_1518byte;
+	u32 tx_jumbo;
+
+	u32 tx_good_bytes_hi;
+	u32 tx_good_bytes_lo;
+	u32 tx_collisions_hi;
+	u32 tx_collisions_lo;
+
+	u32 tx_aborted_errors;
+	u32 tx_multiple_collisions;
+	u32 tx_single_collisions;
+	u32 tx_good;
+
+	u32 tx_deferred;
+	u32 tx_late_collisions;
+	u32 rx_oam;
+	u32 tx_oam;
+};
+
+#define YT921X_MIBn_name(port, name) \
+	(YT921X_MIBn_DATA0(port) + offsetof(struct yt921x_mib_raw, name))
+
+#define YT9215_MAJOR			0x9002
+#define YT9218_MAJOR			0x9001
+
+#define YT921X_PORT_MASK_INTn(port)	BIT(port)
+#define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
+#define YT921X_PORT_MASK_EXT0		BIT(8)
+#define YT921X_PORT_MASK_EXT1		BIT(9)
+
+#define yt921x_port_is_internal(port) ((port) < 8)
+#define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
+
+/* 8 internal + 2 external + 1 mcu */
+#define YT921X_PORT_NUM			11
+
+struct yt921x_reg_ops {
+	void (*acquire)(void *context);
+	void (*release)(void *context);
+	int (*read)(void *context, u32 reg, u32 *valp);
+	int (*write)(void *context, u32 reg, u32 val);
+};
+
+struct yt921x_mib {
+	u64 rx_broadcast;
+	u64 rx_pause;
+	u64 rx_multicast;
+	u64 rx_crc_errors;
+
+	u64 rx_alignment_errors;
+	u64 rx_undersize_errors;
+	u64 rx_fragment_errors;
+	u64 rx_64byte;
+
+	u64 rx_65_127byte;
+	u64 rx_128_255byte;
+	u64 rx_256_511byte;
+	u64 rx_512_1023byte;
+
+	u64 rx_1024_1518byte;
+	u64 rx_jumbo;
+	u64 rx_good_bytes;
+
+	u64 rx_bad_bytes;
+	u64 rx_oversize_errors;
+
+	u64 rx_dropped;
+	u64 tx_broadcast;
+	u64 tx_pause;
+	u64 tx_multicast;
+
+	u64 tx_undersize_errors;
+	u64 tx_64byte;
+	u64 tx_65_127byte;
+	u64 tx_128_255byte;
+
+	u64 tx_256_511byte;
+	u64 tx_512_1023byte;
+	u64 tx_1024_1518byte;
+	u64 tx_jumbo;
+
+	u64 tx_good_bytes;
+	u64 tx_collisions;
+
+	u64 tx_aborted_errors;
+	u64 tx_multiple_collisions;
+	u64 tx_single_collisions;
+	u64 tx_good;
+
+	u64 tx_deferred;
+	u64 tx_late_collisions;
+	u64 rx_oam;
+	u64 tx_oam;
+};
+
+struct yt921x_port {
+	unsigned char index;
+
+	bool hairpin;
+	bool isolated;
+	/* port mask of the joined bridge, including port itself and CPU port */
+	u16 bridge_mask;
+
+	spinlock_t stats_lock;
+	struct delayed_work mib_read;
+	struct yt921x_mib mib;
+	u64 rx_frames;
+	u64 tx_frames;
+};
+
+struct yt921x_priv {
+	struct dsa_switch ds;
+
+	const struct yt921x_info *info;
+	/* cache of YT921X_PON_STRAP_CAP */
+	u32 pon_strap_cap;
+	/* cache of dsa_cpu_ports(ds) */
+	u16 cpu_ports_mask;
+
+	/* slave bus */
+	const struct yt921x_reg_ops *smi_ops;
+	void *smi_ctx;
+
+	/* mdio master bus */
+	struct mii_bus *mbus_int;
+	struct mii_bus *mbus_ext;
+
+	struct mutex lock;
+
+	struct yt921x_port ports[YT921X_PORT_NUM];
+
+	u16 eee_ports_mask;
+
+	/* register prober */
+	u32 reg_addr;
+	u32 reg_val;
+	bool reg_valid;
+};
+
+#endif
-- 
2.50.1


