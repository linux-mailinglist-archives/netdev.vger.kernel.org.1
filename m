Return-Path: <netdev+bounces-70497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAC84F40C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5543F1C21F1A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0E25601;
	Fri,  9 Feb 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0p1vHAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8520332
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476525; cv=none; b=skhIbmSQItZqbioYEgyKIEBLpDnQsoM0WDZ1jJceS4e+ufoTL/5yzqcE5KRQIuOHMlcd2Y6/pCAOxXsdIbk1HFHPozcEFmxI4BrbpCOdkaR1mTRcBONh2I4nx801/caAt5cwjDNoOO2Gux8q/oeeTSO23P20i9cNiHXwWPcFwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476525; c=relaxed/simple;
	bh=1eiEe6HErVpX9s0WsRg7C3uBjq85jnnrDObauvHFERo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6zTUumpwuY5In4aVApSvCDprOhND4B+hqQUEH4UfHHrWKfYGzycXXSsV4haLBkJxeqD3fCX3SjOqH3t2DEyiL6oxNrWgO2kFjhjeBZRaaeJNdyA/wImk9xnA9OCRDshliJm2f3QxYLTcs6laASesmyNj3gckFQGdJBSD0VTf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0p1vHAS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-560daf8e9eeso23832a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707476521; x=1708081321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpM6ApHmz941PVFA0ZNGX0ql5uOzaHviftw7UzcNNb4=;
        b=Z0p1vHASo0aH0M1g2FrxiysGKbVCAfYiqbmggWCgQ2LwHR6+h1DPwiWfqBiZeG3FIp
         RaIZJuaorQ39+5lZdKJpqgIFHvjJEE9OSXb3csRsrEwbw6+duTbgBRBYai3gxNX80d8E
         1LkI+a0NVhYUcYgxCVX8CAbSH/WPlBJFkGOgh8qjmyr152gnLULzr8xndEuHv9AM+BuT
         WtfjduQA3bEgVFEX9K4yq8VbgndXTbe0+7TVWdYfBinezi8fQ7+Bm6FEIu8v5dnmlsiB
         N4kXDJo6m3VlU52qaL/5NWMQR1Pzi03IyJNh+XfMK26CGeVeMX8z07yttgp/X6XGmFj8
         OEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476521; x=1708081321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpM6ApHmz941PVFA0ZNGX0ql5uOzaHviftw7UzcNNb4=;
        b=Or2Ljh40v1TkkIszLi+NbQJBwHqMkhgI5WK3tx7lU0j37ws8ZU0dktxn5ByNBqc4On
         KizS2JHkMhztOI0yl0wINH1X2zpYsPVIYM4H6x22l/X7ZWd2X6gbgelUOyWt6oEjQSbO
         gE0ySADNzfNdZvKaOHOj6HQJG/E/o6mDoAsF7w3wcCbaKTigBLg0ooIwVU+ONCe3oBeZ
         k3nqSB8FqOUCeOEaDDtYDIRJWcMS1mBNSIkaafnjG3qni539c8GxBCCKWoFlBmb7Zxp4
         dbSXYTxSapjMuZ7hlc3ndnB/Rd6OPl5KlKdGDtgmsMqglQA5s+W/NT09arXIC09uMx77
         vCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5LnKaNftu+FT9SntdjrWhOyS8IMtBZ9qzDANVpsMTWeil9P0hyyS/gfco3mqvbUs93yEh2XRUifQqyB+SryTBvXDHW+XC
X-Gm-Message-State: AOJu0Yy4AQJgN6y60+yqMKciGkEiRCXzdarh1upS44zebczyvSN5iCFM
	/A7hQANMx422jmcRdumUMk2H80ZiFgv44BEzn7dLGK7SplxqLptUTdmsQAg5qQhBNDXuL56UOPj
	60VYYSha6ajom2ooPqpDR4w9Kdi8lqGJRp+CL
X-Google-Smtp-Source: AGHT+IFFAzhaket2gB1140mTXALeCmgUXiznXTqBuXdtxEtdYIkUW66Rkv3LWQ+AAFWxuGJfWWiLOgswfIxW0M5FeDk=
X-Received: by 2002:a50:99dc:0:b0:55f:daaa:1698 with SMTP id
 n28-20020a5099dc000000b0055fdaaa1698mr92310edb.6.1707476521165; Fri, 09 Feb
 2024 03:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209061213.72152-1-kerneljasonxing@gmail.com> <20240209061213.72152-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240209061213.72152-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Feb 2024 12:01:46 +0100
