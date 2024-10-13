Return-Path: <netdev+bounces-134934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865299B98B
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C87281C29
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65B140E30;
	Sun, 13 Oct 2024 13:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A11EEE9;
	Sun, 13 Oct 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825437; cv=none; b=Ej0YPwbB7hjQ45iEVY250GRdA0iyTANZ56nBx86Ow1x5hE8sViI7VCtLS3qznbPAnguIEyugURfsyZy3Dw+DAqyVhKZuLSpyqzO7rlGHZJBtn9hL1CN2/8BNINrVnXN8Hpgf65FB6/PpcbGzr9Ef1OQ2wuylq/442bWGOKC5H7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825437; c=relaxed/simple;
	bh=S6BMa3OG9RtXfmc7mHcEPThNpZqWISnb3ySKVPCpNAc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D6P5R8j6fk1vDq7lBCb35mfx3Yt4Jm9sHIV9b7q+RQ+LqfRkD2LXNWHmxGZrsbckoDPRoOE+B1wym/kB1+6F5IKYFG5hCuSq5ABahNtHS1VrfTJmLlA0Kul/R1I3/Lkju5801aWA1nmpDsVMCVcB3R8c+XLVj66QjXUWoRHO/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1szySq-000000006nx-0rR8;
	Sun, 13 Oct 2024 13:16:52 +0000
Date: Sun, 13 Oct 2024 14:16:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jon Hunter <jonathanh@nvidia.com>, Hans-Frieder Vogt <hfdevel@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
Message-ID: <f8282e2fc6a5ac91fe91491edc7f1ca8f4a65a0d.1728825323.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

of_property_read_u32() returns -EINVAL in case the property cannot be
found rather than -ENOENT. Fix the check to not abort probing in case
of the property being missing, and also in case CONFIG_OF is not set
which will result in -ENOSYS.

Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pairs")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com/
Suggested-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/aquantia/aquantia_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 4fe757cd7dc7..7d27f080a343 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -513,7 +513,7 @@ static int aqr107_config_mdi(struct phy_device *phydev)
 	ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
 
 	/* Do nothing in case property "marvell,mdi-cfg-order" is not present */
-	if (ret == -ENOENT)
+	if (ret == -EINVAL || ret == -ENOSYS)
 		return 0;
 
 	if (ret)
-- 
2.47.0


