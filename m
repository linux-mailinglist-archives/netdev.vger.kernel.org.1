Return-Path: <netdev+bounces-215268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B171B2DD8D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057071C80A21
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA32E11B8;
	Wed, 20 Aug 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kloWcBFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCD27BF99
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695828; cv=none; b=Y6aeuBabgs2EpIMYzyNpMpUXIPH2/R8l8aiOFKOSamrljUW3ZhNA7B+i/h39FZjRl9R/F1OaNMjUb8nWFaCJyqlytzOfRyArG/3aJrvkEmhv+a06FEETDjH2+mMC3Gyc9gb3NfmG4Kt+TpkMvTFiKFJUrxz5yh4H0OVl4YeNKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695828; c=relaxed/simple;
	bh=VBz1KWhFCpG8jWrLgoBKbwZBD5H16rQ3iUyc84d5BWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdqEYx9AWXYS+SOa1bEviILLTH7zYC87xkZrVD7OpbxiTUsT4uYTYO727gYPs1hV4n15ZuhniVvXJmFY32cEPpgSerYRFt2w/5U94kE8mBOSG8X3sY7b7HfqJVudd366+nFIisuH1Pd0koXkv5KuGOm7skU6cJ3UuAiB7d9E7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kloWcBFc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109c6532fso65243581cf.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755695826; x=1756300626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLhF8h1sqXy3sl3VwtKNT/mJ1yJVmt1iTz/LotLfR2E=;
        b=kloWcBFcLmSJbsiHuyV02wDhLaA9xLszeK6Ov6c/N5O2gEVGHFELyRKutOk1EKEdQe
         cjWr+85Dv01/9lYcFS6UFH/EJGybpoDsD94g9JVg9TySS8Svj8EUXQwfxiWe5ul5PCc/
         eRrWha8vHvR+Al22vqXcPN/WOmzWwJE+NEN7mOytVbC5BF9Ldcn3VwOJSalRbzLcrLmX
         9+fEBALRJSyaOnIjHAAfjxTBb6oZn7ZXicOh6x0ntXB03PeS+dpvzCG8G2MQdXe3SpAH
         zKklsFdDqT1j+KnhUj6cAD6vSO2Vfz7V5Oo3CzqfG2y4OlJ/ReNd46WkHScNRy0Ozhzb
         kn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695826; x=1756300626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLhF8h1sqXy3sl3VwtKNT/mJ1yJVmt1iTz/LotLfR2E=;
        b=Xlg3aB6iIXNyV9ujUrN8LjHQZWEjTDLBvn6/X5X1GExFPWa5iJ/7S1kD4bQQ/fQtL9
         QGiTeliGaqlbVjZTf3sieuYC9SAJH7aeYVSCRPeULChPBDvCeJsQB2VhszbbKXRvaCoc
         WZHL7q3zgyUuNv6i7hTcEhmVJ69EJh39j9LEIhC4cJ6E+6U6L8PLOlQvz7nCSAKZDKQk
         DRRTfQiS2QUNqc54H0Cw9sMkR9EpIpXSTd985F3xzPwH4aiQt0HOZHYLoK4lOqJtg8hD
         mSiqxMXLPN1e7+3Me3jhv9YWzdLP/lODf9F+bXOHrpzxmQuR1jBVdiHG7FayXPgS7ege
         k2QA==
X-Gm-Message-State: AOJu0Ywqmh3dbQtd3OrKtxX32QdyMDtnSlpp07WlVyzd4FctLsWcgm7c
	GmE4JJuVgsO4PiIjsuVVNyyqaPZcuVW7l7l0NM4meo47DrJ5G1pmOpbUN7GLd86voTOwoTIUaTc
	nL+yX4KXELCt4/MEAm9mxlsJr2vYEH5epHvoZ1mQRLHqu1sF0d7++QjLPCV8=
X-Gm-Gg: ASbGncuzSEWM/4f2p09n1rjcq9Y1DY2hNsgbx04As1n8KdBTqEztrLMokny5/7Udiwd
	hj/P81hX7f5HIoGO6qFpRuaM9TPjJmfJp7XnjWJRuqJK7ChzjVFxLt+Q/TPK6SwZnPRyLX/NOVW
	L+sGZU3gt/lniX8NkPCkjyQekLVHpOQjRraOxV41HX1T8YORFI9WauN9A+QvyQS7soRWG8vazN7
	piozg615x7lHOwiTvWaUoSWfGuUbnR5m3E=
X-Google-Smtp-Source: AGHT+IFa83VqXeT0ie2ajR21WbocvR/2Bz8rM4LhXwoCUHU2FVbpTmSPqfLAprLGPUGGUdW6Pck4HNxdhSq6MmcIu8Y=
X-Received: by 2002:a05:622a:4c0d:b0:4b0:78fb:39da with SMTP id
 d75a77b69052e-4b291a970acmr40724321cf.21.1755695824952; Wed, 20 Aug 2025
 06:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820123707.10671-1-fw@strlen.de>
