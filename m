Return-Path: <netdev+bounces-63887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19D82FEAD
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C9288521
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14C15CC;
	Wed, 17 Jan 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkcnRIsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE925747C
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456825; cv=none; b=Lie6uFa0HBH1phyjKxoqwNfNhyoHelJ9PRqGDWM4skU7lzs+sQFWvyNRMZ5L7C2VeE2MDC4cVTa+3xRymoySP/5gErfer7fgACVeSuVvOfJK2xey80MinB8jHjY5h0Kz9U9x2VYP3hacczRLYzLLMJYzPu63BM27jCtkcH8PM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456825; c=relaxed/simple;
	bh=HIdRrLP74JZvcIeOaAxygVNSZ+dmftr4hpVZB/6D3Co=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4Xk/5myXzUac78MJ5ww9BNS+kfHIp/Dnf5zG7kFx9vsUkK5JerQRq9QRXyctU7R0WuLD0q55yxVl2D9Ov1kRcfuIhEeiRzRxeXUI4/ivVvUlTx5ey6CQ9C/N27lfgAIkZW+7lrJeo4LzTRNG/L2aBA1ndUXzHWn+Z+QNgQFRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkcnRIsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C0D3C43390;
	Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705456824;
	bh=HIdRrLP74JZvcIeOaAxygVNSZ+dmftr4hpVZB/6D3Co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkcnRIsqyKSLeAhkWdcwuRRwGpEUpTQvIXxQBSq6ZpSNstbQmN/ArQheqP/k5U9Ut
	 Ou+Z4QDaaFMjBHiXJ2aroDsac+2rtvNlc+JxnLRHG9M3Jk/wHMVrXPrbmQEa/1XrsX
	 otlQOQF1Qz1nxamGcRlr+PYOTrpdt9Th72ZYHNIkDHoSn0N3dAk4TcH84UjMz9/bHp
	 4bJ3VkMtVryIykq+6z1jscr91ol4BHc0fzARVaMjYqNRZnxegtKGZDDbCjfVxUTbq4
	 6gdxGInn4CYqtUsP/fmAXhWxkRBhK/ZNdlUyg81KvvssiYIKVwt2YS8U1XhAvtwUmp
	 OIgEElg0Ip01w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 612C2D8C972;
	Wed, 17 Jan 2024 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170545682439.28743.9531225057229224989.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 02:00:24 +0000
References: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jan 2024 12:43:38 +0000 you wrote:
> The referenced commit moved the setting of the Autoneg and pause bits
> early in sfp_parse_support(). However, we check whether the modes are
> empty before using the bitrate to set some modes. Setting these bits
> so early causes that test to always be false, preventing this working,
> and thus some modules that used to work no longer do.
> 
> Move them just before the call to the quirk.
> 
> [...]

Here is the summary with links:
  - [net] net: sfp-bus: fix SFP mode detect from bitrate
    https://git.kernel.org/netdev/net/c/97eb5d51b4a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



