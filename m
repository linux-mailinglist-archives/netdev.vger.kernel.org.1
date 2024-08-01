Return-Path: <netdev+bounces-114890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52C94491B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D4B26EAF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CD183CA9;
	Thu,  1 Aug 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk91k9eL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8B16D33D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507033; cv=none; b=LrnnROMn+9khElFY6YLaz28zkjyKebS8ncOpcWm47gkJk0P2E2Nm1cvDgYsD5FpHJZ8R42yjj+xv83i7vffBBiLe2op7Y7e5ahK5W2h4U1jHxydzqaA1rUw7DWyADy04tuOudgvKpIHs5j3CFPvC6ty0jRUxc9UUgcxuoURhRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507033; c=relaxed/simple;
	bh=1McIGP/+e5bL+o1LsHui08pyH/6H0zGABdTnBey5QIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d4FkqQIfwBaPFMQrdPlh5TMOXVt5dgIpHhTx8udlj9qR4JKNwqEQg9mQlYDdP/47RxQVsqPKtP7uTgviO+4KOHcUMOBcEWF1wldRhbFq7PN3Og5PXhSgsrAdhK6D6Aqm5qUYAdOognvUEX0GP6t34oW6kTombdtdZSAuxlB6z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk91k9eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCA13C4AF11;
	Thu,  1 Aug 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722507032;
	bh=1McIGP/+e5bL+o1LsHui08pyH/6H0zGABdTnBey5QIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vk91k9eLHdLeUrI3xOozgvptIrxGQHIOElUbPl/Sldhp3nSlk/vahLR0s9igOcfIP
	 OkYz2aEgAnAmcxrEFU+KyuDtZZrbdlVuQd8+KaN1beO0tB0zKWOsoSx5kZE0l4ePoI
	 LvrNEAnbaLg2geQkXWBGdA/JvtoX045k/7NTBWJe2sJF5CqOi5T6ZVkTJ35zs8pzjW
	 vqSKR++yT4NiUcMvSlZ/uSjRMQLe3rdpPZBzzC1nctj12gS9iglJFP/3ZND/shq6iw
	 te2VER/KfFP9rrAhRhdcyCpkSfz9hvSaWZBw18GLzlYh12cXuW80G5qx0KsRFqDZ8I
	 +y80nNrXwUTHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA3C2C43443;
	Thu,  1 Aug 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: fix ndisc_is_useropt() handling for PIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172250703269.567.4628237760105837009.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 10:10:32 +0000
References: <20240730001748.147636-1-maze@google.com>
In-Reply-To: <20240730001748.147636-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, furry@google.com,
 lorenzo@google.com, prohr@google.com, dsahern@kernel.org,
 yoshfuji@linux-ipv6.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jul 2024 17:17:48 -0700 you wrote:
> The current logic only works if the PIO is between two
> other ND user options.  This fixes it so that the PIO
> can also be either before or after other ND user options
> (for example the first or last option in the RA).
> 
> side note: there's actually Android tests verifying
> a portion of the old broken behaviour, so:
>   https://android-review.googlesource.com/c/kernel/tests/+/3196704
> fixes those up.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: fix ndisc_is_useropt() handling for PIO
    https://git.kernel.org/netdev/net/c/a46c68debf3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



