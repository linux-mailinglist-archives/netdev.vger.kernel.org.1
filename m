Return-Path: <netdev+bounces-35299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D41E7A8AB4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A03281196
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A13E49D;
	Wed, 20 Sep 2023 17:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B141A58F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:35:32 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C282BDD
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:35:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4051039701eso6005e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695231329; x=1695836129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38lJWdaw4dw/VjY/ObDAPYV/F6V32wUm16qcRUnFS7w=;
        b=XIKLlmF9hpYEkDIf3hWkQfLYMNMvU5HDWzE9s8+NeT5mgLK+NN77ec5dp92kJ31pPp
         uBCOalzy6/kEhZQdxWMGjrWLPO5xA28PdAp6E/ugVDnPCLaAwsOnCiJtsBeQRt1EPKLW
         Su/yzGdX+iTUWvTvgdyE9MzGDCkc5iPfjuZwaNS6y0FF7j4ViAYMcfPypwxpnt763AU8
         oFCXHXu3gUwiIFJFFbPnpl6VTSG4lYDIoADk06lw0B14rV6cXF6c9UjagdhDWnVE4m1P
         KKnAanHYo6NbFTaakPW+8kFh/Gpsgrxje0Sl6vpL9BnAR9w15vKMsPuIzn5N6kzsjoMN
         nM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695231329; x=1695836129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38lJWdaw4dw/VjY/ObDAPYV/F6V32wUm16qcRUnFS7w=;
        b=FnGVGV82V341gsdCIwErGe77xSYOSy41T8sjEmlqOgLuEWtzg2pp5ZKlqAiA73QWNB
         hWJSeh+9/TXCc/eeEIz23IwzkbnyCHUYJKVQ8WKgxpApFr0RYXzmq0LTC4sH8VGVeSpA
         pFKzmp4KQtaW+C8h/jhledwb3jF69npbQbzymFQE49VQ1ebNmFU0rJ26z6OrDHYeblRX
         ZOyVZQTlhGK+qV9qigh040ie5ntF819gB5hwartwqZD7IPIF3gZHfURJw7UXXcZhL3tz
         NIkydVnZhqxwU2fF/wprrFuCMBXn3yksl/3aTudCZKpYJNPqPGQIwhM8KNL0SBmhBdDn
         T0sw==
X-Gm-Message-State: AOJu0YyZlw7K8xOr7AVVgUcxD3aXH56i5rPSNa7L2ESTUotuvkqlVaMU
	tXGSkRfDYz8sO+RGickaF3TW4uVt2DWOYTLCMlCKsg==
X-Google-Smtp-Source: AGHT+IH/EwgyBdam9at5MuOW5M2W9QGi3kx9DD1GJCX9itH848+yWZW3l2rbKt+gbqt2iB57rWSqrkuJOelf1qu4M6s=
X-Received: by 2002:a05:600c:1d06:b0:3fe:d691:7d63 with SMTP id
 l6-20020a05600c1d0600b003fed6917d63mr121530wms.6.1695231328885; Wed, 20 Sep
 2023 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com> <20230920172943.4135513-4-edumazet@google.com>
In-Reply-To: <20230920172943.4135513-4-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Wed, 20 Sep 2023 13:34:52 -0400
Message-ID: <CACSApvZg8soR6bsMv9NqHST2+FLX2RFGRORY-DbTDfhCcUURBQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 1:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While BPF allows to set icsk->->icsk_delack_max

nit pick in the commit message:  redundant ->->.

> and/or icsk->icsk_rto_min, we have an ip route
> attribute (RTAX_RTO_MIN) to be able to tune rto_min,
> but nothing to consequently adjust max delayed ack,
> which vary from 40ms to 200 ms (TCP_DELACK_{MIN|MAX}).
>
> This makes RTAX_RTO_MIN of almost no practical use,
> unless customers are in big trouble.
>
> Modern days datacenter communications want to set
> rto_min to ~5 ms, and the max delayed ack one jiffie
> smaller to avoid spurious retransmits.
>
> After this patch, an "rto_min 5" route attribute will
> effectively lower max delayed ack timers to 4 ms.
>
> Note in the following ss output, "rto:6 ... ato:4"
>
> $ ss -temoi dst XXXXXX
> State Recv-Q Send-Q           Local Address:Port       Peer Address:Port =
 Process
