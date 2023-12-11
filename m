Return-Path: <netdev+bounces-55894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99180CB7C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B7E281F4F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79B47787;
	Mon, 11 Dec 2023 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDebUDFF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831710DA
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702302762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAKJhgDZFjppnOq8yVAY97GiR5RWWlY/Hz8yw7/jdJE=;
	b=SDebUDFFBnLqU5rnsO1DODWgnERbu6YQVOIalE6LKSOLXlEVuxNBNgAFhw2J9WV1Ml8yIU
	jVCcY/TT0jG+qb9pPuFW6oj4RA2nlkM7rTB7iR+ZCv7JeYlzEll2OJx4+sx4zBPqbGxSGz
	Pf2YfNnI7ADwnHXmRh2LGEwl5ZaqWAo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-VVvXWqwYOC-qzjAy_b8l-w-1; Mon, 11 Dec 2023 08:52:41 -0500
X-MC-Unique: VVvXWqwYOC-qzjAy_b8l-w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a940dcd1aso63738786d6.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302761; x=1702907561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAKJhgDZFjppnOq8yVAY97GiR5RWWlY/Hz8yw7/jdJE=;
        b=QDrcwiIE26VOT/Y7g6jpelB1QCJnnpiQVhoCMh4q46GCOsfiCSbvPF3DG1BXtPGml5
         AuCSdSArde6KYqyeBSSYSToz0WIirW2JT+MHG+US6NmlToD9BqLY862V6iaKgZ7/iQ3N
         yD0m4ltN6iYAS5tQFA5cMrVLEEaFI1PVPfVheeL4Y6NxFMb5Pu6XT5gLTasAqvzFXVjt
         69EwTNYNSyM9DEONIh31NPgI2Y4puOwhGG7lGPrpDaEcCHprUCcb6aJF4S8S8MnA5htn
         LV1NDuo0tNGRIyX8nk3Nx9m0taINeixQqvgvWqTxjrhKxRutJW3dahTa2L/xDWJaC6ON
         xv+g==
X-Gm-Message-State: AOJu0Yzz+0WkM8MjUTtdZazugO6v1pdAJ160YsP5FA0nCRmE6ziE5AOr
	1CN6IwcUvh9iHvJlVJNe2ZT93JZv3qmxwmuOYmkBhy4KLZhaqcIWB0tNk2cVxc0n/4JJ1a4OqAq
	8u7R3q1HJNn3qNgqi
X-Received: by 2002:ad4:452a:0:b0:67a:5887:b55d with SMTP id l10-20020ad4452a000000b0067a5887b55dmr4932130qvu.49.1702302760907;
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzx/nt6T6DLUCU49cSJD+NhxTBsGn6eVt/zPBsL7ZgqtW6sJsBZ5K+Q5WGQkXV6vBLIadoeg==
X-Received: by 2002:ad4:452a:0:b0:67a:5887:b55d with SMTP id l10-20020ad4452a000000b0067a5887b55dmr4932121qvu.49.1702302760605;
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id tc6-20020a05620a2cc600b0077db614cb7fsm2936968qkn.8.2023.12.11.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:52:40 -0800 (PST)
Date: Mon, 11 Dec 2023 07:52:37 -0600
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
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
Message-ID: <2ihncgvnfxgzj5kfm3eedvj3jvru7fokpno5pdzgtnuuy2mpqf@sfuzuugeuxzh>
References: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
 <20231211080153.3005122-2-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211080153.3005122-2-quic_jsuraj@quicinc.com>

On Mon, Dec 11, 2023 at 01:31:51PM +0530, Suraj Jaiswal wrote:
> Add binding doc for safety IRQ. The safety IRQ will be
> triggered for ECC(error correction code), DPP(data path
> parity), FSM(finite state machine) error.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>

Rob gave you his Reviewed-by over here on the last revision:

    https://lore.kernel.org/netdev/170206782161.2661547.16311911491075108498.robh@kernel.org/

in the future if someone gives you a tag you should add it to the patch
for the next revision you send out (assuming you have to send out
another version, otherwise the maintainers will collect the tags when
they merge that version of the series). If the patches change a lot then
it makes sense to remove the tag since it wasn't what they reviewed, but
in this case you've only expanded a comment in the commit message so it is
appropriate to be present.

> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 7bdb412a0185..93d21389e518 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -37,12 +37,14 @@ properties:
>      items:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt that occurs when Rx exits the LPI state
> +      - description: The interrupt that occurs when HW safety error triggered
>  
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: macirq
> -      - const: eth_lpi
> +      - enum: [eth_lpi, safety]
> +      - const: safety
>  
>    clocks:
>      maxItems: 4
> @@ -89,8 +91,9 @@ examples:
>                 <&gcc GCC_ETH_PTP_CLK>,
>                 <&gcc GCC_ETH_RGMII_CLK>;
>        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> -                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -      interrupt-names = "macirq", "eth_lpi";
> +                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "macirq", "eth_lpi", "safety";
>  
>        rx-fifo-depth = <4096>;
>        tx-fifo-depth = <4096>;
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..3b46d69ea97d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -107,13 +107,15 @@ properties:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet detection
>        - description: The interrupt that occurs when Rx exits the LPI state
> +      - description: The interrupt that occurs when HW safety error triggered
>  
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: macirq
> -      - enum: [eth_wake_irq, eth_lpi]
> -      - const: eth_lpi
> +      - enum: [eth_wake_irq, eth_lpi, safety]
> +      - enum: [eth_wake_irq, eth_lpi, safety]
> +      - enum: [eth_wake_irq, eth_lpi, safety]
>  
>    clocks:
>      minItems: 1
> -- 
> 2.25.1
> 


