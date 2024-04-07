Return-Path: <netdev+bounces-85542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6804B89B346
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DEA2825E1
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3B3B7AC;
	Sun,  7 Apr 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MIvcAYR6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF072231C
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510814; cv=none; b=QUEqPK+eSgIARdhS6JUP5Hn/sRBtnFmlDussHnNXQEEXPWfdaPVHjNn4HpP/0GlPGs4fmq2RUhNcwg7jBH55PkDxm1jOrCOwQUw61znf8UJ6z6GXbQKM8Q1p5y7iGkqsp7Y5qDRQHm6OkH8VHULKwa6Iov755NOi6eJyUVDoeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510814; c=relaxed/simple;
	bh=/VqsvBFwghrPLkX3zuCvhWp/gKD/Bee2/h48i5AOCOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaqOzrcGmR8Jf0EKje967XTV07U6gXarTkWNtTjvhqCburwkxo3+b0H+Q6Mf3PFvus1wQqcbcbSbvh/H6AM33GThEuR6D0t5K2F8ZwuMTz2OsdObfpYMv/8o7ijs9IhnP5Un6n55v1QsASN26TeixU9tmMCR3S16AIdN3lAkAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MIvcAYR6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YWay0V2bZ277152w7TiWjmD5EYN7YDnFFqruQZHdvNI=; b=MIvcAYR6UjIBbhakVGRKfQvpar
	gL/cf6Ty+EC66C2/ezJ5VyY+Lu8sQ130gJ7L8ROPPO4aVN4WHS4AUMWt2JKG3yT2XDmS0OYLghyWT
	EjzUBRXP+HeIfNa2UXHzbGWbCACqWSGETKHbKRkKiQodohuZIOKu+BwNLASHu4g9eF+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtWHs-00CQzk-Nx; Sun, 07 Apr 2024 19:26:36 +0200
Date: Sun, 7 Apr 2024 19:26:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/8] net: Add helpers for netdev LEDs
Message-ID: <de7fa561-84b4-420e-b5dd-6105c0560662@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
 <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-4-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-4-eb97665e7f96@lunn.ch>

> +/**
> + * netdev_leds_setup - Parse DT node and create LEDs for netdev
> + *
> + * @ndev: struct netdev for the MAC
> + * @np: ethernet-node in device tree
> + * @list: list to add LEDs to
> + * @ops: structure of ops to manipulate the LED.
> + * @max_leds: maximum number of LEDs support by netdev.
> + *
> + * Parse the device tree node, as described in
> + * ethernet-controller.yaml, and find any LEDs. For each LED found,
> + * ensure the reg value is less than max_leds, create an LED and
> + * register it with the LED subsystem. The LED will be added to the
> + * list, which should be unique to the netdev. The ops structure
> + * contains the callbacks needed to control the LEDs.
> + *
> + * Return 0 in success, otherwise an negative error code.

There is a missing : here, which causes kdoc warnings. I will wait a
couple of days for other comments and then repost with this fixed.

    Andrew

---
pw-bot: cr

