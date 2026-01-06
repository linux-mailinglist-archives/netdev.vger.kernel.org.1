Return-Path: <netdev+bounces-247310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93387CF6C8C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 06:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E61030057DB
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922E2D8DDB;
	Tue,  6 Jan 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="YbKW6fqH";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Ctfx17by"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA12BD5A8
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767677376; cv=none; b=BTNqiS/0ITHUb0IETkT8VJgyjqP2VTM+sutbzmdZ6Qyik00cs5HP79ie7UN6SX/Ynohz+MPrcKXvNR/YHw1L8xIGWgbQSXeJkU/ckKqeOhRdrOf+WU7y1F6C6bbZynr480u6jgOR53yjFcmbX4sD4RM/kgI5r485K2tUaGQ/UAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767677376; c=relaxed/simple;
	bh=IE0SnzosIq6pX3iVdoBiITRZ+n5l9UvqVTkJlohal3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6+X/NZHropl+e9ovkrQLtNDdEg++eFzCPUoOz9aMOjS7IXWhmA/Iis8Y9FKal7rVeH/84lncw2zIkyjtZDk19/tIi1/OKZckaZgZWo2hEWxt7SNhVV5OU25+onpO4O3/k/rOFGeMSZ4J/KWybH9m6kioONV7tBunMUinyENA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=YbKW6fqH; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Ctfx17by; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=YbKW6fqHon7GZwaBpyK5Sr17ajYVaQLJoH0bCkDkCzJRgDvnrqHdYu5G7kLQoMKHD4C/jlw6KKFkXNLZR/3xLq54E55VLPruKtbPaKOgY6xm+cy05GzvO6ja/YKETbnOM/WhL/bSHgutBEMpll54/W0eFFRXaqvbk0GUFLh1cG8JeMKlIFGduNlFr1S06I4QrbOcb+b1u2XR9MzjaT7m9oltykmD9bxSvDLehFLEum3K1dg0dKP3rLFZ077vdSF9GvvWL7PWo4+0b1ast/SgZDk380CEeKQ5k0VT2OQiZY5Ztccl3m1GxSofbP3lcQY8k4z7R7avHhqoBRHKxIzsXA==; s=purelymail1; d=tinyisr.com; v=1; bh=IE0SnzosIq6pX3iVdoBiITRZ+n5l9UvqVTkJlohal3k=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Ctfx17byLqNKJrY5wbkuuvL/QunuGSkNw/6O3k1A6fG6VqdGaKR5DnFSHSiqJhNxLshibex3hT6H3O6z0GdEEalXX5n74R27qlnliuZVb3qMHybcE+WBRuqhAP4/+r7pwJxTZ0gMZPBjM1XIIvPduzF+EeO8yQWv93uJ4/RfHKfaOmbRaXmIsXco9Yczwwv6t8wE71xHy9MZXuUP99eQWh2KX9RH9FVKPUpF4rsIB0xLG5DvXH/tOq4q0KftkzVjphbbG1HD2DKItXtyVX57oN8bPzb9pR2Ucj36EflsUR/AcQLJai529sd6ScSrn/YZOVS3dSd9n16NY84OUkfdDg==; s=purelymail1; d=purelymail.com; v=1; bh=IE0SnzosIq6pX3iVdoBiITRZ+n5l9UvqVTkJlohal3k=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 234099727;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Jan 2026 05:29:26 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH v2] net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628
Date: Tue,  6 Jan 2026 07:18:28 +0200
Message-ID: <20260106052845.1945352-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The MT7628 does not expose MAC control registers. Writes to these
registers corrupt the ESW VLAN configuration. Existing drivers
never use the affected features, so this went unnoticed.

This patch skips MCR register reads and writes on MT7628, preventing
invalid register access.

Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
v2:
- Add missing Fixes tag

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index e68997a29191..2fae6bd368a6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -699,6 +699,9 @@ static int mtk_mac_finish(struct phylink_config *config=
, unsigned int mode,
 =09struct mtk_eth *eth =3D mac->hw;
 =09u32 mcr_cur, mcr_new;
=20
+=09if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+=09=09return 0;
+
 =09/* Enable SGMII */
 =09if (interface =3D=3D PHY_INTERFACE_MODE_SGMII ||
 =09    phy_interface_mode_is_8023z(interface))
@@ -724,6 +727,9 @@ static void mtk_mac_link_down(struct phylink_config *co=
nfig, unsigned int mode,
 =09struct mtk_mac *mac =3D container_of(config, struct mtk_mac,
 =09=09=09=09=09   phylink_config);
=20
+=09if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_SOC_MT7628))
+=09=09return;
+
 =09if (!mtk_interface_mode_is_xgmii(mac->hw, interface)) {
 =09=09/* GMAC modes */
 =09=09mtk_m32(mac->hw,
@@ -815,6 +821,9 @@ static void mtk_gdm_mac_link_up(struct mtk_mac *mac,
 {
 =09u32 mcr;
=20
+=09if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_SOC_MT7628))
+=09=09return;
+
 =09mcr =3D mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 =09mcr &=3D ~(MAC_MCR_SPEED_100 | MAC_MCR_SPEED_1000 |
 =09=09 MAC_MCR_FORCE_DPX | MAC_MCR_FORCE_TX_FC |
@@ -4357,9 +4366,11 @@ static void mtk_prepare_for_reset(struct mtk_eth *et=
h)
 =09mtk_w32(eth, 0, MTK_FE_INT_ENABLE);
=20
 =09/* force link down GMAC */
-=09for (i =3D 0; i < 2; i++) {
-=09=09val =3D mtk_r32(eth, MTK_MAC_MCR(i)) & ~MAC_MCR_FORCE_LINK;
-=09=09mtk_w32(eth, val, MTK_MAC_MCR(i));
+=09if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628)) {
+=09=09for (i =3D 0; i < 2; i++) {
+=09=09=09val =3D mtk_r32(eth, MTK_MAC_MCR(i)) & ~MAC_MCR_FORCE_LINK;
+=09=09=09mtk_w32(eth, val, MTK_MAC_MCR(i));
+=09=09}
 =09}
 }
=20
--=20
2.52.0


