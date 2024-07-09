Return-Path: <netdev+bounces-110405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF092C324
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7AC2846CF
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19A17B04B;
	Tue,  9 Jul 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRCufdPb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219C182A51;
	Tue,  9 Jul 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548695; cv=none; b=PUNGZykvMH86EN5exhaa0E3Llr7s3Ha3S1Wu3aucruWZknWrv7HIcz2lA3Kqu7cl2S6sgdNDp8dcVTYMgza3F5n9qoUlkMFqQ9kkuOI1tB68Wag1t0LhEGGhkzDLhnMewjBkBwYAi7yy3BZP6C4857n9BF+vTpoLtYsOrh1M2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548695; c=relaxed/simple;
	bh=vmKXIZftIMmUvIjQn6H9m8+/Z4ol58D0xRGXk1f2Epw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4B5EIvuK4wSIeQvieXeS39S6jqNK7D7b4ujzo6iX6am4jiGEVkq8BwRXlxOok9jKf9hiBCyw78YucPT/TIy9xYDYhZ16BCJoGEwuqGPI0C0RyGI5jnkNAt5AOuWtgORws7jykTBjMxU29koeXU90/2XyUldDJEgdQfWGvGAs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRCufdPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0F3C32782;
	Tue,  9 Jul 2024 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720548694;
	bh=vmKXIZftIMmUvIjQn6H9m8+/Z4ol58D0xRGXk1f2Epw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRCufdPbcmGi6dtPoZXTY6MDS2cU/kITaI815vaF+sAxC7EnvMf5Kj30Bjin4x6Wc
	 Ec2kPiJEump+XPpCPdLSYQEN7AAdrYbZ1PnDgH4Q5PRfi8aRbc9ewKMyCJMsT51Jh4
	 BOZoGsU3jFL5lIWY6w3vY8QMWMaLYzi280XT4W/PEEY85Whb3tFzUFoHC7oEl4epQ8
	 7nsInslcd25Gb24INbrOI04QbQEfl2Dtz3zZFtXu1vF+SZrRcrup1yQ9/k/tdAYafv
	 z3PrgTJDGZp73cPJmERZZiDU9G6VQbxarjw843+LJR6v1ry4tnAX1XHapomSwWQA/c
	 uhAoE2OXI2QuQ==
Date: Tue, 9 Jul 2024 19:11:28 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <20240709181128.GO346094@kernel.org>
References: <20240709125433.4026177-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709125433.4026177-1-leitao@debian.org>

On Tue, Jul 09, 2024 at 05:54:25AM -0700, Breno Leitao wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> bloat-o-meter for vmlinux:
> 
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
> 
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Breno,

Some kernel doc warnings from my side.

Flagged by: kernel-doc -none

> ---
> Changelog:
> 
> v2:
>  * Rebased Alexander's patch on top of f750dfe825b90 ("ethtool: provide
>    customized dim profile management").
>  * Removed the ALIGN() of SMP_CACHE_BYTES for sizeof_priv.
> 
> v1:
>  * https://lore.kernel.org/netdev/90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@intel.com
> 
>  include/linux/netdevice.h | 12 +++++++-----
>  net/core/dev.c            | 30 ++++++------------------------
>  net/core/net-sysfs.c      |  2 +-
>  3 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 93558645c6d0..f0dd499244d4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2199,10 +2199,10 @@ struct net_device {
>  	unsigned short		neigh_priv_len;
>  	unsigned short          dev_id;
>  	unsigned short          dev_port;
> -	unsigned short		padded;

padded should also be removed from the Kernel doc for this structure.

> +	int			irq;
> +	u32			priv_len;

And irq and priv_len should be added to the Kernel doc for this structure.

>  
>  	spinlock_t		addr_list_lock;
> -	int			irq;
>  
>  	struct netdev_hw_addr_list	uc;
>  	struct netdev_hw_addr_list	mc;

...

