Return-Path: <netdev+bounces-215080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F3B2D0DE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65B47A601C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BA019F40B;
	Wed, 20 Aug 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX4025v1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A619539F
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651607; cv=none; b=VxoJ24Fa5q02qTlj2W/fDe+yo8paeRe0cV68dHrK/pRof0t3Ub5BTwi8Mg6x+YIfEBmHOi+BSUqgIceJCiraGRpgJTL6X9rbTZqsF5ynNbChJdjLDiVOdSrdnWUWlk/yo0qV/62TN6CsaDawF+nLls1+s8fOxfojtw1LGPG/mT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651607; c=relaxed/simple;
	bh=nptlQY32NCSIccxs32DfxP1iyB+g/4iBCr8esVANs2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0ubqK7RpF7Dpcxfg8ETTveyRsp7aR078w9fDnCHXjMc0dtQ93jfQ8pZYrtOpVGieegjQ4geQKyHbnptxA2k6RU0zCxCxsKO7DQZlIJ7uBqlt6w94vby8ngas5lU0jKytYkXbDlLLQM6DVKzYsxUHqnEYHlEvgjF7t1TAFykm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX4025v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D30C4CEF1;
	Wed, 20 Aug 2025 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651606;
	bh=nptlQY32NCSIccxs32DfxP1iyB+g/4iBCr8esVANs2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pX4025v1iqihby8I0CFC2Ctj3iAH4EChE/imVfsMK9TqZxQEi2Pnn4GPs+fNJqD8U
	 wYn2pytCYcKWpE1W060XJ4R/Ntswa7JHhodrN08XMb+Ho3GXOajTYYAFEsRS7Kccbo
	 ZOHERm0xjvmxsdOF8WrIisf+h0sKSg8qMRINma8UsKT5XYMYyqAtqlkL1SHOA19Tzq
	 GKyDnFTx2rGq7NazluWCSUFdNyefEfoIXGtCIZdKZxoaO17PE1OJycYCvhIZuo9f/O
	 jc9Y1XDWKmKuRlTQ1+1NSA+L9CgrdetGdFGaIpe665h2jE8rp0nGentOTxs/t+Tylg
	 lTh1/As/8R9YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD0383BF58;
	Wed, 20 Aug 2025 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: Speedup some nexthop handling when
 having A LOT of nexthops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565161623.3748899.17139444532353047943.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 01:00:16 +0000
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
In-Reply-To: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: dsahern@kernel.org, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@idosch.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Aug 2025 16:12:47 -0700 you wrote:
> Configuring a very large number of nexthops is fairly possible within a
> reasonable time-frame. But, certain netlink commands can become
> extremely slow.
> 
> This series addresses some of these, namely dumping and removing
> nexthops.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: Make nexthop-dumps scale linearly with the number of nexthops
    https://git.kernel.org/netdev/net-next/c/5236f57e7c03
  - [net-next,v2,2/2] net: When removing nexthops, don't call synchronize_net if it is not necessary
    https://git.kernel.org/netdev/net-next/c/b0ac6d3b56a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



