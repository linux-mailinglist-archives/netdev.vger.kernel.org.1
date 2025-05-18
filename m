Return-Path: <netdev+bounces-191325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21FFABACF5
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 03:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802EA5803E7
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 01:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3D18C06;
	Sun, 18 May 2025 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diO+cg3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3004A33;
	Sun, 18 May 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747530514; cv=none; b=Drom3/YwjZPi3tmb4gog2gVsDkj/3ojEp+aqWLhrJTIR/FlSAsErZWmLzJLczTSq5trzodzU5M3lzY5V4akIwaHxAbQb8GRO0gJrYCFhTxYq+3PLSEazoCPy6nlXt4GxTGB4VaWv4RKszhx+oZunDM3ELExzKr184WUzLwc7akE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747530514; c=relaxed/simple;
	bh=GwzMihj6RTW9h1ZcvOwIXiwTx4wU5VdbSmUrMMRgz28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5cRXQMeKlkqg3MI9UFsZW+NwtXxUSXNRCtw5cTRhi/E29S1RyoWJa0z24Dm2+775/Tp+tJt51CN/2/GWjzx1LSeINW7uzDfQ3olLp+oiJx6a9mbMqhIInc7yxHCC3saQCsw7RnvA7/OiAVYfPsVykDK1IWjRWKEHHdlN6xA4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diO+cg3M; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so32254496d6.1;
        Sat, 17 May 2025 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747530511; x=1748135311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBoiEuNQUK+MG2DD2nIykSgb4W6tOdrktJLNBGrAb/Y=;
        b=diO+cg3M1n2MmM4wefmSH89XA2qCLYgAQlTUxIRdqKUIxuFv+LFIV/hvdB8qYn5C0z
         xdr9DxrFhmrn2i/jom4gBTNONOSQ9zrGv8JYAZXmBvW3cKmMPiyXifkFWHjrgmR+pirz
         OWm47PWCK8QSfGzNREt11tPVks46bIoHiHSQ4y53r7g1C5IvstppkIPUULr/QE56hHwc
         jfu67e3G4/xuitKIIoijGwxBgQBtjJ7QqNnrAIZKTgliaT+P12wWbp5pWs7twvIJo/H/
         YsG5rqPFDzw6IOcQF6lGiuT6QpDeHWMToEVADMZo9BRX+r80WfmqK01qnLiSD6DpAvYa
         dQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747530511; x=1748135311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBoiEuNQUK+MG2DD2nIykSgb4W6tOdrktJLNBGrAb/Y=;
        b=hpkInigim/SeKsfw6wNN1HssOpY+w8G1DgACwy3r2UPDCd7HuRqnZkFyvfOSAoUM7x
         I7Uf58dW+Ii5NrmcVX/0mOrGHGvCHhqV0vuuncUNnADRUzEKMaTpkmQ1kqmDh+UOEg9/
         r4XMHv+DUsNUMNMxbgatu6xeJzAIGSP1qZvgr/icjvL62WE9xDls5JUurZCCJIi8TKYA
         h3QuperNyU22b72zPRpib/T7IfbsnplYh8OkK1MalWJn82y4xzqPyemJfKts++C9zcLs
         7TQztB+diz4KcuPVAmzlDy+4sxM5rZcu2kRi3yz41tqhCloeoWJMLXNYaWKRnxHy59A2
         DOqg==
X-Forwarded-Encrypted: i=1; AJvYcCUMzxweb2qq0GMh+8rLAQyUSQ1Wu3DEy3z/RMZsp5+RiLfSpNtB4R0t2hNJg0oEfquuhpjUsf5NTrjUwSny@vger.kernel.org, AJvYcCVQgugNllT2LdSXgODMooRb0szoFv+tl9oEa8m1TS3cQ99zPdIjph+uUv/KZtPuZEPQAjVv9uWyAypU@vger.kernel.org, AJvYcCX7LF9Hb6H9+rL6UYX4bo+VSlMV60kPfrFBSwjhu05lbMp43c8vnT6fgTY8+o29c7PPCRsEXTzy@vger.kernel.org
X-Gm-Message-State: AOJu0YywVnikGMhnhmhHVKvk9Gdfr/KT8p8jfRg08kNP+ES6Zzf4BY43
	rWhISY2TOCut/xaKRUjWMZsweLBdexOo0vCJhUmuC26iGaPyeu+DVUXf
X-Gm-Gg: ASbGncsR1vr3AHkp2mBM1Ktu0rcA9E5JbPghQBBZJyMVA5lPYP5NMprs5/qNRgjdaTq
	INIbMcY81N0bJgxf3WsL4bHEm4lvdjm6pfKslE9ylBxutjXqErkNrJ7ccP5LNYhlDdBVU6tgAnQ
	gNBgxllcsAN2DdmtRcfs7aT5aNwEb/fRbPqbT9bxXJk1WFpAbItkKUsmOoUSdbx9JCEvAqwGoth
	JCLhl76/vIaAVTkNe6lpI2fLGjtjhdvqRM7pTDIBd/lDd056bV/WAbC4QTWrmtHj8m+rwkKaxWj
	QQY9ZDwUQvcezzl6m2xdla44j/w=
