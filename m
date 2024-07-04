Return-Path: <netdev+bounces-109141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FE19271F9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D2A1C20884
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B641A4F0F;
	Thu,  4 Jul 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcDFWMe9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FF1A3BDB
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082710; cv=none; b=GXH/hX87XsCVO6Y45b1fZN2XohhYROIWIuC8YOM7LZCOtL5yg1Ux0P2w2UxRBjGG9Hw4HBOUmCjLtNCl6ijTNY+NM/u3NNZ+SwnT8mGcbO68rlLoemglwnZsRZEeyhzjWtI9ePIv448UPvYjoAfurTcPsXLu0dVZXSy2KMGcdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082710; c=relaxed/simple;
	bh=cz1XYFeiE/QYzcIRVSjhvWwwQUh1Ate7NFWjrvrI09w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNUPEJUTu27V8KMGO4PMN/Xu20NT1eaC7xfb8gfbr919f6j80ORzNxInVJp88FM3KkcdyMmWXFExwsLhW+w8EvXT4HmAWJUohj56+Wzb+p6JNtFDiQlqNtF4OAdLnue+8biFCmBFJ2FI0onJVuqWsegLu4fmcPvgKR6+4Gr4ir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcDFWMe9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so8578a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720082707; x=1720687507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/bfx/yRssBehmhvd03toXyuldZJ17uvDNQzkz5wIbY=;
        b=mcDFWMe9WTXcbyL+V8IvHd2nAIeFIde8Gr1sfT7OlW8RlhbcVKzAtBAJkZTplORY7c
         0bSCRjERU7YA/KlPDGEI0QS9g2A9LA92XBRNgj28yr/n5g/BvkPi2j1wB8gl6pcOcwQX
         V4lZgcrHJCOXaQesmYokW2iN1KwB9l9o7lugu+hT7+m5vAUoQrETktSCx5QIBzc9dOFz
         7O7728krKLcoKguOXDMuuE5Y+T/60cQqLnO3KFxQxoSsYjfQNCIdVC+i0ejTjo0aBiQ9
         LRX/bDe02wqiX0DX+xqwvbftR9mjEmXePauIX/JlP8+uIG5gC2XgLUYRvEkVQn7ASx6g
         x3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720082707; x=1720687507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/bfx/yRssBehmhvd03toXyuldZJ17uvDNQzkz5wIbY=;
        b=G4uUzP1ud9O1hhOeFNb6ty2jIty1vbYZ/IG7bAjXvMfgbCFWWbH/iaJaKyoS7nmhDt
         fLLcORSaJYZmPr6+jQjzzx0pxrlrtZ8sMFCS1ym2HawTi2iE6DqpZd32ch/n1V1Zlw3B
         HPh/KxDa/vmJsdq+rtsZZ9lnZBr7hRkJ/sjKJ6Wj1tttAvY+aivEbAZiPSLKGvM0I9V4
         m+fC0v8LPfbXixY69LJvqhJLz9Yd3pCXs6Icp+gWOBwwOAuOG3mqq+CUzoPFyi+w79E+
         0dvv3e5OInEnKG3aBjjxRQ0jZbM4ssoqOkJM3lv4ud8mmdQxa1rzfZc2kO5mnYb8lWgV
         k8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/QJQiQzoxeBdGTpwpolUczdvMfee3jGvopG0GNvunDUEx/wrVQ07amAvkeS7mQtSqvZ5AIMouGROKb3Xs59IAJ6WxMprR
X-Gm-Message-State: AOJu0Ywxn2s8UbHN6Mwa0O/YMrOpH7I5HR+ZKFhuPRmK4/pNKyvBLOBO
	5/uriUZ75BBYu174W7vpXjI7xm+c78L5yuupTKGla7RCM+MkFqbHetcQ2GqjiJxGKTYVDX5C/2K
	zLXJbaXkHGymRx5pk6Ru64B7ZsKYvxpf/AZS7PEcxhgON/sP12A==
