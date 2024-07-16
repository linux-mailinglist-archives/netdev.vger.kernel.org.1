Return-Path: <netdev+bounces-111718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B09323AB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DC4284C4C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533F61991C9;
	Tue, 16 Jul 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTEDsi9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A80198A29
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124830; cv=none; b=X5L9W/sl2k1BNk4IycZXb/Uoe0/wOQo0a3GbEmd/r4FPze6gw2xtMrEfXsMq1qNPklJ8+Sh5FZzP/fzM81jHLq6f0LIcy0bZFO833loSXzqie7/XrIqEW3J7sRFxXrbDhXDRGcHco4Z2vbizvV5VIA3v8FsmNd4BLkr3FfEzEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124830; c=relaxed/simple;
	bh=f8Gky9YqWDCmNh8MKNY9H8sRB+mkfPsGLsY2vGiP7+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4UuigBXxL8y2xYsVesLjzSUgmi87UvzL4DswyV7JUwYhJaNH6jX92+1A+11vNq/SkFwfVDjHAKAILd85/GdwCMYeR5H9J16z1GX2eDcK+ZHuVYGYqDTwrHOPJbVLYQk5mHAspW9yo6bSj9TUIpkWxfLYuVcFgEzbPfbwDeO7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTEDsi9k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af3d9169bso3640722b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721124827; x=1721729627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6gMwbuavCbnycNTjRaKx9Abv3DoqBPYUEzkdAtOD14=;
        b=NTEDsi9kYF9duQPxqkOq3Bkr6Vol49BNRWzhV2wsTBiR7MJtBd+1IRNl4jzjrxoUAv
         Ykd5vKc7d+ndCODB7vfiibVcjhTZ6DkOt98lfgDBgb0QTKO1LfpaUmfF/TuD8x7oS9XD
         C+sd80RtqFIrVMON04BADFTBcEywMkjURVrCO4sQf4Sd56oPOTrjirsk+VgyNUI0JvkR
         IjzBRi0FEk4DLGimAtE/KdozIezmWTU0VYTR6nGHDPgafu6qtCrWU8PFPoLIEB6KUqyP
         kLYXTr3nvppS6V/MQ1Simq77QoMT5FvSVNHjjH9E33TIgzc4bmPdoTayW/ZGytsTvTDb
         ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721124827; x=1721729627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6gMwbuavCbnycNTjRaKx9Abv3DoqBPYUEzkdAtOD14=;
        b=P1ycX3Rtuh1wPzZaq1z83xlm1p/BPI9yX6QPuH1n+qUPaDQTr26Q1cFv/zxkheWseB
         fno220sswQBNDYBgpKXTSMfaZUfKy6jQ5ArnlsHpZUQBGxX/sX8jdYR4n9Y8n1OkuuxW
         5ot/a/GnVGhHuZI2GVbe0yWGYPZ7WR7tMICvqL7zHcAq2pnXEqSViXg52+IZLa7663Ja
         1ln1s6EAxxF1+BHC9W1hExe1qOfvbet/TS74eHcp6vAIUt9NOvyZNeIs1WLxTAwLI09B
         I59485el6jdRppG8/Fu/YGRVOW4UQPRyc+6H/L8vnvCrWiO5IZsBKxdpm9V7ke5otnLO
         vkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSJFPJzWrGOisLQv6wNIrDR4n5hwiQ+ufg4GminYdVkN5070jhKIAs9TV4RoumyGbgnAQogZrEsqXONZTqdfwrtZtCs/Q
X-Gm-Message-State: AOJu0Ywq+Nyf2WJ55bWiJq8GJbbKX35ux9/kv9KcBV4mVEfjsAzAiK3m
	sDTAp38amKIP8Sngjhz3uedKeMmFg/vt8hgsemXMgfSKsJsuSZbQozkik2S0kw==
X-Google-Smtp-Source: AGHT+IEDJskFirz6paZGF1HW14iR2GuRPxyEKCS91A1U9kJEn0J3pLh5f3w2w9WhXlu21KxqWnu3BQ==
X-Received: by 2002:a05:6a00:170d:b0:706:6272:417 with SMTP id d2e1a72fcca58-70c1fbd50acmr2120187b3a.10.1721124827058;
        Tue, 16 Jul 2024 03:13:47 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e285sm5915488b3a.8.2024.07.16.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:13:46 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:43:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Patrick Wildt <patrick@blueri.se>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-yoga: add wifi
 calibration variant
Message-ID: <20240716101335.GK3446@thinkpad>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7OeGNIGGpqNC0@windev.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpV7OeGNIGGpqNC0@windev.fritz.box>

On Mon, Jul 15, 2024 at 09:40:41PM +0200, Patrick Wildt wrote:
> Describe the bus topology for PCIe domain 4 and add the ath12k
> calibration variant so that the board file (calibration data) can be
> loaded.
> 
> Signed-off-by: Patrick Wildt <patrick@blueri.se>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts      |  9 +++++++++
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi                 | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index fbff558f5b07..f569f0fbd1fc 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -635,6 +635,15 @@ &pcie4_phy {
>  	status = "okay";
>  };
>  
> +&pcie4_port0 {
> +	wifi@0 {
> +		compatible = "pci17cb,1107";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +		qcom,ath12k-calibration-variant = "LES790";
> +	};
> +};
> +
>  &pcie6a {
>  	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 7bca5fcd7d52..70eeacd4f9ad 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3085,6 +3085,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phy-names = "pciephy";
>  
>  			status = "disabled";
> +
> +			pcie4_port0: pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>  		};
>  
>  		pcie4_phy: phy@1c0e000 {
> -- 
> 2.45.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

