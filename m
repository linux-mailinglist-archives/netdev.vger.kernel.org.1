Return-Path: <netdev+bounces-112947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B612093BF96
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8261C21571
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4B196D9D;
	Thu, 25 Jul 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYwHoU71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BD1386C0
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901831; cv=none; b=qoZ+YC99mE92AenFijZ3LtLDtp+McThTT3uJyquqtBjkUhkOAqPxCsDHaOjLoWzW6KKl8fZ9u7VOeiSweE0mKmPqoZ2n/xtaAeFLYBpxcdiPsDyXzx3sPkMc/ry1sXYiVc8PJvBT10c2P+d+eTBruqrxA/4vKIjRxZIPAawHkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901831; c=relaxed/simple;
	bh=fW3eblInzQrm81i6hy43Aei6W5uy9FNkcUnKFD9Dpmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRKRpsnEz/9zU0XEuy7gULCDd5cDSFfc6JqlcLw1jlF5kT9Fy8H8mBwcyEXwMl4IzWRIW2SIxq/vYtImaRjF5KnI4mqlNelwn1puEHYVqnf27HyP0ydxeQGNPrWqsxP5He+hoEI0Yt2O6J3As2zzlmnjNb1I8Px9LgVW23j8j1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYwHoU71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE6C116B1;
	Thu, 25 Jul 2024 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721901830;
	bh=fW3eblInzQrm81i6hy43Aei6W5uy9FNkcUnKFD9Dpmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYwHoU71EaDw4P88HVk4IWLhefvRmz2J62G31WVmLRjkyxEPH6j41DtB297rbjlor
	 CWKCcTkAAcP/wWwAKYdcquYme6xw/V3BFrj0MTt/D2LQWcPmaV0Iqz1PePQ9ZohzuZ
	 oTYJpgx/Rs3dMSwe6hQnxX6TljS2Yo9socqbZlEomPelSYUfoMRrk8DwQT7RHzTFLe
	 8CrKzoU8scbymBsNM1C3axTX1VArG7In7vub9qGBvr75ACS0TQfTLREkfNcIgs4kke
	 U0GBemHkW7iqzRvDX8kytCAWh7/n3+/DgvvgmpUHEq3+70ENYi7wQUL4NDw3Wrg10F
	 lEDdZF7WIeG2w==
Date: Thu, 25 Jul 2024 11:03:46 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH net] sched: act_ct: take care of padding in struct
 zones_ht_key
Message-ID: <20240725100346.GK97837@kernel.org>
References: <20240725092745.1760161-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725092745.1760161-1-edumazet@google.com>

On Thu, Jul 25, 2024 at 09:27:45AM +0000, Eric Dumazet wrote:
> Blamed commit increased lookup key size from 2 bytes to 16 bytes,
> because zones_ht_key got a struct net pointer.
> 
> Make sure rhashtable_lookup() is not using the padding bytes
> which are not initialized.
> 
>  BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>  BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>  BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
>   rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>   __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>   rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>   rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>   tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
>   tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
>   tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
>   tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
>   tcf_action_add net/sched/act_api.c:2061 [inline]
>   tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
>   rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
>   rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
>   __sys_sendmsg net/socket.c:2680 [inline]
>   __do_sys_sendmsg net/socket.c:2689 [inline]
>   __se_sys_sendmsg net/socket.c:2687 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
>   x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:47
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Local variable key created at:
>   tcf_ct_flow_table_get+0x4a/0x2260 net/sched/act_ct.c:324
>   tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
> 
> Fixes: 88c67aeb1407 ("sched: act_ct: add netns into the key of tcf_ct_flow_table")
> Reported-by: syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

