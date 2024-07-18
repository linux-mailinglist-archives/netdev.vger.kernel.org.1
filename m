Return-Path: <netdev+bounces-112131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8993528E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9A282D67
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FF145346;
	Thu, 18 Jul 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4XVzMaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15514389A
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336260; cv=none; b=B4wxQ0Gp0sdoqVhcTzU5mKtMYYHFTtKN/w6fwBcdUGGcWlPxBBFZLumJoDigvPqD4WrWhpB3F4yNdtJAYjOZ/iN3UxuHmc/qllwRrjhoLPdCVub40tOMujr+xDPmznyIVOf1CnOH9ICHPXhUWL/eo9uMsiuLIJ+oYdtX+8sernk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336260; c=relaxed/simple;
	bh=tAbWfIQ4v/HuPHVEJge1CzK9VejlF4IPKDtclv3TUFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZb+GgqocvKtafg189ADaF9R+r2CugYxu+IU1y+7QAi5+LW2Jul/Z9vmge7DP6szgemf4GzyuGrBuPqkqhJkpAu56A+w+ap8ov2IYpoXc6B4HC5myv9GUKbm5OSbjFyot21H6nfGPpwC3RlX3iO5+UwoXdtzfMLjn6AEcoQ07ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4XVzMaf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so24301281fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721336257; x=1721941057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt4qMEVwM35lFX7t2weYvu2/XW9ujOBzqearuBlFYJA=;
        b=y4XVzMaftnfDmsaFWC/eRYFOQlpYCVih7cFAF/CzvCNJ3v36njPSVyMvo9FvF1T8ar
         cMKEhO483mkwIjssRRHobgutyOHboFlE3jNIqk4XE9U/qzmYZbAG0iqrLeQBtXPNEhyd
         lbsfnx8ZsETqA1lZvAqsBxS6+G+vRXyfPxx3PI7D+cXnCd4MsADerlM0nw8C9Azipv1L
         /WnnQe+OBHtzypMYileVh8ciAGebHhW4Ypo9oLMKox7ABLYexmsgLHVCggXI/J3mcsLf
         8uR2qfgYGeNG9IMFpjm8a+44zQhBKs4ebZWM+XUqNLvlibA1YDVGij1sG84OECnDuToh
         nuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336257; x=1721941057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt4qMEVwM35lFX7t2weYvu2/XW9ujOBzqearuBlFYJA=;
        b=GQs5TcNqdbiiRBNei7vQt3f++x/aRKrguuT68PXqt5Z5ljohsjDRft9vWaGXc2ZVMB
         6gKLdrnbdV8eIRBcMhvCI+FTOkNc2pN5O/Fc9VRCNZbIcUjW2P8iCLDIVDCiiXKPavbR
         hTKjAiKLi9m0NVgcWFG3fmPYg5BmGdtou8wkk2DAMWF5ARBnAMquqHBwkStIsgNxPthY
         VF/jOML7GEg10vJvsl8FWWkv5E6rkguC4R8vj1GHPxExSEfqEKX6byI0G4ZwBbl1nzw6
         hzPRFJ9ZzrSr3iABNIPX/OFl3aJpm6Tsdv9clb1vZW4WihsUB+/5o+g67apdk8Vtawqx
         WJQg==
X-Forwarded-Encrypted: i=1; AJvYcCWA+lVO8hQTLwkR86NWSMoiksTujGCwSEijr3f/PYIB4OcD5IJ97ZcMoF5V/dvtcEFLsm88hQYxaRESyTZ7rw6FhLy9ZV3e
X-Gm-Message-State: AOJu0YxXdkCHd0la3NldW9lqtQiMI0xJDBXBDYn5tpyUBhO3YxxuNNXQ
	I7en55ygOC78Gd3Qlwq6KXjeIhJdTE3+3iq0QYWsJM8swAfAZfRHgIZ08zuoaMM=
X-Google-Smtp-Source: AGHT+IFOEhmrc8/7gP/gyY2lxQaJjz0l0DPkZEGt1Jaui5UPWhGGxU9XXD2bP5LA9cGX048zWkpoOA==
X-Received: by 2002:a05:6512:10c2:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-52ee5453fd4mr6044046e87.55.1721336257180;
        Thu, 18 Jul 2024 13:57:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef07a044dsm196680e87.285.2024.07.18.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:57:36 -0700 (PDT)
Date: Thu, 18 Jul 2024 23:57:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Patrick Wildt <patrick@blueri.se>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Steev Klimaszewski <steev@kali.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi
 calibration variant
Message-ID: <gb5ykva2z2kkn4w4xnpbpkfthglifkygsbwplmqmd53hlxpqlg@gv7qknl3uuob>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>

On Thu, Jul 18, 2024 at 07:40:13AM GMT, Jeff Johnson wrote:
> On 7/15/2024 12:38 PM, Patrick Wildt wrote:
> > This series adds the missing calibration variant devicetree property
> > which is needed to load the calibration data and use the ath12k wifi
> > on the Lenovo Yoga Slim 7x.
> > 
> > Patrick Wildt (2):
> >   dt-bindings: net: wireless: add ath12k pcie bindings
> >   arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
> > 
> >  .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
> >  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
> >  3 files changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> > 
> 
> +ath12k mailing list.
> 
> Qualcomm expects, on x86 and Qualcomm-based ARM devices, that this information
> come from ACPI.

Unfortunately we can not use ACPI on Qualcomm-based ARM devices. They
all are manually converted to DT. 

> 
> That support is currently under review:
> https://lore.kernel.org/all/20240717111023.78798-1-quic_lingbok@quicinc.com/
> 
> /jeff

-- 
With best wishes
Dmitry

