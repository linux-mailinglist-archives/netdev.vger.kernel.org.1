Return-Path: <netdev+bounces-219354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D4B4109D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646DC3B75FA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825281547C9;
	Tue,  2 Sep 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt+r4611"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C232F743
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854606; cv=none; b=Y4Z2QZdh/lyrKEr00ayrialsxbn1DqL7qAV2zL+hKNwJn5MObkTTsv2V1osF8eixwrDezLlG/UA/fcFWxmB2a06Bms4ZQEjn78M77vFdyTxdd1cgQtnonLm6yWrIZhgvZfHGPgDr7eAVtMoJHxXgdNQtkMJvTH4Fg+KCTb79MIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854606; c=relaxed/simple;
	bh=pkNDw9d3nn0qkldOJINbDzKAWr5JncPnXMYSrKyzV6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sM8A5S+59Apg8cFuCRZEdAQez3WmItcQdqEkFUUtICvd85E4GK5NjSgJwEE5dRAtFyVVaUtKsgU36p9gsTwfFhDMHEE9+4GtJ2U40mwLxvn/1n2WwUdAh1Y7H02vyjiBxYZKVKnIMsc3mOzSpaDv2fIRxCnfuR/0LxtLFIWaHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt+r4611; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD5C4CEED;
	Tue,  2 Sep 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854605;
	bh=pkNDw9d3nn0qkldOJINbDzKAWr5JncPnXMYSrKyzV6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kt+r4611FB5QzohQO6F0bXpy5FlTgCX5cAJrT1SunCpJ/QFlR9EgvKRlk9iVlfR6P
	 DAly21ROmzqh+qgK19IRmzcCR74hqvNAcbpO956EqquO/SKm+jq5jWLuktMJzDUKUy
	 NMRr+NbY2z5sI5v5a3heSg/IaWWyKNgzPZAX8T+uIgJfJpoz1vWWwDZ1KSznB9ly5m
	 JrN5PhAAzuU8vcdFJOXya0ERjwGyRNCX4sVUPpwxv1djZdTm8YohePXYuURe+dBy79
	 SQgnLyhmQTGDiwrkECJMph8sLSUfD7S5rnBQKRT5E5HzoVtab8WWfAyLYNo7KSlVRC
	 2CEMOnWJntW+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D43383BF64;
	Tue,  2 Sep 2025 23:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp: Fix socket memory leak in TCP-AO failure
 handling for IPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685461125.464015.5426802978312843780.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:10:11 +0000
References: <20250830-tcpao_leak-v1-1-e5878c2c3173@openai.com>
In-Reply-To: <20250830-tcpao_leak-v1-1-e5878c2c3173@openai.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, 0x7f454c46@gmail.com, noureddine@arista.com,
 fruggeri@arista.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Aug 2025 15:55:38 -0700 you wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When tcp_ao_copy_all_matching() fails in tcp_v6_syn_recv_sock() it just
> exits the function. This ends up causing a memory-leak:
> 
> unreferenced object 0xffff0000281a8200 (size 2496):
>   comm "softirq", pid 0, jiffies 4295174684
>   hex dump (first 32 bytes):
>     7f 00 00 06 7f 00 00 06 00 00 00 00 cb a8 88 13  ................
>     0a 00 03 61 00 00 00 00 00 00 00 00 00 00 00 00  ...a............
>   backtrace (crc 5ebdbe15):
>     kmemleak_alloc+0x44/0xe0
>     kmem_cache_alloc_noprof+0x248/0x470
>     sk_prot_alloc+0x48/0x120
>     sk_clone_lock+0x38/0x3b0
>     inet_csk_clone_lock+0x34/0x150
>     tcp_create_openreq_child+0x3c/0x4a8
>     tcp_v6_syn_recv_sock+0x1c0/0x620
>     tcp_check_req+0x588/0x790
>     tcp_v6_rcv+0x5d0/0xc18
>     ip6_protocol_deliver_rcu+0x2d8/0x4c0
>     ip6_input_finish+0x74/0x148
>     ip6_input+0x50/0x118
>     ip6_sublist_rcv+0x2fc/0x3b0
>     ipv6_list_rcv+0x114/0x170
>     __netif_receive_skb_list_core+0x16c/0x200
>     netif_receive_skb_list_internal+0x1f0/0x2d0
> 
> [...]

Here is the summary with links:
  - [net] net/tcp: Fix socket memory leak in TCP-AO failure handling for IPv6
    https://git.kernel.org/netdev/net/c/fa390321aba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



