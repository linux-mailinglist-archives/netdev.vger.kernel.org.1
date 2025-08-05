Return-Path: <netdev+bounces-211640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B5B1ABC0
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C034189FF1A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081711C8604;
	Tue,  5 Aug 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjdBvnh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADE13B58A
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353811; cv=none; b=VXiMd+6aJdZ2z6mmH7lh9bA7BBAmrNdLIXS9WHWE17U2ML3ah3omI6YreyCyczeOhAmhudkqDbg7aOd/MQx7DQA9q10j779T2yxV1HEe+xDJ/3Qsv1+kzQ7BGMwELSKuxIYbI5isZnResRvfxvtcLyVGFRSwRvMglWX+nNtajgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353811; c=relaxed/simple;
	bh=+cP0BkhqBrOcReKbHqE04MGISKld/eYhmLB9L7ifbfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdl8v58/GlwJdowAXJuqX5AHavwJod/jMDgCqDTrqjQm7CqS00NbLwnWo/jeR9IxCyRlCDQumQY3Rtz0RdXNi/edz/Chs2YJKNf54RruJLDQgopADJaaSGw4641NVtG9BDY4YURhJ38OaDBekqo38JoLEtbe6WU3/4hMdfYB2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjdBvnh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D7FC4CEF0;
	Tue,  5 Aug 2025 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353811;
	bh=+cP0BkhqBrOcReKbHqE04MGISKld/eYhmLB9L7ifbfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EjdBvnh/YYVEvuJjVkG4EtNvM74DdfX74cHL3klj/uFRFVqEeodHNhfU7kO9swVfh
	 XSQ7TIEQO3wWLpBfzDteEim0MyFLjc+IM+FM9ozJ9zmOY7Dkt4Oko71IwD3LpsSMdH
	 JhuQNrkvGWQVkXviWXDp/3O5MAlb6nGcmYGK7Nag1MSjY/N6tSkd0wTK1nl76KmyFA
	 GJnnTn2+m8+MsiQUFa473DOt1aGgJzfed07PJmSTILpNtsbIPkABXATMSc4HS+03qx
	 vlaq+xnj8EeMBUaVCNrDzWd70AoRf/0CyI5stC4j2B04TgW6RvHtP2j65py3cgeGhp
	 kUevrjNQe/BEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD65383BF62;
	Tue,  5 Aug 2025 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/sched: mqprio: fix stack out-of-bounds write
 in tc
 entry parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382475.1400451.11317649923147201674.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:24 +0000
References: <20250802001857.2702497-1-kuba@kernel.org>
In-Reply-To: <20250802001857.2702497-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 maherazz04@gmail.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, vladimir.oltean@nxp.com, fejes@inf.elte.hu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 17:18:57 -0700 you wrote:
> From: Maher Azzouzi <maherazz04@gmail.com>
> 
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack
> write in the fp[] array, which only has room for 16 elements (0–15).
> 
> [...]

Here is the summary with links:
  - [net,v3] net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing
    https://git.kernel.org/netdev/net/c/ffd2dc4c6c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