Message-ID: <CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: add more DROP REASONs in receive process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 7:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> As the title said, add more reasons to narrow down the range about
> why the skb should be dropped.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/dropreason-core.h | 11 ++++++++++-
>  include/net/tcp.h             |  4 ++--
>  net/ipv4/tcp_input.c          | 26 +++++++++++++++++---------
>  net/ipv4/tcp_ipv4.c           | 19 ++++++++++++-------
>  net/ipv4/tcp_minisocks.c      | 10 +++++-----
>  net/ipv6/tcp_ipv6.c           | 19 ++++++++++++-------
>  6 files changed, 58 insertions(+), 31 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index efbc5dfd9e84..9a7643be9d07 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -31,6 +31,8 @@
>         FN(TCP_AOFAILURE)               \
>         FN(SOCKET_BACKLOG)              \
>         FN(TCP_FLAGS)                   \
> +       FN(TCP_CONNREQNOTACCEPTABLE)    \
> +       FN(TCP_ABORTONDATA)             \
>         FN(TCP_ZEROWINDOW)              \
>         FN(TCP_OLD_DATA)                \
>         FN(TCP_OVERWINDOW)              \
> @@ -38,6 +40,7 @@
>         FN(TCP_RFC7323_PAWS)            \
>         FN(TCP_OLD_SEQUENCE)            \
>         FN(TCP_INVALID_SEQUENCE)        \
> +       FN(TCP_INVALID_ACK_SEQUENCE)    \
>         FN(TCP_RESET)                   \
>         FN(TCP_INVALID_SYN)             \
>         FN(TCP_CLOSE)                   \
> @@ -203,6 +206,10 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_SOCKET_BACKLOG,
>         /** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
>         SKB_DROP_REASON_TCP_FLAGS,
> +       /** @SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE: con req not accept=
able */
> +       SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE,
> +       /** @SKB_DROP_REASON_TCP_ABORTONDATA: abort on data */
> +       SKB_DROP_REASON_TCP_ABORTONDATA,
>         /**
>          * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is ze=
ro,
>          * see LINUX_MIB_TCPZEROWINDOWDROP
> @@ -227,13 +234,15 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_TCP_OFOMERGE,
>         /**
>          * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding t=
o
> -        * LINUX_MIB_PAWSESTABREJECTED
> +        * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
>          */
>         SKB_DROP_REASON_TCP_RFC7323_PAWS,
>         /** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate p=
acket) */
>         SKB_DROP_REASON_TCP_OLD_SEQUENCE,
>         /** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ fie=
ld */
>         SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
> +       /** @SKB_DROP_REASON_TCP_ACK_INVALID_SEQUENCE: Not acceptable ACK=
 SEQ field */
> +       SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
>         /** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
>         SKB_DROP_REASON_TCP_RESET,
>         /**
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 58e65af74ad1..1d9b2a766b5e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -348,7 +348,7 @@ void tcp_wfree(struct sk_buff *skb);
>  void tcp_write_timer_handler(struct sock *sk);
>  void tcp_delack_timer_handler(struct sock *sk);
>  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
> -int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
> +enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_bu=
ff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
> @@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct =
inet_timewait_sock *tw,
>  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>                            struct request_sock *req, bool fastopen,
>                            bool *lost_race);
> -int tcp_child_process(struct sock *parent, struct sock *child,
> +enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock =
*child,
>                       struct sk_buff *skb);
>  void tcp_enter_loss(struct sock *sk);
>  void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int new=
ly_lost, int flag);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2d20edf652e6..81fe584aa777 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>                                 inet_csk_reset_xmit_timer(sk,
>                                                 ICSK_TIME_RETRANS,
>                                                 TCP_TIMEOUT_MIN, TCP_RTO_=
MAX);
> +                       SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
>                         goto reset_and_undo;
>                 }
>
> @@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>                              tcp_time_stamp_ts(tp))) {
>                         NET_INC_STATS(sock_net(sk),
>                                         LINUX_MIB_PAWSACTIVEREJECTED);
> +                       SKB_DR_SET(reason, TCP_RFC7323_PAWS);
>                         goto reset_and_undo;
>                 }
>
> @@ -6572,7 +6574,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>  reset_and_undo:
>         tcp_clear_options(&tp->rx_opt);
>         tp->rx_opt.mss_clamp =3D saved_clamp;
> -       return 1;
> +       return reason;
>  }
>
>  static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
> @@ -6616,7 +6618,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct s=
ock *sk)
>   *     address independent.
>   */
>
> -int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
> +enum skb_drop_reason
> +tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
> @@ -6633,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
>
>         case TCP_LISTEN:
>                 if (th->ack)
> -                       return 1;
> +                       return SKB_DROP_REASON_TCP_FLAGS;
>
>                 if (th->rst) {
>                         SKB_DR_SET(reason, TCP_RESET);
> @@ -6654,7 +6657,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
>                         rcu_read_unlock();
>
>                         if (!acceptable)
> -                               return 1;
> +                               return SKB_DROP_REASON_TCP_CONNREQNOTACCE=
PTABLE;
>                         consume_skb(skb);
>                         return 0;
>                 }
> @@ -6704,8 +6707,13 @@ int tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
>                                   FLAG_NO_CHALLENGE_ACK);
>
>         if ((int)reason <=3D 0) {
> -               if (sk->sk_state =3D=3D TCP_SYN_RECV)
> -                       return 1;       /* send one RST */
> +               if (sk->sk_state =3D=3D TCP_SYN_RECV) {
> +                       /* send one RST */
> +                       if (!reason)
> +                               return SKB_DROP_REASON_TCP_OLD_ACK;
> +                       else
> +                               return -reason;

Your patch is too large/risky, not that I am trying to be gentle here...

You should know better that we are not going to accept it as is.
Please split your patches into smaller ones.

Eg, a single patch to change tcp_rcv_synsent_state_process() return value.
It used to return -1, 0, or 1.
Take the time to document for tcp_rcv_synsent_state_process() what are
the new possible return values.

Then other changes, one at a time, in a logical way.

Smaller patches are easier to review, even if it forces the author to
think a bit more about how to
make his series a work of art. Everyone wins, because we spend less
time and we learn faster.

Thank you.

