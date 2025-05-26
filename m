Return-Path: <netdev+bounces-193492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46269AC43B9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC88C18990DF
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2C23F41D;
	Mon, 26 May 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csqnXtbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C823F413;
	Mon, 26 May 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284214; cv=none; b=Biy8X5IgOjtOCAs+evmyLlsg4oDpzTP8iIcsHD9/+zG4c6AqOYNQ17eJgpOkwGlPhP++aa9UrQPe1eqKcVo6eG84dThWd7Jd6vjL0//BtzKKk88Hf0P45ZSEVZYTjQyYZZQOOP/9BxNqXAAkslEUjUUUeFY3Ooc5W1YjM9kMuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284214; c=relaxed/simple;
	bh=ocL9xN3l5CZIkJMP4iIsK/bvcDmu7NvmAZRKme5JHYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WityYzORCdFDyDMnUmtz1VmYRzCv9elWBSeqCpECM7RpAhWHCBfkCXhG2VuyXmXBrIrdLIVvAnjukvY0/E/zun+JvprrP3yILlmzyY/LH/iiUOnnP1eBVRrc5j2YeVgi4W0P2GRz12l7k4xBH96uuqQc/kRgTmuXW5Lldba4FsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csqnXtbD; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86a55400913so47269639f.1;
        Mon, 26 May 2025 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748284211; x=1748889011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=csqnXtbD7h1vC5Uvc+/kZF3Ieeo+8bH+doq0OC8LW+t5BaJtcMBDJZAwfvzbUC6kvi
         3MHGSz0nDRT0kSqeKP32mtAsNtqQr5i9EA5ZmBQOg/rV3R4ed8QMIWFfxFuFxzme2q3V
         X2NuW2p0wnm5kebjw3KAOq8ZAUPvmSAFXAMkerMZghsyrbsFy/APx74M4Op0GjHCyPVV
         CyRhZBvO6zIRUYbrEISMftKsgucFcjN34yk4+fdl0OLIYQANTUeaiXXLAKTBWu9lfQut
         WGr6Xfnj9fPAG6BynFdOmZkPhJg60JAdsEnjiafDTXDiYw4t+JfGsMHv/O+FJ7HtC/By
         h1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284211; x=1748889011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=A5mwPp5IwDIFK3OaOxFwm5asM2OIjZ5l9FlG8otdxnrWZauZM/z2KnDcliPF/Si9GF
         9XcnjdckSPbNgFjmMluiMhrui2YZ1OA2A6T3464fmWfO1yx062Pxh0C+ZCt3uY7V+DmD
         +Y9LDO20VNongtDax9yxQQ9Pu4Kpw3/yxVIdldsa9iWcejfSgi2lMZHYLJQqSXwo2p3e
         gXJEdKpXgM3Q4GRbI6c42mOYtlZUiofXKD6mz0li065nIe2rBtzbBrmhV0GTtpxv3R1g
         eqCl/JE9rbH8snxIAngzP4Yao+L4DZz7FCIQaF105C1Bom3dYCPr6Xgwru9YCekYeNW+
         Ojgw==
X-Forwarded-Encrypted: i=1; AJvYcCUZrzVZtjyUC5AECYLGuadJKMrKfwNcE22hR9NmzMPpOYWbmbR3EQM2jpsukN0Bo/BKsefe3TP1QhHTCd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4wKiN3FW+gcAYD28BPogPn9l+XRP7Y3qfU3N3gspgahmVQg2
	VRh2x/stIztwUpjPJk0s309fdjk5WMRyIg54KztBtt36DtrjOY5v/OszQbl1n9YlEv8=
X-Gm-Gg: ASbGncvM+S6xueoupyGqhoHVR3jYtvq4UT0kGVdhJEhL6IO7ScjXezFFv+aVaR8Avpk
	+O9EDoyjg3Lp8sht+5EzSO979PS6IJFBogLMNxUDFKWvweJIq4zRO2Do4zwQpwJ6ZjWMbcKo8L+
	W28RnEGjptR3K5pTSARPC8g95t2DRfrohQj1ym4w4ctV+LS8ZFKYg5VBomfvbK0RAwbXbttLZYX
	IINvivQ1CQP7TBSSw5hAHDUmblH0EQb9e9chjQEcVepapuL5x3ez6H79g+oW6CR3tKr1e7VoULQ
	cFyPHHhHR2eD3UHNzILs2/upyYDZ7dsQBfmISBwYoQkX/ByRgZhABhnN0S8I1NgT3vVb8jaGCLK
	NCz72iRR93VsVsWhUeUS1w24YbKa9cA==
X-Google-Smtp-Source: AGHT+IF1vt1ugwCJCcgD8FLb9pLv6neLoJcOaXY12NIdGkKI+c6RUDeQIjiCz+L7fEf4ThkwNMlUxA==
X-Received: by 2002:a05:6602:474b:b0:864:48ec:c312 with SMTP id ca18e2360f4ac-86cbb7b86c3mr1087224339f.3.1748284211399;
        Mon, 26 May 2025 11:30:11 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235bff69sm477028639f.8.2025.05.26.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 11:30:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] net: stmmac: allow drivers to explicitly select PHY device
Date: Mon, 26 May 2025 12:29:34 -0600
Message-Id: <20250526182939.2593553-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices like the Allwinner H616 need the ability to select a phy
in cases where multiple PHY's may be present in a device tree due to
needing the ability to support multiple SoC variants with runtime
PHY selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59d07d0d3369..949c4a8a1456 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1210,17 +1210,25 @@ static int stmmac_init_phy(struct net_device *dev)
 	 */
 	if (!phy_fwnode || IS_ERR(phy_fwnode)) {
 		int addr = priv->plat->phy_addr;
-		struct phy_device *phydev;
+		struct phy_device *phydev = NULL;
 
-		if (addr < 0) {
-			netdev_err(priv->dev, "no phy found\n");
-			return -ENODEV;
+		if (priv->plat->phy_node) {
+			phy_fwnode = of_fwnode_handle(priv->plat->phy_node);
+			phydev = fwnode_phy_find_device(phy_fwnode);
+			fwnode_handle_put(phy_fwnode);
 		}
 
-		phydev = mdiobus_get_phy(priv->mii, addr);
 		if (!phydev) {
-			netdev_err(priv->dev, "no phy at addr %d\n", addr);
-			return -ENODEV;
+			if (addr < 0) {
+				netdev_err(priv->dev, "no phy found\n");
+				return -ENODEV;
+			}
+
+			phydev = mdiobus_get_phy(priv->mii, addr);
+			if (!phydev) {
+				netdev_err(priv->dev, "no phy at addr %d\n", addr);
+				return -ENODEV;
+			}
 		}
 
 		ret = phylink_connect_phy(priv->phylink, phydev);
-- 
2.34.1


