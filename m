Return-Path: <netdev+bounces-85485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0289AF54
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C880AB213AA
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68D748F;
	Sun,  7 Apr 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXFygKIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6023D7A
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477054; cv=none; b=k0gW0JJzROgOH86xvaCKo6hzz43D+QxIybTHi8WVbQFVVzsdDBky2pA08f9jzxF8Y5m0Suor/9GT/O8G1Fs1v5eym/SbBxsx3cW6E0cxTCKPQdZqX9BW0Qdx1u6RsA1C3Lza3kiuo3w13EttqieGIhbpDGvPJ3/zmD0eBsFToPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477054; c=relaxed/simple;
	bh=OA11V4gZaC0bm4WHVue3hpnj7GvS2TWb/dX++M+X87o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN3FJzWB0D0azERbUBVVxQVywNgnFCMz/UrCpirVdANECULdll2kOGtoxxUtPrFCbMwwCuuQYrt/peqaS3ypK0tyzc8AOHcvpOVrZN9uxk7P8WLpDLRVwjCDx5ddEzf0vn/4C0L4E+y99560hLs6JxRFy5rAZweDiUfQth6giFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXFygKIw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d0dc0cf7so2632e87.0
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712477051; x=1713081851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7opS8tt3/PQ20Z3xJ7Gfy1IP3QyzeZYFCYGhZNGExoQ=;
        b=IXFygKIwITC96Hx8yWZZO+q0Xqasbsu2Yby87wflgfKQu04ukZH+Q73u2bCzE5PKqb
         1YUCRrUL5XPIxs8JjcwivtP4+damHhAmjA3F4NtHYoK7jqNy/rDo3M3kuv0tsNZEyMm8
         RUMjfoTZoWxh8wCyUtl5C/8hkPybkvjY9oH7bSeAzrmvuxqOI7vFJgDyq9B8LSI8kYsR
         4DkHPLz/UKj2Hl8PCJszCRHndhmzWqHe69HfiGTc08WyfuJ2bWdL3QofkeUnSrpe61pR
         +3tjRZxHvZ1eWOt54aA4buAlW+Mjl42UJcGuLWQ5/epLx8k+WrsTmJrh/W+9EAYnUkcq
         0GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477051; x=1713081851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7opS8tt3/PQ20Z3xJ7Gfy1IP3QyzeZYFCYGhZNGExoQ=;
        b=VcI/x+3Uq2Mt4xjWbPnn/4Igb3eexSok4sZIDD1qLWUXpk4cbfMN+5VH0n5ViMdgVW
         kC5G9cWhq/bG3cfj9tlQfABJQDeyq9dqkFzviedmDQKxS8WLdFmGXA9wqEnfQdAkeyUp
         oCgyasez7DE2PKUHpo6Imk7DChCI/aJtPI9qEtblybHDCje3GFP6gurw2dINXhiepEW2
         oY/YnQjAYUiaFWd2dWgIOopburcPeJJZxnAZQjIu9xZQK0nPkl16RVk5vZfyqEBkfss8
         MWds1vqJRXEYU0B0ckBVVKRaiVwnCMUIL2iQ7BYdw2Z0A/nQicDYQjLNyfNX/MFvVpUY
         EEQw==
X-Forwarded-Encrypted: i=1; AJvYcCVs/6ix4TO63opqaS0exYHLthC4m09y9ZnWB+YyooaweKTPqo6lTM2jS77LGqReHJKVVgvMzAro5RUG8Jg+yqunzMIz64l4
X-Gm-Message-State: AOJu0YyXnSF57vnLm2momyEK0hs0S74WuuzhiTnjL0J6nQUwVLDqQowH
	jpZyLwj9FB/JNWjXlOBImXnwthuvw3KNQpaWJcuoiSb9l4a+GIdlQ2F6IboiyEpS+WtJGsuOcsg
	0zFrLSZmPD7rneU8pvOvB9fXFrjQeyti2zoN5
X-Google-Smtp-Source: AGHT+IGRRJo7P3sVeNCQ/XYlsKR8vcOG2qL/HZ0hBv0CRlcLtL+naRfNOqrXmSjMli2jElawYhLN+iSonLgwCRehTsc=
X-Received: by 2002:a05:6512:3b09:b0:516:d099:400a with SMTP id
 f9-20020a0565123b0900b00516d099400amr130904lfv.0.1712477050794; Sun, 07 Apr
 2024 01:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406160825.1587913-1-edumazet@google.com> <66118ade17cd9_172b6329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <66118ade17cd9_172b6329459@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 7 Apr 2024 10:03:56 +0200
Message-ID: <CANn89iLeUSOhVRM=Fm3Fnq1qi68sqAqzAMqMZnbLHqJdcpUbWQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: display more skb fields in skb_dump()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 7:48=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Print these additional fields in skb_dump()
> >
> > - mac_len
> > - priority
> > - mark
> > - alloc_cpu
> > - vlan_all
> > - encapsulation
> > - inner_protocol
> > - inner_mac_header
> > - inner_network_header
> > - inner_transport_header
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > ---
> >  net/core/skbuff.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 2a5ce6667bbb9bb70e89d47abda5daca5d16aae2..fa0d1364657e001c6668aaf=
af2c2a3d434980798 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1304,13 +1304,16 @@ void skb_dump(const char *level, const struct s=
k_buff *skb, bool full_pkt)
> >       has_trans =3D skb_transport_header_was_set(skb);
> >
> >       printk("%sskb len=3D%u headroom=3D%u headlen=3D%u tailroom=3D%u\n=
"
> > -            "mac=3D(%d,%d) net=3D(%d,%d) trans=3D%d\n"
> > +            "mac=3D(%d,%d) mac_len=3D%u net=3D(%d,%d) trans=3D%d\n"
> >              "shinfo(txflags=3D%u nr_frags=3D%u gso(size=3D%hu type=3D%=
u segs=3D%hu))\n"
> >              "csum(0x%x ip_summed=3D%u complete_sw=3D%u valid=3D%u leve=
l=3D%u)\n"
>
> If touching this function, also add csum_start and csum_offset?
> These are technically already present in csum, as it's a union:
>
>         union {
>                 __wsum          csum;
>                 struct {
>                         __u16   csum_start;
>                         __u16   csum_offset;
>                 };
>         };
>
> But it is a bit annoying to have to do the conversion manually.
> And this is a regular playground for syzbot.

I agree, I am adding them in V2, thanks !

