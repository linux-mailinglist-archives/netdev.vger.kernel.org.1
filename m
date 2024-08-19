Return-Path: <netdev+bounces-119558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40995632D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748301C21580
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF614A4F7;
	Mon, 19 Aug 2024 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FEkcMJNF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AA3EA69;
	Mon, 19 Aug 2024 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045256; cv=none; b=og/O10W0hwrukDp8oGwOUZsr9dCSaWzbhXJIYKbyY/6g4V1LT2ZBdCkOaHLv1EonOfn7Z8C2JET8pQcyPYRed0n4jjbjr3lDvYFMtxmtzLsfIQ4xhaiLk17XHNiaYbCP5ZOL/YBlMBw4l7wUeuwAr8PrXRf6yg8YtY2IhF1zQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045256; c=relaxed/simple;
	bh=/mCGKhdr/KY90pJ810zennttoGmXMQIBX2QHzL7oMqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pwfd8ZVCdZgA+NBMAnrVj3tz3wh+hFWBlS5u3jrpy0RWO2l6GS0IsKttL7zSCtkJujT/8G8m0aW3b5F9pp92w6gHv33TzYxoIBNLa4LIb8D3uy8uJxXMbDLEXM1Ixpr6szUmEx92yetlp4sUsQwU4cy5Y3hE5E3S/s+Dz1/uVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FEkcMJNF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724045253; x=1755581253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/mCGKhdr/KY90pJ810zennttoGmXMQIBX2QHzL7oMqQ=;
  b=FEkcMJNFoT8Q18PoRVQTVKCyHroAdsqyx36stUsw4JZp/m5aRMHXZAkM
   soP/GH33D823b/5xgCbKQ3AqGsVMj46CrAK9ZvNe+CmaHM3jeiNt+Wm71
   bxbG9Ytsbyar6iLAOXen6yH8mVSDC0zBQmREh+P3F3kWTAlEsECd3k/83
   HNCDyj3c0hhV4N2+vhYdZG2aXkPQLK8jBvfv3Ai0TWdaCnun0AAZHeecA
   JE5RgHNKZCSFaET9gaWlnOOT2AcI5lJ1KaESVkcdY156Qf3ckNPVYFWTn
   sKArtox7h6zPwqLuCYfdX6oib0GqaW+8XGMFTuenoMBaNG+U/z38/zwz7
   w==;
X-CSE-ConnectionGUID: VTKYPs/ZQJiauiHw43XcjQ==
X-CSE-MsgGUID: t3Gf+COPQT+k2mUdqY1j7Q==
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="198068541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2024 22:27:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Aug 2024 22:27:11 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 18 Aug 2024 22:27:07 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to configure fixed link state in phylink
Date: Mon, 19 Aug 2024 10:53:35 +0530
Message-ID: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Russell King <linux@armlinux.org.uk>

The function allows for the configuration of a fixed link state for a given
phylink instance. This addition is particularly useful for network devices that
operate with a fixed link configuration, where the link parameters do not change
dynamically. By using `phylink_set_fixed_link()`, drivers can easily set up
the fixed link state during initialization or configuration changes.

Signed-off-by: Russell King <linux@armlinux.org.uk> 
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Note: This code was developed by Mr.Russell King.

 drivers/net/phy/phylink.c | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 51c526d227fa..56dc810b8e00 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1635,6 +1635,48 @@ static int phylink_register_sfp(struct phylink *pl,
 	return ret;
 }
 
+/**
+ * phylink_set_fixed_link() - set the fixed link
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ * @state: a pointer to a struct phylink_link_state.
+ *
+ * This function is used when the link parameters are known and do not change,
+ * making it suitable for certain types of network connections.
+ *
+ * Returns zero on success, or negative error code.
+ */
+int phylink_set_fixed_link(struct phylink *pl,
+			   const struct phylink_link_state *state)
+{
+	const struct phy_setting *s;
+	unsigned long *adv;
+
+	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
+	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
+		return -EINVAL;
+
+	s = phy_lookup_setting(state->speed, state->duplex,
+			       pl->supported, true);
+	if (!s)
+		return -EINVAL;
+
+	adv = pl->link_config.advertising;
+	linkmode_zero(adv);
+	linkmode_set_bit(s->bit, adv);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
+
+	pl->link_config.speed = state->speed;
+	pl->link_config.duplex = state->duplex;
+	pl->link_config.link = 1;
+	pl->link_config.an_complete = 1;
+
+	pl->cfg_link_an_mode = MLO_AN_FIXED;
+	pl->cur_link_an_mode = pl->cfg_link_an_mode;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2381e07429a2..5c01048860c4 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -598,6 +598,8 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
 			       u32 flags);
 void phylink_disconnect_phy(struct phylink *);
+int phylink_set_fixed_link(struct phylink *,
+			   const struct phylink_link_state *);
 
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
-- 
2.34.1


