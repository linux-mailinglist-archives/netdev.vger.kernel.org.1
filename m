Return-Path: <netdev+bounces-229849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7F2BE1589
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C36C40547C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139FB1CAA7B;
	Thu, 16 Oct 2025 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtlwUP7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1231EDA03
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584749; cv=none; b=V6vI5FcudEp/rbe2/ERHHe3qDlTf0aPcnRK1dd80W1qMcitMUGtNYZ+AJ5tnV3yWYBUbcML3LD02menMA2z4r4cP6CMjyzAdcp4UX9huyKdZPtI+HXl5Aw+gZegdrW9i71JgApM5DjcmgTMrvpQBa079Z57rLrNo84MCvTbwV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584749; c=relaxed/simple;
	bh=xT2k+Zpg25JGlJX2w+20IfeaxqO3R5uygvQ7VMsc7Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sr3BIe1FZOQpYrcb/PkT7CCtN00KiTwqem07Vs2dOHykoRIL0DYEkOQ38zfPDizkJX/LvDWK3t8EmFLdC0UGeav3KAv0DBuphO+yryPGFIZ0lTaxMSpcv6L7LvJLfQTJl1Ftd5rVNqXWr8V7fUEPDoyKdrGBQrMVOvm69gLoNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtlwUP7L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f898fso3966495ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760584746; x=1761189546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3V6/3lwtdjURh/3v4+zxQ+JkOqta8pLIKsB7qZtosM=;
        b=YtlwUP7L//xKWtfNi1b2URdxksvcHIp+509EBPS5pC1RdYwQM7vZWip+CVHz8u1X1w
         1p2TxVyHkMae1NiNrDc6NWU4rqvudGNMAGGuMnuw1wAMNtbIMVuReX6L7Btua6gULuMp
         8a27QQuwltF/Z0ililba6kAbHk+IsUGOFBS0b/mGJChiuxJeUmJecvyrOn8QtF5OJ6K1
         xq4gXHHfocZTHsRnM9NL7z2D4CJJviLY6yDBYSUf/zTJRCpvOkbRFAVHUv9I1Pm/8EoC
         vzCCamx332wmJveR/qcMXW4RoHLkWwA7XndLNIzGEorrKfHNU35oL6gTgr8AQPTsHAZt
         xWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760584746; x=1761189546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3V6/3lwtdjURh/3v4+zxQ+JkOqta8pLIKsB7qZtosM=;
        b=raSo+zxrt3iaZdX/A1d3zZpLGQPpgQcGrOh2Mpqv+DoUMYsOXb/2I4or8T+5zOtvRD
         yue9tKtwbBGLwJn+hNIK79uKs6e7Hb/EHPvPagXZkEoZrCIGU5GF1Ew1JwH/ANdQIBdq
         Kvn11LqWojoYelBDMZ4+RFgn/UvxD+jH9lpzo3nwseAq2yM7xZRwoMcd3tGwi7aACJVL
         7mDKCK5lKB0Z5rpazNFlFEz0v/TxvVR0Rg3pcLoKT81rcsXh8ZO7zNnPpCGHgVzySXoV
         mgWLxPzOD8B5ppGqGV//DL5HH7ngjVOj9bI9I2eOvK+82RcCrNbde0PVxN4TJPpftkhJ
         909w==
X-Forwarded-Encrypted: i=1; AJvYcCXaTRE08NFnDdyrLnqXGKpU5yvH80EQj7DbX7k9sqPkZlqu+4g15+ivMa5921JbTr3udb8RkdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqNuDdAN27Vt9MWWeDTU4S7CGHEB9KqYcZf0gsMVGHZhOIeYP
	h/PWS7hjW7XgM+JXKQK90uHL1xZpOA8GvoGmdVdsbZH+1eGjSl9RKkyI
X-Gm-Gg: ASbGncuBFLK5PpEhrcErpmmfR92I8tYK7cTqZv18PKGCNU+a3ugOMsmgUL9YS+Z0+c6
	iub9HFvXJz6s8H0t2WeTTNpgwt5SrU1hHQbodmKjIzJT72kEp+/VJU+FTaCKQ77ONY+445yh2uV
	vqeA1ufN3EY+eVdLC2D0QEo47P+C9x1XaaBXRGrA2pBvgpj8wqn5wjM9xlhovir+7Yxq1ewJKok
	UKrCAqYqfPsyAFapeLzIlTUNEDYv45d7H+7ON34HnImBSgdCGWTvrfDXJfR8u0qFUI+I1SdJt2K
	ZO08xLpiYFx86jxQ8TGyFyzkTbgZ72HUymFxEnDq6iOO+hMQ6VZVz5gxUPw1z58Fg/QekPhFVnI
	zHkNTCgksXWUoOexgNQ72TpI8hmqkwGXtK2EF+p6yuSQNAe8J+FVigST0PXaWVYRRks6LxjjPLt
	zsJZ6Ep/kRwda3
