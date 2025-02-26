Return-Path: <netdev+bounces-169876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4984A462DA
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F51617750A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA9221DB3;
	Wed, 26 Feb 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="gDfvb9tv"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CA221D9F;
	Wed, 26 Feb 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580156; cv=none; b=pSGsyzc7Fp+PWRIh6U29KcJ8VSrcFkiEsrMwwQuAMSPGQoiIwEOn6rpa23OkUisnet4voRe2clWWs2Fi7yevCwySLqZ3ZKnMzFQkhcX8QuLliPecewUgwcIE3KNlgF9Eyp0OQcBnbJ3Z19j8pf0PX840rsFFLhPFRs4wUB1Fuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580156; c=relaxed/simple;
	bh=hsH3z8+Fe83MSGygibT8r+xbnfbuooikdd5M6Z1Gi8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2Xik0VcpkAjLe3tN+CmHI/W/gTAh2IpbaAfdk7HRVIyPxYe9BbzhCrOo/MNcuAmW/GRYgpQIbDz/eecosxdmohpxqtvf3RAerhTLXtin44EGYVKJp3Q+DTSU2qdtTSsA0jMvxpOZ3nhQKrhFd3WLynLDuMrtm3+D1gueVPLACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=gDfvb9tv; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=916645903c=ms@dev.tdt.de>)
	id 1tnI71-00EzaC-8y; Wed, 26 Feb 2025 15:10:11 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1tnI70-00Bwwr-59; Wed, 26 Feb 2025 15:10:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1740579009;
	bh=Z7M5M5uuzltxq1/nZr/jD9f7D60n9T0rSoTt1WRqIZU=;
	h=From:To:Cc:Subject:Date:From;
	b=gDfvb9tvmb8UDr0r2OK5vwRUB4MArzo4Y+E1AM/wAAlNDC8I/c+5BY+9Tr1QvWfSw
	 i/6wGrJYCJz50zwCTd0vx2FZqtNqznVOdlGr1w1jGwl4E2acgpCRVZHkIYFoW4Uz4Y
	 YwiyZp6T+4UtkFeJZh3H9VxnTSHu8NeiHQ0NcK9ELL3Xv2uuGXY3Q0mK4NrFaKiKCO
	 R0sYB4fc/DQjZkt+RPiS0Y6/afAuAg/VfRr/Krn2gBtKGBdf+IYJNGv/qN44URJFns
	 x29KNpPi5zi1WVwA8mRxPap97VWre6zV0iAmpt4bb+2+oXo8WO9VeDdBnOfbKkYRO4
	 DGUBGjh0bzKsA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id AA1A9240041;
	Wed, 26 Feb 2025 15:10:09 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A21EF240036;
	Wed, 26 Feb 2025 15:10:09 +0100 (CET)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 1DCDA238A3;
	Wed, 26 Feb 2025 15:10:09 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module
Date: Wed, 26 Feb 2025 15:10:02 +0100
Message-ID: <20250226141002.1214000-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1740579010-AFFAF3DC-1E7331F6/0/0

Add quirk for a copper SFP that identifies itself as "FS" "SFP-10GM-T".
It uses RollBall protocol to talk to the PHY and needs 4 sec wait before
probing the PHY.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/phy/sfp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9369f5297769..15284be4c38c 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
=20
-	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
-	// needs 4 sec wait before probing the PHY.
+	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
+	// to the PHY and needs 4 sec wait before probing the PHY.
 	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_fs_2_5gt),
=20
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.=
2GBd
 	// NRZ in their EEPROM
--=20
2.39.5


