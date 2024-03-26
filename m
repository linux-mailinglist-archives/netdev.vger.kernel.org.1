Return-Path: <netdev+bounces-82261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A467488CF65
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FABF32092F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405F74E11;
	Tue, 26 Mar 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEjPIUtz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCD1E884
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486168; cv=none; b=thuNBwPuatEjSiJNRE6sPbDF8JCZ+Du8pBeOQxuOuynUo5xAawcfP2pBxSNfjPQJWYmgTgxJYnRcW8/Jpm5ieydQz/N+gS0bXqj9fXdBh6GWyNa02R8Qols6ue06yRkDIE9i5fHCwTg8dw6zj+tu/2swy+iDeDLvDuXXI7GwjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486168; c=relaxed/simple;
	bh=DlRAOeJV8NjOd+uBVaU7xAKSz4AlGyiLtJWwkgO5JYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEWl+FZ+4x4K1UGokITjXWg5AO30bjUFmSOjj3psiaPrPB+60/mNBq32QUiPflwbBov5yfz04L0F5bYzCeIroxSJ8l8Wl7Rci6j9uQkSugGHmekv6WiK5fVVPR28Rg19Q/WsDFzpEnTpEYOVamu7KZqmvWnYDDqaTw2Wnoyw3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEjPIUtz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-368aa96233bso1330355ab.3
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711486166; x=1712090966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUe3b+cdCt3CNtT6kmS7FqC5H6re7v1aHPzp+YOAJWE=;
        b=jEjPIUtzXvzY4GHjOKJsbcWMC1kYjeOW/uPeNWXbLV3OQr29ojM46u8Alp71QBw841
         sdWb/ZeOGpCQaMy9BLsOYcCBq2xpMaYq1XO5DfS0rGQsR7OTrXOgYbrk/mDlXtKyT065
         AOiofyl6o/CQov6ugEdPt2Jmr3JL5sLwVVNaYD8iBd/pLsWSyy+sIszp8dpKc8hishEt
         0SCk4Hzm731FOA7Xqocxo/n5ipbU0jPaz3zjFW0EMJBvRiN8/pL+mqSI2HFmFp7GaALH
         8odZyrwHR1TPn+eVVljYEILxaQ/zjQ1OVXSvGMh771ee4OhNITXm6mGS2nBrB25BBaPH
         ZS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486166; x=1712090966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUe3b+cdCt3CNtT6kmS7FqC5H6re7v1aHPzp+YOAJWE=;
        b=Jt2JMugiyD+BqruE9IOuw/rb8XRxZfNeSuVk21LYkXjdIf+/BscEV0fLQoA6LPHv/p
         nreFyTanVE1UXc0/AvwdqyjaIU9e2UgikkmLHdr1Pku7ns0KD9UEijo9cAOTKxIQC82O
         9wrFumqqjOglP0uYvr8ymXt0cpBBMYh7JU0lX2djl+hpApAPf4Xa3gh9SQHCIqg41fYh
         84pGYYoIe7/S3uqG2maP2AVmBDC2JUYBUK//1ku6XZXlosQxT0jaf+r4dyCJpnNyb5A4
         xKj1nAOvtuazYz4usil/mGyPhmb1otOn0rAwK67oGp7o878q3HKFLbL3iCBVHYSnBsi8
         80EA==
X-Forwarded-Encrypted: i=1; AJvYcCV0f9sjGVLEaF23bC0O+cExaXieDzmY4G/Fx3wt0DmeHSkpFL+i8z1DZSFL7S48lrA7CmtUgv8eXOG0tKX4O21T/Elfo8P1
X-Gm-Message-State: AOJu0YzghD4D/sI6hiA483rONXBwJS0MLCPQxhRbVQKApdMA/0aFHF92
	AYF3z2prHzWMPMQd8Jkb/wdcDd5xO9qkD0b4LJTNNwERr2cqg9SLz5M+iOC/mrznspg5TS9oBDe
	SJqmFj565sAnk0gaQ54jWWnPDatA=
