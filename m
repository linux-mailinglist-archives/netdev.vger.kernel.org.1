Return-Path: <netdev+bounces-85270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB92899FAF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76963B23161
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610E16EBFB;
	Fri,  5 Apr 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfu8KNVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FE16D309
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327382; cv=none; b=LtHU9aRPyPrdcr+xU2REtzF7hJ3dVnuMKEQJ5VDquQz//1VBH9flq6L/AMHwm1SL9CMImeKKQLfM//OHHoExzlEAyHf13x35Lc8cUPn7DSJKTyAxWuvSoAcI2BhlFwO6MXtRNOUJmUx8G5EfaAGbMEAYiPRyd3y/y/yJmYK/SDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327382; c=relaxed/simple;
	bh=x/sT1fuX9zDTCfkT1En4P8xvkPYDpYNQGV2B8e4eoKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxVfTmZHM83bRy1FcKskzCY4K+hC8VwUrRoOTYP/1RPjLq3g6f/X4590xtPVZ3FBpSmV9LFPQFKQvdomHLlJFp1GUKOHv7FwxRKDRjlbI8snXXSG0WMxHcOFFDTwzqCbU5mPHwp9tXziO5AULF2jUhan0sIz+Zh5sjp/Es6exrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfu8KNVF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso2196253a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327379; x=1712932179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iVbJG9kRWcnhU0OJQ1S2xZ7zM1EYxXb/aYkhmQ4uDI=;
        b=Vfu8KNVFw94x9uNo2kgFYkzSS7N2lnuK574Zwr/muXbMJ5swJ8YUWxz+pQS8KUsaco
         MxIl4AtrfJ2JTcrmrq6j19NgjtKrKmxQxk0c+xA3zWUQf0sQbUG5taQRd967KlDOcPPG
         lA86qVab5bi8r48bnnneu1W+pvXmO22h+7HaedHx/0+gGpQt5zA/5a8+2f9icEnuLlYD
         s9sVp+0cscmytDgmheTHVMC0k7/zZ9iDZ/w9+dK7gUrnkloPcEXSPbpeqx0z4kARj1wG
         eBghCFT1URfZkrXZEo8HjL5iDrE5cREpmtfY2Nad5tWEoAekuHSB+wb6K5pNvX/lQgXD
         9BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327379; x=1712932179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iVbJG9kRWcnhU0OJQ1S2xZ7zM1EYxXb/aYkhmQ4uDI=;
        b=SUyEY7Xl7FtlAT43VXQXFK+S+mLgS4XitM9omc8poNa4/yv44o5QShXcEZO5GIJcMy
         3ne8q8WlKtHECOqBPn63oVpziP1P+SmdcwaBRzuBW9GlVtkERTdw1myoRl2m1eygLpQI
         ZOgbAnVQ2BmkXzi8EjfeKT/FfIQfpQpfgV7BbYV/pXhUaa5qJJPV0xx6zkh4ebEghAk2
         eDAF2G0K5nHeI2rCh5+6m/cKfo7ryRuFZHHqJQSR5VqQ1D5A1y19zC2LONjLnqE08J+R
         W7yvSXxplzsQwD2e4pkka/ePyTWSfVZyMBtX/zoXGAge9y6Uy9HOF/dQTGrKPbF9wDj2
         Ap8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1gAwAuol7iJ9MtHRE5MTV7pgnyhmw3Fwa8KHOq3+jxt/PDk7O5MeBb+E7QeuF4SUIT+yS9op6OBATW/NQe98QYL3vc4SZ
X-Gm-Message-State: AOJu0YwehXYqWuar3hc/orjGuyj1pTRu/07tqQvaEZiZnYzOniDNiWxc
	nEew7q3volsl1j5Fs+Hm/wvEEV1DYbaq1/C/3JyVZDk8P7O39KyMGPOyxsqdtZF5k2wHd/ibwCh
	JzcMfam1oIO8o77vn0/SfYesKWOg=
X-Google-Smtp-Source: AGHT+IFtgkwUxe1SfLTaKjU8EvJz7k6n8G51Kjz0cLpXX7OYYixMI83/TEsZ/bZPpupNykHsIakhGC16UcN0KKx665Y=
X-Received: by 2002:a17:906:4888:b0:a4d:f0c3:a9e9 with SMTP id
 v8-20020a170906488800b00a4df0c3a9e9mr1365457ejq.28.1712327378963; Fri, 05 Apr
 2024 07:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404114231.2195171-1-edumazet@google.com>
