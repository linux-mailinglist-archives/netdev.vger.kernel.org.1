Return-Path: <netdev+bounces-210399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F2B13179
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB2174FBD
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7221A428;
	Sun, 27 Jul 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hLV+glJq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D411386B4;
	Sun, 27 Jul 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753643416; cv=none; b=MQCfwG783QUUiSON6fkFOFPwOgN5ih27kEXL73wSVuY6nmaTO6EAVbZFAPCK/M/Mktp03FIAjbxHbkD77WdjOYYx0fKYIFQKjhQpJcQ2uC2mI5l8H82MGkd/CMCpskSbBC9A40SDKb2BmfsqF6VazeLn818logfv3h4pHr9Vdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753643416; c=relaxed/simple;
	bh=wRC/ANxWAxHJAiV4BcAF4Xbq3l4V8WJiV/3TlOQqmRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5g+t9ud3f+dH+FJDAwjk0IiBJpA/SjyzYIOzoJw0P8RUzMqWhL8pZpKmmWtSmz+1AoCELX5VLro8YYyGAU4FrpjmTevfZZwkrSRo1vHeQuIBmL4epN8RnFWSbWIQ7DtQdSvbzBacxfIcaFjvoHg6Bylg/VK5B12N4m86PUf4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hLV+glJq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G6fAFR76cmo7RpsyFJQzRERhtJ7iBzJqeyQVBeXy91o=; b=hLV+glJqUEzoc844ck/FZXvYMD
	PhOs8Bnrf0ylD+a/wULEdJfDI4lHzXVYin5qpBLjnGkk9Hl3bvNuxqyvoLW0rSAaLya6SMpdMsKkA
	jNOg2JPnsZduh2Eyq4ZiHIwdt+JST/R54FqdZGk2Zn36lUbfT74AESIwlm8Bg63jRmyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug6ku-0031NN-T5; Sun, 27 Jul 2025 21:09:56 +0200
Date: Sun, 27 Jul 2025 21:09:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of
 an optional mdio node
Message-ID: <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727180305.381483-3-jonas@kwiboo.se>

On Sun, Jul 27, 2025 at 06:02:59PM +0000, Jonas Karlman wrote:
> The dt-bindings schema for Realtek switches for unmanaged switches
> contains a restriction on use of a mdio child OF node for MDIO-connected
> switches, i.e.:
> 
>   if:
>     required:
>       - reg
>   then:
>     not:
>       required:
>         - mdio
>     properties:
>       mdio: false
> 
> However, the driver currently requires the existence of a mdio child OF
> node to successfully probe and properly function.
> 
> Relax the requirement of a mdio child OF node and assign the dsa_switch
> user_mii_bus to allow a MDIO-connected switch to probe and function
> when a mdio child OF node is missing.
 
I could be getting this wrong.... Maybe Linus knows more.

It could be the switch does not have its own separate MDIO bus just
for its internal PHYs. They just appear on the parent mdio bus. So
you represent this with:

&mdio0 {
	reset-delay-us = <25000>;
	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
	reset-post-delay-us = <100000>;

	phy0: ethernet-phy@0 {
		reg = <0>;
	};

	phy1: ethernet-phy@1 {
		reg = <0>;
	};


        ethernet-switch@1d {
               compatible = "realtek,rtl8365mb";
               reg = <0x1d>;
               pinctrl-names = "default";
               pinctrl-0 = <&rtl8367rb_eint>;

               ethernet-ports {
                       #address-cells = <1>;
                       #size-cells = <0>;

                       ethernet-port@0 {
                               reg = <0>;
                               label = "wan";
			       phy-handle = <phy0>;
                       };

                       ethernet-port@1 {
                               reg = <1>;
                               label = "lan1";
			       phy-handle = <phy1>;
                       };

If this is correct, you should not need any driver or DT binding
changes.

	Andrew

