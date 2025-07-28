Return-Path: <netdev+bounces-210567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115AB13F2D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547833A3986
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30576273D8E;
	Mon, 28 Jul 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qzwc7S0V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B302737E3
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717602; cv=none; b=P4uDaI1FqY77DbRn41Fm9eRfl7kr4aWNkp4UUTPPlguLlbXjujvMFKQq1aec9HLbBKugi6Gof1LJ7d+kAqZNheSaS1TtM6KXjwF/+mzj+UCBuvKolzXl58Otz4JjP7KqufTC8H+b8SAnJw7ik3svw73mxAiWMTrz9se4TvscFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717602; c=relaxed/simple;
	bh=cBANRwVFaSqDugug8eSitJgysi1oMOuagVB2ST0N4ss=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=X/6dvjbo9GomEC0FaFWAK9KQD92CtTdBPpC4pn1YUJGXUqD8P5KQrXwO8D6KTUwy6HfMPl4l9rVWGkMLqjCHsn2H4F81lUViy1GKTjunaNrDFO0esJgXbmqAl+whA97sHdlBXSd12KYrb3d0RygH27+bA9jneMxTcmv4/CTez+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qzwc7S0V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EFg3uLajH2uqZ4TKBpJ9slpQUapZBgJWZv1F9yK5ENs=; b=Qzwc7S0VycqeOc+t408LTLOl8h
	c+MVlUxp/4w2bRoJgU4Jl3Ms91XIDSupkEiryHS7eBJP3WADGnScqsAwI9ZIf4uA54qagZg7bEdpL
	NOOJ2KOma/q4P5Ohi5p5zfphH9JnDkyn/he7pZuVUDSO6T/Mny8ncQTR6DSVzRfskKuOiPhj9W/cF
	dYYL25LoOlwyrA2h1pipcYW5HAapldhauF70TgWj5JX2PrHwswpCLmtkxjvlfKEWEhV1R01GpvT8S
	pTL1ISE66e2IxHRmLaCgm2An7/OK4bVjoZ8+tY491Wj63H/2Y5NzhPp+/Hv9rt2Onu4E4Vifk4ih3
	D1Q8v/Vw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37882 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ugQ3b-0000Ua-36;
	Mon, 28 Jul 2025 16:46:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ugQ2t-006KDF-H8; Mon, 28 Jul 2025 16:45:47 +0100
In-Reply-To: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 4/7] net: stmmac: remove unnecessary "stmmac:
 wakeup enable" print
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ugQ2t-006KDF-H8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 28 Jul 2025 16:45:47 +0100

Printing "stmmac: wakeup enable" to the kernel log isn't useful - it
doesn't identify the adapter, and is effectively nothing more than a
debugging print. This information can be discovered by looking at
/sys/device.../power/wakeup as the device_set_wakeup_enable() call
updates this sysfs file.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index cd2fb92ac84c..58542b72cc01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -816,7 +816,6 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	}
 
 	if (wol->wolopts) {
-		pr_info("stmmac: wakeup enable\n");
 		device_set_wakeup_enable(priv->device, 1);
 		/* Avoid unbalanced enable_irq_wake calls */
 		if (priv->wol_irq_disabled)
-- 
2.30.2