In-Reply-To: <20240404114231.2195171-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 22:29:01 +0800
Message-ID: <CAL+tcoBhdqVs0ZMzifriVf+3gpLeA72HByB5TW4vJyUn+KntMA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tp->window_clamp can be read locklessly, add READ_ONCE()
> and WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/syncookies.c |  3 ++-
>  net/ipv4/tcp.c        |  8 ++++----
>  net/ipv4/tcp_input.c  | 17 ++++++++++-------
>  net/ipv4/tcp_output.c | 18 ++++++++++--------
>  net/ipv6/syncookies.c |  2 +-
>  net/mptcp/protocol.c  |  2 +-
>  net/mptcp/sockopt.c   |  2 +-
>  7 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 500f665f98cbce4a3d681f8e39ecd368fe4013b1..b61d36810fe3fd62b1e5c5885=
bbaf20185f1abf0 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -462,7 +462,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>         }
>
>         /* Try to redo what tcp_v4_send_synack did. */
> -       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->dst=
, RTAX_WINDOW);
> +       req->rsk_window_clamp =3D READ_ONCE(tp->window_clamp) ? :
> +                               dst_metric(&rt->dst, RTAX_WINDOW);
>         /* limit the window selection if the user enforce a smaller rx bu=
ffer */
>         full_space =3D tcp_full_space(sk);
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e767721b3a588b5d56567ae7badf5dffcd35a76a..92ee60492314a1483cfbfa2f7=
3d32fcad5632773 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1721,7 +1721,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>         space =3D tcp_space_from_win(sk, val);
>         if (space > sk->sk_rcvbuf) {
>                 WRITE_ONCE(sk->sk_rcvbuf, space);
> -               tcp_sk(sk)->window_clamp =3D val;
> +               WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
>         }
>         return 0;
>  }
> @@ -3379,7 +3379,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
>         if (!val) {
>                 if (sk->sk_state !=3D TCP_CLOSE)
>                         return -EINVAL;
> -               tp->window_clamp =3D 0;
> +               WRITE_ONCE(tp->window_clamp, 0);
>         } else {
>                 u32 new_rcv_ssthresh, old_window_clamp =3D tp->window_cla=
mp;
>                 u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> @@ -3388,7 +3388,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
>                 if (new_window_clamp =3D=3D old_window_clamp)
>                         return 0;
>
> -               tp->window_clamp =3D new_window_clamp;
> +               WRITE_ONCE(tp->window_clamp, new_window_clamp);
>                 if (new_window_clamp < old_window_clamp) {
>                         /* need to apply the reserved mem provisioning on=
ly
>                          * when shrinking the window clamp
> @@ -4057,7 +4057,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>                                       TCP_RTO_MAX / HZ);
>                 break;
>         case TCP_WINDOW_CLAMP:
> -               val =3D tp->window_clamp;
> +               val =3D READ_ONCE(tp->window_clamp);
>                 break;
>         case TCP_INFO: {
>                 struct tcp_info info;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 1b6cd384001202df5f8e8e8c73adff0db89ece63..8d44ab5671eacd4bc06647c7c=
ca387a79e346618 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -563,19 +563,20 @@ static void tcp_init_buffer_space(struct sock *sk)
>         maxwin =3D tcp_full_space(sk);
>
>         if (tp->window_clamp >=3D maxwin) {

I wonder if it is necessary to locklessly protect the above line with
READ_ONCE() because I saw the full reader protection in the
tcp_select_initial_window()? There are some other places like this.
Any special reason?

Thanks,
Jason

> -               tp->window_clamp =3D maxwin;
> +               WRITE_ONCE(tp->window_clamp, maxwin);
>
>                 if (tcp_app_win && maxwin > 4 * tp->advmss)
> -                       tp->window_clamp =3D max(maxwin -
> -                                              (maxwin >> tcp_app_win),
> -                                              4 * tp->advmss);
> +                       WRITE_ONCE(tp->window_clamp,
> +                                  max(maxwin - (maxwin >> tcp_app_win),
> +                                      4 * tp->advmss));
>         }
>
>         /* Force reservation of one segment. */
>         if (tcp_app_win &&
>             tp->window_clamp > 2 * tp->advmss &&
>             tp->window_clamp + tp->advmss > maxwin)
> -               tp->window_clamp =3D max(2 * tp->advmss, maxwin - tp->adv=
mss);
> +               WRITE_ONCE(tp->window_clamp,
> +                          max(2 * tp->advmss, maxwin - tp->advmss));
>
>         tp->rcv_ssthresh =3D min(tp->rcv_ssthresh, tp->window_clamp);
>         tp->snd_cwnd_stamp =3D tcp_jiffies32;
> @@ -773,7 +774,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
>                         WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>
>                         /* Make the window clamp follow along.  */
> -                       tp->window_clamp =3D tcp_win_from_space(sk, rcvbu=
f);
> +                       WRITE_ONCE(tp->window_clamp,
> +                                  tcp_win_from_space(sk, rcvbuf));
>                 }
>         }
>         tp->rcvq_space.space =3D copied;
> @@ -6426,7 +6428,8 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>
>                 if (!tp->rx_opt.wscale_ok) {
>                         tp->rx_opt.snd_wscale =3D tp->rx_opt.rcv_wscale =
=3D 0;
> -                       tp->window_clamp =3D min(tp->window_clamp, 65535U=
);
> +                       WRITE_ONCE(tp->window_clamp,
> +                                  min(tp->window_clamp, 65535U));
>                 }
>
>                 if (tp->rx_opt.saw_tstamp) {
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e3167ad965676facaacd8f82848c52cf966f97c3..9282fafc0e6109f3ac86d1641=
740f24588b2d75d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -203,16 +203,17 @@ static inline void tcp_event_ack_sent(struct sock *=
sk, u32 rcv_nxt)
>   * This MUST be enforced by all callers.
>   */
>  void tcp_select_initial_window(const struct sock *sk, int __space, __u32=
 mss,
> -                              __u32 *rcv_wnd, __u32 *window_clamp,
> +                              __u32 *rcv_wnd, __u32 *__window_clamp,
>                                int wscale_ok, __u8 *rcv_wscale,
>                                __u32 init_rcv_wnd)
>  {
>         unsigned int space =3D (__space < 0 ? 0 : __space);
> +       u32 window_clamp =3D READ_ONCE(*__window_clamp);
>
>         /* If no clamp set the clamp to the max possible scaled window */
> -       if (*window_clamp =3D=3D 0)
> -               (*window_clamp) =3D (U16_MAX << TCP_MAX_WSCALE);
> -       space =3D min(*window_clamp, space);
> +       if (window_clamp =3D=3D 0)
> +               window_clamp =3D (U16_MAX << TCP_MAX_WSCALE);
> +       space =3D min(window_clamp, space);
>
>         /* Quantize space offering to a multiple of mss if possible. */
>         if (space > mss)
> @@ -239,12 +240,13 @@ void tcp_select_initial_window(const struct sock *s=
k, int __space, __u32 mss,
>                 /* Set window scaling on max possible window */
>                 space =3D max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.=
sysctl_tcp_rmem[2]));
>                 space =3D max_t(u32, space, READ_ONCE(sysctl_rmem_max));
> -               space =3D min_t(u32, space, *window_clamp);
> +               space =3D min_t(u32, space, window_clamp);
>                 *rcv_wscale =3D clamp_t(int, ilog2(space) - 15,
>                                       0, TCP_MAX_WSCALE);
>         }
>         /* Set the clamp no higher than max representable value */
> -       (*window_clamp) =3D min_t(__u32, U16_MAX << (*rcv_wscale), *windo=
w_clamp);
> +       WRITE_ONCE(*__window_clamp,
> +                  min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
>  }
>  EXPORT_SYMBOL(tcp_select_initial_window);
>
> @@ -3855,7 +3857,7 @@ static void tcp_connect_init(struct sock *sk)
>         tcp_ca_dst_init(sk, dst);
>
>         if (!tp->window_clamp)
> -               tp->window_clamp =3D dst_metric(dst, RTAX_WINDOW);
> +               WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW)=
);
>         tp->advmss =3D tcp_mss_clamp(tp, dst_metric_advmss(dst));
>
>         tcp_initialize_rcv_mss(sk);
> @@ -3863,7 +3865,7 @@ static void tcp_connect_init(struct sock *sk)
>         /* limit the window selection if the user enforce a smaller rx bu=
ffer */
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
>             (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp =
=3D=3D 0))
> -               tp->window_clamp =3D tcp_full_space(sk);
> +               WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
>
>         rcv_wnd =3D tcp_rwnd_init_bpf(sk);
>         if (rcv_wnd =3D=3D 0)
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 6d8286c299c9d139938ef6751d9958c80d3031e9..bfad1e89b6a6bb99c28b9ef14=
c142a6c4aeae54b 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -246,7 +246,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>                 }
>         }
>
> -       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(dst, RTA=
X_WINDOW);
> +       req->rsk_window_clamp =3D READ_ONCE(tp->window_clamp) ? :dst_metr=
ic(dst, RTAX_WINDOW);
>         /* limit the window selection if the user enforce a smaller rx bu=
ffer */
>         full_space =3D tcp_full_space(sk);
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3a1967bc7bad63d5a8a628b3f3b868e3a27baaca..3897a03bb8cb88f7869180b5e=
c261158e8e5d027 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2056,7 +2056,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
>                                 ssk =3D mptcp_subflow_tcp_sock(subflow);
>                                 slow =3D lock_sock_fast(ssk);
>                                 WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
> -                               tcp_sk(ssk)->window_clamp =3D window_clam=
p;
> +                               WRITE_ONCE(tcp_sk(ssk)->window_clamp, win=
dow_clamp);
>                                 tcp_cleanup_rbuf(ssk, 1);
>                                 unlock_sock_fast(ssk, slow);
>                         }
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index dcd1c76d2a3ba1ccc31a3e9279f725cd6d433782..b702e994633788183ad95b2e1=
2859ee6b60bf208 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1519,7 +1519,7 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
>
>                 slow =3D lock_sock_fast(ssk);
>                 WRITE_ONCE(ssk->sk_rcvbuf, space);
> -               tcp_sk(ssk)->window_clamp =3D val;
> +               WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
>                 unlock_sock_fast(ssk, slow);
>         }
>         return 0;
> --
> 2.44.0.478.gd926399ef9-goog
>
>

