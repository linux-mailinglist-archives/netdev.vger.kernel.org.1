Return-Path: <netdev+bounces-195795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BDAAD23E6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D621891AB3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1E21ADDB;
	Mon,  9 Jun 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvfkx8iZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EB1FAC4E
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486412; cv=none; b=Y4LpNTD1Qw1wA821QwAsjE+33Fm6vSRF8uoW1L8KPgv6J+nuadcbwoFh/CKes/9blx27/1pf/mLtz0LUqG84j0/F8EqQyO1BePS3mx8cClk3SZIpPODS6KlWFI7mHOZZXruUEfSaNsedQvdVWH4x2t43B3mXHu29PajRegNaF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486412; c=relaxed/simple;
	bh=UHXADYh18vx1+z08DeZFKbFzssAgQ5mG56mCNCdiRos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cla/ehtlxe2B9TmaTK2Xn35SrAQYwIfkgdTA61YM1zi9+PVBYWYJ4ZurCMQnkZeTSpDUCcvCCeq2FsDfMM71kIe0pLmvBj7r/Lyr0JJkRtsyf06QRJKopjS2rRjWSoYxHD5CWABbj7goomrF/1qlvCW8kC01AgoJ01wC7cvctW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvfkx8iZ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2e999729ccbso2972076fac.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749486409; x=1750091209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7ZUZBZdkXzdx2ADRuajM09Mw7d5pxcuVBK35puEztQ=;
        b=kvfkx8iZb/jTN0rBlz+FTCX4eyyq51kayaVqyyGC+et0nA5zWbz1Q07L5yCQxRy8eM
         A0qggEpAIkIrYaIVd1zSNlMiJksMY5/FyHkaSKjFS3AbIvxO0ZtDhze4WFfLI2cfw5fC
         ngFpQQNRBaqljIhR+3ziwwaVsrrgMIUojR4T2IuyHGISwO18W9xH1q9mQwCOWFbKYVEY
         qD7ZzEloGm9Z2aEHiNWBCjDe5PMWMw6uFPw2GfpjcMgLdTjScF0rFK8ITgxqBZFZPVmq
         gpoWAPy8Rh52ruMOH6B1IyqCnbs6fJjaZgMmX4gG4Hy1MT11+Ghszz7+gkET/1WwjvZ8
         rdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486409; x=1750091209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7ZUZBZdkXzdx2ADRuajM09Mw7d5pxcuVBK35puEztQ=;
        b=S9rff06iAPo0pmjzIYaciRBkzg4BGVLCQcRTS9oTL87zT15U5K+6faxrSFr4f+1JxK
         FZnJ/Ls1gHPmfeaTAQ//96cTZrWyF1nZFjH6ajLcYCyBqyulnQeTH6NnAyzLDm//QzyC
         TTL1CnkCHFrd2mRKgCrjpCYkTVNR28CC4RzxlDzC+giAGMs/aH4tBGV1sXDTO2lZ9bO9
         1rrb5Dk7c/slW+Y6h7WveZky2E2b9Plekqt1XXfbb2WU6Nb1jKK1cPU2MFoeWvERUWQX
         RIW2EjF4UnnKl4+KqruMACJr9pHDaiQG2raffRCAX8Z/2y/11yc3Ql8ZhFfBuTYqtFTn
         hFKw==
X-Gm-Message-State: AOJu0Yz4eJtzrC7a0ervN8NYMWe8k5G+jEQVISPBzqnoT6Q0zof9Ln4g
	Cdjr4vci94u0EjFE5QxWI4GzZ7y/bpw4TqXhBzVN5OqBN3QmboXpa6i92Wc67l5s2T4fCaI23CV
	JpO98MoSWlEI+TEvRG68KJIKoY4xqXnkmJuuNkPU8fZCnBI3vBpEUZYAq
X-Gm-Gg: ASbGncuwXylM7ZrWsAUDRMFizjCSaOH+2TMtCqc2MGSAIH0vydzA01M7EC3gTQomgLB
	np/QE7kyJHFENS88OIREn1Mi2GH5rsKWP0Dovqqm9uGEZW7RJjU58/PP2vvQ6xuY2U6C8IUfaQu
	aaaW4T2sDuRd5YOBAiL5glaHqFADTO5u4yfkhNQcNhjjZ0xngAzgeCmQ==
X-Google-Smtp-Source: AGHT+IELMjLLbLaPe3vutl0oqRX7AlPo090/idtmi0fvvAuvgYMBgP7IEJnlp2S8Cs+UYyn/TsOV3NhFML/zNkD8UEA=
X-Received: by 2002:a05:622a:5916:b0:476:7eca:57e7 with SMTP id
 d75a77b69052e-4a5b9d32438mr221202191cf.26.1749486397260; Mon, 09 Jun 2025
 09:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749466540.git.jgh@exim.org> <838b683c8a47d7df158c6a5da440f38b38096068.1749466540.git.jgh@exim.org>
