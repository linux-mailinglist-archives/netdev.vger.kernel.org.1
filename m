Return-Path: <netdev+bounces-194597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDCACAD8A
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CD17F818
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076D1FCFE2;
	Mon,  2 Jun 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmaHqTbO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788B4317D;
	Mon,  2 Jun 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864996; cv=none; b=WyAjLkQeg8jJQnsDmZRQG1vFksvSFWR7Ky5Vt/m+SjHhv+XW+VwHMRofF5xb1HgElEg7nGHmO4qnTzpqXmVP4nS3lb7IpNdW92/cfZoQRYqf3QrwIGp4RCK9UH6FF9pM0kC8/2mWI5/Y0JeHz/mtY3CpA0xNKwaAV7qlO/w7Plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864996; c=relaxed/simple;
	bh=u9MolWNIMkp6pcJK1Gdrv/+CfeWAmrNVP3kj7C4+Zvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tc3yzHZ0beU8HdscRTlOaJlC82nt+yswQS2imjXG+NQhkMLPuM0PoLkofvpW9Xp0Oi4jlsShe4voW2X0TmEosrnHhrC8WjGAls8rXKbI8UTdS6ghJzUMfrPcDrDfXYTNwG3qCyGCnGm5a0M9dymd9XVMAp6MR86Nzq0I7YdfJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmaHqTbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0DDC4CEEB;
	Mon,  2 Jun 2025 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748864995;
	bh=u9MolWNIMkp6pcJK1Gdrv/+CfeWAmrNVP3kj7C4+Zvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmaHqTbOJ0DsOULfOlmSTOXAi+NpeThdX9zQ4G6R0AnGKTT9ho7WX3amZsah+R9JE
	 DM8qzYnxELvXJ+u6QWP2OZjnI+jpQO/awniuHiDaM9AVjyya0lgEBA36yFsXYeGmOX
	 1J6k/ZMxQnH15cGUAUcLkCYnn/R9APC592EEQcdmepy4rGL1heKuVXYy/GCaB6EfPI
	 CFVsPXUzO80kxocb8gxoxg7kRm9/CXcCuMYAfaiIs+LGX0nZgu1AnOBCQ3tSIiUZrM
	 7lZ44dktwP23zzeotzAd8LJiJ2yWrq+gWITJynsZWCuEw8EwuwN7gdZhyGw2xHweBP
	 FEXHWcJKJvNww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFF39F1DF6;
	Mon,  2 Jun 2025 11:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: fix udp gso skb_segment after pull from
 frag_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174886502850.718797.10187815735875897410.git-patchwork-notify@kernel.org>
Date: Mon, 02 Jun 2025 11:50:28 +0000
References: <20250530012622.7888-1-shiming.cheng@mediatek.com>
In-Reply-To: <20250530012622.7888-1-shiming.cheng@mediatek.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: willemdebruijn.kernel@gmail.com, willemb@google.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 lena.wang@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 May 2025 09:26:08 +0800 you wrote:
> Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
> pull from frag_list") detected invalid geometry in frag_list skbs and
> redirects them from skb_segment_list to more robust skb_segment. But some
> packets with modified geometry can also hit bugs in that code. We don't
> know how many such cases exist. Addressing each one by one also requires
> touching the complex skb_segment code, which risks introducing bugs for
> other types of skbs. Instead, linearize all these packets that fail the
> basic invariants on gso fraglist skbs. That is more robust.
> 
> [...]

Here is the summary with links:
  - [net,v6] net: fix udp gso skb_segment after pull from frag_list
    https://git.kernel.org/netdev/net/c/3382a1ed7f77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



