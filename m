Return-Path: <netdev+bounces-108965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F04926643
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4121F22CF7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597271822EC;
	Wed,  3 Jul 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJGCoZ3E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB917995
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024861; cv=none; b=Fdhl0dDWXoVjC5c5o5HSce5V1v9CuGH4CO4l0l3PSj9idvfqZuxTNyOlIVp63k+odrpHI1WBjEa1+nqN3GpbTPNI5flkRxfoWjgm0vWPFJHm4CMEauwlYA4urITS6+F/kMwWSaM/Ww8qDSWyHowkIZCe5feAqj8SuHQomh25GPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024861; c=relaxed/simple;
	bh=79BrRLdiZfItmEzkSMMuHLfKxWc5wOh4+yAMova779Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esM5lsn0cAv5RDHOgQUl9O6QOigDlKiE8gcm4qiNQxyraUVQSEj/qYKRdsl44G7iloTgJyYjWbjPb+82xooBrGyCmsmflRrWD63yPwcXGe7U1bvROYSiKuwRP/LTL4uEfrtUAcIwhdD8SfD3+q7GD+h0S5VV76DKF9DS5BIfgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJGCoZ3E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720024858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjcYMTjxU9kW8nOnuCfG73hNuxho2zHE2PKN/EiOn/o=;
	b=iJGCoZ3EVYkdmtUDyRQmZu/JDorwZvpRAOgaqLWf098PKceKXmFsz+jJLyMU9uFO7ziMwo
	mg6ohPySNLExkTUbo8/W/3ZhJ6yIzsCKiqBhFN5V+xyKN7PBYnPNkiXvZNd6jn0xM6tcw9
	4lVHUXx5D3AiMblzeZIqgeEwIWEuris=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-O4pLmMeLObCG4HGK2Um7yA-1; Wed, 03 Jul 2024 12:40:57 -0400
X-MC-Unique: O4pLmMeLObCG4HGK2Um7yA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee7a53e7cfso14957071fa.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024855; x=1720629655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjcYMTjxU9kW8nOnuCfG73hNuxho2zHE2PKN/EiOn/o=;
        b=id7EtJEg9a/ecQro2MQ3AOiX1+L7ZHIA0GgcD8xXJQ88vwjS+pQs1tPSmDiU7EyCv+
         INQw5USxgGV35i041xVqb3hD8UxcN8U1ZDwtb7+AE1axXZpuobA3BWZvIMOH4OVkME1G
         7I1TBLYN8hGXzmFk6LYLKmp4J0mMA6mfBkrSS0dTkq/GJro8JeM3U4hWPFHR/DyLwRCf
         Q7vRjutScX1hjYdfDAJRgcqMfObBaZV/g3oUHHoMUgEk43BqQMFTpkxeVoM1reu7jMIe
         QCremhXITvBVaFp96kX8vYJkzd08+5M4wRm0mNb0FL3xELsqyfCBXI+KEqc5dpM3O00b
         eMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtkg11ekYtnNIQGsa8Nm/+iNEX5cJf5JI4PMFI1aXJfzbOVNM1B/6jbaqZzAK9KbPqtKEg20Eh23q2XJnRhEPI96fbeDjA
X-Gm-Message-State: AOJu0YyIOVFg/FakK5ltKMul5CLPvPuFQeYctuxd6yHWWjyraa4bJIlH
	6tO5O89aegBBHP/yihY17et8gwSPPDZFx/HP3+rOYHR2MeBSEMv4vfguUzM2kpl9tQoDTNr4Y69
	GSEjl2LHzrMy1OAMufGPAy9m7v09+F+3NtFwLxlcjbP9UuT/OsQ5U1w==
X-Received: by 2002:a05:651c:49b:b0:2eb:d9a3:2071 with SMTP id 38308e7fff4ca-2ee5e6c9cd8mr67067761fa.50.1720024855708;
        Wed, 03 Jul 2024 09:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvypbDJXalyTd6VQsSi89yawsHxOcoDakQlgNsNJ/JxTEK9+b9EQJj2/3nSKl7r1LNJEGU6w==
X-Received: by 2002:a05:651c:49b:b0:2eb:d9a3:2071 with SMTP id 38308e7fff4ca-2ee5e6c9cd8mr67066891fa.50.1720024852997;
        Wed, 03 Jul 2024 09:40:52 -0700 (PDT)
