Return-Path: <netdev+bounces-86724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4858A00C5
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9491F21CA0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421C18133B;
	Wed, 10 Apr 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W7TdjrpR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD228FD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778170; cv=none; b=SfX37kwagz6cjJ+CQSMfIPBUQiLc48EDOxVb/XYAMP5CcQucsWhh+bS4qL82NCzFAXG882EJvowxd9/pWsYkoVd0rtvp6EPSEKncBAh3WqMfKAvoeWglH8KDe+UCHPqm4PCTg5WTo2VCVUJZgvA4B1V8nlJgkp3KZHcStY3sRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778170; c=relaxed/simple;
	bh=FsaaTv6p9Ur61CCp0GEpfTjLHvmpaWP4bI3HcVEs1zc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mIdS6aTT6IeuQKT2VklfaK2mjGaOyAeRfYRs3fM/Bw9j9EfpR0QB/MdBhtMuxkiUZLLm1PxnjeZqTCloYJdDXLkspgTfoak1bcNAnzKaCUL4v2IvoDl5cwoqG/VIwwqAtAkQ8+PBNNAeAvc8V1C41HICjH2+OMRmAcRJRf2mUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W7TdjrpR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4zOpz9i5Ph98Ip0KTemOqJ7dMmgel876YzM10FPX+4U=; b=W7TdjrpRRqKHSCAqwpMLgPf9rx
	6XhiipGPDzLdUl2Gw9ZcIY0e+BemJquAlJyiw3tmVMklO0EhNRHutUtOhbS4kL9IhFcQJ7wlYwGay
	nfkkt+Tv1taATR/52GnmrvAfM+BYZG8gRhdCYalBoaSZMzaR77KKJ5kcveSzRlc1E0e62a8hYir0n
	n9ehZMOALLjyTlyxVxTBhIRi39YxJwmYL82Uz4VJX0Ap0MVahCVK4VmUTWXfidjc7EYOjLZztmBVX
	KMLrdpisravKcDSmGaBistwnLboR25CYlpXaam+5O+J/uf84OPaNfyuWCZNeMYD6unrFCwuHn2rfs
	LxZpW6xg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34804 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rudqE-0008Tf-1s;
	Wed, 10 Apr 2024 20:42:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rudqF-006K9H-Cc; Wed, 10 Apr 2024 20:42:43 +0100
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
Subject: [PATCH net-next v2 2/3] net: dsa: allow DSA switch drivers to provide
 their own phylink mac ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rudqF-006K9H-Cc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 10 Apr 2024 20:42:43 +0100

Rather than having a shim for each and every phylink MAC operation,
allow DSA switch drivers to provide their own ops structure. When a
DSA driver provides the phylink MAC operations, the shimmed ops must
not be provided, so fail an attempt to register a switch with both
the phylink_mac_ops in struct dsa_switch and the phylink_mac_*
operations populated in dsa_switch_ops populated.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h |  5 +++++
 net/dsa/dsa.c     | 11 +++++++++++
 net/dsa/port.c    | 26 ++++++++++++++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index f228b479a5fd..7edfd8de8882 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -457,6 +457,11 @@ struct dsa_switch {
 	 */
 	const struct dsa_switch_ops	*ops;
 
+	/*
+	 * Allow a DSA switch driver to override the phylink MAC ops
+	 */
+	const struct phylink_mac_ops	*phylink_mac_ops;
+
 	/*
 	 * User mii_bus and devices for the individual ports.
 	 */
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 09d2f5d4b3dd..2f347cd37316 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1505,6 +1505,17 @@ static int dsa_switch_probe(struct dsa_switch *ds)
 	if (!ds->num_ports)
 		return -EINVAL;
 
+	if (ds->phylink_mac_ops) {
+		if (ds->ops->phylink_mac_select_pcs ||
+		    ds->ops->phylink_mac_prepare ||
+		    ds->ops->phylink_mac_config ||
+		    ds->ops->phylink_mac_finish ||
+		    ds->ops->phylink_mac_link_down ||
+		    ds->ops->phylink_mac_link_up ||
+		    ds->ops->adjust_link)
+			return -EINVAL;
+	}
+
 	if (np) {
 		err = dsa_switch_parse_of(ds, np);
 		if (err)
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 02bf1c306bdc..c6febc3d96d9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1662,6 +1662,7 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
 
 int dsa_port_phylink_create(struct dsa_port *dp)
 {
+	const struct phylink_mac_ops *mac_ops;
 	struct dsa_switch *ds = dp->ds;
 	phy_interface_t mode;
 	struct phylink *pl;
@@ -1685,8 +1686,12 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 		}
 	}
 
-	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
-			    mode, &dsa_port_phylink_mac_ops);
+	mac_ops = &dsa_port_phylink_mac_ops;
+	if (ds->phylink_mac_ops)
+		mac_ops = ds->phylink_mac_ops;
+
+	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
+			    mac_ops);
 	if (IS_ERR(pl)) {
 		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
 		return PTR_ERR(pl);
@@ -1952,12 +1957,23 @@ static void dsa_shared_port_validate_of(struct dsa_port *dp,
 		dn, dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
 }
 
+static void dsa_shared_port_link_down(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down)
+		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
+						   PHY_INTERFACE_MODE_NA);
+	else if (ds->ops->phylink_mac_link_down)
+		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
+					       PHY_INTERFACE_MODE_NA);
+}
+
 int dsa_shared_port_link_register_of(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
 	bool missing_link_description;
 	bool missing_phy_mode;
-	int port = dp->index;
 
 	dsa_shared_port_validate_of(dp, &missing_phy_mode,
 				    &missing_link_description);
@@ -1973,9 +1989,7 @@ int dsa_shared_port_link_register_of(struct dsa_port *dp)
 				 "Skipping phylink registration for %s port %d\n",
 				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
 		} else {
-			if (ds->ops->phylink_mac_link_down)
-				ds->ops->phylink_mac_link_down(ds, port,
-					MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
+			dsa_shared_port_link_down(dp);
 
 			return dsa_shared_port_phylink_register(dp);
 		}
-- 
2.30.2


