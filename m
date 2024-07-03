Return-Path: <netdev+bounces-108941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5B92645D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8871C21CB0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3A17BB1F;
	Wed,  3 Jul 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axB15R92"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860817B41D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019386; cv=none; b=Wy11csqBngVKcA8i//g9ckiyMYvARqqrlHLC07iCP3aZ7NU/rHbFnsMKx+86giA73kHR/SNcATasChYnQnKLAXs3gcxT/W9hlMw8XR0aDoj5BCkvNMN7/XIAERLsP0bYrFS2NXaiV/ucshaMMg9Q5HJPpD7QPyPWrprhGUpxYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019386; c=relaxed/simple;
	bh=fhpejWcF/vfLe6nwrakqQTsElpgre49BCBgEinb2+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvS50x/jIsh5v1ruk/GLOp/6Yps1+lxlJIPfCPVQsKVynpManFtyhDk84XZ0hx+5eKJqqkcmSewUKCfEG9pZCiuHjb3G9+1D80j/pw52DXFSueLX7KTmeLu0PnH8hX+ZLu/OZ3MiuaFBZk7qqFOH4xhswH6+gjKohx8mj357hTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axB15R92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwJT/oF0rqnt+S31sg05vpTbadEupYIHlD2ocZCHgDI=;
	b=axB15R92bijurVmdG/rL+hymn5lxE6Wdv4Kx28RoGucvl1/9CKL2Ip7vnldcnIZrfA4A2r
	zOIOp1wHE2zhjCqG3KeR8Dp3WB1Bx0dwT2oKgrKTqAvjSFPl0sxNylMevDVajkBik7tivu
	/HLJ9Gn1M4rrdqlBYGeav/t92RSk8H0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Zdev3EwOMJqA-hWAV133Ew-1; Wed, 03 Jul 2024 11:09:42 -0400
X-MC-Unique: Zdev3EwOMJqA-hWAV133Ew-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79d5d9b24a7so646197285a.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019382; x=1720624182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwJT/oF0rqnt+S31sg05vpTbadEupYIHlD2ocZCHgDI=;
        b=DWAS9PkiKfgAr1SI9w5rN6aHnUzz5EH//BDO16G1J6XTePzrh3RLcj1twpwRklSLlL
         tSdAgdWtpw24vrZXQ05IKPKBX0Mbgoke7DlXcWA6lxYuflMAogfJ9+nssSLgviga50GI
         +xDU9S5dkSkQBLpr7q0fQUZGOTykgNij9Boc5q2gIUsuE55S4N4ooknjrdBehMtZ+xtR
         ml531PNwo/zhzYTIwAkgf3nXF/J2oNupt81G2Ts7tSs0jyv4rQM0y4e2F+0iPE1S0gBo
         8bRNDDqj7YM6B5Tczc/7Fud1/eGczOpChleIltaYYPpaCLgCiLZ40kREzZ4dKGNYOeyi
         rDZw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNtUrROJqs8BU/Uq3UDTz1F9bqM1LZtrHsyRPcbLOx3QYFVe8+oFi1U6XF3YklxnVwG4VjZI1aRV0E77z6cIS2ZnS8noC
X-Gm-Message-State: AOJu0YxPysQPyOohoLSi3DdkwbhChgddPdC6VbePTW4PC4J2q81GgyOI
	oYErzgycBw9vH1C8bx1v0TTH9xYZADE0GrbQKE0t1OXaJDO2rIB0pCH3d6Tk41pg9j6ak2iOeng
	UNijMmitCf4Ob98GrQ4I5t1xqNvH6+gT9z81DlWj+CiSfzt+iKTeQjw==
X-Received: by 2002:ac8:7d84:0:b0:444:b495:e94d with SMTP id d75a77b69052e-44662c99f4bmr119753231cf.3.1720019381991;
        Wed, 03 Jul 2024 08:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8jWmpy5/3+Y1qV1pkAlEofbtK+RF6spB2E3wXQKII8gdILaaxSAxoLFic14g5Q4iTwcc7CA==
