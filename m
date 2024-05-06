Return-Path: <netdev+bounces-93760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC878BD1AF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16301C21773
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5685155341;
	Mon,  6 May 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcRV5Lvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F02F2C
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010136; cv=none; b=phy11bvzHTnaomkuhSXb0bArhLOChHlBegQ0T+fc97A4MOqDQLJxbdKHrzko/UNT0sOfHg3qQlSYHla3l5rJetX5mszbxhKmCOXcg1JQxFEzDF8WKNK8SvTVFVqpWrNsjrzCpBLrK+ySm2SVH71MWI7iYWiw83Zv28cZ8/fY/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010136; c=relaxed/simple;
	bh=zsOFrBAqoGkNmU0tZ029hHA4jIlIb5IqcmzTMzaskY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gtj8QpLFs2WjeOQ/WeFa8+nEU9REIq48ox4HL3FMQLZn5XV4m7HrE897gfhghU4+9anVkYXYSij6DbN/uEJ2FED7SY9i84Bcp6dTth/+gHze0pxSpMQo019jpLMZbqmfjDFkpr3KuEpd1xET07EOFX8Tx0TqbWh6KCDhJwrRSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcRV5Lvx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59e4136010so32454966b.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715010133; x=1715614933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiJOBjP8PaFGBAr4xA2D7N9Pe03jnZWmN9AkTbIxC1I=;
        b=mcRV5LvxqBu5AJr2++kcLOS2mUX2WFQ3R0BA0dQvukqICcaYoRDrMrab7RWYzfJN9K
         65gVvhPUJNOfqbyDril5B8O0nyLK0qW7Qsy3wUlY75Ha21oK7mufIfV/QVHXDpaQFKLd
         xkyOiJAXm9ZHAevpdog+sjuUGMx0NRluXvnTolpvRJ1JbaVH9zE+DLN9cznwa1bKjhST
         VdopcvM0bJq/oVVW1m2tmEE3kXImbh20BGskg8t3KVHtETjTj3YCtP1QQDUZP3YdOmIf
         iv6wq/rtAjFJw7q/9vz3GU8vNzBGItcD6uLtMwkcnjwwIL3ZAtoXwMeSgDwPQcpOA4lM
         k1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010133; x=1715614933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiJOBjP8PaFGBAr4xA2D7N9Pe03jnZWmN9AkTbIxC1I=;
        b=M0Utrs1wc9YRlNm/Qd8Jh/Mqtt1UMYjmgw6MobJcohBxjhoxjDRT/sc9PqDgZ9Fdv6
         AyNtiajYMr/aspdUgSm6Hc9HKjxekdTwraf5v1OSrU320ueeCWiLtw+snvN/xAmKcuoK
         ksU6xuwxGD3+m/jm8kxzTk6ciVOfaeKd9GPuQpdFp36G6J3fRyBi/8SZGbNpQq5Cgofm
         luZCDLIVmREiMb5AEIYDNNs7Z8SBAdr3uZ6ATxp3Q5IqBspIL5z1cMBtVlmQDkmVmHad
         CqT1MU3N9S3nFdySZCOMMh1MVVaqsZvJehiIoGuc6VIw/M75LYAG2hWtjP5Tx7uscMp2
         +2nw==
X-Forwarded-Encrypted: i=1; AJvYcCV0f5z6OhdGsU96QXduzkiVYej/NacwiE3M9wuiUzIfL2hvRCNBAPwvUw+xCs2OeJZpSQwMwlya6rsNPp9uv7rOCyVrRNgU
X-Gm-Message-State: AOJu0YxY+M4mdIOyjiRGVUNR4DdGZaQoAejHu/f048GGddwQWRRBSlS/
	5ZayUUjJM29jKimFAK+ykUcMmw3yJ3HbbVa5nN9scc9iu1gVRIFDn+8WPiylCKvyu8iKNHQcvqG
	b1xnRmZnRc25EYgRp3HVGLf4uo6Q=
X-Google-Smtp-Source: AGHT+IGdsiQ/qgFxuMGBwum9ud8rTn8iuUpAa+5yPSvVJUu9ajnkYA6D2h6579j1EaZJvw75P5O7szOp28pqO4u95Uc=
X-Received: by 2002:a17:907:9493:b0:a59:bacc:b082 with SMTP id
 dm19-20020a170907949300b00a59baccb082mr3136428ejc.60.1715010133110; Mon, 06
 May 2024 08:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506123032.3351895-1-edumazet@google.com>
In-Reply-To: <20240506123032.3351895-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 May 2024 23:41:36 +0800
Message-ID: <CAL+tcoAkBbP1QdUtHAVzeq4c4YaiuHU-uqgiUOXwDKrJhu2oMQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix possible NULL dereferences
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jason Xing <kernelxing@tencent.com>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> subflow_add_reset_reason(skb, ...) can fail.
>
> We can not assume mptcp_get_ext(skb) always return a non NULL pointer.
>
> syzbot reported:
>
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
>
> Fixes: 3e140491dd80 ("mptcp: support rstreason for passive reset")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

Sorry, and thank you for the fix.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/mptcp/subflow.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 97ec44d1df308f53e8ebabe6f77c8c86859b5a36..7208d824be353476496271e97=
1ccafde1a47b959 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -287,6 +287,16 @@ int mptcp_subflow_init_cookie_req(struct request_soc=
k *req,
>  }
>  EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
>
> +static enum sk_rst_reason mptcp_get_rst_reason(const struct sk_buff *skb=
)
> +{
> +       const struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +
> +       if (!mpext)
> +               return SK_RST_REASON_NOT_SPECIFIED;
> +
> +       return sk_rst_convert_mptcp_reason(mpext->reset_reason);
> +}
> +
>  static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>                                               struct sk_buff *skb,
>                                               struct flowi *fl,
> @@ -308,13 +318,9 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie) {
> -               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> -               enum sk_rst_reason reason;
> -
> -               reason =3D sk_rst_convert_mptcp_reason(mpext->reset_reaso=
n);
> -               tcp_request_sock_ops.send_reset(sk, skb, reason);
> -       }
> +       if (!req->syncookie)
> +               tcp_request_sock_ops.send_reset(sk, skb,
> +                                               mptcp_get_rst_reason(skb)=
);
>         return NULL;
>  }
>
> @@ -381,13 +387,9 @@ static struct dst_entry *subflow_v6_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie) {
> -               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> -               enum sk_rst_reason reason;
> -
> -               reason =3D sk_rst_convert_mptcp_reason(mpext->reset_reaso=
n);
> -               tcp6_request_sock_ops.send_reset(sk, skb, reason);
> -       }
> +       if (!req->syncookie)
> +               tcp6_request_sock_ops.send_reset(sk, skb,
> +                                                mptcp_get_rst_reason(skb=
));
>         return NULL;
>  }
>  #endif
> @@ -923,7 +925,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         tcp_rsk(req)->drop_req =3D true;
>         inet_csk_prepare_for_destroy_sock(child);
>         tcp_done(child);
> -       reason =3D sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_=
reason);
> +       reason =3D mptcp_get_rst_reason(skb);
>         req->rsk_ops->send_reset(sk, skb, reason);
>
>         /* The last child reference will be released by the caller */
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
>

