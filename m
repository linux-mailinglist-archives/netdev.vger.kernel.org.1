Return-Path: <netdev+bounces-146428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729859D35BA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0585DB23EAC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067B17E46E;
	Wed, 20 Nov 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S3N26LNU"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF8848C;
	Wed, 20 Nov 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092230; cv=none; b=RFNKjJFhtn9x1eRcl9UZ4sMt7nCkYdO78gIf8rCKrMFymQe7wwqZgZR9+pnlohw7n7tsX7uATi13I+RZ9hv6B+KBThROfzfquV6yzp+igaKWDMUjJzVt7Ss4xSFm5nCv4TMImTPttC4SBOiAFM+cICnaeYIPewk5MJyWJO99jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092230; c=relaxed/simple;
	bh=s7HZN9wqRJTa3F166GZNhsc7AcNOq15GYt2NgWafsdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eojDctPgJmhYis6fm/R+OEVvrkVwkN7iNoaLn4InVQFPHpKsIyd8uMmM0Lowq2FqTZtIhmIRCTFgaBvT7QqT9/tHzTs3vuOzAEbOkeRp3XgwnFEAAxC1rxaaREAXQUV5EdhyJEkbcPTRMHRz62gXJHzNExPv6/jIaTLApNhP4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S3N26LNU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 990346000F;
	Wed, 20 Nov 2024 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732092220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Stw1ZeJMKJorc1lwBQ/6FvPBootFID/HdRZ4NSNz5E=;
	b=S3N26LNUg+yg4Gfy6ATW+vUqdJuEV2u5/+u4AK1NRHLMMu6ElvUZ+OYjtWGDzzHXUEV7dj
	FZLMmAPGySelqyxEnTsln7iqvrYUr+I0lL4ox+5rhA+zRSaxVUlZ5bA5pRNzMfXFlmLZqQ
	NjzKeS6NhpIuQ8wNBaN736iGKLjTDIw4X8eU9NwVAY34kjOXSF1coM5KNTFQPGfQ7sLQes
	qOiKCuim7BQaMrbHAlZOeZ8CH3R7GWuWS0bKZNsJ5tlDNQsKNYbcZsTNaubAlLzfMac+oT
	MMRjOBXrAmGlVq4QDcOl+PPJNYLOimVyFdSX46ctYavffMkMjdDkgHyA6eLnvQ==
Date: Wed, 20 Nov 2024 09:43:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 01/10] net: freescale: ucc_geth: Drop
 support for the "interface" DT property
Message-ID: <20241120094336.22f95926@fedora-2.home>
In-Reply-To: <20241115121914.GL1062410@kernel.org>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
	<20241114153603.307872-2-maxime.chevallier@bootlin.com>
	<20241115121914.GL1062410@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Simon,

On Fri, 15 Nov 2024 12:19:14 +0000
Simon Horman <horms@kernel.org> wrote:

[...]
> > @@ -3627,18 +3588,17 @@ static int ucc_geth_probe(struct platform_device* ofdev)
> >  	/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
> >  	ug_info->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
> >  
> > -	/* get the phy interface type, or default to MII */
> > -	prop = of_get_property(np, "phy-connection-type", NULL);
> > -	if (!prop) {
> > -		/* handle interface property present in old trees */
> > -		prop = of_get_property(ug_info->phy_node, "interface", NULL);
> > -		if (prop != NULL) {
> > -			phy_interface = enet_to_phy_interface[*prop];
> > -			max_speed = enet_to_speed[*prop];
> > -		} else
> > -			phy_interface = PHY_INTERFACE_MODE_MII;
> > -	} else {
> > -		phy_interface = to_phy_interface((const char *)prop);
> > +	prop = of_get_property(ug_info->phy_node, "interface", NULL);
> > +	if (prop) {
> > +		dev_err(&ofdev->dev,
> > +			"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
> > +		goto err_put_tbi;  
> 
> Hi Maxime,
> 
> This goto will result in err being returned by this function.
> But here err is 0. Should it be set to an error value instead?
> 
> Flagged by Smatch.

arg yes you're right. I'll address this in the next iteration.

Thanks,

Maxime


