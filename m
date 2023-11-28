Return-Path: <netdev+bounces-51613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410F7FB5BC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E91C210C3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC0746457;
	Tue, 28 Nov 2023 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sjtn6l7z"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE405D0;
	Tue, 28 Nov 2023 01:26:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14305E000C;
	Tue, 28 Nov 2023 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701163601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SWqqO2Y/xiO+TRt8YQW+yLQIPdt2LTdZoHMxmm1Ics=;
	b=Sjtn6l7zR30mQxJLlA3aYzk9WnLTcPBVw0DYsqorv2X4Go8xgOK4V3aCzIINxp+nkLGQK5
	Ayse/f/Mse7tHbDjEPE+MPdWmz3bMf42OLOslD8lN5W9elEuudOQOBJjNrD+tiwAbEWIAr
	SCTRi+QfaZVk0WJipImlHqNLPfi9dC88hjVDTFMScwVwr1vaJ5aeZQD3WVaCxQPTF2Ikz1
	dlK4suG6cJLtk01cHyNVpoT0H7VlPB0VGUwvyIScf/5+mKM+5Bfq0T+bA2rNwRtCJDAFRP
	Jp/kVUBaLItB12epGtBbbim4dhUuRLuNfhMK3eet1bJq29qppvLkNdVT6MzFIA==
Date: Tue, 28 Nov 2023 11:20:37 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII
 adapter when not available
Message-ID: <20231128112037.21e2d5aa@device.home>
In-Reply-To: <20231128101841.627fc97e@windsurf>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
	<20231128101841.627fc97e@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Thomas,

On Tue, 28 Nov 2023 10:18:41 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> On Tue, 28 Nov 2023 10:45:37 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > The SGMII adapter isn't present on all dwmac-socfpga implementations.
> > Make sure we don't try to configure it if we don't have this adapter.
> > 
> > Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index ba2ce776bd4d..ae120792e1b6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -243,7 +243,8 @@ static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
> >  {
> >  	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
> >  
> > -	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> > +	if (dwmac->sgmii_adapter_base)
> > +		writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> >  }
> >  
> >  static int socfpga_set_phy_mode_common(int phymode, u32 *val)  
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> As a follow-up improvement, there's an open-coded version of
> socfpga_sgmii_config() in socfpga_dwmac_fix_mac_speed(), which could be
> rewritten as such:
> 
> 	socfpga_sgmii_config(dwmac, false);
>
> 	if (splitter_base) {
> 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
> 		val &= ~EMAC_SPLITTER_CTRL_SPEED_MASK;
 [...]

I did saw this, but as this is merely a non-functional rework, I'd
like to target this to net-next, so I'll wait for the fix to land and
follow-up with this rework indeed.

Thanks for the review,

Maxime