X-Received: by 2002:ac8:7d84:0:b0:444:b495:e94d with SMTP id d75a77b69052e-44662c99f4bmr119751991cf.3.1720019381501;
        Wed, 03 Jul 2024 08:09:41 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465c4bf7ecsm43222571cf.80.2024.07.03.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:09:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:09:36 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, jassisinghbrar@gmail.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, manivannan.sadhasivam@linaro.org, will@kernel.org, 
	joro@8bytes.org, conor@kernel.org, tglx@linutronix.de, amitk@kernel.org, 
	thara.gopinath@gmail.com, linus.walleij@linaro.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, rafael@kernel.org, viresh.kumar@linaro.org, vkoul@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	robimarko@gmail.com, quic_gurus@quicinc.com, bartosz.golaszewski@linaro.org, 
	kishon@kernel.org, quic_wcheng@quicinc.com, alim.akhtar@samsung.com, 
	avri.altman@wdc.com, bvanassche@acm.org, agross@kernel.org, 
	gregkh@linuxfoundation.org, quic_tdas@quicinc.com, robin.murphy@arm.com, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	quic_rjendra@quicinc.com, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, quic_rohiagar@quicinc.com, luca@z3ntu.xyz, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, bhupesh.sharma@linaro.org, 
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com, 
	netdev@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@pengutronix.de, dmitry.baryshkov@linaro.org, 
	quic_cang@quicinc.com, danila@jiaxyga.com, quic_nitirawa@quicinc.com, 
	mantas@8devices.com, athierry@redhat.com, quic_kbajaj@quicinc.com, 
	quic_bjorande@quicinc.com, quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, 
	quic_tsoni@quicinc.com, quic_rgottimu@quicinc.com, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, 
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-crypto@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@quicinc.com
Subject: Re: [PATCH 29/47] dt-bindings: net: qcom,ethqos: add description for
 qcs9100
Message-ID: <u5ekupjqvgoehkl76pv7ljyqqzbnnyh6ci2dilfxfkcdvdy3dp@ehdujhkul7ow>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-30-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703025850.2172008-30-quic_tengfan@quicinc.com>

On Wed, Jul 03, 2024 at 10:58:32AM GMT, Tengfei Fan wrote:
> Add the compatible for the MAC controller on qcs9100 platforms. This MAC
> works with a single interrupt so add minItems to the interrupts property.
> The fourth clock's name is different here so change it. Enable relevant
> PHY properties. Add the relevant compatibles to the binding document for
> snps,dwmac as well.

This description doesn't match what was done in this patch, its what
Bart did when he made changes to add the sa8775 changes. Please consider
using a blurb indicating that this is the same SoC as sa8775p, just with
different firmware strategies or something along those lines?

> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 1 +
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 6672327358bc..8ab11e00668c 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,qcs404-ethqos
> +      - qcom,qcs9100-ethqos
>        - qcom,sa8775p-ethqos
>        - qcom,sc8280xp-ethqos
>        - qcom,sm8150-ethqos
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3bab4e1f3fbf..269c21779396 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -67,6 +67,7 @@ properties:
>          - loongson,ls2k-dwmac
>          - loongson,ls7a-dwmac
>          - qcom,qcs404-ethqos
> +        - qcom,qcs9100-ethqos
>          - qcom,sa8775p-ethqos
>          - qcom,sc8280xp-ethqos
>          - qcom,sm8150-ethqos
> @@ -582,6 +583,7 @@ allOf:
>                - ingenic,x1600-mac
>                - ingenic,x1830-mac
>                - ingenic,x2000-mac
> +              - qcom,qcs9100-ethqos
>                - qcom,sa8775p-ethqos
>                - qcom,sc8280xp-ethqos
>                - snps,dwmac-3.50a
> @@ -639,6 +641,7 @@ allOf:
>                - ingenic,x1830-mac
>                - ingenic,x2000-mac
>                - qcom,qcs404-ethqos
> +              - qcom,qcs9100-ethqos
>                - qcom,sa8775p-ethqos
>                - qcom,sc8280xp-ethqos
>                - qcom,sm8150-ethqos
> -- 
> 2.25.1
> 


