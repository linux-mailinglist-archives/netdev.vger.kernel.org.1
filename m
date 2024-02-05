Return-Path: <netdev+bounces-69250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3AF84A830
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F941F2C156
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5A13A898;
	Mon,  5 Feb 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQmo360p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB934A9A5
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166731; cv=none; b=g3pfx5XozjzGLJEYIX9Xjue2g+5zEI1ifskbvmAMrnTde47BEasqQVba3j/jDGTrGT5d/fsxImDcEaS3imCd8eDAk/T5zWaFOTVDg6iE91c4wde3mp2jNwcwKi6WGhYZJ6F+x+vJL3jKkyFVAlddMPAF7pU5+maAKTY08eO9FW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166731; c=relaxed/simple;
	bh=/M5SOXuGLnQ7BvIF37xrcPl1pbvxHe94r2j7si2COLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndVO248LZX7VgF04um2nn7TCn6kzOQp0McuvQBSd2bgmdLAlHRxtxU9yPTb3uCZ8An4mPuExthXr8s4uIlC4Ih43erOWqyOu7FZad/A+X+fWjrqg5LnRkqn0Ro3aXM/Y21l3ek1vGgDWAS5CCnyqhm05tPkjCsCK/g5p3xX1dV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQmo360p; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d09b21a8bbso1182081fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166727; x=1707771527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvtmqJM5hcEalFvG1aFQP9SM9YWoBGnIvrrb52PoOJI=;
        b=XQmo360p0rdAPSPjRXFswC/QtGhh7ht4jk+C/QugwvnsOU86a6I88YIWV/AUOnh0v2
         RXNOf9SPYbyo3TMZLd/0vZumfpcNxEdukFq1oYmyzsN7iFimdF5Jr4CR7AjP/M4DXGAI
         2sCFMBHwi4IVrGYhMSiGOXrJ6Ssbi/XEK4cIOqld/pBUSpEIGKj9rTdizxMN9lOfgopy
         eo4eJQFd9LLX277n7cqEdArWOqgtNx5D+7vi+nWv+mPtvrwjsqi9CaLtBeU+rh64xM9g
         cUg1t10tg3+AGF4GRNROqrWeLj74aCuzuD2xTz6YNoIWn6qoMbMJPPRlzG5Yc/LITyt3
         5+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166727; x=1707771527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvtmqJM5hcEalFvG1aFQP9SM9YWoBGnIvrrb52PoOJI=;
        b=CSaHot3ZRelxP8bXFi4lVFrNjMjd7ujTxh4j3WP/Jl3Eov+bpXCJZK3chje8s6ET5P
         g33O7FkaXK2gAeNuem5zcJigGTBJU8LcEnRBEfWY3SGMvxxv9/9T0lRmdu1lrgKGVQA/
         aZ+yhkavkMCFt1L+0UBkmg+MrK5oZXjwFdeTw9wVgeFi9ElIgEoTio23hBPZpvJpfap0
         GmGiwq4q6Z9YKJgtgeVDK3AJseDRwqz4BaqDQe2t4z7AH0es98XahD85moytWpIHAbmX
         7sKyHvsyNXZAC/C9MIAV5tcyxctXv7VYnNF/Lv8Q4nVF48/XgMdJFMsp2Y6Tyu9YEQZR
         kHmA==
X-Gm-Message-State: AOJu0YwdjFP/a2jxnD5f4PGvf9UJSK2vq5qhSr0g9moCqXdlk8PHpBxA
	Dynfhwb52ZqAnRZjsOFSU2jPEmwC9blv3NmXfV+qBO0jWGb1k/wc
