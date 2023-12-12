Return-Path: <netdev+bounces-56554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3480F596
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E691F216B1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC72282FE;
	Tue, 12 Dec 2023 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6kMMMGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FFAA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:40:01 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425e63955f6so4160491cf.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702406401; x=1703011201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viSx5KAjkiBssAE5whgIVmPwBmoNdlAJybiQKEJTllw=;
        b=O6kMMMGfy4oFwgtN6JEFSncwi6d72dBqMuJvenVQctMIvmQVMYTNBVYixPLjJKekf3
         VBwxPCPYyVWCB/X403mig0XD+4WhkudymHB/zup4h4FdL8izSYGCVr2FTMp9SxydhGBy
         IQlo5+qx+yXa7mzic2Lrixl5GpGzi21R16QXbIad3711cxHs9fTrgA8ql/Cl+tqM4wh2
         0shyDKZZfWVfYV1T4+k/oUh5nrFz6Fhq4EieJyF9+4hBdQSnLpfNjbthNI5GmcMDSL8q
         GaoXTuMzSEsCqFNfcpfL6plTcVaww4LpmocS4XnCFR0JXuXIbd2lek16KtNGk7xKQDmA
         ul0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406401; x=1703011201;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=viSx5KAjkiBssAE5whgIVmPwBmoNdlAJybiQKEJTllw=;
        b=kA9SXran/mQ7q72QYruZRTbp7Z8yW66G9Z+Ikm1/LlI05YPeMf0DSzRHAT0IsUwqke
         lR4rzD1XzgqN90JRivJrsCrJ5WmIPrNZFMWpZgYkc4nvi016dLI/AYgYP+g3oKyUcI5A
         qvlKersbVQ1nKccRjG4aoF7jyrTiXNJLiY7HqCWZ2r5Vn2L7xfxoW8wYPgAJ95XGpmEa
         87Pyrt+oFpy2M/+VxuELxmglapxQojBcMPHHwAJTsllEGB8RHVuNL5aCGb0BhamOcdy3
         +9dYjgqeEe6LbhEgsIHX3ePs9uuEaMPBi70vZkzbInAx2P8bSQ4PDgfL8V90kyKgoJpV
         9dog==
X-Gm-Message-State: AOJu0YzudVqdO/0DZ1BIoztX5d6mycIU9eVW7fZJYANP2I6kks6Ab038
	0BnUeiRgwpzKsZ1ZHkcQzaA=
X-Google-Smtp-Source: AGHT+IELMcS3LigWDGr2Jx3HyZygZkU5jZjNqx/Y69PYGH64VxuKevF4Jfb5Cwb0RSZNhoaObsgfaA==
X-Received: by 2002:a05:622a:1482:b0:425:94f0:eddf with SMTP id t2-20020a05622a148200b0042594f0eddfmr9209356qtx.38.1702406400754;
        Tue, 12 Dec 2023 10:40:00 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id f18-20020ac840d2000000b00423c95e5c44sm4259598qtm.97.2023.12.12.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:40:00 -0800 (PST)
Date: Tue, 12 Dec 2023 13:40:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6578a900227e6_2c0ecd29467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231212164621.4131800-1-edumazet@google.com>
References: <20231212164621.4131800-1-edumazet@google.com>
Subject: Re: [PATCH net] net: prevent mss overflow in skb_segment()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Once again syzbot is able to crash the kernel in skb_segment() [1]
> 
> GSO_BY_FRAGS is a forbidden value, but unfortunately the following
> computation in skb_segment() can reach it quite easily :
> 
> 	mss = mss * partial_segs;
> 
> 65535 = 3 * 5 * 17 * 257, so many initial values of mss can lead to
> a bad final result.
> 
> Make sure to limit segmentation so that the new mss value is smaller
> than GSO_BY_FRAGS.
> 
> [1]
> 
> general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 1 PID: 5079 Comm: syz-executor993 Not tainted 6.7.0-rc4-syzkaller-00141-g1ae4cd3cbdd0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:skb_segment+0x181d/0x3f30 net/core/skbuff.c:4551
> Code: 83 e3 02 e9 fb ed ff ff e8 90 68 1c f9 48 8b 84 24 f8 00 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 8a 21 00 00 48 8b 84 24 f8 00
> RSP: 0018:ffffc900043473d0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000010046 RCX: ffffffff886b1597
> RDX: 000000000000000e RSI: ffffffff886b2520 RDI: 0000000000000070
> RBP: ffffc90004347578 R08: 0000000000000005 R09: 000000000000ffff
> R10: 000000000000ffff R11: 0000000000000002 R12: ffff888063202ac0
> R13: 0000000000010000 R14: 000000000000ffff R15: 0000000000000046
> FS: 0000555556e7e380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020010000 CR3: 0000000027ee2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> udp6_ufo_fragment+0xa0e/0xd00 net/ipv6/udp_offload.c:109
> ipv6_gso_segment+0x534/0x17e0 net/ipv6/ip6_offload.c:120
> skb_mac_gso_segment+0x290/0x610 net/core/gso.c:53
> __skb_gso_segment+0x339/0x710 net/core/gso.c:124
> skb_gso_segment include/net/gso.h:83 [inline]
> validate_xmit_skb+0x36c/0xeb0 net/core/dev.c:3626
> __dev_queue_xmit+0x6f3/0x3d60 net/core/dev.c:4338
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> packet_snd net/packet/af_packet.c:3087 [inline]
> packet_sendmsg+0x24c6/0x5220 net/packet/af_packet.c:3119
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> __sys_sendto+0x255/0x340 net/socket.c:2190
> __do_sys_sendto net/socket.c:2202 [inline]
> __se_sys_sendto net/socket.c:2198 [inline]
> __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f8692032aa9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff8d685418 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8692032aa9
> RDX: 0000000000010048 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00000000000f4240 R08: 0000000020000540 R09: 0000000000000014
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff8d685480
> R13: 0000000000000001 R14: 00007fff8d685480 R15: 0000000000000003
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:skb_segment+0x181d/0x3f30 net/core/skbuff.c:4551
> Code: 83 e3 02 e9 fb ed ff ff e8 90 68 1c f9 48 8b 84 24 f8 00 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 8a 21 00 00 48 8b 84 24 f8 00
> RSP: 0018:ffffc900043473d0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000010046 RCX: ffffffff886b1597
> RDX: 000000000000000e RSI: ffffffff886b2520 RDI: 0000000000000070
> RBP: ffffc90004347578 R08: 0000000000000005 R09: 000000000000ffff
> R10: 000000000000ffff R11: 0000000000000002 R12: ffff888063202ac0
> R13: 0000000000010000 R14: 000000000000ffff R15: 0000000000000046
> FS: 0000555556e7e380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020010000 CR3: 0000000027ee2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

The partial_segs arithmetic was introduced in commit 802ab55adc39
("GSO: Support partial segmentation offload") in v4.7, but the
referenced commit was introduced in v4.8, hence that is where the
bug starts.

> ---
>  net/core/skbuff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea88745f9a2ae547d39fdf7e622627..83af8aaeb893b1a89bc034ee0d034d4f96318c6f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4522,8 +4522,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		/* GSO partial only requires that we trim off any excess that
>  		 * doesn't fit into an MSS sized block, so take care of that
>  		 * now.
> +		 * Cap len to not accidentally hit GSO_BY_FRAGS.
>  		 */
> -		partial_segs = len / mss;
> +		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;

Elegant one liner :)


