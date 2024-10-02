Return-Path: <netdev+bounces-131174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DF98D059
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30514B22362
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D141E0B61;
	Wed,  2 Oct 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFZpCbPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69C1CDFDF
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861876; cv=none; b=qDkYJS4f6EH/oxgfYNYPNiKbrLAwRQchgZb/Eb5BWjqRlJ/1eocaE6V5NyqRze0vYE+9E3rm42LkElMqZity1TcDs15KWk1tmOAr6jefD4TXKIsLdKH4uxuvVxAFEURRiAvOlWutea0gumryM9clwjBwV5JUCXStxeRbxYV6Uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861876; c=relaxed/simple;
	bh=AJW4LybkDuThd0WZDh6YTwe/YoP8gO38i47n6ueldgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+fvQFGo2zQ97IuZXyl70w66f7RA+rVX5iAlVjn2fZhwE+ggB7ejh7o10CviYeHRVDOfsHJD0CIE3d1iz+EkLR2DJbGd8xSb6urn9QmBz6nXHQ4xT3ToAYLpIK6o85fpuqnROYJRqeHDY3sEWKMHOEz+N9M0UGXBR/9SY8ckwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFZpCbPv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ae50bf69d6so25125585a.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727861874; x=1728466674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP+VlmsW+1b9k0It6iwoYD1oXAu6XJgpdIVTTeYmXDo=;
        b=KFZpCbPvT+jqb5UPftMDvtr2OaY25PK0df/T8/LNgEKSr+/nyPJtEEanG+nFTO6Aun
         9xhu3o4yKzHSdNtPCMnrHlG8yXZEj9vzYG5ypmCw7hUUa4nzdNm3U1A4ne9aDxDl9LAY
         55cc1xAuL1xHAC/3aB5qjlkf/1/gBJM+O1VLgnU5INFGp6F5bC/HIdSIqDHYav7mFEAg
         4PnJWCJeTglaTdwMPcTKjbWNhEHh1PPZKbJCd883luR/5eCYPtlwbDJl4FnR1rBOyHrR
         Ypx7DdQDVu3HnKDc3wJiQWs2uu1UFvWnODWG5AjiU4MumidtOmG+zGKS+8lxzhmNb2W4
         D5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727861874; x=1728466674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP+VlmsW+1b9k0It6iwoYD1oXAu6XJgpdIVTTeYmXDo=;
        b=mCVV8VDyKyfuc8aH91e88rPlSUwxqBWx2aGj3PCDhuKw03X5Ki549g0vJLJKg9HAt7
         WXdSpqrLozDO7Ji9KOH+L4U7MiePBxZNk+rLLv23wz/8XLim79Kcw3aABYBXK3VJZPP3
         SxvC4jLr3JXYeVUOg9W/pg5nUEzB9cn7ZUoyUYGg5HxRiQeaforx58oq/OQM1muc0Bz7
         j+EIA1lCXhoG2yHomF0oTSUgkzkMVRxQz75P4Bn0DWNHY0XjcEbf9xuwj23iKc1KF6gt
         WIwrSy3IkEcOeqG/bQelCcRCGiir+0a8H033V7VpHH45OvfAYV41rTa38CjEt2H7nB+3
         bYJA==
X-Gm-Message-State: AOJu0Yxf6kpK2oOzQF5+b38kqjaOHUEOeegZszcodOR6Vw+w7SpksvTn
	zwuy4fo7way5gDphZ12Fvk1Vy1FtGLTnNzvCy6notWAMiFZTaE1K0jAwxkPkE9Wxgh59pRDqy75
	nhcpJD+iF3sZtIhJc3P9svNL11eyr
X-Google-Smtp-Source: AGHT+IG3mgC/BUo2a3LsZE41Vv+kVRfpIPJLV6J2AplNs0Wy0SDfb/5sYLkrnINj5yHQquySwTFm/Po8MCXTLhl6WP4=
X-Received: by 2002:a05:6214:ace:b0:6cb:6140:f490 with SMTP id
 6a1803df08f44-6cb81a93f95mr16464156d6.8.1727861873696; Wed, 02 Oct 2024
 02:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727849643-11648-1-git-send-email-guoxin0309@gmail.com> <CANn89iLq0g=TmL+nABr=j4N2gw45yJgRr6g8YOX+iMdWrM3jOg@mail.gmail.com>
In-Reply-To: <CANn89iLq0g=TmL+nABr=j4N2gw45yJgRr6g8YOX+iMdWrM3jOg@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Wed, 2 Oct 2024 17:37:42 +0800
Message-ID: <CAMaK5_gm=8+-KqXq98VSW9fJJ8Zx9fdv2Mbrx_30NzSUQny5ig@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unnecessary update for tp->write_seq
 in tcp_connect()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric, I will send v2 for this patch.

On Wed, Oct 2, 2024 at 3:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Oct 2, 2024 at 8:14=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wro=
te:
> >
> > From: "xin.guo" <guoxin0309@gmail.com>
> >
> > Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
> > introduce tcp_connect_queue_skb() and it would overwrite tcp->write_seq=
,
> > so it is no need to update tp->write_seq before invoking
> > tcp_connect_queue_skb()
> >
> > Signed-off-by: xin.guo <guoxin0309@gmail.com>
> > ---
> >  net/ipv4/tcp_output.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 4fd746b..f255c7d 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -4134,7 +4134,7 @@ int tcp_connect(struct sock *sk)
> >         if (unlikely(!buff))
> >                 return -ENOBUFS;
> >
> > -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> > +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
> >         tcp_mstamp_refresh(tp);
> >         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
> >         tcp_connect_queue_skb(sk, buff);
> > --
> > 1.8.3.1
> >
>
> At line 3616, there is this comment :
>
> /* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
>
> I think you need to add a similar one. Future readers will thank you.
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746bd4d54f621601b20c3821e71370a4a615a..86dea6f022d36cb56ef5678ad=
d2bd63132eee20f
> 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
>         if (unlikely(!buff))
>                 return -ENOBUFS;
>
> -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> +       /* SYN eats a sequence byte, write_seq updated by
> +        * tcp_connect_queue_skb()
> +        */
> +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
>         tcp_mstamp_refresh(tp);
>         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_connect_queue_skb(sk, buff);