In-Reply-To: <20250820123707.10671-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 06:16:54 -0700
X-Gm-Features: Ac12FXzQjiSGePtH8Nfvv5F1MFLdawJfQS_iax-aouAf9UNAQdyMF4GaKRbuoiE
Message-ID: <CANn89i+EQTt8eaBT0=1U=1JjOb5K5_hH=OhESo9_1hnU5XZU1g@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nf_reject: don't leak dst refcount for
 loopback packets
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:37=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> recent patches to add a WARN() when replacing skb dst entry found an
> old bug:
>
> WARNING: include/linux/skbuff.h:1165 skb_dst_check_unset include/linux/sk=
buff.h:1164 [inline]
> WARNING: include/linux/skbuff.h:1165 skb_dst_set include/linux/skbuff.h:1=
210 [inline]
> WARNING: include/linux/skbuff.h:1165 nf_reject_fill_skb_dst+0x2a4/0x330 n=
et/ipv4/netfilter/nf_reject_ipv4.c:234
> [..]
> Call Trace:
>  nf_send_unreach+0x17b/0x6e0 net/ipv4/netfilter/nf_reject_ipv4.c:325
>  nft_reject_inet_eval+0x4bc/0x690 net/netfilter/nft_reject_inet.c:27
>  expr_call_ops_eval net/netfilter/nf_tables_core.c:237 [inline]
>  ..
>
> This is because blamed commit forgot about loopback packets.
> Such packets already have a dst_entry attached, even at PRE_ROUTING stage=
.
>
> Instead of checking hook just check if the skb already has a route
> attached to it.
>
> Fixes: f53b9b0bdc59 ("netfilter: introduce support for reject at prerouti=
ng stage")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Sending this instead of a pull request. the only other two
>  candidates for -net are still under review.
>
>  Let me know if you prefer a normal pull request even in this case.
>  Thanks!
>

Great, I was looking at an internal syzbot report with this exact issue.



WARNING: CPU: 1 PID: 5922 at ./include/linux/skbuff.h:1165
skb_dst_check_unset include/linux/skbuff.h:1164 [inline]
WARNING: CPU: 1 PID: 5922 at ./include/linux/skbuff.h:1165 skb_dst_set
include/linux/skbuff.h:1211 [inline]
WARNING: CPU: 1 PID: 5922 at ./include/linux/skbuff.h:1165
nf_reject6_fill_skb_dst net/ipv6/netfilter/nf_reject_ipv6.c:264
[inline]
WARNING: CPU: 1 PID: 5922 at ./include/linux/skbuff.h:1165
nf_send_unreach6+0x828/0xa20 net/ipv6/netfilter/nf_reject_ipv6.c:401
Modules linked in:
CPU: 1 UID: 0 PID: 5922 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT(=
full)
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 07/12/2025
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:skb_dst_check_unset include/linux/skbuff.h:1164 [inline]
RIP: 0010:skb_dst_set include/linux/skbuff.h:1211 [inline]
RIP: 0010:nf_reject6_fill_skb_dst
net/ipv6/netfilter/nf_reject_ipv6.c:264 [inline]
RIP: 0010:nf_send_unreach6+0x828/0xa20 net/ipv6/netfilter/nf_reject_ipv6.c:=
401
Code: 85 f6 74 0a e8 a9 6c 7a f7 e9 c8 fc ff ff e8 9f 6c 7a f7 4c 8b
7c 24 18 e9 34 fa ff ff e8 90 6c 7a f7 eb 9b e8 89 6c 7a f7 90 <0f> 0b
90 e9 c7 fb ff ff 48 85 db 0f 84 81 00 00 00 4c 8d a4 24 20
RSP: 0018:ffffc90000a083c0 EFLAGS: 00010246
RAX: ffffffff8a453fa7 RBX: ffff88802e6888c0 RCX: ffff88802fc3da00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a08568 R08: ffff888078550b83 R09: 1ffff1100f0aa170
R10: dffffc0000000000 R11: ffffed100f0aa171 R12: ffff888079bb4101
R13: dffffc0000000001 R14: 1ffff11005cd1123 R15: 0000000000000000
FS: 0000000000000000(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd4758e56c0 CR3: 00000000776ca000 CR4: 00000000003526f0
Call Trace:
<IRQ>
nft_reject_inet_eval+0x441/0x690 net/netfilter/nft_reject_inet.c:44
expr_call_ops_eval net/netfilter/nf_tables_core.c:237 [inline]
nft_do_chain+0x40c/0x1920 net/netfilter/nf_tables_core.c:285
nft_do_chain_inet+0x25d/0x340 net/netfilter/nft_chain_filter.c:161
nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
nf_hook include/linux/netfilter.h:273 [inline]
NF_HOOK+0x206/0x3a0 include/linux/netfilter.h:316
__netif_receive_skb_one_core net/core/dev.c:5979 [inline]
__netif_receive_skb+0xd3/0x380 net/core/dev.c:6092
process_backlog+0x60e/0x14f0 net/core/dev.c:6444
__napi_poll+0xc7/0x360 net/core/dev.c:7494
napi_poll net/core/dev.c:7557 [inline]
net_rx_action+0x707/0xe30 net/core/dev.c:7684
handle_softirqs+0x283/0x870 kernel/softirq.c:579
do_softirq+0xec/0x180 kernel/softirq.c:480
</IRQ>
<TASK>
__local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
wg_socket_send_skb_to_peer+0x16b/0x1d0 drivers/net/wireguard/socket.c:184
wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
process_one_work kernel/workqueue.c:3236 [inline]
process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
kthread+0x711/0x8a0 kernel/kthread.c:463
ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
</TASK>

