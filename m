Return-Path: <netdev+bounces-135829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E999F4E0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F128471C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42920822B;
	Tue, 15 Oct 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsNmSnfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0961FC7DB;
	Tue, 15 Oct 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015826; cv=none; b=WvV3FbHU/4+lXaVe+562Lq7OoWCWC3L5Nsg0xbHS+vLHSnSbrTtWztDCUEdz6h2Yoqgq9rTUwmovL9U4hURMQeUsO/xLvY4HbJZlq6SYuLcB/w2l5oLyZvIzOY4HhjdZ4Nwh3BIqviDRza5jk1bPdIHpnhloTjBxwVon1n5s0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015826; c=relaxed/simple;
	bh=yzfmLFfW7KRae6EsSLqq5M5XQcSSL4FeQhWYFB1EXr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gTr3pCl8Yb/EX8+9VctpiyZ6u+TDe47y8reFZF0JXuESa4PEQKQPbSwaVk99G5YnJLhiZ8ZoIugNhs9v29A/1XFj1RDrx08lbr5EsnEV88LyipLhpWoAKVY4IzsLGhnVJsz3KXl0AAkBTj0rptUZCIHtzRVRM1Ze9JXzTtO+1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsNmSnfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADEAC4CED2;
	Tue, 15 Oct 2024 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015825;
	bh=yzfmLFfW7KRae6EsSLqq5M5XQcSSL4FeQhWYFB1EXr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DsNmSnfOeD42upxuYWaCx5RVUrFb4b/pbtWCbwM1gNUOEwj+Zo8oe4XELbPYYYs8N
	 HdACqxE4m/wPhcwpu+8TB6+0/L+NiyDQhPbOC0gB1RCgaqAg5z5qMr4e+CCPBjmGjm
	 upWhqr9JaT/XWE/VXFL14ZcoTeOoDd2vWOjbyrbDuKOvaNhfgji50935EtmSk6qndJ
	 liPYYmW/wR0inv3+oeryfOkksEdqjW2GK537nvyEVWTs0TU9jO8thAaLSnNpbMB7bM
	 jXVIYbSbDJPCXCV8dtbTwAOR1CDhVoBW2mEUHgEoFZqG7b1bIuUQV6Krpzkyv69pKF
	 sthTsh9IuWlhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD03809A8A;
	Tue, 15 Oct 2024 18:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: xilinx: axienet: fix potential memory leak in
 axienet_start_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901583074.1246543.12469731603853856024.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:10:30 +0000
References: <20241014143704.31938-1-wanghai38@huawei.com>
In-Reply-To: <20241014143704.31938-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 andre.przywara@arm.com, zhangxiaoxu5@huawei.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 22:37:04 +0800 you wrote:
> The axienet_start_xmit() returns NETDEV_TX_OK without freeing skb
> in case of dma_map_single() fails, add dev_kfree_skb_any() to fix it.
> 
> Fixes: 71791dc8bdea ("net: axienet: Check for DMA mapping errors")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
    https://git.kernel.org/netdev/net/c/99714e37e833

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



