Return-Path: <netdev+bounces-262200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKdEEchJo2kF/QQAu9opvQ
	(envelope-from <netdev+bounces-262200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:02:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D561C7CD0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F8D930CA0DD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9F3E0C4E;
	Sat, 28 Feb 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="BQdd86js";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TN+xpiA8"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486773E0C40
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304814; cv=none; b=jzWaE+HBB98mH0ZV36i1iZ3266K8uLiNHLK2mRvRhhSVHEVx0habD1p51iEq6lUy+pcTU2bdMEEOG3GHLFHDY5xtkq6Y/OZlrffgwHQkIQdrX6JeeVwdipRuehamAQI446A9jeTAMjlodGNh+EMpMtPK3DAlkNDsXgp+xQ3QAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304814; c=relaxed/simple;
	bh=XMDHbm5RncSG6qsU1lwxMnDqm+3AqxgQXxRAbGIT0cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG0WTUY6jHD0ACRsDdKFg3iHS/jEciM8f3GtoulslWYgOPHITq67FbqAJudbACH7hVmtYvorangi+8+MeXcMdpD/hFaCXQVUPbYiFwQT5ajyyK6F942HJYLu53L3fcoMKEDiZUMxwn7buXn1vrIPkiTT05oPYQFVZSatTdrrRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=BQdd86js; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TN+xpiA8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BQdd86jsTj7u9wlLUNLqjEsg7fZ+r/cHnkkPalwBvnwd33OOE+Cj3Ce4K5b/Fisxcy9kPZErlT5sOJisqOMW0nHBMljrb2vYd7p7KpUx/JZt7CWNsqgqGBG5L6KlkSrNx+qWF9RlDD7RbzY7gucIvzqj0GhMYnz849b3gWkHVRC8pgv/7ggy/69n2WKBbVtYcbQfCQbJLn8yXkydnxJkVKTFInlQb6uLp2Lscsycsb8NlMKK+aFzmEPBFclFqIhqDP+iPzv5r1Wx1I8M1sa+8gg7Wg+iS+K3iUERCe/FykjMnvh1MSLFdRNzaooZM2IsbMmKYTCBZyH8ERqU/Tpogw==; s=purelymail3; d=tinyisr.com; v=1; bh=XMDHbm5RncSG6qsU1lwxMnDqm+3AqxgQXxRAbGIT0cQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=TN+xpiA8fUHoqLfz169lNLKENrB6FXBLjsIbAbaVI4J37vFbSdnaRD3FReljfbH6YIxVDLHkVxz7O/WsWVEoI5GHLIvg8Gn+S88VN4Qda99hxXnRSOlQIsHgxLEVBAkhaMovv5hw7c+8uPIqr1PYMfAJDG8vWZNMv/B7pXfV72j1CVqd1omG0lEKg+pf7EcF7bf3/fKeH4ivruJo+7hALBdYULK4c35Il0LHTlkf9kBSP+M41v4AcaQBmjQ52A1Nvqrh3mSs+XFYEzhioygNwLlxZtNOPGJ3rtiqx4AjhbrpT1ZTSnsWMQWCxX7AGmetJ3zbeqkdNEGaqySw1swFEQ==; s=purelymail3; d=purelymail.com; v=1; bh=XMDHbm5RncSG6qsU1lwxMnDqm+3AqxgQXxRAbGIT0cQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1487390422;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 28 Feb 2026 18:53:27 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC PATCH 2/2 net-next] net: dsa: initial support for MT7628 embedded switch
Date: Sat, 28 Feb 2026 20:52:43 +0200
Message-ID: <20260228185242.800836-4-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228185242.800836-1-joey@tinyisr.com>
References: <20260228185242.800836-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-262200-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tinyisr.com:mid,tinyisr.com:dkim,tinyisr.com:email,purelymail.com:dkim]
X-Rspamd-Queue-Id: 95D561C7CD0
X-Rspamd-Action: no action

Add support for the MT7628 embedded switch.

The switch supports 16 VLANs, has 5x 100mbps built-in user ports and
support for a single external 1000mbps MAC as port 5.

It does not have any way to control inter-port forwarding outside of
VLANs, so the switch is configured with tag_8021q standalone VLANs.

