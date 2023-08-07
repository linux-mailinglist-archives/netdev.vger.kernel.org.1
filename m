Return-Path: <netdev+bounces-25122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E378377303A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201DF1C20B86
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB25174EB;
	Mon,  7 Aug 2023 20:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77816408
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF103C433C8;
	Mon,  7 Aug 2023 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691439623;
	bh=V9AFzfpmpeFOjhnhAQI/RQMk0Kz5hdHnESDiZoo0NE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZBLyIvkTP6BBmNj0Hw8jMi44b6gjK4DwS8jvbZVclYdwWi1kFgkt8v95qVsiaho7n
	 ntMLXdtZmc3F7GYidww1VJZ0sR+hvnBYjKJiBL46mkHIPFRb4CP8a+61uuvTdsBpBS
	 l6HKVoB4wBUmnCJpFpTvizNq30D4XNUxH5/N0dhbdLaiDoXFh/f9Sz2DJNt4+8mM76
	 xkDK/yKk5h9B42oYwhs0cD7OzYJI/YNRaFrYHYUCfAPZhBfyvrye+hcyo+6bH9YZuW
	 +14X7q/s3fJin4CfmY+JKGGiKEb+gsOa3rcHzEIuLns+hJyhI2UTLBhmA/m/LwV7D8
	 u6T/fo2GIDYlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3FCAE505D5;
	Mon,  7 Aug 2023 20:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] page_pool: a couple of assorted optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169143962373.20323.15736867821555960200.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 20:20:23 +0000
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maciej.fijalkowski@intel.com, larysa.zaremba@intel.com,
 linyunsheng@huawei.com, alexanderduyck@fb.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, simon.horman@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Aug 2023 20:05:23 +0200 you wrote:
> That initially was a spin-off of the IAVF PP series[0], but has grown
> (and shrunk) since then a bunch. In fact, it consists of three
> semi-independent blocks:
> 
> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>   not overbloat the consumers not needing complex inline helpers and
>   then stop including it in skbuff.h at all. The first patch is also
>   prereq for the whole series.
> * #3: Improve cacheline locality for users of the Page Pool frag API.
> * #4-6: Use direct cache recycling more aggressively, when it is safe
>   obviously. In addition, make sure nobody wants to use Page Pool API
>   with disabled interrupts.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] page_pool: split types and declarations from page_pool.h
    https://git.kernel.org/netdev/net-next/c/a9ca9f9ceff3
  - [net-next,v4,2/6] net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
    https://git.kernel.org/netdev/net-next/c/75eaf63ea7af
  - [net-next,v4,3/6] page_pool: place frag_* fields in one cacheline
    https://git.kernel.org/netdev/net-next/c/06d0fbdad612
  - [net-next,v4,4/6] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
    https://git.kernel.org/netdev/net-next/c/5b899c33b3b8
  - [net-next,v4,5/6] page_pool: add a lockdep check for recycling in hardirq
    https://git.kernel.org/netdev/net-next/c/ff4e538c8c3e
  - [net-next,v4,6/6] net: skbuff: always try to recycle PP pages directly when in softirq
    https://git.kernel.org/netdev/net-next/c/4a36d0180c45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



