Return-Path: <netdev+bounces-134028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF3997AEC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F41C23A9E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F317C228;
	Thu, 10 Oct 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxCLDSTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD72AF17
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529229; cv=none; b=WoaFgNU5PooRwqb25ab0vTIjPVvgUCUipGru7WKHJJbEe5uhoGHL4S5nbZYfEoaz07ErfzXe2tyhzvnGDEStpSX/8KtHifg0PcVNY/BIwBE28mPg6SxyTtxrKPaz2mlOyDP7uxF5QQZFKaZnT/fLiVaa249FlPJiBRd7bikQWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529229; c=relaxed/simple;
	bh=pGtR4N7/aGM4xCCzoOAYqta/M+LdqNIREVhbJn2uumY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fL7gIjoqLae69R01MF3z2yhJKveSAWIlT1kV9Q5sbbcySL+VyhLZnuvdMyS2YsR0kDdCrLt2WOFvZeRORzZpMwmu7KlvSIuA/f0DVnlce0NFzked/a72Dbgrb3jw0uvQfCnA0M62Z2osjZtHKBPDxieZQfC4+0xSPhZY/KMGSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxCLDSTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E759CC4CEC3;
	Thu, 10 Oct 2024 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529229;
	bh=pGtR4N7/aGM4xCCzoOAYqta/M+LdqNIREVhbJn2uumY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZxCLDSTXaWrSgEkqdREqJpCkO1ZKs+e8mREXHRHMsdlHw2U4rStgPkPOKnQ3Esx1F
	 Kg1L7oexoO9z2s952AJdD+FBjfXwXsw7o4qzb920sEwQsXXC4H+BC7UIFPYsk78IKZ
	 E0eLtG0JvNRKZUZpsakzcjUqBb4HIGyde+eV97TrsB3/Bv7HOj8JLuuHqpv+e06ij3
	 hxvi//0JhES+VZEDrmih6Be9L2Yiz2Ds4bfkbw3kMFZnTW7VyVDLJ8KSIGIyO04Jxg
	 hH+L5M7/2Wj78a4LrKOufnjukKW8CQLZcJV95RXGiUcv23Gq6tAtbKaSc8Bjza0UH9
	 fL5s0EhH3e+Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3D3806644;
	Thu, 10 Oct 2024 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_sfq: handle bigger packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852923326.1548394.4400303859073478456.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:00:33 +0000
References: <20241008111603.653140-1-edumazet@google.com>
In-Reply-To: <20241008111603.653140-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 11:16:03 +0000 you wrote:
> SFQ has an assumption on dealing with packets smaller than 64KB.
> 
> Even before BIG TCP, TCA_STAB can provide arbitrary big values
> in qdisc_pkt_len(skb)
> 
> It is time to switch (struct sfq_slot)->allot to a 32bit field.
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_sfq: handle bigger packets
    https://git.kernel.org/netdev/net-next/c/e4650d7ae425

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



