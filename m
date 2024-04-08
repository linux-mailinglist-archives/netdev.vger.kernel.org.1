Return-Path: <netdev+bounces-85709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4B89BE00
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C9AB2191B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E12657BC;
	Mon,  8 Apr 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fDpiNLnj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E8651B3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575167; cv=none; b=opuDVky42Gj4WFMb6G/RqsTo367RpO89i3HGi3KTi2TvlCxGYDNoCQiuAtcDux6OMQmnbA8/N5pQbRpGT47Z9NsQWqyC/vkAbGlRdErWJ7DmWSW153CMX5r0zKR5m2yl8+PiRSoa4PYZ4yVOiVcyzS2vQmYTCXsTbF887/Jrd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575167; c=relaxed/simple;
	bh=uRTsV5q7EJj8yo1j+a2CRxRjWcC0BtZWhmeJqBoo3tk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BH/dSlmT6yygoD/aYPxnPvRzG1Yo1BSu3HqRohy/Si/1CQk4JJiZ7OXrUPJwjdvLC6d8cOaiu0lsFrsd1ymWWD8a0RUZOGa2TIIfmxH/1rjeBHnsJ4fVzvp6oJZmU05yW8mB4As9Ip4zsODlvDoVW829PeuQUC5nQVy+0xBt2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fDpiNLnj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1EqvgLH3LtJd7n3l3HC9aNXC8dIhQiCt9FmVvNyzftg=; b=fDpiNLnjc8/CPDCvSO0cs8up+n
	bNRyreWmA6tAZbc/MQ0qous6/bCfQbOBzto58b9PtWFEGnNezwyGYY3bdBRrd3107C9calxDwFZ0v
	qWdvsU5z855Zh6Bz390pMk0WUP/xm3d33mDOShATt6CQhW8V9h9Mj2W5ByoFd0GYyHOlq3a/2C9FS
	bT/Hw+3e0St8MDqqh04bOLeySt135OluCwXaNhIGH4s11AXMqHLA5R72lBMggpRZAGxAMX33CubOz
	hW++Xh4iEUMuJk2VeNzdZZOGuccNieA5N3amSWXqHUAZqP/roZIapOOFBd0mt2KzvNs31fORefphI
	4C/HH8nw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59262 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rtn1z-00056g-0g;
	Mon, 08 Apr 2024 12:19:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rtn1z-0065ou-Ts; Mon, 08 Apr 2024 12:19:19 +0100
In-Reply-To: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	 netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: dsa: introduce dsa_phylink_to_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rtn1z-0065ou-Ts@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 08 Apr 2024 12:19:19 +0100

We convert from a phylink_config struct to a dsa_port struct in many
places, let's provide a helper for this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h |  6 ++++++
 net/dsa/port.c    | 12 ++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..f228b479a5fd 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -327,6 +327,12 @@ struct dsa_port {
 	};
 };
 
+static inline struct dsa_port *
+dsa_phylink_to_port(struct phylink_config *config)
+{
+	return container_of(config, struct dsa_port, pl_config);
+}
+
 /* TODO: ideally DSA ports would have a single dp->link_dp member,
  * and no dst->rtable nor this struct dsa_link would be needed,
  * but this would require some more complex tree walking,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index c42dac87671b..02bf1c306bdc 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1558,7 +1558,7 @@ static struct phylink_pcs *
 dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 				phy_interface_t interface)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
 	struct dsa_switch *ds = dp->ds;
 
@@ -1572,7 +1572,7 @@ static int dsa_port_phylink_mac_prepare(struct phylink_config *config,
 					unsigned int mode,
 					phy_interface_t interface)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 	int err = 0;
 
@@ -1587,7 +1587,7 @@ static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->phylink_mac_config)
@@ -1600,7 +1600,7 @@ static int dsa_port_phylink_mac_finish(struct phylink_config *config,
 				       unsigned int mode,
 				       phy_interface_t interface)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 	int err = 0;
 
@@ -1615,7 +1615,7 @@ static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 					   unsigned int mode,
 					   phy_interface_t interface)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct phy_device *phydev = NULL;
 	struct dsa_switch *ds = dp->ds;
 
@@ -1638,7 +1638,7 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 					 int speed, int duplex,
 					 bool tx_pause, bool rx_pause)
 {
-	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->phylink_mac_link_up) {
-- 
2.30.2


