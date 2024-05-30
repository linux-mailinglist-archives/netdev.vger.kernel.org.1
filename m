Return-Path: <netdev+bounces-99355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF488D49B1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B276E1F23E22
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609F176ADD;
	Thu, 30 May 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Fr3vU/aj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6B176AA1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065098; cv=none; b=DpJJDbUOXNHdo57GFdzZ3fQPb2flFUoQq02EJsv19Wsy0ec4EJ6dP3rW6d7wK1Bbgrx89x2HWM8F7FVqkKPXuU2PrWECTpblKh8pndgTRmLzYAl++vd8U/mtpkwYoG64s169uqbIRLTgiNRIR0s75Q008uMAvnBphSJK+XxiHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065098; c=relaxed/simple;
	bh=63f+O1opezTLfsJXw5dCgIt/b+Nl3TJNtrddmzzT4ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReiYWZtTW/pBpvH4pZC/YU687J4aik90daOGWvvDRIGUVa+5dGa+tQAc9jif8/Eyb/gxjwQ1x769qUeJnmLwj1vLj5gwSwpN8+MEqCh3JLzmD0bFI0sQY97xLoZXtluqlkJ+0UZhKKK1paY3Q3mwe0smLWiEdn5kbpAPS91v+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Fr3vU/aj; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3C8DD9C5A29;
	Thu, 30 May 2024 06:25:11 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id fxuGAiE4UcPP; Thu, 30 May 2024 06:25:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C0B8F9C53C1;
	Thu, 30 May 2024 06:25:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C0B8F9C53C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064710; bh=SC1lrSWdAcyOqTblFjk1GR2AXzdOlyFvvtUN/tnZ2CE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Fr3vU/ajV2aiR5QXZLPamwL2OEUy0+OgqYb5DNOehGUPpryYEmwvEkRaNxWFouTWy
	 I7Giu+okoPntWbKMkwyhg+qvOuXP716o9qWGe8Gz/qnl8DN20gl9T0jvOHoH+BoYP6
	 aEf5juor5M647z6syOB/hZYkENid41rBRFXkciUYrPI1BJv0SlROT2kFtDyhwVNezi
	 zgJJQnKI178B8qQeHUixbO0CvY4+CI4OHJsgNL0mPoER9O1KzL64bdL0Lv95AC7M0O
	 u8VTGSVZB+TiUKMXclv00uTnBkxLveHARFKoRVqMqu9MAD1MHGPLMnI1ymvcu6opT+
	 +iraUyc4CItiw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fGvPwIdHArBH; Thu, 30 May 2024 06:25:10 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CA9349C32FC;
	Thu, 30 May 2024 06:25:09 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 3/5] net: phy: micrel: add Microchip KSZ 9477 to the device table
Date: Thu, 30 May 2024 10:24:34 +0000
Message-Id: <20240530102436.226189-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
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

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 78f2040c3cd1..5930ac9fa661 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5550,6 +5550,7 @@ static struct mdio_device_id __maybe_unused micrel_=
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


