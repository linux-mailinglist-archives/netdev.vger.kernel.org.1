Return-Path: <netdev+bounces-32340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E795794497
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ACF2814D3
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FA11193;
	Wed,  6 Sep 2023 20:32:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A972FB3
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 20:32:00 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C119B3
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:31:57 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5733789a44cso134645eaf.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694032317; x=1694637117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApDnZY/DKBpQHmjzQeP6kNqvtsXJj7rovndwy+8r1u4=;
        b=nq5fiwxt0+KB1JfhH0gCNRtQvk0nov1e4/IoKIpeLoT3d3oYWYZTjKq58MgU1vdW1r
         SN6JZvXeOZ9I6kfbPjE1HQJVp9dqvPqT0V7j+7mZTSYSTs8IRLB5/ahiMGQigAWsMvel
         oAjO8jzM5K9SopkYluWi9TiHjPCHDUOfIyT49Os6lX/a9+EUgLYc13KA5He3B1bguSEA
         8k75/5IoByCTHMJm5C2ZMz1I4qcorwQsz8KNGHvHGA8B0lsyyJurfq5Qro6NM9KKWYxR
         BAVX7HXbsdL2wRBG2iwRGp0IgERO1Bv1WzSexc4NEqf8wbviP0XHVgUQ0/B+bCx1A7ot
         aTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694032317; x=1694637117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApDnZY/DKBpQHmjzQeP6kNqvtsXJj7rovndwy+8r1u4=;
        b=FHrLFAIszdAFNYKqkD2gxI4oqYlcdFlGKqcYsVBg/jAg+5c9mUJpqjnYUD69HYotXJ
         7NHEEiIam1lF62YHbLEyRg+z/PM8GzRXL0EB908lEa7pMim0Zo8h2+VHmd3ZGWuY8oy9
         24Yp4tkMIRzTgZSuzbBmcmyRg6QGsI85uFwjuqG89PM6w8hChX9pwAEStfkXF1luwgNZ
         rKr7lrJuoiomdDq0mTjIeZoIDnxEXAnDQcgNudCEDX5HvRrUoMr6SiFUZMqB+cC5E9Fq
         rPaXvJ8bxVrO/qoAhQdXf0Exu8kZV/5xKdpmx/0XApjoV1BvT8f+wVgD1B9NvHutopto
         vEGQ==
X-Gm-Message-State: AOJu0Yxv/xmvvkPqGHOr4SafNPdgHZiDED0JofGC4V4iTezafdFtGoDo
	xoh31TX21fX1UFhNAcdcIxAheFnKiN10NXExEhakmA==
X-Google-Smtp-Source: AGHT+IHRTiKEPnQYlAcE6bAAEFN/5x2JBcz0eU3NqdXrTZV/aW2my9KLwl5TEFi8qtu4YEcd04R7sk3uA6BN+asHw18=
X-Received: by 2002:a05:6358:88f:b0:13a:d269:bd22 with SMTP id
 m15-20020a056358088f00b0013ad269bd22mr4143342rwj.25.1694032316618; Wed, 06
 Sep 2023 13:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
In-Reply-To: <20230906201046.463236-5-edumazet@google.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Wed, 6 Sep 2023 13:31:17 -0700
Message-ID: <CAK6E8=enK954aGeq0Rq8WDBJM8Rdp90_O=Rt_ax8bUHfStunOg@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 1:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This idea came after a particular workload requested
> the quickack attribute set on routes, and a performance
> drop was noticed for large bulk transfers.
>
> For high throughput flows, it is best to use one cpu
> running the user thread issuing socket system calls,
> and a separate cpu to process incoming packets from BH context.
> (With TSO/GRO, bottleneck is usually the 'user' cpu)
>
> Problem is the user thread can spend a lot of time while holding
> the socket lock, forcing BH handler to queue most of incoming
> packets in the socket backlog.
>
> Whenever the user thread releases the socket lock, it must first
> process all accumulated packets in the backlog, potentially
> adding latency spikes. Due to flood mitigation, having too many
> packets in the backlog increases chance of unexpected drops.
>
> Backlog processing unfortunately shifts a fair amount of cpu cycles
> from the BH cpu to the 'user' cpu, thus reducing max throughput.
>
> This patch takes advantage of the backlog processing,
> and the fact that ACK are mostly cumulative.
>
> The idea is to detect we are in the backlog processing
> and defer all eligible ACK into a single one,
> sent from tcp_release_cb().
>
> This saves cpu cycles on both sides, and network resources.
>
> Performance of a single TCP flow on a 200Gbit NIC:
>
> - Throughput is increased by 20% (100Gbit -> 120Gbit).
> - Number of generated ACK per second shrinks from 240,000 to 40,000.
> - Number of backlog drops per second shrinks from 230 to 0.
>
> Benchmark context:
>  - Regular netperf TCP_STREAM (no zerocopy)
>  - Intel(R) Xeon(R) Platinum 8481C (Saphire Rapids)
>  - MAX_SKB_FRAGS =3D 17 (~60KB per GRO packet)
>
> This feature is guarded by a new sysctl, and enabled by default:
>  /proc/sys/net/ipv4/tcp_backlog_ack_defer
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>

