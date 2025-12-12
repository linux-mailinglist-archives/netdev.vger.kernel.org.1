Return-Path: <netdev+bounces-244510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D556CB93BF
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 543D9301005B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285A2566F5;
	Fri, 12 Dec 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUM0CnA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E423AB98;
	Fri, 12 Dec 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555998; cv=none; b=LO1skQZzb91rqKGvo5eRiTgLWe47/JmiWKIAggLEThc+WyfacYgLtjyforjgoB9jetdA5CP8AHCrHHcdEfckc7Uh21ylkHO/gt1kvf966c8KUa1mpUbzRyZSLzoHkBpudwfrrDprqbTmZ3ZYjvjQAGCi0ZGQrRa1mHpF9wYneEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555998; c=relaxed/simple;
	bh=W+IUPDO4jVl5AWP3w1yWONE38/ov8bvq8js6MKveMrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPvSEfyo4kILfqz1zOhzBEJVz+h/6a962amWEHybspBOSBBMAMHgvbaUo+RwAGf3PiAOXIfYoCFBkS1GO83pguaGigAGkmm0Xh8RvvOinLqBg93bI74k3PucZe3j8AxxJWHoPtx9/r6E1Tw2gy6vSSVVxXpRlEN/OEwygKwfxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUM0CnA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D8EC4CEF1;
	Fri, 12 Dec 2025 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765555997;
	bh=W+IUPDO4jVl5AWP3w1yWONE38/ov8bvq8js6MKveMrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUM0CnA0Nq8DSh6E1grP+RDv3dqRQdn68Uan1fuS8zVYENWsAnxRMSCiZmOy47ufc
	 UYN7jicQodtu5/5Cv706B5HWScEkp94fFyyf1Mu8Z51iq8gC2EVVdz+7N7itmkbNGm
	 qrt4kiGmr8jzofZdGMPvjpgkLr4vIobYYgp0GWgPhXxJoiQmils28AQHtKN/gzuC9S
	 U5xHaHQN8XxXSY3FjFtERC7z4AyWqwEW3P5VDr9VbGHLR5cgAo1T+tFM1M5A9nHKep
	 wWGG+cm8j8gC8HJHu2hvjnzGelaSkWsbjZmJHm/8zRQLWdCR/c9eikq56AIwOnqLMT
	 0nRz1fc/9aOuw==
Date: Fri, 12 Dec 2025 16:13:12 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Satananda Burla <sburla@marvell.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [PATCH net v1 1/3] octeon_ep: disable per ring interrupts
Message-ID: <aTw_GDbjNAB-AVKS@horms.kernel.org>
References: <20251212122304.2562229-1-vimleshk@marvell.com>
 <20251212122304.2562229-2-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212122304.2562229-2-vimleshk@marvell.com>

On Fri, Dec 12, 2025 at 12:23:00PM +0000, Vimlesh Kumar wrote:
> Disable the MSI-X per ring interrupt for every PF ring when PF
> netdev goes down.
> 
> Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> ---
>  .../net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c   | 12 ++++++++++--
>  .../net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c   | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> index b5805969404f..db8ae1734e1b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> @@ -696,14 +696,22 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
>  /* Disable all interrupts */
>  static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
>  {
> -	u64 intr_mask = 0ULL;
> +	u64 reg_val, intr_mask = 0ULL;
>  	int srn, num_rings, i;
>  
>  	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
>  	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
>  
> -	for (i = 0; i < num_rings; i++)
> +	for (i = 0; i < num_rings; i++) {
>  		intr_mask |= (0x1ULL << (srn + i));
> +		reg_val = octep_read_csr64(oct, CN93_SDP_R_IN_INT_LEVELS(srn + i));
> +		reg_val &= ~(0x1ULL << 62);
> +		octep_write_csr64(oct, CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
> +
> +		reg_val = octep_read_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(srn + i));
> +		reg_val &= ~(0x1ULL << 62);
> +		octep_write_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
> +	}
>  

I see that (0x1ULL << 62) is already used in this file.
So I think that as a fix what you have is fine.

But, as a follow-up, it may be nice to name this bit using a #define,
and to define it using BIT_ULL().

Likewise, it may be nice to use BIT_ULL() in place of (0x1Ull << ...) elsewhere.

...

