Return-Path: <netdev+bounces-154137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD269FB925
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 05:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6FA161DD2
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 04:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1444D9FB;
	Tue, 24 Dec 2024 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mz1j4rWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FA383BF
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013945; cv=none; b=YBFJWqepV3M3LeENDBN3Mqte43ALWq6oYku1NIZDLJugO2+NmqHoIV45GIjm58ZtFYb39evkxGacdRMigx6X+jcRI4g2Zm0ITcDvNTRFSfBZkI0px1DX5xFQNJpeq8kGQsfHVpuxEKBOQygfPLRc5Wb5f7z3VkPLC+JA10iaR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013945; c=relaxed/simple;
	bh=f9lcj1SWgFQL0TxFT3cUFgka/Ea/Axw8NUPO6qrsqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4man1n331XKkWOOUqsrUkI4FI3StBD0eK6azKIPVpxqC8RUbwVT+4zQKQcB2gV9hT6nc0a3NmFbmYymrtf3JqaqQ1vOJitJVZesAfSmmSTanUYU5443vCPxB9pKxboBUC4oSpMfzsaaAM0RdGgDA2VZjvkm17MY//YDEKXvOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mz1j4rWj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54024aa9febso5211263e87.1
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 20:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735013942; x=1735618742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j85+evyvQS7SlTLMk12mpMS49xrhooguofPw8Ck5dIU=;
        b=Mz1j4rWjidP8sib65C8WZnex2R+51LO0WqfF2jbAogUYIRVwoLUetMiWgwLcTSjRYp
         N9+qIVulPXxW/KKazhnModGUN9+bQwJ8ltyiDxbn3PuPNlG++RH2g1ew7uLXHK7RVyAb
         4Rd0+4aKfsYwENgWLeNV46/N1pdywCTKha09EkWTFH/XPLsdmsAsv9Mo82szq+F2aVGD
         v7H8nxg0oqAtz5BSh1eDBkW/VBZQ/y/tjPKJUFfTvtZ05d2DtpPTssBs4Wcex4zoOmXN
         OLH4soJxlhrawpK9TKt0RZCFjEtRpyEkzr9LQzTo7OyrPN1JiKyTnF1cT9ukVeVa9hiO
         sfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735013942; x=1735618742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j85+evyvQS7SlTLMk12mpMS49xrhooguofPw8Ck5dIU=;
        b=C0X7k5GQvlFVLam2HeKy40bXEme0e0avsvv9DpbFNsV2+2bpqYW/OS+7dgH1JmKuDh
         6rXMUymoAbyMmiRyBvGG9zIBIoA80YAPxolK3fzrDQzUHPhfj7ChP3XoWYaCRjfyG4iT
         9n1R4JJVBxab9JPyZamSMd9RHCQA6zO1xX3q3L2uRypxhjGUywr6eAy7T2kZj2YqFYCY
         tq8o/NaMrm9qlsV8utB+w9OgXlslGAAtRAxpUurw2/wyEpuNUZqkYDJTlsSOWAJwCZZO
         dELphov1laDv3V8ttboouY2Pi5O8xoqsP5c7UiVK6/aF8uk6ZEaW0FoUe6XAg9y3rxa9
         qOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE8q80brPD8WPsj5QwSFdOJ/zHM2APBlvFvvb2XWoCbVoQPqMXBuJwQbMPWj88sB/6QTr5tfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeSzw7aeDhjcurW/9gLAeJG8lzzoxjQ9KsUDh7NpOc0iBTzSe
	KACP3vIteZMFCultevl99QDMyEhNUukGXdwL7GytxF/nOVL+irfC6pEgwZoeZyw=
X-Gm-Gg: ASbGncvjBwLS/bRYQ2mwc4QbGYrnMGXQTVgXNqE5L/xF5vUUmAGr2QTjMw7zEK/oiF4
	8EsXnrJBKwFO/Mzmd2uiCvrNBbvNZZpta0936tIHbDgC7+Vue8c3kbw7WbQJq7NVvF0WiO5tnIK
	NDn9fO3ZlctyIasUBEiCzW6XJdTQDM9aZ88gIHJsryAQdVczDfoAZ5D+nONNeFSpg+cgr2NICgR
	oAOk1zmtIDSrbqQ3sgGYklIAYiucXVo4OHo+N7O5/snOaUXR26s5CmKcOnSbzLG6Q8iYPA57xFZ
	IAlcFqziaTBEh0BCttn4uJqa91lxBsqkFOMq
X-Google-Smtp-Source: AGHT+IENMWxXPIOYhp6GLi6KEvU2mAH3sEt8lO8Lah7Hkc79/YZpEbN2wsmvfsGNSMcgutuOQc9tKg==
X-Received: by 2002:a05:6512:1041:b0:540:1dac:c03d with SMTP id 2adb3069b0e04-54229586ef3mr4768804e87.57.1735013942241;
        Mon, 23 Dec 2024 20:19:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f5fa8sm1496276e87.46.2024.12.23.20.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 20:19:00 -0800 (PST)
Date: Tue, 24 Dec 2024 06:18:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yijie Yang <quic_yijiyang@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-qcom-ethqos: add support for
 EMAC on qcs615 platforms
Message-ID: <62wm4samob5bzsk2br75fmllkrgptxxj2pgo7hztnhkhvwt54v@zz7edyq6ys77>
References: <20241224-schema-v2-0-000ea9044c49@quicinc.com>
 <20241224-schema-v2-3-000ea9044c49@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-schema-v2-3-000ea9044c49@quicinc.com>

On Tue, Dec 24, 2024 at 11:07:03AM +0800, Yijie Yang wrote:
> qcs615 uses EMAC version 2.3.1, add the relevant defines and add the new
> compatible.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 901a3c1959fa57efb078da795ad4f92a8b6f71e1..8c76beaee48821eb2853f4e3f8bfd37db8cadf78 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -249,6 +249,22 @@ static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
>  	.has_emac_ge_3 = false,
>  };
>  
> +static const struct ethqos_emac_por emac_v2_3_1_por[] = {
> +	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x00C01343 },
> +	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642C },

lowercase the hex, please.

> +	{ .offset = SDCC_HC_REG_DDR_CONFIG,	.value = 0x00000000 },
> +	{ .offset = SDCC_HC_REG_DLL_CONFIG2,	.value = 0x00200000 },
> +	{ .offset = SDCC_USR_CTL,		.value = 0x00010800 },
> +	{ .offset = RGMII_IO_MACRO_CONFIG2,	.value = 0x00002060 },
> +};
> +
> +static const struct ethqos_emac_driver_data emac_v2_3_1_data = {
> +	.por = emac_v2_3_1_por,
> +	.num_por = ARRAY_SIZE(emac_v2_3_1_por),
> +	.rgmii_config_loopback_en = true,
> +	.has_emac_ge_3 = false,
> +};

Modulo emac_v2_3_1_por vs emac_v2_3_0_por, this is the same as
emac_v2_3_0_data. Which means that bindings for qcs615-ethqos should be
corrected to use qcom,qcs404-ethqos as as fallback entry, making this
patch unused. Please correct the bindings instead.

> +
>  static const struct ethqos_emac_por emac_v3_0_0_por[] = {
>  	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
>  	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
> @@ -898,6 +914,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id qcom_ethqos_match[] = {
>  	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
> +	{ .compatible = "qcom,qcs615-ethqos", .data = &emac_v2_3_1_data},
>  	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
>  	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
>  	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

