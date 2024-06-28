Return-Path: <netdev+bounces-107571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F260C91B8F9
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7835B287AEF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2753143757;
	Fri, 28 Jun 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guuanbPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729C14373C
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561119; cv=none; b=YuL4+vRh4j9Mv4CmJjnE1+M0yJ2+Wm1vu6Wo1bFgo3+1ACC9bfBZOCBWSGYP2GMF4cU4UdTxjPtY1QDp0FBpA405nROdzDwLypkzCgAISFb9TjyTgzGZwqSZ7iY4Mup9KHrn1sp6iT1j9w2Lp+/jtvYQyMAK66lIR/ZXIyAyfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561119; c=relaxed/simple;
	bh=+zNoKDZQ/xkNOYt+gvFW7KoW2kO58MHXV4zEnjjIi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPBa1PxqWAnM+a29aE88XqQBOhor+B99YtLZ8v8b5H53EkOG6Nq4Jtei8yZF5FGs0CAnqVB8drI06yANYzdLr6UR6fluGwLBYh8QmvOtjRAAtjf6fYTmiKPdss7om7zKlrGF1WmVRPF1Qlh1SyRZ8j8WSBZ+vDvj1LtrOYhfhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guuanbPN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso3343571fa.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719561116; x=1720165916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0Lhq2VrmyZAPS9Zt2InQGHVgI0lvcCDAnX2v0350pI=;
        b=guuanbPNR6J5WDWsdVzl8oOjsY6WLCKit3kGz2fkU68Izj9qG913KpRsHfIK1gr21K
         GScGLeVZW+GwJGNIMBd3r1N9uBwzr7gPzGvmRT1K70Y65b1KaZkPFM4uTzT4B8xcML5O
         NL+Ju+k/PCZSdifUC32RQqeo2Xa5aro1LJyY2IvqqU/cfbgnXEzIO6IYv+ftStfNG8d4
         /ISNuLpghPxQZEhbQnbvkeoxgOQMExIUIgWGKFfAqzwa7ytIu4StdVxRD5hbwfzJvBkB
         EFQWUyqxryVdy+VfouXAMUoRASo1aZrE+LEqnABpdo1X8RPezE4R/Gz33+xOHMapPegv
         Hazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561116; x=1720165916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0Lhq2VrmyZAPS9Zt2InQGHVgI0lvcCDAnX2v0350pI=;
        b=jSIU3XU4nyEXU3SD9nm7pPxdmTC8THklNABr0BQMeCdvp8so4v0Od/eajkp5RYfsJR
         ID/5IoBXX9IlurqBAB+PiB2XxugnP8B10ZA/Paz1R4mFwG/8QJWh6Wy/L4nJ+8K4HkSB
         8U+TYiTosJkNRF2JGl/s1puy+4fH45k2WYBq+dVTK1RNTo4RuUiLC+v3O87B3nUeDydq
         xeQYj4Zv2cmDcQphBPalDncVqEwSd7N6Zqyc5YrYaT3Ak8n9WaJ2qgyKhQ11K04i+jSZ
         QRlxtAGMV8q5dcaZEvsn+stP0DbwkqnnCgXUY3zBnug4V1ZYhluFeZcRLg/a899RA9F+
         MMKg==
X-Forwarded-Encrypted: i=1; AJvYcCXSe+VTwEa+alQaS33Hlb+kjDnF8/Y/RAUh5LwpPeEQhS/l+IFD55JqZDwefxzhYF+SoJsKS806LKTTvL4wUpnTSVWxa4OA
X-Gm-Message-State: AOJu0YyqrdlOR30N9DaN6KyTRCHJxns8hOCSXnrLCaYT6r5BtLPWsug3
	7xxq5giexfYPBaeW5P82aKC0CVU+aLWv/eyUoMUzCvFGlDgtaMc7OM441obpoP0=
X-Google-Smtp-Source: AGHT+IH+g2S686TRu2qwo6Fx8tMGYY1LUnHUqaOm29KoLuznrr5f/PC/tBh0PHvmbSQVGbLqGcVTKQ==
X-Received: by 2002:a05:651c:1988:b0:2ec:637a:c212 with SMTP id 38308e7fff4ca-2ec637ac2b5mr108100831fa.39.1719561116558;
        Fri, 28 Jun 2024 00:51:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160d26dsm2123151fa.25.2024.06.28.00.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:51:56 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:51:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: manivannan.sadhasivam@linaro.org, loic.poulain@linaro.org, 
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net, quic_jhugo@quicinc.com, 
	netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <2xbnsvtzh23al43njugtqpihocyo5gtyuzu4wbd5gmizhs2utf@d2x2gxust3w5>
References: <20240628073605.1447218-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628073605.1447218-1-slark_xiao@163.com>

On Fri, Jun 28, 2024 at 03:36:05PM GMT, Slark Xiao wrote:
> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> And also, add firehose support since SDX72.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: (1). Update the edl file path and name (2). Set SDX72 support
> trigger edl mode by default
> v3: Divide into 2 parts for Foxconn sdx72 platform

Generic comment: please send all the patches using a single
git-send-email command. This way it will thread them properly, so that
they form a single patchseries in developers's mail clients. Or you can
just use 'b4' tool to manage and send the patchset.

> ---
>  drivers/bus/mhi/host/pci_generic.c | 43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 


-- 
With best wishes
Dmitry

