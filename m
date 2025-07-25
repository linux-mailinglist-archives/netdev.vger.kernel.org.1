Return-Path: <netdev+bounces-209977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E588B11A5D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999D27A2B42
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBF23AB94;
	Fri, 25 Jul 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dMICZJHw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9B1FC3;
	Fri, 25 Jul 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433929; cv=none; b=UmeZktKtN8WsY/fJQxEaftZUKZ/nOHt6+eUUH75IlSWJuCHZF47s0C1GCdVEmGqz77WjAtbLFnjJjaC0X5bDlwsnFnfuu4Y2WbkeeIU5a+fzYaPP0T8SrPovwFmn21abfcpzO5ZsDgVh/P6xqcUJFIUtn2IPY4c5xn3RmYMgxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433929; c=relaxed/simple;
	bh=4LTyLSFeKZG/5mjRheEiVVRLUubuJ3GB+hnw/77AT38=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=nLusY3vrkrKrTM5S/yagubD+Igo+D+csdzFfOUjK6Dwv90vSQG4EZoQ+igbUBFmofYkzYozzfgLUxtrx5irLE6lDXUXWG7C5FWoKw1Lllocnv8xtuwNJlApPBEHmy+HqN/2x1ETeIiuMWYGfY8D8gLcDizoJvlyYto3lS4JZNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dMICZJHw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753433918; h=Message-ID:Subject:Date:From:To;
	bh=2zONHVbOrVEYTpfoXjB7Emp6IAtqz5Y9vPgnJgxc21k=;
	b=dMICZJHwSBSHevluguTCqQaSz4diBhJlmMiBRgkUbWYMXvuMKU2yEFCS8+gEW0qpw41WEa4buNPEuxWBEY4AQ9JMaXd6I6LAG+mZjyQ6JzGR6SKHtl+liW83UOq4EJ9WC32YzY7q2lvWBHj0EMjWU4LvmWakoe29gnv12bBlITw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wjx7BIn_1753433917 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 16:58:37 +0800
Message-ID: <1753433749.959542-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
Date: Fri, 25 Jul 2025 16:55:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: <yuehaibing@huawei.com>,
 <zhangchangzhong@huawei.com>,
 <wangliang74@huawei.com>,
 <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <pabeni@redhat.com>,
 <davem@davemloft.net>,
 <willemb@google.com>,
 <atenart@kernel.org>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
In-Reply-To: <20250724083005.3918375-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 24 Jul 2025 16:30:05 +0800, Wang Liang <wangliang74@huawei.com> wrote:
> When sending a packet with virtio_net_hdr to tun device, if the gso_type
> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
> size, below crash may happen.
>
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:4572!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   RIP: 0010:skb_pull_rcsum+0x8e/0xa0
>   Code: 00 00 5b c3 cc cc cc cc 8b 93 88 00 00 00 f7 da e8 37 44 38 00 f7 d8 89 83 88 00 00 00 48 8b 83 c8 00 00 00 5b c3 cc cc cc cc <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 000
>   RSP: 0018:ffffc900001fba38 EFLAGS: 00000297
>   RAX: 0000000000000004 RBX: ffff8880040c1000 RCX: ffffc900001fb948
>   RDX: ffff888003e6d700 RSI: 0000000000000008 RDI: ffff88800411a062
>   RBP: ffff8880040c1000 R08: 0000000000000000 R09: 0000000000000001
>   R10: ffff888003606c00 R11: 0000000000000001 R12: 0000000000000000
>   R13: ffff888004060900 R14: ffff888004050000 R15: ffff888004060900
>   FS:  000000002406d3c0(0000) GS:ffff888084a19000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000040 CR3: 0000000004007000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    udp_queue_rcv_one_skb+0x176/0x4b0 net/ipv4/udp.c:2445
>    udp_queue_rcv_skb+0x155/0x1f0 net/ipv4/udp.c:2475
>    udp_unicast_rcv_skb+0x71/0x90 net/ipv4/udp.c:2626
>    __udp4_lib_rcv+0x433/0xb00 net/ipv4/udp.c:2690
>    ip_protocol_deliver_rcu+0xa6/0x160 net/ipv4/ip_input.c:205
>    ip_local_deliver_finish+0x72/0x90 net/ipv4/ip_input.c:233
>    ip_sublist_rcv_finish+0x5f/0x70 net/ipv4/ip_input.c:579
>    ip_sublist_rcv+0x122/0x1b0 net/ipv4/ip_input.c:636
>    ip_list_rcv+0xf7/0x130 net/ipv4/ip_input.c:670
>    __netif_receive_skb_list_core+0x21d/0x240 net/core/dev.c:6067
>    netif_receive_skb_list_internal+0x186/0x2b0 net/core/dev.c:6210
>    napi_complete_done+0x78/0x180 net/core/dev.c:6580
>    tun_get_user+0xa63/0x1120 drivers/net/tun.c:1909
>    tun_chr_write_iter+0x65/0xb0 drivers/net/tun.c:1984
>    vfs_write+0x300/0x420 fs/read_write.c:593
>    ksys_write+0x60/0xd0 fs/read_write.c:686
>    do_syscall_64+0x50/0x1c0 arch/x86/entry/syscall_64.c:63
>    </TASK>
>
> To trigger gso segment in udp_queue_rcv_skb(), we should also set option
> UDP_ENCAP_ESPINUDP to enable udp_sk(sk)->encap_rcv. When the encap_rcv
> hook return 1 in udp_queue_rcv_one_skb(), udp_csum_pull_header() will try
> to pull udphdr, but the skb size has been segmented to gso size, which
> leads to this crash.

Is it correct to access the checksum of a segmented skb?

>
> Only udp has this probloem. Add check for the minimum value of gso size in
> virtio_net_hdr_to_skb().

Why tcp has not this problem?


>
> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> Fixes: 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in a tunnel")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  include/linux/virtio_net.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..0533101642bd 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -157,11 +157,13 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
>  		unsigned int nh_off = p_off;
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
> +		u16 min_gso_size = 0;
>
>  		switch (gso_type & ~SKB_GSO_TCP_ECN) {
>  		case SKB_GSO_UDP:
>  			/* UFO may not include transport header in gso_size. */
>  			nh_off -= thlen;
> +			min_gso_size = sizeof(struct udphdr) + 1;
>  			break;
>  		case SKB_GSO_UDP_L4:
>  			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> @@ -172,6 +174,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  				return -EINVAL;
>  			if (gso_type != SKB_GSO_UDP_L4)
>  				return -EINVAL;
> +			min_gso_size = sizeof(struct udphdr) + 1;

why +1?

Thanks.

>  			break;
>  		case SKB_GSO_TCPV4:
>  		case SKB_GSO_TCPV6:
> @@ -182,7 +185,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		}
>
>  		/* Kernel has a special handling for GSO_BY_FRAGS. */
> -		if (gso_size == GSO_BY_FRAGS)
> +		if ((gso_size == GSO_BY_FRAGS) || (gso_size < min_gso_size))
>  			return -EINVAL;
>
>  		/* Too small packets are not really GSO ones. */
> --
> 2.34.1
>

