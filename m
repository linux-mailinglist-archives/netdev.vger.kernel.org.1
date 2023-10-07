Return-Path: <netdev+bounces-38805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5D7BC8F1
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B331C2082D
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DE31A71;
	Sat,  7 Oct 2023 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBd1o104"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6D18B14
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48388C433C7;
	Sat,  7 Oct 2023 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696694254;
	bh=FdT0hRiVUetymc4htP5coHs/oBEZ3Uyq+kymb8Y2DpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBd1o104P6neQxI5O+GltjAU3rrUklfWY8d2142pc/H7mAqrbdQu02oK2QjMNS/M7
	 YiGP5Ro+vzKL8/E3g2d1Ctkd6QpA6WdK+uQOGn9/1JANxW8aAJZ3XULf0TmSoPAaXG
	 r6SMq0pwVsOW/R2cr/mKSVu5UIh/ff5OzwDtbq8TbXgiwKvpUmB4zkwCkvziWzy6sp
	 HalIoKSTqTDanMYRlnx465Cb9/xomChLFzTnAO5n2TE0CS3ukSsDcrr2FcEtoW2bRu
	 BdNAnqdw6H7/YBba6/p4azRz70rNmkWITuxORN795qPnDm0OybnccFMMD+tu5NRePF
	 cC6dZnQa5Fnbw==
Date: Sat, 7 Oct 2023 17:57:30 +0200
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/1] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <20231007155730.GF831234@kernel.org>
References: <20231006141246.3747944-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231006141246.3747944-1-kory.maincent@bootlin.com>

On Fri, Oct 06, 2023 at 04:12:46PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab fixes this issue by clearing the whole target bitmap before we
> start iterating. The solution proposed brought an issue with the behavior
> of the mod variable. As the bitset is always cleared the old val will
> always differ to the new val.
> 
> Fix it by adding a new temporary variable which save the state of the old
> bitmap.
> 
> Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Fix the allocated size.
> ---
>  net/ethtool/bitset.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
> index 0515d6604b3b..8a6b35c920cd 100644
> --- a/net/ethtool/bitset.c
> +++ b/net/ethtool/bitset.c
> @@ -432,7 +432,9 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
>  			      struct netlink_ext_ack *extack, bool *mod)
>  {
>  	struct nlattr *bit_attr;
> +	u32 *tmp = NULL;
>  	bool no_mask;
> +	bool dummy;
>  	int rem;
>  	int ret;
>  
> @@ -448,8 +450,16 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
>  	}
>  
>  	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
> -	if (no_mask)
> -		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
> +	if (no_mask) {
> +		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
> +		unsigned int nbytes = nwords * sizeof(u32);

Hi Köry,

Thanks for addressing my concerns regarding the size calculations in v1.

I think that a comment is warranted describing the fact that only the map,
and not the mask part, is taken into account in the size calculations
above.

> +
> +		tmp = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +		memcpy(tmp, bitmap, nbytes);
> +		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
> +	}

Perhaps we could consider something line the following.
Which would avoid the need for the n_mask condition
in the nla_for_each_nested() loop further below.

		...

                saved_bitmap = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
                if (!saved_bitmap)
                        return -ENOMEM;
                memcpy(saved_bitmap, bitmap, nbytes);
                ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);

                orig_bitmap = saved_bitmap;
        } else {
                orig_bitmap = bitmap;
        }

(Choosing names for variables seems hard today.)

>  
>  	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
>  		bool old_val, new_val;
> @@ -458,13 +468,19 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
>  		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
>  			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
>  					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;
>  		}
>  		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
>  				      names, extack);
>  		if (ret < 0)
> -			return ret;
> -		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
> +			goto out;
> +
> +		if (no_mask)
> +			old_val = tmp[idx / 32] & ((u32)1 << (idx % 32));
> +		else
> +			old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
> +
>  		if (new_val != old_val) {
>  			if (new_val)
>  				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
> @@ -474,7 +490,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
>  		}
>  	}
>  
> -	return 0;
> +	ret = 0;
> +out:
> +	kfree(tmp);
> +	return ret;
>  }
>  
>  static int ethnl_compact_sanity_checks(unsigned int nbits,
> -- 
> 2.25.1
> 

