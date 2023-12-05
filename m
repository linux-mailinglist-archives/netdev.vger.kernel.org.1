Return-Path: <netdev+bounces-54149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10EE806181
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA881F21600
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBA6E2A6;
	Tue,  5 Dec 2023 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="FsTGX/Yu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5E1A5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:14:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50be4f03b06so4039746e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701814469; x=1702419269; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3oeJWhEo0I8xr5szo2lUVK5AtQmSHRVB0z9pc75LX4=;
        b=FsTGX/YusM7Jk4O92Ga5LqjyucfY2urobkR/IhgPFmt8yRmpXtzJZHl5SmuvbxWf05
         kFQO2ECoO/RAhIUEFtEGfZ46hx2TY8S5VshVfOQQzSqQ1RJ7gqwJGqAanwZ96yQZhLXm
         iVT5IgPcN1JpA4W+ZGNQy6lCR43C0taRYdxW/XWBcGH8yglwLvLIIz0+gq+LW2zh0EAu
         ca55oeh+F+kqockBmNcheLnf6la4FVWsxw0W0UJY4UYuCVpDY7FJktqI0wFQkhJi3/TV
         MU2ZXNxPqR/V4VX4IdYidJy7am7l9AYv5LFk5V6tzAWld49lNfILlbJdE7Xgqy+Q2P1z
         4vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814469; x=1702419269;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3oeJWhEo0I8xr5szo2lUVK5AtQmSHRVB0z9pc75LX4=;
        b=ZcG32Ek3BXRQ3a8lcUrwYZX6BGEKUn6m1yy+F1r/iMhXYotRZ6IXSmoBTvNFmxCT4X
         60glLkpyBccCdMIZK9OndVyG0HyC/0zRNH4reiLEUbq+LcSE+zghhY9Z7bmIRVqcPIf+
         IRCLN/Bm/b3C5WoE86uDMrX6yxZmEJsxlMKQMNkDkw+v6rHTq2VEg3uq1l6Brp/3iVkJ
         OoZs2M5i5UTHo/jV9gMQ9dnjJ6+JAy06ZWunxjsgLfwLnA+4E646TRvCpqUasXPrCKhT
         53vUr/aVioB9oF5R+DyUNGvZLW7iiVmeCCxJaCo3CJxXFEBIsSBfPdsWT7DIF5amNTqv
         q88g==
X-Gm-Message-State: AOJu0YyR5XkSRYQVDv64wh2u7aP3wMMO83jJH014s4BNTH2yiWVM3a+l
	qQj8Ew5D5obCKYv+8bx81eQiWA==
X-Google-Smtp-Source: AGHT+IHw14+r/osJGdT4h216v+yu9gCzZezTu2fRIk3NC01b+wquQG7tGf4EbE++3ci0Lm24Mtu0EA==
X-Received: by 2002:ac2:4578:0:b0:50b:e054:33c4 with SMTP id k24-20020ac24578000000b0050be05433c4mr2076738lfm.24.1701814469187;
        Tue, 05 Dec 2023 14:14:29 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id m25-20020a195219000000b0050bfed7b882sm453515lfb.218.2023.12.05.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:14:28 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	linux@armlinux.org.uk,
	michal.smulski@ooma.com,
	netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for 6393X
Date: Tue,  5 Dec 2023 23:13:59 +0100
Message-Id: <20231205221359.3926018-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In 4a56212774ac, USXGMII support was added for 6393X, but this was
lost in the PCS conversion (the blamed commit), most likely because
these efforts where more or less done in parallel.

Restore this feature by porting Michal's patch to fit the new
implementation.

Fixes: e5b732a275f5 ("net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 31 ++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index 9a8429f5d09c..d758a6c1b226 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -465,6 +465,7 @@ mv88e639x_pcs_select(struct mv88e6xxx_chip *chip, int port,
 	case PHY_INTERFACE_MODE_10GBASER:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_RXAUI:
+	case PHY_INTERFACE_MODE_USXGMII:
 		return &mpcs->xg_pcs;
 
 	default:
@@ -873,7 +874,8 @@ static int mv88e6393x_xg_pcs_post_config(struct phylink_pcs *pcs,
 	struct mv88e639x_pcs *mpcs = xg_pcs_to_mv88e639x_pcs(pcs);
 	int err;
 
-	if (interface == PHY_INTERFACE_MODE_10GBASER) {
+	if (interface == PHY_INTERFACE_MODE_10GBASER ||
+	    interface == PHY_INTERFACE_MODE_USXGMII) {
 		err = mv88e6393x_erratum_5_2(mpcs);
 		if (err)
 			return err;
@@ -886,12 +888,37 @@ static int mv88e6393x_xg_pcs_post_config(struct phylink_pcs *pcs,
 	return mv88e639x_xg_pcs_enable(mpcs);
 }
 
+static void mv88e6393x_xg_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct mv88e639x_pcs *mpcs = xg_pcs_to_mv88e639x_pcs(pcs);
+	u16 status, lp_status;
+	int err;
+
+	if (state->interface != PHY_INTERFACE_MODE_USXGMII)
+		return mv88e639x_xg_pcs_get_state(pcs, state);
+
+	state->link = false;
+
+	err = mv88e639x_read(mpcs, MV88E6390_USXGMII_PHY_STATUS, &status);
+	err = err ? : mv88e639x_read(mpcs, MV88E6390_USXGMII_LP_STATUS, &lp_status);
+	if (err) {
+		dev_err(mpcs->mdio.dev.parent,
+			"can't read USXGMII status: %pe\n", ERR_PTR(err));
+		return;
+	}
+
+	state->link = !!(status & MDIO_USXGMII_LINK);
+	state->an_complete = state->link;
+	phylink_decode_usxgmii_word(state, lp_status);
+}
+
 static const struct phylink_pcs_ops mv88e6393x_xg_pcs_ops = {
 	.pcs_enable = mv88e6393x_xg_pcs_enable,
 	.pcs_disable = mv88e6393x_xg_pcs_disable,
 	.pcs_pre_config = mv88e6393x_xg_pcs_pre_config,
 	.pcs_post_config = mv88e6393x_xg_pcs_post_config,
-	.pcs_get_state = mv88e639x_xg_pcs_get_state,
+	.pcs_get_state = mv88e6393x_xg_pcs_get_state,
 	.pcs_config = mv88e639x_xg_pcs_config,
 };
 
-- 
2.34.1


