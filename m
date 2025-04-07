Return-Path: <netdev+bounces-179663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ECA7E097
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA60A189C1FB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960571B653C;
	Mon,  7 Apr 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oV8ALXIB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5561C6FED
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034574; cv=none; b=S9FyV3vHWus0V36BAvhpZw7MSGWDC/9HDI1oOF+z/rFV2oAwuERF41uo87hz2k+Rei4YntwGiP1003RY7FEG41PAE7bSIdFyLSjInKygFo9VnU7nt8qJsiuLI1f0TiiOu1GljInOsdRwbU77mlHrlUCtIwfS85rFWzhWEifrXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034574; c=relaxed/simple;
	bh=HxGhoNtlDfP6hpjpwJ6XLIxLlAlP8zHYq+tw4sXt/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS/Ro2xJOFCFKWX1th4v1U1nd04I/QnaQDQ5jeZPu8AGlQuZ6UMI+oxA0uCJDxyDuP7hC2kHYcdrtLkYgqj8fr4vDdtqdKvBtD69eF7p6TWwcXMOwfV5v3N0SLgoLppNympAFFvyO/4sAPaU1rQEemk42y3Wh9fDlB39hqAsX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oV8ALXIB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hTBgqkMriWAkHZtnMiMpJOXFutxVKurvl1Qd1YuYFAc=; b=oV8ALXIBz42bR27ZTJHiA5JxzL
	3m2XQRe5jkyah6Ls0VB91a0uHqDJJOjgon/T9UYHWYliytQJFzs7LnJJNVIhVvpRK65PU16UcqE60
	4HCW+RbBi9yu5F0xLGHvEKDLRc7h7cB3YmaWon/jk6/kr4jVcErenu6reputFtO1p+Xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1n3Z-008EwU-KP; Mon, 07 Apr 2025 16:02:33 +0200
Date: Mon, 7 Apr 2025 16:02:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Leon Romanovsky <leon@leon.nu>, Jakub Kicinski <kuba@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Allen, Neil" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
 <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
 <20250402092344.5a12a26a@kernel.org>
 <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
 <f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37057d315c34b35b9acd93b5b2dcb41@amazon.com>

On Mon, Apr 07, 2025 at 07:01:46AM +0000, Arinzon, David wrote:
> > >> > I think the sysfs control is the best option here.
> > >>
> > >> Actually, it occurs to me that the best option is probably a module
> > >> parameter. If you have to take the network down and up to change the
> > >> mode, why not just unload and reload the module?
> > >
> > > We have something called devlink params, which support "configuration
> > > modes" (= what level of reset is required to activate the new setting).
> > > Maybe devlink param with cmode of "driver init" would be the best fit?
> > 
> > I had same feeling when I wrote my auxbus response. There is no reason to
> > believe that ptp enable/disable knob won't be usable by other drivers
> > 
> > It's universally usable, just not related to netdev sysfs layout.
> > 
> > Thanks
> > 
> > >
> > > Module params are annoying because they are scoped to code / module
> > > not instances of the device.
> 
> Hi Jakub,
> 
> Thanks for suggesting the devlink params option for enable/disable, we will
> explore the option and provide a revised patchset.
> 
> Given the pushback on custom sysfs utilization, what can be the alternative for exposing 
> the PHC statistics? If `ethtool -S` is not an option, is there another framework that
> allows outputting statistics?
> We've explored devlink health reporter dump, would that be acceptable?

We seem to be going backwards and forwards between this is connected
to a netdev and it is not connected to a netdev. You have to destroy
and recreate the netdev in order to make us if it, which might just be
FUBAR design, but that is what you have. So maybe ethtool -S is an
option?

Or take a step back. Are your statistics specific to your hardware, or
generic about any PTP clock? Could you expand the PTP infrastructure
to return generic statistics? The problem being, PTP is currently
IOCTL based, so not very expandable, unlike netlink used for ethtool.

	Andrew

