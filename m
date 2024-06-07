Return-Path: <netdev+bounces-101859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831D90050D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E876AB2929E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DF199398;
	Fri,  7 Jun 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2JAi9iz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316261922F9;
	Fri,  7 Jun 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767164; cv=none; b=Bmmm1A7GbmOye5UVLIKf+Ocyb+KWTsp3Xk2rGcQ4CAGf5m4MQ2liF8oPBhuJ03ENpp+my1pX6BJcBTJOTz6/DhF4uSFSEckqX1paAZiEXDpgjBDRFivtb+qQJy2B4bZdy8p6LhX7UmuZJOC0LktFHnBjMH4B7DkRCHhEasa9d0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767164; c=relaxed/simple;
	bh=6bVomJeklHfwq6dyxfuwrhU6D4+V79v408gXjcqI/WE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i25ZV5a1OiNNZ7x8VfGKiuTCvTrw6Rvbx03pHpfyk/CTkvPE5BdhUlJiiwEG5ePWDEt5yzQ+gKUB0qmd8UOlVS3ux45PSLKCjkwvxOL2kYUZFkyVpciGfh7B7LfSjA/eCs9ABPhW2xR5dfHZi/cQQgS31h8aT7fuZVbFK6wCOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2JAi9iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A041CC32782;
	Fri,  7 Jun 2024 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717767163;
	bh=6bVomJeklHfwq6dyxfuwrhU6D4+V79v408gXjcqI/WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2JAi9izIP49nv1hbYQBXEoeMzNjjpvKLhmSMs9KWcvRREQUNWZBw4UDuNjdWftY7
	 5RKwLxI1/f62DRJc2KFRg//tdnWsd8ip7Dihro57bf8WhaE4Re4cdNuKySnDP4Cllb
	 baErUghfMyZggdOTf13cBzHOMytklcnR3Ok066BKNNvUChK90y6Ev0bPIzy4+i5gQy
	 2hyYBH6F3+5aTyKbxACGzWAHpDz/Yxccy5IWELock/0J14xw3Zn+AQkdnPkJyqD98R
	 +zYojWURTbDePkIbq+lLsUPnjBfn4zoFzlnQtRF2YvY7MGbEh40EcjMtCfTsyD0HX3
	 /Bqjt88w+Watg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9178DCF3BA3;
	Fri,  7 Jun 2024 13:32:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] liquidio: Adjust a NULL pointer handling path in
 lio_vf_rep_copy_packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171776716359.27999.7521949706547651629.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 13:32:43 +0000
References: <20240605101135.11199-1-amishin@t-argos.ru>
In-Reply-To: <20240605101135.11199-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: davem@davemloft.net, horms@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, keescook@chromium.org,
 justinstitt@google.com, felix.manlunas@cavium.com,
 satananda.burla@cavium.com, raghu.vatsavayi@cavium.com,
 vijaya.guvva@cavium.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 5 Jun 2024 13:11:35 +0300 you wrote:
> In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
> but then it is unconditionally passed to skb_add_rx_frag() which looks
> strange and could lead to null pointer dereference.
> 
> lio_vf_rep_copy_packet() call trace looks like:
> 	octeon_droq_process_packets
> 	 octeon_droq_fast_process_packets
> 	  octeon_droq_dispatch_pkt
> 	   octeon_create_recv_info
> 	    ...search in the dispatch_list...
> 	     ->disp_fn(rdisp->rinfo, ...)
> 	      lio_vf_rep_pkt_recv(struct octeon_recv_info *recv_info, ...)
> In this path there is no code which sets pg_info->page to NULL.
> So this check looks unneeded and doesn't solve potential problem.
> But I guess the author had reason to add a check and I have no such card
> and can't do real test.
> In addition, the code in the function liquidio_push_packet() in
> liquidio/lio_core.c does exactly the same.
> 
> [...]

Here is the summary with links:
  - [net,v3] liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
    https://git.kernel.org/netdev/net/c/c44711b78608

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