Looks great. Any reason any workload may want to switch this feature
off? I can't think of one...

> ---
>  Documentation/networking/ip-sysctl.rst |  7 +++++++
>  include/linux/tcp.h                    | 14 ++++++++------
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
>  net/ipv4/tcp_input.c                   |  8 ++++++++
>  net/ipv4/tcp_ipv4.c                    |  1 +
>  net/ipv4/tcp_output.c                  |  5 ++++-
>  7 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index a66054d0763a69d9e7cfae8e6242ac6d254e9169..5bfa1837968cee5eacafc77b2=
16729b495bf65b8 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -745,6 +745,13 @@ tcp_comp_sack_nr - INTEGER
>
>         Default : 44
>
> +tcp_backlog_ack_defer - BOOLEAN
> +       If set, user thread processing socket backlog tries sending
> +       one ACK for the whole queue. This helps to avoid potential
> +       long latencies at end of a TCP socket syscall.
> +
> +       Default : true
> +
>  tcp_slow_start_after_idle - BOOLEAN
>         If set, provide RFC2861 behavior and time out the congestion
>         window after an idle period.  An idle period is defined at
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 3c5efeeb024f651c90ae4a9ca704dcf16e4adb11..44d946161d4a7e52b05c196a1=
e1d37db25329650 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -463,15 +463,17 @@ enum tsq_enum {
>         TCP_MTU_REDUCED_DEFERRED,  /* tcp_v{4|6}_err() could not call
>                                     * tcp_v{4|6}_mtu_reduced()
>                                     */
> +       TCP_ACK_DEFERRED,          /* TX pure ack is deferred */
>  };
>
>  enum tsq_flags {
> -       TSQF_THROTTLED                  =3D (1UL << TSQ_THROTTLED),
> -       TSQF_QUEUED                     =3D (1UL << TSQ_QUEUED),
> -       TCPF_TSQ_DEFERRED               =3D (1UL << TCP_TSQ_DEFERRED),
> -       TCPF_WRITE_TIMER_DEFERRED       =3D (1UL << TCP_WRITE_TIMER_DEFER=
RED),
> -       TCPF_DELACK_TIMER_DEFERRED      =3D (1UL << TCP_DELACK_TIMER_DEFE=
RRED),
> -       TCPF_MTU_REDUCED_DEFERRED       =3D (1UL << TCP_MTU_REDUCED_DEFER=
RED),
> +       TSQF_THROTTLED                  =3D BIT(TSQ_THROTTLED),
> +       TSQF_QUEUED                     =3D BIT(TSQ_QUEUED),
> +       TCPF_TSQ_DEFERRED               =3D BIT(TCP_TSQ_DEFERRED),
> +       TCPF_WRITE_TIMER_DEFERRED       =3D BIT(TCP_WRITE_TIMER_DEFERRED)=
,
> +       TCPF_DELACK_TIMER_DEFERRED      =3D BIT(TCP_DELACK_TIMER_DEFERRED=
),
> +       TCPF_MTU_REDUCED_DEFERRED       =3D BIT(TCP_MTU_REDUCED_DEFERRED)=
,
> +       TCPF_ACK_DEFERRED               =3D BIT(TCP_ACK_DEFERRED),
>  };
>
>  #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.i=
csk_inet.sk)
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 7a41c4791536732005cedbb80c223b86aa43249e..d96d05b0881973aafd064ffa9=
418a22038bbfbf4 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -132,6 +132,7 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_syncookies;
>         u8 sysctl_tcp_migrate_req;
>         u8 sysctl_tcp_comp_sack_nr;
> +       u8 sysctl_tcp_backlog_ack_defer;
>         int sysctl_tcp_reordering;
>         u8 sysctl_tcp_retries1;
>         u8 sysctl_tcp_retries2;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 2afb0870648bc583504714c7d31d8fb0848e18c7..472c3953f40854f3ae85950ca=
dffcd0cb6c4f83c 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1366,6 +1366,15 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .proc_handler   =3D proc_dou8vec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
>         },
> +       {
> +               .procname       =3D "tcp_backlog_ack_defer",
> +               .data           =3D &init_net.ipv4.sysctl_tcp_backlog_ack=
_defer,
> +               .maxlen         =3D sizeof(u8),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dou8vec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>         {
>                 .procname       =3D "tcp_reflect_tos",
>                 .data           =3D &init_net.ipv4.sysctl_tcp_reflect_tos=
,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 06fe1cf645d5a386331548484de2beb68e846404..41b471748437b646709158339=
bd6f79719661198 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5553,6 +5553,14 @@ static void __tcp_ack_snd_check(struct sock *sk, i=
nt ofo_possible)
>             tcp_in_quickack_mode(sk) ||
>             /* Protocol state mandates a one-time immediate ACK */
>             inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOW) {
> +               /* If we are running from __release_sock() in user contex=
t,
> +                * Defer the ack until tcp_release_cb().
> +                */
> +               if (sock_owned_by_user_nocheck(sk) &&
> +                   READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_backlog_ack_d=
efer)) {
> +                       set_bit(TCP_ACK_DEFERRED, &sk->sk_tsq_flags);
> +                       return;
> +               }
>  send_now:
>                 tcp_send_ack(sk);
>                 return;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 27140e5cdc060ddcdc8973759f68ed612a60617a..f13eb7e23d03f3681055257e6=
ebea0612ae3f9b3 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3263,6 +3263,7 @@ static int __net_init tcp_sk_init(struct net *net)
>         net->ipv4.sysctl_tcp_comp_sack_delay_ns =3D NSEC_PER_MSEC;
>         net->ipv4.sysctl_tcp_comp_sack_slack_ns =3D 100 * NSEC_PER_USEC;
>         net->ipv4.sysctl_tcp_comp_sack_nr =3D 44;
> +       net->ipv4.sysctl_tcp_backlog_ack_defer =3D 1;
>         net->ipv4.sysctl_tcp_fastopen =3D TFO_CLIENT_ENABLE;
>         net->ipv4.sysctl_tcp_fastopen_blackhole_timeout =3D 0;
>         atomic_set(&net->ipv4.tfo_active_disable_times, 0);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b4cac12d0e6348aaa3a3957b0091ea7fe6553731..1fc1f879cfd6c28cd655bb8f0=
2eff6624eec2ffc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1077,7 +1077,8 @@ static void tcp_tasklet_func(struct tasklet_struct =
*t)
>  #define TCP_DEFERRED_ALL (TCPF_TSQ_DEFERRED |          \
>                           TCPF_WRITE_TIMER_DEFERRED |   \
>                           TCPF_DELACK_TIMER_DEFERRED |  \
> -                         TCPF_MTU_REDUCED_DEFERRED)
> +                         TCPF_MTU_REDUCED_DEFERRED |   \
> +                         TCPF_ACK_DEFERRED)
>  /**
>   * tcp_release_cb - tcp release_sock() callback
>   * @sk: socket
> @@ -1114,6 +1115,8 @@ void tcp_release_cb(struct sock *sk)
>                 inet_csk(sk)->icsk_af_ops->mtu_reduced(sk);
>                 __sock_put(sk);
>         }
> +       if ((flags & TCPF_ACK_DEFERRED) && inet_csk_ack_scheduled(sk))
> +               tcp_send_ack(sk);
>  }
>  EXPORT_SYMBOL(tcp_release_cb);
>
> --
> 2.42.0.283.g2d96d420d3-goog
>

