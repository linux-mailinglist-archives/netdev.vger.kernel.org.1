Return-Path: <netdev+bounces-141203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351239BA08E
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93511F21A7F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58D196D80;
	Sat,  2 Nov 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+XpKPns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B718A925;
	Sat,  2 Nov 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554481; cv=none; b=p3Yvh0+BOoYkQn9imkZlWjHpwIRQcCl8yfKvNUGZUNzpcxZSyXQoYzfJwuxIO6hGhTM8Z+nG9oVWaRe+viCcy/o0s56YD9jdUNTLbXgz9bWTA+QtimpB/WP+9AhiemDHstpiordcN2rxZe6iEh4UKf+S+3NrQi9+FiZcY5CICPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554481; c=relaxed/simple;
	bh=Ra3EuFvPtdbp/nWEjcEM08kxsYNfQ+eulIhmbKu11rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkbidtcID1mFvkfoNCd30/yQTyszHWnPhZbPIW1vSFgj88EhpX19cYJlIiYfFvcT3lp48FM1v4VyxL7V5C0GVBUWuoxY5RZ0X548JVgNOjAbawFpbtndIxr0P7iQqKJ2ktS81qIOWwddH5ei56NdE/+W8cTnFEyOusS1AOjGxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+XpKPns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07A0C4CEC3;
	Sat,  2 Nov 2024 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730554481;
	bh=Ra3EuFvPtdbp/nWEjcEM08kxsYNfQ+eulIhmbKu11rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+XpKPnsKxBxXKiIZbrlBPvZwT/LNfNRO5H6qaXX6cD2wdZJXCQaaWpXjaq5U7u7h
	 ydQ0SMUTg1pGNfL2qNNOFkjhbEnqGJqwF0/OHGs6arGK4Y686pTDzj19gUpWTANlXd
	 4vdZIxfRzg9BB21gulVyYiYQsK2i2GjAK/auEalEwnxcpwFEltQ3UEX1aJ3+9Dk0iJ
	 TokWLYf1MKaSjk/4HQTPPQ8t+LJD2RgfSmwlj3rzE6f2jRF9+TBs78FVjJtT5+zl4x
	 TeK3XqPlpPEPMw5bqW1u76jbrmVSBVglBn+zM5403krrzDF1QIsemhCjSj2VzljEyk
	 qFe5mNgLi31mw==
Date: Sat, 2 Nov 2024 14:34:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_kkumarcs@quicinc.com, 
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com, quic_linchen@quicinc.com, 
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org, 
	vsmuthu@qti.qualcomm.com, john@phrozen.org
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: pcs: Add Ethernet PCS for
 Qualcomm IPQ9574 SoC
Message-ID: <c3kdfqqcgczy3k2odbxnemmjvuaoqmli67zisyrrrdfxd5hu4v@thxnvpv5gzap>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-1-fdef575620cf@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101-ipq_pcs_rc1-v1-1-fdef575620cf@quicinc.com>

On Fri, Nov 01, 2024 at 06:32:49PM +0800, Lei Wei wrote:
> The 'UNIPHY' PCS block in the IPQ9574 SoC includes PCS and SerDes
> functions. It supports different interface modes to enable Ethernet
> MAC connections to different types of external PHYs/switch. It includes
> PCS functions for 1Gbps and 2.5Gbps interface modes and XPCS functions
> for 10Gbps interface modes. There are three UNIPHY (PCS) instances
> in IPQ9574 SoC which provide PCS/XPCS functions to the six Ethernet
> ports.
> 
> Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
> ---
>  .../bindings/net/pcs/qcom,ipq9574-pcs.yaml         | 230 +++++++++++++++++++++
>  include/dt-bindings/net/pcs-qcom-ipq.h             |  15 ++
>  2 files changed, 245 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
> new file mode 100644
> index 000000000000..a33873c7ad73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
> @@ -0,0 +1,230 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/qcom,ipq9574-pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ethernet PCS for Qualcomm IPQ SoC

