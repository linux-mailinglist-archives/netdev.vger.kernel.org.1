Return-Path: <netdev+bounces-215108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1926CB2D20B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A79525FF7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582727815B;
	Wed, 20 Aug 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aFfxz7Lu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361871428E7;
	Wed, 20 Aug 2025 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657842; cv=none; b=qK/ciNYkYbSEZQXqG5SyHg0FCERubnTzbtIazdg6gROkqd8/KDvVYKTeyckDP/gk35tibJjwXob5u0FbswfhMf8Oob/o5v54+Cjq1DVO5T01uq9rbwCejtLraKEC3b4fEuBJ1yki2CHWjUx3ihMVmTtHAFm12oaMDvR5jAIOb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657842; c=relaxed/simple;
	bh=QAtOmFE8MbVRPcGd6YPaCNUMdnykaY7iPTPEYpn36lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMKVDmBEhfFdVDjSk4RP5urNLf0WA3/YBRx5nFqb6MqQ5N8Q/fXbhxYS0qju88PuAlYc8IJ8K/cfm9R5kGrNEk8qmfP+VdpX0Um34oirikHE1pYiayDBoOEiOwtsiea/59R8jnepoMS6MHDEIiYG0xfUBD5ywLrTNVG8TJuFuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aFfxz7Lu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N+xJmULXxpHn+xezKethz/N2R54pHjMy75yfVcSZbZ8=; b=aFfxz7Lu4MS5kpv0tqnOjSO/Dk
	ftywl6LjfJ0a6NPa1n8NITAaay22TzriZiEV1deD1WFg1dO8r+tsKtGpktxxfAPp2Xb1nYTYbvbxn
	Ky/EkLFTVc5T+v66fENPlvrezjt982uOKTkQdC2O6zM2MLVK7SV0mBlHGJ4Z9x6rqXQk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoYnW-005GZ7-5N; Wed, 20 Aug 2025 04:43:34 +0200
Date: Wed, 20 Aug 2025 04:43:34 +0200
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
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next v2 0/4] Add
 AST2600 RGMII delay into ftgmac100
Message-ID: <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Aug 20, 2025 at 12:40:02AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > This patch series adds support for configuring RGMII internal delays
> > > for the Aspeed AST2600 FTGMAC100 Ethernet MACs.
> > 
> > So i think you are doing things in the wrong order. You first need to sort out the
> > mess of most, if not all, AST2600 have the wrong phy-mode, because the
> > RGMII delay configuration is hidden, and set wrongly.
> > 
> > Please fix that first.
> > 
> 
> The RGMII delay is configured in U-boot stage, and it is not changed when booting to
> Linux. I want to know whether the first thing to correct here is whether the phy-mode
> in aspeed-ast2600-evb.dts is rgmii-id. Our AST2600 EVB, there is no delay on board,
> so, I need to change the phy-mode to "rgmii-id" to meet the RGMII usage first?

If there is no delay on the PCB, then phy-mode is "rgmii-id".

	Andrew

