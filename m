Return-Path: <netdev+bounces-223663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A1B59D91
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041977B3FAC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B037C0E4;
	Tue, 16 Sep 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4FfYHbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741C37429F;
	Tue, 16 Sep 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040013; cv=none; b=Tkt8zeLJPvrBQ93RV71Y77Lt2Gp6h9/a1lGlhF2vIWY/lhuqicJwkuXuq0wSvyfLgDCLetvfW/4c3AoTHDaJOHQ8LZmQhzs566OaMLI/pugJiFHCLYYm7Gp1FBKyv2wt7xU2ZoNI4/wzNTSvsyKlRpk6ht1wb4ePGS+R/tYoy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040013; c=relaxed/simple;
	bh=9/4FFgEn6XEt8f8CMB04t//ssD3IMAER3UQ1rPHhAVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jidRB9j0x+A6dffMtJjSuKhNLnnS7vp3P5ueAK9oK89ZMIUCyZ5IXkhBDnkRJ4+nXXEy5yAcmm6YJdVnES/lrVkbobilx2iV0hgC+gxo9esmg5FduzFcBSSOsKw6XqaZW4JIFHYEFvO9qPbAQBq0RF42igqADLxABIIim0uGVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4FfYHbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5846EC4CEF0;
	Tue, 16 Sep 2025 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758040013;
	bh=9/4FFgEn6XEt8f8CMB04t//ssD3IMAER3UQ1rPHhAVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4FfYHbSlgxAEZqpKg+vOAqtPp7Qu8D3Ty1/bOmONAX9TYWIHDXdhtf8yxNaTYvDF
	 sTxEZXcYzX/AstijcyLOqPJC6fd29TiHiPtrR12r1ArFwnQeHdiGEvGzrRRUCz3ys0
	 hfqCsxrSk/G28gcrYIzaEDQSrSHxGbf9Omz+/JZ0lpAJMyHFX7byh2rSyqUTaDkwsz
	 PZOhwmRCRYZEBQqYxwQ14y8NoCYrCvAP9uQqY2bSzlz6fz8YInxmyONZiT5uziV1h7
	 1s6a90+peiR5qIx3ePRd8k+NzFgx75G4SCofaOz/nnI2UEG4h6q/yWWFAJIxLlyXGY
	 TJGZ7+AUHNTCA==
Date: Tue, 16 Sep 2025 17:26:49 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net v3 1/2] net: stmmac: replace memcpy with ethtool_puts
 in ethtool
Message-ID: <20250916162649.GL224143@horms.kernel.org>
References: <20250916092507.216613-1-konrad.leszczynski@intel.com>
 <20250916092507.216613-2-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916092507.216613-2-konrad.leszczynski@intel.com>

On Tue, Sep 16, 2025 at 11:25:06AM +0200, Konrad Leszczynski wrote:
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

I think it would be worth adding some commentary around
why memcpy results in this problem in this case.

> 
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
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

