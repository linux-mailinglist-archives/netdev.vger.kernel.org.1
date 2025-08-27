Return-Path: <netdev+bounces-217425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1AB38A14
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28EB3BB5B2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF312D3228;
	Wed, 27 Aug 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/ObMzwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF7EEBB;
	Wed, 27 Aug 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322000; cv=none; b=h6S7I0uM5tl8Y8tQeNd+1zR0D2wvNvp0tRgWE6k2qXgkwlb55JH7Ary2xpHMfS53HsOdq3dlPSNBPk6ZbIWa1rsRngcIMTrKzQEgP34crYg0DP0c2jWzhgsmFeVRHfY4fl7ARZPwLJADwgOB211EikvqzfL3ajFF0QwilGryvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322000; c=relaxed/simple;
	bh=AEV+coWoJp19+AOtSRy4opVhMiozkzH4xmmW5FWyAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvolPYEcVCkSqKh0K11hsL+vbgP17LP3/k8uAK6SvZFivvJu/+XL7iRAhp1l8/lI3Y57I/o6pwhgq354YmucnnCYzTgXMtUU/jJbFfuKoXxe44XgPsNWIgPJiV6niyEKhj89TBJf2Pi47IvI9aN0biIeilEva+I4QNeGwBDz+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/ObMzwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0721AC4CEF0;
	Wed, 27 Aug 2025 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756322000;
	bh=AEV+coWoJp19+AOtSRy4opVhMiozkzH4xmmW5FWyAiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/ObMzwOhuXorEZVpM40e0TsU2N+oN9sBn+GGzVRbzYbEQ8IGqYuIpCL/mHvZhzQI
	 1nPuXx76m33H7qB8mF+38Lu2mK8MrV4JJL5ilHjA9GSgTGiCr//WtQrDcoN7TfCvzi
	 MzSrojn5Qu7pTarAGO+MFJbKTRSxFT8NTF+yFp5AVimw+Y56za9O0HFvFHOyHBl6s1
	 1WSsKiPJfBtcaeeVmHN6z1OjavLd8rMeKqLcLdkgFPaMQQPavYsIr4SRMaWodqAdAO
	 fnFShZ1y+QSZhgvlmd0mn57AGYnm805OPuvjFmxBEoPzveRZ5MyiN+YFpY11ML+wOX
	 fHu/wfOmVIf1w==
Date: Wed, 27 Aug 2025 20:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 1/7] net: stmmac: replace memcpy with strscpy in
 ethtool
Message-ID: <20250827191315.GQ10519@horms.kernel.org>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <20250826113247.3481273-2-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826113247.3481273-2-konrad.leszczynski@intel.com>

+ Kees

On Tue, Aug 26, 2025 at 01:32:41PM +0200, Konrad Leszczynski wrote:
> Fix kernel exception by replacing memcpy with strscpy when used with
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
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

Hi Konrad,

As mentioned by Vadim elsewhere, as this is a fix it should
be part of a separate series targeted at net.

And it should have a Fixes tag.

Also, as a follow-up for net-next, it might be nice
to move stmmac_get_strings() to use an appropriate combination
of ethtool_puts() and ethtool_cpu().

See: commit 151e13ece86d ("net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats to use memcpy")

The code change itself looks good to me.

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index f702f7b7bf9f..219a2df578ae 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -795,7 +795,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  				if (!stmmac_safety_feat_dump(priv,
>  							&priv->sstats, i,
>  							NULL, &desc)) {
> -					memcpy(p, desc, ETH_GSTRING_LEN);
> +					strscpy(p, desc, ETH_GSTRING_LEN);
>  					p += ETH_GSTRING_LEN;
>  				}
>  			}
> -- 
> 2.34.1
> 
> 

