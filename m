Return-Path: <netdev+bounces-99356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8418D49B3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C6B1C22B11
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85417C7B2;
	Thu, 30 May 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="v/ggTrPu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE318398B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065099; cv=none; b=lBq1oer/1H67SJFmlW+/+D1Oc0A7R3J5rgdYkG4+zHqi/EMxacMIKLYXYByppReBATfOAQzhACILxGERBOQ9Y94CY4iHY0qHqQiZSyfnNSKeOqtCt5gauHnR3u+3aziLTGXMhrSIPMEFjmXrQQjYIc9Nkcg9GFWAdVpVCDe8WIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065099; c=relaxed/simple;
	bh=lzzefgjDdWw4etASbP9OphGOeeKdJ/U8erhVlzJyjEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQe+2SGZiySVCEWe1NS/NtPWekwIIGecdT0/5bRqcnpFMdMmkYFyOiWeUl9PaFpmB/GGtKow6V9J+D9dtApY4am/pK3c6AQWnqaKk7oNYxK9Mw5847TbdSO/PZugOvbh36ERgyfMV8mAGxqJBH4b/Ps8oIq/kct1v6IYt7Qkxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=v/ggTrPu; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 55D239C5882;
	Thu, 30 May 2024 06:25:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 50yjBMYNa1EG; Thu, 30 May 2024 06:25:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CD7C19C56BD;
	Thu, 30 May 2024 06:25:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CD7C19C56BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064711; bh=EZMrywvIahsm1TnQTRaY8UsYDNJshfm0cOM+dvJRsZ4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=v/ggTrPuEOhrCyZVNRZ91hf8bjEw4pWg6RrYsJFDtu21n6rzI4L5mW6SltsyyuB80
	 FCiNBip/YCHiTYk1EF5sNjaU+XsvxcBe+Q1AWT8tDdgySk6lm/yy8Q3chyupte4DCa
	 kMVNzo+wHz/+/kIrGeMKz1tnPTvkVHNgnLIsCY1hkqNhrE42c4HXoo6J3ajsPcpKS9
	 g3VTYmDjFish6g8asOl/wi7c8CFzY5jNUMux7DVnZb8DUfhsq0EcKgTeyQtaIhXm/s
	 +NRLFbRMXWuBlBLbuRCmAnyHh6QFcm+Yvq4a6I3OjOABZcYRjvXgx/YKmtpb1D3d2x
	 8LU4ite7iHC6g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YhHjEoTZdHym; Thu, 30 May 2024 06:25:11 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DF3BE9C32FC;
	Thu, 30 May 2024 06:25:10 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 4/5] net: dsa: microchip: use collision based back pressure mode
Date: Thu, 30 May 2024 10:24:35 +0000
Message-Id: <20240530102436.226189-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
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

Errata DS80000758 states that carrier sense back pressure mode can cause
link down issues in 100BASE-TX half duplex mode. The datasheet also
recommends to always use the collision based back pressure mode.

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index f8ad7833f5d9..343b9d7538e9 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1299,6 +1299,9 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
=20
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE, false);
+
 	/* Now we can configure default MTU value */
 	ret =3D regmap_update_bits(ksz_regmap_16(dev), REG_SW_MTU__2, REG_SW_MT=
U_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
--=20
2.34.1


