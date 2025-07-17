Return-Path: <netdev+bounces-207674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE1B0828C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B085C583EC0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27DA20468E;
	Thu, 17 Jul 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldqfj47U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8F1EE02F;
	Thu, 17 Jul 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716407; cv=none; b=WCGqq0+LiG/s4YZ/CsCs1XdDLsqbuEPaRF7WH8Oewo4Zlntw5GJbgJXJjA2EvraAT2P4LLlw+3Ty/bAyVEQuo/SSUGXtYrHjlDZZNxYoX+JNlloOcJDlCHTcq0OY7pTk+heD9M02t5piMI/F5x784HXCjCqSwMy7JHyggDeOIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716407; c=relaxed/simple;
	bh=wZEtqFP7aHwbWMq++OgwAQHYQAR8dahj6q0fkSQ3q2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hsOwF7NrL2uytTAXZmilRbX1Wc8yk2ssbwHOGWA50moTnWZMOJi53ZQRGN+4QWUBnuDoNYJ1vTZDjHt/lNlZN/fy4KytT9ayip53MB49Q56FKwNdW1GeXjFbDPynWJRtgX/333JcIxN6BO1YgkGhQ3sx+JF1lmJisjxrCw6mJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldqfj47U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE12C4CEE7;
	Thu, 17 Jul 2025 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716407;
	bh=wZEtqFP7aHwbWMq++OgwAQHYQAR8dahj6q0fkSQ3q2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldqfj47UkfhunCEBN+Oybom1G+4e5Zf4jQ14RVhCB4aJJpw1EhMaNuJ5GM2tUrXwo
	 daaL/DVgINDyVYCZF5PDqfUkHHxbaUGGR538RBjev/9AI1rBDjR4C3mjGhMRLVsm2E
	 pKEbmbNmcWyHQ9ib2hiZKvY9gYtsAXYzeL+1KomyZiPrhAH/qu9tGW24oFF2Q1KxV6
	 XSD+IEx9ui+BkYjerc6n6sOX/aKHVWas0GYcyVLgvRvCHI1tNjPyR1EnuttgvKOgEq
	 +v45+WSrgNyOcGvHr4wDMes9w4AU7kJOx7OM4wlgkLA0oUFaulYQ7T4em6xAHCsWvD
	 JNKx3qH4CGPhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF8383BA38;
	Thu, 17 Jul 2025 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271642749.1391969.4135059292314627486.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:27 +0000
References: <20250714141957.3301871-1-yuehaibing@huawei.com>
In-Reply-To: <20250714141957.3301871-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ap420073@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 22:19:57 +0800 you wrote:
> pmc->idev is still used in ip6_mc_clear_src(), so as mld_clear_delrec()
> does, the reference should be put after ip6_mc_clear_src() return.
> 
> Fixes: 63ed8de4be81 ("mld: add mc_lock for protecting per-interface mld data")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/mcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
    https://git.kernel.org/netdev/net/c/ae3264a25a46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



