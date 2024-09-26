Return-Path: <netdev+bounces-129985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC99876C1
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE81F2538D
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7281531C2;
	Thu, 26 Sep 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocvum0iP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667713777E
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365410; cv=none; b=noMCdmYv1oMHZfTLqZSfEdEN5ZDzNUwz4sZRh3/yeqFABp8ISMoN3QfoSaXVcvawitnWAuVBxZY0PTkiVM+4osOOqDUn7UDtPnZvzK5pc95WZ6OiWhV61CLzcxRNZPUFdqg4wYDhENOaznW3sqf9Xq6EgRlA45S3Ai3iyiU+NY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365410; c=relaxed/simple;
	bh=mdTI3S3XFmSD6f8bQhYk9VdNzU5KONAoc7mNLtLK2Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asHKq2on0jI95VODiORwKRotR99g9sLSUkjyY4PySxvgkMCn62Ug/cT2y6aJ7TwjxT4fsN8GaA22eO8RPDFxFsaGKsCcYbjrbdyn/KUTVnltHDbuZQnMhn51dxozXGw5o/U4050u0T+89biJvDFZDunygZDn8xY/dwaadjFEYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ocvum0iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B6C4CEC5;
	Thu, 26 Sep 2024 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727365410;
	bh=mdTI3S3XFmSD6f8bQhYk9VdNzU5KONAoc7mNLtLK2Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ocvum0iPq68u0gTgzZTQIT+wjv1x4+5Uh2aw2OYk3vGB1PuPhe7kAp+W1akYSYOvC
	 zvxwvY8RcMc3GR1PVjsExVZ0psxU/obwVfVB9kW61esjz12pxJ3acDUt9L2mlY5U2h
	 YS31ybDDFuctoO6AYnMeqN30oCRZCXzueqQ2LR3BYiP/fQ6oC/5dzsjAyj7iGB+ezu
	 ia1EcTVekjeAXR5DHOIhmnTO7QDf3412lq286WzFb0wSHN6RY+2evVAbEnhkNtdCJR
	 fNE2HBu3W16f7mum2cBkCqViC1OkrmBXhHoCjW0i654kk+kSYVOy36b1u3rXXf5vzI
	 IDAibrIp3Sp4A==
Date: Thu, 26 Sep 2024 16:43:26 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, alexandre.ferrieux@orange.com,
	nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: avoid quadratic behavior in FIB insertion
 of common address
Message-ID: <20240926154326.GF4029621@kernel.org>
References: <20240926100807.3790287-1-alexandre.ferrieux@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926100807.3790287-1-alexandre.ferrieux@orange.com>

On Thu, Sep 26, 2024 at 12:08:07PM +0200, Alexandre Ferrieux wrote:
> Mix netns into all IPv4 FIB hashes to avoid massive collision
> when inserting the same address in many netns.
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

Hi Alexandre,

Thanks for your updated patch.

net-next is currently closed for the v6.12 merge window. It should
reopen next week, after v6.12-rc1 has been released. Please repost
your patch, keeping in mind other feedback from Nicolas Dichtel after
it has reopned.

> ---
>  net/ipv4/fib_semantics.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index ba2df3d2ac15..e25c8bc56067 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -347,11 +347,9 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
>  	return val;
>  }
>  
> -static unsigned int fib_info_hashfn_result(unsigned int val)
> +static unsigned int fib_info_hashfn_result(const struct net *net, unsigned int val)

Please line wrap the above so it fits within 80 columns, as is still
preferred by Networking code.

checkpatch can be run with an option to flag this.

>  {
> -	unsigned int mask = (fib_info_hash_size - 1);
> -
> -	return (val ^ (val >> 7) ^ (val >> 12)) & mask;
> +	return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);
>  }
>  
>  static inline unsigned int fib_info_hashfn(struct fib_info *fi)

...

-- 
pw-bot: defer

