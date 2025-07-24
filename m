Return-Path: <netdev+bounces-209759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B1B10B60
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2C5A49DE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990172D8378;
	Thu, 24 Jul 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF0Rk5FR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C92D781B;
	Thu, 24 Jul 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363755; cv=none; b=hcDMOU1LQwlc3KjBNgF7zFoMs2yvmecNNOw8kArlJ0oqmlXtokB6Enl+c0EUIUnLa8ffGlpxR7h8zvHlBpKqVEe7FwXpqoxLVdIh/qW4i8mwjg4qVgdhQKGdvhsfJhpXaQC5WzwqpDtKlAoscGd9naGjWgTHCtJuUgX7kp03X6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363755; c=relaxed/simple;
	bh=Cj9MnC50yvMcr7qpr6ODtEBbyQQkaBD6ebd1FPGuXm4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=raPd1jUsKVM36LwS5qtOv3BUH7DJeqEytxtMUR7OQMr1gR3aOeC1l19eAUcSbR6luux6lSpuuFJj60MWLKus/0s/opINuJbzP0wa0boyXPFMuMvhVeR4YsqyyqzrGQvrs1zI3ctE5wIjWXzeILy9POiNSdtPSZ30wAmSGNtlO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF0Rk5FR; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8dd92e3eeeso766762276.1;
        Thu, 24 Jul 2025 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363752; x=1753968552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7VicNVu9AFEKDYxwUIR/N0jug2E5liWYp96M9vaDxE=;
        b=iF0Rk5FR/VjjJfqsLZmj9sOLsYw4v4/Qp4sOgWIbX2K3k/LqLTNIi83pC5Uv1jeaV2
         5F47c6dHAa3BzVeaX8rSY5/0eIGOD/VNpQ7fvyxuTMxt2wwTpshSc2rKAVBQtBdQEKEO
         uCAuuN7RsxhDhFTbUe3gPegfkohWx8DyDZD694ORPod3vBmv6/VQ0WENJ5DnSVZzEDQ0
         BeaFiHUz+UOjOsPVFGfQm7x+db6drDkR0L8hP9F7vaIFJBdtD44/yUys+103i1zePtdl
         ztUyQm4kjFaKlpnWz35LbZYCrkhEaCNyvUw2fWV3lsqRy1nHX6usCH9lErEXMjboNQBQ
         KqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363752; x=1753968552;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7VicNVu9AFEKDYxwUIR/N0jug2E5liWYp96M9vaDxE=;
        b=drrx1yJdxIkFQ2BFEC+2UWZYVNt+nuT2I7YHOm/7ki6lLwLMwRIxZtxRN7M1Ho7r4U
         bNjg9zzqHpZUoUqMEE1W50PzSdwOOK2r5zCAbnXc/OODATshoNPFmPZJjyOql1dl5rj+
         cXlqsJV3MnDmbBWwvfEAWtfawEDk9pY0d7IF6sD04a75++hdbotrUr1uapyE434LlJyw
         j2HUh3W2MOCcDgooQ6ftb+p4TSNnSeUpMgJyCcxx1cVJQSVCdqPI2UIA4JVP681d3cIR
         LV6Zi85+8yK403MjqmQHVuz2uid+WoVQBO92rblJ1jeR3TJkNuQ5IDKwY6Vrhpy7Dp/A
         3y7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSYmu8wNBwxHGbpPSzEf8X/8KJOoNSovcm4KrQNDraLuvWfMLtvTrER1loB3xBX7Ex7njQsLIX@vger.kernel.org, AJvYcCUa/Y1aUU6YxCjh8ZbdfRBEKGICmjmGAjPz7363HRehAT+myVNTEWkaLgS+ZUYczsQk0TsH1d5Q/ieKR8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedaM1Rdnp2eNkJc3848o8IfWutLNFEHJng+ynVDEnNhl4dYRB
	S1O0f8+B3vPor5WQzXI7m2cfngeZaYmvPLFzfY9B2XXFziOp9N6xxhXU
X-Gm-Gg: ASbGnctg1z0naJyf7mlIq+ZREtCt2BVNu1mIwrZUP0dyPokTB23TrIHtH9+Xb4I6lq1
	rtpEjBGlsb67Vi9mvaoPVRMlvVatvypPrkFG1IAlZ9N8D7nxf9uy1a3Nt2BXKWgAuryoYduxuxx
	YnwZDqC1rXq+fHehjHK6nE8NG1rsR9MJIT5/Z74D+C9uvn8HYWvdCIOmbmrxomHuGiOhzYOuVP2
	Hk+PGc2DUt8Y6f2c/BEz9wRhljorZeJV7eMB0YWn4Bsv7/SdejP4Ge1l/kvKspjE2BySPcCCklf
	m1t8VTTjaqLoNF2ionTWlSeNs3gF/hzo4ZQ4k4yuurabQo1cFNh4sTJuyoQhkrBhk+4HkiOB5M3
	b1XV9cHtTgthb8WKcyTuXZUvVB+5m7TlNK3OF/9bwofJhJkGvDV7/NaoMu4Ei0y3ujVp1AhnC6T
	eFyuMQ
X-Google-Smtp-Source: AGHT+IFA84cd5VFX/HDX39xkJCN9pDNl4VGa31XCOA5+ubhueT+T98heTeV9EwYLri1zF1YAIu7AIg==
X-Received: by 2002:a05:690c:6e0c:b0:719:559f:3320 with SMTP id 00721157ae682-719b41ffc11mr88229937b3.14.1753363752401;
        Thu, 24 Jul 2025 06:29:12 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8de76dba6esm116785276.13.2025.07.24.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:29:11 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:29:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 willemb@google.com, 
 atenart@kernel.org
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 wangliang74@huawei.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 steffen.klassert@secunet.com
Message-ID: <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250724083005.3918375-1-wangliang74@huawei.com>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in
 virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Liang wrote:
> When sending a packet with virtio_net_hdr to tun device, if the gso_type
> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
> size, below crash may happen.
> 
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:4572!

The BUG_ON hit:

	void *skb_pull_rcsum(struct sk_buff *skb, unsigned int len)
	{
		unsigned char *data = skb->data;

		BUG_ON(len > skb->len);

>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   RIP: 0010:skb_pull_rcsum+0x8e/0xa0

From udp_csum_pull_header

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
> 
> Only udp has this probloem. Add check for the minimum value of gso size in
> virtio_net_hdr_to_skb().
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
>  			break;
>  		case SKB_GSO_TCPV4:
>  		case SKB_GSO_TCPV6:
> @@ -182,7 +185,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		}
>  
>  		/* Kernel has a special handling for GSO_BY_FRAGS. */
> -		if (gso_size == GSO_BY_FRAGS)
> +		if ((gso_size == GSO_BY_FRAGS) || (gso_size < min_gso_size))

gso_size is the size of the segment payload, excluding the transport
header.

This is probably not the right approach.

Not sure how a GSO skb can be built that is shorter than even the
transport header. Maybe an skb_dump of the GSO skb can be elucidating.
>  			return -EINVAL;
>  
>  		/* Too small packets are not really GSO ones. */
> -- 
> 2.34.1
> 



