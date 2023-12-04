Return-Path: <netdev+bounces-53475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9948032AC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B00F1C20A3F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7D200BF;
	Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwNBAhM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B219BAB;
	Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF709C433C8;
	Mon,  4 Dec 2023 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701693024;
	bh=Scnnbxct6A0XPzh5s73Wc9TuJRZ1k4HhysjpASGiM/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VwNBAhM3Q1gjAVS8rMJVe7C3EGqC71Xb41c+pR4K4W2naiCy4nJh46gxiocwEGbKB
	 OuscaGrW9kFb0SgGYGGcERJV3JbEqfNQVxgUYC5ZH/0EgMbdBmyxA8snNBagLAfRcT
	 F8UxarbIUQ/YUctZZq+hwmpZK37/xXqKqOvCcxy1AQKppTcn10wDB0CUqrFpysLVGt
	 v9zKu8p8SKS4MuskqiZjHjL2v1x8z1FLHho1DmfpAQ5m+CbrYqWCCC8hKnQGj8FhSZ
	 +adRCFwQVUfAgS2gfGVEAm3RwON6SObRutdLZrRBVrgYz+QjCzmxktZw7+njTU6rgB
	 UzCDo1VWusPMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B154CDD4EEF;
	Mon,  4 Dec 2023 12:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/5] r8152: Hold the rtnl_lock for all of reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170169302472.7913.15839516677330615990.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 12:30:24 +0000
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
In-Reply-To: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
To: Doug Anderson <dianders@chromium.org>
Cc: kuba@kernel.org, hayeswang@realtek.com, davem@davemloft.net,
 linux-usb@vger.kernel.org, grundler@chromium.org, laura.nao@collabora.com,
 ecgh@chromium.org, stern@rowland.harvard.edu, horms@kernel.org,
 bjorn@mork.no, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 29 Nov 2023 13:25:20 -0800 you wrote:
> As of commit d9962b0d4202 ("r8152: Block future register access if
> register access fails") there is a race condition that can happen
> between the USB device reset thread and napi_enable() (not) getting
> called during rtl8152_open(). Specifically:
> * While rtl8152_open() is running we get a register access error
>   that's _not_ -ENODEV and queue up a USB reset.
> * rtl8152_open() exits before calling napi_enable() due to any reason
>   (including usb_submit_urb() returning an error).
> 
> [...]

Here is the summary with links:
  - [net,v3,1/5] r8152: Hold the rtnl_lock for all of reset
    https://git.kernel.org/netdev/net/c/e62adaeecdc6
  - [net,v3,2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
    https://git.kernel.org/netdev/net/c/32a574c7e268
  - [net,v3,3/5] r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
    https://git.kernel.org/netdev/net/c/8a67b47fced9
  - [net,v3,4/5] r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
    https://git.kernel.org/netdev/net/c/8c53a7bd7065
  - [net,v3,5/5] r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
    https://git.kernel.org/netdev/net/c/79321a793945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



