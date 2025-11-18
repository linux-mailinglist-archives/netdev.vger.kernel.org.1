Return-Path: <netdev+bounces-239490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEABC68B5B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 597623813FB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88E32E13C;
	Tue, 18 Nov 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QsbRz4CL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FA3375C2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460086; cv=none; b=ODazYEwZsM2+JRDh/KDswqCNnpYJORzcIxoq+i1DfC/ctarDAcBHylReVyOGZDmxu5OvD7NO28tQkEGhRmyMURIfj5Swm2zAsMdCuiFHkFEh6/mGcPu3i9gYbe0tSNOp7m4Lcd0UJy8NUQQ8IMhHXhtHXdUXSKuxosRhsuWQ3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460086; c=relaxed/simple;
	bh=DRQ1QtFw9Zqi0Fyza9uRJuuS2293HQe40B8/zNrQX8E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tF4wZyCUCWfjEwEVP8CBUfB2OxJWTWJvbWVO6DQLdUKjIJqUUkVNL1Km8bBR+UhNmRzIU8f1DPx9qiXX/CEAEwsVM3wE1NfGinHVJ7hFWY78e0YAGzMTTmxJEDpNxOKEyaGSXlmjXz3sYfmHOtors5qOBz3sm/jonbw+87cCjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QsbRz4CL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aRVTCsVKmKuNEimYsPQc5eVcrZkNx01Ledzu5WS/DBo=; b=QsbRz4CLzEuj/1cu3cYRbqZy/t
	WLuNxQc7gHHPRxQXBzvBvXXu9rI6ICsM4p2v94jse1+TEhIUogH0J4RaokES2E34djACWsEPQx5X3
	0/jBae55MjzLQdYmMVEb5tNV74SfazqeljkAyGGA8EY6vIGQ6Uje2gig/Mpkbl6LRPBEzZoEdGgcE
	5v/9MRdhdi6P7xfBeoaBaN96rMKTOsqbvWOAAgs8kDpxYRt+PuXdEZPJuGudwctiJWP2aM/6jPMUB
	5zBTsYa2eEmePzhNLqCYpN+8a1LmIM73t/wIDjhBzf8Wv2loP1b6C3nbySLOWuVdbF6n6JEZcgkMK
	bkl8dcrQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43556 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLIWS-0000000031x-0q2O;
	Tue, 18 Nov 2025 10:01:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLIWR-0000000Ewkf-1Tdx;
	Tue, 18 Nov 2025 10:01:15 +0000
In-Reply-To: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
References: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: stmmac: stmmac_is_jumbo_frm() len should be
 unsigned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLIWR-0000000Ewkf-1Tdx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Nov 2025 10:01:15 +0000

stmmac_is_jumbo_frm() and the is_jumbo_frm() methods take skb->len
which is an unsigned int. Avoid an implicit cast to "int" via the
method parameter and then incorrectly doing signed comparisons on
this unsigned value.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index fb55efd52240..d14b56e5ed40 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -83,7 +83,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	return entry;
 }
 
-static unsigned int is_jumbo_frm(int len, int enh_desc)
+static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
 {
 	unsigned int ret = 0;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index d359722100fa..4953e0fab547 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -541,7 +541,7 @@ struct stmmac_rx_queue;
 struct stmmac_mode_ops {
 	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
 		      unsigned int extend_desc);
-	unsigned int (*is_jumbo_frm) (int len, int ehn_desc);
+	unsigned int (*is_jumbo_frm)(unsigned int len, int ehn_desc);
 	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 			 int csum);
 	int (*set_16kib_bfsize)(int mtu);
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index d218412ca832..039903c424df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -91,7 +91,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	return entry;
 }
 
-static unsigned int is_jumbo_frm(int len, int enh_desc)
+static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
 {
 	unsigned int ret = 0;
 
-- 
2.47.3


