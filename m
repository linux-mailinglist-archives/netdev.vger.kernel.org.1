Return-Path: <netdev+bounces-118034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF89505DA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F69283559
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967319938D;
	Tue, 13 Aug 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOHZEs3g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815644C8C;
	Tue, 13 Aug 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554362; cv=none; b=ngGqVM0t3Kigqkp4Lgjauox4WJRm8niFthLpOHAbF0/lfaHKlB20z2WkRO+06f8TGLizRCJ0LoMxhQCK/OtscC6QS+xcRl8mFlreyxyZzvFxR7okCXXUbk6MeXQI60jTP7/NMVmnhSkGKCcaNmaHqcv/KGCuW2AyMeSxebX2l1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554362; c=relaxed/simple;
	bh=z0/J+rknn+ERlf5qhUrQ2PI+OXA6YnEcKi9BS6uaEKU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmy1J0KcLP0GbZoD/a9aK2XPosfC3DG5ygLTFJyotntbydSxHgWa2idVuzI3x3sU62Zqvb87X8qcgD/A6zwDmtW3s9Li9Buq7U9HveVgWcQwJjHe4EdqoRgkli0A8YAPwV6sGttmYyqNXRyyjdUkMJNezgwKlSi1v5QWmXmeGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOHZEs3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA80C4AF0B;
	Tue, 13 Aug 2024 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723554362;
	bh=z0/J+rknn+ERlf5qhUrQ2PI+OXA6YnEcKi9BS6uaEKU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=MOHZEs3gpEO9j923e5xNFqew1WU4DIV3Uhc5sIR0Dh7JMp9OJB4ibyP46I+dg+hbI
	 aC1srjtED0ne3HOtnRLrnqclhWlEY/bEW59T0hg+ojzUaz7bwb/Osw3oK6C8G+BkID
	 zbi4xr2FRjdjgMXg10oXEf1iJ87mjQX2wfRH5rg1tLgpkkeYlwz0p1maM1k3sBPM7l
	 J7BTm0nFw6Jh8tdFchyQQOG7vUT7CtzpL5citv6Vvul4duz4SEhODygBed529wSDjm
	 +QPV4qnv6B9C8EQwcWDa2LjIhirnR+xx52KeKqEa6saWJqqBDfnHLt7s7QmmTJjiSS
	 SEwpRD0KwHWxQ==
Date: Tue, 13 Aug 2024 14:05:56 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <20240813130556.GD5183@kernel.org>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-2-jdamato@fastly.com>
 <ZrpvP_QSYkJM9Mqw@mini-arch>
 <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>
 <ZrqOekK43_YyMHmR@mini-arch>
 <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>

On Tue, Aug 13, 2024 at 10:11:09AM +0100, Joe Damato wrote:
> On Mon, Aug 12, 2024 at 03:36:42PM -0700, Stanislav Fomichev wrote:
> > On 08/12, Joe Damato wrote:
> > > On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> > > > On 08/12, Joe Damato wrote:
> > > > > Several drivers have their own, very similar, implementations of
> > > > > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > > > > to centralize this logic in the core.
> > > > > 
> > > > > This will be used in following commits for various drivers to eliminate
> > > > > duplicated code.
> > > > > 
> 
> [...]
> 
> > > > > +bool napi_affinity_no_change(unsigned int irq)
> > > > > +{
> > > > > +	int cpu_curr = smp_processor_id();
> > > > > +	const struct cpumask *aff_mask;
> > > > > +
> > > > 
> > > > [..]
> > > > 
> > > > > +	aff_mask = irq_get_effective_affinity_mask(irq);
> > > > 
> > > > Most drivers don't seem to call this on every napi_poll (and
> > > > cache the aff_mask somewhere instead). Should we try to keep this
> > > > out of the past path as well?
> > > 
> > > Hm, I see what you mean. It looks like only gve calls it on every
> > > poll, while the others use a cached value.
> > > 
> > > Maybe a better solution is to:
> > >   1. Have the helper take the cached affinity mask from the driver
> > >      and return true/false.
> > >   2. Update gve to cache the mask (like the other 4 are doing).
> > 
> > SG! GVE is definitely the outlier here.
> 
> OK, I'll hack on that for rfcv2 and see what it looks like. Thanks
> for the suggestion.
> 
> Hopefully the maintainers (or other folks) will chime in on whether
> or not I should submit fixes for patches 4 - 6 for the type mismatch
> stuff first or just handle it all together.

<2c>
Patches 4 - 6 seem more like clean-ups that fixes to me: they aren't fixing
any bugs are they? So I would just keep them as part of this patchset
unless it becomes unwieldy.
</2c>

In any case thanks for all your good work in this area.

