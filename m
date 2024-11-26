Return-Path: <netdev+bounces-147366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53D9D9462
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7581B162D9B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C51B415C;
	Tue, 26 Nov 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v8gPgori"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C51BD030
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613107; cv=none; b=Rrk3RAGgnIz2L3VI6Yj+6FFNwmp9mkw26YXIWT3HEdRNwppxpRzyFXuQaHIBdiDRAJjHN2f6vkiEjBNxKXJLPA+UxjIqQ8NnOo4Ph4FssEqQuyO306PVT8kUenS8nFqJWyDCGQ3MowIkW2PSyAUliE4BikdncaV6gltf5y5xW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613107; c=relaxed/simple;
	bh=PhFRfZLUgricAFoxtuGr5dbDnrtD4lYb9WuoDUpvRmg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nFEWIAPNiGuT8rBio9nwoWSOQeOXhySVe6IxmXDF2RynOL4FurKEC7sjdCuGgexBMHZj1YgbvmzTuazQsEfdNXQ6iRekLPpUtgGLjc6H1sBkhounHJO9P9rPT2nw00k/qdkNnaUH+BmDrp0EzA2mCtiuiV3W/zX8ogCvWAlaVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v8gPgori; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2KZ6f++/6LKrIDy4/i3vTw30la5tSDaEUV/ViQihMrc=; b=v8gPgoriwZLQykLvUKiI3BwrsT
	EPE4feuotr/8Ox3K/+H/BMUcSgX3OMODwmj+vaGltv4rLq63lKV+yi6Jl0oCIoYRfwEXVY7c7NW8w
	h0REeUjaSjMFNq7Qmc8z7CBOmjctom++YKuzVHYzpQ4dD03QuFKIzGnaKoeOOtaEvu60OLEWYuVK/
	Ois3DfEEn7LTPL7cxR+p9dP/ZxPTGIiQnNrQJhS6yPe9wWvI8cFY/wePe4cZtsPpafdiWzRR6SELQ
	gSyuitI4CAHxDrsgDEze0n+64VgCgEL2dveL8IpAd13XueJZPGb3s7cvHMNQbB0xlx82pEXc0iRK2
	QQJaxZGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60742 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFroS-0006Tf-1c;
	Tue, 26 Nov 2024 09:24:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFroR-005xQE-Ab; Tue, 26 Nov 2024 09:24:51 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 07/16] net: phy: add phy_config_inband()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFroR-005xQE-Ab@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:51 +0000

Add a method to configure the PHY's in-band mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 31 +++++++++++++++++++++++++++++++
 include/linux/phy.h   |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7b34f8ae415..3e4922839895 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1026,6 +1026,37 @@ unsigned int phy_inband_caps(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(phy_inband_caps);
 
+/**
+ * phy_config_inband - configure the desired PHY in-band mode
+ * @phydev: the phy_device struct
+ * @modes: in-band modes to configure
+ *
+ * Description: disables, enables or enables-with-bypass in-band signalling
+ *   between the PHY and host system.
+ *
+ * Returns: zero on success, or negative errno value.
+ */
+int phy_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	int err;
+
+	if (!!(modes & LINK_INBAND_DISABLE) +
+	    !!(modes & LINK_INBAND_ENABLE) +
+	    !!(modes & LINK_INBAND_BYPASS) != 1)
+		return -EINVAL;
+
+	mutex_lock(&phydev->lock);
+	if (!phydev->drv)
+		err = -EIO;
+	else if (!phydev->drv->config_inband)
+		err = -EOPNOTSUPP;
+	else
+		err = phydev->drv->config_inband(phydev, modes);
+	mutex_unlock(&phydev->lock);
+
+	return err;
+}
+
 /**
  * _phy_start_aneg - start auto-negotiation for this PHY device
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ff60c4785e11..6c1887d1edbf 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -980,6 +980,11 @@ struct phy_driver {
 	unsigned int (*inband_caps)(struct phy_device *phydev,
 				    phy_interface_t interface);
 
+	/**
+	 * @config_inband: configure in-band mode for the PHY
+	 */
+	int (*config_inband)(struct phy_device *phydev, unsigned int modes);
+
 	/**
 	 * @get_rate_matching: Get the supported type of rate matching for a
 	 * particular phy interface. This is used by phy consumers to determine
@@ -1844,6 +1849,7 @@ int phy_start_aneg(struct phy_device *phydev);
 int phy_aneg_done(struct phy_device *phydev);
 unsigned int phy_inband_caps(struct phy_device *phydev,
 			     phy_interface_t interface);
+int phy_config_inband(struct phy_device *phydev, unsigned int modes);
 int phy_speed_down(struct phy_device *phydev, bool sync);
 int phy_speed_up(struct phy_device *phydev);
 bool phy_check_valid(int speed, int duplex, unsigned long *features);
-- 
2.30.2


