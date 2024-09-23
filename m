Return-Path: <netdev+bounces-129374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFF97F16F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A492CB21A1A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C719F42B;
	Mon, 23 Sep 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y52NQa2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCD4D8A7
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121483; cv=none; b=gnqQGiWpOMxLtw2TjRdPRE27ZAXmXyUWZvINUsI59QiptIDtHRfN8+ojmtrXDffyZarQzWWv1tKuefb/tjW7q4Pu1nyePHNfxhjns3rfeBam2bnPUm30t9k2G5MT7jRej2Xmgy7EBwyk07a8lN9jQHJJfrWWJneksJSpYkLGPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121483; c=relaxed/simple;
	bh=FJhWSI5BLXofFTUicGbbW16xFMGL9OgLs0Ydxy2kojA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L61o+Oan29PVtj6+BGWBCQs6RFdI+FIjW/Q7DI8oMDdXCJdYb/zfK9ree9KTzTvaonYA+ZmDVdeEijJo6v21cFv+xjEz9BofgRNbVrjCTDPrWW7ec8fNAcfggd1U2JbkLjLW9sQlvmPpRnHRIFEZe2LF4+Jid0eJjIckLTI0LhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y52NQa2L; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99fde9f1dso428919585a.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727121480; x=1727726280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY+OBjtYbjjwhaiPiKQ1NzFK51MAkUu1miJfNpjsf5o=;
        b=Y52NQa2L3m34xWP+9hHBh0/wRF2Bt+wM4RDedTgTeaTWjhJYGaTmKo5dsiD9cLPV+u
         1If6LtWjD9AftVTDpt0XhcnX0eSNjDn1sXJogl4flaBvJZF8G4OeWwFMtj0JVlBtiSOq
         Sa7RvhDfAZQ4AZovWNYjw4WnRpxppCZx050wdWnCCBAm6SXzMnGaf5C1m2dcHfDLqFJh
         FN0yaYgdxHKOA2ViXg/+GY0CVeST1KuiB2kVqJRyOwjTurRgkjLfW8IRuiOCGNaRK0hk
         rJsoi8AnDq02mTnD8w3j8VAMhPggsmKQX2dt6RbC9PdafkdtCd3LxGjVRzi1bGJutih9
         qULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121480; x=1727726280;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HY+OBjtYbjjwhaiPiKQ1NzFK51MAkUu1miJfNpjsf5o=;
        b=W99hhhdpXfOgDxl+pLFQJ0WMuz+oL6xDFBBFppCFBmPjn/lYBytCs0f3OyHin4mhHt
         Ip8HXEYJbruEXchK4ZaPQrSiMT73gAFq76UaoMY04hGrG/rSMe2krSqC79++Q1SPP0c8
         F6E+J1OnjDhyQVCo6hPJXiPpTFhxbQLwH0IZCmI2DmZgsoITOiQ4xz37YCo5fRO01Xoq
         ql43YQ+M8IoF77ACZIg8MdSUlUz0TYYw2cXI8vzPqqLT9huPZl2JjWqL+CK23DljJqJw
         NC9H4D2lrw7Vl7vHxhjfrQNXgl1bhIWS491eSLRzpEC/135DwiUfVfkriqRUJnF9/Cul
         t0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVTYO61vA0wugugIw3rFjnjmi42bBeRrSjDisyzbZGlzkxJuPSTtYSaRpCf3dAX3XtzTzq4O+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwciJTyrTXlJoW5vef8dLe4br90FuAuZynV34LvN7CPc8ZCF8i7
	6aFwFPGcvFJFBrmo6E6NCYh0U4lh3EYvkPHGD4g6eoLKjTa903OJ
X-Google-Smtp-Source: AGHT+IEWM2gdqdS0oVrZ4hCj18y5gGtAytQ/wZbzTd4Qv0LLoeO4asX5DEGgVapvzVkicvfdPasENw==
X-Received: by 2002:a05:620a:190f:b0:79e:ff0a:8799 with SMTP id af79cd13be357-7acb80c4c75mr2008685285a.30.1727121480149;
        Mon, 23 Sep 2024 12:58:00 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cca02sm490385a.73.2024.09.23.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 12:57:59 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:57:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: greearb@candelatech.com, 
 netdev@vger.kernel.org, 
 dsahern@kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Message-ID: <66f1c846a5292_3ee6fb2949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240923162506.1405109-1-greearb@candelatech.com>
References: <20240923162506.1405109-1-greearb@candelatech.com>
Subject: Re: [PATCH] Revert "vrf: Remove unnecessary RCU-bh critical section"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

