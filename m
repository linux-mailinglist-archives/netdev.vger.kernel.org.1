Return-Path: <netdev+bounces-61129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B9822A75
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A13284767
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6681863F;
	Wed,  3 Jan 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKURrIJW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D618634
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336f2c88361so5695471f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704275297; x=1704880097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ygiQ5GZ7AaDONBWvS2tDIrOeQ15Rvo3O1ywNhmUg6E=;
        b=DKURrIJWUdAW9g81u035uyQjPPYqxC3IHf5y4D4x5F8/0+SupR0ZqLxRH9INT9swMz
         QjuATZjny7Qb/fZ+VfKUhm8vn8jLTz1DGrtS+2qrcZFaHliPgBDCKtOlv0nMn534Yltz
         nyl3fqupsaG+BnycDn65a3Ff/oWhfOC3129AjlJYHbKy5qB0gHED6NSCwg+MltvCRqvV
         /jOaYutSu4MzBlr3GoJgC245W2BJVY1DePS2sDHH3CQGoAuC4Si22qtnMCzbGkzTXTCD
         BCP6RVnpYKayfcjeL9zvqwekBQXNi4b1O2TBTb2cjGN08fk9JdBF4HtXtGnlDXufeO7d
         Y6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275297; x=1704880097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ygiQ5GZ7AaDONBWvS2tDIrOeQ15Rvo3O1ywNhmUg6E=;
        b=d4HZDlZWKe1EF1Hw389FfgGqt/zxM7ZX4ScDmywKk4TqO9dlb98UrKmH16473yz/i8
         zdoU7FcfTO/rZwgQPmHAnHiT/DFezpXgKjedH+4m2aqxtH1zg49xx6B24pnBcHFzlUw0
         6hX9XMEUN1qeZ7xDuKagaZde7qfqP0oD0ee6PIlenyclqiWMpgkaZETpnOTXzOPjbfwd
         60NSh//5FGRFLA5Ao9aBjam0JoVy64JGthjzHcXjTWibH6lsN7l8n97t5LYHNgSvqv5r
         RPdSo7hBdDllXcL5GIdyZxTuzMG1tAjJ/HdE5D/PseAI7Z5zSujRPq/OvcpLGOln9hsx
         l1gA==
X-Gm-Message-State: AOJu0YwslMxhLkRa72fG7Ho8Kh0uCunoYaj1dbs0IV6GoSGGpqFjimpb
	ToD0j8jDRbTFP0LrBCgIE0GoMg/w91KXpQ==
X-Google-Smtp-Source: AGHT+IHSLGf/w+/4nLJY24qGtbeXFaHszE9j+MVClx84jKy+oClHc3nv8SAWdrAvyz8Wu3CyLWhQYQ==
X-Received: by 2002:a05:6000:368:b0:337:2aa3:ac80 with SMTP id f8-20020a056000036800b003372aa3ac80mr3811982wrf.68.1704275297315;
        Wed, 03 Jan 2024 01:48:17 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b00333359b522dsm30539123wrm.77.2024.01.03.01.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:48:16 -0800 (PST)
Message-ID: <e0926d70-09d1-40ab-939a-7e110d718448@linaro.org>
Date: Wed, 3 Jan 2024 09:48:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] net: mdio: ipq4019: enable the SoC uniphy clocks
 for ipq5332 platform
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-3-quic_luoj@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231225084424.30986-3-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/12/2023 08:44, Luo Jie wrote:
> On the platform ipq5332, the related SoC uniphy GCC clocks need
> to be enabled for making the MDIO slave devices accessible.
> 
> These UNIPHY clocks are from the SoC platform GCC clock provider,
> which are enabled for the connected PHY devices working.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>   drivers/net/mdio/mdio-ipq4019.c | 75 ++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index 5273864fabb3..e24b0e688b10 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -35,15 +35,36 @@
>   /* MDIO clock source frequency is fixed to 100M */
>   #define IPQ_MDIO_CLK_RATE	100000000
>   
> +/* SoC UNIPHY fixed clock */
> +#define IPQ_UNIPHY_AHB_CLK_RATE	100000000
> +#define IPQ_UNIPHY_SYS_CLK_RATE	24000000
> +
>   #define IPQ_PHY_SET_DELAY_US	100000
>   
>   /* Maximum SOC PCS(uniphy) number on IPQ platform */
>   #define ETH_LDO_RDY_CNT				3
>   
> +enum mdio_clk_id {
> +	MDIO_CLK_MDIO_AHB,
> +	MDIO_CLK_UNIPHY0_AHB,
> +	MDIO_CLK_UNIPHY0_SYS,
> +	MDIO_CLK_UNIPHY1_AHB,
> +	MDIO_CLK_UNIPHY1_SYS,
> +	MDIO_CLK_CNT
> +};
> +
>   struct ipq4019_mdio_data {
>   	void __iomem *membase;
>   	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
> -	struct clk *mdio_clk;
> +	struct clk *clk[MDIO_CLK_CNT];
> +};
> +
> +static const char *const mdio_clk_name[] = {
> +	"gcc_mdio_ahb_clk",
> +	"uniphy0_ahb",
> +	"uniphy0_sys",
> +	"uniphy1_ahb",
> +	"uniphy1_sys"
>   };
>   
>   static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
> @@ -209,14 +230,43 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>   static int ipq_mdio_reset(struct mii_bus *bus)
>   {
>   	struct ipq4019_mdio_data *priv = bus->priv;
> -	int ret;
> +	unsigned long rate;
> +	int ret, index;
>   
> -	/* Configure MDIO clock source frequency if clock is specified in the device tree */
> -	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
> -	if (ret)
> -		return ret;
> +	/* For the platform ipq5332, there are two SoC uniphies available
> +	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
> +	 * should be enabled for resetting the connected device such
> +	 * as qca8386 switch, qca8081 PHY or other PHYs effectively.
> +	 *
> +	 * Configure MDIO/UNIPHY clock source frequency if clock instance
> +	 * is specified in the device tree.
> +	 */
> +	for (index = MDIO_CLK_MDIO_AHB; index < MDIO_CLK_CNT; index++) {

you could do a

if (!priv->clk[index])
	continue;

here and save a few cycles executing code for absent clocks. ipq6018 has 
just 1/5 of the clocks you are checking for here.

Better still capture the number of clocks you find in probe() in a 
variable priv->num_clocks and only step through the array

for (i = 0; i < priv->num_clocks; i++) {}

---
bod

