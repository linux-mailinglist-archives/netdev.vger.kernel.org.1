Return-Path: <netdev+bounces-189555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71944AB29A8
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B10174DF6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253725CC4F;
	Sun, 11 May 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eR7newBU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7B259C9A;
	Sun, 11 May 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981755; cv=none; b=jl1v873woMZ1bBgKmC65uCU9vMPu/EvVuyYvzT5RIcnUEVIUFrxoicNyD8pmlpv5xxTBXc/EU5rKejmD30D76eyCQLN6f5rF9rprBpDkgwzk8Zu1fCcjgaik1HZQ9l6GgvMHWAGVIp6u/WAg0VEvyuouT6ACaRyM1P66NleO6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981755; c=relaxed/simple;
	bh=Mst0Yp31ZspedexbU3R7bW/70oowdBHUF2qt/ZHEFSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFEzibrxghvUvviBJeo69rC9bGFF/PzpMvmJS8vOJg0IhV0asL1KVXhoIvNvtYQON9D2aTDGZDGRVQGM8eSk45Tn485VYDiyUKGzz54tzNRuT3VlIO3J1+FfyUpfI72HHcWpT4zljStTnQtgqiMwvRPjmvr++QpKKshAQjgve+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eR7newBU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QfYxhT92+8A6gWfGGKLpIf5nhSq7v4aUuvhWH2UbJM0=; b=eR7newBUNJ4wqxhc3b1d+3qx/c
	EOFDvTqf8qqEfYJ3R0yC22QrqFJkDAo9E2rWR3JFi6/u5WH2/sFe4owsAocJSN4RWaPCSw9lyau9J
	KZz2Du6+pdPtjQOcMq/y8NdG6pS80LfMlxgQl+jEMlQqtiXiHhIxDAtgmd4t/z9Crhi0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9km-00CGJu-GZ; Sun, 11 May 2025 18:42:16 +0200
Date: Sun, 11 May 2025 18:42:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch node
Message-ID: <bfa0c158-4205-4070-9b72-f6bde9cd9997@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-10-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-10-linux@fw-web.de>

On Sun, May 11, 2025 at 04:19:25PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add mt7988 builtin mt753x switch nodes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 166 ++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index aa0947a555aa..ab7612916a13 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt65xx.h>
>  #include <dt-bindings/reset/mediatek,mt7988-resets.h>
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "mediatek,mt7988a";
> @@ -742,6 +743,171 @@ ethsys: clock-controller@15000000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		switch: switch@15020000 {
> +			compatible = "mediatek,mt7988-switch";
> +			reg = <0 0x15020000 0 0x8000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&ethwarp MT7988_ETHWARP_RST_SWITCH>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				gsw_port0: port@0 {
> +					reg = <0>;
> +					label = "wan";

I would expect the label to be in the board .dts file, since it is a
board property, not a SoC property.

	Andrew

