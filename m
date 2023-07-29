Return-Path: <netdev+bounces-22565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1BA768090
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB0F28232A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E36171C0;
	Sat, 29 Jul 2023 16:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF973D60
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93CF0C433C9;
	Sat, 29 Jul 2023 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690647620;
	bh=IEOAZ45/4P+sp1mwhyEcp2wdIchu873QLS3edQPUFjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E/QU49OhnFQmqJp9x7uJWamfJv/9s6fritLgW8nHcOf5aYwTD/V2d1WZwTD14f+fD
	 vf/ItpNHiWEX5V1KVwR2kNNu4OsR8bPHEsvZEKJuU2toUk7u3eNRlBFe6OVfUHARAf
	 oAdfDDp9rj582kXqNmNeQz50yCSlws6UISecIUuyXmsd/iNSxtVu6WoYoVANvIO8dU
	 J8i+zz8RUHoOx56KV2VDh6E7jk68cdLZ4D/5P8DJ4m8oJm4G4bJBf/tUcmYtYMLcBL
	 yWH4sFxHICf7jf3ByWoBZbCT4ZUEwdvSfiG0mDx/poxovoZcusQ3JV3EV2KF3xTpYi
	 uqvFbK7J7ktlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 707B6E21EC9;
	Sat, 29 Jul 2023 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] qed: Yet another scheduling while atomic fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169064762045.27300.15627978789433373165.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 16:20:20 +0000
References: <20230727152609.1633966-1-khorenko@virtuozzo.com>
In-Reply-To: <20230727152609.1633966-1-khorenko@virtuozzo.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: simon.horman@corigine.com, kuba@kernel.org, manishc@marvell.com,
 aelior@marvell.com, davem@davemloft.net, skalluru@marvell.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 18:26:08 +0300 you wrote:
> Running an old RHEL7-based kernel we have got several cases of following
> BUG_ON():
> 
>   BUG: scheduling while atomic: swapper/24/0/0x00000100
> 
>    [<ffffffffb41c6199>] schedule+0x29/0x70
>    [<ffffffffb41c5512>] schedule_hrtimeout_range_clock+0xb2/0x150
>    [<ffffffffb41c55c3>] schedule_hrtimeout_range+0x13/0x20
>    [<ffffffffb41c3bcf>] usleep_range+0x4f/0x70
>    [<ffffffffc08d3e58>] qed_ptt_acquire+0x38/0x100 [qed]
>    [<ffffffffc08eac48>] _qed_get_vport_stats+0x458/0x580 [qed]
>    [<ffffffffc08ead8c>] qed_get_vport_stats+0x1c/0xd0 [qed]
>    [<ffffffffc08dffd3>] qed_get_protocol_stats+0x93/0x100 [qed]
>                         qed_mcp_send_protocol_stats
>             case MFW_DRV_MSG_GET_LAN_STATS:
>             case MFW_DRV_MSG_GET_FCOE_STATS:
>             case MFW_DRV_MSG_GET_ISCSI_STATS:
>             case MFW_DRV_MSG_GET_RDMA_STATS:
>    [<ffffffffc08e36d8>] qed_mcp_handle_events+0x2d8/0x890 [qed]
>                         qed_int_assertion
>                         qed_int_attentions
>    [<ffffffffc08d9490>] qed_int_sp_dpc+0xa50/0xdc0 [qed]
>    [<ffffffffb3aa7623>] tasklet_action+0x83/0x140
>    [<ffffffffb41d9125>] __do_softirq+0x125/0x2bb
>    [<ffffffffb41d560c>] call_softirq+0x1c/0x30
>    [<ffffffffb3a30645>] do_softirq+0x65/0xa0
>    [<ffffffffb3aa78d5>] irq_exit+0x105/0x110
>    [<ffffffffb41d8996>] do_IRQ+0x56/0xf0
> 
> [...]

Here is the summary with links:
  - [v2,1/1] qed: Fix scheduling in a tasklet while getting stats
    https://git.kernel.org/netdev/net/c/e346e231b42b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



