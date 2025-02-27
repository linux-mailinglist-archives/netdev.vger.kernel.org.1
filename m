Return-Path: <netdev+bounces-170121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B3A4765A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAED1885103
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137A22068A;
	Thu, 27 Feb 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="ugt0BVBa"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2D21B9E6;
	Thu, 27 Feb 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640317; cv=none; b=cevd42X75bklnulEFe0aN8/OvBqL8CfK2vWNtTn0/JM1Y0eQOaKKB0lKIbiLp1Pb++zU+HuKhhWJZSF2W7v5kJoLJndBlyZ7rOiJjqb9b00Qnut4v0iZJjmi6/SCF3gqTpEjr8ODPSaNa6BAb5jrL6I9/Tc3Kaj/qjpbpTmzDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640317; c=relaxed/simple;
	bh=RMgSMxHOSJpyTv8+p9TD5fmUREoxf2nKbV5VhyM0CCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coO7WHULCTIWbIy0OtyZCcMUVjnjjGcxVZeP3/UxFjTkEg6QWfk2dCxDovK9PSjyPb6761KC6xkmFgKusBqJMbjFjBrnRpvrT0OTICWLOmxJKK3W07LuqBn/ZTFAoyXMM/CUpyT28HEfEyQV7SNAudgb4ogRB48IQt1T2Qg/gms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=ugt0BVBa; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=0167d23c47=ms@dev.tdt.de>)
	id 1tnY3d-006JKd-9i; Thu, 27 Feb 2025 08:11:45 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1tnY3c-001arq-2S; Thu, 27 Feb 2025 08:11:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1740640303;
	bh=/UOlT6cf/orwBQKNwfGwMjKYAnFFzn0QigJYizxtK/0=;
	h=From:To:Cc:Subject:Date:From;
	b=ugt0BVBaOeFz3y9+NvvvaRAK/OkHxmg6sOHSp21T26HTQ9Utjk7mAvyfNVPIh+mwA
	 ueEiSLJDz4pZRjchD1lh7EaGpOhTL1n89xqr/3nxmnAOLYFRmdliSkcNnCcJKeGRVe
	 jVsXb+Yu1Ipdk4wFCf8zZAZe9Xv54FxJoGjbP9IKmykU6T6+m4ERqtwBh/9lX0nkaF
	 t0R2QavIWmMztbIKr7eza+G+TLfhB8PGarsW3i75jltbItUZux+gM+Sgh35JH0B1dW
	 O4sa49VNiFZAjncwj5cVWfns3fcQkg9J8lI94OLcTse/e6xznrKpyeiPRvjnEkgxzS
	 Ch9KYHnEfqsbQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 8DD7C240041;
	Thu, 27 Feb 2025 08:11:43 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 86CA4240036;
	Thu, 27 Feb 2025 08:11:43 +0100 (CET)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 2EF08238EA;
	Thu, 27 Feb 2025 08:11:43 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v2] net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module
Date: Thu, 27 Feb 2025 08:10:58 +0100
Message-ID: <20250227071058.1520027-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1740640304-EDF1D23C-285358FE/0/0

Add quirk for a copper SFP that identifies itself as "FS" "SFP-10GM-T".
It uses RollBall protocol to talk to the PHY and needs 4 sec wait before
probing the PHY.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---

=3D=3D=3D Changelog =3D=3D=3D
From v1:
* rename sfp_fixup_fs_2_5gt to sfp_fixup_rollball_wait4s

---
 drivers/net/phy/sfp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9369f5297769..c88217af44a1 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,7 +385,7 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry =3D msecs_to_jiffies(1000);
 }
=20
-static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
+static void sfp_fixup_rollball_wait4s(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
=20
@@ -399,7 +399,7 @@ static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
-	sfp_fixup_fs_2_5gt(sfp);
+	sfp_fixup_rollball_wait4s(sfp);
 }
=20
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
@@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
=20
-	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
-	// needs 4 sec wait before probing the PHY.
-	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
+	// to the PHY and needs 4 sec wait before probing the PHY.
+	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_rollball_wait4s),
+	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_rollball_wait4s),
=20
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.=
2GBd
 	// NRZ in their EEPROM
--=20
2.39.5


