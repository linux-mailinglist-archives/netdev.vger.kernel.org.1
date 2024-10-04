Return-Path: <netdev+bounces-131962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589B9900C5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A00281F03
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138714A609;
	Fri,  4 Oct 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KM+zpqnK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B749137903
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037273; cv=none; b=LhIFb0yiWLAWaLBUm+RreL/rYMMb41BcXlJbn7lBOMDl15X3uGV3oADhrr3oosXykUkegaWgMhg2gZuB2Q6DGABVKA6n3ZREDcIB52ooiGKbHpWcrMtlGWxKWSeVjUvr8g/RvRoftHE7xvMcR+0VfSIuq6ImrAQAgArgr08i6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037273; c=relaxed/simple;
	bh=SuqeHeEHJKu5IRY/ceQktJtlxMo9n8wbbuJjhjTGHAQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lN6lgJnsd3TBW7SFg+aGV6ikGPEqVb7ezLYOdg/Qi4LXKFZTNCR4/CYoNG19neiTc2bPQp4jFS/IQNINCk4J+SzVGyjtkYFxtlf8f0QqXsh0cg6kYGaBDb3mr4WAFU0o3BgUiijITovry1ZGEwth7qKw4uWRlGlBTgl/ukoGDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KM+zpqnK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/I8skTevCz4rK9Ac2m0VAGBuriJ9uLhXWtfDx8BDQpI=; b=KM+zpqnK2Qcf0rSxfhICvD6CiA
	VW8olwrcyukt+LYKjzRxm7kLJCxlJ6yldF6sumLyK97V9VH8l5L9Hwm0GNJef1iiqF4pbA4c9SSNY
	li/tlpvVXVhPweHa2Kqpyq8sSUxdbCSuhSts37Z2OwGeAxTWs7TydEdVl0Rke+ufeGmnb9C/ff/2N
	rY9KcJGEADYBTeQ9519W4DMrWtD5QVXWihQwJ6Fr+4n7PaCva4bd8tyxLxCTb32XJ+ti5kb+u0BSj
	qMqNbHgfsddeqq5Gk9AO//7YVonPZK8IHC64U16M7UZ6w3GC6pAuuhp9fohJt9SSOHlflsR9r5/RF
	oYj2mvuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39944 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQc-0001gM-03;
	Fri, 04 Oct 2024 11:20:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQZ-006Df8-JR; Fri, 04 Oct 2024 11:20:51 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 03/13] net: pcs: xpcs: pass xpcs instead of xpcs->id
 to xpcs_find_compat()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQZ-006Df8-JR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:20:51 +0100

xpcs_find_compat() is now always passed xpcs->id. Rather than always
dereferencing this in the caller, move it into xpcs_find_compat(),
thus making this function consistent with most of the other xpcs
functions in taking an xpcs pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4fbf7c816ed5..8bde87ab971f 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -121,11 +121,11 @@ struct dw_xpcs_desc {
 };
 
 static const struct dw_xpcs_compat *
-xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
+xpcs_find_compat(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
 
-	for (compat = desc->compat; compat->supported; compat++)
+	for (compat = xpcs->desc->compat; compat->supported; compat++)
 		if (compat->interface == interface)
 			return compat;
 
@@ -136,7 +136,7 @@ int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
 
-	compat = xpcs_find_compat(xpcs->desc, interface);
+	compat = xpcs_find_compat(xpcs, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -548,7 +548,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 	int i;
 
 	xpcs = phylink_pcs_to_xpcs(pcs);
-	compat = xpcs_find_compat(xpcs->desc, state->interface);
+	compat = xpcs_find_compat(xpcs, state->interface);
 	if (!compat)
 		return -EINVAL;
 
@@ -620,7 +620,7 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 	if (!xpcs->need_reset)
 		return;
 
-	compat = xpcs_find_compat(xpcs->desc, interface);
+	compat = xpcs_find_compat(xpcs, interface);
 	if (!compat) {
 		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
 			phy_modes(interface));
@@ -810,7 +810,7 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	const struct dw_xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->desc, interface);
+	compat = xpcs_find_compat(xpcs, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -1074,7 +1074,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 	const struct dw_xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->desc, state->interface);
+	compat = xpcs_find_compat(xpcs, state->interface);
 	if (!compat)
 		return;
 
-- 
2.30.2


