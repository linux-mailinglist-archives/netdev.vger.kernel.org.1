Return-Path: <netdev+bounces-98665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326078D1FB3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C13286022
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0C171650;
	Tue, 28 May 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W+YVM2pU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38665171651
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908719; cv=none; b=iTCIFyzz/3xLj3DutduO5tVLwS+H1iN/SxtkcNLPwfZlbANyrL9F46NUFQnxp1u+RCeghLgxI3GkMewtp66AJK4DOH9TJVLfnAWRyqOSalD4oqfmF7G0EbLBd+CIlmQdultLJRubFeA9HRfSK4HImQIx4aOplfRJ1u1NU7Cll5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908719; c=relaxed/simple;
	bh=rrvzaCNpnUc24V96oK0ruPeUCXkpl34H+MHyqDuznGs=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tL9dNQm66KRpltkbuP4tMnc8qZqQCdVyYEJluQ19YK8PWd6Wo1VaxVHGWey6fiMvOsqP9VCzdliR4b0xPxLgpGOIrJrUt3WL8UV/WfDouDkfqU6DJdhn4UTndPNxDD4yoxcFh2fQ8+/rv532dqzg2aPHRMzVQlOqg5OjSDERmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W+YVM2pU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qD2hqp2JKv2fyeaY8uiDGq/6e9JNbxkKmprRsjlobJ4=; b=W+YVM2pUoKqujr8M/gQ6FqFquO
	hNnENUEyPNHNHRFUFpra8r7MlnrowEYJXQ8SU9A12K/WLFhrjdLmROPgOkDqPPw8ZSsvP6T9T2WXS
	wxCHa+eo7r7pDa0Bprj5i+/pMYyG2rlRppj0niKXJGqI8r2zygnEjQgN548F3NAhJcK9K5g9s7eqb
	tLq6pkj5Gu3EWhqjfLEpImlCkDfEREO36FN3+lmVMa0ZR45ZU9F63Jyu91wa6okX+M9VyIg7Nr387
	VycUgSNsPOAtuHbJ+LBxgdRZCGFDo7cX8Cw5Kb90ufNh4wos060I419wflCTeKoS+AFqf9kp7Mj9n
	d/8d/nuw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40590 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sByNv-0004yW-0u;
	Tue, 28 May 2024 16:05:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sByNx-00ELW1-Vp; Tue, 28 May 2024 16:05:10 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: remove mac_prepare()/mac_finish() shims
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sByNx-00ELW1-Vp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 16:05:09 +0100

No DSA driver makes use of the mac_prepare()/mac_finish() shimmed
operations anymore, so we can remove these.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h |  6 ------
 net/dsa/dsa.c     |  2 --
 net/dsa/port.c    | 32 --------------------------------
 3 files changed, 40 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index b60e7e410aba..f9ae3ca66b6f 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -882,15 +882,9 @@ struct dsa_switch_ops {
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct dsa_switch *ds,
 						      int port,
 						      phy_interface_t iface);
-	int	(*phylink_mac_prepare)(struct dsa_switch *ds, int port,
-				       unsigned int mode,
-				       phy_interface_t interface);
 	void	(*phylink_mac_config)(struct dsa_switch *ds, int port,
 				      unsigned int mode,
 				      const struct phylink_link_state *state);
-	int	(*phylink_mac_finish)(struct dsa_switch *ds, int port,
-				      unsigned int mode,
-				      phy_interface_t interface);
 	void	(*phylink_mac_link_down)(struct dsa_switch *ds, int port,
 					 unsigned int mode,
 					 phy_interface_t interface);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 12521a7d4048..668c729946ea 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1507,9 +1507,7 @@ static int dsa_switch_probe(struct dsa_switch *ds)
 
 	if (ds->phylink_mac_ops) {
 		if (ds->ops->phylink_mac_select_pcs ||
-		    ds->ops->phylink_mac_prepare ||
 		    ds->ops->phylink_mac_config ||
-		    ds->ops->phylink_mac_finish ||
 		    ds->ops->phylink_mac_link_down ||
 		    ds->ops->phylink_mac_link_up)
 			return -EINVAL;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 9a249d4ac3a5..e23db9507546 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1549,21 +1549,6 @@ dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 	return pcs;
 }
 
-static int dsa_port_phylink_mac_prepare(struct phylink_config *config,
-					unsigned int mode,
-					phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-	int err = 0;
-
-	if (ds->ops->phylink_mac_prepare)
-		err = ds->ops->phylink_mac_prepare(ds, dp->index, mode,
-						   interface);
-
-	return err;
-}
-
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
@@ -1577,21 +1562,6 @@ static void dsa_port_phylink_mac_config(struct phylink_config *config,
 	ds->ops->phylink_mac_config(ds, dp->index, mode, state);
 }
 
-static int dsa_port_phylink_mac_finish(struct phylink_config *config,
-				       unsigned int mode,
-				       phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-	int err = 0;
-
-	if (ds->ops->phylink_mac_finish)
-		err = ds->ops->phylink_mac_finish(ds, dp->index, mode,
-						  interface);
-
-	return err;
-}
-
 static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 					   unsigned int mode,
 					   phy_interface_t interface)
@@ -1624,9 +1594,7 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 
 static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
 	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
-	.mac_prepare = dsa_port_phylink_mac_prepare,
 	.mac_config = dsa_port_phylink_mac_config,
-	.mac_finish = dsa_port_phylink_mac_finish,
 	.mac_link_down = dsa_port_phylink_mac_link_down,
 	.mac_link_up = dsa_port_phylink_mac_link_up,
 };
-- 
2.30.2


