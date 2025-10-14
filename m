Return-Path: <netdev+bounces-229111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53551BD84C5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C813BCDBD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBFD2DE701;
	Tue, 14 Oct 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgaO6zD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752582D73BE
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432084; cv=none; b=MGfbYGufdCK8/h4ljpzeWz7GBavpn1ObtGxfU7tpnNtKI1UOnqCBXtTQ9PmcJlQMRROy1pOCIXlzhXecvyJz1bbUL1zzUYmCP5qSqaudWEYObc59JT/feL4l6pmilsL8jPp0bUBMD/LYK6l1S5qr+ZJOnuwvpVYt6At+Xr4g/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432084; c=relaxed/simple;
	bh=7x1ksEGRUIlN/JRIZWql+/rRJiRrxtl9r0MDlxoj8Co=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dYPEEVBmbYctDjqM22amnyY9yffuLNq9EIFv+I182/kzw2Oy3Ny2kfNa179djqKA5wnHlpVuj20eGy1pVk8/r8ef3p9qdolXcmHZhQj8WvqNvExhw41brUDXMWyqWodflTMGBGnfUJ0rgIEabZ+wpBN9op8VQR/3YryDPx/E8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgaO6zD7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782bfd0a977so4294028b3a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432082; x=1761036882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISi9f6KzQSpnphkygLBuAPANu77cvnhCFWLhBPhHgsY=;
        b=RgaO6zD7JIq0U1oTpkDVKzmcZUfv7rs1fKBnpjk22jmaEJeOhOopafaZAqyFnmyEhH
         AGRlxGAZ8oyhvit0nMn7qf4QrELfs4w6o3YMAIQYf5et4EmHgEJsDuJjZPk9vHVkR8Qq
         tDN4faYddijCXim041/EKruc2EiJuki368SkZLekMxUYssjkvzpt27/+xV07/CL4uk7J
         WpEILnCEl6K5rvoc+py9mTY2zYnWpddaSWY7n5/ge29ZQ+IMqVwNNYQnMzn4MWvIn96u
         ywCsstlWGSYIlKdYoEAWqPebmtROZ9qYtKHsPwDynY+c6XMIw411qIDc982ytjKffXQo
         hbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432082; x=1761036882;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISi9f6KzQSpnphkygLBuAPANu77cvnhCFWLhBPhHgsY=;
        b=B5ksWCAUn6XzaB3Irw4Vr4y/nplyI08vw5baKGo3X1bImnwaGvnf+BmDRI+a0MWIN6
         kRh+uRAQPPBygCuQ14zfJwhbUWgEhC8H5GwtiJ6CcCvSWUJtNhYwMpYfjTQK2nddKf5w
         Z9TOqmdwq5U7mQ9SyqVgnXxwrWbRChcL/otcjZg2tmzekom+oPSY0K+0oO4y+rc/6usv
         rDLxT7HD5wZwEwJR78/rrffuiGr1sqaWc3AeJONS3QEicbaLyfpQVD1Pe8lFoxmFsJm9
         /pSmIpjxDdlDYZFHxIGBmkbzzt/DehkYyepWhN3I9aMLXz3rfMYS7NPt+MIhxQzsizvi
         XgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXanprWtAK5yOCidrMuc6aSXKPgeIf3uKg97E+ZgxXTIm4q5IF7b0jLVDaXV2IpGTCmFsrmHtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFcJ0phY3FpfI+NzelHCOq5HIGQcDK/4QO2va2dNuHeKLuA3S
	eRqn/lPzLjtgTxAlnz81CLCxMEKdDa5rdlWJkZ5DY11RyN9yzE0//lfE
X-Gm-Gg: ASbGnctYHioZltkOxF4/KUiE8TcmotzjVeum4ajNDymj9vMdhs5GHe+KuwLM8rf5fDf
	pv5AUXwpZ26YKSEzKcDmUCZ6jwgLhPq+BgEW1Cq2yDWBv2BBrtoagsan6n41AP/ZSmdLE1g0PlG
	2H1c106Su/xB1KXKRSCYry0jmMCNetBvDQz0CzT46KwEwDFzUuQeQZd4ClH2GF/chkXuV+pIeQ9
	lrsl3IiIFIXzeTerzoQ1OsHvJzMQYnyIp87k7ck+aLwqcF1X/jya6jj1w6xxYwcUexqAGLbQ4ch
	/njovx3kFENTRoGwxri2+yWk3ewAj8IvRLy6mjjPwhUuP9WVplPNibuQRRYXumbmFXzOnlMs5gd
	0PI2yYByh1TatoKwtuKuvSIVnG2M8Ckeb6R+Iq470eUh9b6OM8y32FA==
X-Google-Smtp-Source: AGHT+IGqTpN25zTj2NoGAGnl9jeNvvTw7CBNIuJy1oxy3KZR2C7Ji/G8drrYLcEK31MzNn+ZS3y/Fg==
X-Received: by 2002:a05:6a00:4fd3:b0:776:12ea:c737 with SMTP id d2e1a72fcca58-79387e05323mr21822249b3a.23.1760432081535;
        Tue, 14 Oct 2025 01:54:41 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b66sm14499599b3a.8.2025.10.14.01.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:54:41 -0700 (PDT)
Message-ID: <8226884b-96f9-483e-bcee-466ff3e04b23@gmail.com>
Date: Tue, 14 Oct 2025 01:53:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bo Gan <ganboing@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: ethernet: eswin: Document for EIC7700
 SoC
To: weishangjuan@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
 anthony.l.nguyen@intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jan.petrous@oss.nxp.com, jszhang@kernel.org, inochiama@gmail.com,
 0x1207@gmail.com, boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918085903.3228-1-weishangjuan@eswincomputing.com>
Content-Language: en-US
In-Reply-To: <20250918085903.3228-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 01:59, weishangjuan@eswincomputing.com wrote:
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
> index 000000000000..57d6d0efc126
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
> +        clock-names = "axi", "cfg", "stmmaceth", "tx";
> +        interrupt-parent = <&plic>;
> +        interrupts = <61>;
> +        interrupt-names = "macirq";
> +        phy-mode = "rgmii-id";
> +        phy-handle = <&phy0>;
> +        resets = <&reset 95>;
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
> \ No newline at end of file
> --
> 2.17.1
> 

Hi ShangJuan,

I'm active user of HiFive p550. I'd like to test out this driver. Do you have
the device tree section of phy0 for Hifive p550 board? Or it's optional for
p550 board and I can just provide an empty &phy0 node? Regarding hsp_sp_csr
node, I should be able to use
https://github.com/sifiveinc/riscv-linux/blob/b4a753400e624a0eba3ec475fba2866dd7efb767/arch/riscv/boot/dts/eswin/eic7700.dtsi#L167
correct?

Bo

