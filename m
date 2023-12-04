Return-Path: <netdev+bounces-53623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78364803F20
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1279B20ABF
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D733CF3;
	Mon,  4 Dec 2023 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQds8Gu9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F56D2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701720977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scE6uJE/gsl0ExlvPlw1tvZXL0nwbCHoC6Ch9ngDrG8=;
	b=KQds8Gu9MN9fs665098G4bgXmbejxlRdEzdisgH4g/5hRlycImVcD7QdJRe6HH9qFxKPQh
	tT+WMUy6oLyLhdwSqMOsiZPd8pTjTgrd/cxUoVuI1qAvhYh+CuC5pnOpKHEpuC+X7YTUwJ
	+5+VB8QOJl9jI33hcWDrbOqyp+No5zs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-r-lXMjtxMQaIISc5z7pW4w-1; Mon, 04 Dec 2023 15:16:15 -0500
X-MC-Unique: r-lXMjtxMQaIISc5z7pW4w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67aa5d15846so19510766d6.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720975; x=1702325775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scE6uJE/gsl0ExlvPlw1tvZXL0nwbCHoC6Ch9ngDrG8=;
        b=fU/mxacbxDIu7uG6akVlZds1JAHE4lWPsyThygu3Hc1F2gZhK77hH7kDJuAO+ejhUa
         VWvYJEpm4AD/I24zR04sNIS2at3pXld8O6MNcBENdhniSeKNuXMYPQz/t1ikCnESHVzI
         FB9s2Q1ZVQ6TbUtvU6+dm0u0VqDwIUoOUaCOOUno4sWv38tKUnqyf86lZVBI0cYMDL/3
         nbWxV9lQYex/lgYYFEqdXAW6xFpJTuIhRYEJOIEcWv0mfwIft6Z5p+oLLA3VKeCcKuO+
         7m0Axdof23JfIiQ76NUs+JGezdFzBkal0zzgX41ZChHBA+Jox+F87Rmd+IV++JZRjuse
         AvyQ==
X-Gm-Message-State: AOJu0Yyqh0rRpebc62hQLITI8YY8wMmsS7Fwek97Ad2Aju7Ia/5hmItT
	GJfol5bNvO/Z685EYqSW3KPUVlryzfFp2NKEptMullt+BdWALAqUpOrzYSiGNYP5gQGXT6xvYoN
	a8mxfKkxOx1W2+bRA
X-Received: by 2002:ad4:4481:0:b0:67a:a721:ec1a with SMTP id m1-20020ad44481000000b0067aa721ec1amr127132qvt.94.1701720975324;
        Mon, 04 Dec 2023 12:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgoVrFG6EC//oL2uzFysj4twtnTf+9h/+HjOZVaxTJrf07QpXYwOj+ja1iSEQZGrynxBr/Ig==
X-Received: by 2002:ad4:4481:0:b0:67a:a721:ec1a with SMTP id m1-20020ad44481000000b0067aa721ec1amr127121qvt.94.1701720975037;
        Mon, 04 Dec 2023 12:16:15 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id r3-20020a0cb283000000b00677fb735738sm4618230qve.34.2023.12.04.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:16:14 -0800 (PST)
Date: Mon, 4 Dec 2023 14:16:12 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v3 0/3] Ethernet DWMAC5 fault IRQ support
Message-ID: <rw5vfdvre5rt4rwytfsp3qy6sgsdr3dm6oefr4sap2aqbvpw42@c2dxz42tucby>
References: <cover.1701695218.git.quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701695218.git.quic_jsuraj@quicinc.com>

On Mon, Dec 04, 2023 at 06:56:14PM +0530, Suraj Jaiswal wrote:
> Add support to listen Ethernet HW safery IRQ. The safety IRQ will be

s/safery/safety/

> triggered for ECC, DPP, FSM error.
> 
> Changes since v3:

This is listed as v3 in the subject, but it should now be v4 since the
last version was v3.

> - Fix DT_CHECKER warning
> - use name safety for the IRQ.
>  
> 
> Suraj Jaiswal (3):
>   dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
>     sa8775p
>   arm64: dts: qcom: sa8775p: enable safety IRQ
>   net: stmmac: Add driver support for DWMAC5 safety IRQ Support
> 
>  .../devicetree/bindings/net/qcom,ethqos.yaml   |  9 ++++++---
>  .../devicetree/bindings/net/snps,dwmac.yaml    |  5 +++--
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi          | 10 ++++++----
>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
>  7 files changed, 45 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 