> ESTAB 0      0        [2002:a05:6608:295::]:52950   [2002:a05:6608:297::]=
:41597
>      ino:255134 sk:1001 <->
>          skmem:(r0,rb1707063,t872,tb262144,f0,w0,o0,bl0,d0) ts sack
>  cubic wscale:8,8 rto:6 rtt:0.02/0.002 ato:4 mss:4096 pmtu:4500
>  rcvmss:536 advmss:4096 cwnd:10 bytes_sent:54823160 bytes_acked:54823121
>  bytes_received:54823120 segs_out:1370582 segs_in:1370580
>  data_segs_out:1370579 data_segs_in:1370578 send 16.4Gbps
>  pacing_rate 32.6Gbps delivery_rate 1.72Gbps delivered:1370579
>  busy:26920ms unacked:1 rcv_rtt:34.615 rcv_space:65920
>  rcv_ssthresh:65535 minrtt:0.015 snd_wnd:65536
>
> While we could argue this patch fixes a bug with RTAX_RTO_MIN,
> I do not add a Fixes: tag, so that we can soak it a bit before
> asking backports to stable branches.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

So great that this is now upstream :-) Thank you!

> ---
>  include/net/tcp.h     |  2 ++
>  net/ipv4/tcp.c        |  3 ++-
>  net/ipv4/tcp_output.c | 16 +++++++++++++++-
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a8db7d43fb6215197af4a80e270b8c82070d55cb..af9cb37fbe53ec60b4e545e8a=
a0740bbf30da7b6 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -718,6 +718,8 @@ static inline void tcp_fast_path_check(struct sock *s=
k)
>                 tcp_fast_path_on(tp);
>  }
>
> +u32 tcp_delack_max(const struct sock *sk);
> +
>  /* Compute the actual rto_min value */
>  static inline u32 tcp_rto_min(const struct sock *sk)
>  {
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 69b8d707370844020770438cc4f31aeda4830b3d..e54f91eb943b2f09f303951cc=
72cbea61ada519d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3762,7 +3762,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info =
*info)
>                 info->tcpi_options |=3D TCPI_OPT_SYN_DATA;
>
>         info->tcpi_rto =3D jiffies_to_usecs(icsk->icsk_rto);
> -       info->tcpi_ato =3D jiffies_to_usecs(icsk->icsk_ack.ato);
> +       info->tcpi_ato =3D jiffies_to_usecs(min(icsk->icsk_ack.ato,
> +                                             tcp_delack_max(sk)));
>         info->tcpi_snd_mss =3D tp->mss_cache;
>         info->tcpi_rcv_mss =3D icsk->icsk_ack.rcv_mss;
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..2d1e4b5ac1ca41ff3db8dc584=
58d4e922a2c4999 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3977,6 +3977,20 @@ int tcp_connect(struct sock *sk)
>  }
>  EXPORT_SYMBOL(tcp_connect);
>
> +u32 tcp_delack_max(const struct sock *sk)
> +{
> +       const struct dst_entry *dst =3D __sk_dst_get(sk);
> +       u32 delack_max =3D inet_csk(sk)->icsk_delack_max;
> +
> +       if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
> +               u32 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> +               u32 delack_from_rto_min =3D max_t(int, 1, rto_min - 1);
> +
> +               delack_max =3D min_t(u32, delack_max, delack_from_rto_min=
);
> +       }
> +       return delack_max;
> +}
> +
>  /* Send out a delayed ack, the caller does the policy checking
>   * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_check(=
)
>   * for details.
> @@ -4012,7 +4026,7 @@ void tcp_send_delayed_ack(struct sock *sk)
>                 ato =3D min(ato, max_ato);
>         }
>
> -       ato =3D min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
> +       ato =3D min_t(u32, ato, tcp_delack_max(sk));
>
>         /* Stay within the limit we were given */
>         timeout =3D jiffies + ato;
> --
> 2.42.0.459.ge4e396fd5e-goog
>

