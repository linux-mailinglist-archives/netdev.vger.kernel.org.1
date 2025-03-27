Return-Path: <netdev+bounces-177886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78560A72978
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 05:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD0E3BDC46
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 04:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB81ADC86;
	Thu, 27 Mar 2025 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNSyuKHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E813DDAA
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743049939; cv=none; b=Mu9T/zeu1HcuIyKmChHMSVocsfYDe7od6c5Do5SfM/UioyICeIRuTCMgVM2e9BjdTvZ24BPmoX0cUDA89yozFZzsRYbOuFzyYPCA0onEAWVA9IKgLM5JuEyIsKx03GrW+jF0OkBQuWp1RYwBpqj8GIyLV1ht364Egpiz8pZRQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743049939; c=relaxed/simple;
	bh=IjDoPODoZHdPQOwtQhv74Qe61bklixu5H0lMgkqnACQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arzuEm5UZSMtoQ2RcaWn1j94HMZgqmJPhjh8cIgjIW7XMM9dm4vCKhTuAMjnU7CsbpwreFVgXrJvdQQUpluaBfmhok3+uxXBpvpyOXoI1+NQLBHkhBviMsh4YV/JEPBPvxhIGPgz9+waCJzMmcSzTLCvvr9Gcog5UzJKpqLqfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNSyuKHk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a304a8edso6070651cf.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743049936; x=1743654736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTdesDccjXUbgxYDpvbCzIfpZis0tj5LBuf65U+tkjA=;
        b=NNSyuKHkZcb+AiVIfp/YMCikxZWE8TFuysLzA3P4H6fiNL6mKzXGB8FGDsGr5j0WWs
         /u7QtG3srL0FapXu12CGA53WBycyBIhGl2GOHGI4c/CI6BzhV/feaap1ClJv5kKrrUVJ
         zYUq3hENVesXXMorpOXeH/SnX1+V7p3NAdDEktjyfMtKpj8ETs7nbUJ+067gjCai16+D
         lQyJjOzfOszNDNG0Z0CVk+EgQp8sMho6C0Xjj0ZXRusTb0Aan8JyAr1RveJsP6RgmyiD
         WcTckFAI87IJTXL4KJ6xKwjI45sqTqScmNL3Qtl3cjsYsBeHJnWL9eZr/M/tYdprRkq/
         Loyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743049936; x=1743654736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTdesDccjXUbgxYDpvbCzIfpZis0tj5LBuf65U+tkjA=;
        b=m7ule7vARt+j+iKzHYMR+vY4uYOEJ2YKRHJneCxQ/yBqudIWohsZ7iX2s6qPVG1TTe
         TSqvdVoQrN2JZquxWA2f2kJ0im+ZWC2zz7V3L4IcusqkEvhm8YEud47W9rietWn7hQjM
         b/HVhXF8gt3cd6HTjg3y2NqI7lG4jZQMOqZhJnSRbJO5Rb2AwRtmjpSZZ7Ytw9LJPknq
         dupV4rTUedV5GjqevmIpWbULxVtmynlsGuLhvptlPJ95YUQvN2mAxrMEtzqT15hivuIH
         OtF/rWBh7yXAexwkt9+rVeRG5cKs7y4WI0I2GdxLGxzRV4/v35SFBU8XdYzhep5CBIsZ
         T8kg==
X-Forwarded-Encrypted: i=1; AJvYcCXP1uOSQZwnDu3P1eUYcfkD6PSJ6m09G93hy/S6qOwDdd026EDe242xu6fU6mo+wC4MgL2MIEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBQ3u7u8PSta5SBohJKR3EGyWfJ8lPVoRsyEZ6+A9NEWJd277
	g/yTtyv5QtvjUdkjvIhEzkANDqusziCZZqnAgiiqR5a0Qsp1KAIcgDoiLpEuB1UW8UWTBbOhAHj
	R6a7Kl+uNlnm7EWePRuaCR5eu0KKtzZcPFamL
X-Gm-Gg: ASbGncu2hS9G5zoYIlGAlDnAMdLhxIMHnHg84fQbU8P/fD7jiUERCPwNpQVL3+SfRaI
	4qPH+skt0c02Fu74aL1HzgZGp9dbEaaNGpATyw83kciMWIeeaspcjlXy3oFVTTbtsk+K0iXoCFZ
	NR5grGATJ2m4AmhUjJKI6W5J8X
X-Google-Smtp-Source: AGHT+IERnNhAmQaXWozP24gk+YANmivm9J0wdDSS2u3qijMJLU77DqUXc+ntjYTdPL4UFPnHfx5G//MDoXpPHFq++Rc=
X-Received: by 2002:ac8:5804:0:b0:477:6ef6:12f with SMTP id
 d75a77b69052e-4776ef60476mr30471761cf.3.1743049935655; Wed, 26 Mar 2025
 21:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327015827.2729554-1-wangliang74@huawei.com>
