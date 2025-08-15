Return-Path: <netdev+bounces-214151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB96B285EB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A3F1CE7CCC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126E22A7F2;
	Fri, 15 Aug 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GTeAPr8g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20593317714;
	Fri, 15 Aug 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283370; cv=none; b=Z5vFhXgnjwYtxhfloKjpCsjGu5UJTrFR1aW6M3CZcrDRvZiUMejqTMSmb8cmGTElruk64rNuLTTzwYyhLIgk91TT2+tcwwlxBDEx2h13mSe/ABkZcgZ7uIB2g5MRFhioAmBHyrOot3WogQBm9OZdlv58VDml7hQKSmhTeEiSr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283370; c=relaxed/simple;
	bh=BgbitYwqALEt/YYM1kuQOWc5srz0g9nkyyToP19KYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TET8T36KaOFNtEgEDd9Mku1tvRrOJsYCjHv2YbacakLPwKRqdQFBPS0euz4iT+vndvmPl4pJupD4mcrroZ4kQqfGR+sw2AmiznMRejoXyIicAx4/IZDWl/cHC8o28C16HHpC7AHqdn0hzERMWMJ+2huhNrhC48efu1yQCZFXUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GTeAPr8g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NFEat3zirg8C2/2oLxu6X/ZdyOC05vJhFKTQnZhl0cg=; b=GTeAPr8gn7YNZKVQbSxG+bF1QA
	CtBH83Hd9XObTUvCNk45wDj5dQNcibQ7ra2s4ipaVsEQqMj7iguXuby5CTgruIH7T60llxk4xKsQ5
	+Nh+55C3QG53q0Kaj2eiMYJmqtcEyE5S+tvSg6m7oWR4pTBfDE7tNVHxQKRDffL+EBxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzNj-004qvW-Bo; Fri, 15 Aug 2025 20:42:27 +0200
Date: Fri, 15 Aug 2025 20:42:27 +0200
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
Subject: Re: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>

On Wed, Aug 13, 2025 at 02:32:57PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the 
> Aspeed AST2600 FTGMAC100 Ethernet MACs.

So i think you are doing things in the wrong order. You first need to
sort out the mess of most, if not all, AST2600 have the wrong
phy-mode, because the RGMII delay configuration is hidden, and set
wrongly.

Please fix that first.

Then consider how you can add fine tuning of the delays. Maybe that
needs to wait for AST2700.

	Andrew

