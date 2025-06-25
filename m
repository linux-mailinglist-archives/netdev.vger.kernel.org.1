Return-Path: <netdev+bounces-201230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A711AE8911
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E6917A1E7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7571C5489;
	Wed, 25 Jun 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm6vA47H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79491CEAD6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867407; cv=none; b=Oz3AmBDfIgOQsIXInJi4VVrIM7lTL++gssarx2mpnubDdNCD0OwXuY0MsdwuBZ2iOXfci9UrlH/7++cV54rUgOGElJyVrqZbNnRzzQNlG74f2MTciC8UQhG7bre0zivibH5QepEAhSfC1TmwXqNZnOF6OCbluaULxWlEr1IDbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867407; c=relaxed/simple;
	bh=ps0c5fJmtFiQhgsgNiyDAw7N9pg5CL+LBJTcwKVj3wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSrrCLrNtxxQ0EckaEu/Mdf82RyVyh9bA8Aecyoxe2TVskx/LJcM5rwKhc91aMu9eHMmiQmh/987haifxapBgbj6yFQH/3Py/uvo6yvOSUZGBjBB5zcllLDSPU4kxZCFcc5U7GscVLpbB8aXMAV8nvYSzKv11BnS6wv9JEP8II4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm6vA47H; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a442a3a2bfso1482181cf.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750867404; x=1751472204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSYoPq4zo0mkb8XfZ9qxE0qbpBP7dRXASL6qsnF7ykY=;
        b=Dm6vA47HAocEhWXeE9REr7xnVkD39M7gS83ptIh9P/NvPp/0pPbrnuy9ZpUlRn1aWf
         sXga6cCqcMB9sGZfs8aFJ6EN/MGzFkjIWjOscic3bYxC5zrYHuNDhCXr4T85fjIkjYsx
         7AEYrnQfj94PnbGNO9zG/I10uafbBhTS52ddKhmX7g+sw1K7X/LS+54d31EJs9Qiq/B+
         LqmQ7svF0nuNcM+ITeJ8BGEAb0/tY5LTJyBR3GfyK7Q6U/3vZBsyvwXmmTt1qqX3Q2+y
         zuboZCSr6U5mufkwSGJROzPQ+omVFcN/mZcjWG0PGWrBLtJ9PjHk+7xjG444t24wH9R8
         7Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867404; x=1751472204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSYoPq4zo0mkb8XfZ9qxE0qbpBP7dRXASL6qsnF7ykY=;
        b=ojZCYEGe2MS0cSwooQ0IA+A3/1dj2GwNw6Tv4EctLzV9JBk4zl9MUyfsTYqdQZ6XU3
         Z/c0VvhXYZfuGUwiauyNaYDtbNNhkSp6kqsFyZPA4rs0sMJnJqrGnZLFIkrudUzeq18W
         YAlcDiN4Siww8kFbhGqKJkl67IG+HAyXeP1WHrsBpmdRaNxeiFZu0MYh8jJdm465xASy
         50tEa4jTorRd9GKQ+Iwf4J31iMZ123BGfuuiERY4YzyhRKw821ias7b5dfOBLFixqdj2
         Ujg3l9r2JYo3R8CBftCJtR7J6GIRXAIPUUOuRiO3BstUfx5SDRczWhEkYQMTzCwUyjKt
         kIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcQxRRZvJ2c4VtrtnP6HBbb+GCtzuOSIbjj5v7VbnJdiHnZjXODJm17XSkUGbHPnpPtXx4hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5pav+9h8ua7FT777sg+7/AYzHA+Bk+O440hgoLZRqvwMDm4D
	00sBq/BWPfkNRnLVmm+33uUNDVv7BxRWRIl5QARr7bV8lri+TBu/9EzmmHICiWmKsGsRcXq9Yms
	ZArD2J0jJnAdhauQmmtlubi1Kx740LnbY275q4uIB
X-Gm-Gg: ASbGnctBRuUlkbrqRFZPS1qhZ0g6g92r1b3A3Ng2Ykl5U4YkvVc7z7GYUkOWkwBBf3f
	/LpcFVH5ew/dU+nQsjPB0AmLNnvYSztoAlEwTvHbpXYKlfC6HH1iJj/Hjp7BBxH7BlycS8p8C0+
	dQOu+EnIgGZBElLtVN5b5jXoW0KFIdukgrdstWKzC9Fg==
X-Google-Smtp-Source: AGHT+IE9hj3pETZzgNRxZ9ATmZe4USbuR0UgwV7tomSG3LKgPATpikEwWMNTs3R4vF0lvnO45CiRdslDxMzt45kKIcU=
X-Received: by 2002:ac8:5dcf:0:b0:4a2:719b:1238 with SMTP id
 d75a77b69052e-4a7c06f04c9mr49189211cf.12.1750867404147; Wed, 25 Jun 2025
 09:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625153628.298481-1-guoxin0309@gmail.com>
In-Reply-To: <20250625153628.298481-1-guoxin0309@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 09:03:13 -0700
X-Gm-Features: AX0GCFvTdLRvVWatub4624qRGdWR0QP6u7VG6WHZKo_7YAwkHGX2hMIFXsCeAJI
Message-ID: <CANn89iKrwuyN2ixswA-u1AxW=BX8QwWp=WHskCmh_1qye3QvLA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: fix tcp_ofo_queue() to avoid including
 too much DUP SACK range
To: "xin.guo" <guoxin0309@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 8:37=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wrot=
e:
>
> If the new coming segment covers more than one skbs in the ofo queue,
> and which seq is equal to rcv_nxt , then the sequence range
> that is not duplicated will be sent as DUP SACK,  the detail as below,
> in step6, the {501,2001} range is clearly including too much
> DUP SACK range:
> 1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 1325288529,
> win 20000, length 500: HTTP
> 2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length 0
> 3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
> ack 1325288529, win 20000, length 500: HTTP
> 4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
> {501:1001}], length 0
> 5. client.43629 > server.8080: Flags [.], seq 1:2001,
> ack 1325288529, win 20000, length 2000: HTTP
> 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
> length 0
>
> After this fix, the step6 is as below:
> 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:1001}],
> length 0

I am not convinced this is the expected output ?

If this is a DUP SACK, it should be :

Flags [.], ack 2001, win 65535, ... sack 2 {1501:2001} {501:1001} ....



>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
> v1: add more information in commit message
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 19a1542883df..f8c62850e9ca 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4846,7 +4846,7 @@ static void tcp_ofo_queue(struct sock *sk)
>                 if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
>                         __u32 dsack =3D dsack_high;
>                         if (before(TCP_SKB_CB(skb)->end_seq, dsack_high))
> -                               dsack_high =3D TCP_SKB_CB(skb)->end_seq;
> +                               dsack =3D TCP_SKB_CB(skb)->end_seq;
>                         tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack)=
;

At a first glance, bug is in tcp_dsack_extend()

