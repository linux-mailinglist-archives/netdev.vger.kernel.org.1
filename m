Return-Path: <netdev+bounces-86723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA678A00C4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36FF1F22C17
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2E181311;
	Wed, 10 Apr 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TiHq8PnG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C228FD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778165; cv=none; b=aegLNx6cXFkzki3pKMsHCveslK5z4g+UO/F0YRBIeQCU0L+2xlTNsWs/KnIQDPsRxFSG1PR8YWgynwtHWtw7i5Lr4BHWJWE4ZM7/o0hpLYU4N0ToXBKfEFBIcv8PHoP05Bu8NnJ1SP/QJ2QRzpwksaUuO2jWOLzm5eo9BbOd2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778165; c=relaxed/simple;
	bh=DwqzMnRNG8TfMc7+NGUBlkRhXdk9BgJVh8ILghDlmhE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SD1wX2h6AAMBDLEncqQxxxuwafJ5LnoqHOcq9SNb76qlGzbcP53SmsFwZlEA/trxU5LBX28mD8bmErygNBB/kMWOcc7Sv1wdb7VLxnhSGmp5Cid4SpgSi45LE4KddWOjmDjhQgQllX9AuRzxAyW1/a/WSDdfl/WP9w3SV6cVkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TiHq8PnG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WcmDVYvCUbB72NGHShsHq4HahEne8hPGk4sqL9dmQJ0=; b=TiHq8PnGVpKuGGOdaphCvXBNVF
	ImIE8AXurRHlD70N++kq5GcecW6e+lGkitW4V+fFRmdTXzsjOIwOGtM8yoKatBvFPRr7IwfPp/j8x
	vrdZ9fCWnlQwIN1qc4uir86i6e2UwVFwaw5pFO/Ln37XgogCSjAI/927fVXGdgkNqeWqukNJww0uM
	B/HmtWeO3cJqZUIKx1KPmbMI6NjfG3CGv1zwDrEgmvDs7yasrL5zNfnayut5v+meOQWm0OSA9keub
	0pczb4lKm49Udmlbvup/Hb+RfZVnqc3smt+w7kEsuA3YWTyTLoKpx1jZQGZt4K2mK1yUkKc0y50Q9
	KQwnhjTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59194 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rudq9-0008TT-1T;
	Wed, 10 Apr 2024 20:42:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rudqA-006K9B-85; Wed, 10 Apr 2024 20:42:38 +0100
In-Reply-To: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	 netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/3] net: dsa: introduce dsa_phylink_to_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rudqA-006K9B-85@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 10 Apr 2024 20:42:38 +0100

We convert from a phylink_config struct to a dsa_port struct in many
places, let's provide a helper for this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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


