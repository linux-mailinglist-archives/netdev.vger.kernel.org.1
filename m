Return-Path: <netdev+bounces-159628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0EA162EB
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518A8164994
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349B1DED57;
	Sun, 19 Jan 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NDV8Pl+5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308A3207;
	Sun, 19 Jan 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304234; cv=none; b=C4qHrWe7mKHjj+H9/X06j0zlYUvjA7x5sEHkcsXaCZ8F5VPzI6JbFHAFc4Q3pnUSkV9C7SWRJkV7VMjH7din11sLlcViCNTym9AWv1eHRrvfloLJzkD9BSuTzd+LAFBxBtBVhe0HObNW0kY4mgXZB5hxg2rw0zgjxzaLK6QSpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304234; c=relaxed/simple;
	bh=pNA8pTGmyqesSb5RNq/Jqk3pe6bXGxZEBcn0j+R2euA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc5uZturVrURz2aBoebyB1ZGenpB87jcZ4xNfAKxIakpV4kPSC+6KVMevIt7Jn6bs2/331E/d9SHtT46YdE1WcApRvewRGG5qfU9C6woeKIGOd4Xqn/bBIW6+iYo9eyNGnmrfyVYBZGduQFMEvXK8s0FnXjOjVNjcOTTV5riDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NDV8Pl+5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HwefpYHMifKM3JidAjIGjZi09phyptztxDCC5QWqai0=; b=ND
	V8Pl+5Bj0uqmEJ1/llB3+mur1d1FJ1ryhUol8M7vNx+0JxbtwQTP86VDOuaWZ2TI1cYkWuso0yHkM
	KCsolwe6lUvJrldGcKVKgFDalLuZWz3HVpV5VCy7r2GImKq9X8KHXaEgxAo02F0vetYxk383JzLwp
	R1HBdJddeUhTYeg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZYBo-0065O1-8N; Sun, 19 Jan 2025 17:30:20 +0100
Date: Sun, 19 Jan 2025 17:30:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: marvell-88q2xxx: Fix temperature
 measurement with reset-gpios
Message-ID: <c58f7140-520c-464a-a658-be7e12c7e56f@lunn.ch>
References: <20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com>

On Sat, Jan 18, 2025 at 07:43:43PM +0100, Dimitri Fedrau wrote:
> When using temperature measurement on Marvell 88Q2XXX devices and the
> reset-gpios property is set in DT, the device does a hardware reset when
> interface is brought down and up again. That means that the content of
> the register MDIO_MMD_PCS_MV_TEMP_SENSOR2 is reset to default and that
> leads to permanent deactivation of the temperature measurement, because
> activation is done in mv88q2xxx_probe. To fix this move activation of
> temperature measurement to mv88q222x_config_init.
> 
> Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

