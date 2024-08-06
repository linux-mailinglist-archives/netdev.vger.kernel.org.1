Return-Path: <netdev+bounces-116148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDC94946A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF6A1C2172E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4731E182B4;
	Tue,  6 Aug 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UORLM55e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF218D63A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957798; cv=none; b=UXh/LoiPfAMhxu+cDJBzY1CrnE2LQ9vAhCosvuUUTxav6vJja5/iZeHXBiaTOQLkMOgf8reiTKScFVY8gTylpy1hfZsLh9WEHhVDVycpCsSa53aQnd/N6DBlkmg2m6mTpy49PrbiOP/jBcJLfLC4hZ6x4BEBhU/u2+zer5LGHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957798; c=relaxed/simple;
	bh=dj8e2R8tyWQDvrz1BWtiDY5y8Uxw86HtL9MW8WCF2+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJ/KLc4RIqRa8xF5nhgUlD73zz4xlRL/X5iRYV9k5EnuGgtMLzii12ZsjfbxLTSvVqXRnT+0cS0X6sYTwFwCkuv0Yr+p0Fjy5MT08EHZxiwgjxHALxgc+qlVltlIXVTGXI2favRmwkV69TuI+RLYnnwEIMfHH5hzG8OzZoPa/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UORLM55e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EEDC32786;
	Tue,  6 Aug 2024 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957797;
	bh=dj8e2R8tyWQDvrz1BWtiDY5y8Uxw86HtL9MW8WCF2+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UORLM55eKImvQouYLRC2zZql01FLpcXazmB6ewrivEf7FBdMVDqpMNXOR+HWML7mO
	 JAX/tI3JETq4isddoEpUx1B/pIpxPHCW/o9oCgeMLolHtpGXE4LBCgdKHJHSwMzyob
	 kZOvPIu257v6WtmxpPtC0SuuBFAP6IK6YyiFR15vvvhDDFRdksUt0AqydKFW1K+CRl
	 cUL6UD4GF2MedPJrtCqk/K/xHrhAv2VBCwoh9t9QAkqd763h4+W8CdjjLAa9bH6pxh
	 Tjz49A+24oKJ73IlA3au25nBzBl4bT286ERdjJ3phILVzxI+X+lwoBQgv4GGUBycsJ
	 FF1LnkuqJB50A==
Date: Tue, 6 Aug 2024 08:23:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
Message-ID: <20240806082316.02c5d71a@kernel.org>
In-Reply-To: <ff8dea3e-ff4e-af27-4b96-3fcf1092cc52@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-10-kuba@kernel.org>
	<ff8dea3e-ff4e-af27-4b96-3fcf1092cc52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 15:24:50 +0100 Edward Cree wrote:
> > +	if (!ctx->ctx_idx) {
> > +		ret = rss_dump_one_ctx(skb, cb, dev, 0);
> > +		if (ret)
> > +			return ret;
> > +		ctx->ctx_idx++;
> > +	}  
> 
> Maybe comment this block with something like "context 0 is
>  not stored in the XArray" to make clear why this is split
>  out from a loop that looks like it should be able to handle
>  it.

Will do.

> > +
> > +	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
> > +		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
> > +		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	ctx->ctx_idx = 0;  
> 
> Feels like there has to be a way to do this with
>  xa_for_each_start()?  Something like (untested):

It may work in the current code but I prefer to stay away from xarray
iterators in netlink code. They cause too many bugs. They do not
invalidate / move the index past the end of the array once they are
done. Which means if the dump ever gets called again after finishing
we'll re-dump the last element.

