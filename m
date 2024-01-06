Return-Path: <netdev+bounces-62170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E909A826090
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2841C20849
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A5C847C;
	Sat,  6 Jan 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqa82TV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70B79CB
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 16:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4520C433C7;
	Sat,  6 Jan 2024 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704557432;
	bh=NGsTR5DQm++BEFKsnYywvV7P4USbV8+M0f444lNTMXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sqa82TV+FcH3FRnOLA4od5WdptH2VKd2I7p+kZqBn7VhdrtTfwBGlTS51MEVVY13H
	 tSLgZfaCtKv2rjZbE1rKI0EZLkWOpAJE6C36Y2cctyJqxzlcrXP1WAB62/Do7FJENx
	 RRvFtBe/4uYivQ2w8ni8VAdLn35KHBpEK2CAG/qK7t0lEwynQS9/71wLhLrCPhBUzn
	 HMbRODQ13rKXEH70qAGJhGL9McN7JQIE0yR9T3gV1iulv88gxIzgze+ssmHJgBvXeP
	 Vn+6q0C+abaNiPb3iU9f+/9basheKZGkbuQFzNMCf2HstDrrMFaamL4gaw0XgC+904
	 IuCIrzLMu+LUQ==
Message-ID: <adb52b11-0a7e-4c62-9516-d29aa88d75df@kernel.org>
Date: Sat, 6 Jan 2024 09:10:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip6_tunnel: fix NEXTHDR_FRAGMENT handling in
 ip6_tnl_parse_tlv_enc_lim()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
References: <20240105170313.2946078-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240105170313.2946078-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 10:03 AM, Eric Dumazet wrote:
> syzbot pointed out [1] that NEXTHDR_FRAGMENT handling is broken.
> 
> Reading frag_off can only be done if we pulled enough bytes
> to skb->head. Currently we might access garbage.
> 
> [1]
> BUG: KMSAN: uninit-value in ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ipxip6_tnl_xmit net/ipv6/ip6_tunnel.c:1326 [inline]
> ip6_tnl_start_xmit+0xab2/0x1a70 net/ipv6/ip6_tunnel.c:1432
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3548 [inline]
> dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
> __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> neigh_connected_output+0x569/0x660 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:542 [inline]
> ip6_finish_output2+0x23a9/0x2b30 net/ipv6/ip6_output.c:137
> ip6_finish_output+0x855/0x12b0 net/ipv6/ip6_output.c:222
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip6_output+0x323/0x610 net/ipv6/ip6_output.c:243
> dst_output include/net/dst.h:451 [inline]
> ip6_local_out+0xe9/0x140 net/ipv6/output_core.c:155
> ip6_send_skb net/ipv6/ip6_output.c:1952 [inline]
> ip6_push_pending_frames+0x1f9/0x560 net/ipv6/ip6_output.c:1972
> rawv6_push_pending_frames+0xbe8/0xdf0 net/ipv6/raw.c:582
> rawv6_sendmsg+0x2b66/0x2e70 net/ipv6/raw.c:920
> inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
> slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> slab_alloc_node mm/slub.c:3478 [inline]
> __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
> __do_kmalloc_node mm/slab_common.c:1006 [inline]
> __kmalloc_node_track_caller+0x118/0x3c0 mm/slab_common.c:1027
> kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
> pskb_expand_head+0x226/0x1a00 net/core/skbuff.c:2098
> __pskb_pull_tail+0x13b/0x2310 net/core/skbuff.c:2655
> pskb_may_pull_reason include/linux/skbuff.h:2673 [inline]
> pskb_may_pull include/linux/skbuff.h:2681 [inline]
> ip6_tnl_parse_tlv_enc_lim+0x901/0xbb0 net/ipv6/ip6_tunnel.c:408
> ipxip6_tnl_xmit net/ipv6/ip6_tunnel.c:1326 [inline]
> ip6_tnl_start_xmit+0xab2/0x1a70 net/ipv6/ip6_tunnel.c:1432
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3548 [inline]
> dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
> __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> neigh_connected_output+0x569/0x660 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:542 [inline]
> ip6_finish_output2+0x23a9/0x2b30 net/ipv6/ip6_output.c:137
> ip6_finish_output+0x855/0x12b0 net/ipv6/ip6_output.c:222
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip6_output+0x323/0x610 net/ipv6/ip6_output.c:243
> dst_output include/net/dst.h:451 [inline]
> ip6_local_out+0xe9/0x140 net/ipv6/output_core.c:155
> ip6_send_skb net/ipv6/ip6_output.c:1952 [inline]
> ip6_push_pending_frames+0x1f9/0x560 net/ipv6/ip6_output.c:1972
> rawv6_push_pending_frames+0xbe8/0xdf0 net/ipv6/raw.c:582
> rawv6_sendmsg+0x2b66/0x2e70 net/ipv6/raw.c:920
> inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 7345 Comm: syz-executor.3 Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> 
> Fixes: fbfa743a9d2a ("ipv6: fix ip6_tnl_parse_tlv_enc_lim()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>  net/ipv6/ip6_tunnel.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 5e80e517f071013410349d1fd93afc00a394e284..46c19bd4899011d53b4feb84e25013c01ddce701 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -399,7 +399,7 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>  	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
>  	unsigned int nhoff = raw - skb->data;
>  	unsigned int off = nhoff + sizeof(*ipv6h);
> -	u8 next, nexthdr = ipv6h->nexthdr;
> +	u8 nexthdr = ipv6h->nexthdr;
>  
>  	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
>  		struct ipv6_opt_hdr *hdr;
> @@ -410,25 +410,25 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>  
>  		hdr = (struct ipv6_opt_hdr *)(skb->data + off);
>  		if (nexthdr == NEXTHDR_FRAGMENT) {
> -			struct frag_hdr *frag_hdr = (struct frag_hdr *) hdr;
> -			if (frag_hdr->frag_off)
> -				break;
>  			optlen = 8;
>  		} else if (nexthdr == NEXTHDR_AUTH) {
>  			optlen = ipv6_authlen(hdr);
>  		} else {
>  			optlen = ipv6_optlen(hdr);
>  		}
> -		/* cache hdr->nexthdr, since pskb_may_pull() might
> -		 * invalidate hdr
> -		 */
> -		next = hdr->nexthdr;
> -		if (nexthdr == NEXTHDR_DEST) {
> -			u16 i = 2;
>  
> -			/* Remember : hdr is no longer valid at this point. */
> -			if (!pskb_may_pull(skb, off + optlen))

you dropped the comment above the may_pull which is helpful for reviewers.


Reviewed-by: David Ahern <dsahern@kernel.org>


