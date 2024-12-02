Return-Path: <netdev+bounces-148139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C969E07AD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E8217A41D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E320C028;
	Mon,  2 Dec 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqVRjmwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82B20ADEC
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153089; cv=none; b=quK+C4wuqW+6+KZU5OC/dvVoYaKQkKwaKY8RDy8plOPo2R16eLJzA/jvdoIbLCechX7q7eMI6nt3+em6ksXxVTmiWxlp9FXDc/RWO6fl0UrywP0lQ7tfoM/+q53qUQ0Zl2xlIDPvvQlAgu9aqBrXuhZ8CBr7BQKGiRrGul3jfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153089; c=relaxed/simple;
	bh=goFeMCUVRbDjipThdghVVJLskLf8H473+GNXYnXXrDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABVj9opwdjRV2wTmutdVNXxWRuLGMtaWicfZr+QUuiACI3aDInSJ0IxHwvVtQJuHIaMUnuqjS9SYUrlUTny/seJeZ77IG3+h9iQZQ+5nS7AbBTLDlHGuTdu2O6WrZBgKkIsOP4swN39e9ToDsr2mxcgmzdNSCOFY3S5r2C8o6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqVRjmwC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eeffdff41dso36736657b3.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153087; x=1733757887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05ZXtxtYDYApb+lIzc95yV2LA74LDricN9fUjzTVsRg=;
        b=oqVRjmwCPFbp8NX13GQ37Knaf7Js6RruA7JsAME9fKoTUAGL/hAHluYy3hssqDdGck
         G3h2wgUUsarnvqYTXpdtcC7ex9fmfZah+6CcPrjQHRIdDHm5YYD2ZPWCzPyWLSZX+6Wl
         Ttd2gF3PJx2LHbFghXgX2dyZmsOzrQOFa0InxUkzTh0xRpguw7ISgu8qgM4B0PL1BYAk
         u2/lj2VSrRMtL+bSn3omEt6j92wabJzeXdNMRiojvlZWxVN6/j0rB5ZgVKGLX7zgR29U
         clW/0lGnWXGwEgryAo35SEApnH1tAAyBhCWD6+6ugnSKDsCgkQNwbtXI2HeWI15fYVO/
         e+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153087; x=1733757887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05ZXtxtYDYApb+lIzc95yV2LA74LDricN9fUjzTVsRg=;
        b=xLuv4qH/JROuAA2t8Z1epg5AaSgxUjVliHog8pmzMhwSFVg7pRyAcH9ztcsmhQt5xt
         kupzh80vGztUhNFez5+h5Gcch5BsQ4C7gOPQDCCy0eXIuHA0Nh/ngXy9WZwNctmRbLHz
         0PPocQKIlmzpRvQH/gKhmRj+U2SiuSl5lIL0IjZ+XAad4HwPcfRxBNx3s7KcR/7/PtHY
         ZqjSRtXqZRZQPcJJ2TQYP9XZNMYAuDRIfyyMHO+5z1S0SdTDScSa2XvaI8CIKEHnc5MF
         t0iKTYOMPFMBUBwbtymfndVvUkp8tUYkg5/HKRIIUwPipF/l0khK193MH9LQYGlda3t1
         j5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW39tGcl5z1WcGPLpCP76L5j9St5Yca4DpzbqVnRH0w1EgzKah0Ay0gJN+R/mHDBKcai+Lwev4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5ma9+DtA3IPbVW5NMubnwVy7JIOJhUHwwETFFlowmfv2EwTP
	0jJyub6HAgten2UMo7HKP6XxS2kHv97G0N5d3mwjd68iHQffox+I4whW75o/8LVJD6zkxHb20wx
	SHPfE586bemsHbYEK4orMxVyOYuXXnz/kLSWeGA==
X-Gm-Gg: ASbGnctYnuld9lxPyRXFDQs3FSXrPR0Y3HYzp476RsHh8crzdI6vy6IY40Qlvfdlyxz
	P2ZUCSUYpbxMIuvVKVhw/1GW/3CtFg3Mt
X-Google-Smtp-Source: AGHT+IG1/7GNikn+o7qWaeU6OlA3SHIeQqG6VzX6iFXwmrBOhF0bD/LXd61skcVAWua1i/pv/Z75jusfAxofKt3ImP8=
X-Received: by 2002:a05:6902:2e0e:b0:e39:9b9f:7f87 with SMTP id
 3f1490d57ef6-e399b9f830cmr6954354276.29.1733153086437; Mon, 02 Dec 2024
 07:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130094758.15553-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241130094758.15553-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:24:10 +0100
Message-ID: <CAPDyKFqiar=EKBHG=PHimjNcdLKsVdx+BRZReEJzHr8_qoayeg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop Bhupesh Sharma from maintainers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Bhupesh Sharma <bhupesh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 10:48, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> For more than a year all emails to Bhupesh Sharma's Linaro emails bounce
> and there were no updates to mailmap.  No reviews from Bhupesh, either,
> so change the maintainer to Bjorn and Konrad (Qualcomm SoC maintainers).
>
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I have queued this up via my mmc tree for next. If anyone has
objections to that and wants to funnel this via another tree, please
let me know!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml         | 3 ++-
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml           | 3 ++-
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml         | 3 ++-
>  .../devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml        | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index c09be97434ac..62310add2e44 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm crypto engine driver
>
>  maintainers:
> -  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konradybcio@kernel.org>
>
>  description:
>    This document defines the binding for the QCE crypto
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 8b393e26e025..eed9063e9bb3 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm SDHCI controller (sdhci-msm)
>
>  maintainers:
> -  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konradybcio@kernel.org>
>
>  description:
>    Secure Digital Host Controller Interface (SDHCI) present on
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 0bcd593a7bd0..f117471fb06f 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Ethernet ETHQOS device
>
>  maintainers:
> -  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konradybcio@kernel.org>
>
>  description:
>    dwmmac based Qualcomm ethernet devices which support Gigabit
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> index 758adb06c8dd..059cb87b4d6c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm SM6115 Peripheral Authentication Service
>
>  maintainers:
> -  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konradybcio@kernel.org>
>
>  description:
>    Qualcomm SM6115 SoC Peripheral Authentication Service loads and boots
> --
> 2.43.0
>
>