s/IPQ/IPQ9574/

> +
> +maintainers:
> +  - Lei Wei <quic_leiwei@quicinc.com>

...

> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: system clock
> +      - description: AHB clock needed for register interface access
> +
> +  clock-names:
> +    items:
> +      - const: sys
> +      - const: ahb
> +
> +  '#clock-cells':

Use consistent quotes, either ' or "

> +    const: 1
> +    description: See include/dt-bindings/net/pcs-qcom-ipq.h for constants
> +
> +patternProperties:
> +  "^pcs-mii@[0-4]$":
> +    type: object
> +    description: PCS MII interface.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 4
> +        description: MII index
> +
> +      clocks:
> +        items:
> +          - description: PCS MII RX clock
> +          - description: PCS MII TX clock
> +
> +      clock-names:
> +        items:
> +          - const: mii_rx

rx

> +          - const: mii_tx

tx

> +
> +    required:
> +      - reg
> +      - clocks
> +      - clock-names
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +
> +    pcs0: ethernet-pcs@7a00000 {

Drop unused labels here and further.

> +        compatible = "qcom,ipq9574-pcs";
> +        reg = <0x7a00000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&gcc GCC_UNIPHY0_SYS_CLK>,
> +                 <&gcc GCC_UNIPHY0_AHB_CLK>;
> +        clock-names = "sys",
> +                      "ahb";
> +        #clock-cells = <1>;
> +
> +        pcs0_mii0: pcs-mii@0 {
> +            reg = <0>;
> +            clocks = <&nsscc 116>,
> +                     <&nsscc 117>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +
> +        pcs0_mii1: pcs-mii@1 {
> +            reg = <1>;
> +            clocks = <&nsscc 118>,
> +                     <&nsscc 119>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +
> +        pcs0_mii2: pcs-mii@2 {
> +            reg = <2>;
> +            clocks = <&nsscc 120>,
> +                     <&nsscc 121>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +
> +        pcs0_mii3: pcs-mii@3 {
> +            reg = <3>;
> +            clocks = <&nsscc 122>,
> +                     <&nsscc 123>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +    };
> +
> +    pcs1: ethernet-pcs@7a10000 {

One example is enough, drop the rest.

> +        compatible = "qcom,ipq9574-pcs";
> +        reg = <0x7a10000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&gcc GCC_UNIPHY1_SYS_CLK>,
> +                 <&gcc GCC_UNIPHY1_AHB_CLK>;
> +        clock-names = "sys",
> +                      "ahb";
> +        #clock-cells = <1>;
> +
> +        pcs1_mii0: pcs-mii@0 {
> +            reg = <0>;
> +            clocks = <&nsscc 124>,
> +                     <&nsscc 125>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +    };
> +
> +    pcs2: ethernet-pcs@7a20000 {
> +        compatible = "qcom,ipq9574-pcs";
> +        reg = <0x7a20000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&gcc GCC_UNIPHY2_SYS_CLK>,
> +                 <&gcc GCC_UNIPHY2_AHB_CLK>;
> +        clock-names = "sys",
> +                      "ahb";
> +        #clock-cells = <1>;
> +
> +        pcs2_mii0: pcs-mii@0 {
> +            reg = <0>;
> +            clocks = <&nsscc 126>,
> +                     <&nsscc 127>;
> +            clock-names = "mii_rx",
> +                          "mii_tx";
> +        };
> +    };
> diff --git a/include/dt-bindings/net/pcs-qcom-ipq.h b/include/dt-bindings/net/pcs-qcom-ipq.h
> new file mode 100644
> index 000000000000..8d9124ffd75d
> --- /dev/null
> +++ b/include/dt-bindings/net/pcs-qcom-ipq.h

Filename matching exactly binding filename.

Best regards,
Krzysztof


