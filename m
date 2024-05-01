Return-Path: <netdev+bounces-92795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD48B8DC6
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF933B246C5
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365D12FF78;
	Wed,  1 May 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y6RCaAGM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C712F37C
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579733; cv=none; b=KZA+g5BvV+2/7E8Fvayu5Z+2RjtPAPn2ZBKG+NUqriFc1xFZ4MasvIIO3/SUsP5iCWatZNJ9oKEnVnHmtUqn58rFqLWStkm/veUroP5kERwXNqhQ9w0saIp+qpeH0G16zWexkYXNKE3lKkLSVAyvEgTbPAIRKt3nrxfVVlRnEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579733; c=relaxed/simple;
	bh=+VEadbv+bcletex4ZU3F70vDHElyd0EyvsjfsK+uSck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKMYEu32ov9b2fiMVbaw1vFxpgnGrPQpn+wJ7uheyKcNOcI/aqTezZsVunZeR9GK2cNa9Hgq2qcZAtrqaJ9UUJUJFw9PjWlJx6dPvQBscvMgrY85Fv+RIImFM1znPCrlHvUkgm11LXClkg0zO0rjLr510h5dwJQPXOf7Q94pIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y6RCaAGM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mA3Njj1fxRUT2Fs0JeXa7R5oyh9TdjrdV+s1GXEqvn0=; b=Y6RCaAGMGIw5uDbgwrwxmuUIz5
	rlzGTC3wu/ad3O3/pDMU8EFRcL7zP572VjE5WWKb2BdR0z9j0vyB8Ww7Mu77iVmox6A57QJGea4MT
	M0Llrs2dimW8bZ5Im0M2CR3zK5MaOcGiUfyheJCNnGTDciJaR2J0oVVLBye6+ttANEx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2CVk-00EREo-EX; Wed, 01 May 2024 18:08:48 +0200
Date: Wed, 1 May 2024 18:08:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: tn40xx: add basic Rx handling
Message-ID: <1cbbc4df-fdf8-4ef2-b332-bf3334e9d2b9@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
 <20240429043827.44407-5-fujita.tomonori@gmail.com>
 <20240429202713.05a1d8fc@kernel.org>
 <20240501.151616.1646623450396319799.fujita.tomonori@gmail.com>
 <20240501063405.442e0225@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501063405.442e0225@kernel.org>

On Wed, May 01, 2024 at 06:34:05AM -0700, Jakub Kicinski wrote:
> On Wed, 01 May 2024 15:16:16 +0900 (JST) FUJITA Tomonori wrote:
> > > drivers/net/ethernet/tehuti/tn40.c:318:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > >   318 |                            dm->off, (void *)dm->dma);
> > >       |                                     ^  
> > 
> > My bad. Fixed. I should have found this warning in patchwork before.
> 
> No you shouldn't have. The patchwork warnings are for maintainers, 
> it's not a public CI.

Expanding on that a bit. Its not a secret patchwork shows some CI
results. What we don't want is developers posting 1/2 baked patches to
the list in order that the CI picks them up and tests them. Hence the
"not a public CI".

We expect developers do their own mechanical build testing before
posting patches. Build with W=1 C=1 etc. Build a couple of different
architectures, ideally a 32 and a 64 bit. Build the documentation,
etc.

Reviewer and maintainer time is limited. So ideally we want the
developer to do the mechanical work, leaving the reviewers to
concentrate on things which cannot be reviewed mechanically, like
architecture, logic bugs, conforming to the processes.

     Andrew


