Return-Path: <netdev+bounces-73993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87B85F915
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77F9286DA9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007413248E;
	Thu, 22 Feb 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mF8b9PpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE612EBD4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606914; cv=none; b=Ub+ZXvknpRu85YHlb3CfrHeXnekE06Cx8VUwxe8cQSxxxjMTK3ExtV29wR6bb0lnPHkJJBR4hRcrpfxecoXKQbRi/DIFtjGYCdjksWuuIg/8CMoMdk7AMpC6ABt7F7hvhJkyFWu75wva1Mfue5F7joTemuk9yS4aIn/xCGm2VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606914; c=relaxed/simple;
	bh=9zC3a/lUBBoHG92n62uz1igUDeqMpK/0eJHMsRGQvwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdruGqQO3a5VzjSO5lp2krfMSfyEDtNmpEp/DXABWxGvW6sJJTAKtinskYyIhln1YFzXDlImtvoJOV/BTnqjDSaAqKm0Nt9HiYD3TMh1wOlpc1I17Sxw+XwJjSY63Pdn47N1ftD99cX9+sI780HrKgSUzjQ/jjJAByJRnRYWvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mF8b9PpX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so2280345e87.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708606910; x=1709211710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7Z26rH0nxtWAPBPvE/KxZ0NHjlwRm5O/7QOSN2/Ky0=;
        b=mF8b9PpXDpthGYHQOPyBJgfTwj/UQtTrU1m0/EVniS7hxHKaKMMd9yw1W2eLqJoA6e
         lTnhz0ZRyZVpjgUvKZ4N6a7BGC8Nz/vUP70MyR8KRkuceXY+cFe4DreBnws6hU5Jhy3C
         QISH21uoUuRdR0bmZVQU5ogw9bwI3UtU/oYZvs5JtnT86jKNcnTRZpRF3XswhONGofq9
         ZXXVZtsRvmFKWzPkZx+1/+a69Pqr2rdxtQxDrqJ5fsH2FBvW9FrDixqMlHEG+BQ1nd/B
         LR0tLFnCDUESdUD3Tx+Wpy1gdOBwPmNbGd1bZE/XqreNyGAqQgroxBIMzoLmfVlmDiAu
         AgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606910; x=1709211710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7Z26rH0nxtWAPBPvE/KxZ0NHjlwRm5O/7QOSN2/Ky0=;
        b=ZfH2yL/RF6M9Bv9qONyPLp0xVsDNHh4GmNpnN3xrNu0c97/Ug0pA+wUhx5Ha24inyM
         uyDZSQ9t3pjMLpmSixFYiDjZBzPV8w0ggRg9UkM6q2dt0Z+FMCaZ33i4LJiFxoZPIeSK
         as8Z7yw0PrW9G0flu9uTJtiGV52XoZOV0O3T7nr+2xZEe4MdxQC/UwTOxlRn3P1z5tJM
         3zvAxmZZ5Ej+E2RXnABt2WhCIhO0GNY7begWARi+8S0VwuClAIUjHXAXqCZ2AEOARBGh
         mvo7RLr90mm9uR86YaADZY8TK2Ico884O2YQqPt/V7r+7I/UgxmAU8jwJMUsvW+b4mR3
         MF6A==
X-Forwarded-Encrypted: i=1; AJvYcCVOyAbUF2F1oXfA+vURD6HBNde35QeUBMFlECXhZAesJLZ2HUj4EigP9v+HvPl+GlF4UGrIaW0NY8vGfcc7COekSYJDzKhf
X-Gm-Message-State: AOJu0Yx9v3LqkwbRof8c+JsPvZPAuFn66XyqS8cxkJw4gsvVfYDrLJx5
	cnrNNilftBZccC/hH8jEv6SWjYBLcqcoO6brY8o8bKb3F/Q/RCqm1RHHtgMQ6d0=
X-Google-Smtp-Source: AGHT+IGkf5An0FRhTN8uAcXotjLH9vOh29NQ0tafltetUlELSWRNWwvu9X3GqAFXb4b17ycZtwCaOQ==
X-Received: by 2002:a05:6512:3a88:b0:512:ba3a:5368 with SMTP id q8-20020a0565123a8800b00512ba3a5368mr9141098lfu.48.1708606910048;
        Thu, 22 Feb 2024 05:01:50 -0800 (PST)
Received: from [172.30.204.125] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o6-20020ac24e86000000b0051186931619sm2055814lfr.146.2024.02.22.05.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:01:49 -0800 (PST)
Message-ID: <54b8c58a-6288-4ae6-9ed7-aa7b212e63da@linaro.org>
Date: Thu, 22 Feb 2024 14:01:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Update link
 clock rate only for RGMII
Content-Language: en-US
To: Sarosh Hasan <quic_sarohasa@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>
Cc: kernel@quicinc.com, Sneh Shah <quic_snehshah@quicinc.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>
References: <20240222125517.3356-1-quic_sarohasa@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240222125517.3356-1-quic_sarohasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 13:55, Sarosh Hasan wrote:
> Updating link clock rate for different speeds is only needed when
> using RGMII, as that mode requires changing clock speed when the link
> speed changes. Let's restrict updating the link clock speed in
> ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
> only need to enable the link clock (which is already done in probe).
> 
> Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
> ---
>   .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 26 ++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..9cd144fb3005 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -169,21 +169,23 @@ static void rgmii_dump(void *priv)
>   static void
>   ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
>   {
> -	switch (speed) {
> -	case SPEED_1000:
> -		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> -		break;
> +	if (phy_interface_mode_is_rgmii(ethqos->phy_mode)) {
> +		switch (speed) {
> +		case SPEED_1000:
> +			ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> +			break;
>   
> -	case SPEED_100:
> -		ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
> -		break;
> +		case SPEED_100:
> +			ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
> +			break;
>   
> -	case SPEED_10:
> -		ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
> -		break;
> -	}
> +		case SPEED_10:
> +			ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
> +			break;
> +		}
>   
> -	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
> +		clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
> +	}
>   }

if (!phy_interface_mode_is_rgmii(ethqos->phy_mode))
	return 0;

[leave the rest unchanged]

?

Konrad

