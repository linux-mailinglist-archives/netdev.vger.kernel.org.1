Return-Path: <netdev+bounces-164525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049AA2E1BC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1221885EA5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C975258;
	Mon, 10 Feb 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tJ+Ysb81"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF423CB;
	Mon, 10 Feb 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147284; cv=none; b=G3/Fw0s+B/RVqQA00kqAgI6YWp82u0vK28DPPYQY9EFnzadAWp9FB3bbLLmxoiy8FE2DDUIODnLj3GMgXdgfcgQox62lCXOKKgeA8cZF8F+SyHZtfPFS/vHl4E4/3oKeqzq4iwzMIGvsQpGhSRyUSiZ9jjnBf1vA9WBhkjzf2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147284; c=relaxed/simple;
	bh=fvqZn3dds/2vc743MN+NhZL253B6zh0m/oJAf86dSQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKU4iZfm5CgCUiPzlRzx7ztDj0nFtBxuQHWS2jZubO35aujnptKsv8X7zgCeQdx9a0kKgAZ2nqIY3qYbFdl7Sw3TLVEOTH3INuk0dnZ5tivR/h9FJTeJzLezo2EHn5HrVS4Rfc2xBVHaEP/Al27MOuSPxuU3fC3d2RmutrpZK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tJ+Ysb81; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9+OuQB8vrs+CeMFvejhrtScCH5/Bhssr04jN9BqY/Ig=; b=tJ+Ysb81mPEctH9wES4dKgtK5b
	ix/tJ/3uqz7VeeEMP7zC9Q9lSy/eyasx8tlX2rH+ci5buSImWKcmcJESC4RMWeCRQAzxLhSeqYTGW
	CnzJ4otjw6eLvSEnyOzwds+qINFWKWjJzqH/f+fJorCDWmUVIn727rDo+fRZ8WSxzULI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thHeP-00CYAE-Nu; Mon, 10 Feb 2025 01:27:49 +0100
Date: Mon, 10 Feb 2025 01:27:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell-88q2xxx: Add support for
 PHY LEDs on 88q2xxx
Message-ID: <bc53a976-fa27-488b-9891-658014550950@lunn.ch>
References: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>
 <Z6eJ6qPs7ORuOrbt@eichest-laptop>
 <20250209084135.GA3453@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209084135.GA3453@debian>

On Sun, Feb 09, 2025 at 09:41:35AM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> Am Sat, Feb 08, 2025 at 05:44:26PM +0100 schrieb Stefan Eichenberger:
> > On Fri, Feb 07, 2025 at 05:24:20PM +0100, Dimitri Fedrau wrote:
> > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > uses with the 'netdev' trigger.
> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > 
> > Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
> > 
> 
> thanks for reviewing. I just noticed that led0 is enabled in
> mv88q222x_config_init, but I think it should be enabled in
> mv88q2xxx_config_init because LED configuration is same for all
> mv88q2xxx devices. What do you think ?

The code looks O.K. to me, so please add my Reviewed-by: Andrew Lunn
<andrew@lunn.ch> if you decide to change to the generic 2xxx.

    Andrew

