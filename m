Return-Path: <netdev+bounces-51949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B900E7FCCA4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B7E1C21067
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6B3D7A;
	Wed, 29 Nov 2023 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNLN+iBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA71998;
	Tue, 28 Nov 2023 18:12:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b5155e154so3764995e9.3;
        Tue, 28 Nov 2023 18:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223950; x=1701828750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5ay5oC9DZAwFCrHcch3zWMGDOFcuL6xfvWXGq+yQ4o=;
        b=PNLN+iBx/BxFlMzskCMpuMoh6q4v1hAUuQRgTjxfPnTUZnMYoPoIW0YCjXJaPprExm
         MiT6LnxixIYVouQ8aBY4uYVEgJglk2xJYTZAnBcSphA4DXTYRj8Fo07vkSLxecP7Fo6Z
         vAm4LViIVSYhlLv7DJacOucQ27XWeVWHyYmSLLAe/3YNLru7eU8Qf5WW4z0VsQse/FEH
         w81F+pXSyOb6agQ487bnPfmzXFTlXZ6K4dmkU5ccGJlRXer5icdBLlf/JkqTW/HquJpf
         l0NrGZpkPcLCFXuXaTByY7xUy7ljBvnl4di20HLqEly8+YmwJk1WGfGWlELMZrg4ehYC
         QFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223950; x=1701828750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5ay5oC9DZAwFCrHcch3zWMGDOFcuL6xfvWXGq+yQ4o=;
        b=LAygyRjfWfx3QFxDl6FZMRNWGxl+wDnPgChtB3VsJ80BxdfEGjrkD6UcFLCqQAhicZ
         im/0hxngJhFkL31G4WLvMZkePysHGU2U5sW3Ffy9xReL3kBAac4yYFupAedEPyQpr/UT
         9PTn8d0nzjWQ1CiiddsooDefAEdfq0SNbZUBSpB6dH6ls/WHvbG08ojhhUMUgMOuk7/y
         ZG3p3GWRZvssGuc/HRAMAz0h/Ap+mKYO/4sqlgm7BV2gmsO/Uh+3oVgKQpHsxQOcz3g1
         wfisle1gNrnOc/t2qOWjWv2+WMvde5Fin5feKjc5H2Sn2fCvZT3Rui8xzlQqSsd67HWP
         c9vA==
X-Gm-Message-State: AOJu0YzBXC+wJw0JluAMfUQlXRZVRDLZUQxECM+u6nhi/BxI1C9tapBx
	M1gl5EhWovvmeE3KXLI48Tg=
X-Google-Smtp-Source: AGHT+IFUojHgQUsnsLe3vcXsotDSfLmGvlr7zdjTYQllQfvz+i/Ic9aCuGNqsvCvPnhEADYiSugLDQ==
X-Received: by 2002:a05:600c:4f82:b0:40b:2b42:a1c9 with SMTP id n2-20020a05600c4f8200b0040b2b42a1c9mr11767158wmq.23.1701223949645;
        Tue, 28 Nov 2023 18:12:29 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 01/14] net: phy: at803x: fix passing the wrong reference for config_intr
Date: Wed, 29 Nov 2023 03:12:06 +0100
Message-Id: <20231129021219.20914-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix passing the wrong reference for config_initr on passing the function
pointer, drop the wrong & from at803x_config_intr in the PHY struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..ef203b0807e5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2104,7 +2104,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2134,7 +2134,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2150,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
-- 
2.40.1


