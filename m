Return-Path: <netdev+bounces-131580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABAF98EED9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D411C211A0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17216BE1C;
	Thu,  3 Oct 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="A3f03joZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33122156C63
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957580; cv=none; b=E7Z04/NHN6vDXBngcgamsZkFuHVgjlP1aJOpsWwM9Aicf6IDjP4ts2YHrxR/vyZe4igI1mNDrCyyCsR+PWJCSBNexnmp/2Nq3x94myj90n0WmRTmH2Qh0yqMigF4cBv4xlbBlH1JIIKepYY5QyXPHtmnYWYuPY2ePWxg16EYN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957580; c=relaxed/simple;
	bh=0x6tZk4YGTOTOU6o9Ue3I5QeMJBT6xK1kIGzvH1ahog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5J4q/TEa4KUiv72xjDBWrFyEz0zxvwbKOLSJfsaExuO8vvxmnAsw93XaLf9ik0mdG1N0vJObQoopjq+EBuss1fu6abD1ejnStbhr51prmjAlMJVHW5S50Urb0IyV8WAUE3mZIFJMkPiblYHxTdLMBAbi09Rgs0BILvGprEYmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=A3f03joZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so1846620e87.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727957576; x=1728562376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xa8eF60sMNK1pIoeIyWLtZy6r5H6bkLZNmwU+/ruFw=;
        b=A3f03joZLECZOZPKLYg2BY4kBVywIYJCGIArL07JrZpVa+8HBW7Taq6hR7cxGGAdJe
         dVv+SFEwY6I2F2H0ctZpl0bq0mSJrzBpyQoQ/JVmuzsyhmD1TK3519dCpe3ApcfXLpLf
         ojCYdkuYQo8ZPapKPmnasAwBW00Zl/zmFE3+umcX2/JRuvi7GmqjT6Yv7iaFCPwKXbvN
         2+bCa+T22/4YjJIbc9FEwSfIolfAwEXH+X3zFkZ3ZKiLgZ9GwqEYX5fMeM8XjMW+rxdF
         MXFjPq/LvIZfYuvuTfit4ssV/bi0QvC+PWVZCNc5zws8bVLepwt21eJRs7cNHBgSljBN
         oYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957576; x=1728562376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xa8eF60sMNK1pIoeIyWLtZy6r5H6bkLZNmwU+/ruFw=;
        b=P3/ESaLxOyHb19ustwrL6tM8H56/hk9gRnnDiF5HgEUXgXZvTyS+XwnRKNdgAmrcVH
         YoK6wHkDIi9No0BYvDF82Cnp2/iv2krHzG4C3hafwgKl+NM4JsY7sTyPGOsFGe2m9NRs
         XTktC3Ow0Waht7NYQnizyK3Cjv4cIfkYz+AzensKJ6y2jidCZBhsGjiXiAsgSNnj2Yj+
         Z47ii7fZyypW6pUxWfCncfK1HwziYhjf6vMb+P4FapFF1LEIxuTg7lHkJOdG1ZFmLuFk
         1tDdlBHW4SIbJVeX7OQGH9x/h7CYKxtVTyn7xVuKFGb4kdKMwPNQxvS8NLTgNdrXps7W
         Sy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOqmcbmA3z5xpYq0Cs6svQOfweyGS7Vf+u6eFgsZPlvxSfrfT1MdkdJU++u5LUOG/hUFTKa3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD47Sgq+63JAaIvn8LQtXHdPKai9nn69C1hxxGkW6MJtyntX5b
	/8hdgDP6McZP5pHJGDgBaE2x7yRTvBKAN/1C1wCW8qXO7Utiyo+eyqFsXFyw5jMfBZSZtD9H1VY
	z
X-Google-Smtp-Source: AGHT+IGmTKCGEQNqAewvX5DDkhQB+yZ0q35SrFZ8fw0RZh1yUzjZYb2RqN+pThwako+HD/g/EUedxA==
X-Received: by 2002:a05:6512:3512:b0:52e:fef4:2cab with SMTP id 2adb3069b0e04-539a625ee1emr759199e87.2.1727957575915;
        Thu, 03 Oct 2024 05:12:55 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82a3991sm164344e87.224.2024.10.03.05.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:12:55 -0700 (PDT)
Message-ID: <43f6f1cd-34ab-4db2-82c4-b92345310eb7@blackwall.org>
Date: Thu, 3 Oct 2024 15:12:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] netfilter: br_netfilter: fix panic with
 metadata_dst skb
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, idosch@nvidia.com, petrm@nvidia.com
References: <20241001154400.22787-1-aroulin@nvidia.com>
 <20241001154400.22787-2-aroulin@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241001154400.22787-2-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 18:43, Andy Roulin wrote:
