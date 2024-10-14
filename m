Return-Path: <netdev+bounces-135212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB799CCBB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE961F23AD4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61C1A3A8D;
	Mon, 14 Oct 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0zfEFc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2011AAE19
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915844; cv=none; b=f1xtRHdhNIAYzgDfKyR+uhCK1LXFY89Y4covTYDTBZjk1967i8AT1kLuHWMgPv1RkNn9lSPkF4PctGbPH5sQnPKWkDS5pEQvMn0g+PIiP7rQZ7f4ciJSyNZ0es7+8lTvcRP4EtaGh2nikhNd8z6goy2mcBxyRw747xYDj/ZeBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915844; c=relaxed/simple;
	bh=gBmL7VsJsuMJr6PVV16JxEW+8WPist4nBJYdv/8sDTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yke8yrVDz5ao92QbwNEKGegApTRO4gT9uMnPy0pikdsQiJXIglqyx1z5U2RjCxJ9aMUi3ba/6HXfPjzR37xePfaHmLmDqtbKe0xVjYUsbmulkjCC6hOGwHlBKN+CEh8ERPz+MEsBuoRqES1V6lRUaNQMRV6UP0jptlcPQIJCBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0zfEFc3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460414d5250so31133501cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728915841; x=1729520641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hjtZijfOkGPPhwysG7j9QwgtG4jzbmV2H+tLgcp260=;
        b=R0zfEFc3evTi4BZFEQDBBdsbSWH8FdAHi0gRO98I1/cpJs9g777+ihiulVNDhPwydr
         gUCtjHwbdO1bSrIv8j+jB036FvThYo4WeHCVoETxOQj4bWqoDamvZ3USPGioGBfFf9mF
         RiK0SLR6x5Mn7xdteduSeAq8a06EZ3Ky7RGMmafl0oT55OGW2Bg3bVaSC4xx+SLJrk1U
         oy14+SW18NLofunAZHsE3/ybmHQAXsUfIxKGWAIDA5jJI36Okx4ogMqc3mlGeHxbmjB6
         JP2IL2hbhZWbg4aQhn/2BleBEo7bTaTSGLFDgUCXZlZk5a2nbmHMEOsJIAGldJEN9DBv
         JITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915841; x=1729520641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hjtZijfOkGPPhwysG7j9QwgtG4jzbmV2H+tLgcp260=;
        b=fjPZAx0xa7IY/A3uD+guYSCUVwFbgyKWfR04ka8Ek/0hhsakFqCAbbN53u6nI+bltQ
         jaI0OQFpR3bpWyPjI+MMDhkJqAtu3R5WV8pBXxKMtuX4zNJS0u3hXrFhbBrovjWlStKh
         1MhO79k3L2ml88wNIMTbglXe77mGYMIQfyiewdrDy+nTf4QyhfMUNx+bpY8EieymXd1N
         q41fmCGJbnJ6Rr8E+mZuidpiLEzMSgKbaCxpgGQOGCHib3MBG3huSO49Itm5yDZ2wPGP
         mToeRV+G11yYsv2F9Eo+gexmzN+SgTcw+2mm/Ks/mP0g6Nsbte3tgiJRVEKmjYIGYx2f
         uXYg==
X-Forwarded-Encrypted: i=1; AJvYcCVnUfJEUYQIRV5W5wbBJ0ukQhv8obSP+WyJJCsO+snTa6YJY9IAVyLT8+BFrw4mYpj8RFLCQik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rVBQ9bSS8GDT05DXcQvGd2StP509RJNJIyDJaZXBtMGqAznY
	WqB0hFQ6tvWrzynqmAMU73tpenu4e3pTcxG/n5ity8AwLpqtUqETlz8holKuvgnTbuB7c+Namti
	OzP3jmM5gg1V+4we9OOH+oES6EoWPsyN3ZFQ2