In-Reply-To: <20250327015827.2729554-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Mar 2025 05:32:04 +0100
X-Gm-Features: AQ5f1Joxhw4ztvlbdG0Vp3cpx8XoHZe5qTySBW5Y-H2P_Ta_UWRHVUeUr_5eH4k
Message-ID: <CANn89iJn5gARyEPHeYxZxERpERdNKMngMcP1BbKrW9ebxB-tRw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed needed_headroom
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 2:48=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> When create ipip6 tunnel, if tunnel->parms.link is assigned to the previo=
us
> created tunnel device, the dev->needed_headroom will increase based on th=
e
> previous one.
>
> If the number of tunnel device is sufficient, the needed_headroom can be
> overflowed. The overflow happens like this:

How many stacked devices would be needed to reach this point ?

I thought we had a limit, to make sure we do not overflow the kernel stack =
?

>
>   ipip6_newlink
>     ipip6_tunnel_create
>       register_netdevice
>         ipip6_tunnel_init
>           ipip6_tunnel_bind_dev
>             t_hlen =3D tunnel->hlen + sizeof(struct iphdr); // 40
>             hlen =3D tdev->hard_header_len + tdev->needed_headroom; // 65=
496
>             dev->needed_headroom =3D t_hlen + hlen; // 65536 -> 0
>
> The value of LL_RESERVED_SPACE(rt->dst.dev) may be HH_DATA_MOD, that lead=
s
> to a small skb allocated in __ip_append_data(), which triggers a
> skb_under_panic:
>
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:209!
>   Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 24133 Comm: test Tainted: G W 6.14.0-rc7-00067-g76b6=
905c11fd-dirty #1
>   Tainted: [W]=3DWARN
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-=
0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:skb_panic+0x156/0x1d0
>   Call Trace:
>    <TASK>
>    skb_push+0xc8/0xe0
>    fou_build_udp+0x31/0x3a0
>    gue_build_header+0xf7/0x150
>    ip_tunnel_xmit+0x684/0x3660
>    sit_tunnel_xmit__.isra.0+0xeb/0x150
>    sit_tunnel_xmit+0x2e3/0x2930
>    dev_hard_start_xmit+0x1a6/0x7b0
>    __dev_queue_xmit+0x2fa9/0x4120
>    neigh_connected_output+0x39e/0x590
>    ip_finish_output2+0x7bb/0x1f00
>    __ip_finish_output+0x442/0x940
>    ip_finish_output+0x31/0x380
>    ip_mc_output+0x1c4/0x6a0
>    ip_send_skb+0x339/0x570
>    udp_send_skb+0x905/0x1540
>    udp_sendmsg+0x17c8/0x28f0
>    udpv6_sendmsg+0x17f1/0x2c30
>    inet6_sendmsg+0x105/0x140
>    ____sys_sendmsg+0x801/0xc70
>    ___sys_sendmsg+0x110/0x1b0
>    __sys_sendmmsg+0x1f2/0x410
>    __x64_sys_sendmmsg+0x99/0x100
>    do_syscall_64+0x6e/0x1c0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ---[ end trace 0000000000000000 ]---

Can you provide symbols ?

scripts/decode_stacktrace.sh is your friend.

>
> Fix this by add check for needed_headroom in ipip6_tunnel_bind_dev().
>
> Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c63f36709a642f801c5
> Fixes: c88f8d5cd95f ("sit: update dev->needed_headroom in ipip6_tunnel_bi=
nd_dev()")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/ipv6/sit.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 39bd8951bfca..1662b735c5e3 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1095,7 +1095,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *=
skb,
>
>  }
>
> -static void ipip6_tunnel_bind_dev(struct net_device *dev)
> +static int ipip6_tunnel_bind_dev(struct net_device *dev)
>  {
>         struct ip_tunnel *tunnel =3D netdev_priv(dev);
>         int t_hlen =3D tunnel->hlen + sizeof(struct iphdr);
> @@ -1134,7 +1134,12 @@ static void ipip6_tunnel_bind_dev(struct net_devic=
e *dev)
>                 WRITE_ONCE(dev->mtu, mtu);
>                 hlen =3D tdev->hard_header_len + tdev->needed_headroom;
>         }
> +
> +       if (t_hlen + hlen > U16_MAX)
> +               return -EOVERFLOW;
> +
>         dev->needed_headroom =3D t_hlen + hlen;
> +       return 0;
>  }
>
>  static void ipip6_tunnel_update(struct ip_tunnel *t,
> @@ -1452,7 +1457,9 @@ static int ipip6_tunnel_init(struct net_device *dev=
)
>         tunnel->net =3D dev_net(dev);
>         strcpy(tunnel->parms.name, dev->name);
>
> -       ipip6_tunnel_bind_dev(dev);
> +       err =3D ipip6_tunnel_bind_dev(dev);
> +       if (err)
> +               return err;
>
>         err =3D dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
>         if (err)
> --
> 2.34.1
>

