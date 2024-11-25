Return-Path: <netdev+bounces-147267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC6D9D8CEA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D4BB22AE0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6C1BF328;
	Mon, 25 Nov 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMAcOiAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B51CD2C;
	Mon, 25 Nov 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563825; cv=none; b=XvJcZad4z/U9osY+NqW2tiSfWzWAzxztXuUASQ7h1jSM8fAdvnjr9ZKTo+8D63WwjjABP3yAfCGvWVwPjgjGLWsWfx7LFPyRLY/+0SpuGdZIJD9Vf9fssiGuoJ6DGUy6dBuaNM3Nzh6Tvq4hvS0cDNO6mNpqHROxSl03RkD3F78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563825; c=relaxed/simple;
	bh=7u0gpDiYyYA7NQ6VezJSJ+8hriofj8q48xLAc+TwLXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzpHXklyatl9ssYANY/TzMrc9J9Nn4BBXLANxwiMR3XGec6aLtj3/OPju9sculOxcPiUKs4kL8GcIC5TLpXpNb1sj59rkiA/tH4+QUFUW20hnvJWQz9zifrh9xgL76LqYmV2idy1BBiHzF+al8/ur5bDa3qZbWIjq/JRMnUiqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMAcOiAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D9BC4CECE;
	Mon, 25 Nov 2024 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732563824;
	bh=7u0gpDiYyYA7NQ6VezJSJ+8hriofj8q48xLAc+TwLXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMAcOiAF133ikRjS9Twl43aEyOsANFMhxCC3DmyRZ86if6xmZ6CyHtAZ1psjwvwt4
	 uRlbLkhgWVVJg+1RlLmak6gfDygGP6OS4pj6Wq3w5dz9kGFjwZ5F2BMYOd1Iw35IxM
	 5xPrNPFdjIFQYxH0dgej6nyouefcRyCYXKNmH53pvD5bDEheyd2IZi8yYr+hs1xObG
	 IX3xWrTGPVDDbs1HhdtDpq4xvFOM5C0RZ87DwuFjCoJtFkySHKpNDlUENCji2wPgRW
	 YF/VDyppF54IHd9C/WAiksxT2sleuGcXj+WiVEnPSP8c9wEd3qPzO2Oo6/wlYR3xzT
	 S9WcQ80YFqAHA==
Date: Mon, 25 Nov 2024 21:43:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241125194340.GI160612@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>

On Mon, Nov 25, 2024 at 11:26:14AM +0200, Ilia Lin wrote:
> On Sun, Nov 24, 2024 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > > In packet offload mode the raw packets will be sent to the NiC,
> > > and will not return to the Network Stack. In event of crossing
> > > the MTU size after the encapsulation, the NiC HW may not be
> > > able to fragment the final packet.
> >
> > Yes, HW doesn't know how to handle these packets.
> >
> > > Adding mandatory pre-encapsulation fragmentation for both
> > > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > > on the state.
> >
> > I was under impression is that xfrm_dev_offload_ok() is responsible to
> > prevent fragmentation.
> > https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410
> 
> With my change we can both support inner fragmentation or prevent it,
> depending on the network device driver implementation.

The thing is that fragmentation isn't desirable thing. Why didn't PMTU
take into account headers so we can rely on existing code and do not add
extra logic for packet offload?

Thanks

> 
> >
> > Thanks

