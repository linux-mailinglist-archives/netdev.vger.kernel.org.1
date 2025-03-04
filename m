Return-Path: <netdev+bounces-171640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609ECA4DF11
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0E177DEB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A620409F;
	Tue,  4 Mar 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LOlTOkGR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5F202F68
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094419; cv=none; b=NlB5ezWu4OnORneBfBP7Hz2FuPRvYJM7sBfUWFaLpzgPoQTPp17EF2lnNTKk1ZIeZrz6Zh5PeuhL7biehHoGsSqCUvepzB/mdFCuafnosFff9OD6gqX2NA1LFjLkiURDfi4/1LcMM3tOiMYUquV+8zAPEW3Xh12GRUbLfnu6rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094419; c=relaxed/simple;
	bh=ePGDKsJQDSGLxx8D6n9vsqq7mbrqfgMDpdpCd/Tvl08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSxJXYpnskfv386joQw+FdVQf5T8PNeFp4/OsOtrSjzKvMJfn1Ao9rq8Bf3Hkf4tDdDUIgssqQUZoU7hV5IEDQ7e76ehWr2ThT2bsYeoyB/xsvgsTHMyPlOGC8LjxnCQzpR+4Uv0fz1U9fIyHpBXlye+wgyroaEge7UvkHFasXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LOlTOkGR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P6eW9J+velEDMHdy8wcj+gbiAHZOqtUjrnLcOSMSrYc=; b=LOlTOkGRKf92hlxi9AV4gmRMaV
	aAMYLVCLGgJ5BpJItmtuQtbon8oSwDpyozFcXt6Z6WySQ858znhFKsvoBj/GVjNCmVJP/2jofUg/h
	KWk5iQm6bdg+88kVcV+OX2aWdIWG5veMN8/B2KgCKpft1UWdvqtZt54Q7F8c2hxangeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpSBm-00292F-Lv; Tue, 04 Mar 2025 14:20:02 +0100
Date: Tue, 4 Mar 2025 14:20:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, ltrager@meta.com,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for
 PHY loopback
Message-ID: <3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
 <20250227203138.60420-3-gerhard@engleder-embedded.com>
 <20250303173500.431b298e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303173500.431b298e@kernel.org>

On Mon, Mar 03, 2025 at 05:35:00PM -0800, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 21:31:32 +0100 Gerhard Engleder wrote:
> > phy_loopback() leaves it to the PHY driver to select the speed of the
> > loopback mode. Thus, the speed of the loopback mode depends on the PHY
> > driver in use.
> > 
> > Add support for speed selection to phy_loopback() to enable loopback
> > with defined speeds. Ensure that link up is signaled if speed changes
> > as speed is not allowed to change during link up. Link down and up is
> > necessary for a new speed.
> 
> Hi Andrew, does this one look good to you? I see your review tags 
> on other patches :)

Sorry, dropped the ball on this patchset.

I actually think there needs to be a step back and look at the
requirements and what others are doing in the area.

Jijie Shao is doing similar things:
https://lore.kernel.org/lkml/20250213035529.2402283-3-shaojijie@huawei.com/

Both run into the same limitations of the current code, being able to
compose tests from what we currently have.

And then there is what Lee Trager is doing:
https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html

There is some overlap with the work Lee is doing, i assume he will
need to configure the link mode the PCS is using, which is the
scalability issue you raised with previous versions of this patchset.
And configuring the PRBS in the PCS is not so different to configuring
the packet generators we have in net/core/selftest.c.

The current IOCTL interface is definitely too limiting for what Lee
will need. So there is a netlink API coming soon. Should Gerhard and
Jijie try to shoehorn what they want into the current IOCTL handler,
or help design the netlink API? How can selftest.c be taken apart and
put back together to make it more useful? And should the high level
API for PRBS be exported through it, making it easier to use for any
netdev?

	Andrew



