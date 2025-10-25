Return-Path: <netdev+bounces-232793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33711C08E71
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A50E034F972
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425482E11D1;
	Sat, 25 Oct 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjkoloqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F92DCBF1
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384520; cv=none; b=jJ5wu+LGxCDwuEffse5AZOugHjOpfpIyOlFVMmA42v0fosY2CVcWzlfxzAlItFLrPuS6u3i6W0EGVgdRXm/1trMks5bVXvrbbpzXABj7CwiLvSL9NKZCc6WmnA68jp3ha882wyw++vpZ4NAzdEP33yxw9zzDzR74R5uRu3ZRXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384520; c=relaxed/simple;
	bh=vkmTLMpvpm/Qa6GR83vugp7lS0yOQgGxQYJ58GDReT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9UYiilSHJJQpO68nfNED6PzJrqEvN+ua36y3rPydmiMfxparhZm4ThoPZmzz4yWcoawbrPcWYLy+13AgkUbxfKj7ZIlgrZq09deJTsaT6fsIeBgQVAIiQVF68pyv30fgdrLJugyJGlC4Dv+fAMbLn2eMa/aT++zbsdvmvLG+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjkoloqU; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e847a443fso280803839f.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761384518; x=1761989318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHS+rYA72OACrxZRCGvYNKYLOg/36EJkZI8te9neMR0=;
        b=BjkoloqUoTgzTbOxZJFzL1o6OrrIVXzhxRwCEdyPPwlL1OSx1cjxH5hCS5+KHfe6j7
         t6AF/yIXQHSEMk2IFVVEhfKq7VjkYrlyfYuuktbdWeG3Ps5/o+85XmyJlthnCw38DBYO
         jV1Ag3upZxSkOnTLlQf3NL2kzlqkuizmJxkfeI4iMDCW+bpgmW3AtvJl/cMBeK0YmNWc
         iKjIcWUyPsBR6BdvyEHel2Y9XyqI3BKxVMzsa8ZFqTDFqQj15PAfbJZlpJsr7nlu/oxD
         ax8PekEYV0WgTl8BaN46o4Qol0TlLgJszvvKgrRy9gUGgolvLlbUBz0DjIUuUyeU9eQX
         YzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761384518; x=1761989318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHS+rYA72OACrxZRCGvYNKYLOg/36EJkZI8te9neMR0=;
        b=G52qA/4hFI48zMDagy+zHqEZ4VibeDfhMqheVnC41SA1az/d39JIdHv/ONd1QSmPp8
         wYlzt4fOsa0haIt/OAVVslHWjZMgMtDAVhol81920PeZYUarF4DavZXDqAN63+nz+656
         VAZvumw0YJdvErirn8nF8J7rlm+0SOoJhcUVo7Yz701YUTpAwm0nGyEbCQ7Jl0Kj06fJ
         JiRuqnycb8YbD1kL9RteHef3Z1y5+LBBKTEt7NxhOfxnz4moWlR/q/R9UPOy6F6Bbu9D
         KuBVPdRp4vP4sUvotdxILEV+eWQExQZv860zzEKm8mRLbGBSzktFRuF4wna/CxURMvzO
         EWfg==
X-Forwarded-Encrypted: i=1; AJvYcCXuUDU2dpkJ1uhhQab4CCwHPp5+pfo/m7n1VdOZ4C+MroxhoHLURNhVUNeVLe241VRED2jaCp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOX/h9Ojmx2Vt/wh/R5WGhlNrga2XnFM524i+foecSE+SgRsT
	n+TDovXr+OV8WSMRsRKNddypAvVuJwF6FWAZ72YVtw2VE8C4ERSeNHEp+Dp1it/8ZyN37wKoN1B
	4glLIZdeBj5yI7BkTha8u/97zEGUckRA=