Double tag is enabled to fake VLAN-unaware mode until support is added
for offloading VLAN filtering.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/dsa/Kconfig  |   6 +
 drivers/net/dsa/Makefile |   1 +
 drivers/net/dsa/mt7628.c | 567 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 574 insertions(+)
 create mode 100644 drivers/net/dsa/mt7628.c

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 39fb8ead16b5..7af20d0d22d7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -70,6 +70,12 @@ config NET_DSA_MV88E6060
 =09  This enables support for the Marvell 88E6060 ethernet switch
 =09  chip.
=20
+config NET_DSA_MT7628
+=09tristate "MT7628 Embedded ethernet switch support"
+=09select NET_DSA_TAG_MT7628
+=09help
+=09  This enables support for the switch in the MT7628 SoC.
+
 source "drivers/net/dsa/microchip/Kconfig"
=20
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index f5a463b87ec2..22da6b680f29 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) +=3D vitesse-vsc73x=
x-core.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) +=3D vitesse-vsc73xx-platfo=
rm.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) +=3D vitesse-vsc73xx-spi.o
 obj-$(CONFIG_NET_DSA_YT921X) +=3D yt921x.o
+obj-$(CONFIG_NET_DSA_MT7628) +=3D mt7628.o
 obj-y=09=09=09=09+=3D b53/
 obj-y=09=09=09=09+=3D hirschmann/
 obj-y=09=09=09=09+=3D lantiq/
diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
new file mode 100644
index 000000000000..25881f2acf12
--- /dev/null
+++ b/drivers/net/dsa/mt7628.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek MT7628 Embedded Switch (ESW) DSA driver
+ * Copyright (C) 2026 Joris Vaisvila <joey@tinyisr.com>
+ *
+ * Portions derived from OpenWRT esw_rt3050 driver:
+ * Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2009-2015 Felix Fietkau <nbd@nbd.name>
+ * Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ * Copyright (C) 2016 Vittorio Gambaletta <openwrt@vittgam.net>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/dsa/8021q.h>
+#include <linux/if_bridge.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <net/dsa.h>
+
+#define MT7628_ESW_REG_IMR 0x04
+#define MT7628_ESW_REG_FCT0 0x08
+#define MT7628_ESW_REG_PFC1 0x14
+#define MT7628_ESW_REG_PVIDC(_n) (0x40 + 4 * (_n))
+#define MT7628_ESW_REG_VLANI(_n) (0x50 + 4 * (_n))
+#define MT7628_ESW_REG_VMSC(_n) (0x70 + 4 * (_n))
+#define MT7628_ESW_REG_VUB(_n) (0x100 + 4 * (_n))
+#define MT7628_ESW_REG_SOCPC 0x8c
+#define MT7628_ESW_REG_POC0 0x90
+#define MT7628_ESW_REG_POC2 0x98
+#define MT7628_ESW_REG_SGC 0x9c
+#define MT7628_ESW_REG_PCR0 0xc0
+#define MT7628_ESW_REG_PCR1 0xc4
+#define MT7628_ESW_REG_FPA2 0xc8
+#define MT7628_ESW_REG_FCT2 0xcc
+#define MT7628_ESW_REG_SGC2 0xe4
+
+#define MT7628_ESW_PFC1_EN_VLAN GENMASK(22, 16)
+
+#define MT7628_ESW_PVIDC_PVID_M 0xfff
+#define MT7628_ESW_PVIDC_PVID_S 12
+#define MT7628_ESW_VLANI_VID_M 0xfff
+#define MT7628_ESW_VLANI_VID_S 12
+#define MT7628_ESW_VMSC_MSC_M 0xff
+#define MT7628_ESW_VMSC_MSC_S 8
+#define MT7628_ESW_VUB_S 7
+#define MT7628_ESW_VUB_M 0x7f
+
+#define MT7628_ESW_SOCPC_CRC_PADDING BIT(25)
+#define MT7628_ESW_SOCPC_DISBC2CPU GENMASK(22, 16)
+#define MT7628_ESW_SOCPC_DISMC2CPU GENMASK(14, 8)
+#define MT7628_ESW_SOCPC_DISUN2CPU GENMASK(6, 0)
+
+#define MT7628_ESW_POC0_PORT_DISABLE GENMASK(29, 23)
+
+#define MT7628_ESW_POC2_PER_VLAN_UNTAG_EN BIT(15)
+
+#define MT7628_ESW_SGC_AGING_INTERVAL GENMASK(3, 0)
+#define MT7628_ESW_BC_STORM_PROT GENMASK(5, 4)
+#define MT7628_ESW_PKT_MAX_LEN GENMASK(7, 6)
+#define MT7628_ESW_DIS_PKT_ABORT BIT(8)
+#define MT7628_ESW_ADDRESS_HASH_ALG GENMASK(10, 9)
+#define MT7628_ESW_DISABLE_TX_BACKOFF BIT(11)
+#define MT7628_ESW_BP_JAM_CNT GENMASK(15, 12)
+#define MT7628_ESW_DISMIIPORT_WASTX GENMASK(17, 16)
+#define MT7628_ESW_BP_MODE GENMASK(19, 18)
+#define MT7628_ESW_BISH_DIS BIT(20)
+#define MT7628_ESW_BISH_TH GENMASK(22, 21)
+#define MT7628_ESW_LED_FLASH_TIME GENMASK(24, 23)
+#define MT7628_ESW_RMC_RULE GENMASK(26, 25)
+#define MT7628_ESW_IP_MULT_RULE GENMASK(28, 27)
+#define MT7628_ESW_LEN_ERR_CHK BIT(29)
+#define MT7628_ESW_BKOFF_ALG BIT(30)
+
+#define MT7628_ESW_PCR0_WT_NWAY_DATA GENMASK(31, 16)
+#define MT7628_ESW_PCR0_RD_PHY_CMD BIT(14)
+#define MT7628_ESW_PCR0_WT_PHY_CMD BIT(13)
+#define MT7628_ESW_PCR0_CPU_PHY_REG GENMASK(12, 8)
+#define MT7628_ESW_PCR0_CPU_PHY_ADDR GENMASK(4, 0)
+
+#define MT7628_ESW_PCR1_RD_DATA GENMASK(31, 16)
+#define MT7628_ESW_PCR1_RD_DONE BIT(1)
+#define MT7628_ESW_PCR1_WT_DONE BIT(0)
+
+#define MT7628_ESW_FPA2_AP_EN BIT(29)
+#define MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE GENMASK(28, 24)
+#define MT7628_ESW_FPA2_FORCE_RGMII_LINK1 BIT(13)
+#define MT7628_ESW_FPA2_FORCE_RGMII_EN1 BIT(11)
+
+#define MT7628_ESW_FCT2_MUST_DROP_RLS_TH GENMASK(17, 13)
+#define MT7628_ESW_FCT2_MUST_DROP_SET_TH GENMASK(12, 8)
+#define MT7628_ESW_FCT2_MC_PER_PORT_TH GENMASK(5, 0)
+
+#define MT7628_ESW_SGC2_SPECIAL_TAG_EN BIT(23)
+#define MT7628_ESW_SGC2_TX_CPU_TPID_BIT_MAP GENMASK(22, 16)
+#define MT7628_ESW_SGC2_DOUBLE_TAG_EN GENMASK(6, 0)
+
+#define MT7628_ESW_PORTS_NOCPU GENMASK(5, 0)
+#define MT7628_ESW_PORTS_CPU BIT(6)
+#define MT7628_ESW_PORTS_ALL GENMASK(6, 0)
+
+#define MT7628_ESW_NUM_PORTS 7
+#define MT7628_NUM_VLANS 16
+
+static const struct regmap_config mt7628_esw_regmap_cfg =3D {
+=09.name =3D "mt7628-esw",
+=09.reg_bits =3D 32,
+=09.val_bits =3D 32,
+=09.reg_stride =3D 4,
+=09.fast_io =3D true,
+=09.reg_format_endian =3D REGMAP_ENDIAN_LITTLE,
+=09.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+};
+
+struct mt7628_vlan {
+=09bool active;
+=09u8 members;
+=09u8 untag;
+=09u16 vid;
+};
+
+struct mt7628_esw {
+=09void __iomem *base;
+=09struct reset_control *rst_ephy;
+=09struct reset_control *rst_esw;
+=09struct regmap *regmap;
+=09struct dsa_switch *ds;
+=09u16 tag_8021q_pvid[MT7628_ESW_NUM_PORTS];
+=09struct mt7628_vlan vlans[MT7628_NUM_VLANS];
+};
+
+static int mt7628_phy_read(struct dsa_switch *ds, int port, int regnum)
+{
+=09int ret =3D 0;
+=09u32 val =3D 0;
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
+=09=09=09=09       5000);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG, regnum) |
+=09=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
+=09=09=09=09=09      port) |
+=09=09=09=09   MT7628_ESW_PCR0_RD_PHY_CMD);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       (val & MT7628_ESW_PCR1_RD_DONE), 10,
+=09=09=09=09       5000);
+out:
+=09if (ret) {
+=09=09dev_err(ds->dev, "read failed. MDIO timeout?\n");
+=09=09return -ETIMEDOUT;
+=09}
+=09return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
+}
+
+static int mt7628_phy_write(struct dsa_switch *ds, int port, int regnum,
+=09=09=09    u16 dat)
+{
+=09u32 val;
+=09int ret =3D 0;
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       !(val & MT7628_ESW_PCR1_WT_DONE), 10,
+=09=09=09=09       5000);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_write(
+=09=09esw->regmap, MT7628_ESW_REG_PCR0,
+=09=09FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
+=09=09=09FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG, regnum) |
+=09=09=09FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR, port) |
+=09=09=09MT7628_ESW_PCR0_WT_PHY_CMD);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       (val & MT7628_ESW_PCR1_WT_DONE), 10,
+=09=09=09=09       5000);
+out:
+=09if (ret) {
+=09=09dev_err(ds->dev, "write failed. MDIO timeout?\n");
+=09=09return -ETIMEDOUT;
+=09}
+=09return ret;
+}
+
+static void mt7628_vendor_phys_init(struct dsa_switch *ds)
+{
+=09/* vendor specific init sequence from openwrt/uboot */
+=09mt7628_phy_write(ds, 0, 31, 0x2000); /* change G2 page */
+=09mt7628_phy_write(ds, 0, 26, 0x0020);
+
+=09for (int i =3D 0; i < 5; i++) {
+=09=09mt7628_phy_write(ds, i, 31, 0x8000); /* change L0 page */
+=09=09mt7628_phy_write(ds, i, 0, 0x3100);
+
+=09=09/* EEE disable */
+=09=09mt7628_phy_write(ds, i, 30, 0xa000);
+=09=09mt7628_phy_write(ds, i, 31, 0xa000); /* change L2 page */
+=09=09mt7628_phy_write(ds, i, 16, 0x0606);
+=09=09mt7628_phy_write(ds, i, 23, 0x0f0e);
+=09=09mt7628_phy_write(ds, i, 24, 0x1610);
+=09=09mt7628_phy_write(ds, i, 30, 0x1f15);
+=09=09mt7628_phy_write(ds, i, 28, 0x6111);
+=09=09mt7628_phy_write(ds, i, 31, 0x2000);
+=09=09mt7628_phy_write(ds, i, 26, 0x0000);
+=09}
+
+=09/* 100Base AOI setting */
+=09mt7628_phy_write(ds, 0, 31, 0x5000); /* change G5 page */
+=09mt7628_phy_write(ds, 0, 19, 0x004a);
+=09mt7628_phy_write(ds, 0, 20, 0x015a);
+=09mt7628_phy_write(ds, 0, 21, 0x00ee);
+=09mt7628_phy_write(ds, 0, 22, 0x0033);
+=09mt7628_phy_write(ds, 0, 23, 0x020a);
+=09mt7628_phy_write(ds, 0, 24, 0x0000);
+=09mt7628_phy_write(ds, 0, 25, 0x024a);
+=09mt7628_phy_write(ds, 0, 26, 0x035a);
+=09mt7628_phy_write(ds, 0, 27, 0x02ee);
+=09mt7628_phy_write(ds, 0, 28, 0x0233);
+=09mt7628_phy_write(ds, 0, 29, 0x000a);
+=09mt7628_phy_write(ds, 0, 30, 0x0000);
+}
+
+static void mt7628_switch_init(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09/* undocumented init sequence from openwrt/uboot */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_FCT0, 0xC8A07850);
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SGC2, 0x00000000);
+
+=09regmap_write(
+=09=09esw->regmap, MT7628_ESW_REG_FCT2,
+=09=09FIELD_PREP(MT7628_ESW_FCT2_MC_PER_PORT_TH, 0xc) |
+=09=09=09FIELD_PREP(MT7628_ESW_FCT2_MUST_DROP_SET_TH, 0x10) |
+=09=09=09FIELD_PREP(MT7628_ESW_FCT2_MUST_DROP_RLS_TH, 0x12));
+
+=09/*
+=09 * general switch configuration:
+=09 * 300s aging interval
+=09 * broadcast storm prevention disabled
+=09 * max packet length 1536 bytes
+=09 * disable collision 16 packet abort and late collision abort
+=09 * use xor48 for address hashing
+=09 * disable tx backoff
+=09 * 10 packet back pressure jam
+=09 * disable was_transmit
+=09 * jam until BP condition released
+=09 * 30ms LED flash
+=09 * rmc tb fault to all ports
+=09 * unmatched IGMP as broadcast
+=09 */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SGC,
+=09=09     FIELD_PREP(MT7628_ESW_SGC_AGING_INTERVAL, 1) |
+=09=09=09     FIELD_PREP(MT7628_ESW_BC_STORM_PROT, 0) |
+=09=09=09     FIELD_PREP(MT7628_ESW_PKT_MAX_LEN, 0) |
+=09=09=09     MT7628_ESW_DIS_PKT_ABORT |
+=09=09=09     FIELD_PREP(MT7628_ESW_ADDRESS_HASH_ALG, 1) |
+=09=09=09     MT7628_ESW_DISABLE_TX_BACKOFF |
+=09=09=09     FIELD_PREP(MT7628_ESW_BP_JAM_CNT, 10) |
+=09=09=09     FIELD_PREP(MT7628_ESW_DISMIIPORT_WASTX, 0) |
+=09=09=09     FIELD_PREP(MT7628_ESW_BP_MODE, 0b10) |
+=09=09=09     FIELD_PREP(MT7628_ESW_LED_FLASH_TIME, 0) |
+=09=09=09     FIELD_PREP(MT7628_ESW_RMC_RULE, 0) |
+=09=09=09     FIELD_PREP(MT7628_ESW_IP_MULT_RULE, 0));
+
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SOCPC,
+=09=09     MT7628_ESW_SOCPC_CRC_PADDING |
+=09=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISUN2CPU,
+=09=09=09=09=09MT7628_ESW_PORTS_CPU) |
+=09=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISMC2CPU,
+=09=09=09=09=09MT7628_ESW_PORTS_CPU) |
+=09=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISBC2CPU,
+=09=09=09=09=09MT7628_ESW_PORTS_CPU));
+
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_FPA2,
+=09=09=09MT7628_ESW_FPA2_FORCE_RGMII_EN1 |
+=09=09=09=09MT7628_ESW_FPA2_FORCE_RGMII_LINK1 |
+=09=09=09=09MT7628_ESW_FPA2_AP_EN);
+
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_FPA2,
+=09=09=09   MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE,
+=09=09=09   FIELD_PREP(MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE, 31));
+
+=09/* disable all interrupts */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_IMR, 0);
+
+=09/* enable special tag on CPU port */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SGC2,
+=09=09     MT7628_ESW_SGC2_SPECIAL_TAG_EN |
+=09=09=09     FIELD_PREP(MT7628_ESW_SGC2_TX_CPU_TPID_BIT_MAP,
+=09=09=09=09=09MT7628_ESW_PORTS_CPU));
+
+=09/* set up switch for double tagging to simulate vlan unawareness */
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_POC2,
+=09=09=09MT7628_ESW_POC2_PER_VLAN_UNTAG_EN);
+=09regmap_update_bits(
+=09=09esw->regmap, MT7628_ESW_REG_PFC1, MT7628_ESW_PFC1_EN_VLAN,
+=09=09FIELD_PREP(MT7628_ESW_PFC1_EN_VLAN, MT7628_ESW_PORTS_ALL));
+}
+
+static void esw_set_vlan_id(struct mt7628_esw *esw, unsigned vlan, unsigne=
d vid)
+{
+=09unsigned s =3D MT7628_ESW_VLANI_VID_S * (vlan % 2);
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VLANI(vlan / 2),
+=09=09=09   MT7628_ESW_VLANI_VID_M << s,
+=09=09=09   (vid & MT7628_ESW_VLANI_VID_M) << s);
+}
+
+static void esw_set_pvid(struct mt7628_esw *esw, unsigned port, unsigned p=
vid)
+{
+=09unsigned s =3D MT7628_ESW_PVIDC_PVID_S * (port % 2);
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_PVIDC(port / 2),
+=09=09=09   MT7628_ESW_PVIDC_PVID_M << s,
+=09=09=09   (pvid & MT7628_ESW_PVIDC_PVID_M) << s);
+}
+
+static void esw_set_vmsc(struct mt7628_esw *esw, unsigned vlan, unsigned m=
sc)
+{
+=09unsigned s =3D MT7628_ESW_VMSC_MSC_S * (vlan % 4);
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VMSC(vlan / 4),
+=09=09=09   MT7628_ESW_VMSC_MSC_M << s,
+=09=09=09   (msc & MT7628_ESW_VMSC_MSC_M) << s);
+}
+
+static void esw_set_vub(struct mt7628_esw *esw, unsigned vlan, unsigned ms=
c)
+{
+=09unsigned s =3D MT7628_ESW_VUB_S * (vlan % 4);
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VUB(vlan / 4),
+=09=09=09   MT7628_ESW_VUB_M << s,
+=09=09=09   (msc & MT7628_ESW_VUB_M) << s);
+}
+
+static void mt7628_vlan_sync(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09int i;
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *vlan =3D &esw->vlans[i];
+=09=09esw_set_vmsc(esw, i, vlan->members);
+=09=09esw_set_vlan_id(esw, i, vlan->vid);
+=09=09esw_set_vub(esw, i, vlan->untag);
+=09}
+
+=09for (i =3D 0; i < ds->num_ports; i++)
+=09=09esw_set_pvid(esw, i, esw->tag_8021q_pvid[i]);
+}
+
+static int mt7628_setup(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09reset_control_reset(esw->rst_esw);
+=09usleep_range(1000, 2000);
+=09reset_control_reset(esw->rst_ephy);
+=09usleep_range(1000, 2000);
+=09/*
+=09 * all MMIO reads hang if esw is not out of reset
+=09 * ephy needs extra time to get out of reset or it ends up misconfigure=
d
+=09 */
+=09mt7628_vendor_phys_init(ds);
+=09mt7628_switch_init(ds);
+=09rtnl_lock();
+=09dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+=09rtnl_unlock();
+=09return 0;
+}
+
+static int mt7628_port_enable(struct dsa_switch *ds, int port,
+=09=09=09      struct phy_device *phy)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09regmap_clear_bits(esw->regmap, MT7628_ESW_REG_POC0,
+=09=09=09  FIELD_PREP(MT7628_ESW_POC0_PORT_DISABLE, BIT(port)));
+=09return 0;
+}
+
+static void mt7628_port_disable(struct dsa_switch *ds, int port)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_POC0,
+=09=09=09FIELD_PREP(MT7628_ESW_POC0_PORT_DISABLE, BIT(port)));
+}
+
+static enum dsa_tag_protocol
+mt7628_get_tag_proto(struct dsa_switch *ds, int port, enum dsa_tag_protoco=
l mp)
+{
+=09return DSA_TAG_PROTO_MT7628;
+}
+
+static void mt7628_phylink_get_caps(struct dsa_switch *ds, int port,
+=09=09=09=09    struct phylink_config *config)
+{
+=09config->mac_capabilities =3D MAC_100 | MAC_10;
+=09__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
+=09__set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
+}
+
+static int mt7628_dsa_8021q_vlan_add(struct dsa_switch *ds, int port, u16 =
vid,
+=09=09=09=09     u16 flags)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan =3D NULL;
+
+=09for (int i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
+=09=09if (!check_vlan->active) {
+=09=09=09vlan =3D check_vlan;
+=09=09} else if (check_vlan->vid =3D=3D vid) {
+=09=09=09vlan =3D check_vlan;
+=09=09=09break;
+=09=09}
+=09}
+
+=09if (!vlan)
+=09=09return -ENOSPC;
+
+=09vlan->vid =3D vid;
+=09vlan->active =3D true;
+=09vlan->members |=3D BIT(port);
+
+=09if (flags & BRIDGE_VLAN_INFO_PVID)
+=09=09esw->tag_8021q_pvid[port] =3D vid;
+
+=09if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
+=09=09vlan->untag |=3D BIT(port);
+
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static int mt7628_dsa_8021q_vlan_del(struct dsa_switch *ds, int port, u16 =
vid)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan =3D NULL;
+
+=09for (int i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
+=09=09if (check_vlan->active || check_vlan->vid !=3D vid)
+=09=09=09continue;
+=09=09vlan =3D check_vlan;
+=09=09break;
+=09}
+=09if (!vlan)
+=09=09return -ENOENT;
+
+=09vlan->members &=3D ~BIT(port);
+=09vlan->untag &=3D ~BIT(port);
+
+=09if (!vlan->members)
+=09=09vlan->active =3D false;
+
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static struct dsa_switch_ops mt7628_switch_ops =3D {
+=09.get_tag_protocol =3D mt7628_get_tag_proto,
+=09.setup =3D mt7628_setup,
+=09.port_enable =3D mt7628_port_enable,
+=09.port_disable =3D mt7628_port_disable,
+=09.phy_read =3D mt7628_phy_read,
+=09.phy_write =3D mt7628_phy_write,
+=09.phylink_get_caps =3D mt7628_phylink_get_caps,
+=09.tag_8021q_vlan_add =3D mt7628_dsa_8021q_vlan_add,
+=09.tag_8021q_vlan_del =3D mt7628_dsa_8021q_vlan_del,
+};
+
+static int mt7628_probe(struct platform_device *pdev)
+{
+=09struct dsa_switch *ds =3D NULL;
+=09struct mt7628_esw *esw =3D NULL;
+=09struct device *dev =3D &pdev->dev;
+
+=09ds =3D devm_kzalloc(&pdev->dev, sizeof(*ds), GFP_KERNEL);
+=09if (!ds)
+=09=09return -ENOMEM;
+
+=09esw =3D devm_kzalloc(&pdev->dev, sizeof(*esw), GFP_KERNEL);
+=09if (!esw)
+=09=09return -ENOMEM;
+
+=09esw->base =3D devm_platform_ioremap_resource(pdev, 0);
+=09if (IS_ERR(esw->base))
+=09=09return PTR_ERR(esw->base);
+
+=09esw->regmap =3D devm_regmap_init_mmio(&pdev->dev, esw->base,
+=09=09=09=09=09    &mt7628_esw_regmap_cfg);
+=09if (IS_ERR(esw->regmap))
+=09=09return PTR_ERR(esw->regmap);
+
+=09esw->rst_ephy =3D devm_reset_control_get_exclusive(&pdev->dev, "ephy");
+=09if (IS_ERR(esw->rst_ephy)) {
+=09=09dev_err(dev, "failed to get EPHY reset: %pe\n", esw->rst_ephy);
+=09=09esw->rst_ephy =3D NULL;
+=09}
+
+=09esw->rst_esw =3D devm_reset_control_get_exclusive(&pdev->dev, "esw");
+=09if (IS_ERR(esw->rst_esw)) {
+=09=09dev_err(dev, "failed to get ESW reset: %pe\n", esw->rst_esw);
+=09=09esw->rst_esw =3D NULL;
+=09}
+
+=09ds->dev =3D dev;
+=09ds->num_ports =3D MT7628_ESW_NUM_PORTS;
+=09ds->ops =3D &mt7628_switch_ops;
+=09ds->priv =3D esw;
+=09esw->ds =3D ds;
+=09dev_set_drvdata(dev, esw);
+
+=09return dsa_register_switch(ds);
+}
+
+static void mt7628_remove(struct platform_device *pdev)
+{
+=09struct mt7628_esw *esw =3D platform_get_drvdata(pdev);
+=09if (!esw)
+=09=09return;
+
+=09dsa_unregister_switch(esw->ds);
+}
+
+static void mt7628_shutdown(struct platform_device *pdev)
+{
+=09struct mt7628_esw *esw =3D platform_get_drvdata(pdev);
+=09if (!esw)
+=09=09return;
+
+=09dsa_switch_shutdown(esw->ds);
+=09dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static const struct of_device_id mt7628_of_match[] =3D {
+=09{
+=09=09.compatible =3D "mediatek,mt7628-esw",
+=09},
+=09{},
+};
+
+MODULE_DEVICE_TABLE(of, mt7628_of_match);
+
+static struct platform_driver mt7628_driver =3D {
+    .driver =3D {
+        .name =3D "mt7628-esw",
+        .of_match_table =3D mt7628_of_match,
+    },
+    .probe =3D mt7628_probe,
+    .remove =3D mt7628_remove,
+    .shutdown =3D mt7628_shutdown,
+};
+
+module_platform_driver(mt7628_driver);
+
+MODULE_AUTHOR("Joris Vaisvila <joey@tinyisr.com>");
+MODULE_DESCRIPTION("Driver for Mediatek MT7628 embedded switch");
+MODULE_LICENSE("GPL v2");
--=20
2.53.0


