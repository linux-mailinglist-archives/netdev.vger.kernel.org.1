Return-Path: <netdev+bounces-45256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818F7DBBA2
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F842813B7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03E6179A9;
	Mon, 30 Oct 2023 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbi4/tjq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3259179A0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A332C433C8;
	Mon, 30 Oct 2023 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698675841;
	bh=LURC/rLxExQ3bpL0yDbWx8HByNj3zGefLpsyRChzNOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbi4/tjqgp6NsTt9Bvn9HXfbWDEjFvrMUY8hQmzw7deSuJEHllPcUTLi7ZvHf7Mt8
	 9/tfm1EHLJ+VAL02abgN1L1nFYA3f9APuF2aPnwKdQNsZF9uJxzpKTYvv7qJt7ls6c
	 V74ytnNQzA3uXKU/1MkXK2QrdQs5TjsB4x7Q1WBcQxJG1XGj9z14Wgeu8olo07s+TV
	 J+MnXFpC6Uxi0kwx+8C6Mn2t+QiTzJJ+fRBrkp+PmHZCm/tjOswKmTktBMiH4av7jR
	 sAZbYGp7jW3I+QoFouQOB43vQIeJG+g6x4rRk1J4GUl954yS+RY5GiCJqE4w9id49p
	 1Nlufv+ddnkfA==
Date: Mon, 30 Oct 2023 16:23:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org,
	Paulo.DaSilva@kyberna.com, mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <20231030142355.GB5885@unreal>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
 <ZTiu0Itkhbb8OqS7@hera>
 <20231025075341.GA2950466@unreal>
 <j2viq53y3m7z6lj6tkzqxijtavtdfsdnenl2yt2pl4jkqupm6w@aautqnvca6w3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j2viq53y3m7z6lj6tkzqxijtavtdfsdnenl2yt2pl4jkqupm6w@aautqnvca6w3>

On Mon, Oct 30, 2023 at 10:39:18AM +0100, Sven Auhagen wrote:
> On Wed, Oct 25, 2023 at 10:53:41AM +0300, Leon Romanovsky wrote:
> > On Wed, Oct 25, 2023 at 08:59:44AM +0300, Ilias Apalodimas wrote:
> > > Hi Jakub,
> > > 
> > > On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> > > > On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > > > > If the page_pool variable is null while passing it to
> > > > > the page_pool_get_stats function we receive a kernel error.
> > > > >
> > > > > Check if the page_pool variable is at least valid.
> > > >
> > > > IMHO this seems insufficient, the driver still has to check if PP
> > > > was instantiated when the strings are queried. My weak preference
> > > > would be to stick to v1 and have the driver check all the conditions.
> > > > But if nobody else feels this way, it's fine :)
> > > 
> > > I don't disagree, but OTOH it would be sane for the API not to crash if
> > > something invalid is passed. 
> > 
> > In-kernel API assumes that in-kernel callers know how to use it.
> > 
> > > Maybe the best approach would be to keep the
> > > driver checks, which are saner, but add the page pool code as well with a
> > > printable error indicating a driver bug?
> > 
> > It is no different from adding extra checks to prevent drivers from random calls
> > with random parameters to well defined API.
> > 
> > Thanks
> 
> I can see the point for both arguments so I think we should definitely
> keep the driver check.
> 
> Is there a consensus on what to do on the page pool side?
> Do you want me to keep the additional page pool check to prevent
> a kernel crash?

I don't want to see bloat of checks in kernel API. They hide issues and
not prevent them.

> I mean the mvneta change was also implemented with this problem
> and it leads to serious side effects without an additional check.
> Especially if the page pool ethtool stats is implemented in more
> drivers in the future and the implementations are not 100% correct,
> it will crash the kernel.

Like many other driver mistakes.

Thanks

> 
> Best
> Sven
> 
> > 
> > > 
> > > Thanks
> > > /Ilias
> > > 

