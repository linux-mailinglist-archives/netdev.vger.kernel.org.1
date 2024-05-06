Return-Path: <netdev+bounces-93737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D178BD048
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888B82819E3
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E01384B7;
	Mon,  6 May 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJzwo23S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56413D2AC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005772; cv=none; b=BBgAvcZAFuzvIIygcHdsKvADEopZez0Dd+enl9AAPdfYQxoL8DDSkIAH9Mdrjy25oetYP6ifGurenbL1G2bX7PMZvEvxo3/5fHucgyB+/CDNgqhFL7L+Cj+MXM06aZ291k3u2+NRK1voos3SuWSmW/9VDmgTYj5EEkUjNYZK3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005772; c=relaxed/simple;
	bh=qT1z1KiRV6DTRrTDv0BGHbZBh5p+n2z9jnWMVDm/zfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KahbO6d9F3OQHJPsiR0I4zMs412QJlCrYRdXAEfwzfZ8AWXVb2Ques/SMieNRwWaOiFammfxd18QxgHYGRtsoJW/1odLBMtUKdDip72PivxwH5zuZM8/SH2ylOJ5zHwzkulweGkNQNGiEa5D31/kmIt6altZdC0+5/5510Tmg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJzwo23S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715005769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FszTCKMS2ShL8nu4pHhlzn/7RjZBXVvqXmqTPCO46tY=;
	b=UJzwo23SXNRZDwpSSg0K8ah4Ee+Bs0ufri7B5NGdOAQvuGnuKj2GoRyLgol6kPkq1lCIqz
	60S75bEixJKN5ZCFVoSubV78qvbcKGXj+GxuXeM8C4RvoGR+ToH3uKPRsfZysudaGnDT7G
	filxln4+1CKJe9C/PMmcKfdFzN0IYX8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-zGgKHAm7ObGJ3Klx7JcdbA-1; Mon, 06 May 2024 10:29:28 -0400
X-MC-Unique: zGgKHAm7ObGJ3Klx7JcdbA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34ec75411d5so226205f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005767; x=1715610567;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FszTCKMS2ShL8nu4pHhlzn/7RjZBXVvqXmqTPCO46tY=;
        b=mBmyzSr55I5Fr0tmTCwo+6foj712IhauztJ2yOz+2uxuF+moBIRn0EE8VUIJv8Kt0V
         SZJ7guNAdXPsD/udJqwyNFYtHpDF9vNcBZwbRXo1E6y9sRY3HLEOvLtf/8s8JMjPyWju
         1+MvfVp1VG+S3hQsPVQerJ43r149GN+5A4jbuX/+AOFjmDOa1stJZlxg8JMaw41pjx5T
         pbZ0sJuMinQTCn5GtLv6TxrMS1C6RiM0/c/DYXO3pY1m6xvomF9BrOJoKVaQOvoBSpBC
         8XztaHaUZtr5KS88Wj5F/hQBm02/R0JPOudOPuzMxu93t8zpcbl0n26VALNyLz1KP4DJ
         KBTA==
X-Gm-Message-State: AOJu0Yz6Zuu76DkcOVFCKyY+CnN/7F1KMybcFmTq1hrVwugnxUOSRZ6M
	+hyBq5MZCgP5XGHjyf2lF4Fp0CzrX+PNZiVPuIJq8GGmldQ6cF2qB9hvic1ZuUKL24Vxt7zd7/f
	SN+uOXRBARNHaHx4uBwG2y/qc+6DgWAX0Nde8x2Dl/RxMrq574ywx8g==
X-Received: by 2002:a05:6000:e47:b0:34c:9a04:4667 with SMTP id dy7-20020a0560000e4700b0034c9a044667mr6606744wrb.4.1715005767338;
        Mon, 06 May 2024 07:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyMclVKgt0fWg6w9fuGAG/E0p9Yt0AcayhwoztN3Qz/q2MrWa82AxOGybIrYJyP/aTfJj7ww==
X-Received: by 2002:a05:6000:e47:b0:34c:9a04:4667 with SMTP id dy7-20020a0560000e4700b0034c9a044667mr6606723wrb.4.1715005766915;
        Mon, 06 May 2024 07:29:26 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b0034e0ff3e6dasm10800476wri.93.2024.05.06.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:29:26 -0700 (PDT)
Message-ID: <89182ff5dc9d7fbbb065577c04cf595e4931d70f.camel@redhat.com>
Subject: Re: [PATCH net-next] mptcp: fix possible NULL dereferences
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
 <syzkaller@googlegroups.com>, Jason Xing <kernelxing@tencent.com>, Matthieu
 Baerts <matttbe@kernel.org>
Date: Mon, 06 May 2024 16:29:24 +0200
In-Reply-To: <20240506123032.3351895-1-edumazet@google.com>
References: <20240506123032.3351895-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-06 at 12:30 +0000, Eric Dumazet wrote:
> subflow_add_reset_reason(skb, ...) can fail.

whooops... yes, indeed.=20

> We can not assume mptcp_get_ext(skb) always return a non NULL pointer.
>=20
> syzbot reported:
>=20
> general protection fault, probably for non-canonical address 0xdffffc0000=
000003: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 PID: 5098 Comm: syz-executor132 Not tainted 6.9.0-rc6-syzkaller-01=
478-gcdc74c9d06e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
>  RIP: 0010:subflow_v6_route_req+0x2c7/0x490 net/mptcp/subflow.c:388
> Code: 8d 7b 07 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c0 01 00 0=
0 0f b6 43 07 48 8d 1c c3 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20=
 84 c0 0f 85 84 01 00 00 0f b6 5b 01 83 e3 0f 48 89
> RSP: 0018:ffffc9000362eb68 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888022039e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88807d961140 R08: ffffffff8b6cb76b R09: 1ffff1100fb2c230
> R10: dffffc0000000000 R11: ffffed100fb2c231 R12: dffffc0000000000
> R13: ffff888022bfe273 R14: ffff88802cf9cc80 R15: ffff88802ad5a700
> FS:  0000555587ad2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f420c3f9720 CR3: 0000000022bfc000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   tcp_conn_request+0xf07/0x32c0 net/ipv4/tcp_input.c:7180
>   tcp_rcv_state_process+0x183c/0x4500 net/ipv4/tcp_input.c:6663
>   tcp_v6_do_rcv+0x8b2/0x1310 net/ipv6/tcp_ipv6.c:1673
>   tcp_v6_rcv+0x22b4/0x30b0 net/ipv6/tcp_ipv6.c:1910
>   ip6_protocol_deliver_rcu+0xc76/0x1570 net/ipv6/ip6_input.c:438
>   ip6_input_finish+0x186/0x2d0 net/ipv6/ip6_input.c:483
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
>   __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5739
>   netif_receive_skb_internal net/core/dev.c:5825 [inline]
>   netif_receive_skb+0x1e8/0x890 net/core/dev.c:5885
>   tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
>   tun_get_user+0x2f35/0x4560 drivers/net/tun.c:2002
>   tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
>   call_write_iter include/linux/fs.h:2110 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xa84/0xcb0 fs/read_write.c:590
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Fixes: 3e140491dd80 ("mptcp: support rstreason for passive reset")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


