Return-Path: <netdev+bounces-127601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9989975DA6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E34A1F23A4B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E921BC089;
	Wed, 11 Sep 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLvVlj8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD51BC07B;
	Wed, 11 Sep 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096834; cv=none; b=ImnZrT3zjcitzYJhQbBcoku4ZCm4tqa8gPQprAWxlhvRgRmhhsaJaqq7TtEmCciko8MWduHZXSLLYAVP9e+EPBc9bKl6jI8a8utHdrHHY8/FW/iuHsTrwaTMfRuoMbZI0+rCSyKGMHkHuBA0akPnPEwvNglLw4+EO1OHSxbq4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096834; c=relaxed/simple;
	bh=T+Xk9de/KDBxm3BAUHKnu2gHLOOciVSNBTtQ8HkA9as=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GllAfpPkZOl7o4wdvxDks3O52AqZEUGYXONmpMOIxqto9fazzqi2b+gd26axqmC3Y0qvxeJYENWt62Dvn+P7qEJHFgpa0larMwAcDR5uOOlkjNC17WgYPgv2GMqEz4HMYGye4RbxMbQJNqz93/VmtpkwIYRzgTu9mJw/cmgCwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLvVlj8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C6C4CEC0;
	Wed, 11 Sep 2024 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096833;
	bh=T+Xk9de/KDBxm3BAUHKnu2gHLOOciVSNBTtQ8HkA9as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OLvVlj8mYSixA5P6WQq6QZXi3dIYgPQvMVIsiREQgjYDGt2KYSwmCkMcqvJqs18fO
	 yvnhoH0wS94gRvnANjcQJFA5naTdO1FNBNIg3GLFTrVwAumC57UtQga3Ur9i4y4PAD
	 jMp2C8dFrqSoMgUBka8KP25MD9kdWB+nSOjnoVBzlu3f7vU16FiWhZsPrE/RyPTrpw
	 QRPzbb+DKfJcVskBwAJRgQi0xZTSNlkRTQN/fzbQXJrYrH7hmyBNadeRagQ3EOZd/v
	 nsAp62RuHErr2c8CFkiYDph8/3mwk6s9cxUPmatYvxHaxZvSSNtTex9mkQKsaPMyH8
	 mBXKJ+lKPdzLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D123806656;
	Wed, 11 Sep 2024 23:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V4] mptcp: pm: Fix uaf in __timer_delete_sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609683476.1105624.7683534378726526616.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:34 +0000
References: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
In-Reply-To: <tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 17:58:56 +0800 you wrote:
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
> 
>      CPU1				CPU2
>      ====                               ====
>      net_rx_action
>      napi_poll                          netlink_sendmsg
>      __napi_poll                        netlink_unicast
>      process_backlog                    netlink_unicast_kernel
>      __netif_receive_skb                genl_rcv
>      __netif_receive_skb_one_core       netlink_rcv_skb
>      NF_HOOK                            genl_rcv_msg
>      ip_local_deliver_finish            genl_family_rcv_msg
>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
>      tcp_data_queue                     remove_anno_list_by_saddr
>      mptcp_incoming_options             mptcp_pm_del_add_timer
>      mptcp_pm_del_add_timer             kfree(entry)
> 
> [...]

Here is the summary with links:
  - [net,V4] mptcp: pm: Fix uaf in __timer_delete_sync
    https://git.kernel.org/netdev/net/c/b4cd80b03389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



