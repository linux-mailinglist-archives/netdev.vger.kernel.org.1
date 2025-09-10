Return-Path: <netdev+bounces-221780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C7B51D9D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A081C80742
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F233472D;
	Wed, 10 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3N1bM+YG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B99463;
	Wed, 10 Sep 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521691; cv=none; b=P0qPMfiaCV4zNTFBNHkYXli2XO762THBMORyhN35T8WXjzTM4Tys5npRc/c8mHyb+zBTZRFkl6vDVuXxr1Sj6rK8yUnPpzzRTwKOXDox50sRsW1VBLOdJb55nlICOu3AxI3QCXpznWtlulOuSgI8gruOrBaNh9d3aFbFISGTIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521691; c=relaxed/simple;
	bh=Ip/KN2ZBg4uirjUszlcMbTp+luH52XTz8G/cRfWRFX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJSlrcG2jYfxcHbAFD53+H4VsUhwkfoeyN8Vrbwv0ahV/ryrHO9MPNm3fcKEkOmdoU+ON8AcZIYryh0NFBHawPBAyjYTyLQuKNXnmKakrAecAYACfGyJZsDv5U2nWK0E961oNu3paREFarUU7nYuWKu2leTK+vvLk6pu0ntPv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3N1bM+YG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/xjGoP5vn/+OHaRa5itQ8wKINnejO/BR/dQQpInoLBQ=; b=3N1bM+YGSMC9Ti8OTLgjBhKB0T
	Ldrt3k3BjutpLirPelsVDJ9tkzlbslgsdsIHSDwGQIBWGhVDRLR3UYN4ZvPaH1MqKR+6AoFUJwWBp
	VYdccpB8p18eo2HU3gQT6dPWJ7iPNUPVzVMwdMW/ucXpIwoEjt4FEQjSgoY45hgiNpYw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwNfm-007yKv-RE; Wed, 10 Sep 2025 18:27:54 +0200
Date: Wed, 10 Sep 2025 18:27:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add strap
 configuration during reset
Message-ID: <393f0c41-57f2-491a-9ac6-5069c7db089e@lunn.ch>
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>

On Wed, Sep 10, 2025 at 04:55:23PM +0200, Bastien Curutchet wrote:
> Hi all,
> 
> This small series aims to allow to configure the KSZ8463 switch at
> reset. This configuration is determined by pin states while the chip is
> held in reset. Normally, this kind of configuration is handled with
> pull-ups/pull-downs. However, in some designs these pull-ups/pull-downs
> can be missing (either intentionally to save power or simply by mistake).
> In such cases, we need to manually drive the configuration pins during
> reset to ensure the switch is set up correctly.
> 
> PATCH 0 adds a new property to the bindings that describes the GPIOs to
> be set during reset in order to configure the switch properly. Alongside
> this new property, a new 'reset' pinctrl state is introduced.
> 
> PATCH 1 implements the use of this property in the driver. I only have a
> KSZ8463 to test with, so only its configuration is supported.

Are you setting switch state which cannot be set via register writes?

	Andrew

