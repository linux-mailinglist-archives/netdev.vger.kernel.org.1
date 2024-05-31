Return-Path: <netdev+bounces-99760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E148D6470
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A971C209A4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE041CF90;
	Fri, 31 May 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="xb9qkkuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F81BF40
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165486; cv=none; b=DcdiGPe+C6fcsBmItUnGQV492lpXih3TFhJzwoTotGzswAR7Ohr3eCyvBD5snAMvtT7ZHHVbnaoIa5dCl2nXzzYSd8hzzb0ND2P9kvAXtVQY4MgY0EFdOJ7arjA46wWHwQaopY6DOQfLrwgqcEie9M5CKu/PP8LJh8eZgADEQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165486; c=relaxed/simple;
	bh=3GCpDhULczbPiUCJtF27T1bqkcED8cluiRZ0Q72BTng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A3nfWf7tsuVHl18pBQJhVUJ+vexGa3mphYoSY0lsCImoLHi6ayfAml4f7GFT607iTH8h88V0DZRdEwXRsbNy9xA5j/EGz7dhwusp/X0essyzFeaGOh5hd4gn8t7dWpF2a48iPBwFUap1vcMO+hcV8jFbgWoqKgOTJffsrADt9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=xb9qkkuf; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B94EB9C58F5;
	Fri, 31 May 2024 10:24:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id T07ojGVVkwdW; Fri, 31 May 2024 10:24:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 16B689C32FC;
	Fri, 31 May 2024 10:24:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 16B689C32FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717165482; bh=Z7k2RaPV2b/xiu+bo3AWdjel+DLcBS01fw7SBTNCuHM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=xb9qkkufxsIYciLPez4+YQumRlJD2aIFDe5G+dQQJFV/jBi+rWSlYVF29RALIIEhZ
	 JlQyLFo1ipgh+NDk8B3LoxjLHQwOdnNgdWlCyU4ZJ/3z7BJZsbbYMeGlVq+uWuqjix
	 rowNAqk1I3fZHwneXF0bFc30PsbVwFheN6lbBAelg1pw5DKBQBcImkNofPRs5zY57O
	 n14s6I96p8QcTWIhW8iKjUYU4GaeFFkFZdb5MUcWxDhjfpFQXLcftRW2FzzkRZhSsH
	 YU1lTyqQrGV3ACbHOPj8tRc+97twYsrygD5+d2S7N85gUegJB/A2T4J3GBG3JvrXZI
	 s6N0BhMXu9Ykg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4xUeHZGwb-1P; Fri, 31 May 2024 10:24:42 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 286859C5899;
	Fri, 31 May 2024 10:24:41 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v4 2/5] net: phy: micrel: disable suspend/resume callbacks following errata
Date: Fri, 31 May 2024 14:24:27 +0000
Message-Id: <20240531142430.678198-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
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

Microchip's erratas state that powering down a PHY may cause errors
on the adjacent PHYs due to the power supply noise. The suggested
workaround is to avoid toggling the powerdown bit dynamically while
traffic may be present.

Fixes: fc3973a1fa09 ("phy: micrel: add Microchip KSZ 9477 Switch PHY supp=
ort")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
v4:
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-3-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/phy/micrel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 8a6dfaceeab3..2608d6cc7257 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5492,8 +5492,9 @@ static struct phy_driver ksphy_driver[] =3D {
 	.config_init	=3D ksz9477_config_init,
 	.config_intr	=3D kszphy_config_intr,
 	.handle_interrupt =3D kszphy_handle_interrupt,
-	.suspend	=3D genphy_suspend,
-	.resume		=3D genphy_resume,
+	/* No suspend/resume callbacks because of errata DS80000758:
+	 * Toggling PHY Powerdown can cause errors or link failures in adjacent=
 PHYs
+	 */
 	.get_features	=3D ksz9477_get_features,
 }, {
 	.phy_id		=3D PHY_ID_KSZ9897,
--=20
2.34.1


