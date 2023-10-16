Return-Path: <netdev+bounces-41191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD77CA3A1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EAB1C20932
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699571BDD8;
	Mon, 16 Oct 2023 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKpgoN/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21B15ADD;
	Mon, 16 Oct 2023 09:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F4FC433C7;
	Mon, 16 Oct 2023 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697447453;
	bh=9Lx78ecl0MZuF5F5PNauQCDBeFdcUns/BLrcQKTwtW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKpgoN/b8/gx5spIIHKQLj/BYMaITLA0ShZI8w54Z6AZp3+yxr+251NrFO3tI9/HA
	 dKuuuaYuLdJRYP4053aXJObFgODZ8XabcwBbEU7z1bl3ojOSeSyAr2+h/jSiOtNRvv
	 x0+44lYRpiiNjJ/Pr/xd80TumRQQ0bWoaXWJE4Wz7a3QKh/SwR7NlIUN8qDhptlsWQ
	 ItL7ryT709B5NYfrKHbsSdf79BPk+Ioj7jZrYg4C2GOamcEbXeK66myoQtT6o7Rtc4
	 hV9OmkzeywmN8uujBf5iHby+/H6F6OgKHk62t8aRudGlfHwkRZ4dOOzkpMHKmq3oPU
	 3kZxk5sEhKImw==
Date: Mon, 16 Oct 2023 11:10:48 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
	ncardwell@google.com, ycheng@google.com, kuniyu@amazon.com,
	morleyd@google.com, mfreemon@cloudflare.com, mubashirq@google.com,
	linux-doc@vger.kernel.org, weiwan@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
Message-ID: <20231016091048.GG1501712@kernel.org>
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>

On Wed, Oct 11, 2023 at 01:30:44PM -0700, Haiyang Zhang wrote:
> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> There is no single value that fits all applications.
> Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> optimal performance based on the application needs.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3: Updated doc as suggested by Neal Cardwell.
>     Updated variable location in struct netns_ipv4 as suggested by Kuniyuki
>     Iwashima.
> 
> v2: Make it per-namesapce setting, and other updates suggested by Neal Cardwell,
> and Kuniyuki Iwashima.

Thanks,

this looks clean to me. It seems to address the review of v2.
And keeps the knob as syctl as discussed in v2.

Reviewed-by: Simon Horman <horms@kernel.org>

