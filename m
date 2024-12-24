Return-Path: <netdev+bounces-154136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F69FB920
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 05:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A67165BAC
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 04:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78412C499;
	Tue, 24 Dec 2024 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQcM7Z0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2E1392
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013822; cv=none; b=fmLhiR7LlwJ/evQ6NR8LeASejgEj3MAxMmS48TH3Hpcci5e1jGk3RmkbT3LCGUoVkTzpEPdxmy2FnowZLZvJat/9ioAStxKvR9ouinvpVDsVD5Ti54lXuZLfz+gSoRV984l20Z3m6030nAoMZZRHTg3mtL1t3eTVpMjtjXUrG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013822; c=relaxed/simple;
	bh=oIie33HXjEdQse5G0/GhL59JqBHGqG/Osu83u0kXaIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH0LtT9MwPhPjGR554ZCSj4PQYiaXlbJYFfAdKaciq3RTzOcp80GpfuxpJvPq8Egfe1kG1OmzukhrT12EsfnxIXqTnabXGYUSR3NZsnrHNKFWE9MtkCOu6Mu5NshoZiR/WPKroMStPnnt3iG4c7YJgGmuMqRfmgxlODHtwUThRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQcM7Z0R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df80eeeedso4849817e87.2
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735013818; x=1735618618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBqVAasc5aaOLoOz1GUhccnE1y4WdkWmYtGpXlXBdiM=;
        b=vQcM7Z0R+Ht5qSL8zOpmGaJMwzjHbWEzawfMsCOWA03IHeLdMv03MFb/KAoy7yotdf
         gEcIn6pxZTfwSNqrjuZm01kj8dBj/ThS+WYgCz75bhAD5MBUr3GKXmItaKHmi0W6ILAf
         5uJS0vqnl9z8WrGssVI9Bi5hQfHL4NfElE66/ImnnVkq4lZKcZeez0Pt1Bcljk9wZZf/
         tOw53EgtbCdDPvBRSJ2SFZ1IfFgw6MIX11dr2Ibd7uNSEFp27QexaldLVVeyCZja0sTc
         tz24ry/UtF2jzmsrpDn6A97c5jyh6CJKRy104baAAXL1heyu7NCosbDPlaN6yeXYW1Z2
         M8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735013818; x=1735618618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBqVAasc5aaOLoOz1GUhccnE1y4WdkWmYtGpXlXBdiM=;
        b=e5cLNxhxKw2SNf8/wHEgabTWXppu8YJs75s/AoKpCoSke+WpRJDQDALyP5NS50z7Ep
         2wuQrbCOplPGOikLyg46wDVEiTV93bo0ZCyb07o5K0bKOjCaG95Zq2cYApYl1v2ncMCF
         Wr65Hhi//w16y8rEX1BvPgfHFRtMMNmXggvwr2++ORpcuTwunFs5M4ecdZZPh3wpPLcG
         Omi29cdNVKCWY3V+l6V4XJxMKskmAyrrFU2ONsG7PJk9GRYOsE2F1qpVqDyISiZcNryM
         E9bAbhZBX8I+5oBJIUJ97Oz05y/dOVvIUFVF1pM/8cOMzX57xwlX9W+3TVrdgtt5w9Fb
         CmFg==
X-Forwarded-Encrypted: i=1; AJvYcCWLOD+Z0i/U/SHPxwKxhpJzxJtBCY2wCu81MJ+rqXBEF0vSqjqVkHeYgu+gLuwEH4SyEZ4OHRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynuIf5uNaiG3WIPGQEUJ13zJxOYU/q2vuDdwvCP0v83gtbZdf
	WpeNQ4XLCR1BpfWb3u2coC/RriIYKtjQGbul5stdTas7I5LpBtabDVcVcqlwtZQ=
X-Gm-Gg: ASbGncuSOaB8CKaamcD+Gx7xECuHKLLJrRo9TVTOohEOF1reMV6B78P/6ezXHA0vtir
	956PwKkRZHuaaw6EeUS+lHaPSdkYmn5Q7CjEd+ekUty8KPKk90wmjLZ+5ojLifDTa+lDWuyAnWL
	wUixtXsaFJDrwjFNV+YD/SoHe9a6ioAeqG5XMr1KIIkyXVkoEziAT9/wF5bBxAlGpGi8d6ksiS9
	ehBLzM3i8cbbuYD8Kvvvqi+QKPLFmbPdSu+NKa6Suiut281s3D0w5QwnUYG7W1TiZbONMig2mfs
	XMzhtdqBnoXaq2k60uvhU1zUxYN6LUrqM3HR
X-Google-Smtp-Source: AGHT+IHMGmYGMF6q2MDHua7nxv0GhA7FnjWIVG2kKpKZJ4CxXoTwmdLNVjxPUwAUj8j/ub8sXpIJFg==
X-Received: by 2002:ac2:4c48:0:b0:540:3579:f38f with SMTP id 2adb3069b0e04-542295821afmr5451612e87.37.1735013818146;
        Mon, 23 Dec 2024 20:16:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238214b5sm1486186e87.187.2024.12.23.20.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 20:16:56 -0800 (PST)
Date: Tue, 24 Dec 2024 06:16:54 +0200
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
Subject: Re: [PATCH v2 0/3] Add standalone ethernet MAC entries for qcs615
Message-ID: <t7q7szqjd475kao2bp6lzfrgbueq3niy5lonkfvbcotz5heepi@tqdiiwalhgtg>
References: <20241224-schema-v2-0-000ea9044c49@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-schema-v2-0-000ea9044c49@quicinc.com>

On Tue, Dec 24, 2024 at 11:07:00AM +0800, Yijie Yang wrote:
> Add separate EMAC entries for qcs615 since its core version is 2.3.1,
> compared to sm8150's 2.1.2.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
> Changes in v2:
> - Update the subject for the first patch.
> - Link to v1: https://lore.kernel.org/r/20241118-schema-v1-0-11b7c1583c0c@quicinc.com
> 
> ---
> Yijie Yang (3):
>       dt-bindings: net: qcom,ethqos: Drop fallback compatible for qcom,qcs615-ethqos
>       dt-bindings: net: snps,dwmac: add description for qcs615
>       net: stmmac: dwmac-qcom-ethqos: add support for EMAC on qcs615 platforms
> 
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml  |  5 +----
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml   |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 4 deletions(-)
> ---
> base-commit: 3664e6c4f4d07fa51834cd59d94b42b7f803e79b

Which commit is it? I can't find it in linux-next

> change-id: 20241111-schema-7915779020f5
> 
> Best regards,
> -- 
> Yijie Yang <quic_yijiyang@quicinc.com>
> 

-- 
With best wishes
Dmitry

