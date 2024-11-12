Return-Path: <netdev+bounces-144133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D779C5BB8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF68B37B35
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618341FF7C2;
	Tue, 12 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG/3GkRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4F1FF60E;
	Tue, 12 Nov 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423364; cv=none; b=tiaeJ3ofmBWQ26DZ9DjFT7E4GTL8BbHybbWd+nin183yHgvaLKSDa21yrsYXSwNTTCOnjT4HMlv9lVI6NMK/j15zg8ja3Yk5UbsCuOHyQ1SpnFnKVWcdzHz3WX8CzL/3rwiYA/3z5JNJp5IEMx+8t4zXCbMcPFvj3k5Oqg3Iaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423364; c=relaxed/simple;
	bh=sjtOX4U8btZ+pX6YU8B2jICTN2PT+V0pityV9K3OEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwtyoLc5sIeSFjbAvaBPqbVDF+d+ag3b6Rob8QQwzkQLKUcZXA0IsOAIDFJCD1wgjv+hAtQPha+tbIiQpTfTKWAjmhAebiTZu0TgQvpPPwGGgEB9VJKbNq0ZEcChrIpIpClQVJ2zrPMLZxEU0xwl5PxbokZabQTgvCJ9g3Dcz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG/3GkRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C12EC4CED0;
	Tue, 12 Nov 2024 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423363;
	bh=sjtOX4U8btZ+pX6YU8B2jICTN2PT+V0pityV9K3OEgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KG/3GkRi+PzBfH0bPRDfobz/mT6+gCk2ZgvEyfYWyaNYDoNZb+9U60lRz9cdNT+e6
	 nHGX3+wQnkZ+H8qTc+YFS+CzEHgCK/Ls29Bxb4S+iXjJ5ssiJ2XixMHOqrZGSuzbFe
	 Ksy8hqJ0fytWVXguZLHlZemeCQbrhv7ePNflyzZrpBk3+waNIp9vWKDHeB3jp1P0c9
	 Yyz3tVLv5kDfVS8jksqk5yiJq3atGT/9huj2YjQf/vvqbshjBQCYyRH4TPOIqQ2Rdn
	 BKicNTOAMNcj0XpM6nr1j7nDm5T1LJKWb+A5/nEHUysh9o5K6NjtbkonT1Ps8dFfGc
	 GSUBBhWMM8Jrg==
Date: Tue, 12 Nov 2024 08:56:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, upstream@airoha.com,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [net-next PATCH v4 1/3] dt-bindings: net: dsa: Add Airoha AN8855
 Gigabit Switch documentation
Message-ID: <173142336068.894176.10211231485154959915.robh@kernel.org>
References: <20241108132511.18801-1-ansuelsmth@gmail.com>
 <20241108132511.18801-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108132511.18801-2-ansuelsmth@gmail.com>


On Fri, 08 Nov 2024 14:24:14 +0100, Christian Marangi wrote:
> Add Airoha AN8855 5 port Gigabit Switch documentation.
> 
> The switch node requires an additional mdio node to describe each internal
> PHY absolute address on the bus.
> 
> Calibration values might be stored in switch EFUSE and internal PHY
> might need to be calibrated, in such case, airoha,ext-surge needs to be
> enabled and relative NVMEM cells needs to be defined in nvmem-layout
> node.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/dsa/airoha,an8855.yaml       | 242 ++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


