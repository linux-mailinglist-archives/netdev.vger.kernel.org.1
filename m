Return-Path: <netdev+bounces-224783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEEB89F86
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32974E20FB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17802317706;
	Fri, 19 Sep 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKYidIdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0A3164DA;
	Fri, 19 Sep 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292227; cv=none; b=LXtJXOp97/rYF6Vh0mpkoQwjvGHMxunAD+qGvN9W+YCml0Jenm/73nxcidq0sM76HkmJ9ei8yGoJvGNNUxgWvXvaRt4Uqh3gH808EEjpc8TVzW2tFgMc7w1ZMxyWHnnU2+buu1DLa9qtATKE0fCNwGI+TsHwCzNFc4XDzxMiLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292227; c=relaxed/simple;
	bh=om7IHFxUqBk57l+hzSxJYXmlW0dohVfqH7wx9gm7LsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbYjHR5nFRq35J/xUqMqbm8uVfBBDNV1B85GXpqOTm1JZSHSJBmUPW6sDf0qTnGZaq1RRVGXyRQA5Ovysjstn3nYEzLmD6/Os9wpyfQDOPIVAzbTCmTrmxLVAGW9Rlh7lLXWQkAIVNsm5vV+TSvzsIPeZHFepYyv5JZsiSrIoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKYidIdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744CAC4CEF0;
	Fri, 19 Sep 2025 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292226;
	bh=om7IHFxUqBk57l+hzSxJYXmlW0dohVfqH7wx9gm7LsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uKYidIdoOAgpzhd2SpMHR61DatOztYePJmLjsZz71t2b+GYrakR3GDj8Dklln8YDf
	 5qKtMF35YuwHED5dRGmZJtBoh+9e5u329FdSyIRoZqP1frv79l97ToV7uhyd9apCZA
	 D20R0nO63su5vqCTqaFLmRViyQ4mIVgN2/lM0MZCN2qC/rwE858PUF5K7tknHc9UJv
	 9wC96543Bs+GPr1jsazQUQNVivEytVengW4REBZ5bRHycTiV5vhprQjMdJYq3WA+XK
	 Le8zadwSLkw+HYeSWpGunPgbaks849jnO2NQgj/IKkd519+l3h5uGzLw+Dwn0Y5Qbx
	 UtDCpn3FtcRFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3439D0C20;
	Fri, 19 Sep 2025 14:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hinic3: Fix NULL vs IS_ERR() check in
 hinic3_alloc_rxqs_res()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222574.3219626.8716643732005745835.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:25 +0000
References: <aMvUywhgbmO1kH3Z@stanley.mountain>
In-Reply-To: <aMvUywhgbmO1kH3Z@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gongfan1@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zhuyikai1@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 12:45:47 +0300 you wrote:
> The page_pool_create() function never returns NULL, it returns
> error pointers.  Update the check to match.
> 
> Fixes: 73f37a7e1993 ("hinic3: Queue pair resource initialization")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] hinic3: Fix NULL vs IS_ERR() check in hinic3_alloc_rxqs_res()
    https://git.kernel.org/netdev/net-next/c/c4bdef8b3d2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



