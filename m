Return-Path: <netdev+bounces-119693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DE956A26
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A5C1F23448
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949051684BB;
	Mon, 19 Aug 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0HFqXYSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946B16B399
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068797; cv=none; b=grq/llsig4fdR/EMha9YNh0U7jFkZCfoWP52K05alX/PQ4vrjuPoQkrQhjXl9L2g6FzurMNQHORTitfJ13x9giGoWArEItib96GnInl59Qb4ZnBNI30o/qguoEBMEWoYyB4RD2FZFzvsd95Iqiyc9YNyS9bLGY+QByRZSW1mtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068797; c=relaxed/simple;
	bh=aOdAdpq3Oo6jkevhbgwqDUup4E5TThmjcatQiBpJnFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYucKjvqdMmFu0J8ac0MfCqWZYd98q685XTl2/Aysm7NnjSmpZeaccBohrv5pJaHv633E5U2x1AAIOE4y7sle2zmSC3ZEQktfxS03bVlwPz7r3g6t4S1TV/Bg91C3vOEH5w/XWBvdGRmxNJPlS6uPUunrENJTI7i8KragQdT7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0HFqXYSV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4196299a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724068794; x=1724673594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+aaGSMQkOfPA6RmnyONMlMbJIKCTEOr7vJDe+PdHv8=;
        b=0HFqXYSVn9hMbhZ6aVKKc9ZVNVaGOHluSwD9zajMe62y9gOTh2Vyq3qoPaBYc1Wtet
         cUWfbdWtYKCEANz7Ze49vXdST9UBR302t8iQMr8RYVjzBkt37kP1Muwp70lCS93cLuV1
         +FVyeIw733o1OF0wX2C7EVoX5wvZGV8gUjAU9UwuaPZqxM8Ja7YmfcWi/4aHG23uDH2K
         obrtmFfhtp2g2g4H1kAff0qdUNhK/4qugLY6Z+LziuC16zaDYrKdjJ2fTcuBvms4b9Yu
         lKwv8VHRqBfExnoFaMLS8cq2UF926Nct8hYwv4eLvfq2kVlyOa9YNofLD/hvYOQNC20N
         LYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068794; x=1724673594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+aaGSMQkOfPA6RmnyONMlMbJIKCTEOr7vJDe+PdHv8=;
        b=HR9R9q4jQHVPurukwyIPuNBk3wYxS+cN53TQxEjvBT+sRobG6xSJciCCn6E0Ob3f5T
         bWVlmtf+97FlCzdwcS0UYM0xNTKjllP6rbnLAIvna7fwBarc9dvUK0ygO578xRM4d7kk
         Cfh+VGplRFaBfSGf25P9Lj5iFMtvc4UzNxBGj5HzFk1itNWs63F/X+T5FstN59o6kUgn
         Ckc8DJEp5ycfyEOz37/1ArAvTLzJTJv+b5y8rAz430bL9txKEj5fQrOMF6LF8mXta+bL
         RclIQaRmi8OSDWwvG2VCjq4SIv3m1egJiOYkKbz9N2/tDw8crDMiqy8PuhieN5Ciq8Yb
         We8A==
X-Gm-Message-State: AOJu0Yy+jSuwG4m7XcQWOxaniThCGXhEdgGofJ/n2AYYUitRuCvy20gH
	ZVIrzIMfhQH/BIxVRTjfUgsG944W5k497KA4v4VRXPBdG9WsWZpLqAq4AWIjZyWGCdaUUVhRGrQ
	fqLKOgHYR1XFNRSlJdT28WoQROgcq3Jduud6F
X-Google-Smtp-Source: AGHT+IEnzb5GW42aoNoScfmlEOB5TJhvfOBAb570ObELfwUeKUC8bsMLI+jG//EvTcaH2nwH8ae/KAIPU2/iWdZmWBw=
X-Received: by 2002:a17:907:c7e1:b0:a7a:aa35:408e with SMTP id
 a640c23a62f3a-a8392930f8amr791607566b.27.1724068792846; Mon, 19 Aug 2024
 04:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
In-Reply-To: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 13:59:40 +0200
Message-ID: <CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3DraQtsceNGYwug@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] tcp: Allow TIME-WAIT reuse after 1 millisecond
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:31=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
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


We now have network namespaces, and still ~30,000 ephemeral ports per netns=
 :)

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

Note the RTT part here. I do not see this implemented in your patch.

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

Please do not abuse tcp_clock_ms().

Instead use tcp_time_stamp_ms(tp)

Same remark for other parts of the patch, try to reuse tp->tcp_mstamp
if available.

Also, (tcp_clock_ms() !=3D ts_recent_stamp) can be true even after one
usec has elapsed, due to rounding.

The 'one second delay' was really: 'An average of 0.5 second delay'

Solution : no longer use jiffies, but usec based timestamps, since we
already have this infrastructure in TCP stack.

