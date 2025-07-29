Return-Path: <netdev+bounces-210852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F68B151D4
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D207189E968
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E18286897;
	Tue, 29 Jul 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy60Tk+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F300204863;
	Tue, 29 Jul 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808995; cv=none; b=CTX0owAZnXQQZKJRwTp8sw7NZA6YROeXQfbJtlWX+ZSZhN0ogkSv1I6ONA18sdR+S+KcV950O9H+Fg6qCuoQTaKlk+cCMu6aGF2YouDjfGq1Tf6VPMW38MAvEIQ133Jcja9NELnJ5s1iLQpbykEC0SYz0VW68h+jYlyOs11gchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808995; c=relaxed/simple;
	bh=fpqxhzWJtHjAYGvLmCUdpdaNmXBiWP8n3lMQKxa+S6U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=skLZP0msvbHgejdcb/5V05TK1ODt3gptpuWVg69ywqGzwCxRQlrwdqo6HOjAHljdGCJ4MgILhz71ByIswYMC1tNVOFrmc1fyQQ0LrQkPwTM9GkNy3B7jkpyMxszkHvwmzXxGGaKDsLoEqtc7hPNwEHRZ/svm0GoEYIstimve1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy60Tk+v; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a34087749so10291327b3.2;
        Tue, 29 Jul 2025 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753808992; x=1754413792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHLIBiSL/KtnXCFPIH5IfZKEjXvqhs/FSKlHN+gsWGQ=;
        b=cy60Tk+vA5rMpFzfZDLdYy1DI+B138LY4q3b3RRm6jc8JhGhtlWKbjxHQ5W6o4yBV4
         N7AUtSAngjt2GjBQDFhNYoLZSH3zrrkG/ZoP12Nb51kKXkdvoRVYH5tC32lRc6Ebr7KO
         4/mPeNvwpFZJUkGS9AEsrera0iSNqcyf1/IqNLwWtrw1ugaPtb6cL9wyJzSgzK7q/v40
         nGVxwWp3GMRFbMZK5alpI225U5m0Yv00TrKIoplhXDuNt3W+b56l+h57xGgiQ0oipumf
         KX/4IC3QqcOAkKM5ApESQ82eStQm2avbBDb6TXyvnXANbZ+p0gM9WuuoG65BPpSeZFR/
         Fr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753808992; x=1754413792;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xHLIBiSL/KtnXCFPIH5IfZKEjXvqhs/FSKlHN+gsWGQ=;
        b=Sq5I0dOu971jw1GlIjot/V36TRUN8fJKChU1P+x2LwOxMbYM6uzGLKi+vtMTyXFP3u
         /y1wThy6Badk4EidXOLMw9C7AZrv1/o2r6v3xJkRN3opFj7C5e2LN0JUCd2aedeWWNsx
         1zAUSKVYDiGACfKz0CHd2daaTqn91QflFd+y0/EEF8tc2vvpkThqfyYwsw231FuqKsG7
         YaJ6/Nj1fidA2i24OZU63RTHNBDNV87PUQj97aD0z0Eegjy+IkdrJ4rwkX89KJ6scct4
         ESeyNKuhd4jIMtBrJwx/ReLLEWm4DAosmvn6TaGt+95RP776O8/7gEf4DmMGoP4cioaW
         ELcw==
X-Forwarded-Encrypted: i=1; AJvYcCUzTC/ZHZn9TlHg1zD6qK93hQcWS8rUqf+aOvvgTFATQazwqsTVV+Zx1ZDy3HyorIf3eaRrPVwi@vger.kernel.org, AJvYcCXcZrXWWHbMo3ASQvR/fqOq5L+At8GfTENy+KzE40Feit2uAXO5+rTKybPvv6qldRXM1TLXgcWLyBltiUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDRtIPk2hh1Jy1O3YGYMOl99sSfOSwYJFI+MJ9o3i4V+VkP+6
	moh0RVyOA3u5jWxAqqf+/tCyMpalXxE8nmXs/5UHOlHcT83QwPGQ22jW
