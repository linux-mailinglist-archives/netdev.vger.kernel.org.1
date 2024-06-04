Return-Path: <netdev+bounces-100497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCB8FAEAB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7781F21C50
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEA144306;
	Tue,  4 Jun 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="YIDy/ecU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FD143894
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493036; cv=none; b=TjvWBk0rnkD2ZEE3RrMJ1cgCuK7612wFrEpJ9lmgvCRSh6uQV3tzc5eq7PhCTmXfEHpho5P0qZXdVE+0+mzTs98moaycJQdHQDlWNRNkL6o7iqFVjnTNe01kPxiYpUjRJayLazkSfAyJS9I25j5UkJYRCKMjnq5wUKgmuCFZiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493036; c=relaxed/simple;
	bh=JBZB8WAoPO9+QjWKrNbPcT2+WotMbzX56OXz0Fw2MoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QE76+YDugtGw86MY0jGBzlcdDq7YCUDZ0adQrUxwJORyEILWGRxLJal1YSbeoD6cVtXqaJI2JDyQHqclY2KUfN8klAmuMIvcBwazHVgSXzmHrXzc6/sVjD7Qqc2BcyEbj/pkccjuXGN19UEqOO5cJP6ywz+d749XfNc2q65N680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=YIDy/ecU; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7D0019C5898;
	Tue,  4 Jun 2024 05:23:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MQmb354SMFBD; Tue,  4 Jun 2024 05:23:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E416D9C58AE;
	Tue,  4 Jun 2024 05:23:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E416D9C58AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717493028; bh=OZT5wLrOwsL6UTM7/pUAoXCczt//BaKgmePC/FZSQLU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YIDy/ecU1eWn7JCt6aQ1vjiKlRwfAZhwg5pLhW7H8qqoalkFz13GHM0wnwdHmxc6X
	 eBsK+hfmlo/OeaneHrAKDNLcIhH86roOdL93jobyi1aahfttFlB2Zpk+uFH4TwHehT
	 W9usr6aNmG7at4T6e2ZBoRi9MhNmV3RBvoTbtutGMseGMcM0u5ZmXl7EFHdKrgsnCY
	 HCe99lfSAsDXfD1JocyCtfDsjKq7Fw34JcLi8PoSRsOVDK1kSYAZFCPtjkJxVrxo+H
	 p23W9xWUGPRfyfxZDMzAgq4dJzjVIb7HvgPkIu4iFdVGEBb41RvDfP4YTOMG2riHBA
	 DC+Kj90h0rbyw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xjB9eMOVijnR; Tue,  4 Jun 2024 05:23:47 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A40DC9C5898;
	Tue,  4 Jun 2024 05:23:46 -0400 (EDT)
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
Subject: [PATCH net v5 2/4] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Tue,  4 Jun 2024 09:23:03 +0000
Message-Id: <20240604092304.314636-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
index 11e58fc628df..d0ecbb3f7429 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5577,6 +5577,7 @@ static struct mdio_device_id __maybe_unused micrel_=
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


