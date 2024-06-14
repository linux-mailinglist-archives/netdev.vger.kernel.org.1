Return-Path: <netdev+bounces-103543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE828908853
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F67DB2722A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13719CCE9;
	Fri, 14 Jun 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="f4P8Bf2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B419A2B4
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358419; cv=none; b=QsgepiRFR3QFKR86dUXG+k+UKcav2m9zoK5peNfKhVSclBbsGG7EEnHPGf2YbxHCOCQ7jka7Xh1PtK55IsoGCm9MaFkA+8LPTdXroKETu50NJ1LquXy1WPU1wITLBOOX5FucN+V45fVt3OHrn3Ns5OARVjNjiQMsD9KcBCty3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358419; c=relaxed/simple;
	bh=HipulwafQawPC8HDsJGnbcClZPE7pXSZ2nUaNtRyBWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmJrf83KqMEqXX4VBES+3ElHsQr3wayeZOwXc7EySHjd9OBm2sSORrgxUD0dkB/+ehgiM/igz9cR2iU2dl2boy4jtpicbCluI+M8AWXWDggLolSVYOVyBoETQh5mUMgBdbTXkyQIGs7fsVJV7CIwKLrC77ZFijRPHyn0G7l87eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=f4P8Bf2i; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 845C39C58EF;
	Fri, 14 Jun 2024 05:46:53 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4jan7hX7xTQW; Fri, 14 Jun 2024 05:46:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B96559C5625;
	Fri, 14 Jun 2024 05:46:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B96559C5625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718358412; bh=WImuKUjMXvI2FAWArHwhfCK1HwbCQzkhU6VuS4Gr6Bk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=f4P8Bf2itVpp8ZZIluftoBbYt88/PtbVkjhZ72Fqq/0Ocb7QadeFM9LhsXeB2gXCi
	 zRllFqoYKTTknP5fwHGDdZqzNIaUc/Kqt0ksq+njddnaRRpEGJFoSMM1eWRdVOfpXZ
	 Cftb8DxWMbSKI40Og1hd/0LvJaqHoYdUUaY4PvhC7IzY41BiIfHFabstMstDk2f2M/
	 Zn+o08hqGuhOXIMhLnhMDjk1gd4ZuUyPQvM7KWO3xj9cl5fv4QRvCFpTXKy7YVp/t0
	 Dj3n3JrcUUIqcBDM7safi87gUhSn9KgoJT8fW2QL56bjKhYkJRvoCWOOK59nNFRNzn
	 OFENcN1yNdRbA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jD0JN0lQnxse; Fri, 14 Jun 2024 05:46:52 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 79AD09C58C4;
	Fri, 14 Jun 2024 05:46:51 -0400 (EDT)
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
Subject: [PATCH net v6 1/3] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Fri, 14 Jun 2024 09:46:40 +0000
Message-Id: <20240614094642.122464-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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


