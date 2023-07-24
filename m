Return-Path: <netdev+bounces-20523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFC75FED3
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F082814AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70376100B0;
	Mon, 24 Jul 2023 18:11:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18251100AD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635AC433C8;
	Mon, 24 Jul 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690222269;
	bh=lVl/AoyoC3+s3150PJB7m2OVF2U2VY5mosVKutorV/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLxx1cJ7WRLyBjboZj27c0pna1eGR+fCO+km4x5R9cBWxpNR9AHc2zVnostvDm33y
	 ouKZWeqCO2jyWpcuzSGXqJsKjcw1BQTyMWv2cer8LbSL/juksaHecI7R9I0KtTHmFv
	 +tErBrJc5HiKIY4YislKAQKbpCW0JAEMHKDR4rBYYWjRcFAk80SCF3kn4k0lH/cUUd
	 /4N3YPyo8/Is+KPdHWY14mAjm1cE6lghRAQM+jTfzxse8ZErgC8dinjpoRtmmPXynY
	 s9waxOgIcU18SW6csvbm2epdLW0999zHzd7XmazwwKeRel0yU6LaUu2A9V1cqAzTib
	 lyPASW3sHewcg==
Date: Mon, 24 Jul 2023 21:11:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230724181105.GD11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724090044.2668064-1-ilia.lin@kernel.org>

On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> If XFRM_OFFLOAD is configured, but XFRM is not

How did you do it?

>, it will cause
> compilation error on include xfrm.h:
>  C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
>  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
>  C 05:56:39         struct xfrm_state *x = dst->xfrm;
>  C 05:56:39                                ~~~  ^
> 
> Making the XFRM_OFFLOAD select the XFRM.
> 
> Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> Reported-by: Ilia Lin <ilia.lin@kernel.org>
> Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> ---
>  net/xfrm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -10,6 +10,7 @@ config XFRM
> 
>  config XFRM_OFFLOAD
>  	bool
> +	select XFRM

struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOAD,
so it is unclear to me why do you need to add new "select XFRM" line.

   26 struct dst_entry {
   27         struct net_device       *dev;
   28         struct  dst_ops         *ops;
   29         unsigned long           _metrics;
   30         unsigned long           expires;
   31 #ifdef CONFIG_XFRM
   32         struct xfrm_state       *xfrm;
   33 #else
   34         void                    *__pad1;
   35 #endif
   36         int

Thanks

