Return-Path: <netdev+bounces-202061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D909AEC24B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FF0173D43
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB228A3EC;
	Fri, 27 Jun 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0BXBCTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE928A1C7;
	Fri, 27 Jun 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060903; cv=none; b=ZpmpgEXcBc7paF4+irt2JAILwzq9jIuvaCZo+asWyxX8PotI5Kylm5wDBCkQIo8d0YiHEDbBkNQ1J1K+nliblj0DE486tEOmU2Ff0CfDKhXTkdu8ROi245z/ppMDgc4DxmPy41QJPPrQ4gy+qoucUEHGHy6Vk3QxZwjZkeUDRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060903; c=relaxed/simple;
	bh=YHqgPMpv3lbWQeN0ahS3Aj9hJ6fjkJUfFUhz0ULMu7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l03II21WqVu4CwE+0ATOS8GSg19CtOoB0wQnr9aVSB201qcmFfAvgeNR+/xCShpecSpsnOFr1FnfjqtPtv/5zFS7mqzHLbHCVmJV/9AKvy3y9EPIat+tIQy8HkLy6ljZdEmaR9S+ZsHilMeD2W46L3SK7Io/ge8udHAnBl4Pp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0BXBCTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBDAC4CEE3;
	Fri, 27 Jun 2025 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060902;
	bh=YHqgPMpv3lbWQeN0ahS3Aj9hJ6fjkJUfFUhz0ULMu7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0BXBCTmzuRvWVnE7dxBQGa3Co6tx7KvAwnAhhiYVSX2/D/E+FJFebyvI9k9NYUJz
	 gdf9K4aKDNQb15RrHtY60rJqhLFvKegk3BV4qPqDJtuPLRduzxHOApkqUneiWv7DNS
	 xhc+QwFW6vRblmxDPS/2WdkVphzzIeoRflCbu7yMX/MX0gEjQSpPB92CVvoyAl1LRb
	 jEIfbQJHecV4BSUPukdJvB6y6Fmdn++G6c1RRPrNR43cnv4lawKW+rYi49XXmwj4BV
	 Yme2khNgG9Fiv9Fz/s3cCLOuDB+ftj+BSHLrFpJkxk2TipiC6SqeKKc6WvbBS9C4y/
	 hhOq+ufF43bkA==
Date: Fri, 27 Jun 2025 16:48:21 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v15 05/12] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC
Message-ID: <20250627214821.GA195510-robh@kernel.org>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626212321.28114-6-ansuelsmth@gmail.com>

On Thu, Jun 26, 2025 at 11:23:04PM +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> new file mode 100644
> index 000000000000..a683db4f41d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Switch SoC
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 Switch is a SoC that expose various peripherals like an
> +  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> +
> +  It does also support i2c and timers but those are not currently
> +  supported/used.
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +
> +  efuse:
> +    type: object
> +    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
> +    description: EFUSE exposed by the Airoha AN8855 SoC
> +
> +  ethernet-switch:
> +    type: object
> +    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
> +    description: Switch exposed by the Airoha AN8855 SoC
> +
> +  mdio:
> +    type: object
> +    $ref: /schemas/net/airoha,an8855-mdio.yaml
> +    description: MDIO exposed by the Airoha AN8855 SoC
> +
> +required:
> +  - compatible
> +  - reg
> +  - mdio
> +  - ethernet-switch
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        soc@1 {
> +            compatible = "airoha,an8855";
> +            reg = <1>;
> +
> +            reset-gpios = <&pio 39 0>;
> +
> +            efuse {
> +                compatible = "airoha,an8855-efuse";
> +
> +                #nvmem-cell-cells = <0>;
> +
> +                nvmem-layout {
> +                    compatible = "fixed-layout";
> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +
> +                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
> +                       reg = <0xc 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
> +                        reg = <0x10 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
> +                        reg = <0x14 0x4>;
> +                    };
> +
> +                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
> +                       reg = <0x18 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
> +                        reg = <0x1c 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
> +                        reg = <0x20 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
> +                       reg = <0x24 0x4>;
> +                    };
> +
> +                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
> +                        reg = <0x28 0x4>;
> +                    };
> +                };
> +            };
> +
> +            ethernet-switch {
> +                compatible = "airoha,an8855-switch";
> +
> +                ports {

Same comment here.

Why do we need 2 examples of the same thing? Isn't this 1 complete 
example here enough?

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

