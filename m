Return-Path: <netdev+bounces-119711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74645956AE5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CDB1C238EA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A616B3B6;
	Mon, 19 Aug 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maO7IBPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE616B396
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070470; cv=none; b=P8J7I9TH/nhg8NE9OKyBpPb6C0JpDiqdjmSK2NPFNT399LnTaWltEw7xlrO2YD8EabhEE49sw8OST8g8x9P6dbRF7GpDgrKVJuxudipq7X5wpMy6L5L2pUbdZpXA3SMbtOwZ+m8bmXfbSXbcNvNjpoqG+1XnxQqAgXKx8XrVzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070470; c=relaxed/simple;
	bh=dGHw/2GnAO0DMtN64kqN9WpwBeA9i93MLvQ2F4+QvxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlhIhh6cugVZ76YjM5me7tqntIBeBicmWmCXCx5zoChMCozCGOBRlPJHi81oxjNqm4XR2wEaTpkLDskhZIxs01aygB7kWMez1NmPGIPgSOsFUQBMvIwnSDINFBOLK/qcrt2DsPl46zrjZXSuNO+pv4EVRFlazeZSbBs3qiCfeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maO7IBPZ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-37636c3872bso16988935ab.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724070468; x=1724675268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4E9Dy3UeksFEmBl4cfLUPHZ+Scds2QtEu1cYvfJwY8=;
        b=maO7IBPZU+cJL+nAQM0mwpHC7NG+e9/jpHQq6r++0vLjOCdSt6ZK35mF8S0tMaE5wX
         ebJzPmhFg29HmnLU3iZAAPhCYKDweSjnBVaproxns0f6BKuZQVzgPPwpfSNQP9PakGLl
         U0rObSE2pYZqI5FNd32NX5doP5PUmO+ndMknFuzj9MkSR/svmAvOrVJiirlYm37Fl2iR
         D+S/4iKkhFxjXjnaZif6KnOpb6yG6WJDXe52ZNi5k9ndXt0Q6wdf1zFSkXYKymMIjC7E
         oYzMVaJiCgqkv3+K5K6e7WWC2FpZk23tfofQt6ReOLTag+/G9WDolwSmzZH8cpV7de2p
         48ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070468; x=1724675268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4E9Dy3UeksFEmBl4cfLUPHZ+Scds2QtEu1cYvfJwY8=;
        b=PVXGIP1X3AGFhKEk3p5oysVDdIrDyz8dv6bNI/eA1kEMWstoYtPfSd8caCxA3fydsW
         IqO5cm/MiJhDod9OM2YmWRUkwqY9X1MOPzfWNYOwtB4XKQidMQmyex9ZT9ol70SUB7Iy
         u3h2C+8roJ64ddkFYl9oGXca9dwkNEaJrNOpODvGi5lx4CsZOZ/ZLt6au52VYs4zn2zW
         GOrnLbVcxUFeF/Kb0Ucu5JPSXDPmPiSO+fN9Rfmlgvk6IuygPmZ3K7xO4fgSq4kMk60r
         Lv31JpiOEysuwQAxc2/D33QIOBg/O1RTNBm/XBnvXXum9Jc9VuUyV9Fa1B+zDb+qYmOT
         GYug==
X-Gm-Message-State: AOJu0YyL6lZttxCPELQuJ5R1CmETTgw3yigBUlFWIHnnldyxaTKjnPfI
	OKg/xAXHLo10ZndeGgXtKoHi3EYpW3yOAQLJ36JE90PgzjRWty1jiDnTHaqSEWUMvNF2pmxXHs9
	KMEiPaMkOekeEuRl43ZCqINLgEjk=
X-Google-Smtp-Source: AGHT+IHoVZ0YxUcglXCoIF9wlJ/TSyjm/N4K4t1AymaeJGz2jIW6ubuGxWS2h5Hnb78SEVIy8nxwIP972+rj3CIaNiI=
X-Received: by 2002:a05:6e02:1989:b0:39b:25dc:7bd6 with SMTP id
 e9e14a558f8ab-39d26cde6a7mr127160725ab.4.1724070467971; Mon, 19 Aug 2024
 05:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
In-Reply-To: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 20:27:11 +0800
Message-ID: <CAL+tcoD9BA_Y26dSz+rkvi2_ZEc6D29zVEBhSQ5++OtOqJ3Xvw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] tcp: Allow TIME-WAIT reuse after 1 millisecond
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Mon, Aug 19, 2024 at 7:31=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> [This patch needs a description. Please see the RFC cover letter below.]
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Can we shorten the TCP connection reincarnation period?
>
> Situation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently, we can reuse a TCP 4-tuple (source IP + port, destination IP +=
 port)
