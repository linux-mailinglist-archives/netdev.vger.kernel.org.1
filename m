Return-Path: <netdev+bounces-30363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AF78705F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527B52815D9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4442890B;
	Thu, 24 Aug 2023 13:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE48100A7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:38:07 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9190A10EF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+pDUnGS3fPXl62HbQXfqAtSfEmek0JbeaXPVZog/Gb8=; b=sMj3xB601rd6BEWs+KrB6LyeWd
	M++A88qprjsX9zbICIJ1BvFigr4KzcruflgZd2eN8DZcHueTrbTHAHE4icnpcZ00S6OhAR5B7KfRs
	LXJg7qcs/8By4D1sw4S6Yq7jl0yWVeoPXzcFSDegtr4UJ9baywEXhHxrhvEq2xiBRpaai1c7HpP4r
	sjdwycNBpUcfgkXgJHZ5hXnLMceh6pMUQX3Ej8zn4X16NkzlKiq3NDhHEMXQ2Vc5hE+S4NFNAQpRB
	MruKtwEUuLcQHhabrQDZRFMEKCJHm9uvJcvlAaf0xE76FveQxaH8FElvRAxfCfA7+wob9/Ene1wdZ
	G+SNxs9A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54008 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZAX3-0004Bz-0q;
	Thu, 24 Aug 2023 14:37:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZAX3-005pTi-K1; Thu, 24 Aug 2023 14:37:53 +0100
In-Reply-To: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 01/10] net: phylink: add phylink_limit_mac_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZAX3-005pTi-K1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 24 Aug 2023 14:37:53 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a function which can be used to limit the phylink MAC capabilities
to an upper speed limit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 18 ++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 160bce608c34..0d7354955d62 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -426,6 +426,24 @@ static struct {
 	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF },
 };
 
+/**
+ * phylink_limit_mac_speed - limit the phylink_config to a maximum speed
+ * @config: pointer to a &struct phylink_config
+ * @max_speed: maximum speed
+ *
+ * Mask off MAC capabilities for speeds higher than the @max_speed parameter.
+ * Any further motifications of config.mac_capabilities will override this.
+ */
+void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(phylink_caps_params) &&
+		    phylink_caps_params[i].speed > max_speed; i++)
+		config->mac_capabilities &= ~phylink_caps_params[i].mask;
+}
+EXPORT_SYMBOL_GPL(phylink_limit_mac_speed);
+
 /**
  * phylink_cap_from_speed_duplex - Get mac capability from speed/duplex
  * @speed: the speed to search for
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 789c516c6b4a..7d07f8736431 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -223,6 +223,8 @@ struct phylink_config {
 	unsigned long mac_capabilities;
 };
 
+void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
+
 /**
  * struct phylink_mac_ops - MAC operations structure.
  * @validate: Validate and update the link configuration.
-- 
2.30.2


