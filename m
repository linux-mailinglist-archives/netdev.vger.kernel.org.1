Return-Path: <netdev+bounces-79395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EE878F9B
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFADA1F21887
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92969D00;
	Tue, 12 Mar 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="uDQct1sW"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97F6997E
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231736; cv=none; b=roZ09vUuWq7HXCtSrmfu+Ahcxmu28IRQmsnGTeDNtO0QNAFnaxV/2nRG7+OqbWmWfokU5x6ZaXlUubQeEiMx0EWmSGGxFyRpy5nEcTZ2sXo9DZDVbEXiwbp/cMt8K/IjRupUZUvkAWX30ceAad793aGSfMFw9k8hoFpb8jOo73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231736; c=relaxed/simple;
	bh=ocnfBw9s9NdEsh0cXrfgz6rAXjlFH8k5MagF3W7Gizs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ozzLF7apB/YbWlMi5ZC43B/lbUQNgo8D0Ssc0T69d/+1EiEen+Q6Ks90pa6GydDR12roZ+o572ZwFb2ZODTjP3t3Bd+AT1y2IEIbl3f9DBqSEy4KjmeKnYNtwFaYc4pSR7OwNgNGXrCwkVqHa99w3I8OPPrJfFlCCNGM8Tn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=uDQct1sW; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:6a9a:1db7:4d8d:d1a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id C22396023D;
	Tue, 12 Mar 2024 09:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710231730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6eXsFxLFxfdVKvdFRJhhqA9qgh76+a5sExwyl+fWhs=;
	b=uDQct1sW4BOHQrZ5FKkZfezcEOF+dieBHM1ESX354tMKTX/X+KHC/qFaMAGOa8DeMs6/VS
	/xBh57zJLCMwT45fFetgqfE9utwu5TCM8726u3+fJP2HgkA7g0xizRGXo4u0am2Q5eb/om
	vCNtLs0NZtTTHj6YS/K3nKFuNPidvSSOUXZ8LMdoCRkmarjIYiUGYicXaJrT4iClxaBCyb
	7QQWrlwOIjwoHnUtEkMDBOUnRl9qZkGbKmaRI+LNqM0e1nr0id6SbCna1sGoHWgxrwKeD3
	bLZs+NgkS7tCazbBt5TvHCLLJngE8PuQbZ5pRoAurW+TmWffY87mvDel12gDuw==
Date: Tue, 12 Mar 2024 09:22:20 +0100
From: Max Gautier <mg@max.gautier.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <ZfAQvGTYe7eBcY3e@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
 <20240311124003.583053a6@hermes.local>
 <Ze-Fj2RwYnM0WgWi@framework>
 <20240311183007.4a119eeb@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311183007.4a119eeb@hermes.local>

On Mon, Mar 11, 2024 at 06:30:07PM -0700, Stephen Hemminger wrote:
> On Mon, 11 Mar 2024 23:28:31 +0100
> Max Gautier <mg@max.gautier.name> wrote:
> 
> > On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:
> > > On Mon, 11 Mar 2024 17:57:27 +0100
> > > Max Gautier <mg@max.gautier.name> wrote:
> > >   
> > > > Only apply on systemd systems (detected in the configure script).
> > > > The motivation is to build distributions packages without /var to go
> > > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > > outside of /usr on boot).
> > > > 
> > > > The feature flag can be overridden on make invocation:
> > > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > > 
> > > > Links: https://0pointer.net/blog/projects/stateless.html  
> > > 
> > > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.  
> > 
> > The commit introducing the install of that directory is quite old
> 
> The problem is that build environment != runtime environment for embedded systems.

That's the same for anything detected by the configure script, right ?
Hence the override capability.

> But arpd really is legacy/dead/rotting code at this point.

Yeah I can see that, not touched since 2016 (mostly). You would rather
just drop it ?

-- 
Max Gautier

