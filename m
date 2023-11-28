Return-Path: <netdev+bounces-51611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC27FB57A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB9A281E79
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923FA405FA;
	Tue, 28 Nov 2023 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cGP/JFSw"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA0D53;
	Tue, 28 Nov 2023 01:18:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EE001C000D;
	Tue, 28 Nov 2023 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701163123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNvRwnmWbMcsSfw4MtpQ8A6yvzjLtDp5XU7GJHCHcNg=;
	b=cGP/JFSwx72kYNQBXmTul4ItDEpXcm2qsZemcZUUfdQ62v0J+1ZmCtGtsukPTgd9m3/Cx8
	SAv+jPBPn1349+noY/O6WWXBhVCuacr4Ja/Ug8c2cl/eMEsbML5lwJtw4o6hjjXelYmc/4
	OWObjLP8VDosTxpJuVvUAcfJE3EY8Pw/a4hvsFUaGcV7mDE/P4/6izHG0fQN09wrerBpM4
	77Mvw3E/+gaEVNvkg8U10TNasMlECQVIcMN0THLlqGP6vQgjrt6IKfvAsKwUTKtMN5NBRN
	JNYEOnHm88RD2yhmn2xj781DKV8QYS6O5NnAjM+jmNZWCLWtvOahHBnZ7kCWCw==
Date: Tue, 28 Nov 2023 10:18:41 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII
 adapter when not available
Message-ID: <20231128101841.627fc97e@windsurf>
In-Reply-To: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
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
X-GND-Sasl: thomas.petazzoni@bootlin.com

On Tue, 28 Nov 2023 10:45:37 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> The SGMII adapter isn't present on all dwmac-socfpga implementations.
> Make sure we don't try to configure it if we don't have this adapter.
> 
> Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index ba2ce776bd4d..ae120792e1b6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -243,7 +243,8 @@ static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
>  {
>  	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
>  
> -	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> +	if (dwmac->sgmii_adapter_base)
> +		writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
>  }
>  
>  static int socfpga_set_phy_mode_common(int phymode, u32 *val)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

As a follow-up improvement, there's an open-coded version of
socfpga_sgmii_config() in socfpga_dwmac_fix_mac_speed(), which could be
rewritten as such:

	socfpga_sgmii_config(dwmac, false);

	if (splitter_base) {
		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
		val &= ~EMAC_SPLITTER_CTRL_SPEED_MASK;

		switch (speed) {
		case 1000:
			val |= EMAC_SPLITTER_CTRL_SPEED_1000;
			break;
		case 100:
			val |= EMAC_SPLITTER_CTRL_SPEED_100;
			break;
		case 10:
			val |= EMAC_SPLITTER_CTRL_SPEED_10;
			break;
		default:
			return;
		}
		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
	}

	if (phy_dev)
		socfpga_sgmii_config(dwmac, true);

But of course, that's not a fix so it should be a separate improvement.

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

