Return-Path: <netdev+bounces-148637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C79E2B59
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2318D163B78
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE121FA177;
	Tue,  3 Dec 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKbvqtPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1701362
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251774; cv=none; b=URQEiye49YRt+0kwOeB4N/mAqkFO/1i/63be3zRjJZLxoyfnI7ykWTAicw4qERzT0VHFhFjBLy2DRs7kB1+k4bM3Np7Ff4P7aNkTD6NzJA4/seVckTSaInoBHFieFCX9zDZG7SWj9UdfyQfuLqysY2NbHBcyTalCL8vbNFNMIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251774; c=relaxed/simple;
	bh=M4qITtnES7xCFeAZqFvSzz18GVdqf3EvbdoAZGCNTGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndMggVgfvpNEzqFkJyDZnrvBK6nTORtOrSD75fd4Rp4hKMY6Uhke4a8npBSQpG0/A7HR5wLktqkHdQEfw29AA5DE2N66HUCQWnL6T56WPmBYHXPwJFyOtbErVuNpOL24EAosxnMfDu82BjwCT08B8ZYjJyNStmwWahKIYsudoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKbvqtPr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a8640763so50044725e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733251771; x=1733856571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thSqbQjoOYsFydcpCQhEBnXOUDbYt9Tm54/71p4oXVA=;
        b=oKbvqtPrJmfHeC8JvDy0SGlau52tQvUD1h3pHtKwTt6oXn0pfJSmEOcQKplLd/Pmau
         4NV4zFOVdZQfml4L+0hDxNLM9dMkSgdiyXSqot0qdz6e2CD7yTLJ2T8U0pgha7BpAq+4
         tpaoHXqzt2lFmkJnA7uAzHdzG18keY20sAWsovMa3BHmexkwDBnjku/XuuMuDfOkQxVn
         USkZJN3j+ml5lvIzgkeHM49x5V6Xl6XdQ27S5BCv+HaQMilesXnKXEoEfOTHpV2UuUrG
         +JVjXHn7gO6Sd718IoHqLCfyHxwn5Aza8xLXTW6o2t0GF/qH+vGuKLw5szt0qkvFiVYo
         AaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251771; x=1733856571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thSqbQjoOYsFydcpCQhEBnXOUDbYt9Tm54/71p4oXVA=;
        b=j9z99cNFFboEj8LhCbrJNaPbK3luUNmLMl0fUebWNNcLBkpn82B/nCv8Z7rtaFclYs
         8GZDjXHDQb73T6BHHCEXlJiG06Q0wftFJU5CHyJTpx/PSnhl8gVu7/Z1/2PJ5Cs3F/B+
         NDMgpiJh4noQiE0Gw4BGuqD++s3wGrD6YG75wse81AW5w/Bozyg7/P7lT3it88l0TBRK
         oglHo9x00+0EEuSb5ijiERFYjSML9MgL1bSp1vpR7x8O+X3EBO2Zmxv5Kk2PIxpAfYrS
         AOlm62fCW931TCGu43ZBrOeH1RbtXW2yZROd05uGhFDUXXbwngVLRXO/AXfAOmHhbbWK
         7Yrg==
X-Forwarded-Encrypted: i=1; AJvYcCWGeKuGbIoGsM6Jl4ZHlwh8NmzJy9jHQxHpSjQbo81yyiHCbd7dLwjE8PrG0fGv2S2l2S7vroM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreOiaBRsv3bOrAvVT91lcTHIEw35lne7fjIze1Fx12VKWZ7FS
	lstnPGysbNfhgdbhdeIvwSdBwXGP7jqbOlqbFOfnr9HVCT3CIWJ78r41GsduLAWby5CFmytmWdv
	Y5h0xYb13RbZapqCj2fBtKbMaePvtEWdPimzfXpABTeSfwG56KQ==
X-Gm-Gg: ASbGncug9zdnh1fOCkkq2P0GWJtCA3bKlPtfncU5OH27/7aFjtErRpYzSZeFdm1Vvo2
	spXj2zv/njm90AU0JwDlNRpPEZXw2ik0ePajmjMhXLgaZqokP8DKBYOLdjFBD
X-Google-Smtp-Source: AGHT+IHpwUj1n3HR/fT6ZhBlnLtRvznJIBv20w7oRFmmrltUqPgU+1F0OlSvDAo1FenF7PIWotv4E5UoxC9yVUZAkm4=
X-Received: by 2002:a05:600c:3b18:b0:431:5a27:839c with SMTP id
 5b1f17b1804b1-434d09b1564mr33847945e9.5.1733251770587; Tue, 03 Dec 2024
 10:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203173617.2595451-1-edumazet@google.com>
