Return-Path: <netdev+bounces-155398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA1A022D7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE071883095
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F461D9A56;
	Mon,  6 Jan 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVID/dzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357F2AE94
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159079; cv=none; b=Q7CEalFYhmOEzBqP+tuJXCv+c8COfhFzSbMpfVbaFgxLpYudSirgmIDzS/flgclw1WHBmdSTKhr/4jUg/xpL0xCPSv1+lyo2LWRDW79kKs0T0SxeOHTgC5V1SQPLuYZzM6m28sxnT6hQqzejSA5JXG0deSCYGtQrHgZ5vq43t/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159079; c=relaxed/simple;
	bh=DtpVoJYlWiG9wZI+v93lDURF31tn9TWO89RSuMfJ2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN8pJNsu9PC6AZHb0sYP29yV/e6Uf5Z7vdqdDi8axlMOeHPkHZP5hSglsaTT52qctoF9I6TeErqZd689QXqgMKnPnGsroED4n8OPrMYaS2sSNttxvvjMwZNBOI8VPAS+WXNSy1ZHSvX7ipZnvG8E6e050VRPRKyKf8hEbJCwO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVID/dzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33677C4CED2;
	Mon,  6 Jan 2025 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736159078;
	bh=DtpVoJYlWiG9wZI+v93lDURF31tn9TWO89RSuMfJ2iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVID/dzuuisC0G8XHubGgG++O29S9oMg28h4hIJ04s3AXdLtBYAG3b16AThO37AFH
	 Wp+weT/OVg08EHL8UhxtsfACetB381OvY6ZNnc/GWZQ/kp4lgoBDQEhR5rLOyGlTG0
	 5y1d2MzBHR2Lam6JQ3PUlfM8VNGedDXnlTXUC+dLuPFWUEjTqkGmXga3cJjS88RY8J
	 ftJ2j+pWbAI20cScB0u0RH9epV1/hLWiEkwn1yOLw95bE6gQ45UYdGachRxwMoZgyf
	 TpQZYaAe7UvnfXcblwTp9+P0hYHHZLzxpugGBssi72R0uqe30RDgQIB5ErlzFkj9Mw
	 KmJ8kqT3FxoeQ==
Date: Mon, 6 Jan 2025 10:23:34 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH iwl-net v3] ice: fix ice_parser_rt::bst_key array size
Message-ID: <20250106102334.GA4068@kernel.org>
References: <20241219115516.11708-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219115516.11708-1-przemyslaw.kitszel@intel.com>

On Thu, Dec 19, 2024 at 12:55:16PM +0100, Przemek Kitszel wrote:
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
> Extend also the debug dump print of the key to cover all bytes. To not
> have string with 20 "%02x" and 20 params, switch to
> ice_debug_array_w_prefix().
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
> ---
> v3: mention printing change in commit msg, separate prefix from the debug log (Simon)
> 
> v2: same as v3, but lacks code change :(
> 
> v1: https://lore.kernel.org/intel-wired-lan/20241216170548.GI780307@kernel.org/T/#mbf984a0faa12a5bdb53460b150201fdd7cc1826a

Thanks for the updates, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>


