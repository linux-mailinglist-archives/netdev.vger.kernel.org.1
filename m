Return-Path: <netdev+bounces-123987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F350E9672D9
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 19:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92FC2826EA
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F85588F;
	Sat, 31 Aug 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nekbbEcU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6A4C8C
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125780; cv=none; b=MYu7Vv1XCn26xm7/JSoEpRo3jSbzszH+1BVhcLt3mk2gTPbio3NI2wMx+98w5KEIoqL1gykO7+tU2yyR94OTy4dtba8y/lMOGn2LEURVL9C4nKqMSTPMrxLUDsQ8IQo+45wQiZlyEzYeWtpoBsRiU7uRzWcP9o4ByOUYavQTnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125780; c=relaxed/simple;
	bh=9qJqyhApIj+jFtluzzXwXGO250WG1b0aiU9Wl98xy8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ+Gf50kuOUshTc5CgOlZbowntfRoq+FKB7hbla6IcEjaFQc0C2K+RFkBVS0aL0WqC5Xk9aArFQiDDHbSIMb+79TBg+JCGZ/plDKbK2qw2aNx8HdousrMe5LhzhVVNbL6HxwrUw17qtyyfeoOSUoUGIGzsoxyPoDUbbU5s4RP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nekbbEcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE82EC4CEC0;
	Sat, 31 Aug 2024 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725125780;
	bh=9qJqyhApIj+jFtluzzXwXGO250WG1b0aiU9Wl98xy8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nekbbEcUvfa0lUdLRctU9jRZ2TOiWEfZeIoi3c1qqub7FQI2L/7e27TUkVPAuXVHQ
	 q5uw09HNZ1pG2rEPbG7vq2R8HAoO5V3Cp/l04B7gmrdGFKtsXHqPiMkmdQ4O0mClYD
	 iYBL1GvZBLPe8SPTWeYqnPeXguewxTMXJAmZmnYGe1SDPElIRPd6kJ9f/dj1++63zg
	 4nfGqEhekekQPedXvNQk2Yqg3TL4abSf6uZLoPS2PLP5M60FZKpVFxGcmmaHF9IBoX
	 /v8aKddHlvuyn77fNSfqHhq7q8WAzTYfDKGJtlE7a42RjJKATwsJNZNQxxeNaD1X6Z
	 jt3W78CKjrktQ==
Date: Sat, 31 Aug 2024 20:36:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240831173616.GB4000@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal>
 <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
 <20240829103846.GE26654@unreal>
 <CADsK2K8KqJThB3pkz7oAZT_4yXgy8v89TK83W50KaR-VSSKjOg@mail.gmail.com>
 <20240830143051.GA4000@unreal>
 <CADsK2K8+sEGwLSX_Q2nxcOosbGFFKjfKb2ffRXK2E1sp_Fbd+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K8+sEGwLSX_Q2nxcOosbGFFKjfKb2ffRXK2E1sp_Fbd+Q@mail.gmail.com>

On Fri, Aug 30, 2024 at 05:27:29PM -0700, Feng Wang wrote:
> Hi Leon,
> 
> I believe you are right about the mlx5e_ipsec_feature_check function.
> And it shows that the driver can indeed make use of the SA
> information. Similarly, in packet offload mode, drivers can
> potentially leverage this information for their own purposes. The
> patch is designed to be non-intrusive, so drivers that don't utilize
> this information won't be affected in any way.

I asked about examples of such drivers. Can you please provide them?

> 
> I'm also curious about why the mlx driver doesn't seem to use the XFRM
> interface ID in the same way that xfrm_policy_match() does.
> https://elixir.bootlin.com/linux/v6.10.7/source/net/xfrm/xfrm_policy.c#L1993a

HW offload is always last in packet TX traversal and it means that if HW
catches that packet and it meets the HW offload requirements, it will be
encrypted. The main idea is that routing (sending to right if_id) is handled
by the upper layers and HW offload is just a final step.

> This ID is critical in scenarios with multiple IPsec tunnels, where
> source and destination addresses alone might not be sufficient to
> identify the correct security policy. Perhaps there's a specific
> reason or design choice behind this in the mlx driver?

It is not specific to mlx5, but to all HW offload drivers. They should
implement both policy and SA offloading. It is violation of current mailing
list deign to do not offload policy. If you offload both policy and SA, you
won't need if_id at all.

> 
> Thank you once again for your valuable insights and collaboration.
> 
> Feng

