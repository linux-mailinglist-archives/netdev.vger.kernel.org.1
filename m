Return-Path: <netdev+bounces-58597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3E81774F
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39D71C23CDE
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7142392;
	Mon, 18 Dec 2023 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RopcjDXT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162936AEA
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702916526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTEkicxeHNXHb/6pSYfpZYOfjZVCf7gx8W87QpG78TA=;
	b=RopcjDXTFci1TqOLW9XjO/oDfb8eyrvrEDBP4uvk6n05v3CZVQFC+H2qyN/IUbR4VM3UeR
	H5Nu8oom8snHenPbo3mN7tPg+UraSSWm7XNXzcf3YZFg0E0RMiTb6QROGCq0T/zmTqlos5
	LZt3I/wWkfGqoo96d8V3gVIjJOcanEM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-aeiMLOarP1iUXqvHHJ2aqg-1; Mon, 18 Dec 2023 11:20:10 -0500
X-MC-Unique: aeiMLOarP1iUXqvHHJ2aqg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77f46b7ef40so569510185a.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916407; x=1703521207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTEkicxeHNXHb/6pSYfpZYOfjZVCf7gx8W87QpG78TA=;
        b=N4r+XoCe0M2QJwd5wJYGeAifonBgTuxw6/17EQiO1RjmJAqBSJWjaq+WoKYt8pLBvR
         ELw5cO7fPEZEMJ6tcuX5qvZU9FVl1c1mHIJlG8urJTq320qccOmYuN5csuL8DS88HFwa
         GAdqLNahCFqT5+nfP9a9NA2Y22V7PxdilLlRosxkXYlYG5XQsDeBsxkJYybv8y8nbuUa
         ChrxLjwUMClWbDtid9CUdP5N87JQAUZdkk9OPIi2CfVMYOc+ZejrzrCRHo0TYtzbeTa/
         s4sNhu6gFdtQ0QqCGqJgKFnE1cKiOWt6jkfZU4V+guRC5y2vsUu5LjjVzQXS4CiOhjeS
         vgmQ==
X-Gm-Message-State: AOJu0YxJS8dJA3Qfh0tM2WghbByDmEoaT2xw2KCW5edzVf0xWUEk17qb
	kgG9rlnIPMa1thx/ZthFHjUiCWFNrLZ9b8MIgdkPQOLwNn9Mtp7m3GA05uIlcGEaI8ZAM1d58na
	c3gmD/CqZAerb539G
X-Received: by 2002:a05:620a:4591:b0:77e:fba3:58e2 with SMTP id bp17-20020a05620a459100b0077efba358e2mr21670382qkb.115.1702916407340;
        Mon, 18 Dec 2023 08:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtIhW+W09l1XgbMu3JLXQQrCRVUmt/NuCFTSbNGaPFdKMggkCWZLhtm+YyuiZCLChvHbZurQ==
X-Received: by 2002:a05:620a:4591:b0:77e:fba3:58e2 with SMTP id bp17-20020a05620a459100b0077efba358e2mr21670361qkb.115.1702916407066;
        Mon, 18 Dec 2023 08:20:07 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id vq18-20020a05620a559200b0077fafc08e46sm2772136qkn.84.2023.12.18.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:20:06 -0800 (PST)
Date: Mon, 18 Dec 2023 10:20:03 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for
 2.5G SGMII
Message-ID: <4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>
References: <20231218071118.21879-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218071118.21879-1-quic_snehshah@quicinc.com>

On Mon, Dec 18, 2023 at 12:41:18PM +0530, Sneh Shah wrote:
> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> mode for 1G/100M/10M speed.
> Added changes to configure serdes phy and mac based on link speed.
> 
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..b3a28dc19161 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -21,6 +21,7 @@
>  #define RGMII_IO_MACRO_CONFIG2		0x1C
>  #define RGMII_IO_MACRO_DEBUG1		0x20
>  #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
> +#define ETHQOS_MAC_AN_CTRL		0xE0
>  
>  /* RGMII_IO_MACRO_CONFIG fields */
>  #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
> @@ -78,6 +79,10 @@
>  #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
>  #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
>  
> +/*ETHQOS_MAC_AN_CTRL bits */
> +#define ETHQOS_MAC_AN_CTRL_RAN			BIT(9)
> +#define ETHQOS_MAC_AN_CTRL_ANE			BIT(12)
> +

nit: space please add a space before ETHQOS_MAC_AN_CTRL

>  struct ethqos_emac_por {
>  	unsigned int offset;
>  	unsigned int value;
> @@ -109,6 +114,7 @@ struct qcom_ethqos {
>  	unsigned int num_por;
>  	bool rgmii_config_loopback_en;
>  	bool has_emac_ge_3;
> +	unsigned int serdes_speed;
>  };
>  
>  static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
> @@ -600,27 +606,47 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
>  
>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  {
> -	int val;
> -
> +	int val, mac_an_value;
>  	val = readl(ethqos->mac_base + MAC_CTRL_REG);
> +	mac_an_value = readl(ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
>  
>  	switch (ethqos->speed) {
> +	case SPEED_2500:
> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> +			      RGMII_IO_MACRO_CONFIG2);
> +		if (ethqos->serdes_speed != SPEED_2500)
> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> +		mac_an_value &= ~ETHQOS_MAC_AN_CTRL_ANE;
> +		break;
>  	case SPEED_1000:
>  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
>  		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>  			      RGMII_IO_MACRO_CONFIG2);
> +		if (ethqos->serdes_speed != SPEED_1000)
> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>  		break;
>  	case SPEED_100:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
> +		if (ethqos->serdes_speed != SPEED_1000)
> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>  		break;
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> +		if (ethqos->serdes_speed != SPEED_1000)
> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>  		break;
>  	}
>  
>  	writel(val, ethqos->mac_base + MAC_CTRL_REG);
> +	writel(mac_an_value, ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
> +	ethqos->serdes_speed = ethqos->speed;

I see these bits are generic and there's some functions in stmmac_pcs.h
that muck with these...

Could you help me understand if this really should be Qualcomm specific,
or if this is something that should be considered for the more core bits
of the driver? I feel in either case we should take advantage of the
common definitions in that file if possible.

>  
>  	return val;
>  }
> @@ -789,6 +815,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  				     "Failed to get serdes phy\n");
>  
>  	ethqos->speed = SPEED_1000;
> +	ethqos->serdes_speed = SPEED_1000;
>  	ethqos_update_link_clk(ethqos, SPEED_1000);
>  	ethqos_set_func_clk_en(ethqos);
>  
> -- 
> 2.17.1
> 


