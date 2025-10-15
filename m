Return-Path: <netdev+bounces-229673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B80DFBDF96A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E2C0505E9E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69532ED2E;
	Wed, 15 Oct 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="awDYVu/9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189025CC79
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544670; cv=none; b=XYHznr4/CNFGDq+I4sYX0pHBImJ+hdDtwpQ2tBTbJd0QLCSC1DFiJjgmEWxCiD0u8bs02PUyNq7m4P3F39ld9m/ncR63dgutrXCQUtOoo2DqusPyRuUHs+pikz49/NvNrJe+bzu4nOeZJjH2gFk1OpYv0umNfsBuO5oFAJvFkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544670; c=relaxed/simple;
	bh=CH7gfh8Px48moonebJaK5xFS2wd9ohzDgz0GDTQRkWE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HVr/R3gfyzVtA9EsFQHSIW5dbdQ+8mkGwOvxW/nre5p5JTzwyfffwat+qj137T9C/k4NwR7CTgB410X6jisXEPi8tRGxRCERumY6A6s838jWPnnWgxksuQo9VAGhkZCubXw3GCvBtDaad03vngLKljTOGkR6Ce8mv/cW2tTbOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=awDYVu/9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uqLOBUY0xU3RN71ffCkfmJX1LRd55XNwi+h1nM0Q9Ps=; b=awDYVu/9177C4j2gkxtgJtIgeK
	yiI0UZJ570OzDPY4bl2k1nEhy7+Oa6FFVznX4uC5U4g55kXg6NMWt3AklfN+mz1dzix2+Ol4yzChF
	IOix5BhyOK2a7QmKKwE6FvI6DA/eKSEjfWFLocZ56CQnupmB111bVc5PzUX2vv2PBxv0YgwC3BFb2
	USTUYWUKz9dWGLBm8WZVBRpzf6xDaG7d19xb9RukV9k8UhEzAnhzW0blKGMb/saL3b5wLkp2SJEpU
	0j8IR3htwwhR92S8nSOfIdbSzwrSRFhtDXa44/nF0TKlUB669pMhK/PiwEZn5LyqC0qBVPCcyATZX
	NRVdomjw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v945Z-000000005AZ-2lmk;
	Wed, 15 Oct 2025 17:10:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v945Y-0000000Ameb-2gDI;
	Wed, 15 Oct 2025 17:10:56 +0100
In-Reply-To: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/5] net: stmmac: rearrange tc_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v945Y-0000000Ameb-2gDI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Oct 2025 17:10:56 +0100

To make future changes easier, rearrange the use of dma_cap->l3l4fnum
vs priv->flow_entries_max.

Always initialise priv->flow_entries_max from dma_cap->l3l4fnum, then
use priv->flow_entries_max to determine whether we allocate
priv->flow_entries and set it up.

This change is safe because tc_init() is only called once from
stmmac_dvr_probe().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 97e89a604abd..ef65cf511f3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -262,10 +262,10 @@ static int tc_init(struct stmmac_priv *priv)
 	unsigned int count;
 	int ret, i;
 
-	if (dma_cap->l3l4fnum) {
-		priv->flow_entries_max = dma_cap->l3l4fnum;
+	priv->flow_entries_max = dma_cap->l3l4fnum;
+	if (priv->flow_entries_max) {
 		priv->flow_entries = devm_kcalloc(priv->device,
-						  dma_cap->l3l4fnum,
+						  priv->flow_entries_max,
 						  sizeof(*priv->flow_entries),
 						  GFP_KERNEL);
 		if (!priv->flow_entries)
-- 
2.47.3


