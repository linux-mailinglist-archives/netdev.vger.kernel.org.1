Return-Path: <netdev+bounces-148572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80819E231C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C467282AD6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764951F76AC;
	Tue,  3 Dec 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sbDTkIiX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E2646
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239885; cv=none; b=p5lF+jpMpQN4dLPfpJqen9CrxPdcgmi6CoHpBMQ1g3Q+WWJFUvkyV+4XywCQ6CviFu/WH1dZy5iJy11u2OMlde3U1yU0+mPDjYevim2KVSiIqvCSvps5YIMteHPr/biNCLmmtHCtCs8Hrp1O5edm2tA0o7engBBmHq73CJ+Xgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239885; c=relaxed/simple;
	bh=HJweVvY2IhHB9kxOfCGnXfRYHZQ1Zqkms35PWQI6RUA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nzCxkt/UTQejoPIltMmJALuRNdEK1kmhK4TeHJvZQ0LO5opvZOo3mQMTlJ/pCsf6+qEIvOwQGgVDA/Bh7xuzwIrTCxSxoHfQ0hY+oQt+BUmyoLYhgdgDb0K5zblqBmhthpgd1oRRtFO1Xdrk98Pj6lTrpPi9rmrJCeIXqoj9bEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sbDTkIiX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DQs9awcvxtg+eCXqRSOWO22FQ8DMKVImRZu2eJiSHGE=; b=sbDTkIiX0n/afpUGROfh9gSNbA
	FfSapJbSNowGX5vhS0OC+4qxUqSy7/4FVqmAHsgXa4BC8uPvN4TPP5/4jXvyN93/O5YGw9Zb5HXZg
	yqirHVmoczUXybyyLNVASATqNHSu6Zo7UEMVkGbTMlYVBQpzmReoaQiplv2OsLd/c/xgAylvWcjwH
	7AEcthTxnZod247nzgJ9rPU+JyOQace+QlepK6VD5ncMm+yUS7kKspImD/916hfPlzSUv+UoGR76Q
	3D4p+Db1TXQsiv70Ng+E3TRjBfC7ghuvnI33q+ycMn1PjnPjLSD9JeLCD+9RHF/eYwrgxB8D0ER+5
	Fc2zJj1g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrv-00028h-0d;
	Tue, 03 Dec 2024 15:31:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUru-006IUI-08; Tue, 03 Dec 2024 15:31:18 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 07/13] net: phy: add phy_config_inband()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUru-006IUI-08@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:18 +0000

Add a method to configure the PHY's in-band mode.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/phy.h   |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index f42cd6584841..0c228aa18019 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1026,6 +1026,38 @@ unsigned int phy_inband_caps(struct phy_device *phydev,
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
+EXPORT_SYMBOL(phy_config_inband);
+
 /**
  * _phy_start_aneg - start auto-negotiation for this PHY device
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ccb93d892da9..61a1bc81f597 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -982,6 +982,11 @@ struct phy_driver {
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
@@ -1846,6 +1851,7 @@ int phy_start_aneg(struct phy_device *phydev);
 int phy_aneg_done(struct phy_device *phydev);
 unsigned int phy_inband_caps(struct phy_device *phydev,
 			     phy_interface_t interface);
+int phy_config_inband(struct phy_device *phydev, unsigned int modes);
 int phy_speed_down(struct phy_device *phydev, bool sync);
 int phy_speed_up(struct phy_device *phydev);
 bool phy_check_valid(int speed, int duplex, unsigned long *features);
-- 
2.30.2


