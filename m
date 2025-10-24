Return-Path: <netdev+bounces-232574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF19C06B8D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77F3335C574
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCA31352B;
	Fri, 24 Oct 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMdya6Iu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302730C363
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316547; cv=none; b=QewVZz43jQWhEzUoKOWHHT10gvHznidkIJD0uWGi4ZrP2G/rRLOTsfWTJN5w1wglLhAmHXO4z3tEdofrVMEXtfj7ECUSyPGiP9iYUypkffUbwyC5BxDoZe3il+qZTpv0myli/SzIUWAlT6PViaHZyfOVMFiJEHGjPuWG8RGq7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316547; c=relaxed/simple;
	bh=8qlqsSkwPJmKNkE5Nc7LkDoHg469dxF/xXpEFjIqW3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYQTiceZ6flAFWD3QNJ+RIagC7/jm/cx3GZJu44Ubpo+kcKEofwcz4QkGCXT6WQ57NR1FRodED6S7JADOQOBXiGd4tDBQSavvent2y8zDsOGsE3Q4sCM0tZaP5NlcTHfPyDIu1TY9LSH3fcXfYt52K2NiCIQ1DhPKvNTcB4vMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMdya6Iu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e887152679so17831931cf.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761316545; x=1761921345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bGpICDcc8oCRuhzylk0XUgqpOJmOq5M+SZ6CEEstuE=;
        b=cMdya6IutPpUtoUofj9jd7z6qRXXcz22x8fdwe8rOw1XDIYOxUqI2Mk2kkfv+goZTA
         RkQJEIy6YQq7CZOF00wp5D+IJK1hBJGzuAJh6nOaP5jMH/WDoBy55BgZjC31F32To3G6
         XjxqtNV9ntvAdvfruob0kIqhqZrdRGNa+KkJfj341JRPT+HyM0SHkSTpaXzmmuc/gCIv
         kCIVAlxcYaoiF2LFlICnF2ngIwj7ReKLTIBTrWNLjCbwA3XWODIaFTChWxx6yOJa6qrh
         mcXX6A4nFQXXjyetmSunp4L4UMb2TWGAStCBXdTAlhvdwHLZPa833My9dnNr1MrRR42g
         Hxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316545; x=1761921345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bGpICDcc8oCRuhzylk0XUgqpOJmOq5M+SZ6CEEstuE=;
        b=vDxb2hs2QiVHxD1/9pEWnDOjXc2scFpQVCshXKEoxlXWyUzUyouAI66j2ll9NROM2B
         fPdM4O6DJxy64CsVaoO1n5GBGknZwul/iCqg13Fc5YPdbhcbqfoxHUh8WYzsqiWjyBu3
         eC06wxWlEFeNeTtze1d9I0PE1UUYbLP5Bx16cA/ba+gWV8jdSeANEgor7TFLWXmV1LkM
         IeXgtVVlDcCdHoYW6AuG1M53rC3zyvlwnhz+X4gzKEwWJF7rQQeF4sm/liqIgc35/w7M
         SaiuEAIECa3HF/wYshgryukcIZdxAwZtcMNcH1MGY5QA/lGEB4GydqZALEPjyuyB4+P1
         WtJA==
X-Forwarded-Encrypted: i=1; AJvYcCWKq96eOWKrHVg4Vit5a5w3D7NZVlaXD/WYHVoYf1sJ4SO5q2lNez624IakoWIxEyTS62Iienk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytO78GPkUgKF1WZebCbBkR8BirzzFBmPy2P+GsZtWk/w1eDmee
	gc+Yuk+lM8LwkRGmmbormNu5SSgoITt6fQWEFAVkmAEkAtt9jW3NDHseP/KZp0UIpPJYL3WDv5F
	016lsHiOwk6/YHAqpQIzW7pb4MSm9wdSdDwOkDv1C
X-Gm-Gg: ASbGncsKXWff+mxen7aS9yKxqOZfUrdQ6mmgrhwtXnU1QaIAnp5oEt7DM7buk6N9Boh
	0caEieIyNI++P/5fCTMx0DGCe5QElikmXGhgjVHlifhUART5wuWzx9NPt8+6oGIwhdjNNguOUO8
	Sjsz2FV0igXYNR0OH8ZzxdSkt3palzwJ34JpqMJhe88HEyM3pEep+ZJKdXqccOmbGZbql3U8W1t
	fVyQ5EZcvvV8W3ia2+B3m0osWv30gngL4iS7RBY0EF4uHJmAe5wJbEUoMM=
X-Google-Smtp-Source: AGHT+IGMrOlAkdIcI4rQNpbGuF16BPD6e7wh5JdFq7xe7yC70ifD2Sfpohn4PQwHPjJwOU2b2bmbh/4YQzqZFT+ZIQk=
X-Received: by 2002:a05:622a:20b:b0:4e7:3084:5282 with SMTP id
 d75a77b69052e-4eb92b343c2mr41579071cf.11.1761316543977; Fri, 24 Oct 2025
 07:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023083450.1215111-1-amorenoz@redhat.com> <874irofkjv.fsf@toke.dk>
In-Reply-To: <874irofkjv.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 07:35:32 -0700
X-Gm-Features: AS18NWBL-bNxKDEAoWP82poknYalcS0kSd7pGCzh85_6YYhD2KkcrrhXF6AYJFE
Message-ID: <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Cong Wang <cong.wang@bytedance.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Gathering interface statistics can be a relatively expensive operation
> > on certain systems as it requires iterating over all the cpus.
> >
> > RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> > statistics from interface dumps and it was then extended [2] to
> > also exclude IFLA_VF_INFO.
> >
> > The semantics of the flag does not seem to be limited to AF_INET
> > or VF statistics and having a way to query the interface status
> > (e.g: carrier, address) without retrieving its statistics seems
> > reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> > to also affect IFLA_STATS.
> >
> > [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> > [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/core/rtnetlink.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 8040ff7c356e..88d52157ef1c 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >       if (rtnl_phys_switch_id_fill(skb, dev))
> >               goto nla_put_failure;
> >
> > -     if (rtnl_fill_stats(skb, dev))
> > +     if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> > +         rtnl_fill_stats(skb, dev))
>
> Nit: I find this:
>
>         if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
>             rtnl_fill_stats(skb, dev))
>
> more readable. It's a logical operation, so the bitwise negation is less
> clear IMO.
>

Same for me. I guess it is copy/pasted from line 1162 (in rtnl_vfinfo_size(=
))

