Return-Path: <netdev+bounces-94348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51F8BF3D7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8091F2132E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F4399;
	Wed,  8 May 2024 00:51:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC579CC;
	Wed,  8 May 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129518; cv=none; b=ZggUn+vszKgUBXREuOanhuMk/BVBpB24pK1gIFqVzdFl2gWklzKxclYSArFB5gX39+9dFrsySVjdIpopiX1jzSNSQaBOaM+ykSl0c95WV2zNwYq0jTaj9hZ3lsuorNH71wYuvkFzAOKinZWPqZEBsOboO3ewJLa+7/MqVPyc1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129518; c=relaxed/simple;
	bh=bDx4HxaCRI3tx13XsK0SdihIQe6rQ1h74yQ6qmRAqzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CzkYK2C9O2Zf6UIRTAWq8c+gYooAK5kHRrSt/F+iJ49xNSHgPbtb5Ze1uKPY9xA+cmWQ6EoapZk2fGQztdPyDY5TKbvr3y3oMNFL7ZUdcKJkHWXMdqmo3QV/hsZEqqvAC9stqxa23lpwZVpgUtb+wjZZHz0vdZ9wZ++6Wf7zZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s4VX9-000000007ms-0HBx;
	Wed, 08 May 2024 00:51:47 +0000
Date: Wed, 8 May 2024 01:51:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	SkyLake Huang <skylake.huang@mediatek.com>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Crispin <john@phrozen.org>
Subject: [PATCH net] net: phy: air_en8811h: reset netdev rules when LED is
 set manually
Message-ID: <9be9a00adfac8118b6d685e71696f83187308c66.1715125851.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Setting LED_OFF via the brightness_set should deactivate hw control,
so make sure netdev trigger rules also get cleared in that case.
This matches the behaviour when using the 'netdev' trigger without
any hardware offloading and fixes unwanted memory of the default
netdev trigger rules when another trigger (or no trigger) had been
selected meanwhile.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
This is basically a stop-gap measure until unified LED handling has
been implemented accross all MediaTek and Airoha PHYs.
See also
https://patchwork.kernel.org/project/netdevbpf/patch/20240425023325.15586-3-SkyLake.Huang@mediatek.com/

 drivers/net/phy/air_en8811h.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 4c9a1c9c805e..3cdc8c6b30b6 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -544,6 +544,10 @@ static int air_hw_led_on_set(struct phy_device *phydev, u8 index, bool on)
 
 	changed |= (priv->led[index].rules != 0);
 
+	/* clear netdev trigger rules in case LED_OFF has been set */
+	if (!on)
+		priv->led[index].rules = 0;
+
 	if (changed)
 		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
 				      AIR_PHY_LED_ON(index),
-- 
2.45.0


