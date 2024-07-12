Return-Path: <netdev+bounces-111063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625F92FA65
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D5D282050
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816D16F271;
	Fri, 12 Jul 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZqUeXI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44498282E1
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788032; cv=none; b=GKJhH/6iVFjLefdXGPJA56LB2enmC8CNk5bNoN0ST9N9gyiqkpmG+HA1h4ZygpaMmT0xDwnPC6jPaosroSxJXK5ndwlDXkv2Tqgd901CKv5O7XFxgDWeKG46QfXMxuqI9ZlQSmzl7jflFmVdHBUMMQvJFg3lBQHEXvLOhhyvMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788032; c=relaxed/simple;
	bh=FmRVSlg6UzFUtfcs+uwT3V5g21ee04rcyq4pvEKr2AU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=myxRDM8VLKE4jOvrKFsPXbgzsj70jDQq1SWvJRDB56urwkR6hFMcfririYYqBw8aQKUedSLPCpdZHaK9RtmcR9FGnBv4NsY5TI2SWFefz/8R2h0P7ek7wp3zfKrQHZvrjTGdjUxW499vAkjPsjmuRQXxJ1cRvPIbxWby01cm180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZqUeXI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E1BDC4AF0D;
	Fri, 12 Jul 2024 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720788032;
	bh=FmRVSlg6UzFUtfcs+uwT3V5g21ee04rcyq4pvEKr2AU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZqUeXI0BzK6H9KMNxInhHB0wtuh1QxkbfKxUyVz5LG6n0ByVCct3a4BmP5YU7Yma
	 SG00Ybh/ii03SMhl1ADxIqnCfVfj/NqDbH5YRclEzZLOwwxRxhDi4prhglHUQuPgoQ
	 R//N9pQ1W35eBAGL5S4vNECAXVLeWKJdcj5ycTR80075dwt2xIQKCFXl0k/CBpl3Gz
	 +48rjolZFYucfiDCb5t4kqDu4V3U0jhviBiO3H+wJBzfvxnBM8T9zcoaxnLD9eRXuR
	 N9iDeRJiMsH1qeysJw0IWRR4n/IDRQsTbFwrWWtvtPrH7yfTy3dmQZB0/kGqDvaQ2u
	 e6FKHoKGsSL9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00064DAE95C;
	Fri, 12 Jul 2024 12:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp-i2c: invalidate flows immediately on TX
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172078803199.14799.923781720410892219.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 12:40:31 +0000
References: <20240710-mctp-next-v1-1-aefc275966c3@codeconstruct.com.au>
In-Reply-To: <20240710-mctp-next-v1-1-aefc275966c3@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Bonnie_Lo@wiwynn.com, Jerry_C_Chen@wiwynn.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 10 Jul 2024 10:17:22 +0800 you wrote:
> If we encounter an error on i2c packet transmit, we won't have a valid
> flow anymore; since we didn't transmit a valid packet sequence, we'll
> have to wait for the key to timeout instead of dropping it on the reply.
> 
> This causes the i2c lock to be held for longer than necessary.
> 
> Instead, invalidate the flow on TX error, and release the i2c lock
> immediately.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp-i2c: invalidate flows immediately on TX errors
    https://git.kernel.org/netdev/net-next/c/338a93cf4a18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