> in the TIME-WAIT state to establish a new outgoing TCP connection after a=
 period
> of 1 second. This period, during which the 4-tuple remains blocked from r=
euse,
> is determined by the granularity of the ts_recent_stamp / tw_ts_recent_st=
amp
> timestamp, which presently uses a 1 Hz clock (ktime_get_seconds).
>
> The TIME-WAIT block is enforced by __{inet,inet6}_check_established ->
> tcp_twsk_unique, where we check if the timestamp clock has ticked since t=
he last
> ts_recent_stamp update before allowing the 4-tuple to be reused.
>
> This mechanism, introduced in 2002 by commit b8439924316d ("Allow to bind=
 to an
> already in use local port during connect") [1], protects the TCP receiver
> against segments from an earlier incarnation of the same connection (FIN
> retransmits), which could potentially corrupt the TCP stream, as describe=
d by
> RFC 7323 [2, 3].
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D
>
> The one-second reincarnation period has not posed a problem when we had a
> sufficiently large pool of ephemeral ports (tens of thousands per host).
> However, as we began sharing egress IPv4 addresses between hosts by parti=
tioning
> the available port range [4], the ephemeral port pool size has shrunk
> significantly=E2=80=94down to hundreds of ports per host.
>
> This reduction in port pool size has made it clear that a one-second conn=
ection
> reincarnation period can lead to ephemeral port exhaustion. Short-lived T=
CP
> connections, such as DNS queries, can complete in milliseconds, yet the T=
CP
> 4-tuple remains blocked for a period of time that is orders of magnitude =
longer.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> We would like to propose to shorten the period during which the 4-tuple i=
s tied
> up. The intention is to enable TIME-WAIT reuse at least as quickly as it =
takes
> nowadays to perform of a short-lived TCP connection, from setup to teardo=
wn.
>
> The ts_recent_stamp protection is based on the same principle as PAWS but
> extends it across TCP connections. As RFC 7323 outlines in Appendix B.2, =
point
> (b):
>
>     An additional mechanism could be added to the TCP, a per-host
>     cache of the last timestamp received from any connection.  This
>     value could then be used in the PAWS mechanism to reject old
>     duplicate segments from earlier incarnations of the connection,
>     if the timestamp clock can be guaranteed to have ticked at least
>     once since the old connection was open.  This would require that
>     the TIME-WAIT delay plus the RTT together must be at least one
>     tick of the sender's timestamp clock.  Such an extension is not
>     part of the proposal of this RFC.
>
> Due to that, we would want to follow the same guidelines as the for TSval
> timestamp clock, for which RFC 7323 recommends a frequency in the range o=
f 1 ms
> to 1 sec per tick [5], when reconsidering the default setting.
>
> (Note that the Linux TCP stack has recently introduced even finer granula=
rity
> with microsecond TSval resolution in commit 614e8316aa4c "tcp: add suppor=
t for
> usec resolution in TCP TS values" [6] for use in private networks.)
>
> A simple implementation could be to switch from a second to a millisecond=
 clock,
> as demonstrated by the following patch. However, this could also be a tun=
able
> option to allow administrators to adjust it based on their specific needs=
 and
> risk tolerance.
>
> A tunable also opens the door to letting users set the TIME-WAIT reuse pe=
riod
> beyond the RFC 7323 recommended range at their own risk.
>
> Workaround
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Today, when an application has only a small ephemeral port pool available=
, we
> work around the 1-second reincarnation period by manually selecting the l=
ocal
> port with an explicit bind().
>
> This has been possible since the introduction of the ts_recent_stamp prot=
ection
> mechanism [1]. However, it is unclear why this is allowed for egress
> connections.
>
> To guide readers to the relevant code: if the local port is selected by t=
he
> user, we do not pass a TIME-WAIT socket to the check_established helper f=
rom
> __inet_hash_connect. This way we circumvent the timestamp check in
> tcp_twsk_unique [7] (as twp is NULL).
>
> However, relying on this workaround conflicts with our goal of delegating=
 TCP
> local port selection to the network stack, using the IP_BIND_ADDRESS_NO_P=
ORT [8]
> and IP_LOCAL_PORT_RANGE [9] socket options.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db8439924316d5bcb266d165b93d632a4b4b859af
> [2] https://datatracker.ietf.org/doc/html/rfc7323#section-5.8
> [3] https://datatracker.ietf.org/doc/html/rfc7323#appendix-B
> [4] https://lpc.events/event/16/contributions/1349/
> [5] https://datatracker.ietf.org/doc/html/rfc7323#section-5.4
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D614e8316aa4cafba3e204cb8ee48bd12b92f3d93
> [7] https://elixir.bootlin.com/linux/v6.10/source/net/ipv4/tcp_ipv4.c#L15=
6
> [8] https://manpages.debian.org/unstable/manpages/ip.7.en.html#IP_BIND_AD=
DRESS_NO_PORT
> [9] https://manpages.debian.org/unstable/manpages/ip.7.en.html#IP_LOCAL_P=
ORT_RANGE
> ---
>
> ---
>  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 2 +-
>  include/linux/tcp.h                                         | 4 ++--
>  net/ipv4/tcp_input.c                                        | 2 +-
>  net/ipv4/tcp_ipv4.c                                         | 5 ++---
>  net/ipv4/tcp_minisocks.c                                    | 9 ++++++--=
-
>  5 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c =
b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index 6f6525983130..b15b26db8902 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -1866,7 +1866,7 @@ static void chtls_timewait(struct sock *sk)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
>         tp->rcv_nxt++;
> -       tp->rx_opt.ts_recent_stamp =3D ktime_get_seconds();
> +       tp->rx_opt.ts_recent_stamp =3D tcp_clock_ms();
>         tp->srtt_us =3D 0;
>         tcp_time_wait(sk, TCP_TIME_WAIT, 0);
>  }
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..174257114ee4 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -110,7 +110,7 @@ struct tcp_sack_block {
>
>  struct tcp_options_received {
>  /*     PAWS/RTTM data  */
> -       int     ts_recent_stamp;/* Time we stored ts_recent (for aging) *=
/
> +       u32     ts_recent_stamp;/* Time we stored ts_recent (for aging) *=
/
>         u32     ts_recent;      /* Time stamp to echo next              *=
/
>         u32     rcv_tsval;      /* Time stamp value                     *=
/
>         u32     rcv_tsecr;      /* Time stamp echo reply                *=
/
> @@ -543,7 +543,7 @@ struct tcp_timewait_sock {
>         /* The time we sent the last out-of-window ACK: */
>         u32                       tw_last_oow_ack_time;
>
> -       int                       tw_ts_recent_stamp;
> +       u32                       tw_ts_recent_stamp;
>         u32                       tw_tx_delay;
>  #ifdef CONFIG_TCP_MD5SIG
>         struct tcp_md5sig_key     *tw_md5_key;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e37488d3453f..873a1cbd6d14 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3778,7 +3778,7 @@ static void tcp_send_challenge_ack(struct sock *sk)
>  static void tcp_store_ts_recent(struct tcp_sock *tp)
>  {
>         tp->rx_opt.ts_recent =3D tp->rx_opt.rcv_tsval;
> -       tp->rx_opt.ts_recent_stamp =3D ktime_get_seconds();
> +       tp->rx_opt.ts_recent_stamp =3D tcp_clock_ms();
>  }
>
>  static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd17f25ff288..47e2dcda4eae 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -116,7 +116,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *skt=
w, void *twp)
>         const struct inet_timewait_sock *tw =3D inet_twsk(sktw);
>         const struct tcp_timewait_sock *tcptw =3D tcp_twsk(sktw);
>         struct tcp_sock *tp =3D tcp_sk(sk);
> -       int ts_recent_stamp;
> +       u32 ts_recent_stamp;
>
>         if (reuse =3D=3D 2) {
>                 /* Still does not detect *everything* that goes through
> @@ -157,8 +157,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *skt=
w, void *twp)
>          */
>         ts_recent_stamp =3D READ_ONCE(tcptw->tw_ts_recent_stamp);
>         if (ts_recent_stamp &&
> -           (!twp || (reuse && time_after32(ktime_get_seconds(),
> -                                           ts_recent_stamp)))) {
> +           (!twp || (reuse && (u32)tcp_clock_ms() !=3D ts_recent_stamp))=
) {

At first glance, I wonder whether 1 ms is really too short, especially
for most cases? If the rtt is 2-3 ms which is quite often seen in
production, we may lose our opportunity to change the sub-state of
timewait socket and finish the work that should be done as expected.
One second is safe for most cases, of course, since I obscurely
remember I've read one paper (tuning the initial window to 10) saying
in Google the cases exceeding 100ms rtt is rare but exists. So I still
feel a fixed short value is not that appropriate...

Like you said, how about converting the fixed value into a tunable one
and keeping 1 second as the default value?

After you submit the next version, I think I can try it and test it
locally :) It's interesting!

Thanks,
Jason

