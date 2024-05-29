Return-Path: <netdev+bounces-99031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD628D379C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05F1F237DF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DF125C0;
	Wed, 29 May 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z2/azBst"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9911CAB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989369; cv=none; b=bTByLfxpmw8jvxOTiW6OupKZcoifDAwL7vP6v2HNIQZLYZ/Qq2+aTJ6eT470v0gMiOh6L00CjH8H2O26sCG6MjXPaLLstzbEV4g+MwehJhXPcjZshxo6MnceTsHPLrNNRpGqrbXom9dLoWKwJzG4tHqi7WdomjaAHBUvmmdV5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989369; c=relaxed/simple;
	bh=0cC26AS9RA8hgkXnPY6c1Jk6MvSh7crAichKJm3IVqU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SDZvu2buLaT9CAybPtZ6nG1iegAjw1jrohbzIH723niPNadQheIrfZLl/5bRiNldFeV82mnyUUKpn7yMfN1ET8BrZgSoLpv0k1uPfASIxN3olCr+O/80hQTMZj8rNcGoNswfMS0HnFiHgBhs6O+XjD5pqUPXUfmAHauAQFYTlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z2/azBst; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vn0jH6CU7KHQ/wpW+WUjXbY6CCLADkErWHq5wcQ5KPY=; b=z2/azBstyNEE8fNK9RO/j3URxN
	/HMqBM8QpLyXTMJbSNeb8o8BQHN0jiih+1BHVS2uc/ULIL/jlUM3h45zbaq3yN6Vo0eYg7pbbcG2o
	qg0ELOzgeZ7f1MC1jZ/lo2xMhb3stSMTCMxsRElBTyqFQO2MQg7PCuLjOJhMdfPXCuA6c/CSOwQYm
	y4Il0ybXHByyM3RoIZ5e6O4PNnJTo5nkoM23OQLs4Uc8ueIBA5Ovc3PT+6wgSBCLjQurjoTMKaw8F
	+ASv9Ok3s6WAog/ESr1UjOjvUmmDYgRaM+5NrYFN+xFeltKi0UYYEt8B+A3yTXxZ0SSjo07ZBB7GX
	UHvi0hVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33424 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCJMi-00069t-39;
	Wed, 29 May 2024 14:29:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCJMl-00Ecqp-K0; Wed, 29 May 2024 14:29:19 +0100
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	 Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/6] net: phylink: rearrange phylink_parse_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCJMl-00Ecqp-K0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 14:29:19 +0100

Of the two users of phylink_config->ovr_an_inband, both manually check
for a fixed link before setting this flag (or clearing it if they find
a fixed link.) This is unnecessary complication.

Rearrange phylink_parse_mode() a little so we can change how
phylink_config->ovr_an_inband works. This will allow the flag to be
tested before checking for the fixed link properties in the next patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 994471fad833..5abd12713598 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -899,12 +899,15 @@ static int phylink_parse_mode(struct phylink *pl,
 			return -EINVAL;
 		}
 
+		pl->cfg_link_an_mode = MLO_AN_INBAND;
+	}
+
+	if (pl->cfg_link_an_mode == MLO_AN_INBAND) {
 		linkmode_zero(pl->supported);
 		phylink_set(pl->supported, MII);
 		phylink_set(pl->supported, Autoneg);
 		phylink_set(pl->supported, Asym_Pause);
 		phylink_set(pl->supported, Pause);
-		pl->cfg_link_an_mode = MLO_AN_INBAND;
 
 		switch (pl->link_config.interface) {
 		case PHY_INTERFACE_MODE_SGMII:
-- 
2.30.2


