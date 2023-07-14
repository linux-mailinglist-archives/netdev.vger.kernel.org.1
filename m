Return-Path: <netdev+bounces-17773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21C753046
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96038280354
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7046AB;
	Fri, 14 Jul 2023 04:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCE4A11
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F63C433C9;
	Fri, 14 Jul 2023 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689307220;
	bh=sEiLPb6g0aGjWGK0/UMQFIfMD96QRvgmebAcFFHQWbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JisSJ5yxoaLHl3M0MwghbeR6pZorQ+naYYddq1MVDLpe3kQMOCdoGb+xprJcuSZYb
	 czsEbeyk2P/A48VscQjKv87Po9SuxjDxbsY0kYOnMi+ahiGMdKspDkOgPihxpwc6Mi
	 WizyVgw95Tp/45MCJGnza4osXEc/QmVsBNs825LaCXONoiVKxC/UO9ENoj7G3Z/gaW
	 4N8MfsP2pQOhmpoLMOInrVCJmYrR4XKc4zFAySqVmlUPrbM5AfFL40HbOaMqTVtj6m
	 vdhsE/Nha7fuFhxHvK0MnztL4XUsA1LZDAJnWw7MK6xwFmaSqt7hUCNDB/A23AznOf
	 kYn58+vY+8mSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C00E2E29F45;
	Fri, 14 Jul 2023 04:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usbnet: Fix WARNING in
 usbnet_start_xmit/usb_submit_urb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930722078.11211.17894680146501945080.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 04:00:20 +0000
References: <ea152b6d-44df-4f8a-95c6-4db51143dcc1@rowland.harvard.edu>
In-Reply-To: <ea152b6d-44df-4f8a-95c6-4db51143dcc1@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: davem@davemloft.net, kuba@kernel.org, oneukum@suse.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jul 2023 10:15:10 -0400 you wrote:
> The syzbot fuzzer identified a problem in the usbnet driver:
> 
> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> WARNING: CPU: 0 PID: 754 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> Modules linked in:
> CPU: 0 PID: 754 Comm: kworker/0:2 Not tainted 6.4.0-rc7-syzkaller-00014-g692b7dc87ca6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Workqueue: mld mld_ifc_work
> RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> Code: 7c 24 18 e8 2c b4 5b fb 48 8b 7c 24 18 e8 42 07 f0 fe 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 a0 c9 fc 8a e8 5a 6f 23 fb <0f> 0b e9 58 f8 ff ff e8 fe b3 5b fb 48 81 c5 c0 05 00 00 e9 84 f7
> RSP: 0018:ffffc9000463f568 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff88801eb28000 RSI: ffffffff814c03b7 RDI: 0000000000000001
> RBP: ffff8881443b7190 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
> R13: ffff88802a77cb18 R14: 0000000000000003 R15: ffff888018262500
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556a99c15a18 CR3: 0000000028c71000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  usbnet_start_xmit+0xfe5/0x2190 drivers/net/usb/usbnet.c:1453
>  __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4932 [inline]
>  xmit_one net/core/dev.c:3578 [inline]
>  dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
> ...
> 
> [...]

Here is the summary with links:
  - [v2] net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb
    https://git.kernel.org/netdev/net/c/5e1627cb43dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



