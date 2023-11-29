Return-Path: <netdev+bounces-52167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC37FDAE2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EF1282919
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6437173;
	Wed, 29 Nov 2023 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KBu4vmPw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F6BE
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Ao1fcAglahOTQZ4bf214WWSEO/4jJRkgGDt+9cTqLU=; b=KBu4vmPweonlauaslQW5EmUM4x
	6lNr0lXxIjzqXJWtMc/hjZuwdgqyiGpsHhCkXqsPhpZuYK7EeP60UsSKO9UXYzJYqMlykJWHgE8R2
	QSS3OuhBHDYrKj3ZDTkbL/ZL8uuPOTJ06t1+h+VIe0MG4yMkF6jEgAxWDSAX72rwvgWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8MFI-001aDL-Pn; Wed, 29 Nov 2023 16:13:00 +0100
Date: Wed, 29 Nov 2023 16:13:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
Message-ID: <a0f8aad6-badc-49dc-a6c2-32a7a3cee863@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231129123819.zrm25eieeuxndr2r@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129123819.zrm25eieeuxndr2r@skbuf>

> I am disappointed to see the dsa_switch_ops API polluted with odds and
> ends which have nothing to do with Ethernet-connected Ethernet switches
> (DSA's focus).
> 
> Looking at the code, I don't see why dsa_port_leds_setup() cannot be
> rebranded as library code usable by any netdev driver and which bypasses DSA.
> Individual DSA switch drivers could call it directly while providing
> their struct device for the port, and a smaller ops structure for the
> cdev. But more importantly, other non-DSA drivers could do the same.
> 
> I think it comes as no surprise that driver authors prefer using the DSA
> API as their first choice even for technically non-DSA switches, seeing
> how we tend to cram all sorts of unrelated stuff into the monolithic
> struct dsa_switch_ops, and how that makes the API attractive. But then
> we push them away from DSA for valid reasons, and they end up copying
> its support code word for word.

O.K, i need to think about this.

What is not obvious to me at the moment is how we glue the bits
together. I don't want each DSA driver having to parse the DSA part of
the DT representation. So the DSA core needs to call into this library
while parsing the DT to create the LEDs. We also need an ops structure
in the DSA driver which this library can use. We then need to
associate the ops structure the driver has with the LEDs the DSA core
creates in the library. Maybe we can use ds->dev as a cookie.

Before i get too deep into code, i will post the basic API idea for a
quick review.

	Andrew


