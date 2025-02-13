Return-Path: <netdev+bounces-166123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0175A34AC9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4497A19C1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734B524290A;
	Thu, 13 Feb 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of7CjW3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8E241691
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465403; cv=none; b=UCGNuTo4D4NEffmTzLeh5h21jIELGFmji++bKZ1iH1OwegJs8UzpWGsIGiozyY5j2biQBaRFkA/IwzkiwPzKjX4tR5DLBbvpIb9GYh915+E4eUliAUhhUvGcPfEKQaQIjiMEgr/TQK2bN2be3BY0UpVLU48qcGvgzFHEVzGNdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465403; c=relaxed/simple;
	bh=Eu188JSDuYFG3Gb9frOY8rek+eWlDvpXrZYOPIteRwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oWKOuaVvxSHmD/9eHDRYgfb9xyg1YVv0LVNMyA0U0Y9n3tSPgxmzEQhh+kjxwhQKH6UtoSYlzh5CHHWlHOO6Gq2hcEr9d93qkXLIXwNSjrGTzqbIlqtgzz+bxBLChAHz28sc/JBr85gVUBlTav0VdtWfCNiSRgO38Xq3STbOdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of7CjW3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB795C4CED1;
	Thu, 13 Feb 2025 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465402;
	bh=Eu188JSDuYFG3Gb9frOY8rek+eWlDvpXrZYOPIteRwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Of7CjW3Qri9J9cRGuqaE/AyrV1SqXeaJBVSF035XatqdaQZ3HaE78UbByygB2+242
	 +frm8+0PiCaVpAbebuyBPmVMvRJTKz/gK10n25W97w8hrwFR3XcKpd/A5Eh4HdBsGO
	 saN9atRKmgjZIdFCBHpnelWpL3ZZrSZP6r1JqAGYwd2mBOYr2qYD9xHPNfqSa6Cokv
	 wcGi4NkU9n8hAwEkqhd8auuLM1qpkqkh0DenxPUTagom6BcrgzrZedBUL01GoVQ6Aw
	 SuCF9HoJsWqVmf+M6MmjppdMnucyvOfBqMO8LWL1ySBpsr4XvtcW2020Ug657dXiWI
	 vZSsHAOoKwwpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342BE380CEEF;
	Thu, 13 Feb 2025 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: mcast: add RCU protection to mld_newpack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946543174.1295234.14096603831223863900.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 16:50:31 +0000
References: <20250212141021.1663666-1-edumazet@google.com>
In-Reply-To: <20250212141021.1663666-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, horms@kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 14:10:21 +0000 you wrote:
> mld_newpack() can be called without RTNL or RCU being held.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: mcast: add RCU protection to mld_newpack()
    https://git.kernel.org/netdev/net/c/a527750d877f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



