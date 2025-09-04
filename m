Return-Path: <netdev+bounces-219834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C25B434E1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76701C82AA4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405C2BEC45;
	Thu,  4 Sep 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhSHOWo/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACC2BEC2D;
	Thu,  4 Sep 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972802; cv=none; b=fWDiZp5NG8tmQPe8Kph/7kGEl1MdMEKRWpzhM37YWTVB0nUNRJ9v6ofeUZJCKfZNWNs93MsU13u369PtyDbeXpxlpXgN2J7trADV8ux4aLi6kl5YQHR/yNt5AGrqKcgavmpsMZXjrCXe3bwLNPospL8K/HdsL+Kbq3KCx9PR+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972802; c=relaxed/simple;
	bh=LTfSK6bm0uoDmpF/XmAaaSZU4qORee0HC7EH0q/Ptpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ues39li9bGVEJrlZmys2vr74EDUNQIcNG3NK9Z8tuucFDhBWH3+aWwxCxFitCBdh4SNq5/L7pHhNY3VVANM1ptxY1hODY5ZOe875gHgpaBMiDWz1rGtvGaOXulvbiP+uPGTnhd8i7luobxVAeiiQnxwIEQZjfpKxZVKenZLYRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhSHOWo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB477C4CEF4;
	Thu,  4 Sep 2025 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972802;
	bh=LTfSK6bm0uoDmpF/XmAaaSZU4qORee0HC7EH0q/Ptpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZhSHOWo/nxz9p8qppx08leARXGv7SpENcwjjT9yby0I4mZ39+1CH7CFBRNQxkzeBY
	 GQwkWxk2Jpv6PgtUiS4wO+2h1KZ7x6DRJR24z/DALys7/pn+xVXtpABUjg8FbG0/og
	 Vb+uIXtwVnTIilN2tQRjo2yaHPqS3YoHzteWKATnn4UNY0l6CzKKDX2xz3aen6PMrU
	 2fnUfRj4piQjjMJrZhJ6KoGHaXlI2DXrolM+nRt84Q5r7/dEY/bq3k+Jf/c7PFZPLM
	 ceIjRAC+LJ6GbIAKmcEV9SQcRvvu1faD7eD3r0+j61JK3R6Zm2EsW3tpum/4R3NzcZ
	 fTeg5HpkVDCEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8EB383C25A;
	Thu,  4 Sep 2025 08:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: atm: fix memory leak in atm_register_sysfs when
 device_register fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175697280674.1344869.4481080369917304414.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 08:00:06 +0000
References: <20250901063537.1472221-1-wangliang74@huawei.com>
In-Reply-To: <20250901063537.1472221-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, kay.sievers@vrfy.org,
 gregkh@suse.de, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 1 Sep 2025 14:35:37 +0800 you wrote:
> When device_register() return error in atm_register_sysfs(), which can be
> triggered by kzalloc fail in device_private_init() or other reasons,
> kmemleak reports the following memory leaks:
> 
> unreferenced object 0xffff88810182fb80 (size 8):
>   comm "insmod", pid 504, jiffies 4294852464
>   hex dump (first 8 bytes):
>     61 64 75 6d 6d 79 30 00                          adummy0.
>   backtrace (crc 14dfadaf):
>     __kmalloc_node_track_caller_noprof+0x335/0x450
>     kvasprintf+0xb3/0x130
>     kobject_set_name_vargs+0x45/0x120
>     dev_set_name+0xa9/0xe0
>     atm_register_sysfs+0xf3/0x220
>     atm_dev_register+0x40b/0x780
>     0xffffffffa000b089
>     do_one_initcall+0x89/0x300
>     do_init_module+0x27b/0x7d0
>     load_module+0x54cd/0x5ff0
>     init_module_from_file+0xe4/0x150
>     idempotent_init_module+0x32c/0x610
>     __x64_sys_finit_module+0xbd/0x120
>     do_syscall_64+0xa8/0x270
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] net: atm: fix memory leak in atm_register_sysfs when device_register fail
    https://git.kernel.org/netdev/net/c/0a228624bcc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



