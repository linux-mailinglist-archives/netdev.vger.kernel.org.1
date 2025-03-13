Return-Path: <netdev+bounces-174558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F3A5F3C8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBC3AD967
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06E0266EF0;
	Thu, 13 Mar 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8/NvYdd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C033266B68
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867578; cv=none; b=gkAUeIwEy1Y90/VZs4+HmpNeELdqceKc0PsrNOfA0KqMXWtIkoGgqhiMfxpXyc+ft8nP/rilfZBPcWzSBOjcHgrzSHTePzVSI0gVnKtJKutR8QyamLVSSkjM6m0Vbr+IdRAA30eV0/2dkspYPabaxCZCBSH+7/9x0jP/gp6AGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867578; c=relaxed/simple;
	bh=Oy2J8HdRGZjGPnd0MKhGX6DrjHeSW5d6ynq2S0GUk4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPOJ+tg4PPXhSc53dex4wn07G3hE5c4cI6Y9rSxxEx5RdnOgO9TJCWPmkzXYP0UnShOImw9DCVXtao8JHSo0RXfqYCNQLwKttPourF5NNd+77Am6lEvJH5SI/xp7pX5HnAehHISZVrVwlGhAKGfkgzRK2SdqRUVr7b9KNikhZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8/NvYdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49317C4CEDD;
	Thu, 13 Mar 2025 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867577;
	bh=Oy2J8HdRGZjGPnd0MKhGX6DrjHeSW5d6ynq2S0GUk4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8/NvYddVbWaU/iOXPbhbOq/RS+n08OQ3W++Ud+355BWZNVrdYLd8sFpBSPhVNLMg
	 AXHd12qAuOvNi7Z9mGgbvrWSg5D7Vwq0LBm0+A3nfN9mjjTpVi6nuZyjoYQHIDatA7
	 v30QwsF0r0kXbctpdfSUTvL8f3yMB5rWGptcCTs6sCymGiw0xIXcEj01/Cz9QSALIB
	 JOcuJMkgh3++tq/2ymgfvYL/QnUJk8yS/YRR3JZk1rAC5VfhWB2Diq+77RWpsO5cB8
	 LAY84X1mAlqjOBS+VX1uxC5QyIarZkHya2uKmSa6JkIDQkkNgwKq8y6JAE/fsVYyXw
	 9IU5A2AuIa4XQ==
Date: Thu, 13 Mar 2025 14:06:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stanleyjhu@google.com, yumike@google.com
Subject: Re: [PATCH ipsec-next v5 2/2] xfrm: Refactor migration setup during
 the cloning process
Message-ID: <20250313120612.GK1322339@unreal>
References: <20250313023641.1007052-1-chiachangwang@google.com>
 <20250313023641.1007052-3-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313023641.1007052-3-chiachangwang@google.com>

On Thu, Mar 13, 2025 at 02:36:41AM +0000, Chiachang Wang wrote:
> Previously, migration related setup, such as updating family,
> destination address, and source address, was performed after
> the clone was created in `xfrm_state_migrate`. This change
> moves this setup into the cloning function itself, improving
> code locality and reducing redundancy.
> 
> The `xfrm_state_clone_and_setup` function now conditionally
> applies the migration parameters from struct xfrm_migrate
> if it is provided. This allows the function to be used both
> for simple cloning and for cloning with migration setup.
> 
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
> v4 -> v5:
>  - Remove redundant xfrm_migrate pointer validation in the
>    xfrm_state_clone_and_setup() method
> ---
>  net/xfrm/xfrm_state.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

