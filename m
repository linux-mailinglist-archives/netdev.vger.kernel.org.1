Return-Path: <netdev+bounces-110780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A169E92E462
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FD21F228AB
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AB158D8B;
	Thu, 11 Jul 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ9Bmm+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A251586D5;
	Thu, 11 Jul 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693230; cv=none; b=oFuluiGp6/zqihi4fNoHLuN4dVVpWnNqZcfYqJVuCyeCUc4IsbRh95CRf8a5N6NHep70pr3RjWToF4dBYkTn7q3FSPwlYONa90RA6CArcdbdApT5ZXZjoRkx7mV0DBLhz0NIbSWaZTgSs/GF38x/ZDLSUEYOVCswgo04cu+tKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693230; c=relaxed/simple;
	bh=KuLkmPep0FgB/b9onjhI7XMc1imfQqx3j5EA9FWI9tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XrkKGi3TWwAde03xsCnXQ4GYP25PDZByLx9+8MHLef/Xe/+GR29LNltrPi0IIo4ip27gmls5b5iXJZGHtXIQ5eEv6eTW9CNT2kB8ybR+Hdce3GBHuXuHJp3f91oPWQ8XqOof38+n7TPEPDaDUw7ppuT982DopgQoyeeMUX7p1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ9Bmm+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3F1AC32786;
	Thu, 11 Jul 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693229;
	bh=KuLkmPep0FgB/b9onjhI7XMc1imfQqx3j5EA9FWI9tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZ9Bmm+vb36W/NTCnTCuq/j+PDx9P1TZ969KcaxpR/PkSO0pu+nnLnXpBnXSC3FU4
	 em6I1UMOSt9RhLmaWnrCf76FvfMuO1LKJDqHNF1yjOcWHp3mWNO5IvkzeZRmoI/OT5
	 AaxV4cdzJlI4cPbuCXX4ngZ4PDCOPr21mdcyM8i94rYCN5MmZD53AL7f5JtVbJp88U
	 QI6qd00Ob7F9IHNK9p0X41750xmXWyySnUIP2QVKXg4pChcW9+j/3EUBkZzkM9PmaF
	 sIdRCHm4g+zSKRKEUu1sfvlOndXPCKr6vBq/TA81jetYwILl87p+1KcfVKTo9iNIWb
	 gNQtiyvdK9r2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9340CC433E9;
	Thu, 11 Jul 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/sched: Fix UAF when resolving a clash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172069322959.11889.7076340448823741973.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 10:20:29 +0000
References: <20240710053747.13223-1-chengen.du@canonical.com>
In-Reply-To: <20240710053747.13223-1-chengen.du@canonical.com>
To: Chengen Du <chengen.du@canonical.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ozsh@nvidia.com, paulb@nvidia.com, marcelo.leitner@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gerald.yang@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Jul 2024 13:37:47 +0800 you wrote:
> KASAN reports the following UAF:
> 
>  BUG: KASAN: slab-use-after-free in tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>  Read of size 1 at addr ffff888c07603600 by task handler130/6469
> 
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x48/0x70
>   print_address_description.constprop.0+0x33/0x3d0
>   print_report+0xc0/0x2b0
>   kasan_report+0xd0/0x120
>   __asan_load1+0x6c/0x80
>   tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>   tcf_ct_act+0x886/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
>   __irq_exit_rcu+0x82/0xc0
>   irq_exit_rcu+0xe/0x20
>   common_interrupt+0xa1/0xb0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x27/0x40
> 
> [...]

Here is the summary with links:
  - [net,v3] net/sched: Fix UAF when resolving a clash
    https://git.kernel.org/netdev/net/c/26488172b029

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



