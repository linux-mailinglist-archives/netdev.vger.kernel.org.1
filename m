Return-Path: <netdev+bounces-245893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01146CDA4FC
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91A393025710
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58093349B1D;
	Tue, 23 Dec 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK8r1FLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370534A3B4
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516935; cv=none; b=CMA8PexouiCpnNm29lPyjX0YytM08eRjMNxUrTNi2Sj1s0Kj5ntqSDff1AjfiDB2N83KA04KWS/Vij5WK3A7Arvn+/PHwf8O9s1WpZ15Emlmn5DUCHMh7/d1vwlaXsgy8r7uYAs3Sq9kqX9Y4e8pUQN3brOOkROkJJUXqFMz1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516935; c=relaxed/simple;
	bh=bxWOviDURpu0BngGmKehQNKByWXinUctQypHgi4C1Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfCd0oTE6171t1Srj2bpnIM0B3BMeKFJ/8KBL9mn2pykBMPXzXhglOQwaopAfZMsTmW1J3zCf7Hj6aujmKDtnIRKLdVYTUgtzI5EB7bWHEfC5M1WNk5Hm36mmcAox/3RbX8FpbaMc8JCb8HVnSFhEBQ4EZ3XLMSM9ynSTlBANNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK8r1FLM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso34956685e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766516932; x=1767121732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f94AB6cb3HG/eWMYQqlXm4FzeTrvvTstknIkIvvEzDE=;
        b=QK8r1FLMjJE3492wOv2Rr8QnNQcQF9vqb/tLzhZLM5Sbs9figDy+6ef1fg0VW3k0OY
         tpPJN3RBvVo9CXLrR/l1rG/rUGt0x1g9O1WlkM+qXHEY1ICYU5a5h3k+Kk6eqfkg7lKt
         mjqBi3BGCytnniT0HUEErwK3RdQf4NhBv6gpff3hibZx465r4qj4A95ZpuOTjkSzhnvn
         xfIV6fzAsPpxmHLcLIpDVdXzvKn4HW+5K74EDLgrXo9m0yqlOaJUQ2UY2AZFOm+5jA51
         tLiaU+fejseQJvMotlTx2UNKHHw3ORp6OgLWppVFrk8RO9mDjc31yY9ynQxTNHAuXa3N
         1CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766516932; x=1767121732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f94AB6cb3HG/eWMYQqlXm4FzeTrvvTstknIkIvvEzDE=;
        b=FpnBZOk+x348Qojlk5RFZTRVku4oSDPlj8vcm52RkNM3gBnhW/rpvOnoKucziiMT6k
         oUtw+eHfiyV056VbnO5rdFkI+RQyUTEA3Z9+cMBUbQKXq/AsNnUIwo9gpjnSXkBByRkl
         MY7bEgepRc8rs6ZixLT7V+ElomWF1yYcEqz30tzDw0MgdgQCK3uFrvRepnj12wxDXpv2
         46lSgLdcuA4beC2GGecG1ZPkpkl9i7kiLiXIV4aR05XYS2kJLPMSDg9PyzzlJmTd1wNP
         JJ/hO3Hdf4hcPuHVEsm9L4BjQDeZDYEArwYoE0no3l6ZQy4FT12y/zFAUavexi0Xs48q
         qCKA==
X-Forwarded-Encrypted: i=1; AJvYcCV4XkJJRzc3y2ZlKgiBqJF43EYlr9AAyILcVDJHgB4Z6jZbIGR+s/JJ/LT0V6poBUe6DbvcscM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRWh42UNubuMiKowHfmU5J1VibdyEQRcyGQPZ7mczBi1qnw7p
	z/bC2I+EqgMgpsIdc7C1nf+Q7iIvrgqGG/3ZZhABInCjAbCB2hbYtNiw
X-Gm-Gg: AY/fxX676StVtEzGh+r0OBRCDBtDKcjcIRyPruMU4D3b4vqQ07wTM0yg/AMBtfrCGrS
	SqQQEi/DQJ+3pEv9k+NX0p00txPBz4tsxj28j21TcEsyNMI9rGurSNboailp7IAPQkbgFYgUzcG
	LO0ee4cxxD2k5bdqZtnv+CCPCNFJuPgsm0dmNY73WJx0tSMh005uoMmufOXdIwwUoggpC0RV0M7
	z1xKlKzXa7fjhF19xMpaMccgB84KXPNrdsxlLSt4z35dvQx4XEwDqhGmehdZYBT4D0GPGZVsgN5
	6Ze75swdaeEHpnmirCsyOiHJOpU9KemMIiY3EHyDB/eNt7UnLuVOArVkGpuaCuKzWNYrXfvXqrf
	F/DByoXcaH7azBQzDLMnsmAbgTvOuvGraPOrV4gNArxI08MTDGVIqENSioNV/ZDWcLYmnvLTk5v
	WBSNEoeVVuwezqQDrEYYw25dVh2od/EuptAunZ02LDbAsRECwN5eE=
X-Google-Smtp-Source: AGHT+IH3Q0hPHKJKChpo35Wgcum55tE85eoWpfZOgkdjlvObESRWfsHXpeJunSU5cP6/XSJwW1Ja9A==
X-Received: by 2002:a05:600c:45cf:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-47d19533403mr139222325e9.4.1766516931787;
        Tue, 23 Dec 2025 11:08:51 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm29610174f8f.15.2025.12.23.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:08:51 -0800 (PST)
Date: Tue, 23 Dec 2025 19:08:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
 <akpm@linux-foundation.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ice: use bitmap_weighted_xor() in
 ice_find_free_recp_res_idx()
Message-ID: <20251223190846.76ff4dc0@pumpkin>
In-Reply-To: <20251223162303.434659-3-yury.norov@gmail.com>
References: <20251223162303.434659-1-yury.norov@gmail.com>
	<20251223162303.434659-3-yury.norov@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 11:23:01 -0500
"Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:

> Use the right helper and save one bitmaps traverse. 

It makes no difference here.
The bitmap has 48 entries and is just a single 'long' on 64bit.
It is also already in a very slow path that has iterated all the
'set' bit of two bitmaps.

The code is also pretty convoluted and confusing already.
One of the other bitmaps has 64 entries, recoding using u64 would
make it a bit more readable.

Doing the 'weight' here is also just optimising for failure.

Oh, and using u8 and u16 for function parameters, return values and
maths requires extra instructions and is usually a bad idea.

	Dvaid

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 84848f0123e7..903417477929 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
>  			  hw->switch_info->recp_list[bit].res_idxs,
>  			  ICE_MAX_FV_WORDS);
>  
> -	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
> -
>  	/* return number of free indexes */
> -	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
> +	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
>  }
>  
>  /**


