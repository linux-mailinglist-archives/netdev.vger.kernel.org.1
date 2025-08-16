Return-Path: <netdev+bounces-214309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45EB28EC9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EEC7A22F5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0812F0691;
	Sat, 16 Aug 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L2zMQX5H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCEA2F39D5;
	Sat, 16 Aug 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357113; cv=none; b=Pf5nnfJ49PnwZdiJ8BrjAfUsl9V29cmcEHsZljat0Bncs4Vd4VUr/m0pAxqy2fEAdkv7Rr6jtn2Fh9rvF59P25L8us5ELJkm3ei+4xqsWVYYyr5+mQZIxS/yM7sP5c/NY5r/PfRPkNgpM7EzLBpcQu8va+ti0kYv7vCIRULD+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357113; c=relaxed/simple;
	bh=UMEFa52la42hMqyKMzdR+q0aEPSEABoj+9c5UKaSSvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asr2Os8HnYgtbbAIz9ScsMN9AU3SowTY1xpuz9ij9tLld6hLPnSiK7Kjl6ewqz/JBhMan+FzFvr+14Vq/Rx26n+hU8vOC2ZuyjfJYyIHG9KwvF85axwkYrCT5X8aTdeYMMY6pmNLatKZajt79Pb52DMU/J1sAjzYM+WSS1o6mD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L2zMQX5H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3NAUUTiJZHuAR2izt+xT21rv8ZMns6fw9BsTVEElK6M=; b=L2zMQX5Hww/NOqp+oDguP1MWAu
	1ExUD0+VsfUvL6v/2KlyqgL8gCrSmpJwMTv3YOQwJNOIw+3X/vP1XY6QaNoKbf/xZuZj4gL711y5D
	bCwVW1B/FiRf5PchvAzW8u/Z7jA9aGPLCCxu4tNwhS2U3KQAv6y9HMANgJzwLm3tseIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIZJ-004uXK-LF; Sat, 16 Aug 2025 17:11:41 +0200
Date: Sat, 16 Aug 2025 17:11:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v3 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <9b44c768-8362-4b1d-931a-6df91106018b@lunn.ch>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
 <20250816052323.360788-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816052323.360788-2-mmyangfl@gmail.com>

> +  motorcomm,switch-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      When managed via MDIO, a hard-configured switch ID to form MDIO reg addrs,
> +      to distinguish between multiple devices beside phyaddr.
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +    maxItems: 1

So how is this different to reg? Why cannot it be derived from reg?
Please give us all the details of what this actually does. Or point us
to a chapter in the datasheet.

> +                /* if external phy is connected to a MAC */
> +                port@9 {
> +                    reg = <9>;
> +                    label = "wan";
> +                    phy-mode = "rgmii";
> +                    phy-handle = <&phy1>;
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                        pause;
> +                    };

If there is an external PHY, why have a fixed link?


    Andrew

---
pw-bot: cr

