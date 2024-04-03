Return-Path: <netdev+bounces-84519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788E897255
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1401281C62
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96D1494D1;
	Wed,  3 Apr 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sqgD6/KL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61618168BD
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153923; cv=none; b=p+PfeTatvjPR9IS3/tboJNblNPUiZRYGnnDqYlB/chV3Z09dsmTFollfi1Twj2tgZIWQ1XPnHI3G6a+NtByZJ9Txbyv3AkPJzQRKfBKJCYHjOOIUykMbcQgFxvKLCPsknP6vNiN57NdN9JzY4Anm8KPPNLMehCViWJwmhdWdyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153923; c=relaxed/simple;
	bh=uRTsV5q7EJj8yo1j+a2CRxRjWcC0BtZWhmeJqBoo3tk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TZztQL6eRwmgnk+LRwpKt7ug1ItdKSzSpFLwVr05wPqKoFe7riMlReLfDiEKoA9Yx2mPFZjCoAG6kYkHjfAU46+6WzfIDGroia/JegnUCFB4J8DSa+dIRDO3ZfqUD6GzYe0XKC0PeTSHnvRoW1zIlS20mn17TuqAeRDC/IUX2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sqgD6/KL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1EqvgLH3LtJd7n3l3HC9aNXC8dIhQiCt9FmVvNyzftg=; b=sqgD6/KLJEOJXKmcFG6Jby9LvA
	+gE/i9HdwU5C1fbthIOCKdm1HMC//pz42vRhf0nXsmHTehuE4/N4NX5ilY6y1LW6my+oZIigbmOsa
	kxLTCGsb1bO9Y2KGY1aH2GavkgMFcV6tOBc5Vv1f4gnvyEQ/NqlC2OTzKHWVnZdzR+3bVCUD8JrRv
	dLOAwqvSo/MIhsNAwKEVmKAUQg3nhi5RBt+MWNjLjTF0PUnC+Y+DC1nkVpwZeOEbZQDAzE95JjZwj
	5SBCaZQ2dEbNJi755kMZn86r5acXwRoeg8RZEpGe2iI63bkmNo0TWuDPF62MhJCZa5ci86c7I6+A1
	0UZZv60g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54366 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rs1Rj-0008VV-1S;
	Wed, 03 Apr 2024 15:18:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rs1Rj-005g7M-Ul; Wed, 03 Apr 2024 15:18:35 +0100
In-Reply-To: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
References: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 1/3] net: dsa: introduce dsa_phylink_to_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rs1Rj-005g7M-Ul@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Apr 2024 15:18:35 +0100

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


