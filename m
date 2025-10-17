Return-Path: <netdev+bounces-230471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54FBE8825
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946C44E5CAD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EB72D94AF;
	Fri, 17 Oct 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dkIpJJYw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49703332EAE
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702689; cv=none; b=Ui/0CiES5MbJTxE7ExUqaXzCj9pbcXn/utj7f5H1sbATvbTzAdRuOxeUFVFX3JTuBmuSnxiMJRKtXJDT2kjUPDpS56x7mjc79ymuyOiIiHK5d8ZfX5pJoLtMMUlG8D7o8fB2PRBXYlAbXl/YkHPbrBtsiQnHibfNeNSny3yYQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702689; c=relaxed/simple;
	bh=TTG7XjMLfgyvYa2w+55w1qbB11DJIGHu4o5FEMAQmq4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rNxuQziBwqhcpqg/asVNIThy32OiBqAN3tFxZdnW2HgvCp/H9NcAH5PSPfFaoV6MWAz8mPL8xAX5aDP/ItVcsQ7mZwjjEm2mwotv+94TRhlmq9iWdQiIVRdOLVPigQeVxNyE/xYnjMMqxeLlHc8MIM1bqS//Q02RZxqhEjnFWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dkIpJJYw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gl3RH1/grBVvpYgYxo1wR1jFGKFoqkxGDgHmjqc0K1Q=; b=dkIpJJYw0arrj6Gttb6BXMlBnj
	kntmuu++ry799y+xXC+mwWmhlPxgm34m252FsCqFh6SR6/TpneUPdHfwzYHH8HvYgDcSl/73CeBCO
	hTEmgDZLLhLv23GQ+H3NTI0lv3G2tdyv/dYLLOHovI3aUncrO+KcVs9tFwn7JyTm0Vb3QrN24MGH9
	XLcvuHKO5rkeN02K8+N1xQCHttv8Kyqk/R9Fjw4HWCmMWq2YwP4G/10ruVdXfcRawbcnrfBwSBV5Y
	HkM2HtRP5EKH/GZCMChxETvoFUe9Zo+vu3eb3eueg/dp/nvsMwV98GtZGZVKBgUy8X6FvcYTBVFZq
	tCNcN3fQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44984 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v9jCK-000000007pX-0SjI;
	Fri, 17 Oct 2025 13:04:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v9jCJ-0000000B2NQ-0mhG;
	Fri, 17 Oct 2025 13:04:39 +0100
In-Reply-To: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/6] net: phy: add phy_can_wakeup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v9jCJ-0000000B2NQ-0mhG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Oct 2025 13:04:39 +0100

Add phy_can_wakeup() to report whether the PHY driver has marked the
PHY device as being wake-up capable as far as the driver model is
concerned.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phy.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482356..3eeeaec52832 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1379,6 +1379,18 @@ static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode
 	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
+/**
+ * phy_can_wakeup() - indicate whether PHY has driver model wakeup capabilities
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_capable()
+ * setting.
+ */
+static inline bool phy_can_wakeup(struct phy_device *phydev)
+{
+	return device_can_wakeup(&phydev->mdio.dev);
+}
+
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
 
-- 
2.47.3


