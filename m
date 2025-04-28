Return-Path: <netdev+bounces-186480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10891A9F59A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86969176783
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36F27FD70;
	Mon, 28 Apr 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VstnMOO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12027CB21
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857330; cv=none; b=IYZ3OTabuT0QR7aTTQXk64sfFndd3GuC3/4ubMsWrWP5n/rXYB41AcRhfhAzcc0Cu/HJEFrraOiPa9yOAOBl5dpHESj3OUtBqJr6BIYLLB41/IoDTevMz80WQkKjQ4H35pxmIQTmoRp5CJE/sdq+QlF8ozF2C07A9kupYKHXBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857330; c=relaxed/simple;
	bh=Vw4DlImvgesrbSAsVdwb6vTeImKi0Z4LGtqXAOAB+Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lot3mP10S7MY0wx3M7wrk1h1x0IROP3uwsqbxv2v1cnZIjltlbb6ioJ6rB8ywNh9sTJIppKcGo/nm1JuBfWuU3/tR2tMyiYRlfoxyFw8S+9VB3tcVgW2IUVswRK5MwI5i5nniDwW5U63TNBB1C3i18owbtRadZQm4Sa3EIb57oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VstnMOO9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7080dd5f9f1so34166877b3.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745857326; x=1746462126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjtfgNYAyQgaIv+6+gwAi/DXzlNfZQv9vmE2wR+LnUU=;
        b=VstnMOO9OIpDzRVxGmD9lmKOmGsdXuocbVU9WCF4GNr0cPoaTl+FvxFER6+gxTX01g
         l0lPgxqzmL4GI0JX2UiIFXcAiIS68xq+DKCjIKxCbmShJ71tf7eFQmLqy1OOwC5ZqDYz
         zsKcS742SGFGoG5pLeeNUgEUQ28vlxoWIQa7wjfNDKi/ALdT3FLf6nIpQcw1FnW5H55G
         6L/vMsGOdDkcpUMzmI3uLgqcHkhrY2S8ZeRgkF+AJZBbdJqT77kL0zGKpLFWCm3PHB+a
         E1qqVEe0tr6wcHtDoZAR8pMkiR4kpbeZqwXtzijE3XqLWKv99PcQujVmOdxowxweiEl2
         H5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857326; x=1746462126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjtfgNYAyQgaIv+6+gwAi/DXzlNfZQv9vmE2wR+LnUU=;
        b=WgQIqAytp1ySYVXDGlZCmrxFP7exkNPpIVysQfTTg/32zuMpfQeVVk+4WH8ArjMqW1
         acs4qbTx3JI0sy41DGGsTd6l/bnRXk/RVH9F/b8Hu9t/pQfiMaTbtv55/TabQgv/Tp41
         eNtL8bnzfBz4d/qtYoqbseH5T0kQyAJsagGhxnP5QZcnnvYW5JCOwo+nm+NpykxSKiAL
         PNph6eCNLBi7JGZjL1sPrp2LV2Vj6q2v9mP3YYIwQsaGvQZuBVHgcWl037QagXag1v8U
         Ps8sJOi0oijX4ujZQGwzOcMLFEr+/ISj5Pj/Hjhsog1/+DG77ckyMjGkkVVm8xavReQR
         TVAg==
X-Forwarded-Encrypted: i=1; AJvYcCVbfk+M6MR2VdGuDekp8tL4eVV7m9NFtdnCtcQSDwjV2jVEAsmL72+IlI4C+aAZmPjsMgU+YlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NxyldU58+iFammOfMUzYCC2uWX9frDuSHFBhmSrUc3WDYc7t
	MmcKUW72irPthftGp4IEyGYL7PJgAn4Jy22klbtRd56+ev/fsX52q09qT8P6+Uw4gxQaXVraC5Q
	mEUJsOrocCtfgC3nM/vIuHox73/7rKK31BytlIQ==
X-Gm-Gg: ASbGnct387zelAFRJuOMbe0Eof7z7mLRm/ao64kWOQDwN44UEPZNGfBammJpDXnPxTH
	86xtgsBIrG0//Ntdxy32Eetb7x6aiWnIgBAXDExgnt/CFfgAPJHTruasOxNJEwajUDErYCkWotI
	xPM/tOkRMg/UzSsYhV43IkyGHeiW2NK4Rikg==
X-Google-Smtp-Source: AGHT+IHJ8fzCsar22nWRrLuqubA/nW5PD6Isexezh6U72gKuIl5N70HEwT9JTNXKPWmpqHrpu7bpAGC2DT3kmga/dpo=
X-Received: by 2002:a05:690c:67c6:b0:708:3532:ec94 with SMTP id
 00721157ae682-70853f752e9mr174343137b3.0.1745857326167; Mon, 28 Apr 2025
 09:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-sm7150-upstream-v1-0-bf9a9081631d@jiaxyga.com> <20250422-sm7150-upstream-v1-11-bf9a9081631d@jiaxyga.com>
In-Reply-To: <20250422-sm7150-upstream-v1-11-bf9a9081631d@jiaxyga.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:21:30 +0200
X-Gm-Features: ATxdqUFknbhFgOKvNVOI3-s43pP4YH55pKLNf_KwLrUaeaEizalUr2MLUM3sfs8
Message-ID: <CAPDyKFqPpqDj+DKT=nJrTS8iDUx_8scnLreUQ99byDHEdBeiww@mail.gmail.com>
Subject: Re: [PATCH 11/33] dt-bindings: mmc: sdhci-msm: Add the SM7150 compatible
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Souradeep Chowdhury <quic_schowdhu@quicinc.com>, Lee Jones <lee@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Elder <elder@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	David Wronek <david@mainlining.org>, Jens Reidel <adrian@mainlining.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-hardening@vger.kernel.org, linux@mainlining.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 22:24, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> Add compatible for the SDHCI block found in SM7150.
>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index eed9063e9bb352b5c8dac10ae2d289c5ca17f81b..2b2cbce2458b70b96b98c042109b10ead26e2291 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -60,6 +60,7 @@ properties:
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm6375-sdhci
> +              - qcom,sm7150-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
>                - qcom,sm8350-sdhci
>
> --
> 2.49.0
>