X-Google-Smtp-Source: AGHT+IF4v2d27Dj/e7jq1kEU9oe1rwtYs2LQ1lRSZOTT/iIRfUfi40YveMA9WdkCLpBc1j1xOkHApQ==
X-Received: by 2002:a17:903:b4f:b0:288:e2ec:edfd with SMTP id d9443c01a7336-290272154a4mr369206485ad.10.1760584746390;
        Wed, 15 Oct 2025 20:19:06 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab9c0fsm11872355ad.82.2025.10.15.20.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 20:19:05 -0700 (PDT)
Message-ID: <227c0045-1e6c-4b2e-93d5-263213a7ff39@gmail.com>
Date: Wed, 15 Oct 2025 20:17:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: ethernet: eswin: Document for EIC7700
 SoC
To: weishangjuan@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jan.petrous@oss.nxp.com,
 inochiama@gmail.com, jszhang@kernel.org, 0x1207@gmail.com,
 boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Xuyang Dong <dongxuyang@eswincomputing.com>
References: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
 <20251015114041.1166-1-weishangjuan@eswincomputing.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251015114041.1166-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zhi, ShangJuan,


On 10/15/25 04:40, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting clock
> configuration, delay adjustment and speed adaptive functions.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/net/eswin,eic7700-eth.yaml       | 127 ++++++++++++++++++
>   1 file changed, 127 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> new file mode 100644
> index 000000000000..9ddbfe219ae2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -0,0 +1,127 @@
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
> +description:
> +  Platform glue layer implementation for STMMAC Ethernet driver.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - eswin,eic7700-qos-eth
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: eswin,eic7700-qos-eth
> +      - const: snps,dwmac-5.20
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: macirq
> +
> +  clocks:
> +    items:
> +      - description: AXI clock
> +      - description: Configuration clock
> +      - description: GMAC main clock
> +      - description: Tx clock
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: cfg
> +      - const: stmmaceth
> +      - const: tx
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: stmmaceth
> +
> +  rx-internal-delay-ps:
> +    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +
> +  tx-internal-delay-ps:
> +    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +
> +  eswin,hsp-sp-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: Phandle to HSP(High-Speed Peripheral) device
> +      - description: Offset of phy control register for internal
> +                     or external clock selection
> +      - description: Offset of AXI clock controller Low-Power request
> +                     register
> +      - description: Offset of register controlling TX/RX clock delay
> +    description: |
> +      High-Speed Peripheral device needed to configure clock selection,
> +      clock low-power mode and clock delay.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-mode
> +  - resets
> +  - reset-names
> +  - rx-internal-delay-ps
> +  - tx-internal-delay-ps
> +  - eswin,hsp-sp-csr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
> +        reg = <0x50400000 0x10000>;
> +        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> +                <&d0_clock 193>;

Can you let me know which clock I should use for EIC7700 (HiFive P550), if
I apply this patchset on top of XuYang's v6 clock patchset? ref:
https://lore.kernel.org/all/20251009092029.140-1-dongxuyang@eswincomputing.com/
In your vendor kernel, you have EIC7700_CLK_HSP_ETH_[APP|CSR]_CLK, but in
the v6 clock patchset, I couldn't find them. Please help translate
<186> <171> <40> <193> to the macro of v6 clock patchset, so I can help
test it.

> +        clock-names = "axi", "cfg", "stmmaceth", "tx";> +        interrupt-parent = <&plic>;
> +        interrupts = <61>;
> +        interrupt-names = "macirq";
> +        phy-mode = "rgmii-id";
> +        phy-handle = <&phy0>;> +        resets = <&reset 95>;

For reset, I assume this <95> corresponds to EIC7700_RESET_HSP_ETH0_ARST,
if applying on top of the v7 reset patchset, correct? ref:
https://lore.kernel.org/all/20250930093132.2003-1-dongxuyang@eswincomputing.com/

> +        reset-names = "stmmaceth";
> +        rx-internal-delay-ps = <200>;
> +        tx-internal-delay-ps = <200>;
> +        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
> +        snps,axi-config = <&stmmac_axi_setup>;
> +        snps,aal;
> +        snps,fixed-burst;
> +        snps,tso;
> +        stmmac_axi_setup: stmmac-axi-config {
> +            snps,blen = <0 0 0 0 16 8 4>;
> +            snps,rd_osr_lmt = <2>;
> +            snps,wr_osr_lmt = <2>;
> +        };
> +    };
> --
> 2.17.1
> 

Bo

