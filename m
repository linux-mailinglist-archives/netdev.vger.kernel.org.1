Return-Path: <netdev+bounces-223668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF12B59E13
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F79E4608AA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B52AE7F;
	Tue, 16 Sep 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfvXmgaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD72FFF80;
	Tue, 16 Sep 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041135; cv=none; b=nM1woT/xuSYx9NPwkpaApFBDzICIVuOCPAK+YhL4z0s0ifRddubeLP0WTJMHaKgmBoVzzG0X+uKqenuJqWF7yXAYV+AQS9kcn6rSNTxt3vqzYVw43wjiYfrzKE2z1aEqyc7Q96BnuRDp6jZO+137fOAook7XtTflZzLIm9yy1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041135; c=relaxed/simple;
	bh=+t/HWhG+SPiQHaU/as8kRI8y4qlgUGT045L/wciADKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tacJiFVhhUPl4p+53eQvahXueNEixadZA93TZp4gVdOjL3kEIScF8RZwjO6PGgj3sEYItQ8YmM0X69RCDR0yDe74AD88Cu8okZ3ehnqwj82ZVnUgvyY+6rVl3uzoOJuzQ8+hiIlD4o8htnLX171bMBYVq0AGuCQ4UWDDwVnHF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfvXmgaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4074C4CEEB;
	Tue, 16 Sep 2025 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758041134;
	bh=+t/HWhG+SPiQHaU/as8kRI8y4qlgUGT045L/wciADKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfvXmgajGLKScNA9oqQjde50Dhj4E5OLTwIXXgK64ccDRnirol4gDX10hm0RCWV+w
	 NBigjsXrL14SneTwJxXGkovLCehf/5ccj1GhjyusOSjMWNQ6nxX3ZG+8IGkLdf2urq
	 fck7zOEqhaUu8zn8pGbdex3jrQmdKOneQbqEv3BVYMcSKOzOu9NbikfaY+uL1PbEwS
	 T42BeR4pGQJsa15JC2Ma9rKL/iTPXYVuepa7WEoR8KvkFskTy/Y5pzSWfBow6XX4cw
	 PcwBkHE7FRrCVBiaxKwjSE6xEr7HeQM97JdaFVu2MD+v1c3obRuGqMVmL90CJifySu
	 +2+3hEkwGabYA==
Date: Tue, 16 Sep 2025 17:45:30 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net v4 1/2] net: stmmac: replace memcpy with ethtool_puts
 in ethtool
Message-ID: <20250916164530.GM224143@horms.kernel.org>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
 <20250916120932.217547-2-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916120932.217547-2-konrad.leszczynski@intel.com>

On Tue, Sep 16, 2025 at 02:09:31PM +0200, Konrad Leszczynski wrote:
> Fix kernel exception by replacing memcpy with ethtool_puts when used with
> safety feature strings in ethtool logic.
> 
> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> 
> [  +0.000005] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x6c/0x90
> [  +0.000016]  print_report+0xce/0x610
> [  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
> [  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000101]  kasan_report+0xd4/0x110
> [  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000102]  kasan_check_range+0x3a/0x1c0
> [  +0.000010]  __asan_memcpy+0x24/0x70
> [  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]
> 
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

As per my comment on v3 (sorry, I missed that you had already posted v4):

I think it would be good to explain why using memcpy() is a problem here.

I looked and it seems to me that one reason is that the strings may be
too long. But are there others?

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 77758a7299b4..d5a2b7e9b2a9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -752,7 +752,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  				if (!stmmac_safety_feat_dump(priv,
>  							&priv->sstats, i,
>  							NULL, &desc)) {
> -					memcpy(p, desc, ETH_GSTRING_LEN);
> +					ethtool_puts(&p, desc);
>  					p += ETH_GSTRING_LEN;

ethtool_puts() increments p, so I think the line above should be removed.

>  				}
>  			}
> -- 
> 2.34.1
> 
> 

