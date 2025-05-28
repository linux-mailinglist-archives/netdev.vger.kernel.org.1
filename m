Return-Path: <netdev+bounces-193902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C7AC6369
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11D416CFBC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA247246348;
	Wed, 28 May 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkZZ2MKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A601DE4F1
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418756; cv=none; b=uc1Frtjot7HHr0fe15dZJdFBFV9ooewofhFXHzR5WCebSYR08ZGDu+MIwXaDKSpVEWYvSDLzz/6tqAQKinsUlB40Sb3wLJ83a1OWXaFLJPe4DCG2pHkp4VQZXTJ0yYFv/GEy7HuZfcrCsqZltB2Ta+e3+R/BzKYWCmtKmbdV5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418756; c=relaxed/simple;
	bh=/sDMz3Y3JCZyRlZFJBGVaxgvJvaORqamqpRMqm0zVCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qkyuHKo8iUfEK93r3M9uFW78GcE5Nh6ssKBxAjqOtARnKMs4ugx1jv/sH79sEQmoFr6VqFXnzviqix8J7Vo6xT6zqWagwM3AHQy5c1JDpRcbStsFavUG71RVRXbbND5D6/ZdAO43srdQpA9kxV3sRzc1kgaMaENtiPZv2dfqi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkZZ2MKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AB2C4CEF0;
	Wed, 28 May 2025 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748418756;
	bh=/sDMz3Y3JCZyRlZFJBGVaxgvJvaORqamqpRMqm0zVCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkZZ2MKsFgPvry0M0P6yDcTQJ/zZD/8Rs3iFVzsU7o6SRQLmdbJGaBjP6oG9omEN0
	 8C//7WmvhbT50JUTJ4QdMW8TWDE+s0+KYrhFAdGetYjwcUimv6ut5kTzx8yvQ+AxTn
	 HbY3Dd2mkVM9w7q/IMy2L25MCbYWPuTYyJuIKVliO/8bZd+pnSZWjcBHNMBXvHQ18Y
	 WgRMpmO/8U5AQngW45HoUxh3ivN9RoAlUF33844lhPPMVPERBnMcNBnFor0P0j36Il
	 RDa2gzH7q8MwF6FsC8HywBH3SWlsOJH0ugIjIG0p1lsz7nnOzG/7WpoZD6DSUs51jQ
	 CTEtzYcwEZxJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE939F1DE4;
	Wed, 28 May 2025 07:53:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841879000.2284365.10372314207862770782.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 07:53:10 +0000
References: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
In-Reply-To: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
To: Faicker Mo <faicker.mo@zenlayer.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.varghese@nokia.com, pshelar@ovn.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 May 2025 03:41:43 +0000 you wrote:
> The unexpected MPLS packet may not end with the bottom label stack.
> When there are many stacks, The label count value has wrapped around.
> A dead loop occurs, soft lockup/CPU stuck finally.
> 
> stack backtrace:
> UBSAN: array-index-out-of-bounds in /build/linux-0Pa0xK/linux-5.15.0/net/openvswitch/flow.c:662:26
> index -1 is out of range for type '__be32 [3]'
> CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Tainted: G           OE   5.15.0-121-generic #131-Ubuntu
> Hardware name: Dell Inc. PowerEdge C6420/0JP9TF, BIOS 2.12.2 07/14/2021
> Call Trace:
>  <IRQ>
>  show_stack+0x52/0x5c
>  dump_stack_lvl+0x4a/0x63
>  dump_stack+0x10/0x16
>  ubsan_epilogue+0x9/0x36
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  key_extract_l3l4+0x82a/0x840 [openvswitch]
>  ? kfree_skbmem+0x52/0xa0
>  key_extract+0x9c/0x2b0 [openvswitch]
>  ovs_flow_key_extract+0x124/0x350 [openvswitch]
>  ovs_vport_receive+0x61/0xd0 [openvswitch]
>  ? kernel_init_free_pages.part.0+0x4a/0x70
>  ? get_page_from_freelist+0x353/0x540
>  netdev_port_receive+0xc4/0x180 [openvswitch]
>  ? netdev_port_receive+0x180/0x180 [openvswitch]
>  netdev_frame_hook+0x1f/0x40 [openvswitch]
>  __netif_receive_skb_core.constprop.0+0x23a/0xf00
>  __netif_receive_skb_list_core+0xfa/0x240
>  netif_receive_skb_list_internal+0x18e/0x2a0
>  napi_complete_done+0x7a/0x1c0
>  bnxt_poll+0x155/0x1c0 [bnxt_en]
>  __napi_poll+0x30/0x180
>  net_rx_action+0x126/0x280
>  ? bnxt_msix+0x67/0x80 [bnxt_en]
>  handle_softirqs+0xda/0x2d0
>  irq_exit_rcu+0x96/0xc0
>  common_interrupt+0x8e/0xa0
>  </IRQ>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: openvswitch: Fix the dead loop of MPLS parse
    https://git.kernel.org/netdev/net/c/0bdc924bfb31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