X-Google-Smtp-Source: AGHT+IGTjVEXv5gv8q+yUGOJo/9H42E4YOCndog1H1dcpHu2xMblBPziZC+n9XcSs3EQigen3m7HjBSy/3vfRJhZaak=
X-Received: by 2002:a92:508:0:b0:368:9a79:6c9b with SMTP id
 q8-20020a920508000000b003689a796c9bmr4883488ile.10.1711486165867; Tue, 26 Mar
 2024 13:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20eee0606b06a3e0ec7d90a4cb24a86a1905d4df.1711478269.git.lucien.xin@gmail.com>
 <20240326203637.50709-1-kuniyu@amazon.com>
In-Reply-To: <20240326203637.50709-1-kuniyu@amazon.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 26 Mar 2024 16:49:14 -0400
Message-ID: <CADvbK_ciytN_TBJFDK0PxeE45bhzPF6uGX=0b=GJW2pSDrG=iA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix the any addr conflict check in inet_bhash2_addr_any_conflict
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, joannelkoong@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xin Long <lucien.xin@gmail.com>
> Date: Tue, 26 Mar 2024 14:37:49 -0400
> > Xiumei reported a socket bind issue with this python script:
> >
> >   from socket import *
> >
> >   s_v41 =3D socket(AF_INET, SOCK_STREAM)
> >   s_v41.bind(('0.0.0.0', 5901))
> >
> >   s_v61 =3D socket(AF_INET6, SOCK_STREAM)
> >   s_v61.setsockopt(IPPROTO_IPV6, IPV6_V6ONLY, 1)
> >   s_v61.bind(('::', 5901))
> >
> >   s_v42 =3D socket(AF_INET, SOCK_STREAM)
> >   s_v42.bind(('localhost', 5901))
> >
> > where s_v42.bind() is expected to fail.
>
> Hi,
>
> I posted a similar patch yesterday, which needs another round due to
> build error by another patch though.
> https://lore.kernel.org/netdev/20240325181923.48769-3-kuniyu@amazon.com/
>
> So, let me repost this series.
Cool, thanks for letting me know.

>
> Thanks!
>
>
> >
> > However, in this case s_v41 and s_v61 are linked to different buckets a=
nd
> > these buckets are linked into the same bhash2 chain where s_v61's bucke=
ts
> > is ahead of s_v41's. When doing the ANY addr conflict check with s_v42 =
in
> > inet_bhash2_addr_any_conflict(), it breaks the bhash2 chain traverse af=
ter
> > matching s_v61 by inet_bind2_bucket_match_addr_any(), but never gets a
> > chance to match s_v41. Then s_v42.bind() works as ipv6only is set on s_=
v61
> > and inet_bhash2_conflict() returns false.
> >
> > This patch fixes the issue by NOT breaking the bhash2 chain traverse un=
til
> > both inet_bind2_bucket_match_addr_any() and inet_bhash2_conflict() retu=
rn
> > true.
> >
> > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and addres=
s")
> > Reported-by: Xiumei Mu <xmu@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index c038e28e2f1e..a3188f90210b 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -299,14 +299,12 @@ static bool inet_bhash2_addr_any_conflict(const s=
truct sock *sk, int port, int l
> >
> >       spin_lock(&head2->lock);
> >
> > -     inet_bind_bucket_for_each(tb2, &head2->chain)
> > -             if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3md=
ev, sk))
> > -                     break;
> > -
> > -     if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb=
_ok,
> > -                                     reuseport_ok)) {
> > -             spin_unlock(&head2->lock);
> > -             return true;
> > +     inet_bind_bucket_for_each(tb2, &head2->chain) {
> > +             if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3md=
ev, sk) &&
> > +                 inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_c=
b_ok, reuseport_ok)) {
> > +                     spin_unlock(&head2->lock);
> > +                     return true;
> > +             }
> >       }
> >
> >       spin_unlock(&head2->lock);
> > --
> > 2.43.0