X-Google-Smtp-Source: AGHT+IHEk6wLHuzGL9ZVIheZxwIKvyuNPvN3E7M2ztbpxkwfBph4DZrGwsQqA2w+aJFvOUOlvoGwRvm0tfb2RHL/TyQ=
X-Received: by 2002:a50:9f4c:0:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-58e28f6168emr72261a12.1.1720082706879;
 Thu, 04 Jul 2024 01:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704035703.95065-1-kuniyu@amazon.com>
In-Reply-To: <20240704035703.95065-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jul 2024 10:44:55 +0200
Message-ID: <CANn89iJhX=ck_XD4Gu7B_1401e+y4NSE+8CAD_Yu4PMO4-H-eA@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 5:57=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> RFC 9293 states that in the case of simultaneous connect(), the connectio=
n
> gets established when SYN+ACK is received. [0]
>
>       TCP Peer A                                       TCP Peer B
>
>   1.  CLOSED                                           CLOSED
>   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
>   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SENT
>   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RECEIV=
ED
>   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
>   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-RECE=
IVED
>   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTABLIS=
HED
>
> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such =
a
> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challeng=
e
> ACK.
>
> For example, the write() syscall in the following packetdrill script fail=
s
> with -EAGAIN, and wrong SNMP stats get incremented.
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>   +0 < S  0:0(0) win 1000 <mss 1000>
>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscal=
e 8>
>   +0 < S. 0:0(0) ack 1 win 1000
>
>   +0 write(3, ..., 100) =3D 100
>   +0 > P. 1:101(100) ack 1
>
>   --
>
>   # packetdrill cross-synack.pkt
>   cross-synack.pkt:13: runtime error in write call: Expected result 100 b=
ut got -1 with errno 11 (Resource temporarily unavailable)
>   # nstat
>   ...
>   TcpExtTCPChallengeACK           1                  0.0
>   TcpExtTCPSYNChallenge           1                  0.0
>
> That said, this is no big deal because the Challenge ACK finally let the
> connection state transition to TCP_ESTABLISHED in both directions.  If th=
e
> peer is not using Linux, there might be a small latency before ACK though=
.

I suggest removing these 3 lines. Removing a not needed challenge ACK is go=
od
regardless of the 'other peer' behavior.

>
> The problem is that bpf_skops_established() is triggered by the Challenge
> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> check if the peer supports a TCP option that is expected to be exchanged
> in SYN and SYN+ACK.
>
> Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid suc=
h
> a situation.
>
> Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> Fixes: 9872a4bde31b ("bpf: Add TCP connection BPF callbacks")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/tcp_input.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 77294fd5fd3e..70595009bb58 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5980,6 +5980,11 @@ static bool tcp_validate_incoming(struct sock *sk,=
 struct sk_buff *skb,
>          * RFC 5961 4.2 : Send a challenge ack
>          */
>         if (th->syn) {
> +               if (sk->sk_state =3D=3D TCP_SYN_RECV && !tp->syn_fastopen=
 && th->ack &&
> +                   TCP_SKB_CB(skb)->seq + 1 =3D=3D TCP_SKB_CB(skb)->end_=
seq &&
> +                   TCP_SKB_CB(skb)->seq + 1 =3D=3D tp->rcv_nxt &&
> +                   TCP_SKB_CB(skb)->ack_seq =3D=3D tp->snd_nxt)
> +                       goto pass;
>  syn_challenge:
>                 if (syn_inerr)
>                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> @@ -5990,7 +5995,7 @@ static bool tcp_validate_incoming(struct sock *sk, =
struct sk_buff *skb,
>         }
>
>         bpf_skops_parse_hdr(sk, skb);
> -
> +pass:

It is not clear to me why we do not call bpf_skops_parse_hdr(sk, skb)
in this case ?


>         return true;
>
>  discard:
> --
> 2.30.2
>

