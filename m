Return-Path: <netdev+bounces-147442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF79D986F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7303D1658A5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5E1D515E;
	Tue, 26 Nov 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLdIGSG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F51D5151;
	Tue, 26 Nov 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627311; cv=none; b=PSCca/NNu/nlJJhE4bPxvIUzkDnT9T/667Ua/5OaCxObcfY1wooZfqqo6zJfZe6K7yMzFcXxTJxv5qwUbv9dMlO32/appI/fFTjiBA3gJd8Ln1OZ6JrmbujWmNpx0OoJ/tEZT/5POjM//NtBiD3dHN+Wv/ijOsBuXS21Kl8YU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627311; c=relaxed/simple;
	bh=r7WixRalsMhPOVvhc77DI2Yr24fjHE72bC6gsIMtJyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+09PEXdjjcuCthZVCzJ3CEcg+dVZyfUDEZSF3NG6Tp3iWl36BoOSRkW6lneJpfIH8dJeN7c0ulTbo2/rk3jhKytw89CU1rDPsUOC0uyBwYJLJjYTsUjfbd3y37DA+f71czUHJQoGos+wNxNDHwzcaocSsSh4j7ffcSnht7dd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLdIGSG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B3FC4AF09;
	Tue, 26 Nov 2024 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732627311;
	bh=r7WixRalsMhPOVvhc77DI2Yr24fjHE72bC6gsIMtJyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLdIGSG5gufIjX6wy+iMi+jmUtoBFw6sFScNNNMe+IKmP0B75VZbJDsDkfvkwZROC
	 iN5CedH370QQwomB5bvVsKGqiX6kXXx5b0DkbUfkv47Mqm0yeaoiiyn9q5GBu1kSLg
	 INHAIZlt9uxB4EoD/kiM8h+C2i104eJCHcuxgD7aU/+whYP7r5ltYuFjVIg98H64yP
	 D+LcNELTpebOUJ7NKvljwcK2hAAZoxS92GkeGDboazb+dXkWPWIMdt9I/zMchJjcKD
	 FUlW3Tg0FuHANpD6EIe/yxRNdSy+6N+45w5Cwl9ZjG/+zsPgAushp9YhMPEI9/UhqU
	 jDaxCWMPEuxYg==
Date: Tue, 26 Nov 2024 15:21:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, herbert@gondor.apana.org.au,
	David Miller <davem@davemloft.net>, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241126132145.GA1245331@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
 <20241125194340.GI160612@unreal>
 <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>
 <20241126083513.GL160612@unreal>
 <Z0XGMxSou3AZrB2f@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XGMxSou3AZrB2f@gauss3.secunet.de>

On Tue, Nov 26, 2024 at 01:59:31PM +0100, Steffen Klassert wrote:
> On Tue, Nov 26, 2024 at 10:35:13AM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 26, 2024 at 09:09:03AM +0200, Ilia Lin wrote:
> > > On Mon, Nov 25, 2024 at 9:43 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 25, 2024 at 11:26:14AM +0200, Ilia Lin wrote:
> > > > > On Sun, Nov 24, 2024 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > > > > > > In packet offload mode the raw packets will be sent to the NiC,
> > > > > > > and will not return to the Network Stack. In event of crossing
> > > > > > > the MTU size after the encapsulation, the NiC HW may not be
> > > > > > > able to fragment the final packet.
> > > > > >
> > > > > > Yes, HW doesn't know how to handle these packets.
> > > > > >
> > > > > > > Adding mandatory pre-encapsulation fragmentation for both
> > > > > > > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > > > > > > on the state.
> > > > > >
> > > > > > I was under impression is that xfrm_dev_offload_ok() is responsible to
> > > > > > prevent fragmentation.
> > > > > >
> > > https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410
> > > > >
> > > > > With my change we can both support inner fragmentation or prevent it,
> > > > > depending on the network device driver implementation.
> > > >
> > > > The thing is that fragmentation isn't desirable thing. Why didn't PMTU
> > > > take into account headers so we can rely on existing code and do not add
> > > > extra logic for packet offload?
> > > 
> > > I agree that PMTU is preferred option, but the packets may be routed from
> > > a host behind the VPN, which is unaware that it transmits into an IPsec
> > > tunnel,
> > > and therefore will not count on the extra headers.
> > 
> > My basic web search shows that PMTU works correctly for IPsec tunnels too.
> 
> Yes, at least SW and crypto offload IPsec PMTU works correctly.
> 
> > 
> > Steffen, do we need special case for packet offload here? My preference is
> > to make sure that we will have as less possible special cases for packet
> > offload.
> 
> Looks like the problem on packet offload is that packets
> bigger than MTU size are dropped before the PMTU signaling
> is handled.

But PMTU should be less or equal to MTU, even before first packet was
sent. Otherwise already first packet will be fragmented.

Thanks


