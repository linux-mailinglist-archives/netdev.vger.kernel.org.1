Return-Path: <netdev+bounces-100374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276798F9A48
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D628C177
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7313C3EB;
	Mon,  3 Jun 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByVoQelQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3213C3C0
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450463; cv=none; b=tYioWHFLbUFW+5pZsnU216qfk3h3R4oSM+PT8yihYZEUey10X1xX+1SzKmdlfmiBMTwy9jDeIZVRrQHdFJ9IWpjZBnY8srT1XMMFG6tNYEWriLKbXgVC1LiQSJNcKP40rxlsDE/JpsOD7U1SNsB0nhbn0V5fQJ/XgT1KNFpc8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450463; c=relaxed/simple;
	bh=Qe2H7f0zyDUtjohuco3vh6Kpz+eDB8Y0SyKI1fX2xI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs1wPuNzZ7lIJgc5moWtwl2/tMOAb554nlsBCfnvIbt98MJua7V3ye4hQqBSCNloHGkCULcmOCP0dIju/8gfOBqbAGFKceSnof8K2lkIuqDG+C2M0c1FDe4928ED5qunmQM+24dX50B+S9Ps2v+njgikCwmxjCe5LX76JQ4sEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByVoQelQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a63036f2daaso542883466b.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717450460; x=1718055260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIeGDDwQw+KvfKWciKSemhA5egFwCai9faXGKzrCfDE=;
        b=ByVoQelQFPcOqdLpQMvGGwCnaggE+tfCkfmTrQFBSF71l/SxP4G4kW3o6ETavNrZV3
         BQUZPhfW0WN8A8RzadKTiLBbE4Avot9t1e1J5usPdejrnmsFIfirGQpKwe/oFBjBP4K7
         NBQKwGMypJRpSKS0jO1X6rn5c4pgM/WLUGyqGzANsGkeMdubkKVfeAGrr/jJf+n6c8my
         2mnMilNk/VKKE0ayA6UMzlvVjDf5d4YhE5XrdXHqMsskOHSGLpzFTua6MsmXpJr1S9vn
         qZx06tvEpe3oiCjqPyx8mkSTtVxvPSz6+31LfU1J4rH0zMeJS6POXwBNIf3w2p/Ow+HR
         g9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450460; x=1718055260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIeGDDwQw+KvfKWciKSemhA5egFwCai9faXGKzrCfDE=;
        b=J8hf6m9e4g8toaBMXQJIq7dVRyW3bFDJa4hZu+EfCcYo6Ln4In7ItBspXDPE/9SlEn
         6F3uxoyI4XxQajwHkdCgoKvzeF8Gu/X2GbDdZdK6eq7G9h18Oz6+B12JvX1vBRu/WFks
         Js/bwOjt2RBVIIPx4iZ0zJGPUTcjSdl4kpyxSF/KOYFrzrlqK9D8gTQk8N8paOBbr9ue
         FRWBoBVPciP2qkgx5u6L7M2PtQXTdLx+NjptSWUBvqckCG2brnK/dQDwp2KC1kfbQdQB
         ufdh1srO9GTy1vS3uVLyYZXs8Iu2b10LGx/CgxwEjk8HFT6g/GU4L9N3UZlcByLeFB2g
         4+6A==
X-Forwarded-Encrypted: i=1; AJvYcCWOlrgeOxDyWS/Phuje5Sdk+4Al2aJrOsTurOSoC7cyuYXV/L33VlLEugzsNrM+htd/6lU+RNsq2Fms4u3nBpqbQfq2m21W
X-Gm-Message-State: AOJu0Yy6mEz2+2biqHlQHD+g6jEWt9MwQpNsSI7ibPnkOA/JfM1Oj7Hm
	pd8Vuh9q0C7OFrpEuVBB5HrW6705Roa4RqPgzMJBuaONLxbe7trOrfgi1i2VLxuyxmEnWnkSvww
	0W03oIUpSBp23W0kziPQyeSvdCCXfwW3T3gkc
X-Google-Smtp-Source: AGHT+IFqsII+ofZD5Nq97kLmqOrSBbabIF4iI8xllAQVfN//5g+V7A5++Okxo2jfX83YM1t5Moi1aV4JTBfZn5Lj3hg=
X-Received: by 2002:a17:907:3f1f:b0:a69:5ac:2417 with SMTP id
 a640c23a62f3a-a6905ac2600mr288494566b.51.1717450460122; Mon, 03 Jun 2024
 14:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530153436.2202800-1-yyd@google.com> <20240530153436.2202800-2-yyd@google.com>
 <160254f0fe9e4c829dfbe9420b704750@AcuMS.aculab.com>
In-Reply-To: <160254f0fe9e4c829dfbe9420b704750@AcuMS.aculab.com>
From: Kevin Yang <yyd@google.com>
Date: Mon, 3 Jun 2024 17:34:07 -0400
Message-ID: <CAPREpbb90pDeDOJF+jX=ULOG+b=abfXeemaFBt6woGJzCpp=Uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: derive delack_max with tcp_rto_min helper
To: David Laight <David.Laight@aculab.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "ycheng@google.com" <ycheng@google.com>, 
	"kerneljasonxing@gmail.com" <kerneljasonxing@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks for the nice suggestions, sent v3
https://lore.kernel.org/netdev/20240603213054.3883725-1-yyd@google.com/

On Sat, Jun 1, 2024 at 10:56=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Kevin Yang
> > Sent: 30 May 2024 16:35
> > To: David Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.c=
om>; Jakub Kicinski
> >
> > Rto_min now has multiple souces, ordered by preprecedence high to
> > low: ip route option rto_min, icsk->icsk_rto_min.
> >
> > When derive delack_max from rto_min, we should not only use ip
> > route option, but should use tcp_rto_min helper to get the correct
> > rto_min.
> ...
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index f97e098f18a5..b44f639a9fa6 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -4163,16 +4163,9 @@ EXPORT_SYMBOL(tcp_connect);
> >
> >  u32 tcp_delack_max(const struct sock *sk)
> >  {
> > -     const struct dst_entry *dst =3D __sk_dst_get(sk);
> > -     u32 delack_max =3D inet_csk(sk)->icsk_delack_max;
> > -
> > -     if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
> > -             u32 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> > -             u32 delack_from_rto_min =3D max_t(int, 1, rto_min - 1);
> > +     u32 delack_from_rto_min =3D max_t(int, 1, tcp_rto_min(sk) - 1);
>
> That max_t() is more horrid than most.
> Perhaps:
>                 =3D max(tcp_rto_min(sk), 2) - 1;
>
> >
> > -             delack_max =3D min_t(u32, delack_max, delack_from_rto_min=
);
> > -     }
> > -     return delack_max;
> > +     return min_t(u32, inet_csk(sk)->icsk_delack_max, delack_from_rto_=
min);
>
> Can that just be a min() ??
>
>         David
>
> >  }
> >
> >  /* Send out a delayed ack, the caller does the policy checking
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

