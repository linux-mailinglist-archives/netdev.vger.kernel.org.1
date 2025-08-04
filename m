Return-Path: <netdev+bounces-211545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFEB1A052
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D663917522D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBA252912;
	Mon,  4 Aug 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+1pta4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B192405E8;
	Mon,  4 Aug 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305977; cv=none; b=kx8Cl4KqgivasACsvwDy955SYE/W5dPi53dS2B1vE+2UT8SgptBIim9jGig+GAG51zmOnPEB8tyTYy2QlUpAEF2Ag2Ik7AlnfgaA8s/G9yLsWsF5rEktN9xEpNU9acrAs7OqAOlQ5LyBXwuITWSMKRzKFADVgDYX8TDknJnCVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305977; c=relaxed/simple;
	bh=TKLS9TYLXqeSRKUBXajbCG2BW+JZWM2tD6Xn5jYT5iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/svZ423j2dFLLd9nGMV8fA0lFs4fUQ2k3SHEqiJgIquVPH4rr2WUsUYmrU7hXQQ3ex3Jj6z3hHVD1Fezrks3iJYZB9ur9d7eR07lAuY0CbeKcA3Qhd0AfT7uHi/ckTjuy3xxxKwBWMAPbYlthJDOC2Vn0V3kmCgEzyQbP4/Jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+1pta4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B29C4CEE7;
	Mon,  4 Aug 2025 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754305976;
	bh=TKLS9TYLXqeSRKUBXajbCG2BW+JZWM2tD6Xn5jYT5iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+1pta4zXXz67PfIQwuMoJISCjPK3kbI24GV2nCGW7MQQy+qkOdigeNWFnCWrUSGU
	 X6JR4h57+UqIoHKxJ05jqxBa+OYolfwqETeD5s6tAqUhvP1IcL8tn0KZJ+4DlQsTTO
	 5sa6GYKvKWat3cG2EQ1Z7bjebBVTbLrZg0OVEIn3gnUN6zDej9SI9Zg51G2mInaCOV
	 9wFkwyE615d/i2IlaoEojZstusBkEKV3C9rJJpidfA+SHZYj5zY1pnZWb1rqZw70NK
	 iKdpS/+WKh8CXK4PF4ukXQjBvHVHGLFSmrlO0I889sLkx8U6NK/BQv8HKt1pbShkTV
	 Qh+Msqh2mjLNw==
Date: Mon, 4 Aug 2025 12:12:51 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kernel-team@meta.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 2/2] eth: fbnic: Lock the tx_dropped update
Message-ID: <20250804111251.GS8494@horms.kernel.org>
References: <20250802024636.679317-1-mohsin.bashr@gmail.com>
 <20250802024636.679317-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802024636.679317-3-mohsin.bashr@gmail.com>

On Fri, Aug 01, 2025 at 07:46:36PM -0700, Mohsin Bashir wrote:
> Wrap copying of drop stats on TX path from fbd->hw_stats by the
> hw_stats_lock. Currently, it is being performed outside the lock and
> another thread accessing fbd->hw_stats can lead to inconsistencies.
> 
> Fixes: 5f8bd2ce8269 ("eth: fbnic: add support for TMI stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Thanks,

I note that hw_stats_lock is documented as protecting hw_stats.
And that it is already used for that purpose elsewhere in
fbnic_get_stats64().

I do wonder if some refactoring could allow only locking
hw_stats_lock once in fbnic_get_stats64(). But that line of thought
doesn't effect the correctness of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