X-Google-Smtp-Source: AGHT+IGWyPrDcYHqjCN3qtoNsW5iOSUZa13NaKXNbx7t9skbjcJsYPif4vqMZCd2++JUXSgynnt8yg==
X-Received: by 2002:a0c:f113:0:b0:6f8:b4aa:2a4c with SMTP id 6a1803df08f44-6f8b4aa47f5mr74616576d6.14.1747530511141;
        Sat, 17 May 2025 18:08:31 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468b6a53sm335710785a.67.2025.05.17.18.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 18:08:30 -0700 (PDT)
Date: Sun, 18 May 2025 09:07:55 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	p.zabel@pengutronix.de, yong.liang.choong@linux.intel.com, rmk+kernel@armlinux.org.uk, 
	jszhang@kernel.org, inochiama@gmail.com, jan.petrous@oss.nxp.com, 
	dfustini@tenstorrent.com, 0x1207@gmail.com, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	lizhi2@eswincomputing.com
Subject: Re: [PATCH v1 1/2] ethernet: eswin: Document for eic7700 SoC
Message-ID: <mqf33f6bd6w7ozklh7igpa7ybgzuicqfxrbokvdcvcofwayffx@i6g5mqebahif>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
 <20250516011040.801-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516011040.801-1-weishangjuan@eswincomputing.com>

On Fri, May 16, 2025 at 09:10:38AM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting
> multi-rate (10M/100M/1G) auto-negotiation, PHY LED configuration,
> clock/reset control, and AXI bus parameter optimization.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> ---
>  .../bindings/net/eswin,eic7700-eth.yaml       | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> new file mode 100644
> index 000000000000..6cb9c109c036
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SOC Eth Controller
> +
> +maintainers:
> +  - Shuang Liang <liangshuang@eswincomputing.com>
> +  - Zhi Li <lizhi2@eswincomputing.com>
> +  - Shangjuan Wei <weishangjuan@eswincomputing.com>
> +
> +description: |
> +  The eth controller registers are part of the syscrg block on
> +  the EIC7700 SoC.
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-qos-eth

Please set the related dwmac version as basic compatible,
it should be something like snps,dwmac-xxx.

> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Base address and size
> +      - description: Extension region (optional)
> +
> +  interrupt-names:
> +    const: macirq
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [mii, gmii, rgmii, rmii, sgmii]
> +
> +  id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Controller instance ID
> +

> +  clocks:
> +    minItems: 3
> +    maxItems: 7
> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: app
> +      - const: stmmaceth
> +      - const: tx
> +      - const: slave_bus
> +      - const: master_bus
> +      - const: ptp_ref
> +      - const: phy_ref_clk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: ethrst

Please refer to snps,dwmac.yaml and set a matching name.
This applies to all properties with snp prefix.

> +
> +  dma-noncoherent: true
> +
> +  # Custom properties
> +  eswin,hsp_sp_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: HSP SP control registers
> +
> +  eswin,syscrg_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: System clock registers
> +
> +  eswin,dly_hsp_reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: HSP delay control registers
> +
> +  snps,axi-config:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: AXI bus configuration
> +
> +  stmmac-axi-config:
> +    type: object
> +    unevaluatedProperties: false
> +    properties:
> +      snps,lpi_en:
> +        type: boolean
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: Low Power Interface enable flag (true/false)
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-names
> +  - interrupts
> +  - phy-mode
> +  - id
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - eswin,hsp_sp_csr
> +  - eswin,syscrg_csr
> +  - eswin,dly_hsp_reg
> +  - snps,axi-config
> +  - snps,blen
> +  - snps,rd_osr_lmt
> +  - snps,wr_osr_lmt
> +  - snps,lpi_en
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gmac0: ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth";
> +        reg = <0x0 0x50400000 0x0 0x10000>;
> +        interrupt-parent = <&plic>;
> +        interrupt-names = "macirq";
> +        interrupts = <61>;
> +        phy-mode = "rgmii";
> +        id = <0>;
> +        status = "disabled";
> +        clocks = <&clock 550>,
> +                 <&clock 551>,
> +                 <&clock 552>;
> +        clock-names = "app", "stmmaceth", "tx";
> +        resets = <&reset 0x07 (1 << 26)>;
> +        reset-names = "ethrst";
> +        dma-noncoherent;
> +        eswin,hsp_sp_csr = <&hsp_sp_csr 0x1030 0x100 0x108>;
> +        eswin,syscrg_csr = <&sys_crg 0x148 0x14c>;
> +        eswin,dly_hsp_reg = <0x114 0x118 0x11c>;
> +        snps,axi-config = <&stmmac_axi_setup>;
> +        stmmac_axi_setup: stmmac-axi-config {
> +            snps,blen = <0 0 0 0 16 8 4>;
> +            snps,rd_osr_lmt = <2>;
> +            snps,wr_osr_lmt = <2>;
> +            snps,lpi_en;
> +        };
> +    };
> -- 
> 2.17.1
> 

