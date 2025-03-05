Return-Path: <netdev+bounces-172167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B59AA50705
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADC3173E52
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777172517B1;
	Wed,  5 Mar 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hytC9W9P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361D251785
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197168; cv=none; b=pS0VjRqEzg/OmCukXc1NoBEES7wloqg85BxO8ha7isbCvtW6fl2QyGz8vJ8yXw0OgrduuenF+57BU4WkKyqClm5lNFO7IZUzCDlgc6oFsBywNB3f2iRFd99fFh6zXiy1l07c1lcEN1CIc4JVl5+Wl9lbBcnUEQ3/QW3Q0q0OGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197168; c=relaxed/simple;
	bh=7H1zFJgxS671346J7N9EeBQL60PvtjXzQ1/keHz3aiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv6gviTOSydq8W49hE6uGFMWzUggro89M9hyMB73uawsn9X6DRIwC4Rbe2XEPFKi+OinUU8nyrJSjs5AtJCfIBjErT6bHYPiVLvHMwo0L0xTCPhKLdrWX/c8ogCqKEnYdYUWUNsguynyFi6Tw9Z8wE4fzVDRZo1aLQlSmZBS0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hytC9W9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C3C4CEE2;
	Wed,  5 Mar 2025 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197167;
	bh=7H1zFJgxS671346J7N9EeBQL60PvtjXzQ1/keHz3aiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hytC9W9PhxCO+dbClcB7nVSDQvzf15X1puRMywM/MD4NtPLoBtHGJXtSCk9PffZEv
	 KTAnx/Ghyx40KA/1Hc9Ly6GFMZyjlB9FWpre4mSYTLo3AIxECPlyqI7mzTQD79/MMu
	 JAStuotA+0EoWZ1iU5kZMxQuXMAeSB9Kw0I0fu+8M7FZHa11N2ApJ6TigmaLwnTrpX
	 QgZZQuM4MPfWPVjUwA5kMSX4ilYtMSNaHRuVIJeCuYOc/yCmjaZ8p9MnRADnQYyzpc
	 iferI7xpRm1+OkeKxhm5lDEFrtSSbher14lx0aKqs0UZzq49yxPqaVYDws9PlDDay8
	 4QYiOIbF15Riw==
Date: Wed, 5 Mar 2025 19:52:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"Arinzon, David" <darinzon@amazon.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
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
Subject: Re: [EXTERNAL] [PATCH v8 net-next 5/5] net: ena: Add PHC
 documentation
Message-ID: <20250305175243.GN1955273@unreal>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <a4be818e2a984c899d978130d6707f1f@amazon.com>
 <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>
 <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>

On Wed, Mar 05, 2025 at 04:35:48PM +0100, Andrew Lunn wrote:
> > If you read the actual code in that patch, there's a hint though.
> > Because the actual process in ena_phc_enable_set() does the following:
> > 
> > +	ena_destroy_device(adapter, false);
> > +	rc = ena_restore_device(adapter);
> > 
> > Is that actually tearing down the whole netdev and recreating it when
> > the PHC enable is flipped?
> 
> Well Jakub said it is a pure clock, not related to the netdev. 

So why are you ready to merge the code which is not netdev, doesn't have
any association with netdev and doesn't follow netdev semantics (no
custom sysfs files)?

Thanks

