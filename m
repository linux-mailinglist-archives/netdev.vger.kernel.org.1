Return-Path: <netdev+bounces-157719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C9A0B5F9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D471667D0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050051465AE;
	Mon, 13 Jan 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="07IgX5hz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BD22CF3E
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768789; cv=none; b=C0ZHh0QLEUxBbUDieJlImP1AyD63unWw8TIoRjN2cU+vXZKqnDDCGhhq6lQ0B10f7nhSK9CUQtOZjc5U8RG5QLondtW2bC/8dlS7us2ohtH1rRcFWX/LPIFuE7w1cq3Rg5wNIwsfnZH348MehJuoxhV4epW0FJQuSRaxTDEkHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768789; c=relaxed/simple;
	bh=22yEy/nD6zTvEpofeX5d0DpSB5ofVLVLDOCLogI9EFI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qxOM+EkDXr5lyefWRi9F9vjewT+4gS+nNYJzxErE5Lx/lOorKspqzx4K3/MckpWkbiOgqaG4mwNWaREWI/i8Y/4ADvSqX0vBibjQa3D3UuVFti+RQjVEmCkV8IVBXBKQD5oOLggLwZ3kRlvNW7LiSzuH0qKvA0PAc2KnR6HW38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=07IgX5hz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eHGBpnOJSbQXIJIcFls+W2wBz5McA8yNE0ntaczE2hE=; b=07IgX5hzLIa68QEHroPBGdGykk
	ylc62DhROu9kE3gMANoaYDxGIaU7Lm8Ffz6GSzTB1TjeMDowHqmiPFG/gVaKxzu+wF3BjC0nn9Qks
	L+hyXuq8L3k95XzNlCZE0j23Il+PClcGVKTIDmDzaOVYNJZkdPU/btLl2TphPtDrbBMAbMJXSyPqK
	vsdKhyd2ubop0qIlcejcA8k8cbmVaQsrhDLRxFQJX6CYEPzqxJnCb3EgSHgMUg8lIPHHx2KU+VmfJ
	QQtUrMj8Sl4QXQhPc4mkjACkpUX0UXbwByEHqfopxwNgjP4FZhxLXNCQmKAOljmEaCMv7BEEunLYu
	9Dt05LNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35704 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItf-0006Vx-14;
	Mon, 13 Jan 2025 11:46:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItM-000MBI-CX; Mon, 13 Jan 2025 11:46:00 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 5/9] net: stmmac: add stmmac_try_to_start_sw_lpi()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItM-000MBI-CX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:46:00 +0000

There are two places which call stmmac_enable_eee_mode() and follow it
immediately by modifying the expiry of priv->eee_ctrl_timer. Both code
paths are trying to enable LPI mode. Remove this duplication by
providing a function for this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 26ff1ded4e3d..2bb61757e320 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -426,6 +426,13 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 	return 0;
 }
 
+static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
+{
+	if (stmmac_enable_eee_mode(priv))
+		mod_timer(&priv->eee_ctrl_timer,
+			  STMMAC_LPI_T(priv->tx_lpi_timer));
+}
+
 /**
  * stmmac_stop_sw_lpi - stop transmitting LPI
  * @priv: driver private structure
@@ -449,8 +456,7 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
 {
 	struct stmmac_priv *priv = from_timer(priv, t, eee_ctrl_timer);
 
-	if (stmmac_enable_eee_mode(priv))
-		mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(priv->tx_lpi_timer));
+	stmmac_try_to_start_sw_lpi(priv);
 }
 
 /**
@@ -2782,10 +2788,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			xmits = budget;
 	}
 
-	if (priv->eee_sw_timer_en && !priv->tx_path_in_lpi_mode) {
-		if (stmmac_enable_eee_mode(priv))
-			mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(priv->tx_lpi_timer));
-	}
+	if (priv->eee_sw_timer_en && !priv->tx_path_in_lpi_mode)
+		stmmac_try_to_start_sw_lpi(priv);
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-- 
2.30.2


