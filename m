Return-Path: <netdev+bounces-112311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4A93841B
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 11:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D21C20982
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C813C153;
	Sun, 21 Jul 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFYYNtYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12084256E;
	Sun, 21 Jul 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721552421; cv=none; b=eBcIa23YCGIIjycktHjBuMn/WHoRW4jqh5juwI1WYRZG6GKNz9K9huULk2Bonyi2Wjm+gLvjHQYZHxDOTULu5NFff4oBmYPjTydNpRmaxcn/MwpUSg+5l7ckMxoeQ/q3p59+bgLSgHZsbUmld/i43qapvw539GoPkqXfKY5xoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721552421; c=relaxed/simple;
	bh=73l4iQPCGsyJcwGiCLPqOY8gYX9SmoGLU4LSJfc1aHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6vTWzgpXjMEe8aXrmww80jW6FRG9mJHqmQe1IcJGoTCMyPLshki/Xjo/2KS2FP50EyzUXZVQQkBAxlWen+8oWfQ3Ro+BKTqaVdNeYi2Wrkfuh8Gc71/4hwhsVc9yA7tkpDDossusKSakCzUO5LGk/v57n0fIIGoCDgDoj3F3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFYYNtYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E49EC4AF0B;
	Sun, 21 Jul 2024 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721552420;
	bh=73l4iQPCGsyJcwGiCLPqOY8gYX9SmoGLU4LSJfc1aHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFYYNtYu5KZjR+7mt6MYwkPW9xQEQ0QSZqvi/v6xwY6I0nxXDCRm4y5ET91U9AtYq
	 eDt7YvEgjBBTDy/rqpEGusz1Sfe9vP0mO8LVJ7TbLyNzrd0rpNqzqyYjnAbkErk8/5
	 npvywz09WghPFGl+XBNN45jZSN5Xm3Y60Sqw9LVT2da6q1s+vlhr+gPYU0axQvrOoG
	 ahndPeHAlAiFR3Y2ZZmTU9LhwAy54cx0OyrqumhL7sU/KfltmteD22pd9GknKn7Ini
	 ekA1f29zT+UAM73D5oodDS2wdZz5VbOS5/1vXhP3QXrcNeAgmtEuaYLP/lrIEm9YtJ
	 pzroHGbCj6VTA==
Date: Sun, 21 Jul 2024 10:00:14 +0100
From: Simon Horman <horms@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
Message-ID: <20240721090014.GC715661@kernel.org>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>

On Fri, Jul 19, 2024 at 03:15:10PM +0530, Ayush Singh wrote:
> boot-gpio (along with reset-gpio) is used to enable bootloader backdoor
> for flashing new firmware.
> 
> The pin and pin level to enabel bootloader backdoor is configed using

nit: enable

     Flagged by checkpatch.pl --codespell

> the following CCFG variables in cc1352p7:
> - SET_CCFG_BL_CONFIG_BL_PIN_NO
> - SET_CCFG_BL_CONFIG_BL_LEVEL
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> index 3dde10de4630..a3511bb59b05 100644
> --- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -29,6 +29,9 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  boot-gpios:
> +    maxItems: 1
> +
>    vdds-supply: true
>  
>  required:
> @@ -46,6 +49,7 @@ examples:
>          clocks = <&sclk_hf 0>, <&sclk_lf 25>;
>          clock-names = "sclk_hf", "sclk_lf";
>          reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
> +        boot-gpios = <&pio 36 GPIO_ACTIVE_LOW>;
>          vdds-supply = <&vdds>;
>        };
>      };
> 
> -- 
> 2.45.2
> 
> 

