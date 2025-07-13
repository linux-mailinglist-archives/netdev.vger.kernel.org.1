Return-Path: <netdev+bounces-206469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E2B03371
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31668175E8A
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFC156661;
	Sun, 13 Jul 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3Sw5K1x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DD2033A
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449386; cv=none; b=hRaxJR621ieYJoC4grRiEO5x2FE38bWK/yqzA4DlbYexYnTRrrlo/zlqwzGSQpaVV4b2icqzWruPELKpUxs10NxeE1JISNOzJAEye+rEf5aeWoidnTr9X+nk37hLZhZ3M0ZE3TraKuxjVUXkapqvIDdMD0jUlA3KT8s5OyOdeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449386; c=relaxed/simple;
	bh=oepiEya9lHsiLteS4a9XNytQkyKmOyLnbyB6hFOvVqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=glUl4+ncXn7n1DIXR4V/pBAK8AQls167vrU2VkdMwlwuPOliCQC10ieAnvSW6kimjpj+AjEtRps9h+1BxuSS25eUqn/k25xVGiyZYect2ttGygnhrh92sZakpeUZtP/K37GQyEkSA8NDvy5xJK28hPL7R7An4DvdztG+qpOYz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3Sw5K1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E3EC4CEE3;
	Sun, 13 Jul 2025 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752449385;
	bh=oepiEya9lHsiLteS4a9XNytQkyKmOyLnbyB6hFOvVqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P3Sw5K1xSrRvAfEL+7hgrP6u8X7AWdEOAYVunn5A5QkEV2ltV5PxUhnGKoSveZbS9
	 Cfq+Mj8U1CBREfjpRCXWtjVZD+08esG7fizfN1LHsRL2api9Y61lAQK1T0BNWK/Bn6
	 aDmGxcuYAYE5h1ymYWDKMW7MFMXI1AmxIgsamn0RMHOdrDFQWWIcde3wCKeJFVCTHL
	 T3kF1+4XPUButzNU/bNSZ3Zw2m13V+Aae9vVU6/LjdB32IDmgjJ/ORC39KQoFCpey0
	 sAlBn46LEQei/TbM5jpRTBmqXASAozMglAaJ41MtvNwYpyFkAk9XgTaOvFvMy/J3Gq
	 2kHdb+nwqMTNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA5383B276;
	Sun, 13 Jul 2025 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] rpl: Fix use-after-free in rpl_do_srh_inline().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175244940656.3230585.3558253584085351946.git-patchwork-notify@kernel.org>
Date: Sun, 13 Jul 2025 23:30:06 +0000
References: <20250711182139.3580864-1-kuniyu@google.com>
In-Reply-To: <20250711182139.3580864-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Jul 2025 18:21:19 +0000 you wrote:
> Running lwt_dst_cache_ref_loop.sh in selftest with KASAN triggers
> the splat below [0].
> 
> rpl_do_srh_inline() fetches ipv6_hdr(skb) and accesses it after
> skb_cow_head(), which is illegal as the header could be freed then.
> 
> Let's fix it by making oldhdr to a local struct instead of a pointer.
> 
> [...]

Here is the summary with links:
  - [v1,net] rpl: Fix use-after-free in rpl_do_srh_inline().
    https://git.kernel.org/netdev/net/c/b640daa2822a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



