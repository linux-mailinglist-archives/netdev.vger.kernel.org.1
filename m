Return-Path: <netdev+bounces-99761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC908D6471
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C051F21C5F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F120B34;
	Fri, 31 May 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="c1acFYcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE21C687
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165486; cv=none; b=E+nTWC/avDfsml939UB/XvGLtkZCyECWTJvKRz+7vDyVm0XOqHAHyXepCwaDqiutg2BF0I6rh1cI659jeoI57WXSwUtiEF7epacemrdIm1XRTABrC5GzZVq8Lpq4uRjJ7H8MU8k0lFPvMF+KTKLwwOZwGeU1UctJ5oMs53UFnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165486; c=relaxed/simple;
	bh=4CSp4OvvZBR8EkePW4ABjuf5q/9jqMjLNcEqMkNSSVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLSaWAYumnLlSJY/mLgL8S+ebr3W7yGhzq2GEeQso6WxgHH8l2n4fdxT/h4SNTSbA13lRG+s4NnBNfAsZhT42w0N3gYKVZwtOzCkGroa4q65qDwu6ZmwERYD76UIGvpg1A0scpZF4sk06a+JaFxBSKpX8EgN2zp5E6VItqwLE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=c1acFYcQ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A36D49C59F4;
	Fri, 31 May 2024 10:24:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id w8lZUojev2ft; Fri, 31 May 2024 10:24:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1EDFD9C32FC;
	Fri, 31 May 2024 10:24:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1EDFD9C32FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717165483; bh=+0WGUL++y09ZdFElCyNjG/nTorMgcqWoWBpR2PNNffI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=c1acFYcQKwH7C+Ovt2qtFO6ezatXY0pQgn4KVE7f5pwYGI2gGD1o7ONnO+7/UwB0H
	 L2wbDai3jPBsMyAWFidR+RGsTP7RTXz2psSZMI/kVLwleHoHn+vnhHL1J275qTXr1S
	 jWE46ONi9cN5G3HjOrEcDYYSCY4qGH9YvXgdXSRinf59XlhlAoorBQwtE3vHjJ8EnG
	 xCptNO5oINgQmpoHt0IQ/OJCrpLizG4sUrLGuBIXjkQ+AkSittguFQbqrHViTQhzA1
	 bdVRCUXblcX83zC9w7zjeOP+3yHFLtfJi9Ujjk5FnFCBjuypoVgZph2uEH2ef5Nk4f
	 Z4VJsl5+KSPjw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RGcbFm9d3xcd; Fri, 31 May 2024 10:24:43 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 32AD19C405E;
	Fri, 31 May 2024 10:24:42 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v4 3/5] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Fri, 31 May 2024 14:24:28 +0000
Message-Id: <20240531142430.678198-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
index 2608d6cc7257..f700485793bd 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5529,6 +5529,7 @@ static struct mdio_device_id __maybe_unused micrel_=
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


