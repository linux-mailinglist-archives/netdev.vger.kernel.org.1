Return-Path: <netdev+bounces-106571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58006916DBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D921F25205
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B8170841;
	Tue, 25 Jun 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Kq+jbluL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE215382E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331621; cv=none; b=iNuqjzavkh+9VQajQTs9SjT/HxB40XThFMSPxj2R+o2WEgSCHsyA0BScJ5Xzv4Wn7ruLSvij23wjc9M9MRMSA1eH7LrbvfZ2pCzGpRMo0TE90lN6ziJgLaR0qPTyRyN2Zwvf78elBjEXz9Yx+KkqfgHNKK6Z+e6zBmh4z8rG/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331621; c=relaxed/simple;
	bh=6GzaBJMDsOliriiMLi2upwAx/AQh0bkBiX/dP6PmIPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp/K3IsulMMUxu4ibpWq7V6J4Zt/7Q5iRDTseU2t9pZ4y3v5M5OmCp9j4PnNdTo+yAopPhDpdettDuhX7qJhFexlYJXEU9UlCRbQAVR7Rxu6iPSp/P881IZFoIBMYHE3Vt+0Koq1epTCaif2DjMd5ALYDVFL0Vb3dP1w1/Kb2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Kq+jbluL; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5FC849C5C1C;
	Tue, 25 Jun 2024 12:06:52 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7eMM8_yoF4gf; Tue, 25 Jun 2024 12:06:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CA3C89C59F2;
	Tue, 25 Jun 2024 12:06:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CA3C89C59F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719331611; bh=lqjnZGFiynUWTvexOpISDPPCpdHav5ZGL45gJr+nohg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Kq+jbluLo/FkdbLDXJbqNoNl0ozqByxmd0iNtfEbpIit5FFACfxO5K7ku7m9Xzaz5
	 mVLis+VVtNTe9scoG9Frg3NqzHoBKYBvvRoa2o0uH/5y/NJva4xHwgCoKvp4SmnVwh
	 JNrKmPG5BAOde5soMl9u4gsev3JW/xml9uY0TfkFsF3Ht58CKr+Z88gghjtiNwCqOS
	 8B9moLYomarWHMHOarmArEUIw2BTRQX2cit+UyvDmJsdd/n13ol4D//XMcNJV3Wayv
	 fue5LAEIxFFgj5zuU6uG2T++k2/G3EZ9blXIhmNJuLxFSEOKwjrJPdBR1ppFeVdhaH
	 P7oc6sbKBFJjw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4KBK7w8zJtzj; Tue, 25 Jun 2024 12:06:51 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 94AEF9C5C1C;
	Tue, 25 Jun 2024 12:06:50 -0400 (EDT)
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
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v8 1/3] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Tue, 25 Jun 2024 16:05:18 +0000
Message-Id: <20240625160520.358945-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PHY_ID_KSZ9477 was supported but not added to the device table passed to
MODULE_DEVICE_TABLE.

Fixes: fc3973a1fa09 ("phy: micrel: add Microchip KSZ 9477 Switch PHY supp=
ort")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4:
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-4-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5aada7cf3da7..ebafedde0ab7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5607,6 +5607,7 @@ static struct mdio_device_id __maybe_unused micrel_=
tbl[] =3D {
 	{ PHY_ID_KSZ8081, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8873MLL, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ886X, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9477, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
--=20
2.34.1


