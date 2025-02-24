Return-Path: <netdev+bounces-169009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18946A41FDD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5216FEDB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1512233736;
	Mon, 24 Feb 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/e4hWjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656C221F2E
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402063; cv=none; b=Bg+bbfmuirg+gYtb2PCkPULRXCa/lnZuo1BOjdvkUCUtmQGjCR2K52cnNh80ccZl/fIF9/L+6yb0GpgFHyx4muULGTuAirnG9xPeQYobSSvm/eT8US4h5c6HTBWxHe5u8vj6K7OzErl3AYvkU0IjffA5XRKxn8ntU9ZX3Tsc+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402063; c=relaxed/simple;
	bh=VLAsrmSAb3kGU++2nwWF9OOXrMTkn8/dEIc9dcvkfZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+95xTvhLUwjA+4wI4fLmGgE09gApTHd3uKJkAJBcmvijyA188vwEpb9gRbcXCkzYW1IWjUJpRTQXH65DIZwrPENSky1cJw/Bark0/SEabUDiDBUGdzFyHL4liDskMlNuqwxZRpvmRSUGbGlyFxydslZ9V2/NHQ+O778bfCZGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/e4hWjb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so9812969a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402060; x=1741006860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhW5lfJWyyYPvccFPixIiNXBgnolkSq4aXYrSR9SgFo=;
        b=a/e4hWjbw3SCOQKLAOSA2deLBukfIRHLaufE/ILL++8Licuw30hnwLS6iDdlvbiV86
         qdQpGQMTqkwwoFlWxumbygs0GtgVmMHXj43PI3TyQNfuNP54q52LMyCxaUJXev6ejHLY
         jUnVZ4G5SjQjwpu1daxW4ufP5WuDN3sRZkXlq9260CxJfyqi0kWuWySaVpqJfRjLiaG9
         jCKxr0HHaIZWU6edb7NH8UvtVjwM2bi+LqMC/+V/r2q9v4JxLNYesSsTJAvJ0uEnh7AE
         mkkOFAJ02Aus0ezeEoy4U3QYky40qLgQXqisauPerKyV7h+j/G4lbeLqGphULqNzNLtK
         vemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402060; x=1741006860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhW5lfJWyyYPvccFPixIiNXBgnolkSq4aXYrSR9SgFo=;
        b=ah2N6A8l3PtuenIYiXdYW8oIj5jxhrTvveUS0fFUDeFmjbRflLs8YTLvWlevBntfeQ
         +xX0iExigoeipI1gLbi0u23OcMh7zpg6bTXZMzo+oi7cVZsTSkEVNOpW73j92St4yHER
         BO6/XqvHxAfo9TpZIwAMGAA86zqz9geJjgt1sc5eZ2Mvbqp7XXw0i2gAStoWU9iffzL7
         /M88mK1TKIol02Vg3QR2yZiJjzJEuDTxUymOVGM9Xkyw9J3fLuhAj8ISXw6wN/5eBDCi
         4ma0CS6juRWjFiZiRLK0j9/cB7hy1ao2RTYPHIVYd2RON598qyMzst6Vz2VRLeZ2zH5Q
         eI7w==
X-Gm-Message-State: AOJu0YwbrAAdHvR7hlAaQ3m8+nLG8ea81YuM1vq+gIwxDHyiIxuAIYGi
	y/1tG+83+bCdDuQsyStS4C6fWmK9wj+uCLu8OCuQR1vrDh63I6cutizxDn1fgcyygRCRiWjZxwu
	X74OPxuWvQ+QzHZO4OIJ6enN6KhdVBr0KXO+jwxIrzEgU95r0R6gLVPo=
X-Gm-Gg: ASbGnctSkbTYKt0B50kEsjsBJZ2f9HnD9BneeF6haz36OvD/5fQqnkIl1bakOsyAa/1
	ZL0FDytbnswvmlCVjeN94YQ1W6QLR0XGTd7lcr/KZa+6z9Hin+WRa8AEYrFvNG0We98rjQU4xuX
	MOEOMoZQ==
X-Google-Smtp-Source: AGHT+IFxP6DKH9JVVKKeu9MfUZc742Xg3JoJpQSL6FzFgLaRmR+KL/fy1Rt8P0ne+rwSe6Uj+SiEwuDzYufljb0FcKg=
X-Received: by 2002:a17:907:c49b:b0:abb:8926:5b9f with SMTP id
 a640c23a62f3a-abbeda29d05mr1318984066b.6.1740402059256; Mon, 24 Feb 2025
 05:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224112046.52304-1-nbd@nbd.name>
In-Reply-To: <20250224112046.52304-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 14:00:46 +0100
X-Gm-Features: AWEUYZnf60BoIkKhs_5P3lIQAgrUMsntAC8uHFiAbLzqhf9ShLWOsjDaDtw-1wY
Message-ID: <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: fix TCP GSO segmentation with NAT
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:21=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> When updating the source/destination address, the TCP/UDP checksum needs =
to
> be updated as well.
>
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO pa=
ckets")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv6/tcpv6_offload.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index a45bf17cb2a1..5d0fcdbf57a1 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -113,24 +113,36 @@ static struct sk_buff *__tcpv6_gso_segment_list_csu=
m(struct sk_buff *segs)
>         struct sk_buff *seg;
>         struct tcphdr *th2;
>         struct ipv6hdr *iph2;
> +       bool addr_equal;
>
>         seg =3D segs;
>         th =3D tcp_hdr(seg);
>         iph =3D ipv6_hdr(seg);
>         th2 =3D tcp_hdr(seg->next);
>         iph2 =3D ipv6_hdr(seg->next);
> +       addr_equal =3D ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
> +                    ipv6_addr_equal(&iph->daddr, &iph2->daddr);
>
>         if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
> -           ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
> -           ipv6_addr_equal(&iph->daddr, &iph2->daddr))
> +           addr_equal)
>                 return segs;
>
>         while ((seg =3D seg->next)) {
>                 th2 =3D tcp_hdr(seg);
>                 iph2 =3D ipv6_hdr(seg);
>
> -               iph2->saddr =3D iph->saddr;
> -               iph2->daddr =3D iph->daddr;
> +               if (!addr_equal) {
> +                       inet_proto_csum_replace16(&th2->check, seg,
> +                                                 iph2->saddr.s6_addr32,
> +                                                 iph->saddr.s6_addr32,
> +                                                 true);
> +                       inet_proto_csum_replace16(&th2->check, seg,
> +                                                 iph2->daddr.s6_addr32,
> +                                                 iph->daddr.s6_addr32,
> +                                                 true);
> +                       iph2->saddr =3D iph->saddr;
> +                       iph2->daddr =3D iph->daddr;
> +               }
>                 __tcpv6_gso_segment_csum(seg, &th2->source, th->source);
>                 __tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);

Good catch !

I note that __tcpv4_gso_segment_csum() does the needed csum changes
for both ports and address components.

Have you considered using the same logic for IPv6, to keep
__tcpv6_gso_segment_list_csum()
and __tcpv4_gso_segment_list_csum() similar ?

