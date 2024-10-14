Return-Path: <netdev+bounces-135215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE799CDAF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8FC1F23B4F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558C1AAE37;
	Mon, 14 Oct 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zhW+SHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E441AC42C
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916501; cv=none; b=DtoiqmFzcYZ4y4zjBlsoy5ew7xhCHlpgy1Nl0FM4scKF+zhV8U3Tl+a8UaGFU8UMgDZ8Dlafu4DoaJUjeEwGpiJ8qHqCUK4nkLvsyupk8e9kPNck5dRuIElf5N8YLL6TnMpLo9EEaV5K9Knfjval1OzaZJB99yCASe1Z43yanCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916501; c=relaxed/simple;
	bh=aQYcg5R22II1OX6DrSmc8zCDvj+qvptHyVXjHz5pHbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii18qEhAKkusdFBj5e6Eo1ZwgNWDun6bnqnjDGy5A7zbaJCeDKb4FsRhifpgqUjUS8TzwRTPswbPHQEf2lid5ZRNKCcpl2vIsY1CwPmyJktWYrFigWsfSlRqFga5qADocqV2/A4PQeahRSu7xeuWOBAqZ6eSTREONdCVauugspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zhW+SHf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbceb321b3so35735706d6.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728916498; x=1729521298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIXZBJC5MsAuUOIkx6KZJ12XWc+YfSBNkdgu5obR6qQ=;
        b=3zhW+SHfS6IVrqjDA8ulBEBJiQz1aw8Frhgx3BGy8NOt2vf3EUpmQVQKx2NKGuy/b2
         MYhKZXULiRFJn609AdDpL6NeKV7O55rEH5vUBgO/VX44BqM5KXRWqruoqFAM25vkn4/8
         9BqsiFToMWAd98u3hEVphj81ebe4n+shUYE6gwQcrkeq2Vld5Ban0W0tFX2Mpboqwt+2
         JW6mCNHYJVSExlIB3PeiWydlijnWqhpfPG9W7bnhCs27+Sszqdfb/DMeiGJgg1tKuSBr
         JNsn7IuqHHYx1BD+JO1F/ygx8yrjY6DfVywR3rSchxvCtQyfmsTgNT83IowWLgCd9jpE
         rT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916498; x=1729521298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIXZBJC5MsAuUOIkx6KZJ12XWc+YfSBNkdgu5obR6qQ=;
        b=akZGyU3m1KW2LkBNmmeTBun6ud49cFIu9psmu+YB8y5WrrJcr7ZFVBQgZrhgqgx70V
         PvnRuZ1FL3sVIfFSWvQKVi0sf4QHSZkKd6k2n/MO8toPoDPCxPKq8JTu9yjsEgajk0aI
         JsZfhLh/KcljpzvFjquGM0Pm4Wws/lEo6hH/l8eyrZKOqH1TV+6oy/XoEznxfG+UyCzL
         ds1h0TIl/fpJpqUhqtBk40qkVNZVHa74Ykfhs08m9sh77LEWBIrayJfIfFF+HxHmQvKh
         h76tUyRF9Vc7zcBDUx28rtMmrd3aKCodySeL6P9Q7znFUmc7JURmqmaFtPHJVSqEtd/H
         L6dw==
X-Forwarded-Encrypted: i=1; AJvYcCWvlUPf/e857dKEKpgngMdkXmYAhxJuSSKRWn3L+lBNSSTjut+qt7+aGXyC026VHG17xxSINDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzonPQIkQvWxF0f6cbv2zI1C5Oqn7dLYp2B+u0IHH4lMxqjWiM2
	5y/Vyth4V1sk4ZGISB4ZJ1jOpTRWCQcNuTDPDDMZ59Yp72o7enALewSYGi9EoDzA+e2vG5Yj7iM
	VeXNwxjXbIdEn8yAXGyAnVevJexA3pMhqvLzi
X-Google-Smtp-Source: AGHT+IGQXQi1mtvjfrxDnVjpJkS7DSjrbh8AS2wMWGTDnbPTsi8yxHeWu0wrHxwzq+zwyzbsGdnkQipwD4XUqCQiZjk=
X-Received: by 2002:a05:6214:5d82:b0:6cb:f8e4:77d8 with SMTP id
 6a1803df08f44-6cbf8e478f8mr117770996d6.20.1728916498283; Mon, 14 Oct 2024
 07:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-4-edumazet@google.com>
 <CAMzD94SwQhKO_-8Xi5axbjb7X+Hb6n99yvQFQkzHUMcyKhRFqg@mail.gmail.com> <CANn89iLm+VJFdKwsLNoJFuGzA8KGS7b813e38fhiFLk6R9tFUw@mail.gmail.com>
In-Reply-To: <CANn89iLm+VJFdKwsLNoJFuGzA8KGS7b813e38fhiFLk6R9tFUw@mail.gmail.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:34:45 -0400
Message-ID: <CAMzD94Q5iwiOrBOtOMhL27Cus6HJajFW4PSuSvx0DxKtySNiDg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/5] net: add skb_set_owner_edemux() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the explanation, it makes sense.

Reviewed-by: Brian Vazquez <brianvv@google.com>

On Mon, Oct 14, 2024 at 10:23=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 4:20=E2=80=AFPM Brian Vazquez <brianvv@google.com=
> wrote:
> >
> > On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > This can be used to attach a socket to an skb,
> > > taking a reference on sk->sk_refcnt.
> > >
> > > This helper might be a NOP if sk->sk_refcnt is zero.
> > >
> > > Use it from tcp_make_synack().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/sock.h    | 9 +++++++++
> > >  net/core/sock.c       | 9 +++------
> > >  net/ipv4/tcp_output.c | 2 +-
> > >  3 files changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 703ec6aef927337f7ca6798ff3c3970529af53f9..e5bb64ad92c769f3edb8c=
2dc72cafb336837cabb 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -1758,6 +1758,15 @@ void sock_efree(struct sk_buff *skb);
> > >  #ifdef CONFIG_INET
> > >  void sock_edemux(struct sk_buff *skb);
> > >  void sock_pfree(struct sk_buff *skb);
> > > +
> > > +static inline void skb_set_owner_edemux(struct sk_buff *skb, struct =
sock *sk)
> > > +{
> > > +       skb_orphan(skb);
> >
> > Is this skb_orphan(skb) needed? IIUC skb_set_owner_w is doing
> > skb_orphan too? and then calling this helper, but we do need the
> > skb_orphan is needed when called from the synack.
> >
> > Can skb_set_owner_w try to orphan an skb twice?
> >
>
> skb_orphan(skb) does nothing if there is nothing to do.
>
> It is common practice to include it every time we are about to change
> skb->destructor.
>
> Otherwise we would have to add a WARN() or something to prevent future le=
aks.
>
> Better safe than sorry :)