In-Reply-To: <20241203173617.2595451-1-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Tue, 3 Dec 2024 13:49:18 -0500
Message-ID: <CAMzD94TUrgWaJ8y-ROYKLCWJCn_9ykf15jTvGs4HYdd=K4_OpA@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: add indirect call wrapper for getfrag() calls
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> UDP send path suffers from one indirect call to ip_generic_getfrag()
>
> We can use INDIRECT_CALL_1() to avoid it.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Brian Vazquez <brianvv@google.com>

> ---
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Brian Vazquez <brianvv@google.com>
> ---
>  net/ipv4/ip_output.c  | 13 +++++++++----
>  net/ipv6/ip6_output.c | 13 ++++++++-----
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 0065b1996c947078bea210c9abe5c80fa0e0ab4f..a59204a8d85053a9b8c9e86a4=
04aa4bf2f0d2416 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1169,7 +1169,10 @@ static int __ip_append_data(struct sock *sk,
>                         /* [!] NOTE: copy will be negative if pagedlen>0
>                          * because then the equation reduces to -fraggap.
>                          */
> -                       if (copy > 0 && getfrag(from, data + transhdrlen,=
 offset, copy, fraggap, skb) < 0) {
> +                       if (copy > 0 &&
> +                           INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                           from, data + transhdrlen, off=
set,
> +                                           copy, fraggap, skb) < 0) {
>                                 err =3D -EFAULT;
>                                 kfree_skb(skb);
>                                 goto error;
> @@ -1213,8 +1216,9 @@ static int __ip_append_data(struct sock *sk,
>                         unsigned int off;
>
>                         off =3D skb->len;
> -                       if (getfrag(from, skb_put(skb, copy),
> -                                       offset, copy, off, skb) < 0) {
> +                       if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                           from, skb_put(skb, copy),
> +                                           offset, copy, off, skb) < 0) =
{
>                                 __skb_trim(skb, off);
>                                 err =3D -EFAULT;
>                                 goto error;
> @@ -1252,7 +1256,8 @@ static int __ip_append_data(struct sock *sk,
>                                 get_page(pfrag->page);
>                         }
>                         copy =3D min_t(int, copy, pfrag->size - pfrag->of=
fset);
> -                       if (getfrag(from,
> +                       if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                   from,
>                                     page_address(pfrag->page) + pfrag->of=
fset,
>                                     offset, copy, skb->len, skb) < 0)
>                                 goto error_efault;
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f7b4608bb316ed2114a0e626aad530b62b767fc1..3d672dea9f56284e7a8ebabec=
037e04e7f3d19f4 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1697,8 +1697,9 @@ static int __ip6_append_data(struct sock *sk,
>                                 pskb_trim_unique(skb_prev, maxfraglen);
>                         }
>                         if (copy > 0 &&
> -                           getfrag(from, data + transhdrlen, offset,
> -                                   copy, fraggap, skb) < 0) {
> +                           INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                          from, data + transhdrlen, offs=
et,
> +                                          copy, fraggap, skb) < 0) {
>                                 err =3D -EFAULT;
>                                 kfree_skb(skb);
>                                 goto error;
> @@ -1742,8 +1743,9 @@ static int __ip6_append_data(struct sock *sk,
>                         unsigned int off;
>
>                         off =3D skb->len;
> -                       if (getfrag(from, skb_put(skb, copy),
> -                                               offset, copy, off, skb) <=
 0) {
> +                       if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                           from, skb_put(skb, copy),
> +                                           offset, copy, off, skb) < 0) =
{
>                                 __skb_trim(skb, off);
>                                 err =3D -EFAULT;
>                                 goto error;
> @@ -1781,7 +1783,8 @@ static int __ip6_append_data(struct sock *sk,
>                                 get_page(pfrag->page);
>                         }
>                         copy =3D min_t(int, copy, pfrag->size - pfrag->of=
fset);
> -                       if (getfrag(from,
> +                       if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
> +                                   from,
>                                     page_address(pfrag->page) + pfrag->of=
fset,
>                                     offset, copy, skb->len, skb) < 0)
>                                 goto error_efault;
> --
> 2.47.0.338.g60cca15819-goog
>

