Return-Path: <netdev+bounces-151445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A39EF1AB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11D6290FC0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF6231A3D;
	Thu, 12 Dec 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjutuD17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A70231A3A
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021051; cv=none; b=ZwQUsHIAOyuO8Obv6ZERpNHZyOPknBwBfiOnNjMeL76CDd9lQHjEg2i4ULzFfbAnXfXLDdyawPk+o/0EWEZsO+dqVD1lp+lrYee5FKON4gJOKXqxCaB60me/UT0xxr95yX62YQ9Apnd7fmPx4+Kz7/+TmtHiMztJ2mrgKNjafFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021051; c=relaxed/simple;
	bh=Bgd7dC+8VkZkhmHsUWGvAPgGMT1s5CIo9KCWBJ3WLgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6XS+9uUJPOQ/YBqptdOyopk5U+odvp1THslvmlIbljyp2Wvqz0gn4j4uJKD1E6/YSJ2hrJEzLB49dqMAb7mb23QvdTPnX7BuQ6dsOo3koB1JaPYjLgHGYuASjnLtZYeVhY9iOrXtAJGOoi4mD8EvcXuuwp6L4qGSJnu9Cz6y6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjutuD17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8B7C4CECE;
	Thu, 12 Dec 2024 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021051;
	bh=Bgd7dC+8VkZkhmHsUWGvAPgGMT1s5CIo9KCWBJ3WLgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjutuD17SdC3oU1eNsby40al2J7o8SErj+ov30fqtQQK085BsF1HSVdJEouvFEq9c
	 mEf84+jqHBLX26q+mzSywIgC/n0L0CYkcwobTOarz2jYIu94DBq6WrXEya4E6SwIys
	 y9yGXOiJIK3YDTIs21EymA8wC+qJRV1tVEpTDe8qeYcOn2IR3WBY/SM/zJhdquZO/Y
	 cOMmk70J33AyhsfQSnrBUvmwsQOkzsbgtpdeUCH85DXLLQTvrqkPLt4aVWqZSAWjDs
	 mS4DCi0Pi8exOKtbRTgd4Obh+QIDo2XM5+kgOQIcwcTU+N/zPXFyQtWf0t2jIPpg6k
	 C/hHoZCSgBLAg==
Date: Thu, 12 Dec 2024 16:30:47 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix ice_parser_rt::bst_key array size
Message-ID: <20241212163047.GA73795@kernel.org>
References: <20241211132745.112536-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211132745.112536-2-przemyslaw.kitszel@intel.com>

On Wed, Dec 11, 2024 at 02:26:36PM +0100, Przemek Kitszel wrote:
> Fix &ice_parser_rt::bst_key size. It was wrongly set to 10 instead of 20
> in the initial impl commit (see Fixes tag). All usage code assumed it was
> of size 20. That was also the initial size present up to v2 of the intro
> series [2], but halved by v3 [3] refactor described as "Replace magic
> hardcoded values with macros." The introducing series was so big that
> some ugliness was unnoticed, same for bugs :/
> 
> ICE_BST_KEY_TCAM_SIZE and ICE_BST_TCAM_KEY_SIZE were differing by one.
> There was tmp variable @j in the scope of edited function, but was not
> used in all places. This ugliness is now gone.
> I'm moving ice_parser_rt::pg_prio a few positions up, to fill up one of
> the holes in order to compensate for the added 10 bytes to the ::bst_key,
> resulting in the same size of the whole as prior to the fix, and miminal
> changes in the offsets of the fields.
> 
> This fix obsoletes Ahmed's attempt at [1].
> 
> [1] https://lore.kernel.org/intel-wired-lan/20240823230847.172295-1-ahmed.zaki@intel.com
> [2] https://lore.kernel.org/intel-wired-lan/20230605054641.2865142-13-junfeng.guo@intel.com
> [3] https://lore.kernel.org/intel-wired-lan/20230817093442.2576997-13-junfeng.guo@intel.com
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/intel-wired-lan/b1fb6ff9-b69e-4026-9988-3c783d86c2e0@stanley.mountain
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Przemek,

I agree that these changes are good.  But I wonder if it would be best to
only treat the update size of bst_key as a fix.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> index dedf5e854e4b..d9c38ce27e4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> @@ -125,22 +125,20 @@ static void ice_bst_key_init(struct ice_parser_rt *rt,
>  	else
>  		key[idd] = imem->b_kb.prio;
>  
> -	idd = ICE_BST_KEY_TCAM_SIZE - 1;
> +	idd = ICE_BST_TCAM_KEY_SIZE - 2;
>  	for (i = idd; i >= 0; i--) {
>  		int j;
>  
>  		j = ho + idd - i;
>  		if (j < ICE_PARSER_MAX_PKT_LEN)
> -			key[i] = rt->pkt_buf[ho + idd - i];
> +			key[i] = rt->pkt_buf[j];
>  		else
>  			key[i] = 0;
>  	}
>  
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Generated Boost TCAM Key:\n");
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X\n",
> -		  key[0], key[1], key[2], key[3], key[4],
> -		  key[5], key[6], key[7], key[8], key[9]);
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "\n");
> +	ice_debug_array_w_prefix(rt->psr->hw, ICE_DBG_PARSER,
> +				 KBUILD_MODNAME "Generated Boost TCAM Key",

Should there be a delimeter between KBUILD_MODNAME and "Generated ..." ?
e.g.:

				 KBUILD_MODNAME ": Generated Boost TCAM Key",

> +				 key, ICE_BST_TCAM_KEY_SIZE);
>  }
>  
>  static u16 ice_bit_rev_u16(u16 v, int len)
> 
> base-commit: 51a00be6a0994da2ba6b4ace3b7a0d9373b4b25e
> -- 
> 2.46.0
> 
> 