X-Google-Smtp-Source: AGHT+IFNJnAF3GIjLKh3VWvXx1XFthWj+A9RluvyQyQhDdtALLihbv19qVPAgXLqDBWzuZZU8ckOaA==
X-Received: by 2002:a2e:9157:0:b0:2cf:48cf:dbe2 with SMTP id q23-20020a2e9157000000b002cf48cfdbe2mr642283ljg.0.1707166727222;
        Mon, 05 Feb 2024 12:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOnneMeMJCwsAepPxZDBCrHTk1AST7j5wdHz+kkGWJGjcp9JZD9rV2nkmt7uj3AKh+osa3URnH1m5OxgitG+evqBtTkz0YGd00rTuX/hEMBddZKyu34Zt0yPcTkkxMWZO6fAUPOvNqj+7WbVbiCO4Obll7niFQRE7+gT2A/GvWVN+gB3epoxg75Hi/FBy/rujZLoyxrdpsLmGkxwRNosLlbIimAc6IMLiSVGq7DBlTGjYwa1+xMEtLjUPzs6g31WZYX1ZHmTi8bNYPpjeDF54UHcVOVPwxAFsOnxpAet0sRLITwfl4bcs9pnHTW+bCFQqxKbGPOJ3yrCwqOY9o35jjZlpX496kvjKC01sNwq9NHhq08HQT35pj9lM+q8N4DEHP23yDlw==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id x3-20020a2e9dc3000000b002cf5244b08asm60674ljj.83.2024.02.05.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:58:46 -0800 (PST)
Date: Mon, 5 Feb 2024 23:58:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:48:18PM +0800, Yanteng Si wrote:
> Add Loongson GNET (GMAC with PHY) support, override
> stmmac_priv.synopsys_id with 0x37.

Please add more details of all the device capabilities: supported
speeds, duplexness, IP-core version, DMA-descriptors type
(normal/enhanced), MTL Tx/Rx FIFO size, Perfect and Hash-based MAC
Filter tables size, L3/L4 filters availability, VLAN hash table
filter, PHY-interface (GMII, RGMII, etc), EEE support,
AV-feature/Multi-channels support, IEEE 1588 Timestamp support, Magic
Frame support, Remote Wake-up support, IP Checksum, Tx/Rx TCP/IP
Checksum, Mac Management Counters (MMC), SMA/MDIO interface, 

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 3b3578318cc1..584f7322bd3e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -318,6 +318,8 @@ static struct mac_device_info *loongson_setup(void *apriv)
>  	if (!mac)
>  		return NULL;
>  

> +	priv->synopsys_id = 0x37;	/*Overwrite custom IP*/
> +

Please add a more descriptive comment _above_ the subjected line. In
particular note why the override is needed, what is the real DW GMAC
IP-core version and what is the original value the statement above
overrides.

>  	ld = priv->plat->bsp_priv;
>  	mac->dma = &ld->dwlgmac_dma_ops;
>  
> @@ -350,6 +352,46 @@ static struct mac_device_info *loongson_setup(void *apriv)
>  	return mac;
>  }
>  
> +static int loongson_gnet_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(pdev, plat);
> +
> +	plat->multicast_filter_bins = 256;
> +
> +	plat->mdio_bus_data->phy_mask =  ~(u32)BIT(2);
> +
> +	plat->phy_addr = 2;

> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;

Are you sure PHY-interface is supposed to be defined as "internal"? 

> +
> +	plat->bsp_priv = &pdev->dev;
> +
> +	plat->dma_cfg->pbl = 32;
> +	plat->dma_cfg->pblx8 = true;
> +
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +
> +	return 0;
> +}
> +
> +static int loongson_gnet_config(struct pci_dev *pdev,
> +				struct plat_stmmacenet_data *plat,
> +				struct stmmac_resources *res,
> +				struct device_node *np)
> +{
> +	int ret;
> +

> +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);

Again. This will be moved to the probe() method in one of the next
patches leaving loongson_gnet_config() empty. What was the problem
with doing that right away with no intermediate change?

> +
> +	return ret;
> +}
> +
> +static struct stmmac_pci_info loongson_gnet_pci_info = {
> +	.setup = loongson_gnet_data,
> +	.config = loongson_gnet_config,
> +};
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *id)
>  {
> @@ -516,9 +558,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03

> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
>  	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },

After this the driver is supposed to correctly handle the Loongson
GNET devices. Based on the patches introduced further it isn't.
Please consider re-arranging the changes (see my comments in the
further patches).

-Serge(y)

>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

