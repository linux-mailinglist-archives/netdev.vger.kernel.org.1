Return-Path: <netdev+bounces-192625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0EAC08E2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0282A3B47CA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908D2857F9;
	Thu, 22 May 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPHI/iU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DB284691;
	Thu, 22 May 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906795; cv=none; b=HZcISrclkAVAq8mMztMvFoi/zr+bZLsZ3oe64dqot3jOvvqjWlqfY+dIXAzqrP+nKrDKy3SZnX6I5mgDk1FKY3h5eKI6zz8zbYecvKhHgNYyeR13q8S7lUhoKS2Ts18jKA7Xt6h+a5e9y2WyfW2I9oQzFryHEYrdn6rmw3WkPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906795; c=relaxed/simple;
	bh=PrtIcPwzM7wPs2zvuHxls1vVzDdD9wFrpWGArTsL/Q4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kAT2nQKP0/iBC1uHqB0bGuhSnbrkR4dI/PzIfj8Jiml6hbnw6IAySMA797ON8n1yqC6+DazfnwpLbgqlTKA7+V+zNJecokwHSTnQI2K/ETeDUr9pdhnCSM0RSq/pLtmayS+e7x/Mlscv1r5fNliRePv3/N678KvRcbppcWLpKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPHI/iU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC6C4CEE4;
	Thu, 22 May 2025 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906794;
	bh=PrtIcPwzM7wPs2zvuHxls1vVzDdD9wFrpWGArTsL/Q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JPHI/iU7YnzWgpoyjAExvkpauD6VjJu94PfygI9paOFlHscYZUO29WQuL9IxAMpL1
	 QKtHos3paPQOln/jxonb93toglkOJEmDZbD6vinC5MxbPl5eOe0hakk4K78t7uRgDY
	 U8zdCSHpQblLEZoOm4fs+LifjCDxD6hOTZAfWcuDr0ADfxRgVB/vW+tET2CbrSqAd8
	 oU0kmAzHenpsNcslBeB5pI8TuXk3wCceTsN91nRwm6uKFqhcHEz7lK8aZqmS25D72V
	 KRTeSXiFzsM2ZYcDtVe6n3X8HnmGioIYJyXl0DQv0885a+zXNfLErx3UEFCC2mmE7q
	 WuArOtcDotgfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4B380AA7C;
	Thu, 22 May 2025 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tipc: fix slab-use-after-free Read in
 tipc_aead_encrypt_done
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174790683026.2467448.15133180857730827822.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 09:40:30 +0000
References: <20250520101404.1341730-1-wangliang74@huawei.com>
In-Reply-To: <20250520101404.1341730-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tuong.t.lien@dektech.com.au, ying.xue@windreiver.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 May 2025 18:14:04 +0800 you wrote:
> Syzbot reported a slab-use-after-free with the following call trace:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
>   Read of size 8 at addr ffff88807a733000 by task kworker/1:0/25
> 
>   Call Trace:
>    kasan_report+0xd9/0x110 mm/kasan/report.c:601
>    tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
>    crypto_request_complete include/crypto/algapi.h:266
>    aead_request_complete include/crypto/internal/aead.h:85
>    cryptd_aead_crypt+0x3b8/0x750 crypto/cryptd.c:772
>    crypto_request_complete include/crypto/algapi.h:266
>    cryptd_queue_worker+0x131/0x200 crypto/cryptd.c:181
>    process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
> 
> [...]

Here is the summary with links:
  - [net] net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done
    https://git.kernel.org/netdev/net/c/e27902461713

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



