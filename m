Return-Path: <netdev+bounces-71465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652838536B9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B0BB20A2D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C559A5FB86;
	Tue, 13 Feb 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/b7mJw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F45F48C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843700; cv=none; b=NRp3zQAaMBD9fyreYmjIDUmLehE7sTK3+t9uaBuoEKKRjte4SOH68LUBH1fKG7uPbStVK6olMuYxBuIQjxkzS5Oggmjwc90dzyC+a9lds9XVPRbWf6rsm7YmPcerKeNDt87YA9QYRl9MrExRd5+GjDgJLYZBFYWTQIgRKV79RGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843700; c=relaxed/simple;
	bh=dLpvUJPgdc8tqnPXV8wTKztrj0RdbZCGZAKwlsqR+U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMKipgUDeKPy9F4flCiFwf7Kn1DXCyfeS84Pj1l9BBb0u/qEaLWETDuMWFHF7WZCSZhIa//U7QKpav6woJJHZJZqBMWEPiKCzXNtvqPGCBk/V7gxgzoxnHRdxQ3XjZWFzifNDNVOb5DVX9pLwvWd/FkHm+bkfAxLGqG3QVWPnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/b7mJw+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so6062269a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707843697; x=1708448497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ9k6u1nnq51ddur8WFFVldpMClqje9ZSa+IRSG+5Sg=;
        b=a/b7mJw+CLMhARqNQoi3ijVhPszdbLJ6clhuWFbaCHyFZUiKoBCSYBnnfFKmRhs2pm
         5x/ABltYqISf1gVFC7LCL6GIyUXwQVCaOMcsNyGvptdFjwddEl0WPkKRJduFkTjCyvHl
         /+dkdHe8umpKud/Dn+Lf54Uc84QL55L9IAaZZb0qMTo8deBxSTWKHxHoSS8syAHWvAXD
         GjSs/bBzCN8q7+lnp3O58D2cy877ZypNc7+zimV5EUcfGXcVhQWoayY4i4+zo2JvLlsU
         whbGf1tuOvT/ZC2D8qRZMaYTVuU2kLpwmJjqDLwxevUwnJyplzGxJFgFG3wFwRn0nY0P
         m0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843697; x=1708448497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ9k6u1nnq51ddur8WFFVldpMClqje9ZSa+IRSG+5Sg=;
        b=ONfbxIwqmccubkRwwkTa5ECquARdY7GQk20sKy7XP7QAxDmR3jsnu9bMLf9mtxQx7i
         SSu/CXaKQqWTDfLehRWONNFo2fsvODG48AZWp9fWCYg43hkdPM8AyQLofDXBfcCuQsZR
         kmi91rYYahn7ATGydua4xDK4DkXNKswcpwYyFZFt//ry/YRPFsXgN1+ztFlRcZDviVjq
         OUHcuZ3fvmp4KqSpY5qasI2jei+qXbg+K0h/gu8V8Opfd+a30AE+X3RV9DzO7QyAx88d
         bwsD0LVX/X7bN+1jO2pa7CzHjTigqaWT2ewZbvfGtFCxMDnyc6tFiWMiIi4Aej9E4MR+
         +8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXUZVAATbmYO9nN686zBGyH4JURL4m0sQdGLlZJgbKcc9Gvk6ClMXGeDV6HB9KqNbZvlpU+U2E3ToTu8YI4RE01QqwDlP74
X-Gm-Message-State: AOJu0YyHHWTkOG2hF3kblPT2YPWSNPhwfxLWJywcGHliLQFUkJ3sn+WD
	IOM1J7pHS/wKpgiKaVC2Z77MjWoQIqT8EX30NI1IPMHQ0IDbfjQKOnTJE8sV19cBtLMnDcTeqb8
	QsidLpfnhZhuSYWIJNsjYuGvEESQ=
X-Google-Smtp-Source: AGHT+IH/RyrFwJxHZRwcFgjnUm7pTRRUg0uDLoLHJY2PtSHPu90yFTk9h/krrlhGZ3x8BA9GSXoAgtHP2reM13NGNrM=
X-Received: by 2002:aa7:c44f:0:b0:560:aca:6344 with SMTP id
 n15-20020aa7c44f000000b005600aca6344mr199957edr.0.1707843697232; Tue, 13 Feb
 2024 09:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
 <20240213134205.8705-4-kerneljasonxing@gmail.com> <632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org>
In-Reply-To: <632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Feb 2024 01:01:00 +0800
Message-ID: <CAL+tcoBTzU_3Y-tMMT6iHg59oBxRUsm3JMBPMLW62LkH+AgLEg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/5] tcp: use drop reasons in cookie check for ipv4
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:56=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 2/13/24 6:42 AM, Jason Xing wrote:
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 38f331da6677..07e201cc3d6a 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, stru=
ct sk_buff *skb)
> >                          ireq->ir_loc_addr, th->source, th->dest, sk->s=
k_uid);
> >       security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
> >       rt =3D ip_route_output_key(net, &fl4);
> > -     if (IS_ERR(rt))
> > +     if (IS_ERR(rt)) {
> > +             SKB_DR_SET(reason, IP_ROUTEOUTPUTKEY);
>
> Reason names should be based on functional failures, not function names
> which will change over time. In this case the failure is an output route
> lookup which is basically SKB_DROP_REASON_IP_OUTNOROUTES

You're right. I'll update it soon :)

Thanks,
Jason

>
>
>

