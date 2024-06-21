Return-Path: <netdev+bounces-105730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B591283B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0151C25AC7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9722BD05;
	Fri, 21 Jun 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="TmAJpmKq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92612868D
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981020; cv=none; b=PpMOo2fBGO56owK9boH/Z/+ihtXIPQRY909Z1JWPqWArT73HcImIA9klg8UCyhGm6bCR5fKRcbYroyn1jQjWI2fejVdfFLDx6OKGGj4yu1VASHS0J6Na+027D10GX+qgFapu+OBXcr6hYdb3UDyeOeLdulleqQ7JGIoqZzc4PLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981020; c=relaxed/simple;
	bh=6GzaBJMDsOliriiMLi2upwAx/AQh0bkBiX/dP6PmIPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/A1oaKJxTVYWx9Es99dDNmpRxMfoPyreBbiSl+BFaKKZE87pWbLcgs8vwh8EdTqfy7Yq8c/Gu8Fu0/h0CzDRADlZNy3jOLMSuGzmp6y7xtieyMk4RPwBjIIIRM6MdUiItZXOC4jejnFKSCg7KmJFAHIl04MJw9xupQUYBvF+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=TmAJpmKq; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 181B59C5A87;
	Fri, 21 Jun 2024 10:43:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TbW4NrAI99a7; Fri, 21 Jun 2024 10:43:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 83D5F9C5A85;
	Fri, 21 Jun 2024 10:43:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 83D5F9C5A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718981011; bh=lqjnZGFiynUWTvexOpISDPPCpdHav5ZGL45gJr+nohg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=TmAJpmKqPXR1itcJcqBap07SgJ9tcCY10UehMm1xqXPuMBYSDmImAAcwQwWBUhN4S
	 IICmsatAN5G2RpK07tY+CF9d0ZYDRsIkCr3SE0TNQ6RnEqUjKyHUgstjnSEEixHQtk
	 FwQR6BO9DM04WLqAruFDJrw21R4nCfGmUqGxO1nRWJfe2+Om9jxVvCbInJTopnTz6P
	 /l3vsFKQKR/xf2ejUsmZnufO8tHzkFu5xYYh70FfULlzagI1/YAa+zetzxzlNxOQT7
	 DpThn4Tedz9H0XyZz1T3S3qYB34zUKO074NcYivzHdQTzIk8iX7v/i6yn8FX3SCRaW
	 PWTwuMffQiC1A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Rwo4IPQ_MBd0; Fri, 21 Jun 2024 10:43:31 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4D1149C5B17;
	Fri, 21 Jun 2024 10:43:30 -0400 (EDT)
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
Subject: [PATCH net v7 1/3] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Fri, 21 Jun 2024 16:43:20 +0200
Message-Id: <20240621144322.545908-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
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


