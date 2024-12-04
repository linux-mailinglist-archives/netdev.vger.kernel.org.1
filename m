Return-Path: <netdev+bounces-148763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B319E3153
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAAD287495
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB53B192;
	Wed,  4 Dec 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnnpdPAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47729415;
	Wed,  4 Dec 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278721; cv=none; b=owoGdN+43gE1xx6/azx5FJp+UkfBZgwFlTFnvBijdC/j742PlnZA8X4fyaFcbjcywc/501cHQhJ/epJBITXZh6AGbIvO01yw2C8qzAE1OpLuvxqxeEYcisJkBCwo9OXLrN2L3veEkeQGqtkVijeBCFfrdE5Ydsi6aY8tTYA4FW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278721; c=relaxed/simple;
	bh=2GlwHQZbbRKKabmGuug4EJBubFUAaQetA4T3lj43eY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIgIQLtgPmabvT1A2LA9xpZoa77Gm/o3ZCaz07UVLdpmddPItEP0Y3vhMz+fQKJtY/ekW2I3a5AAj/pCCBRkOmkviZv991hltiIAx3pHDri8oD5uCA6IbMHLCOmz3GGT9cgu6pjlMfMALWuf4np+ub/7yautSczfBMfyPzq4eEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnnpdPAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2BDC4CEDC;
	Wed,  4 Dec 2024 02:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278720;
	bh=2GlwHQZbbRKKabmGuug4EJBubFUAaQetA4T3lj43eY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnnpdPAUEornWBiyp9u7b9bXk6Ly81uhUSN/izdm4KXOoZNPUgOsmiN6pXm6/dfbl
	 Kus3Bxz2bmPw/1d8jG7YJgKnS9YHb2H/KjS7dQ4RkjfuN75pfJ7qEFV172kZwk4IMz
	 WX4ogietknYsX4Ep7PCg9GfQNUjcWBFxtsBVS1MgOq/hM2qENOhMZaiJCcy9xgFsgB
	 NL0pXuJdhuKQJaUr6ibg1I12YlzujkFuezSC83BipLq1wXWvB1/axDxOMRv1s4D/QW
	 FRoUfT99Mx1z7NpwKDKVldCcaP048LMChXde4WpX5Cm5j70DFGklkZp0y16bUhxjzC
	 umGizxkplvsRw==
Date: Tue, 3 Dec 2024 18:18:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>, Youngmin Nam
 <youngmin.nam@samsung.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
 sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <20241203181839.7d0ed41c@kernel.org>
In-Reply-To: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > I have not seen these warnings firing. Neal, have you seen this in the past ?  
> 
> I can't recall seeing these warnings over the past 5 years or so, and
> (from checking our monitoring) they don't seem to be firing in our
> fleet recently.

FWIW I see this at Meta on 5.12 kernels, but nothing since.
Could be that one of our workloads is pinned to 5.12.
Youngmin, what's the newest kernel you can repro this on?

