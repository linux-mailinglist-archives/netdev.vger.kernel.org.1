Return-Path: <netdev+bounces-91762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5A8B3C6E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA356283A75
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8415217A;
	Fri, 26 Apr 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XgQEc+Nk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007614C5BF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147702; cv=none; b=nxgfnlhu1lu8nFHNe6c3fOf2TvkZfnUMyuEFz3pk2xcvyux7+RRI9IXKtFHXxhZFJJtzh50JYzHh/bHR+vCuB8IgM3RUjSL02ZVKf35bl9ZOnY3o+OigeHnaSu/lYiU6jabF1b5kd91FFSRfYzS7J6WFpRaT2gbAAjntuf665Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147702; c=relaxed/simple;
	bh=rfpF7nrOt8QiJpqdHt23IAMQXqYz090nBVqresZvtKA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G0/vtDwXVunjYvqhHQZF2u8saD6Wd0jI0ea34sX10WxwDN/RVzKvYlDUT2gWDDfwIXzn4he5MU/8oVgf3xn5hMHkuGhbo91Kuc+fG2ztkaWgAENs3xpXcfpQXDHvbTKf/1SniUf5WfrL40XrDQdQnhIdd3kUrn7QOwNZfu9Crgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XgQEc+Nk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yPI11ontvFwlzft6tid3vgR1oO39+Alh5vLsCpQQGRg=; b=XgQEc+NkroCiyiQPwiDK367G/g
	njYQ7ekljx270zyo1cgkCPVoy6CtLF3MoDKaD+z42TpwDWJXRHmDGoBAcWhA1KHspHZKdCMCjPY3h
	MGxitUWzgRrb8hvBuUURST5K+1n14jO+CLqf6yk5nXjqXw9VkS515j0cVxR8bz6XxMDdyhowL+5Xh
	2kjaVbOKZkowY9U5gJVEmTKqB/PhGCS4F06Jfrh82lFYK3fq86gJDBhsFRwyCSbgkOZSszjxQwws9
	qrVYPrq50ixDJCs7T3bqivGdoGNt/SLCU5Fukzd757JiYJMhyZQCgY1O1qKDlHOLjQg3VDV97bP6P
	FZOwWivA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36036 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0O7Q-0000UY-20;
	Fri, 26 Apr 2024 17:08:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0O7R-009gq2-Qm; Fri, 26 Apr 2024 17:08:13 +0100
In-Reply-To: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Florian Fainelli <f.fainelli@gmail.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] net: dsa: ksz_common: use separate
 phylink_mac_ops for ksz8830
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0O7R-009gq2-Qm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:08:13 +0100

Use a separate phylink_mac_ops for the KSZ8830 chip-id.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2ff0cb175daf..2bb8e8f9e49f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -253,6 +253,9 @@ static const struct ksz_drive_strength ksz8830_drive_strengths[] = {
 	{ KSZ8873_DRIVE_STRENGTH_16MA, 16000 },
 };
 
+static void ksz8830_phylink_mac_config(struct phylink_config *config,
+				       unsigned int mode,
+				       const struct phylink_link_state *state);
 static void ksz_phylink_mac_config(struct phylink_config *config,
 				   unsigned int mode,
 				   const struct phylink_link_state *state);
@@ -260,6 +263,12 @@ static void ksz_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface);
 
+static const struct phylink_mac_ops ksz8830_phylink_mac_ops = {
+	.mac_config	= ksz8830_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz8_phylink_mac_link_up,
+};
+
 static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
@@ -1339,7 +1348,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,
 		.num_tx_queues = 4,
 		.ops = &ksz8_dev_ops,
-		.phylink_mac_ops = &ksz8_phylink_mac_ops,
+		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -3104,6 +3113,16 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 	return interface;
 }
 
+static void ksz8830_phylink_mac_config(struct phylink_config *config,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+
+	dev->ports[dp->index].manual_flow = !(state->pause & MLO_PAUSE_AN);
+}
+
 static void ksz_phylink_mac_config(struct phylink_config *config,
 				   unsigned int mode,
 				   const struct phylink_link_state *state)
@@ -3112,11 +3131,6 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
 	struct ksz_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (ksz_is_ksz88x3(dev)) {
-		dev->ports[port].manual_flow = !(state->pause & MLO_PAUSE_AN);
-		return;
-	}
-
 	/* Internal PHYs */
 	if (dev->info->internal_phy[port])
 		return;
-- 
2.30.2


