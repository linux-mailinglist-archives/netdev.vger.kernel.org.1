Return-Path: <netdev+bounces-177922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A73A72EA4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D691E1899BC3
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8D211A27;
	Thu, 27 Mar 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWkLU7LT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFE1FF7BC
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074130; cv=none; b=r7fMou8PtdGifsqhkpNgvPTcL6YuLII/8vlX3/XN0xqnI0UOKmDWYvnBBZokMACAd0sr9RPEHdrO9gqI6nEH+ofWXkcqU995UWcLFFG/hvR7zcVs2+rj3Scr5ltwQ4meYrz3P9lI3wn4NUkYmg94dTmGtkXNV4idYeHVZCt5tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074130; c=relaxed/simple;
	bh=ZRDeevv7juYSUNcSFoIuUECMR06lYDL61aLJ3d1sLQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdaM0mv/p0wAbSm0jNYiTI1pjsd/11265SkEdXBngGxmLEQjTcS87zGW12oxwAnf+yDVHGMpm0zgDLNEP6/ckE1N1o4/68wZHbPsd1NP6BokHU5YcaKtzs6rZKuQ1EGPFmMe3RZH2oiekZrKcAoedAN5PmEDSYP4hMcK2cZL8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWkLU7LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9354C4CEDD;
	Thu, 27 Mar 2025 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743074129;
	bh=ZRDeevv7juYSUNcSFoIuUECMR06lYDL61aLJ3d1sLQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWkLU7LTb25/rHxTRBYgCxqQA0wsJaUWtUSB0LF9hWm0e8ZP6n09AK6myWUWasoJ3
	 nfZcGt4Jw24vt7nhYR5+OsIF4LtRJVSgoLyRXjdzF5A8J2EMsRuqdjE936nZDrFu1H
	 zjpESR6JQGNinBTkfYXWKM4DEESMsh3MyTLhfXE7m2wMASg6OMY0Bj/0MeZAsYXOwq
	 iwqB/Nic4swuj123HFKK1667y5mQcVSUf6Lxv3fIP/HlSd1bnbUM6UQ8dG7k/mfl2A
	 MtOxBJBaqK+4MDa6694QhAEBZFNqLMOKSuIfL903MA4sbNIgTMYMLzi7Y+2e0S/Sa8
	 E37Pkfz0LYySA==
Date: Thu, 27 Mar 2025 13:15:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <20250327111522.GA21758@unreal>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <a4be818e2a984c899d978130d6707f1f@amazon.com>
 <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>
 <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>
 <20250305175243.GN1955273@unreal>
 <db859110a34d440fb36c52a7ff99cb65@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db859110a34d440fb36c52a7ff99cb65@amazon.com>

On Wed, Mar 26, 2025 at 03:32:00PM +0000, Arinzon, David wrote:
> > > > If you read the actual code in that patch, there's a hint though.
> > > > Because the actual process in ena_phc_enable_set() does the following:
> > > >
> > > > +   ena_destroy_device(adapter, false);
> > > > +   rc = ena_restore_device(adapter);
> > > >
> > > > Is that actually tearing down the whole netdev and recreating it
> > > > when the PHC enable is flipped?
> > >
> > > Well Jakub said it is a pure clock, not related to the netdev.
> 
> The PHC device is a PTP clock integrated with the networking device under the same PCI device.  
> As previously mentioned in this thread, enabling or disabling the ENA PHC requires reconfiguring the ENA network device, 
> which involves tearing down and recreating the netdev. 
> This necessitates having a separate control knob.

I appreciate the desire to keep everything in one place and provide
custom, vendor specific sysfs files. However, there is standard way
(auxbus??) to solve it without need to reinvent anything.

Thanks

> 
> Thanks,
> David
> 
> > 
> > So why are you ready to merge the code which is not netdev, doesn't have
> > any association with netdev and doesn't follow netdev semantics (no custom
> > sysfs files)?
> > 
> > Thanks