X-Gm-Gg: ASbGnctxZFp9aD+Gi6syd8h5kTBrce2LCuFJRTBKO4MheUTNiiAPDCzctEadSX1NKzz
	ols6tvK2qA7JVTHhUNd3H770PQ77Dh+usgZKmzgG3F45SDLc4J0CNxMGVWFlLSPJ8yYjgRhv/Yq
	3+nFuej0d2ojISOiqWNQFVKHpAzF93ybhlC7vszhxs6rP0JSlNXnhcd9xsJLJVR4wlrE8/aCLR2
	xOH6IlBdk1u94IzrkSno1Pp/F/C8Xe6df2LLYAOzhpg+7QcoNSf/u8gYujd3j15zrsJWA==
X-Google-Smtp-Source: AGHT+IFrWh7z4CTVFu9vQ+xrjaz9LS2N1hcONurg46hZNqNrD28GNm/jDCqkOjutDT1/E7m6lZeIKMuGVQSjjz/6S/I=
X-Received: by 2002:a05:6e02:164b:b0:430:a8c5:fdad with SMTP id
 e9e14a558f8ab-431dc139f37mr127440375ab.6.1761384517763; Sat, 25 Oct 2025
 02:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-9-kerneljasonxing@gmail.com> <aPvK0pFuBpplxbXX@mini-arch>
In-Reply-To: <aPvK0pFuBpplxbXX@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:28:00 +0800
X-Gm-Features: AWmQ_bmu26OzQyT-TKJbwhXorr2a6Rp88JdSnJEBmxfy2w_9MDKpR8qmaP4z0GA
Message-ID: <CAL+tcoDssz0zPY3iKS5Zv6C0zq1ChbTZhRbwTPRq_6F0U6Jc8A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy mode
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:52=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > - Move xs->mutex into xsk_generic_xmit to prevent race condition when
> >   application manipulates generic_xmit_batch simultaneously.
> > - Enable batch xmit eventually.
> >
> > Make the whole feature work eventually.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 1fa099653b7d..3741071c68fd 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock=
 *xs)
> >       struct sk_buff *skb;
> >       int err =3D 0;
> >
> > -     mutex_lock(&xs->mutex);
> > -
> >       /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> >       if (unlikely(!xsk_is_bound(xs))) {
> >               err =3D -ENXIO;
> > @@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_so=
ck *xs)
> >       if (sent_frame)
> >               __xsk_tx_release(xs);
> >
> > -     mutex_unlock(&xs->mutex);
> >       return err;
> >  }
> >
> > -static int __xsk_generic_xmit(struct sock *sk)
> > +static int __xsk_generic_xmit(struct xdp_sock *xs)
> >  {
> > -     struct xdp_sock *xs =3D xdp_sk(sk);
> >       bool sent_frame =3D false;
> >       struct xdp_desc desc;
> >       struct sk_buff *skb;
> >       u32 max_batch;
> >       int err =3D 0;
> >
> > -     mutex_lock(&xs->mutex);
> > -
> >       /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> >       if (unlikely(!xsk_is_bound(xs))) {
> >               err =3D -ENXIO;
> > @@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
> >       if (sent_frame)
> >               __xsk_tx_release(xs);
> >
> > -     mutex_unlock(&xs->mutex);
> >       return err;
> >  }
> >
> >  static int xsk_generic_xmit(struct sock *sk)
> >  {
> > +     struct xdp_sock *xs =3D xdp_sk(sk);
> >       int ret;
> >
> >       /* Drop the RCU lock since the SKB path might sleep. */
> >       rcu_read_unlock();
> > -     ret =3D __xsk_generic_xmit(sk);
> > +     mutex_lock(&xs->mutex);
> > +     if (xs->batch.generic_xmit_batch)
> > +             ret =3D __xsk_generic_xmit_batch(xs);
> > +     else
> > +             ret =3D __xsk_generic_xmit(xs);
>
> What's the point of keeping __xsk_generic_xmit? Can we have batch=3D1 by
> default and always use __xsk_generic_xmit_batch?

Spot on. Thanks. Then I can fully replace it with the new function.

Thanks,
Jason

