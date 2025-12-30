Return-Path: <netdev+bounces-246308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63403CE92CB
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D47D830028A6
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64727F75F;
	Tue, 30 Dec 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="SpVQxjT2";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="EbUQ/opg"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19B277023
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086013; cv=none; b=ECmflT0AHHaNkW/PbLwbI2c0fku3dld/XC8Awab1FC8JAUJXOjlKihmeLr9V/ILRxEOOyXt6M3Wo8sZ82DuTbSFev+IT6mth8LizdAU0JCeROo7k2TqD7TWlQSxMyEnTYCYsFwG7m1F7bGl6DkpPohazdUg79SpOehnRzap6pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086013; c=relaxed/simple;
	bh=g+TBXdgYNtzZT3hhbPhG1j65uOqO8FfPYxezOjTu+Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MjZmILlnzZjMmrdnocedErigLsOrKdmSiA5oCidj4v1uXso/jwo6YU1bC9xmca/kkvOSYWeO+Z5qh/4VCIiU3ZWSpsn0iKEapVkVmQVyahiFU8n65d6dA2P9GbaJ+Wjus2+b4Dx84ZaShMST9qydgSVucou83hP7O0GecPXwh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=SpVQxjT2; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=EbUQ/opg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=SpVQxjT20DVlJdYcTQF8LKhB1ZH7/WfMmCkjp8PWcYupuDPzQQ5X/tdlXYapw4i8cqdlA8LF5rDGX78o6BGbPlSHHmJlGHk00P/ljwByPpwVMZU/omwjko+IZt67SrIjZiZabZ7EnCpr8Y2TNyHYLluWEdVNCzyVIbz9AbyomqUFSkrGAsppHN5rbJS4rqXeGowI985PW/A3bRhigSLo7U831l49Me75CIFLw580bXAr6vEMkr4gRxVSbiB8JJ2yeP62Pq8MJWzjyg/+fCsUhHii3/3Usl0rTrtq68pBWJOLT9BfZ6Cdwy2l6MR/fDUfC9ftUF8MTBjGHJqQ8L/fFA==; s=purelymail3; d=tinyisr.com; v=1; bh=g+TBXdgYNtzZT3hhbPhG1j65uOqO8FfPYxezOjTu+Js=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=EbUQ/opgnGj5N6IgWTA+zUmA2YUbhsfkYg67pVb9PK+/kEvYwkJs9yTpc/x7AI4ArXVueoswlYppRZTo+6SPMFB8AqOtyYwv870K0AMsXLfJep59BKq1RsOLfdfsO7hnSuGVJEiptI+wPkIf14Wmk8Ayil3e3+Og3I4yiYsOD+C1G1rSnpp4rCP9W9/pnp8gkNRg82nCdwrxPWAaC2sB2M3HK6MCaWMOlEoRycksoyOmSMbShWKjm0wSxC+uBNDFsDWr9Xy0n8c04QsP6xNQwT2a50+oS4EAduf0omw4Mo3GIINqzcd+Bfee7094/hXhuHS2QOC4UFdEhed0WS1xxg==; s=purelymail3; d=purelymail.com; v=1; bh=g+TBXdgYNtzZT3hhbPhG1j65uOqO8FfPYxezOjTu+Js=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2012679011;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 30 Dec 2025 09:13:23 +0000 (UTC)
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
Subject: [PATCH] net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628
Date: Tue, 30 Dec 2025 11:10:41 +0200
Message-ID: <20251230091151.129176-1-joey@tinyisr.com>
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

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
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


