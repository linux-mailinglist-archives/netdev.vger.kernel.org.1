Return-Path: <netdev+bounces-218632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F65B3DB36
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AE0189BFF6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5A26F293;
	Mon,  1 Sep 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoIHldoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B48267AF1
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712285; cv=none; b=P4TCMSmckfqjWL9sDDEzhPsTAvxCSvDNLkU0tbBG2u132dFO92jVk/YD3ZEcsiHQt5//W4zoqtHZM/H/zFX9WR/GiJZezt3SnYHb/L/EVncXAj2xzJAnRamxRN5QAXldcvYufBvF6SphkyIUXZu+PvU1UWfJf5ShkigXeDM5+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712285; c=relaxed/simple;
	bh=WzfW40AZj4gPjN0MUg3o+yqK/+B/OT5Q7UpvUVPe8oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQNnMWvDclHaNyVEoNbgUJcbdv0EsT05KjvvWngBvEdW07IG6y0DJc256YYpFpPvEbWIt39Es/O0Lss1ZS3FkB5Lbdw+ihWT2BHWv/XuG+TmPyZSKmvgZR3VjdXU1GTT7tPWGIPqyPM3nBFyjAvkTMFPTiERaTg5Rgg6nbNNvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoIHldoE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b2f0660a7bso38499641cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756712283; x=1757317083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q7Kl5djn2WgPJ4cdJmkEnqgC+STRWJseSy7eNtKfiA=;
        b=ZoIHldoE4OtEwoVNTtDxzFHfePWLl8GYRBZOmq9MVfG5gMXB+/iN6gOv6cb41P4g98
         FUtpZMQPHZY4tls3HxBDujX6LPerx3SYsA7kN6DUH8AW4BP02Z9nQGJY9DwMq4mgYRTH
         5S48mS/QSxtUlJJBUspoKXcDCpVTP73WWcZ0b87zVIlAElp4UK3PZE59AV8DXGzORcDh
         L/v+7kCjfdYhlldxO/Rxez6ONIEH+WhNyYTjFbUZSTdOH/IT9nRgevi1hJTpzVfdfv9L
         VUx6mf79Ubmb+svzi1lbSbwjWetF0mv11udoChe5tI+y8e1lElYI1VzQ58jmhfMt+vfw
         elsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712283; x=1757317083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q7Kl5djn2WgPJ4cdJmkEnqgC+STRWJseSy7eNtKfiA=;
        b=G8PnBOEywOjgQqGOoY5uJlE0Hbasf72DiILrtNDAvsy3r/vuFT164Rm45dcDyzTAh3
         BMGaXck5HhdQd7b2KQ3cIWvWuEC3boSW9CQAjowHzEBP2CT97A760sBuKj/7ISdcgdqD
         tOMfZFkywmfqCyUt2r7Bf3aOdafhYBs8RUGrXe/o+7XJxpDy1v8U1M2jbR4+Gux3AC3W
         hZDJZqcxYs1B9jWgpxrr7KnqC9LnijevBz12HjIMOfqhkREO9f/aqvxONGHIuGT3O0gj
         LKTpBtuBa8GABPHFjJoGwotWQE0eZUbKr6CFcQ4eXeEIL2vNBA2e0K/amupqrl3zTkhe
         +chw==
X-Gm-Message-State: AOJu0Yyc4f2L/ORdXGLFPgGrW0VqcIVxcIZPqO8+znpt4WtvcuZ6X946
	/xE8CkvCj7HRHrJIKNk7BL8gvsfdhhXdtRrs+SFDXy04RSa4BEu6/raGMxE9/mtEOklDJDNy8k9
	Q+Ay26GzHMsSFYF9FnOMoJDYvdkyPBqv6/IatEaEQ
X-Gm-Gg: ASbGncsPpOGN4LHl9ZVI4AhGlHvhEyqwUza0O5QRzE6axburUMHYJX7RXPEdwKAePz9
	bW9ndNkz6qAkho1ePXH4pNpZqLUKNRnD8zmFGSs2F9amR/byAGKEY6hlWGKh7FChoKQSOx5ARgn
	LtPqABZxY1g8RXiqxQvusH9TIZd5koK7YGjpe46Ijks6Ur4l9cTrrs81j2NKsBdJF0HuVUGKK4Q
	DBjT6S0q6Bx0w==
X-Google-Smtp-Source: AGHT+IGzV6ATmp61ewbLzWto0qipug1G5shAQMh1uxcEylMfvmjc0KzUnlWIJKtFhfSJ0DazP+bJFRjB/3sgo7tLmGo=
X-Received: by 2002:a05:622a:4c0e:b0:4b3:19b1:99d4 with SMTP id
 d75a77b69052e-4b31dd773bdmr95750161cf.80.1756712282420; Mon, 01 Sep 2025
 00:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827143715.23538-1-disclosure@aisle.com>
In-Reply-To: <20250827143715.23538-1-disclosure@aisle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 00:37:48 -0700
X-Gm-Features: Ac12FXwEBF4lffbGsQAW59JN0B7gOKoWwGphyL_Y5FDSSgXmBtkMqJYMWifcp7Q
Message-ID: <CANn89iJM3CV-_2jWMMspH52RvfWtep-3srctf47NkYUkTTboSg@mail.gmail.com>
Subject: Re: [PATCH net] netrom: validate header lengths in nr_rx_frame()
 using pskb_may_pull()
To: Stanislav Fort <disclosure@aisle.com>
Cc: netdev@vger.kernel.org, security@kernel.org, kuba@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:38=E2=80=AFAM Stanislav Fort <disclosure@aisle.co=
m> wrote:
>
> NET/ROM nr_rx_frame() dereferences the 5-byte transport header
> unconditionally. nr_route_frame() currently accepts frames as short as
> NR_NETWORK_LEN (15 bytes), which can lead to small out-of-bounds reads
> on short frames.
>
> Fix by using pskb_may_pull() in nr_rx_frame() to ensure the full
> NET/ROM network + transport header is present before accessing it, and
> guard the extra fields used by NR_CONNREQ (window, user address, and the
> optional BPQ timeout extension) with additional pskb_may_pull() checks.
>
> This aligns with recent fixes using pskb_may_pull() to validate header
> availability.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---
>  net/netrom/af_netrom.c | 12 +++++++++++-
>  net/netrom/nr_route.c  |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 3331669d8e33..1fbaa161288a 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, struct net_devi=
ce *dev)
>          *      skb->data points to the netrom frame start
>          */
>
> +       /* Ensure NET/ROM network + transport header are present */
> +       if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
> +               return 0;
> +
>         src  =3D (ax25_address *)(skb->data + 0);
>         dest =3D (ax25_address *)(skb->data + 7);
>
> @@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, struct net_devi=
ce *dev)
>                 return 0;
>         }
>
> +       /* Ensure NR_CONNREQ fields (window + user address) are present *=
/
> +       if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {

If skb->head is reallocated by this pskb_may_pull(), dest variable
might point to a freed piece of memory

(old skb->head)

As far as netrom is concerned, I would force a full linearization of
the packet very early

It is also unclear if the bug even exists in the first place.

Can you show the stack trace leading to this function being called
from an arbitrary
provider (like a packet being fed by malicious user space)

For instance nr_rx_frame() can be called from net/netrom/nr_loopback.c
with non malicious packet.

For the remaining caller (nr_route_frame()), it is unclear to me.

