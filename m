Return-Path: <netdev+bounces-123717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD4966437
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAF51F2144C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1650199936;
	Fri, 30 Aug 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQA8E9Xt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F11384B3
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028255; cv=none; b=LzRwR2iw0m33UbGurnmbnweFJiU4tr/MTnROlD1jlSpBYkSmWqS6DIc3LifdXjGyga4+Jj/AANneAqHqlWCpXb3l/J8MwV6mFI4GIl//fRVaFAu/sZfGnEJyVzIndAxKdONyRpAB1Hsd8qrGrEO3bPkaOGTf+z42f8nH3XTYOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028255; c=relaxed/simple;
	bh=idrgXe3QeU8ZzGhjb/wDX2ZjXquoMenEVaZWHPbg9b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icqYgfJEXRHncBcQ/F0xdWYMPpxOweHDMhx1QbmnZlPHJMJL3hGVID4beNjyM+C5RfqJY61nvi3mi6X19ILvPw0cFz7OVRXL4Wqs5QNYobIchHVG4Iekj8s/CCBZl0Z35HFmCMCCoeY+EL+7c2ILuaTQQuWvtHttqlbYL8Dsoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQA8E9Xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C605EC4CEC5;
	Fri, 30 Aug 2024 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725028255;
	bh=idrgXe3QeU8ZzGhjb/wDX2ZjXquoMenEVaZWHPbg9b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQA8E9XtzLbuqVtlX1HYr6YL/7V7h6YwRWDNOl/fi3NgtrOyovhzvYn4asizTXUW2
	 c0JOkXyP5WmgcXbye3FZzjFVF2dm4VxgcPG4jYD+oNQntkwzA2iKLMoHRTrHpQNMgD
	 YdvMdyRJPLEmtDiGl8KFgyi3Dm6+Hx3sxx9fOqOAKtJvxCZciWslIY65Rh+kAlLhQE
	 D5XczvJCy114489qSH/MtKR8b8+M15bedbqguXXsdlAGFZRPmOkoE8DxUH/QnKgIuZ
	 Zn+T0LtQ/EvH3Lu9Tk0j5mjbPbYn/k1D7N5xfgWbLRPTbnsAe9uYzxCsCqRxxW4Xil
	 cIcersgYc44ZA==
Date: Fri, 30 Aug 2024 17:30:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240830143051.GA4000@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal>
 <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
 <20240829103846.GE26654@unreal>
 <CADsK2K8KqJThB3pkz7oAZT_4yXgy8v89TK83W50KaR-VSSKjOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K8KqJThB3pkz7oAZT_4yXgy8v89TK83W50KaR-VSSKjOg@mail.gmail.com>

On Thu, Aug 29, 2024 at 02:19:25PM -0700, Feng Wang wrote:
> Hi Leon,
> 
> Thank you again for your thoughtful questions and comments. I'd like
> to provide further clarification and address your points:
> 
> SA Information Usage:
> 
> There are several instances in the kernel code where it's used, such
> as in esp4(6)_offload.c and xfrm.c. This clearly demonstrates how SA
> information is used. Moreover, passing this information to the driver
> shouldn't negatively impact those drivers that don't require it.
> Regarding a driver example, the function mlx5e_ipsec_feature_check
> caught my attention.
> https://elixir.bootlin.com/linux/v6.10/source/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h#L89)
> As you're more familiar with this codebase, I defer to your expertise
> on whether it's an appropriate sample. 

This function is not involved when packet is going to be offloaded for "IPsec packet offload".

> However, the crucial point is that including this information empowers certain drivers to leverage
> it without affecting those that don't need it.

Can you please provide a list of drivers that will benefit from this change?
Can you give a complete flow (including driver) which didn't work before
and will work after this change?

> 
> validate_xmit_xfrm Function:
> My primary goal in discussing the validate_xmit_xfrm function is to
> assure you that my patch maintains the existing packet offload code
> flow, avoiding any unintended disruption.

The whole idea of packet offload is to skip everything in XFRM stack and
present packet as plain text.

> 
> State Release:
> I've noticed that secpath_reset() is called before xfrm_output(). The
> sequence seems to be: xfrmi_xmit2 -> xfrmi_scrub_packet ->
> secpath_reset(), followed by xfrmi_xmit2 calling dst_output, which is
> essentially xfrm_output().
> I'm also open to moving the xfrm_state_hold(x) after the if (!xo)
> check block. This would ensure the state is held only when everything
> is ok. I'll gladly make this adjustment if you believe it's the better
> option.
> 
> Thank you once again for your valuable insights and collaboration.
> Your feedback is greatly appreciated!
> 
> Feng
> 