Received: from redhat.com ([31.187.78.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257c4e10d6sm173923055e9.30.2024.07.03.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:40:52 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:40:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: missing check virtio
Message-ID: <20240703123832-mutt-send-email-mst@kernel.org>
References: <20240613095448.27118-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613095448.27118-1-arefev@swemel.ru>

On Thu, Jun 13, 2024 at 12:54:48PM +0300, Denis Arefev wrote:
> Two missing check in virtio_net_hdr_to_skb() allowed syzbot
> to crash kernels again
> 
> 1. After the skb_segment function the buffer may become non-linear
> (nr_frags != 0), but since the SKBTX_SHARED_FRAG flag is not set anywhere
> the __skb_linearize function will not be executed, then the buffer will
> remain non-linear. Then the condition (offset >= skb_headlen(skb))
> becomes true, which causes WARN_ON_ONCE in skb_checksum_help.
> 
> 2. The struct sk_buff and struct virtio_net_hdr members must be
> mathematically related.
> (gso_size) must be greater than (needed) otherwise WARN_ON_ONCE.
> (remainder) must be greater than (needed) otherwise WARN_ON_ONCE.
> (remainder) may be 0 if division is without remainder.
> 
> offset+2 (4191) > skb_headlen() (1116)
> WARNING: CPU: 1 PID: 5084 at net/core/dev.c:3303 skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
> Modules linked in:
> CPU: 1 PID: 5084 Comm: syz-executor336 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
> Code: 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 52 01 00 00 44 89 e2 2b 53 74 4c 89 ee 48 c7 c7 40 57 e9 8b e8 af 8f dd f8 90 <0f> 0b 90 90 e9 87 fe ff ff e8 40 0f 6e f9 e9 4b fa ff ff 48 89 ef
> RSP: 0018:ffffc90003a9f338 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888025125780 RCX: ffffffff814db209
> RDX: ffff888015393b80 RSI: ffffffff814db216 RDI: 0000000000000001
> RBP: ffff8880251257f4 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000045c
> R13: 000000000000105f R14: ffff8880251257f0 R15: 000000000000105d
> FS:  0000555555c24380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002000f000 CR3: 0000000023151000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip_do_fragment+0xa1b/0x18b0 net/ipv4/ip_output.c:777
>  ip_fragment.constprop.0+0x161/0x230 net/ipv4/ip_output.c:584
>  ip_finish_output_gso net/ipv4/ip_output.c:286 [inline]
>  __ip_finish_output net/ipv4/ip_output.c:308 [inline]
>  __ip_finish_output+0x49c/0x650 net/ipv4/ip_output.c:295
>  ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
>  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>  ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
>  dst_output include/net/dst.h:451 [inline]
>  ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
>  iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
>  ipip6_tunnel_xmit net/ipv6/sit.c:1034 [inline]
>  sit_tunnel_xmit+0xed2/0x28f0 net/ipv6/sit.c:1076
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3545 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3561
>  __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4346
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  packet_xmit+0x257/0x380 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  __sys_sendto+0x255/0x340 net/socket.c:2190
>  __do_sys_sendto net/socket.c:2202 [inline]
>  __se_sys_sendto net/socket.c:2198 [inline]
>  __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

I suspect it's this one:

Fixes: 0f6925b3e8da ("virtio_net: Do not pull payload in skb->head")


Though if you can test kernel before that to make sure, that
would be nice.

I'm inclined to merge, crashing syzkaller is not nice.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  V1 -> V2: incorrect type in argument 2
>  include/linux/virtio_net.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4dfa9b69ca8d..d1d7825318c3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -56,6 +56,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	unsigned int thlen = 0;
>  	unsigned int p_off = 0;
>  	unsigned int ip_proto;
> +	u64 ret, remainder, gso_size;
>  
>  	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
>  		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> @@ -98,6 +99,16 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
>  		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
>  
> +		if (hdr->gso_size) {
> +			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
> +			ret = div64_u64_rem(skb->len, gso_size, &remainder);
> +			if (!(ret && (hdr->gso_size > needed) &&
> +						((remainder > needed) || (remainder == 0)))) {
> +				return -EINVAL;
> +			}
> +			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> +		}
> +
>  		if (!pskb_may_pull(skb, needed))
>  			return -EINVAL;
>  
> -- 
> 2.25.1