X-Google-Smtp-Source: AGHT+IECyjSBiwV7eE9zQicgjAfzQBt3d9ru0J2afBJNXpkuNHBJKQa+mNWQJmVFUEANV5rzegerHAY8L1Fwij0Um9s=
X-Received: by 2002:a05:6214:328b:b0:6cb:e9eb:2f51 with SMTP id
 6a1803df08f44-6cbefef4ca7mr154614626d6.0.1728915841169; Mon, 14 Oct 2024
 07:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-6-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-6-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:23:47 -0400
Message-ID: <CAMzD94Twmw17xq+yCLeDiiO09=uDyHJbD7acr_+UL_rMaqa=Tg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/5] ipv4: tcp: give socket pointer to control skbs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ip_send_unicast_reply() send orphaned 'control packets'.
>
> These are RST packets and also ACK packets sent from TIME_WAIT.
>
> Some eBPF programs would prefer to have a meaningful skb->sk
> pointer as much as possible.
>
> This means that TCP can now attach TIME_WAIT sockets to outgoing
> skbs.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Brian Vazquez <brianvv@google.com>

> ---
>  include/net/ip.h     | 3 ++-
>  net/ipv4/ip_output.c | 5 ++++-
>  net/ipv4/tcp_ipv4.c  | 4 ++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index bab084df15677543b7400bb2832c0e83988884cb..4be0a6a603b2b5d5cfddc045a=
7d49d0d77be9570 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -288,7 +288,8 @@ static inline __u8 ip_reply_arg_flowi_flags(const str=
uct ip_reply_arg *arg)
>         return (arg->flags & IP_REPLY_ARG_NOSRCCHECK) ? FLOWI_FLAG_ANYSRC=
 : 0;
>  }
>
> -void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
> +void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
> +                          struct sk_buff *skb,
>                            const struct ip_options *sopt,
>                            __be32 daddr, __be32 saddr,
>                            const struct ip_reply_arg *arg,
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index e5c55a95063dd8340f9a014102408e859b4eb755..0065b1996c947078bea210c9a=
be5c80fa0e0ab4f 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1596,7 +1596,8 @@ static int ip_reply_glue_bits(void *dptr, char *to,=
 int offset,
>   *     Generic function to send a packet as reply to another packet.
>   *     Used to send some TCP resets/acks so far.
>   */
> -void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
> +void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
> +                          struct sk_buff *skb,
>                            const struct ip_options *sopt,
>                            __be32 daddr, __be32 saddr,
>                            const struct ip_reply_arg *arg,
> @@ -1662,6 +1663,8 @@ void ip_send_unicast_reply(struct sock *sk, struct =
sk_buff *skb,
>                           arg->csumoffset) =3D csum_fold(csum_add(nskb->c=
sum,
>                                                                 arg->csum=
));
>                 nskb->ip_summed =3D CHECKSUM_NONE;
> +               if (orig_sk)
> +                       skb_set_owner_edemux(nskb, (struct sock *)orig_sk=
);
>                 if (transmit_time)
>                         nskb->tstamp_type =3D SKB_CLOCK_MONOTONIC;
>                 if (txhash)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 985028434f644c399e51d12ba8d9c2c5740dc6e1..9d3dd101ea713b14e13afe662=
baa49d21b3b716c 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -907,7 +907,7 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb,
>                 ctl_sk->sk_mark =3D 0;
>                 ctl_sk->sk_priority =3D 0;
>         }
> -       ip_send_unicast_reply(ctl_sk,
> +       ip_send_unicast_reply(ctl_sk, sk,
>                               skb, &TCP_SKB_CB(skb)->header.h4.opt,
>                               ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>                               &arg, arg.iov[0].iov_len,
> @@ -1021,7 +1021,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
>         ctl_sk->sk_priority =3D (sk->sk_state =3D=3D TCP_TIME_WAIT) ?
>                            inet_twsk(sk)->tw_priority : READ_ONCE(sk->sk_=
priority);
>         transmit_time =3D tcp_transmit_time(sk);
> -       ip_send_unicast_reply(ctl_sk,
> +       ip_send_unicast_reply(ctl_sk, sk,
>                               skb, &TCP_SKB_CB(skb)->header.h4.opt,
>                               ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>                               &arg, arg.iov[0].iov_len,
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

