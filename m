Return-Path: <netdev+bounces-26923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A752577978A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC31C209D2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EF219FF;
	Fri, 11 Aug 2023 19:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6638468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98760C433C7;
	Fri, 11 Aug 2023 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691780987;
	bh=VfmfHOv6xko6YT4HOZzOKBhoBWltWaprWd7FnqJLdbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taCcphmE1F9dHFapXEZ5XHEpRt26FV/M7dylMddLm0+jKLD9w0TeDKaZzhogexxsz
	 OVscaYm6Itm2domY51J5SML9b6dhHc9BzU26ehqEpGSD2fjOxfD3wMrU0d3NDeRLGs
	 t4mwBGIS/h7BwXEFKO4ztKUFgyNPEoE6ZhRlki25UEX0+bFiqHNhGJybLe3ZdbLhfu
	 9fuj+MWou2o2jsb7jCyyxx7fcmzlxUkIS0Hp9paw3NonL1wYsXBUZzXGgHXFnheF2O
	 M75l7mkRTAc08Dr39YAi45QMYJfXWJ0pbkQ2/wROS6KRDGGQaiJrQAirOYw7pxZG5L
	 3FyvWFeqQzRrg==
Received: (nullmailer pid 3934074 invoked by uid 1000);
	Fri, 11 Aug 2023 19:09:44 -0000
Date: Fri, 11 Aug 2023 13:09:44 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: mt76: support setting
 per-band MAC address
Message-ID: <20230811190944.GA3730441-robh@kernel.org>
References: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>

On Mon, Jul 31, 2023 at 11:23:16PM +0100, Daniel Golle wrote:
> Introduce support for setting individual per-band MAC addresses using
> NVMEM cells by adding a 'bands' object with enumerated child nodes
> representing the 2.4 GHz, 5 GHz and 6 GHz bands.
> 
> In case it is defined, call of_get_mac_address for the per-band child
> node, otherwise try with of_get_mac_address on the main device node and
> fall back to a random address like it used to be.
> 
> While at it, add MAC address related properties also for the main node.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since v2:
>  * drop items list with only a single item
> 
> Changes since v1:
>  * add dt-bindings
> 
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 58 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 252207adbc54c..7eafed53da1de 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -37,6 +37,12 @@ properties:
>      description:
>        MT7986 should contain 3 regions consys, dcm, and sku, in this order.
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    interrupts:
>      maxItems: 1
>  
> @@ -72,13 +78,23 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  address: true

What's this? Not a documented property.


> +
> +  local-mac-address: true
> +
> +  mac-address: true

You really need a ref to the schema defining these. But first we need to 
split them out from ethernet-controller.yaml. Which I think there were 
patches for, but it stalled out.

Anyways, it's fine for now if you're not up for that.

> +
>    nvmem-cells:
> +    minItems: 1
>      items:
>        - description: NVMEM cell with EEPROM
> +      - description: NVMEM cell with the MAC address
>  
>    nvmem-cell-names:
> +    minItems: 1
>      items:
>        - const: eeprom
> +      - const: mac-address
>  
>    mediatek,eeprom-data:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -213,6 +229,29 @@ properties:
>                      description:
>                        Half-dBm power delta for different numbers of antennas
>  
> +patternProperties:
> +  '^band@[0-2]+$':
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      address: true
> +      local-mac-address: true
> +      mac-address: true
> +
> +      nvmem-cells:
> +        description: NVMEM cell with the MAC address
> +
> +      nvmem-cell-names:
> +        const: mac-address
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -225,10 +264,13 @@ examples:
>        #address-cells = <3>;
>        #size-cells = <2>;
>        wifi@0,0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
>          compatible = "mediatek,mt76";
>          reg = <0x0000 0 0 0 0>;
>          ieee80211-freq-limit = <5000000 6000000>;
> -        mediatek,mtd-eeprom = <&factory 0x8000>;
> +        nvmem-cells = <&factory_eeprom>;
> +        nvmem-cell-names = "eeprom";
>          big-endian;
>  
>          led {
> @@ -257,6 +299,20 @@ examples:
>               };
>            };
>          };
> +
> +        band@0 {
> +          /* 2.4 GHz */
> +          reg = <0>;
> +          nvmem-cells = <&macaddr 0x4>;
> +          nvmem-cell-names = "mac-address";
> +        };
> +
> +        band@1 {
> +          /* 5 GHz */
> +          reg = <1>;
> +          nvmem-cells = <&macaddr 0xa>;
> +          nvmem-cell-names = "mac-address";
> +        };
>        };
>      };
>  
> -- 
> 2.41.0