greearb@ wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> 
> dev_queue_xmit_nit needs to run with bh locking, otherwise
> it conflicts with packets coming in from a nic in softirq
> context and packets being transmitted from user context.
> 
> ================================
> WARNING: inconsistent lock state
> 6.11.0 #1 Tainted: G        W
> --------------------------------
> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
> {IN-SOFTIRQ-W} state was registered at:
>   lock_acquire+0x19a/0x4f0
>   _raw_spin_lock+0x27/0x40
>   packet_rcv+0xa33/0x1320
>   __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
>   __netif_receive_skb_list_core+0x2c9/0x890
>   netif_receive_skb_list_internal+0x610/0xcc0
>   napi_complete_done+0x1c0/0x7c0
>   igb_poll+0x1dbb/0x57e0 [igb]
>   __napi_poll.constprop.0+0x99/0x430
>   net_rx_action+0x8e7/0xe10
>   handle_softirqs+0x1b7/0x800
>   __irq_exit_rcu+0x91/0xc0
>   irq_exit_rcu+0x5/0x10
>   common_interrupt+0x7f/0xa0
>   asm_common_interrupt+0x22/0x40
>   cpuidle_enter_state+0x289/0x320
>   cpuidle_enter+0x45/0xa0
>   do_idle+0x2fe/0x3e0
>   cpu_startup_entry+0x4b/0x60
>   start_secondary+0x201/0x280
>   common_startup_64+0x13e/0x148
> irq event stamp: 467094363
> hardirqs last  enabled at (467094363): [<ffffffff83dc794b>] _raw_spin_unlock_irqrestore+0x2b/0x50
> hardirqs last disabled at (467094362): [<ffffffff83dc7753>] _raw_spin_lock_irqsave+0x53/0x60
> softirqs last  enabled at (467094360): [<ffffffff83481213>] skb_attempt_defer_free+0x303/0x4e0
> softirqs last disabled at (467094358): [<ffffffff83481188>] skb_attempt_defer_free+0x278/0x4e0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(rlock-AF_PACKET);
>   <Interrupt>
>     lock(rlock-AF_PACKET);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by btserver/134819:
>  #0: ffff888136a3bf98 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_recvmsg+0xc7/0x4e0
>  #1: ffffffff84e4bc20 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x59/0x1e20
>  #2: ffffffff84e4bc20 (rcu_read_lock){....}-{1:2}, at: dev_queue_xmit_nit+0x2a/0xa40
> 
> stack backtrace:
> CPU: 2 UID: 0 PID: 134819 Comm: btserver Tainted: G        W          6.11.0 #1
> Tainted: [W]=WARN
> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x73/0xa0
>  mark_lock+0x102e/0x16b0
>  ? print_usage_bug.part.0+0x600/0x600
>  ? print_usage_bug.part.0+0x600/0x600
>  ? print_usage_bug.part.0+0x600/0x600
>  ? lock_acquire+0x19a/0x4f0
>  ? find_held_lock+0x2d/0x110
>  __lock_acquire+0x9ae/0x6170
>  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>  lock_acquire+0x19a/0x4f0
>  ? tpacket_rcv+0x863/0x3b30
>  ? run_filter+0x131/0x300
>  ? lock_sync+0x170/0x170
>  ? do_syscall_64+0x69/0x160
>  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  ? lock_is_held_type+0xa5/0x110
>  _raw_spin_lock+0x27/0x40
>  ? tpacket_rcv+0x863/0x3b30
>  tpacket_rcv+0x863/0x3b30
>  ? packet_recvmsg+0x1340/0x1340
>  ? __asan_memcpy+0x38/0x60
>  ? __skb_clone+0x547/0x730
>  ? packet_recvmsg+0x1340/0x1340
>  dev_queue_xmit_nit+0x709/0xa40
>  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>  vrf_finish_direct+0x26e/0x340 [vrf]
>  ? vrf_ip_local_out+0x570/0x570 [vrf]
>  vrf_l3_out+0x5f4/0xe80 [vrf]
>  __ip_local_out+0x51e/0x7a0
>  ? __ip_append_data+0x3d00/0x3d00
>  ? __lock_acquire+0x1b57/0x6170
>  ? ipv4_dst_check+0xd6/0x150
>  ? lock_is_held_type+0xa5/0x110
>  __ip_queue_xmit+0x7ff/0x1e20
>  __tcp_transmit_skb+0x1699/0x3850
>  ? __tcp_select_window+0xfb0/0xfb0
>  ? __build_skb_around+0x22f/0x330
>  ? __alloc_skb+0x13d/0x2c0
>  ? __napi_build_skb+0x40/0x40
>  ? __tcp_send_ack.part.0+0x5f/0x690
>  ? skb_attempt_defer_free+0x303/0x4e0
>  tcp_recvmsg_locked+0xdd1/0x23e0
>  ? tcp_recvmsg+0xc7/0x4e0
>  ? tcp_update_recv_tstamps+0x1c0/0x1c0
>  tcp_recvmsg+0xe5/0x4e0
>  ? tcp_recv_timestamp+0x6c0/0x6c0
>  inet_recvmsg+0xf0/0x4b0
>  ? inet_splice_eof+0xa0/0xa0
>  ? inet_splice_eof+0xa0/0xa0
>  sock_recvmsg+0xc8/0x150
>  ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>  sock_read_iter+0x258/0x380
>  ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>  ? sock_recvmsg+0x150/0x150
>  ? rw_verify_area+0x64/0x590
>  vfs_read+0x8d5/0xc20
>  ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>  ? kernel_read+0x50/0x50
>  ? __asan_memset+0x1f/0x40
>  ? ktime_get_ts64+0x85/0x210
>  ? __fget_light+0x4d/0x1d0
>  ksys_read+0x166/0x1c0
>  ? __ia32_sys_pwrite64+0x1d0/0x1d0
>  ? __ia32_sys_poll+0x3e0/0x3e0
>  do_syscall_64+0x69/0x160
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f6909b01b92

Can compress output to short relevant part

Please also add a Link: to the previous conversation

and a Fixes: to the commit that introduced this
and a Cc: stable@vger.kernel.org

Mark the subject PATCH net


> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/vrf.c | 2 ++
>  net/core/dev.c    | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 4d8ccaf9a2b4..4087f72f0d2b 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
>  		eth_zero_addr(eth->h_dest);
>  		eth->h_proto = skb->protocol;
>  
> +		rcu_read_lock_bh();
>  		dev_queue_xmit_nit(skb, vrf_dev);
> +		rcu_read_unlock_bh();
>  
>  		skb_pull(skb, ETH_HLEN);
>  	}
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd479f5f22f6..566e69a38eed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>  /*
>   *	Support routine. Sends outgoing frames to any network
>   *	taps currently in use.
> + *	BH must be disabled before calling this.
>   */
>  
>  void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
> -- 
> 2.42.0
> 



