Return-Path: <netdev+bounces-214144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9CDB285A2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53164A20C7E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DD2308F35;
	Fri, 15 Aug 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tb6bmmhx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670342F9C23;
	Fri, 15 Aug 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281596; cv=none; b=TTv432Mbp4vnTPLsVmmoDUBWj20E8YCyj5CJZFf3Ngh1K844qqs09nVFw6I7CmGI5gpogIbQ/I2iwQQ5whdwtS4QLgyCS1Fw8WsP3qdTEG/dIQc5Yq1dkJeW4bH9tA0Bv2j7wBOfkmWe8w7C3aYZ61TTcCeF5xCz3qit5nH6xzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281596; c=relaxed/simple;
	bh=zsB0T/19d095Sl/miMKM+8NX2NfFLaJKmoMiFDq2yZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siPcv+3CzeGtTV1FsJ8CvoPzt1UTAcgVeW2kuhrfLwKww/8prjMyNKC/iRulzyhIsJde+myySA3sfrSxuXO+rlGPJcGNsvntJi6gMRC9mhk4cU3tO/806Ynanxaaku0ezO9XNGaHgZ+z9ACPY2hRPsCCHM39y/Qg0GD1/5aiwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tb6bmmhx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NaAAZBpMGB7NNLtOQW+QNZLjNhJZLoLyOf0dfTeVUlE=; b=Tb6bmmhxnYVqGw0yP/q44nYma2
	yPL4ILKbEY+6Ft21B0Rg6zzDDTZglBOta6eYBy5fyy7Q75j8J9GAGRWPV3cxpMJbzD32qjSC8QYh2
	8KL70QyrnMO8qUc6Lhu8tCYXJeP1lcdRi2B83nbFMTVeP9NZJ6VYwjHPX6GGO20mKFno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyv8-004qgu-QW; Fri, 15 Aug 2025 20:12:54 +0200
Date: Fri, 15 Aug 2025 20:12:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	taoren@meta.com, bmc-sw2@aspeedtech.com
Subject: Re: [net-next v2 1/4] dt-bindings: net: ftgmac100: Restrict phy-mode
 and delay properties for AST2600
Message-ID: <08c46fbc-b65a-4eb4-9cfa-e555cab8398b@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063301.338851-2-jacky_chou@aspeedtech.com>

> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac01
> +    then:
> +      properties:
> +        phy-mode:
> +          enum: [rgmii-id, rgmii-rxid]

Why not rgmii-txid? Also, why not rgmii?

On the MAC, tx/rx-internal-delay-ps is meant to be used to perform
small fine tuning. There is no reason why you cannot use this with a
PCB which implements a delay.

	Andrew

