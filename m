Return-Path: <netdev+bounces-17160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344617509FF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB01C21125
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAC34CC0;
	Wed, 12 Jul 2023 13:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995F2AB5C
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28CDC433C8;
	Wed, 12 Jul 2023 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689169859;
	bh=kdW9rcGTBy8xaWPezaxcrnjRQsfta6w55AE9h1GG9iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJdxJIwRsspor8VKxpXCBekWKR97OYW/aJNe9kkx5vunCim0+cNohGFswrPnf/92G
	 /ZLBQMn8U82GEJnRF+6tKJB65QWmzDv7zorwxoncVWsIRCLMJUSg723iI3FY6XTbyJ
	 KE5AYMJwDR9AecMDj7TML+YUkC89IqC4M6DDNCbx82l3oiconcbI867Bk2vFRXe6Le
	 /VeVkqhWXpjS9dL+SFTopM3QXL1q1q/1+mvkojEfURDgeTdU7KpiyOQatXGZI0L5vx
	 r03AliAVW8lDoDte+wihV70AFCvorJdRL7Tiz65n906W/we7YDVYPtQZS1r0DmMk/d
	 uJZlvr8yQ7e/w==
Message-ID: <837f1d5f-64fa-2496-6379-09e5e95252f4@kernel.org>
Date: Wed, 12 Jul 2023 16:50:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] net: ethernet: ti: cpsw_ale: Fix
 cpsw_ale_get_field()/cpsw_ale_set_field()
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230712110657.1282499-1-s-vadapalli@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230712110657.1282499-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/07/2023 14:06, Siddharth Vadapalli wrote:
> From: Tanmay Patil <t-patil@ti.com>
> 
> CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
> The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
> field will be strictly contained within one word. However, this is not
> guaranteed to be the case and it is possible for ALE field entries to span
> across up to two words at the most.
> 
> Fix the methods to handle getting/setting fields spanning up to two words.
> 
> Fixes: db82173f23c5 ("netdev: driver: ethernet: add cpsw address lookup engine support")
> Signed-off-by: Tanmay Patil <t-patil@ti.com>
> [s-vadapalli@ti.com: rephrased commit message and added Fixes tag]
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw_ale.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 0c5e783e574c..64bf22cd860c 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -106,23 +106,37 @@ struct cpsw_ale_dev_id {
>  
>  static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
>  {
> -	int idx;
> +	int idx, idx2;
> +	u32 hi_val = 0;
>  
>  	idx    = start / 32;
> +	idx2 = (start + bits - 1) / 32;
> +	/* Check if bits to be fetched exceed a word */
> +	if (idx != idx2) {
> +		idx2 = 2 - idx2; /* flip */
> +		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
> +	}
>  	start -= idx * 32;
>  	idx    = 2 - idx; /* flip */
> -	return (ale_entry[idx] >> start) & BITMASK(bits);
> +	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);

Should this be bit-wise OR instead of ADD?

>  }
>  
>  static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
>  				      u32 value)
>  {
> -	int idx;
> +	int idx, idx2;
>  
>  	value &= BITMASK(bits);
> -	idx    = start / 32;
> +	idx = start / 32;
> +	idx2 = (start + bits - 1) / 32;
> +	/* Check if bits to be set exceed a word */
> +	if (idx != idx2) {
> +		idx2 = 2 - idx2; /* flip */
> +		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
> +		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
> +	}
>  	start -= idx * 32;
> -	idx    = 2 - idx; /* flip */
> +	idx = 2 - idx; /* flip */
>  	ale_entry[idx] &= ~(BITMASK(bits) << start);
>  	ale_entry[idx] |=  (value << start);
>  }

-- 
cheers,
-roger

