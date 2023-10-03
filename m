Return-Path: <netdev+bounces-37695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B887B6A97
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9795828160C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E7928DA6;
	Tue,  3 Oct 2023 13:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19559262AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:34:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62CA6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oqxMI3/bfDr/nVm0ypkWZiZ5Ylt26SnPTBr1Bh1iElk=; b=zVoO2MrQDWej1cq1caPmhr//15
	ihdG2p/Bnh01QQzJS8GlQZaYLl44Ju6llBLtUVkvIhK2ALVRJZuEoLfanMDF6LqLceYGneBcghf4L
	F0qgqupwL6oVzdiChQ4y799+1MhnDk7+MbCtbehd91pmM3NTqe6Bav7yv/qOAUA1kzXUV+M4tvXcC
	ODT4NEJQHMK4QSN8BK2vT0/oyM5xHw5K1XUnDjuTBccHW/OmNxdiotM3geK5jWlYFb2uy2pNh8m+N
	OZF8zGcEAhb7qSJzzRhFtWAUPQD1S47xYduj0cD4t6QKLtomFFMgIBf9QREPEExlOYX2KN5DFrpRY
	4GRhdAiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37884 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qnfXg-0001nL-12;
	Tue, 03 Oct 2023 14:34:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qnfXh-008UDe-F9; Tue, 03 Oct 2023 14:34:29 +0100
In-Reply-To: <ZRwYJXRizvkhm83M@shell.armlinux.org.uk>
References: <ZRwYJXRizvkhm83M@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/2] net: sfp: improve Nokia GPON sfp fixup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qnfXh-008UDe-F9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Oct 2023 14:34:29 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve the Nokia GPON fixup - we need to ignore not only the hardware
LOS signal, but also the software implementation as well. Do this by
using the new state_ignore_mask to indicate that we should ignore not
only the hardware RX_LOS signal, and also clear the LOS bits in the
option field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 1f32e936d3ab..1016a953226b 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -345,11 +345,26 @@ static void sfp_fixup_long_startup(struct sfp *sfp)
 	sfp->module_t_start_up = T_START_UP_BAD_GPON;
 }
 
+static void sfp_fixup_ignore_los(struct sfp *sfp)
+{
+	/* This forces LOS to zero, so we ignore transitions */
+	sfp->state_ignore_mask |= SFP_F_LOS;
+	/* Make sure that LOS options are clear */
+	sfp->id.ext.options &= ~cpu_to_be16(SFP_OPTIONS_LOS_INVERTED |
+					    SFP_OPTIONS_LOS_NORMAL);
+}
+
 static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 {
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_nokia(struct sfp *sfp)
+{
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 // For 10GBASE-T short-reach modules
 static void sfp_fixup_10gbaset_30m(struct sfp *sfp)
 {
@@ -446,7 +461,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
-		  sfp_fixup_long_startup),
+		  sfp_fixup_nokia),
 
 	// Fiberstore SFP-10G-T doesn't identify as copper, and uses the
 	// Rollball protocol to talk to the PHY.
-- 
2.30.2


