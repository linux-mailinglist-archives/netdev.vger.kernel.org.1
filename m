Return-Path: <netdev+bounces-105731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C291283C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B9AB2ACEC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88E2868D;
	Fri, 21 Jun 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="xBITzNGU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88942C182
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981022; cv=none; b=WNelVRz9CTOi8m/Cvr7RYp/iq20i28iw2Tpg/Q0mooxZ7by1BO8gPonCI11Wb+9g9erIjPrg6M2sMNKBUIcgzeLBDoGH3Mg267d8gGl9EbEtNK8LumiVbOoQ4zRY//ZARxPgx9GxmtKJKJCv3UmVwUUnJQo4VnmVQlDeJKO8nl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981022; c=relaxed/simple;
	bh=tI5wgxUIR5ttYXBLnZidjpdPzjcs2hMqzD9JXZxFLmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkJuyYkphpc8zbQM0KdXRPS36ULevhaj1yWXgoxi4t9sYOu3qfo6dVRdEBVQW+IkZOxZoYv3sHAMA3xDh3LrzEFMVyu73NKySh1MAhFIyX9q4NduPxXepejtdTGC1Vw96CM+OJLCbLMVuoo4hm3bwKWi3dcGvzw0x6BCI+NctG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=xBITzNGU; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C83B49C5BDC;
	Fri, 21 Jun 2024 10:43:33 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id v5bejfXunULG; Fri, 21 Jun 2024 10:43:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 13EF59C5A85;
	Fri, 21 Jun 2024 10:43:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 13EF59C5A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718981013; bh=v87H5fOt9tHSV3TRoD4XrpJJEo/VOf6RrMnyDae28Js=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=xBITzNGUWQftLOUsA6bnWu05W0l3W88jmOpW8GGZ3PrFpYOgGqLH2LFemOnCwfsYO
	 v66JIDjBVEiU7ok9mlgpCwEkJu/LhIoyPP6aLMcbCnMLuStdBQi0STAErgP/Ywf0+i
	 Fv3xVL43alhpf0d7azUey6oR6tCZx/Y+roqphT4d9VYAs+szcYcAj1SLdod3X1KnzM
	 qT51ppdJWeBAso94CPijjN+CxXBT8Ggm2v9NdcM26OVhtFjJGd11UU2Xsc6HdbhmZs
	 1roUuCBibyWKjknjqbm8R+5jpbBtfle69E1Uec5AZAPe2jlVVlrB5/30AhcaJwRizs
	 MXjWTAFV+M1Yg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4D7-rMr5FRwO; Fri, 21 Jun 2024 10:43:33 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A01339C5B21;
	Fri, 21 Jun 2024 10:43:31 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Woojung Huh <Woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net v7 2/3] net: dsa: microchip: use collision based back pressure mode
Date: Fri, 21 Jun 2024 16:43:21 +0200
Message-Id: <20240621144322.545908-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Errata DS80000758 states that carrier sense back pressure mode can cause
link down issues in 100BASE-TX half duplex mode. The datasheet also
recommends to always use the collision based back pressure mode.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Reviewed-by: Woojung Huh <Woojung.huh@microchip.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5:
 - define SW_BACK_PRESSURE_COLLISION
v4: https://lore.kernel.org/all/20240531142430.678198-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c     | 4 ++++
 drivers/net/dsa/microchip/ksz9477_reg.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index f8ad7833f5d9..c2878dd0ad7e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1299,6 +1299,10 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
=20
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE,
+		SW_BACK_PRESSURE_COLLISION);
+
 	/* Now we can configure default MTU value */
 	ret =3D regmap_update_bits(ksz_regmap_16(dev), REG_SW_MTU__2, REG_SW_MT=
U_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index f3a205ee483f..fb124be8edd3 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -247,6 +247,7 @@
 #define REG_SW_MAC_CTRL_1		0x0331
=20
 #define SW_BACK_PRESSURE		BIT(5)
+#define SW_BACK_PRESSURE_COLLISION	0
 #define FAIR_FLOW_CTRL			BIT(4)
 #define NO_EXC_COLLISION_DROP		BIT(3)
 #define SW_JUMBO_PACKET			BIT(2)
--=20
2.34.1


