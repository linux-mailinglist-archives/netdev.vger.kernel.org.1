Return-Path: <netdev+bounces-211111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4FB169E4
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CD73B87FC
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4264E156228;
	Thu, 31 Jul 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2jq+Pmk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E65579E;
	Thu, 31 Jul 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924204; cv=none; b=NefDY7kjdwvFd21fI/umNL/8htG0/JNfvJZ79f1gUuvkI68CEUoTosCR/8/M2WWiOUwVJF2K3tNfXuCjXjAzmTOO1/2Z36S8H+gxlaIxqLuL7RtsfEFauzWelKOz2k/AuW8KlRkW1OHTWoXOt5oyf/zhyp4ssfqbwBkTRiMaUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924204; c=relaxed/simple;
	bh=ee+At6EtvGcpCpHALYPC/vwBjyqphz/XXMzRRpJlmzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jni0/udraVKcwbaIh28tpSyeLTHC8avqLPSMfukGKoh8r2w5cXx0BjS1K2UP01k8wjGPfg8WIdLNtePX8WVSAyHydmsFJbY6E1I7XarSstw4tAetP4rZ+0P3Y8vKC3lz1mi5vsPvYC5gawqr4XINFrPnHJuF+aoTuqm12la89G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2jq+Pmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98199C4CEEB;
	Thu, 31 Jul 2025 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924203;
	bh=ee+At6EtvGcpCpHALYPC/vwBjyqphz/XXMzRRpJlmzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L2jq+PmkglpgoQLcSQAdnOmacU+b+rJp2BlVTHNBwIblXk+0oq0cyMgI4NkltaAmV
	 9BTrc/rXmNX8rPf8P2Z1bJJs0cLZuyCzCVKBt7Fsn67IsvGkeeWrkbhiQWrj4zmTRu
	 mHSQJYtneTEuohKiJ2aKpCsubMyY89bCyJjXkQDYc6F6VDduEMzzU8JBtLHBdB9cqu
	 e10D1DzhI4Vvd1pn1sZNCNhSP/2gsZkgKmhfb+0PLuse122jQra2cgKoHzEBfbJIIk
	 UJKUGa4a64tyHEXU+1Kvok9sBRxJksvF0Jt1xr/PmlmBcb9/7AhocF6fY2CdxreGtt
	 Ao80exKotVegQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB0383BF5F;
	Thu, 31 Jul 2025 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kcm: Fix splice support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392421918.2566045.61660066535623324.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 01:10:19 +0000
References: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
In-Reply-To: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cong.wang@bytedance.com,
 tom@herbertland.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 12:33:04 +0200 you wrote:
> Flags passed in for splice() syscall should not end up in
> skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
> confused: skb isn't unlinked from a receive queue, while strp_msg::offset
> and strp_msg::full_len are updated.
> 
> Unbreak the logic a bit more by mapping both O_NONBLOCK and
> SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
> regard to errno EAGAIN:
> 
> [...]

Here is the summary with links:
  - [net] kcm: Fix splice support
    https://git.kernel.org/netdev/net/c/9063de636cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



