Return-Path: <netdev+bounces-99357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD38D49B4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310D51C226CC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B5176AD8;
	Thu, 30 May 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="UcLBeg4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB1176AC7
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065099; cv=none; b=FsN1g70a/hrKUPG1VkY6T2PmbQpEoBF3XhYxHAOU8CG7izsIYKhMU+mfgEgOO/knGTE1N7b4sM7UvXZbLHZenlwqcMFIq/5waLpWO0VBQ/i2+LnF+s/kd1Ln2ZbvsDYcrLBCSGh7F4cJNYmooygh9Sq9jPSrPpxMu0MNMkLf/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065099; c=relaxed/simple;
	bh=GFA91Mr3rynjqsgM4fHjz0cSVPUVhfgs+tM8NqaFOhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RR9arj4KJ7pjEAJqMUCmx6OkhmxEqVNOa9UxAarhHFAqJUw5IKT/g7cudfkmf0ecueyQOW9TyrDkuXtABvyMwV7g7qaSsbVMQ5eIPLNrrjiqtHIKTefy7vLvIbl+SCKesIcCxB3wVRK+cC+mC1SUfYiCmfrdWq9QvtTrK7vxlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=UcLBeg4E; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 532F09C5A17;
	Thu, 30 May 2024 06:25:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id fhSMu1Vn-zR9; Thu, 30 May 2024 06:25:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB5A19C53C1;
	Thu, 30 May 2024 06:25:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AB5A19C53C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064709; bh=0FUsDMqKI4DbapXjdymOIRvqnPI51tJuF/s9XLEpmEk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=UcLBeg4ECFTsCwnzpZP/Y2fdwRfOp98N/DXu+8g/spAkWaRJ4bzwTjqdAGCSO331v
	 MYp962GMwKrlKFs7qaGR5hDfctEfuaY+ArndBvAwDd1Mlw9D4sNe+zmTL4y7IaXgPu
	 /yAlSvDZTO5T6tkVPvOCMJm5beyQ41lqtEJPvNeoz43tLOHFWoiQ5ORfRarloQXrl2
	 IUOF2YQ7Eo5ss2DEOsVWmdFHsjkcCDdlczIBcpBEN2jKO61by2Gey60cSroreg/zqe
	 MrSMkyrfXz3crZfYx6JlJ9e6WMJE3ncbhQfVNBKmzz0dUatyVw3eqj2Jjuj2CtuGUA
	 rrEsOoPd3qMKQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ry9hHGqKBgVH; Thu, 30 May 2024 06:25:09 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BF0D29C32FC;
	Thu, 30 May 2024 06:25:08 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 2/5] net: phy: micrel: disable suspend/resume callbacks following errata
Date: Thu, 30 May 2024 10:24:33 +0000
Message-Id: <20240530102436.226189-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
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

Microchip's erratas state that powering down a PHY may cause errors
on the adjacent PHYs due to the power supply noise. The suggested
workaround is to avoid toggling the powerdown bit dynamically while
traffic may be present.

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/phy/micrel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 99322a3c3869..78f2040c3cd1 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5514,8 +5514,9 @@ static struct phy_driver ksphy_driver[] =3D {
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
 	.name		=3D "Microchip KSZ9897 Switch",
@@ -5524,8 +5525,9 @@ static struct phy_driver ksphy_driver[] =3D {
 	.config_aneg	=3D ksz8873mll_config_aneg,
 	.read_status	=3D ksz8873mll_read_status,
 	.match_phy_device =3D ksz9897_match_phy_device,
-	.suspend	=3D genphy_suspend,
-	.resume		=3D genphy_resume,
+	/* No suspend/resume callbacks because of errata DS00002330D:
+	 * Toggling PHY Powerdown can cause errors or link failures in adjacent=
 PHYs
+	 */
 } };
=20
 module_phy_driver(ksphy_driver);
--=20
2.34.1


