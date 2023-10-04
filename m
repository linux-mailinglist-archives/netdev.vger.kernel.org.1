Return-Path: <netdev+bounces-37929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C47B7DCB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8DEA281508
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708E111B7;
	Wed,  4 Oct 2023 11:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417211C8D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 11:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D9C433C7;
	Wed,  4 Oct 2023 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696417639;
	bh=1JJrIUPl6pbHzZ7I1g6oBNmULdlUHsuIiITpgEf24Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhs3iQMnZx4oR08DZ/GXEIWmgD/VHwaRYw1qbKslBmAbCUM9ZyX25b0+KROSz41FY
	 rRv07clWP2HIEdfy10yH9XaQbE5BMbVlNn5roem8f5jXtDmbH2ebesao2KAylq12Dw
	 TDt/dD698mjX0ymhnx9LD23Of1aDtzEtL7yBKjxkhGH1AyBct8Co5+hDF9Ocq30QlH
	 q7P2GQnEwSzRpli39K+TnLPNfZLwamYKoC2c7ptjaS+Cm7fodSp1GFRLU7pYkzyAL2
	 048rvKKMkUXmnz55TIYo4hVordZq6g4y/in9hXRRrzn7EmWqgD0gdotKUswvHkwtsl
	 DvM7n2d8mwSpg==
Date: Wed, 4 Oct 2023 13:07:14 +0200
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	stable@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/1] ethtool: Fix mod state of verbose no_mask bitset
Message-ID: <ZR1HYg2ElUjy2aud@kernel.org>
References: <20231003085653.3104411-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003085653.3104411-1-kory.maincent@bootlin.com>

On Tue, Oct 03, 2023 at 10:56:52AM +0200, Köry Maincent wrote:
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
> Cc: stable@vger.kernel.org
> ---
>  net/ethtool/bitset.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
> index 0515d6604b3b..95f11b0a38b4 100644
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
> @@ -448,8 +450,11 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
>  	}
>  
>  	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
> -	if (no_mask)
> -		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
> +	if (no_mask) {
> +		tmp = kcalloc(nbits, sizeof(u32), GFP_KERNEL);
> +		memcpy(tmp, bitmap, nbits);

Hi Köry,

I'm no expert on etnhl bitmaps. But the above doesn't seem correct to me.
Given that sizeof(u32) == 4:

* The allocation is for nbits * 4 bytes
* The copy is for its for nbits bytes
* I believe that bitmap contains space for the value followed by a mask.
  So it seems to me the size of bitmap, in words, is
  DIV_ROUND_UP(nbits, 32) * 2
  And in bytes: DIV_ROUND_UP(nbits, 32) * 16
  But perhaps only half is needed if only the value part of tmp is used.

If I'm on the right track here I'd suggest helpers might be in order.

> +		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
> +	}
>  
>  	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
>  		bool old_val, new_val;
> @@ -458,13 +463,18 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
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
> +		if (no_mask)
> +			old_val = tmp[idx / 32] & ((u32)1 << (idx % 32));
> +		else
> +			old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
> +
>  		if (new_val != old_val) {
>  			if (new_val)
>  				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
> @@ -474,7 +484,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
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
> 