In-Reply-To: <838b683c8a47d7df158c6a5da440f38b38096068.1749466540.git.jgh@exim.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Jun 2025 09:26:26 -0700
X-Gm-Features: AX0GCFsFOt3dio5o-RDNLdjOgReOI2dlA187dupVysp45vFQot1HWIv6TylYOB0
Message-ID: <CANn89iJe=CjG8Lt+XWDOtgd7MdHzCszSd-j-jn0KXtEzWeXJjw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] tcp: copy write-data from listen socket
 to accept child socket
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:05=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> Set the request_sock flag for fastopen earlier, making it available
> to the af_ops SYN-handler function.
>
> In that function copy data from the listen socket write queue into an
> sk_buff, allocating if needed and adding to the write queue of the
> newly-created child socket.
> Set sequence number values depending on the fastopen status.
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>
> ---
>  net/ipv4/tcp_fastopen.c  |  3 ++-
>  net/ipv4/tcp_ipv4.c      |  4 +--
>  net/ipv4/tcp_minisocks.c | 58 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 57 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 9b83d639b5ac..03a86d0b87ba 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -245,6 +245,8 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         struct sock *child;
>         bool own_req;
>
> +       tcp_rsk(req)->tfo_listener =3D true;
> +
>         child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, =
NULL,
>                                                          NULL, &own_req);
>         if (!child)
> @@ -261,7 +263,6 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         tp =3D tcp_sk(child);
>
>         rcu_assign_pointer(tp->fastopen_rsk, req);
> -       tcp_rsk(req)->tfo_listener =3D true;
>
>         /* RFC1323: The window in SYN & SYN/ACK segments is never
>          * scaled. So correct it appropriately.
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 6a14f9e6fef6..e488effdbdb2 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1747,8 +1747,8 @@ EXPORT_IPV6_MOD(tcp_v4_conn_request);
>
>
>  /*
> - * The three way handshake has completed - we got a valid synack -
> - * now create the new socket.
> + * The three way handshake has completed - we got a valid synack
> + * (or a FASTOPEN syn) - now create the new socket.
>   */
>  struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff =
*skb,
>                                   struct request_sock *req,
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 43d7852ce07e..d471531b4a78 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -529,7 +529,7 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>         struct inet_connection_sock *newicsk;
>         const struct tcp_sock *oldtp;
>         struct tcp_sock *newtp;
> -       u32 seq;
> +       u32 seq, a_seq, n_seq;
>
>         if (!newsk)
>                 return NULL;
> @@ -550,9 +550,55 @@ struct sock *tcp_create_openreq_child(const struct s=
ock *sk,
>         newtp->segs_in =3D 1;
>
>         seq =3D treq->snt_isn + 1;
> -       newtp->snd_sml =3D newtp->snd_una =3D seq;
> -       WRITE_ONCE(newtp->snd_nxt, seq);
> -       newtp->snd_up =3D seq;
> +       n_seq =3D seq;
> +       a_seq =3D seq;
> +       newtp->write_seq =3D seq;
> +       newtp->snd_una =3D seq;
> +
> +       /* If there is write-data sitting on the listen socket, copy it t=
o
> +        * the accept socket. If FASTOPEN we will send it on the synack,
> +        * otherwise it sits there until 3rd-ack arrives.
> +        */
> +
> +       if (unlikely(!skb_queue_empty(&sk->sk_write_queue))) {
> +               struct sk_buff *l_skb =3D tcp_send_head(sk),
> +                               *a_skb =3D tcp_write_queue_tail(newsk);
> +               ssize_t copy =3D 0;
> +
> +               if (a_skb)
> +                       copy =3D l_skb->len - a_skb->len;
> +
> +               if (copy <=3D 0 || !tcp_skb_can_collapse_to(a_skb)) {
> +                       bool first_skb =3D tcp_rtx_and_write_queues_empty=
(newsk);
> +
> +                       a_skb =3D tcp_stream_alloc_skb(newsk,
> +                                                    newsk->sk_allocation=
,
> +                                                    first_skb);
> +                       if (!a_skb) {
> +                               /* is this the correct free? */
> +                               bh_unlock_sock(newsk);
> +                               sk_free(newsk);
> +                               return NULL;
> +                       }
> +
> +                       tcp_skb_entail(newsk, a_skb);
> +               }
> +               copy =3D min_t(int, l_skb->len, skb_tailroom(a_skb));
> +               skb_put_data(a_skb, l_skb->data, copy);

TCP stack no longer puts payload in skb->head. This caused many
issues, trust me.
Please do not try to bring this back.

Also I see no locking there, this is racy with another thread trying
to sendmsg() data to the listener.

Honestly, I do not like this series at all adding cost in TCP fast
path for a very narrow use-case.

