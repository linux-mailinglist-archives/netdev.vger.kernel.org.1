Return-Path: <netdev+bounces-37694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D417B6A96
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D251E281661
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94028698;
	Tue,  3 Oct 2023 13:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBF262AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:34:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730FAB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eZz3B/lrhH1Pc5iFa23TkUghdhEMSgGibxabSKoQJsU=; b=OJIbUrjGAlEnQJacmwAaIhp6s7
	QtUTc5u9zsEbbJ7lWXB/gZSdt4P4CJtfYFZibIH/gpi+FW1Z+/5jFNnwoCmw/HrCXuRTqCjAI0iD/
	wWYmbeIwBSx++C4HzNEkVQgkb6u0gICSGwXTzI/hFx9vE1dPw7VbBh0QKPdbuUW9eYmGnuoXrYtSs
	/QHJYc2rVGZKvhIfMrOxcaVZDL0WTqbL0KAbB/njZ+FRdOmBrtUYrJ9BCMykImdr3uRHJi8o3WhKo
	gXjsXM/ZyP3ZlwHE155FZcUeVMajn5+7QqBY8l75KNxxZJGH4rVrI/Etu95N0B354jtn2ntty9Gkd
	6k8BwCdA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39900 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qnfXb-0001n9-0U;
	Tue, 03 Oct 2023 14:34:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qnfXc-008UDY-91; Tue, 03 Oct 2023 14:34:24 +0100
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
Subject: [PATCH net-next 1/2] net: sfp: re-implement ignoring the hardware
 TX_FAULT signal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qnfXc-008UDY-91@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Oct 2023 14:34:24 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Re-implement how we ignore the hardware TX_FAULT signal. Rather than
having a separate boolean for this, use a bitmask of the hardware
signals that we wish to ignore. This gives more flexibility in the
future to ignore other signals such as RX_LOS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a50038a45250..1f32e936d3ab 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -257,6 +257,7 @@ struct sfp {
 	unsigned int state_hw_drive;
 	unsigned int state_hw_mask;
 	unsigned int state_soft_mask;
+	unsigned int state_ignore_mask;
 	unsigned int state;
 
 	struct delayed_work poll;
@@ -280,7 +281,6 @@ struct sfp {
 	unsigned int rs_state_mask;
 
 	bool have_a2;
-	bool tx_fault_ignore;
 
 	const struct sfp_quirk *quirk;
 
@@ -347,7 +347,7 @@ static void sfp_fixup_long_startup(struct sfp *sfp)
 
 static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 {
-	sfp->tx_fault_ignore = true;
+	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
 // For 10GBASE-T short-reach modules
@@ -789,7 +789,8 @@ static void sfp_soft_start_poll(struct sfp *sfp)
 
 	mutex_lock(&sfp->st_mutex);
 	// Poll the soft state for hardware pins we want to ignore
-	sfp->state_soft_mask = ~sfp->state_hw_mask & mask;
+	sfp->state_soft_mask = ~sfp->state_hw_mask & ~sfp->state_ignore_mask &
+			       mask;
 
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) &&
 	    !sfp->need_poll)
@@ -2314,7 +2315,7 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 	sfp->module_t_start_up = T_START_UP;
 	sfp->module_t_wait = T_WAIT;
 
-	sfp->tx_fault_ignore = false;
+	sfp->state_ignore_mask = 0;
 
 	if (sfp->id.base.extended_cc == SFF8024_ECC_10GBASE_T_SFI ||
 	    sfp->id.base.extended_cc == SFF8024_ECC_10GBASE_T_SR ||
@@ -2337,6 +2338,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 
 	if (sfp->quirk && sfp->quirk->fixup)
 		sfp->quirk->fixup(sfp);
+
+	sfp->state_hw_mask &= ~sfp->state_ignore_mask;
 	mutex_unlock(&sfp->st_mutex);
 
 	return 0;
@@ -2838,10 +2841,7 @@ static void sfp_check_state(struct sfp *sfp)
 	mutex_lock(&sfp->st_mutex);
 	state = sfp_get_state(sfp);
 	changed = state ^ sfp->state;
-	if (sfp->tx_fault_ignore)
-		changed &= SFP_F_PRESENT | SFP_F_LOS;
-	else
-		changed &= SFP_F_PRESENT | SFP_F_LOS | SFP_F_TX_FAULT;
+	changed &= SFP_F_PRESENT | SFP_F_LOS | SFP_F_TX_FAULT;
 
 	for (i = 0; i < GPIO_MAX; i++)
 		if (changed & BIT(i))
-- 
2.30.2


