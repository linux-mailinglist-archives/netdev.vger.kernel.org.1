Return-Path: <netdev+bounces-254240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD6wNk4Cemn31QEAu9opvQ
	(envelope-from <netdev+bounces-254240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:34:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C25A14F4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38873063D78
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBF34EF06;
	Wed, 28 Jan 2026 12:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307034E760;
	Wed, 28 Jan 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603465; cv=none; b=HkWb0gq6Tq7bkzr7p0ZRzQujNrkOBOrilqYG+QNK3nuAiadQJkBmD9Z7Z5nVVUEVnW4fdxPIVS91ytWGnm2lKDj/fBGljlZcq7nUPuM3xzmzL4nmd+vnjX2xE7bwBCy1eg6Im9SU3u89G1oxnyuwJIWRlaFdt/FKRh+KsQj+dLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603465; c=relaxed/simple;
	bh=o26NIRifOz86Ls8d6uX3q14Y/0oFbx2QAS8UvO81KgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZFdU3qhUKl6Vr7KWwDImxEJpvAOyNGCqoc9BosLKc0hsIriCy7sgBDU+lnhs7hijwKlMfXpKwAByhL+zt8bnqh8Fky2fiN6lrby3wO6SBxkcQqE8n65rKVGntmRJllDTjBAYLvDEwjH7WGgCHyd5aCcIzHzi3T7Ed6rX2v8f9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 002151A1B8C;
	Wed, 28 Jan 2026 13:30:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DD1241A1B7F;
	Wed, 28 Jan 2026 13:30:56 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BF73520364;
	Wed, 28 Jan 2026 13:30:55 +0100 (CET)
Date: Wed, 28 Jan 2026 13:30:56 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <aXoBgO+qRRmB1yVM@lsv051416.swis.nl-cdc01.nxp.com>
References: <cover.1769592679.git.dan.carpenter@linaro.org>
 <b38f1c628cdac8e87271e5fa4e2b71110c15b42c.1769592679.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38f1c628cdac8e87271e5fa4e2b71110c15b42c.1769592679.git.dan.carpenter@linaro.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,linaro.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lsv051416.swis.nl-cdc01.nxp.com:mid,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 33C25A14F4
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:54:01PM +0300, Dan Carpenter wrote:
> On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
> Originally, accessing this register was done in a sort of ad-hoc way,
> but we want to use the syscon interface to do it.
> 
> This is a little bit ugly because we have to maintain backwards
> compatibility to the old device trees so we have to support both ways
> to access this register.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v5: Return an error if regmap_write() fails
> v4: no change
> v3: no change
> v2: Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 28 +++++++++++++++----
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..af594a096676 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -11,12 +11,14 @@
>  #include <linux/device.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_address.h>
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/stmmac.h>
>  
>  #include "stmmac_platform.h"
> @@ -32,6 +34,8 @@
>  struct s32_priv_data {
>  	void __iomem *ioaddr;
>  	void __iomem *ctrl_sts;
> +	struct regmap *sts_regmap;
> +	unsigned int sts_offset;
>  	struct device *dev;
>  	phy_interface_t *intf_mode;
>  	struct clk *tx_clk;
> @@ -40,11 +44,17 @@ struct s32_priv_data {
>  
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	int ret = 0;
> +
> +	if (gmac->ctrl_sts)
> +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	else
> +		ret = regmap_write(gmac->sts_regmap, gmac->sts_offset,
> +				   S32_PHY_INTF_SEL_RGMII);
>  
>  	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int s32_gmac_init(struct device *dev, void *priv)
> @@ -125,10 +135,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  				     "dt configuration failed\n");
>  
>  	/* PHY interface mode control reg */
> -	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> -	if (IS_ERR(gmac->ctrl_sts))
> -		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
> -				     "S32CC config region is missing\n");
> +	gmac->sts_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +					"nxp,phy-sel", 1, &gmac->sts_offset);
> +	if (gmac->sts_regmap == ERR_PTR(-EPROBE_DEFER))
> +		return PTR_ERR(gmac->sts_regmap);
> +	if (IS_ERR(gmac->sts_regmap)) {
> +		gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> +		if (IS_ERR(gmac->ctrl_sts))
> +			return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
> +					     "S32CC config region is missing\n");
> +	}
>  
>  	/* tx clock */
>  	gmac->tx_clk = devm_clk_get(&pdev->dev, "tx");
> -- 
> 2.51.0
> 

Reviewed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Thanks.
/Jan