X-Gm-Gg: ASbGncsmhRqel6w4ZMD4jiNgvIrHnKMN8lkl81fakTlrfZ3TSQzJACdC4rguupK5JT9
	1toOCcMvmGsVt24NERDo/7xo7KOfM/0OYjpSUIDrux4y/2qsPZ5pnrE0rLW+eM3ZBcrzXZhYjZR
	AZ7aGwQ07W2iVTFf215wWozL0TUQEnobVMIq7u6gpu2K/Qt1StOqPgwdEHwrkShFrkizQn52tTB
	0ATBmajCdndZKupEm5jEE1T6/ensBOZaVKg7FqMJ04lQ+ikN17Qjw50MsrexCfoLYxVvf+ogo0Y
	ZxvHoyDSoX8VHqiU6neo8SgqAvb2a7cHkRpvlBdoZ4Nm1CChFyGVlQ2xGWWTo/yIQxYJnGM2BeP
	RU8QvJk3NsSFmlE5xzCe8MZSnxxjJT+75WJrEF0PoQAiCnYXIWHb1ojbCxnkW60TzYCay8A==
X-Google-Smtp-Source: AGHT+IGKt1HTBUsA00vXgZZAeXtiTpikCp3sMNgA8JtHZT8O9Bose0puGZq4nc2U4ukixdxtD42JsQ==
X-Received: by 2002:a05:690c:4b08:b0:719:635b:a025 with SMTP id 00721157ae682-71a468f6d6amr9151107b3.26.1753808992316;
        Tue, 29 Jul 2025 10:09:52 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f21ae473sm19163377b3.33.2025.07.29.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:09:49 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:09:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 atenart@kernel.org
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 wangliang74@huawei.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6889005c9d7f1_1669652947@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250729123907.3318425-1-wangliang74@huawei.com>
References: <20250729123907.3318425-1-wangliang74@huawei.com>
Subject: Re: [RFC PATCH net v2] net: drop gso udp packets in udp_rcv_segment()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Can limit to drop UFO packets, as other GSO packets will get segmented
correctly.

Wang Liang wrote:
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
> 
> Previous commit cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> introduces segmentation in UDP receive path only for GRO, which was never
> intended to be used for UFO, so drop gso udp packets in udp_rcv_segment().
> 
> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> Fixes: 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in a tunnel")

Only one Fixes tag, to know where to backport too.

The segmentation on receive is introduced in the first commit. I'd
keep only that.

And please add a Link: to the email thread with the analysis of the
bug, your v1 (above the ---).

> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
> v1: https://lore.kernel.org/netdev/20250724083005.3918375-1-wangliang74@huawei.com/
> v2: Drop ufo packets instead of checking min gso size.
> ---
>  include/net/udp.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index a772510b2aa5..e3fcda71f6c1 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -587,6 +587,14 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
>  {
>  	netdev_features_t features = NETIF_F_SG;
>  	struct sk_buff *segs;
> +	int drop_count = 1;

This is rare, can move initialization into the branch.
> +
> +	/*
> +	 * Segmentation in UDP receive path is only for UDP GRO, drop udp
> +	 * fragmentation offload (UFO) packets.
> +	 */
> +	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP | SKB_GSO_UDP_L4))

Only SKB_GSO_UDP.

The purpose of this function is to correctly segment SKB_GSO_UDP_L4
packets.

> +		goto drop;
>  
>  	/* Avoid csum recalculation by skb_segment unless userspace explicitly
>  	 * asks for the final checksum values
> @@ -610,16 +618,18 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
>  	 */
>  	segs = __skb_gso_segment(skb, features, false);
>  	if (IS_ERR_OR_NULL(segs)) {
> -		int segs_nr = skb_shinfo(skb)->gso_segs;
> -
> -		atomic_add(segs_nr, &sk->sk_drops);
> -		SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, segs_nr);
> -		kfree_skb(skb);
> -		return NULL;
> +		drop_count = skb_shinfo(skb)->gso_segs;
> +		goto drop;
>  	}
>  
>  	consume_skb(skb);
>  	return segs;
> +
> +drop:
> +	atomic_add(drop_count, &sk->sk_drops);
> +	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
> +	kfree_skb(skb);
> +	return NULL;
>  }
>  
>  static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
> -- 
> 2.34.1
> 



