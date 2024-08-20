Return-Path: <netdev+bounces-120301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8F958E18
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658C91F21E14
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28C146D6B;
	Tue, 20 Aug 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz+iFhM8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD23EAC5;
	Tue, 20 Aug 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178821; cv=none; b=ICWW4MGNHShHyrcli2BabMGFdRyVNHWydSsvu1GtRjfFOaQ7d9GmexhGpLn83Pd1EseXoRBA3aOc0ZN9YCQbAm2JprJGZVOXgq5FGIo0Lwxb9CsgAE44STCgEUFh4EhBKt+hcahgZWfmwAoUP4Mo2pNIp8BeIOrDYfbMIZMY3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178821; c=relaxed/simple;
	bh=HOynmsngE3UkqL88UINGscqF08HnLAab0FpdwkbJdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYVtwRElz5AhE+zIG0D9jRksjDMG3IPyTCrwMKuQnbCOAbC9yzPQPkzYEGfmCTyzh6hVCM/0qnKifX0aOtXfr4kce3BSDkePLZhiVp74VYIzU7WHiW2zFUpcbXoAEc1V1U4kEAi4s4UCwbnFKQbiSjsW0o1ovz2HTz1kZZqW4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz+iFhM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DA1C4AF0B;
	Tue, 20 Aug 2024 18:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724178820;
	bh=HOynmsngE3UkqL88UINGscqF08HnLAab0FpdwkbJdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz+iFhM8jJT+4IW7O3cA6zMJ1cHj8l7TGeCiHBo8qbua4eIeDYc+V7r/2mExZfX5Q
	 z9gy7iQyvQ5DSRLBL0Ewt2S4aXzTINFNLLgwa1/IsDoZkzyrHrLaqwl9pnpfn99YwZ
	 iJsTtzOflQ6VpSnPJTQZn0wwXAfY5+i10xA3sXRZELtPo2JOSX4uh0fAB5mzmsdHTm
	 2d4OlV30rqIRIMmWLLiVEytmquHXzCV8NQKsQGHaT9w5uinAVtUm1MCzNd+O0tCPJI
	 oIFBf5+zzaZTr+71VXmyANwxecilwZDz2rWHxu5EEEHJGxWDPNIATjLtGvtgZ3DjPB
	 bQHgLFozhPa+g==
Date: Tue, 20 Aug 2024 19:33:35 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [net PATCH v2] octeontx2-af: Fix CPT AF register offset
 calculation
Message-ID: <20240820183335.GB2898@kernel.org>
References: <20240819123237.490603-1-bbhushan2@marvell.com>
 <20240819152744.GA543198@kernel.org>
 <CAAeCc_ngtvx7LNWB2CMgfA6Vyitx8BTZbahJby+ZDgTEC5JYbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeCc_ngtvx7LNWB2CMgfA6Vyitx8BTZbahJby+ZDgTEC5JYbA@mail.gmail.com>

On Tue, Aug 20, 2024 at 04:37:02PM +0530, Bharat Bhushan wrote:
> On Mon, Aug 19, 2024 at 8:57 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Aug 19, 2024 at 06:02:37PM +0530, Bharat Bhushan wrote:
> > > Some CPT AF registers are per LF and others are global.
> > > Translation of PF/VF local LF slot number to actual LF slot
> > > number is required only for accessing perf LF registers.
> > > CPT AF global registers access do not require any LF
> > > slot number.
> > >
> > > Also there is no reason CPT PF/VF to know actual lf's register
> > > offset.
> > >
> > > Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > ---
> >
> > Hi Bharat,
> >
> > It would be very nice to have links (to lore) to earlier version and
> > descriptions of what has changed between versions here.
> 
> Hi Simon,
> 
> Will add below in next version of this patch

Thanks, much appreciated.

> v3:
>   - Updated patch description about what's broken without this fix
>   - Added patch history
> 
> v2: https://lore.kernel.org/netdev/20240819152744.GA543198@kernel.org/T/
>   - Spelling fixes in patch description
> 
> v1: https://lore.kernel.org/lkml/CAAeCc_nJtR2ryzoaXop8-bbw_0RGciZsniiUqS+NVMg7dHahiQ@mail.gmail.com/T/
>   - Added "net" in patch subject prefix, missed in previous patch:
>     https://lore.kernel.org/lkml/20240806070239.1541623-1-bbhushan2@marvell.com/
> 
> 
> Thanks
> -Bharat
> 
> >
> > Using b4 to manage patch submissions will help with this.
> >
> 

