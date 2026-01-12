Return-Path: <netdev+bounces-249182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B8D155B9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93631308B377
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57177340A43;
	Mon, 12 Jan 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luNDscka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCD33985B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251626; cv=none; b=Pwdbf8Gdjb6+DS2khM9skpw/5HoeOHQSCphyjgsvc5myKANq/5RkUXySzCralJdWlVt2FlnxRFVoZ7SyYMALhGgSxuwuDApgCRxUKUewpQ0IKuY3mK6bHIL9wOkmV4fiQd5BOdVbaeBnl9Dyb62XiJMC4BebYr8PEkd/w8DZLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251626; c=relaxed/simple;
	bh=zsq0FcI+5iaP8g/qGWw34D9bFPRbssKzPV6XPrHRLHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YytwWkyjkEZWbqP0JiZQy/8KBGsVCIShiQ1tZVY1ZEvofK/n6xVnbX+rN5PXSiQBA8nK1za+Kwuinn75kLgu05cxeisffzTaDPNzpVyMkjCJYiWae4/bX+jmpd3RyEfD5+5lNC/JcgzQ9dQEf+xqHZ2I++7NnWHtQBJIqx2EcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luNDscka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3021C116D0;
	Mon, 12 Jan 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251625;
	bh=zsq0FcI+5iaP8g/qGWw34D9bFPRbssKzPV6XPrHRLHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=luNDsckaTHAkYBKbkPFP7AzlYr2rJd5bPo0wSwOS+QqcJPbcMGAjsZI2+ArLFPC/E
	 RK2Y74wUGHGZciCurq5RyZZIU0knjRP9j5u//EZ47v/R1dDY5xhNcI5KgBAc1wwZQ2
	 q6g0lnR5I9B5lvIUIWPYwVbHL0NdKZ7TV1cTYCz7V3phQlGc98ERzHu6dyAtW33GsN
	 /4x5E5BL7SafHFixCmvJCEau5hLO/YVG12w6e7ZoWoWPFLIlAjimIx+fIkXJSpy7W6
	 lkmT3Heyxk86cviTv+bfval6RfPb7rOlCly69raO8TmbXvaurq4J4WC0bsb9RYxq2v
	 O2+sKt83NbdpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F32C7380CFD5;
	Mon, 12 Jan 2026 20:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: ip_gre: make ipgre_header() robust
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825141952.1092878.6752634861801285923.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:56:59 +0000
References: <20260108190214.1667040-1-edumazet@google.com>
In-Reply-To: <20260108190214.1667040-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 19:02:14 +0000 you wrote:
> Analog to commit db5b4e39c4e6 ("ip6_gre: make ip6gre_header() robust")
> 
> Over the years, syzbot found many ways to crash the kernel
> in ipgre_header() [1].
> 
> This involves team or bonding drivers ability to dynamically
> change their dev->needed_headroom and/or dev->hard_header_len
> 
> [...]

Here is the summary with links:
  - [net] ipv4: ip_gre: make ipgre_header() robust
    https://git.kernel.org/netdev/net/c/e67c577d8989

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



