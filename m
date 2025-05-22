Return-Path: <netdev+bounces-192622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0818AC08B1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9921BA81E3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6F286D40;
	Thu, 22 May 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVmJayAG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DA24E4C6
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906201; cv=none; b=JUdpbIPPtb6blc52hBd9MmgoWz2ycr49HBszhYZjsSrw0VKisKdflwAb2lQRF9y54wHGXvnHF7hC02bjJ4TRk1r/Mrrj1r90WZpufI+itBYVElelAQtm2xcw4YSi/JWanupuVXXuLSML5DExUPHWzi4UUBo6Zv1/N71ND33CNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906201; c=relaxed/simple;
	bh=FeOnFPaIbBX9sOzEZROLJNqX8RCEfxSpxw+eoijlfac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw8IWqHZjxaO2IdicEkKkxJv2xO4QYPv0RQsjrw6mJxs3wwS+HuOL6GtK20ty5pQAnbLxH+F4HqQhWym/o367KwVXbipnBo8tP/RKRxr31sXTcplgbNhFFONOwjE6F3bt2gJWngoy5y+0WZGafaTe2+yqoY0uHMMQEN/IC0M4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVmJayAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB87AC4CEE4;
	Thu, 22 May 2025 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906201;
	bh=FeOnFPaIbBX9sOzEZROLJNqX8RCEfxSpxw+eoijlfac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BVmJayAG7fNpiJauMYGKXzpgv/IuYliimo6wbiMyn1smGTc+evqhTnRoc4qyDZ/29
	 Lc4xy9Zp6C/0FqjOhU2XOoIfEWu+5uyrLKAvzXdsS6SyA7ikOL6U/oya/ql15roCql
	 3Xu8gbqsiEdATMFR9/OfDSbyjoG+xjI7fF0D0geV1HsgDYUpFgGY5ubI7JqMTmcqNc
	 0bL17b19+2orAwkOq5gNciE3QMqcwRGnQfPlw1qRDbSON2aR98bxExwZ8N8JWteZwL
	 bOFGFzrV/eznibzhvthpoMQcZ7ydAfhIgE4JPM4xNPXd0bX/tTqpNayQUB+1NJTb/f
	 6VSqR9/9dza6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6E380AA7C;
	Thu, 22 May 2025 09:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net 0/2] net_sched: Fix HFSC qlen/backlog accounting bug and
 add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174790623648.2464246.11027722128186057723.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 09:30:36 +0000
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 18 May 2025 15:20:36 -0700 you wrote:
> This series addresses a long-standing bug in the HFSC qdisc where queue length
> and backlog accounting could become inconsistent if a packet is dropped during
> a peek-induced dequeue operation, and adds a corresponding selftest to tc-testing.
> 
> ---
> Cong Wang (2):
>   sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>   selftests/tc-testing: Add an HFSC qlen accounting test
> 
> [...]

Here is the summary with links:
  - [net,1/2] sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
    https://git.kernel.org/netdev/net/c/3f981138109f
  - [net,2/2] selftests/tc-testing: Add an HFSC qlen accounting test
    https://git.kernel.org/netdev/net/c/c3572acffb75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



