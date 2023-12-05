Return-Path: <netdev+bounces-53870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109080505D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920881C20DB6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F454BD5;
	Tue,  5 Dec 2023 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyx5ED2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34D184;
	Tue,  5 Dec 2023 02:36:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so38299201fa.3;
        Tue, 05 Dec 2023 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772571; x=1702377371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFMu8yHYAxfVLVvDj+B8IqaslSN1vZ5XWG3YsW0hTQA=;
        b=Jyx5ED2YCd8AL6MXgUhxkf3x9ABAwoWOU1V8F5SFGpWp8xYQA51Ui5n4Cr7jYMBWw3
         tGKg6hNUFjN4+Mi0EJwbyOc+k1UI3esOIOEsIY9GYe+zDl1vxRZl/KtXJCrvIpunNStw
         Yi2f5DboGNblOlH75Zy/CF2pjfjD1i9Lzvtqp5aiLqIvUeFaZ+1mUmNYKw7VB37Htydy
         eWjFRoxdO755hWM7Nqw/eF+lN10DdDe2iK+XO+LiTMaxALZnBDyd9O4VRN41MbD3anyP
         1lpczkCuBC5Qosn9c5rAg8qMYrPxp5Xemp/yVPVMSGwb8WNwrFbnaNkUtEAaOxQ8zTnm
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772571; x=1702377371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFMu8yHYAxfVLVvDj+B8IqaslSN1vZ5XWG3YsW0hTQA=;
        b=GGCcbRoVzqApJumzZEIPO/dfOdHyOAGYeVR5y7CqG6vtpPVnwZLbGVcFMl+wyCmziK
         EyHo3kyHmjLf744Yq30DGKaBmXeNGybMnC+SLBUhERvNsQz2YqTYWwiYsKjs7Wvreepo
         hnCR675yIM7DXCRmgdVpij6Uid4OdcmWgd82FoVVVLSz5DylwSGe51ROIoDZSVWu8XN5
         VP1WoNh5bjQQbSpu0qh8MBz+RtKiWaEPgXU3qtpU8A0e5cu+Wj/7T2qtfuQBN21CYI7Q
         Dge+SPu076lPLaF6K7n958Nv6QMMctq3vqctZM0OA0G1eZQrPADgrXsaTES0DDt049cI
         +b4w==
X-Gm-Message-State: AOJu0YwZ58E1W6uNfmBOYLu0Y+yCqIAB7bca/qfUH5TepL117jTwUkjI
	5HRQezyp7PAYeQSy1z++ycU=
X-Google-Smtp-Source: AGHT+IH0HyLEqm5MstBhJhll+ilWNbLcAbUlRzT66sgkeFhmYOZXWSY29xW02fWBkRMGmVcZxYa/xQ==
X-Received: by 2002:a2e:994c:0:b0:2c9:f3b6:522 with SMTP id r12-20020a2e994c000000b002c9f3b60522mr2596361ljj.57.1701772571048;
        Tue, 05 Dec 2023 02:36:11 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l21-20020a2e3e15000000b002ca0689190fsm548139lja.31.2023.12.05.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:10 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/16] net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
Date: Tue,  5 Dec 2023 13:35:26 +0300
Message-ID: <20231205103559.9605-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic MDIO-device driver will support setting a custom device ID for the
particular MDIO-device. Generic DW XPCS ID can be used for that as well
just in case if the DW XPCS-device was erroneously synthesized with no or
some undefined ID. In addition to that having all supported DW XPCS device
IDs defined in a sinle place will improve the code maintainability and
readability.

Note while at it rename the macros to be shorter and looking alike to the
already defined NXP XPCS ID macro.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 8 ++++----
 drivers/net/pcs/pcs-xpcs.h   | 3 ---
 include/linux/pcs/pcs-xpcs.h | 2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 46afeb5510c0..2850122f354a 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1343,16 +1343,16 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 
 static const struct xpcs_id xpcs_id_list[] = {
 	{
-		.id = SYNOPSYS_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.id = DW_XPCS_ID,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = synopsys_xpcs_compat,
 	}, {
 		.id = NXP_SJA1105_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1105_xpcs_compat,
 	}, {
 		.id = NXP_SJA1110_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1110_xpcs_compat,
 	},
 };
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 96c36b32ca99..369e9196f45a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -6,9 +6,6 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
-#define SYNOPSYS_XPCS_ID		0x7996ced0
-#define SYNOPSYS_XPCS_MASK		0xffffffff
-
 /* Vendor regs access */
 #define DW_VENDOR			BIT(15)
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index da3a6c30f6d2..8dfe90295f12 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -12,6 +12,8 @@
 
 #define NXP_SJA1105_XPCS_ID		0x00000010
 #define NXP_SJA1110_XPCS_ID		0x00000020
+#define DW_XPCS_ID			0x7996ced0
+#define DW_XPCS_ID_MASK			0xffffffff
 
 /* AN mode */
 #define DW_AN_C73			1
-- 
2.42.1


