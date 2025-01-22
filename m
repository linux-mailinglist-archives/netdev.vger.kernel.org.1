Return-Path: <netdev+bounces-160268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B9A19174
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BA23ABF1B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC752212B1D;
	Wed, 22 Jan 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI/PS6gD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76D211484;
	Wed, 22 Jan 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549582; cv=none; b=k2iMW8PXAUm8tX4jDz6NqbkVZ23E5ebFTQO4yn9JT2xfrrqgl10UaU0VLbI55qguagZyMSdtLHz2nyjLgsW2951t8k6wegZ/5BgNGaxSuOdWLX8ephNawofUjZhh4P7Fn8NeJZimcuYFaXn6HiVdGPqnUD0ARu5fwEZCPNHLCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549582; c=relaxed/simple;
	bh=Qyd+iCjoTm9xlHts+Ha4dvewQmrB9thaHu54n0DRp4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/kwGxxYX7yh/32x/iUJxNW1uYuCYatLHCEsmaDhxmlJQq+nUUPbE5y6APwTDc5UXME0vWVTxbHQE8l7c9BONEzlrmg3eGGjK7UK1wYCP+RM8fQCizlSuqZWMBvys0hTzGJxBFs8xVgqTGcojW3HrTuamHeLHRFHKTc+VNILSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI/PS6gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9189C4CED6;
	Wed, 22 Jan 2025 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737549580;
	bh=Qyd+iCjoTm9xlHts+Ha4dvewQmrB9thaHu54n0DRp4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI/PS6gDcY+bTmVNQhsJV34/JsLscDE7ukDGJmyYaPgy8edGyj4cScdQxBBuGoU8W
	 MjnillvI2C2VqI0tpYYSE5uNpzK9fEtFHp90DThvXhQMES1++3sj+aDp02PqW/eCou
	 xHj4YOQkx0V887jH+sBMhuG7vyin4N5lxw5gvtjOLgu1xxYnxsCG12wDMxoTfEXj7N
	 OPPPxEZcOYnldEQIS6ZO60B1h+AFLVZEg9Liw6myGhQmZLvW62Aop4KPalZLUwnw1y
	 C7lm6KvmenlEAJCVviZGLjbbFQdaf+7XNvoLq1LUh+W6Hfj7+09bBaVn6ikzL2bqDR
	 Jyk5Ky62qUFEA==
Date: Wed, 22 Jan 2025 12:39:36 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: fix integer overflow in
 xfrm_replay_state_esn_len()
Message-ID: <20250122123936.GB390877@kernel.org>
References: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>

On Tue, Jan 21, 2025 at 02:16:01PM +0300, Dan Carpenter wrote:
> The problem is that "replay_esn->bmp_len" comes from the user and it's
> a u32.  The xfrm_replay_state_esn_len() function also returns a u32.
> So if we choose a ->bmp_len which very high then the total will be
> more than UINT_MAX and value will be truncated when we return.  The
> returned value will be smaller than expected causing problems in the
> caller.
> 
> To fix this:
> 1) Use size_add() and size_mul().  This change is necessary for 32bit
>    systems.
> 2) Change the type of xfrm_replay_state_esn_len() and related variables
>    from u32 to size_t.
> 3) Remove the casts to (int).  The size should never be negative.
>    Generally, values which come from size_add/mul() should stay as type
>    size_t and not be truncated to user fewer than all the bytes in a
>    unsigned long.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9736acf395d3 ("xfrm: Add basic infrastructure to support IPsec extended sequence numbers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The one caller that I didn't modify was xfrm_sa_len().  That's a bit
> complicated and also I'm kind of hoping that we don't handle user
> controlled data in that function?  The place where we definitely are
> handling user data is in xfrm_alloc_replay_state_esn() and this patch
> fixes that.

Yes, that is a bit "complex".

FWIIW, my opinion is that your patch is correct and it improves things -
even if the end result may still have imperfections. And for that reason
I'm in favour of it being accepted.

Reviewed-by: Simon Horman <horms@kernel.org>

