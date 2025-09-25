Return-Path: <netdev+bounces-226244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53700B9E74E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DE21893BD0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD0283FEF;
	Thu, 25 Sep 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etu4+rfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC51ACDFD;
	Thu, 25 Sep 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793330; cv=none; b=Lw/8ja03x/fvN5PRdVVLDfcebRNjgjJHF8vvDyx5+yLqIScql70aaZW2RsMVMW0hy7oBn0vbEt27xsFp5PNzYQzgV/NIqs+et4EhMl/x9CrJtzHnonScMOOcXUV9ZNcUgDEwuZXhxP1ApaJDsHa0H5zBvX9z66VugXDpqYKg2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793330; c=relaxed/simple;
	bh=F41QS3ZPsVh0OZ2B5xiSK7R/BbbchGf3UKyh+TVD1DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTn8HYrvSIoxwtvalcnU00hLilq9SB7lc4TT+jkDNuu9OA4t1t+lsAy09PzlMBVd6pQSn6oQOlUF3y1HzssFq1bWp5gRTwYnfB/w5elHWQXjfq4zp05yLfSgZuYYvZ07mnkowhrQt9T3OvKShE3Cs3+HoRTrSu+tSq20OdWdTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etu4+rfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFC1C4CEF0;
	Thu, 25 Sep 2025 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758793330;
	bh=F41QS3ZPsVh0OZ2B5xiSK7R/BbbchGf3UKyh+TVD1DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etu4+rfrzCqNV5ry38PWUR8lUBaF7Tkz89jm7s46OS1rLc5dCVMQuoJJty58GKXFG
	 X0fE5tmYMcNnOpW1Dfidc7+UHW8hnRjzelLyYO379uEvMEXuXnZ7GqLxgzx63UJdME
	 jNCIm0BcEt95rD7MNSPepRIypkQQzkc8TZ0wvRhzdgOHECkb/KztHZJ6DmWR7dNxjy
	 BvY8zpyUihB5isMaTw6m93L6IZHarnEkiqmOSsu25gZM80MhI9fhgKSTJU2F78DvbF
	 B6hf9hNNS2BRt/iD9Ymr0GCdvl+8mcohcL+1upVbQtQV9emsoX2IviYAE4Be6NT5Jc
	 y4DBBcWd1Rxqg==
Date: Thu, 25 Sep 2025 10:42:05 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, xfr@outlook.com
Subject: Re: [PATCH net-next] net: stmmac: Convert open-coded register
 polling to helper macro
Message-ID: <20250925094205.GC836419@horms.kernel.org>
References: <20250924152217.10749-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924152217.10749-1-0x1207@gmail.com>

On Wed, Sep 24, 2025 at 11:22:17PM +0800, Furong Xu wrote:
> Drop the open-coded register polling routines.
> Use readl_poll_timeout_atomic() in atomic state.
> 
> Compile tested only.
> No functional change intended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

I agree this is correct. Or at least, it looks correct to me.
But, FWIIW, I do have some hesitation about untested code of this nature
being accepted so close to the merge window.

Reviewed-by: Simon Horman <horms@kernel.org>

...

