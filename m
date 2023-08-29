Return-Path: <netdev+bounces-31251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93778C550
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A381C20A55
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3576174DB;
	Tue, 29 Aug 2023 13:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DED171B2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:29:59 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA9F7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0DjC9ZMxD102H+JhE6xrIC7pYAF3Sy1Cq4pNKP95ISo=; b=IHAfui+2D5PmkRyzYMMcFRVUbF
	W/+LyN4pJIICbtHlxoFQAcev9qqFYcdp7y1Nd9qSEEvOLTVjNqsa4o94UEE5+mow3zIow4470l0mF
	cUaRA+9EV6xzxGCEGCl+6/PWWeD2XCFLllSPghtFef7u7GsWf30lqIsrGEIN7wr5fyHC8QNys7H83
	VXaixUcXQ2VOjwVCcubgHvgag3LNRR+48CyE26fzPIzDH218vsZDHBKUCEQT0ogIk3Vtzw4EP56NH
	i+w/Pfh3ALQNpswloxyYgsWmAlzp6gaHvlyfAgcw9/HT69AEdaNziIlhzapj0CKn4+YvdyYRJJiu+
	s1h9cezA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36568 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qayn0-0000WA-0a;
	Tue, 29 Aug 2023 14:29:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qayn0-006Q8J-GE; Tue, 29 Aug 2023 14:29:50 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: stmmac: failure to probe without MAC interface
 specified
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qayn0-006Q8J-GE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 29 Aug 2023 14:29:50 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexander Stein reports that commit a014c35556b9 ("net: stmmac: clarify
difference between "interface" and "phy_interface"") caused breakage,
because plat->mac_interface will never be negative. Fix this by using
the "rc" temporary variable in stmmac_probe_config_dt().

Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
I don't think the net tree is up to date with the net-next, so this
patch needs applying to net-next preferably before the pull request
to fix a regression.

Thanks.

 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 35f4b1484029..0f28795e581c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -419,9 +419,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		return ERR_PTR(phy_mode);
 
 	plat->phy_interface = phy_mode;
-	plat->mac_interface = stmmac_of_get_mac_mode(np);
-	if (plat->mac_interface < 0)
-		plat->mac_interface = plat->phy_interface;
+	rc = stmmac_of_get_mac_mode(np);
+	plat->mac_interface = rc < 0 ? plat->phy_interface : rc;
 
 	/* Some wrapper drivers still rely on phy_node. Let's save it while
 	 * they are not converted to phylink. */
-- 
2.30.2


