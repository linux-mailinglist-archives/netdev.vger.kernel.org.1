Return-Path: <netdev+bounces-296703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ADVGQUZJ2qhrgIAu9opvQ
	(envelope-from <netdev+bounces-296703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAA65A14E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:33:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tinyisr.com header.s=purelymail2 header.b=CN95t8i0;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=fLMnQMcx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=tinyisr.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54895301495F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED94378D9F;
	Mon,  8 Jun 2026 19:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C33314A95
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 19:30:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947039; cv=none; b=AnHwCDyU8Xc0KRQIIrZx3aFHMJERWPeIwM75U6//T/3ITAG86mjQeclaTBvHfEm5MyOdrvPEGFihl3deev9IH61uk5t2X/gYjsxjsWiYeXO4u+kjwUgTanjoKTAh9fX1jnHCQ34h7o0aWAulrcAo3cbghL6l4PnJUbVL8xPchzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947039; c=relaxed/simple;
	bh=peZaUgU6kF3usG1ARn8a1OMgbwDOcsjk3UjRsnYyPk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3GdIKGgM3oHFDYtMlNw8Vssg4d316KGOQOdd8YdMkDHQ3RjzlU8Q3m/Yq3r8zKb8Qf83vgQPXEU38PXTg2agBUeeNNINXgPGH0veATKfeKC0Ahsdix57OUUW9IoFBoGAPMgZ3sv91tP8xqdX0J7fK7EA8WGxvImZyHqZGhuLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=CN95t8i0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fLMnQMcx; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=CN95t8i0eBNblZS83jFqCx8jQ5XjtRg5c70s1Tvvy53X1C1VmqQU6wgaZsmKJQU2+iWv5CsyEBaBNBZsviiDr6eP4jTXcwCFxLDScjszYSlf/6M4xT/DGfWNBW/Ykm5USxZ6T8ZHKT+wY8IgdMLBh/NraTb1SMFbs6IKtjmhGtU8Oej0FptPjRJsg9zmrYHkTzlKFqlDv/e2QNs7PJ1Blw6E96wqHXhQufbzzJ2N3mMsDJyJk6DCdlY/cIRncWLN1KtQ2Ey7vSIELRcxPIaoUSFVxXBWe5mj9vFJ7JHx3InInOBIDwiTgWb9b5ndBBn2EGZEGeI5UU83DbgFkEvvaA==; s=purelymail2; d=tinyisr.com; v=1; bh=peZaUgU6kF3usG1ARn8a1OMgbwDOcsjk3UjRsnYyPk0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fLMnQMcxJr28EMyNO3WooqJb/z7f6X0WsY5PLou/Pg03Rfhx7WZqxVpWBbTkh5x21Q4g69RQ9BgZPYF+eH6fS5mellQsAlO0PiJXRXfPQXqexN6A5xzSFfIbsnckGUfs5zGmfMlOyJEumFuph1Q/GaCba9myWUu8uhtWPbtNNbVwFCrjuowHGmhY0skk4sKjGi/mx7FlFFesLvtj2GP43adZw9yammIe6CN0Vo388aDKuBHpJ+o3j1GSPM6xsfgs9s34gIboh2eiLkmfWdCFHWsZEoDPX90y5mXMDPXE8NEa9A6sLkc40f1IJPLnP1HLazqstX0oibTtv2/F178vKg==; s=purelymail2; d=purelymail.com; v=1; bh=peZaUgU6kF3usG1ARn8a1OMgbwDOcsjk3UjRsnYyPk0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 305744462;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 08 Jun 2026 19:30:36 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v4 2/4] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
Date: Mon,  8 Jun 2026 22:29:46 +0300
Message-ID: <20260608192948.289745-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608192948.289745-1-joey@tinyisr.com>
References: <20260608192948.289745-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296703-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:daniel@makrotopia.org,m:joey@tinyisr.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,arinc9.com,mediatek.com,makrotopia.org,tinyisr.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,purelymail.com:dkim,tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,tinyisr.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6CAA65A14E

The Fast Ethernet PHYs present in the MT7628 SoCs require an
undocumented bit to be set before they can establish 100mbps links.

This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
corresponding driver mtk-fe-soc.c.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/mediatek/Kconfig      | 10 +++++-
 drivers/net/phy/mediatek/Makefile     |  1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c | 50 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kc=
onfig
index bb7dc876271e..b6a51f38c358 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -21,8 +21,16 @@ config MEDIATEK_GE_PHY
 =09  common operations with MediaTek SoC built-in Gigabit
 =09  Ethernet PHYs.
=20
+config MEDIATEK_FE_SOC_PHY
+=09tristate "MediaTek SoC Fast Ethernet PHYs"
+=09help
+=09  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
+=09  This driver only sets an initialization bit required for the PHY
+=09  to establish 100 Mbps links. All other PHY operations are handled
+=09  by the kernel's generic PHY code.
+
 config MEDIATEK_GE_SOC_PHY
-=09tristate "MediaTek SoC Ethernet PHYs"
+=09tristate "MediaTek SoC Gigabit Ethernet PHYs"
 =09depends on ARM64 || COMPILE_TEST
 =09depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
 =09=09   COMPILE_TEST
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/M=
akefile
index ac57ecc799fc..6f9cacf7f906 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)=09+=3D mtk-2p5ge.o
+obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)=09+=3D mtk-fe-soc.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)=09=09+=3D mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)=09+=3D mtk-ge-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)=09=09+=3D mtk-phy-lib.o
diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediat=
ek/mtk-fe-soc.c
new file mode 100644
index 000000000000..317944411fbe
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for MT7628 Embedded Switch internal Fast Ethernet PHYs
+ */
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define MTK_FPHY_ID_MT7628=090x03a29410
+#define MTK_EXT_PAGE_ACCESS=090x1f
+
+static int mt7628_phy_read_page(struct phy_device *phydev)
+{
+=09return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
+}
+
+static int mt7628_phy_write_page(struct phy_device *phydev, int page)
+{
+=09return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
+}
+
+static int mt7628_phy_config_init(struct phy_device *phydev)
+{
+=09/*
+=09 * This undocumented bit is required for the PHYs to be able to
+=09 * establish 100mbps links.
+=09 */
+=09return phy_write_paged(phydev, 0x8000, 30, BIT(13));
+}
+
+static struct phy_driver mtk_soc_fe_phy_driver[] =3D {
+=09{
+=09=09PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628),
+=09=09.name =3D "MediaTek MT7628 PHY",
+=09=09.config_init =3D mt7628_phy_config_init,
+=09=09.read_page =3D mt7628_phy_read_page,
+=09=09.write_page =3D mt7628_phy_write_page,
+=09},
+};
+
+module_phy_driver(mtk_soc_fe_phy_driver);
+static const struct mdio_device_id __maybe_unused mtk_soc_fe_phy_tbl[] =3D=
 {
+=09{ PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628) },
+=09{ }
+};
+
+MODULE_DESCRIPTION("MediaTek SoC Fast Ethernet PHY driver");
+MODULE_AUTHOR("Joris Vaisvila <joey@tinyisr.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, mtk_soc_fe_phy_tbl);
--=20
2.54.0


