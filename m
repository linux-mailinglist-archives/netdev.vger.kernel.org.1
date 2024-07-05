Return-Path: <netdev+bounces-109401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDF928553
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787371C227F8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CF1474C9;
	Fri,  5 Jul 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S96Hkxiq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEB146D6F
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172547; cv=none; b=lZKeI5nQfZiOQjdr/0Jn5Dpno1Det/L+o9rrslgy62VDuvtbignl569/1mEmSyUrFc2qvNwp0NZJBfg3o9porJCVlofxCOmIwvE8KwgQk68KmhhoFEmTvOko3X6ghaazHMWQSMSUTxOR310zWRGVe3QjWVgNyI+wE23SM37XCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172547; c=relaxed/simple;
	bh=ZFC0i9oO5aKvq1enj6LjhPA7uYNCMez5URRGBg7GdqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIuz6zo07ez0wQwgQg4AFjjElgLDY7jWr1/H1sE0vmPc6JKWtYoOGLqGq6z5Kxwczc8hCPNPgyHoBABRNnjcflOza1sDDmvUwKTPFO27AGgKF6HQz8mcaUuQ+iLU8covEWOLsM9M+qNiBIRBaG5XmDsknZBKunW1iZVY9zU/8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S96Hkxiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83949C116B1;
	Fri,  5 Jul 2024 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720172546;
	bh=ZFC0i9oO5aKvq1enj6LjhPA7uYNCMez5URRGBg7GdqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S96Hkxiq0p2FWnA98XUtnXgWFgrEw7gFNp+y+wE4j6MT1IbwOX32Yf3BNGJ7aqhvt
	 K2GzT85JGNd/tbt2OmsDJcJtqepbTdcwPM3pzlnmUFYHPZKoFHMJ7HrGJXB9oB3mrE
	 tYz8UuL/A1PVgVkawq6A7P2ZB6p6TfNLuKOJ06xgFOJl8oODtqSDWbhtvWL6AjHYr6
	 FSuF/jw+iXWmNwyz3ppTThS/5J8/mjZE9lbhrNTrm1800JV0fKPOI2Eh1TG8oY1nJj
	 czJenm4zgxP3W1W5jP+D7xJDKMxFP5/LQT1eOVeCxNHheJMwExrT7fXb6Ul7QYPhpH
	 6KWt5IjpR6tOg==
Date: Fri, 5 Jul 2024 10:42:22 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	jhs@mojatatu.com
Subject: Re: [PATCH net-next v2] act_ct: prepare for stolen verdict coming
 from conntrack and nat engine
Message-ID: <20240705094222.GC1095183@kernel.org>
References: <20240704112925.10975-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112925.10975-1-fw@strlen.de>

On Thu, Jul 04, 2024 at 01:29:20PM +0200, Florian Westphal wrote:
> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP verdict

nit: debugging

     (I don't think there is a need to repost just because of this)

> with NF_DROP_REASON() helper,
> 
> This helper releases the skb instantly (so drop_monitor can pinpoint
> exact location) and returns NF_STOLEN.
> 
> Prepare call sites to deal with this before introducing such changes
> in conntrack and nat core.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  No changes, v1 errounously targetted 'net' tree.

Reviewed-by: Simon Horman <horms@kernel.org>


