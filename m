Return-Path: <netdev+bounces-166652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EEA36C50
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 07:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DD63B2222
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13B1624FE;
	Sat, 15 Feb 2025 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="hmpAlHPh"
X-Original-To: netdev@vger.kernel.org
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [80.237.132.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6B623
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739600995; cv=none; b=hlQEXKV2ENadCpoVgx4KPoknw+uUzRC47K3KP4HUvWKnpT4rHua129btOLLj8+wPX6EDA0NVeXTBkHl3ACdb6/BmrOuOBOvY6OM2IBmLzxQp05w28XJhk7F5TWHwOHMeuQ39v++v5x+p2tsTVmd7fgMzIa8cchwz7q44sBVky4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739600995; c=relaxed/simple;
	bh=sJBNkEjzKUaWqxdX+4sZCeuQ/JUD3ox6Y18TbzEEt9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mLIYid0njLSDkUCGDKUvT9J8ZR3GeRiiDsKPOzPzBPlS9Zc56wVWZDJB/2N1VzdB7PUJ4+smpr2iE9SRFl39npyDb88SPLtydRHwMlw2eSQwAsqyyGicPDmtneZkBk8qo5TiBt/jKI/vobGE81k6MMUSZndWoMPruyXUzNtZiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=hmpAlHPh; arc=none smtp.client-ip=80.237.132.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=birger-koblitz.de; s=he134867; h=Cc:To:Message-Id:Content-Transfer-Encoding
	:Content-Type:MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=76YxnghdWiJ3guDKU0QmXTCQgZm0lERENJX6P9Q7Cag=; t=1739600993; x=1740032993; 
	b=hmpAlHPhxTQDMDQEkZ6h4aMjbSdvYV0DcCNmUl+lNvTbcz68CFkk/TElAU/0Z8GzRJfIlIkASW5
	KXdbp+BQB5VSug8IA/Su0KWwYxBDDrIi2mAh3s9U46dk5nHV/YUIp/R0QxL9xiMNVJblaqqgM+yc/
	qrmM4PdakYqP5hnrpjKlBT1MUY/CP5YfeYFcPcLEoDx3dIV+pZigjRP05nTYL2Ri0xt7qmPCqUSni
	UJ3U3Pi0CG5SI/Mhu/cwXSr+GS3oHbqD87BB0t/GWk3lWdXtBKulrIxcFPNHax+EdLAZXBm6gBA5J
	0J5TWAS9t55bZEw/j5hyuePEnjI1eD8NTK/A==;
Received: from [2a00:6020:47a3:e800:b302:277d:cae8:fbde] (helo=AMDDesktop.lan); authenticated
	by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tjBgO-00EL1P-2H;
	Sat, 15 Feb 2025 07:29:44 +0100
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 15 Feb 2025 07:29:44 +0100
Subject: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-lkmsub-v1-1-1ffd6ae97229@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAFc0sGcC/x3MQQqAIBBA0avErBNMErKrRIvMqYbKwrEQorsnL
 R98/gOMgZChLR4IeBPT4TOqsoBxGfyMglw2KKm0VJUW27rzZYUzRrvG4lRLCTk+A06U/lEHHqP
 wmCL07/sBwimyK2IAAAA=
X-Change-ID: 20250215-lkmsub-d995d8bef400
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.14.2
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1739600993;cbca1cc7;
X-HE-SMSGID: 1tjBgO-00EL1P-2H

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee26a221e9c47a6f030c8a18317bdbb..9369f5297769493efcab0ed4c356245baa1aa248 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),

---
base-commit: 9946eaf552b194bb352c2945b54ff98c8193b3f1
change-id: 20250215-lkmsub-d995d8bef400

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


