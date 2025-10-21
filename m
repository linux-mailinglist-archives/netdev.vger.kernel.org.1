Return-Path: <netdev+bounces-231052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F93BF43A8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2571897C2A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25251DC198;
	Tue, 21 Oct 2025 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0uN+GWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553418CBE1;
	Tue, 21 Oct 2025 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009406; cv=none; b=KY+h42IQG2jfeHe9z6HcPeptRZ5uYrHi5R0PW6JTC5u/T1gexucts2l/POK9d20PMnPDij3nOQYYRsPYZWH+PYpqYmbnvo+p/H2/X6ojgszmfDPetO1bxcGvU1WFGhWDN2WMXWWiZJx0ffj3WcIqtd0DB/Ke1mrMSeRdOkqQxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009406; c=relaxed/simple;
	bh=FlG+exzSWR++/edIMS0S5Y+KS4hcAr0q2UH5cA3Hx28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+kyREmI0HaKSQbCR+VrESx5j3wTmIeqW2ApbzjyYyMx3miutDft7UO7E/QYTPCrYxga7FxChYH/nb50jK0ShNMuFo2u/qUUgAI62HHps0iWTi+hQ8YujTVv0/oo7+baUrHAKpAO7IkbfmwbIfeP1+QxUBol4EpjLpBOVCuIdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0uN+GWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A1C4CEFB;
	Tue, 21 Oct 2025 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009406;
	bh=FlG+exzSWR++/edIMS0S5Y+KS4hcAr0q2UH5cA3Hx28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0uN+GWjFLqoIVLzDdrkPOJbT42cSjN81WJxOrJIgcS2nsX1w0KLhzoX0J0NTH014
	 KVlPKkGOEYVYGVfS+O+5zBuHTl/YeI/EjUGjOyioazJl9ZeonnXyIyDK92Ayif48Io
	 l9vW3HBG7tDVxsPrz6l60OXCjb43UCCgpA7zo7DMGE2oWnqNkCAfy+rFQnZxklYnHt
	 9UQjDk5VRVdEMOrurh1VVtXRensKY+fRyKyHmFax4XS/KiwEQS3X3oprhY3lLDAnWk
	 1sMtsK4L0gRQxRGOocW0GV9hGfNc2Hx0iCYmDezS790nFbVoH7VApKtg0K1egwkfxI
	 4n7QqZuvC2TtA==
Date: Mon, 20 Oct 2025 18:16:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Dan Nowlin
 <dan.nowlin@intel.com>, Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 05/14] ice: improve TCAM priority handling
 for RSS profiles
Message-ID: <20251020181644.5b651591@kernel.org>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-5-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-5-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:08:34 -0700 Jacob Keller wrote:
> +/**
> + * ice_set_tcam_flags - set TCAM flag don't care mask
> + * @mask: mask for flags
> + * @dc_mask: pointer to the don't care mask
> + */
> +static void ice_set_tcam_flags(u16 mask, u8 dc_mask[ICE_TCAM_KEY_VAL_SZ])
> +{
> +	u16 *flag_word;
> +
> +	/* flags are lowest u16 */
> +	flag_word = (u16 *)dc_mask;
> +	*flag_word = ~mask;

Please don't cast pointers to wider types, get_unaligned() exists 
for a reason. BTW endian also exists, AFAIU, this will do a different
thing on BE and LE.

>  /**
>   * ice_adj_prof_priorities - adjust profile based on priorities
>   * @hw: pointer to the HW struct
> @@ -3688,10 +3733,17 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
>  			struct list_head *chg)
>  {
>  	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
> +	struct ice_tcam_inf **attr_used;
>  	struct ice_vsig_prof *t;
> -	int status;
> +	u16 attr_used_cnt = 0;
> +	int status = 0;
>  	u16 idx;
>  
> +	attr_used = devm_kcalloc(ice_hw_to_dev(hw), ICE_MAX_PTG_ATTRS,

attr_used is freed before exiting this function, every time.
Why the devm_* ?

