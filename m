Return-Path: <netdev+bounces-244170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFDCB10E4
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 21:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1F130AECAB
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4685F2D3237;
	Tue,  9 Dec 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2FHVx10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19820262FC1;
	Tue,  9 Dec 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313437; cv=none; b=p5LgEhFbKCmF0PiyP/llV/WVi5hi83vRrJ+G/Blvt3qmZoYtPBuVgy4Y8ncTKRnPWxt1qrGKMBlepWuPhIE/c0e3fswnT7bLVUX8Q2ocHw8vvKwj/X7ShssII9xQ4hylEO7Y4kEtduLhey34AMIXQjBkdLaD9q7Wi2EyPfqD9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313437; c=relaxed/simple;
	bh=+NrxrvZMgkcpBUKcfznjEv3pgGvqP8bd/L6BGqUssYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOhbSWH3JHl13uVu3mcpug3HSamZtSN2eUQiHnprJEsrE5wC/Fnr0BEQZQnKTl7uUPy18A9NSshyGU/o/l0Z60DFwiR+BDHnPJVmGaBc9/1OjF1U0d9IaBj/RoRGtNQlibEecCJFyYwdEs64AZ+0JfFXbPNIEGDT6FJET9MGRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2FHVx10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA14C4CEF5;
	Tue,  9 Dec 2025 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765313436;
	bh=+NrxrvZMgkcpBUKcfznjEv3pgGvqP8bd/L6BGqUssYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2FHVx10lU9ymJ024KMK22dlyRk155qhGloao/pSRz4jhhFpXovieBQvErMqIjWb0
	 AdZYlCm48RH3jrzdGsS/A55Wdu3GDDkl+qUTLvPs0cg1bd27lhDg6VjF4eyQtc9Pv7
	 ucRGmTR5z070mWSQ0GBmGg/MF17WszEWWkJA8b7e+bvOBrI8mFv8yg92qsOdtvQv0M
	 fsUjo5De94mBVOfFI1b3L7nVyZbOFGz60p5XuV1v/cjaI8zRQnF7Z6a4UX1Q8q98YJ
	 RO6IGfa/XlMnaLYkxPSQ1XFordW8jMm90tsWcYYLbYfoot2Y8PoiZ3n0nYeQ3yOJ0Z
	 buLKTnh/ZOkGA==
Date: Tue, 9 Dec 2025 14:50:34 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <20251209205034.GB1056291-robh@kernel.org>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
 <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>

On Sat, Dec 06, 2025 at 07:30:30PM +0100, Andrew Lunn wrote:
> > @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >  		priv->rxdes0_edorr_mask = BIT(30);
> >  		priv->txdes0_edotr_mask = BIT(30);
> >  		priv->is_aspeed = true;
> > +		/* Configure RGMII delay if there are the corresponding compatibles */
> > +		err = ftgmac100_set_internal_delay(priv, &phy_intf);
> > +		if (err)
> > +			goto err_phy_connect;
> 
> Thinking forward to when you add 2700 support, i really think you need
> to break the probe up into helpers for 2500 and before, 2600 and in
> the future 2700. You currently have a couple of tests on the
> compatible which you can reduce to one.
> 
> In fact, this driver has 10 calls to of_device_is_compatible(). I
> think you should first refactor the code to list each compatible in
> ftgmac100_of_match[], and add a data structure which contains an enum
> of the MAC type. You can then transfer this to priv, and replace all
> the of_device_is_compatible() tests to just look at the enum value.

Better yet, define a structure which defines the different settings 
directly. Such as:

priv->rxdes0_edorr_mask
priv->txdes0_edotr_mask
priv->is_aspeed

And anything else needed...

Rob