> Fix a kernel panic in the br_netfilter module when sending untagged
> traffic via a VxLAN device.
> This happens during the check for fragmentation in br_nf_dev_queue_xmit.
> 
> It is dependent on:
> 1) the br_netfilter module being loaded;
> 2) net.bridge.bridge-nf-call-iptables set to 1;
> 3) a bridge with a VxLAN (single-vxlan-device) netdevice as a bridge port;
> 4) untagged frames with size higher than the VxLAN MTU forwarded/flooded
> 
> When forwarding the untagged packet to the VxLAN bridge port, before
> the netfilter hooks are called, br_handle_egress_vlan_tunnel is called and
> changes the skb_dst to the tunnel dst. The tunnel_dst is a metadata type
> of dst, i.e., skb_valid_dst(skb) is false, and metadata->dst.dev is NULL.
> 
> Then in the br_netfilter hooks, in br_nf_dev_queue_xmit, there's a check
> for frames that needs to be fragmented: frames with higher MTU than the
> VxLAN device end up calling br_nf_ip_fragment, which in turns call
> ip_skb_dst_mtu.
> 
> The ip_dst_mtu tries to use the skb_dst(skb) as if it was a valid dst
> with valid dst->dev, thus the crash.
> 
> This case was never supported in the first place, so drop the packet
> instead.
> 
> PING 10.0.0.2 (10.0.0.2) from 0.0.0.0 h1-eth0: 2000(2028) bytes of data.
> [  176.291791] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000110
> [  176.292101] Mem abort info:
> [  176.292184]   ESR = 0x0000000096000004
> [  176.292322]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  176.292530]   SET = 0, FnV = 0
> [  176.292709]   EA = 0, S1PTW = 0
> [  176.292862]   FSC = 0x04: level 0 translation fault
> [  176.293013] Data abort info:
> [  176.293104]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  176.293488]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  176.293787]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  176.293995] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000043ef5000
> [  176.294166] [0000000000000110] pgd=0000000000000000,
> p4d=0000000000000000
> [  176.294827] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  176.295252] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel veth
> br_netfilter bridge stp llc ipv6 crct10dif_ce
> [  176.295923] CPU: 0 PID: 188 Comm: ping Not tainted
> 6.8.0-rc3-g5b3fbd61b9d1 #2
> [  176.296314] Hardware name: linux,dummy-virt (DT)
> [  176.296535] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [  176.296808] pc : br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
> [  176.297382] lr : br_nf_dev_queue_xmit+0x2ac/0x4ec [br_netfilter]
> [  176.297636] sp : ffff800080003630
> [  176.297743] x29: ffff800080003630 x28: 0000000000000008 x27:
> ffff6828c49ad9f8
> [  176.298093] x26: ffff6828c49ad000 x25: 0000000000000000 x24:
> 00000000000003e8
> [  176.298430] x23: 0000000000000000 x22: ffff6828c4960b40 x21:
> ffff6828c3b16d28
> [  176.298652] x20: ffff6828c3167048 x19: ffff6828c3b16d00 x18:
> 0000000000000014
> [  176.298926] x17: ffffb0476322f000 x16: ffffb7e164023730 x15:
> 0000000095744632
> [  176.299296] x14: ffff6828c3f1c880 x13: 0000000000000002 x12:
> ffffb7e137926a70
> [  176.299574] x11: 0000000000000001 x10: ffff6828c3f1c898 x9 :
> 0000000000000000
> [  176.300049] x8 : ffff6828c49bf070 x7 : 0008460f18d5f20e x6 :
> f20e0100bebafeca
> [  176.300302] x5 : ffff6828c7f918fe x4 : ffff6828c49bf070 x3 :
> 0000000000000000
> [  176.300586] x2 : 0000000000000000 x1 : ffff6828c3c7ad00 x0 :
> ffff6828c7f918f0
> [  176.300889] Call trace:
> [  176.301123]  br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
> [  176.301411]  br_nf_post_routing+0x2a8/0x3e4 [br_netfilter]
> [  176.301703]  nf_hook_slow+0x48/0x124
> [  176.302060]  br_forward_finish+0xc8/0xe8 [bridge]
> [  176.302371]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
> [  176.302605]  br_nf_forward_finish+0x118/0x22c [br_netfilter]
> [  176.302824]  br_nf_forward_ip.part.0+0x264/0x290 [br_netfilter]
> [  176.303136]  br_nf_forward+0x2b8/0x4e0 [br_netfilter]
> [  176.303359]  nf_hook_slow+0x48/0x124
> [  176.303803]  __br_forward+0xc4/0x194 [bridge]
> [  176.304013]  br_flood+0xd4/0x168 [bridge]
> [  176.304300]  br_handle_frame_finish+0x1d4/0x5c4 [bridge]
> [  176.304536]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
> [  176.304978]  br_nf_pre_routing_finish+0x29c/0x494 [br_netfilter]
> [  176.305188]  br_nf_pre_routing+0x250/0x524 [br_netfilter]
> [  176.305428]  br_handle_frame+0x244/0x3cc [bridge]
> [  176.305695]  __netif_receive_skb_core.constprop.0+0x33c/0xecc
> [  176.306080]  __netif_receive_skb_one_core+0x40/0x8c
> [  176.306197]  __netif_receive_skb+0x18/0x64
> [  176.306369]  process_backlog+0x80/0x124
> [  176.306540]  __napi_poll+0x38/0x17c
> [  176.306636]  net_rx_action+0x124/0x26c
> [  176.306758]  __do_softirq+0x100/0x26c
> [  176.307051]  ____do_softirq+0x10/0x1c
> [  176.307162]  call_on_irq_stack+0x24/0x4c
> [  176.307289]  do_softirq_own_stack+0x1c/0x2c
> [  176.307396]  do_softirq+0x54/0x6c
> [  176.307485]  __local_bh_enable_ip+0x8c/0x98
> [  176.307637]  __dev_queue_xmit+0x22c/0xd28
> [  176.307775]  neigh_resolve_output+0xf4/0x1a0
> [  176.308018]  ip_finish_output2+0x1c8/0x628
> [  176.308137]  ip_do_fragment+0x5b4/0x658
> [  176.308279]  ip_fragment.constprop.0+0x48/0xec
> [  176.308420]  __ip_finish_output+0xa4/0x254
> [  176.308593]  ip_finish_output+0x34/0x130
> [  176.308814]  ip_output+0x6c/0x108
> [  176.308929]  ip_send_skb+0x50/0xf0
> [  176.309095]  ip_push_pending_frames+0x30/0x54
> [  176.309254]  raw_sendmsg+0x758/0xaec
> [  176.309568]  inet_sendmsg+0x44/0x70
> [  176.309667]  __sys_sendto+0x110/0x178
> [  176.309758]  __arm64_sys_sendto+0x28/0x38
> [  176.309918]  invoke_syscall+0x48/0x110
> [  176.310211]  el0_svc_common.constprop.0+0x40/0xe0
> [  176.310353]  do_el0_svc+0x1c/0x28
> [  176.310434]  el0_svc+0x34/0xb4
> [  176.310551]  el0t_64_sync_handler+0x120/0x12c
> [  176.310690]  el0t_64_sync+0x190/0x194
> [  176.311066] Code: f9402e61 79402aa2 927ff821 f9400023 (f9408860)
> [  176.315743] ---[ end trace 0000000000000000 ]---
> [  176.316060] Kernel panic - not syncing: Oops: Fatal exception in
> interrupt
> [  176.316371] Kernel Offset: 0x37e0e3000000 from 0xffff800080000000
> [  176.316564] PHYS_OFFSET: 0xffff97d780000000
> [  176.316782] CPU features: 0x0,88000203,3c020000,0100421b
> [  176.317210] Memory Limit: none
> [  176.317527] ---[ end Kernel panic - not syncing: Oops: Fatal
> Exception in interrupt ]---\
> 
> Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> ---
>  net/bridge/br_netfilter_hooks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index 0e8bc0ea6175..1d458e9da660 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -33,6 +33,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <net/addrconf.h>
> +#include <net/dst_metadata.h>
>  #include <net/route.h>
>  #include <net/netfilter/br_netfilter.h>
>  #include <net/netns/generic.h>
> @@ -879,6 +880,10 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
>  		return br_dev_queue_push_xmit(net, sk, skb);
>  	}
>  
> +	/* Fragmentation on metadata/template dst is not supported */
> +	if (unlikely(!skb_valid_dst(skb)))> +		goto drop;
> +
>  	/* This is wrong! We should preserve the original fragment
>  	 * boundaries by preserving frag_list rather than refragmenting.
>  	 */

This helper's name is a bit misleading. :) But looking at it, it seems
only metadata dsts are not considered valid, so looks good to me.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


