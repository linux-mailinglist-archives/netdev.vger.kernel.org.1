Return-Path: <netdev+bounces-41518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC487CB2F1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D176E1C20983
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD728DCC;
	Mon, 16 Oct 2023 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfeZr3Ss"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC63398E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:56 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC626A2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:47:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2346a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697482073; x=1698086873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37xhMDI7DAPdqp0luTgCgbhoJZzrlanKYn4bNAqs/Aw=;
        b=YfeZr3Ssg3dDvXn3vVfjmZRFK1dvuiSuA8wZ403fPJSyUaTyqXrBVSLDi7GIv83eKt
         LxT6rX8fZfpKcOWbwBXz2AoynR050shfmFkvXopnFb/YY2DO///1VuZNBzBtSLL0y0rl
         kpvcJUAlvS1WPVPUs39xy3mYCCtZck9Iuc33W4agjwYkCet1dmKD6hBHg+O7HRDXokFr
         RVnI9OM+52WFu5EMm03Jl159QD69SvpWbQgboCWtV0uJnm6hetWqv/qikQij/fkKcEDj
         hykYmCKk3kCy0yXHFg4sBkS65/Iz2Cq0YQcT2+EugbRxQNeFyS13/qr3vByNgIJi/CtU
         YpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482073; x=1698086873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37xhMDI7DAPdqp0luTgCgbhoJZzrlanKYn4bNAqs/Aw=;
        b=VVeCzuV3PcAXvMD+mLdZJDusGOawZ5JChYHj0t3nBIZYEQH9HPMYzc9KpIktcxNpGg
         ezFPa5kVzsgvCHzH6+ctawDnx5F5vTwT1h1xC5v0sOqjkAT3cd304hWTGVN6xkK2u1TA
         Jv0J9nlzM31lbbiuvraUhrvMdPcrzxW+AosQ1M0CXl/iAA0ZHD3H6Fx30/HzhvlFcPA4
         R2AlxMs8V76WojMoSikYPkt8O/6aYElgZrcTjBSThZcVFQgSjYZJTtGuJAfG+vFMobAG
         SvhWoFQUDM2GH5jY/wLvOSRkhOe5xKHwds/ebCskfmivLWkNooSh67targOPOWOfWqz0
         oSeA==
X-Gm-Message-State: AOJu0YxUg41mkk62vToI5FHA2Z0eWMUZqdTX7UoqAvHly+ZerqYxfOKg
	0iAxxQl6DmMJihI+YpxgVwi91mt+ungHVfs8TIH5uQ==
X-Google-Smtp-Source: AGHT+IGpqWaO/87iWx2LqSOqQge4xeb0bSszwfgM8k0a2+d6yIJyTcj9zeJlhChAX3+JVX32tokHyk71fgNAdmh9IlA=
X-Received: by 2002:a50:ab5b:0:b0:53e:e94c:2891 with SMTP id
 t27-20020a50ab5b000000b0053ee94c2891mr9160edc.3.1697482073138; Mon, 16 Oct
 2023 11:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net> <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net> <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
 <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
 <CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=2ES69tTDJRziw@mail.gmail.com> <76a0c751-c827-4b6e-b27f-ced3ba2834fb@gmx.net>
In-Reply-To: <76a0c751-c827-4b6e-b27f-ced3ba2834fb@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 20:47:39 +0200
Message-ID: <CANn89i+6VuixihW4YyHntjj_GOKOOyXt8hHF8TJtB3bm07CZ6w@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 8:25=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Eric,
>
> Am 16.10.23 um 12:35 schrieb Eric Dumazet:
> > On Mon, Oct 16, 2023 at 11:49=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > Speaking of TSQ, it seems an old change (commit 75eefc6c59fd "tcp:
> > tsq: add a shortcut in tcp_small_queue_check()")
> > has been accidentally removed in 2017 (75c119afe14f "tcp: implement
> > rb-tree based retransmit queue")
> >
> > Could you try this fix:
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec84409=
28e22a290712f0b6b
> > 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
> >          return true;
> >   }
> >
> > +static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
> > +{
> > +       const struct rb_node *node =3D sk->tcp_rtx_queue.rb_node;
> > +
> > +       /* No skb in the rtx queue. */
> > +       if (!node)
> > +               return true;
> > +
> > +       /* Only one skb in rtx queue. */
> > +       return !node->rb_left && !node->rb_right;
> > +}
> > +
> >   /* TCP Small Queues :
> >    * Control number of packets in qdisc/devices to two packets / or ~1 =
ms.
> >    * (These limits are doubled for retransmits)
> > @@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock
> > *sk, const struct sk_buff *skb,
> >                  limit +=3D extra_bytes;
> >          }
> >          if (refcount_read(&sk->sk_wmem_alloc) > limit) {
> > -               /* Always send skb if rtx queue is empty.
> > +               /* Always send skb if rtx queue is empty or has one skb=
.
> >                   * No need to wait for TX completion to call us back,
> >                   * after softirq/tasklet schedule.
> >                   * This helps when TX completions are delayed too much=
.
> >                   */
> > -               if (tcp_rtx_queue_empty(sk))
> > +               if (tcp_rtx_queue_empty_or_single_skb(sk))
> >                          return false;
> >
> >                  set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
>
> This patch applied on top of Linux 6.1.49, TSO on, gso_max_size 65535,
> CONFIG_HZ_100=3Dy
>
> root@tarragon:/boot# iperf -t 10 -i 1 -c 192.168.1.129
> ------------------------------------------------------------
> Client connecting to 192.168.1.129, TCP port 5001
> TCP window size:  192 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.12 port 59714 connected with 192.168.1.129 port 500=
1
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 1.0 sec  11.5 MBytes  96.5 Mbits/sec
> [  3]  1.0- 2.0 sec  11.4 MBytes  95.4 Mbits/sec
> [  3]  2.0- 3.0 sec  11.1 MBytes  93.3 Mbits/sec
> [  3]  3.0- 4.0 sec  11.2 MBytes  94.4 Mbits/sec
> [  3]  4.0- 5.0 sec  11.1 MBytes  93.3 Mbits/sec
> [  3]  5.0- 6.0 sec  11.2 MBytes  94.4 Mbits/sec
> [  3]  6.0- 7.0 sec  11.2 MBytes  94.4 Mbits/sec
> [  3]  7.0- 8.0 sec  11.1 MBytes  93.3 Mbits/sec
> [  3]  8.0- 9.0 sec  11.4 MBytes  95.4 Mbits/sec
> [  3]  9.0-10.0 sec  11.2 MBytes  94.4 Mbits/sec
> [  3]  0.0-10.0 sec   113 MBytes  94.4 Mbits/sec
>
> The figures are comparable to disabling TSO -> Good
>
> Thanks

Great. I suspect a very slow TX completion from fec then.

Could you use the following bpftrace program while your iperf is running ?

.bpftrace -e '
k:__dev_queue_xmit {
 $skb =3D (struct sk_buff *)arg0;
 if ($skb->fclone =3D=3D 2) {
  @start[$skb] =3D nsecs;
 }
}
k:__kfree_skb {
 $skb =3D (struct sk_buff *)arg0;
 if ($skb->fclone =3D=3D 2 && @start[$skb]) {
  @tx_compl_usecs =3D hist((nsecs - @start[$skb])/1000);
  delete(@start[$skb]);
 }
}
END { clear(@start); }'

