Return-Path: <netdev+bounces-142160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 694399BDAE2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC75B23DE0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECB16FF45;
	Wed,  6 Nov 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqSgYMUV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975A165F11
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855089; cv=none; b=FDADpc0IBaBx1Cf3qIuLoiY7CmrqyKHXtWcFVHEVSZX76X1hfo7SP0Q4DN7RFeLQpxGLmQn4hK5FlqTAvAMoOY086Vu730w5N6PuGrUYJFKrugC4cjRuGPAOHSVDtz4lS0lsPsQ5+8xtUIRHVQJK+GRveshvKrbb63+uv7ki0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855089; c=relaxed/simple;
	bh=Nm+WnKi2dN079NhHE7HTGtIts2p+UbTc/UgMpH85mjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfvEpivDqYytryTGVSsNm+RcuGUgekgJWKHN/ka/5QlDzbzPL85Zc8lOV0Src3zTEh+Rz7pXYC9feaMYdfX7yw8s98M7t3BlcVt0YmgI1ZKqoHdmfBxxZavA7UaBfqRc3S88euPWulBEvKHSvfWedS5579GoS0cdg2y6HzVs0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqSgYMUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF4EC4CECF;
	Wed,  6 Nov 2024 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730855088;
	bh=Nm+WnKi2dN079NhHE7HTGtIts2p+UbTc/UgMpH85mjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqSgYMUV1G5v6n7f88sbkLT1m6vL6Q9o5ZmrdZ8O6XqZ3IV5SJ9pjcpWbs7d09U64
	 2nd7XSJsobQW9qStGA+c8w8Z+MsDGBzMaLpJfsN5RRWX93oDhaZCvF21VJKSq4emzk
	 4SwbdeznBscBMrk7H85wWXX0lvX23p8J03nQIqFCYiKwzdAYXAQ+eL7eyWgfqip6KP
	 Cl2Ceu8Ad+txyL+h3OA9ztYSZrM7vbiHAZ3oQ1jTXeMmqf4baIhmQztsMd/aP4uQR6
	 nMkoHEjWDnzwyojvojwv3Iy19nXSgVUFtEIQM7XGi0NcTQYP6OGAZ9CbzMgc957wfy
	 HC3zSSt8+OGow==
Date: Tue, 5 Nov 2024 17:04:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
 <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct
 rtnl_link_ops.
Message-ID: <20241105170447.1d32beda@kernel.org>
In-Reply-To: <20241106005825.3537-1-kuniyu@amazon.com>
References: <20241106005237.2696-1-kuniyu@amazon.com>
	<20241106005825.3537-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 16:58:25 -0800 Kuniyuki Iwashima wrote:
> > > I guess compiler will warn if someone tries to use < 255  
> > 
> > I chose 1 just because all of the three peer attr types were 1.  
> 
> s/chose 1/chose u8/ :)
> 
> 
> > Should peer_type be u16 or extend when a future device use >255 for
> > peer ifla ?

I think we can extend in the future if you're doing this for packing
reasons. Barely any family has more attrs than 256 and as I replied to
myself we will assign a constant so compiler will warn us.

