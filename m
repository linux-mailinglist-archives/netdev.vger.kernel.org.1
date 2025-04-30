Return-Path: <netdev+bounces-187142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31817AA533B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC13BA6D4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116C26656F;
	Wed, 30 Apr 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWQdQ5xR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F91AA1FF
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035671; cv=none; b=hGnR0IdwDrRFz5K3DFGuyzoC7qcwvdAq5JGxqC6sOoOGMutAHi1IWqR68XA8jkIZy1lVbk/W2tR0RxB2i6BD8vAKLpHbHfAWpYvv+npN1GNiZuWV6qcVhznncPU4zMjWlTg6VnBz38xNkBlT/N2a4Ud8ms77zJSl9aM9eMA9lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035671; c=relaxed/simple;
	bh=Ljcc3ZAZS+yzcl3OGD3RFYaZpoWN2HMvVtdY5ZCKCo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W4QTORKyYMUo09OcFjGUVGxsvxTUiPjuE6KWAw5QnFBjcUKymPONm2kPHczlecOwIkxX/mQt9oWsLq6yCoGLW26EvWA0Q6trs4hKIYyFpNt8sBcxWmLx9F3YkwzCGKNIcbU9KVETxQS6JYm6wqX2u+C68tJWipoVvNzS1Qc/3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWQdQ5xR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2242ac37caeso24155ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035669; x=1746640469; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPbUTi2PYYIIfuKOmYX8yf8KMD2tLvoABDEozQ6vVb4=;
        b=RWQdQ5xRyBSZI9j4ezcYZw6kHoZWgYKJ2W8IC+LRSuR79DzheQXfk+F3TcaTb+rCVg
         b1sLBz8qM4lnXZlA3oEzQhAYWJ4WlOaBE2VCDBYPqPrADSCulyJaVL6wxotVwX13Iwa3
         HUUIB69tMwer6cBYG//pQGOS9pOyXyU0L+TizwKZxhHDhaxSgGfAMYTprQOo5fv8PsyL
         XrYjJ/SfLE/aF3iRDaZd7tqGK22tDZpF7Qvk/HlUOyt2DqHb/m2PblxaDh8Obut3k0LR
         Oz/KRa+8zEyANZ3cg9fNbb4l5JJwedHo2YNiiJgCHMIv8+BFTViimPlbi+nW6hIkgChC
         fVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035669; x=1746640469;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPbUTi2PYYIIfuKOmYX8yf8KMD2tLvoABDEozQ6vVb4=;
        b=gSL38n2//uMwE3Bo15W97g9WFWEuzxK1q8X0ZbGb40pse3+oCKG17fcsTZngdMOcNn
         Q74BsQWXiButcbS6JgJz/MSw5J+gZNJJvIq1dApbTlJy+QPU1N7LdbxQvQ9gR2yQyiDl
         ezXmlEOcWLKkgLnKVKUio/KPxFQpc2bi9+PmWelLMupXhz+pvsb6xZmRuYBqD4+VTNje
         X9iucarWNbpPKWDzBQ4rBfSI6BXv0KkXfl5CJkdPFsarWL6HMeVdhZn9NgEScFttabjY
         38p8BpdGym/AI1Qy92q9E+TOszSMvmVBCmhxmeBwllhVuYo6uslCEwYx5nFb68YprkGl
         8QRg==
X-Forwarded-Encrypted: i=1; AJvYcCXrHiIwPwIK+bb7cxmNIrPGjr3GJ6dUP+Kjv5kuRiR/On7RQSHiFuoDC1Y3StJs5goagJ+u+iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/URyu4oZEdMz/FrFnfHfb3lIBelRuEw6HGQ8QM2eM+TQHUPGv
	OcYQ/5XvGA7VKMXCtjl5QHkN6/v1Zr3h5CSxh3Gl2Rq/T+HO2ZAIiQwib4XpFkZ7QsWa3ZrkIc2
	MubqmuDxom0wJje28DcmM3a02VgqJwE1mxpg7
X-Gm-Gg: ASbGnctJpOVFrV3hqtYU9BANO+XeKGMrqo6ELefRyheDfXq+ZbLNloVwxEbkoThR9Me
	WUu0kr6Gxdau78cS9KZQUl7N1CVAHlnsyP0cABRMss05UzRSA1Nzf2tq9jARgps3VpW60N2PwCX
	jpHIS1gtb/3A1FBY2Skxzh+LVSxIzOuNgp95t8NxMoEIqc/emkvC6LBbI=
X-Google-Smtp-Source: AGHT+IGAtUTjE1ToVn0X3a2r3Fobwj+ih4T08C12Zh3vsndflqz/st0/DImi+CWIBqvca6vfjpERbh1RGNH0tzvDv54=
X-Received: by 2002:a17:902:d4d1:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22e0400910bmr19045ad.7.1746035668734; Wed, 30 Apr 2025 10:54:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429222656.936279-1-skhawaja@google.com> <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
 <CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com> <aBJVi0LmwqAtQxv_@LQ3V64L9R2>
In-Reply-To: <aBJVi0LmwqAtQxv_@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 30 Apr 2025 10:54:16 -0700
X-Gm-Features: ATxdqUEVlZrlbMlWoJi11fTmuCkas696qQEk1_hTru9xa_M7wbTjnF95cYimFto
Message-ID: <CAAywjhQVdYuc3NuLYNMgf90Ng_zjhFyTQRWLnPR7Mk-2MWQ2JA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 9:53=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Apr 29, 2025 at 06:16:29PM -0700, Samiullah Khawaja wrote:
> > On Tue, Apr 29, 2025 at 4:57=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Tue, Apr 29, 2025 at 10:26:56PM +0000, Samiullah Khawaja wrote:
> > >
> > > > v6:
> > > >  - Set the threaded property at device level even if the currently =
set
> > > >    value is same. This is to override any per napi settings. Update
> > > >    selftest to verify this scenario.
> > > >  - Use u8 instead of uint in netdev_nl_napi_set_config implementati=
on.
> > > >  - Extend the selftest to verify the existing behaviour that the PI=
D
> > > >    stays valid once threaded napi is enabled. It stays valid even a=
fter
> > > >    disabling the threaded napi. Also verify that the same kthread(P=
ID)
> > > >    is reused when threaded napi is enabled again. Will keep this
> > > >    behaviour as based on the discussion on v5.
> > >
> > > This doesn't address the feedback from Jakub in the v5 [1] [2]:
> > >
> > >  - Jakub said the netlink attributes need to make sense from day 1.
> > >    Threaded =3D 0 and pid =3D 1234 does not make sense, and
> > Jakub mentioned following in v5 and that is the existing behaviour:
> > ```
> > That part I think needs to stay as is, the thread can be started and
> > stopped on napi_add / del, IMO.
> > ```
> > Please see my reply to him in v5 also to confirm this. I also quoted
> > the original reason, when this was added, behind not doing
> > kthread_stop when unsetting napi threaded.
>
> Here's what [2] says:
>
>   We need to handle the case Joe pointed out. The new Netlink attributes
>   must make sense from day 1. I think it will be cleanest to work on
>   killing the thread first, but it can be a separate series.
>
> In this v6 as I understand it, it is possible to get:
>
>     threaded =3D 0
>     pid =3D 1234
>
> I don't think that makes sense and it goes against my interpretation
> of Jakub's message which seemed clear to me that this must be fixed.
>
> If you disagree and think my interpretation of what Jakub said
> is off, we can let him weigh in again.
Agreed. Also my interpretation of his statement might be incorrect.
Considering the possible actions,

- Hiding the PID when "napi threaded" is disabled is likely not ideal,
as you have pointed out, though I find it acceptable.
- Stopping the thread when "napi threaded" is set to 0 doesn't align
with Jakub's following statement,
```
That part I think needs to stay as is, the thread can be started and
stopped on napi_add / del, IMO.
```
Also please note the discussion on stopping the thread I shared earlier:
https://lore.kernel.org/netdev/CAKgT0UdjWGBrv9wOUyOxon5Sn7qSBHL5-KfByPS4uB1=
_TJ3WiQ@mail.gmail.com/

>
> > >
> > >  - The thread should be started and stopped.
> > >
> > > [1]: https://lore.kernel.org/netdev/20250425201220.58bf25d7@kernel.or=
g/
> > > [2]: https://lore.kernel.org/netdev/20250428112306.62ff198b@kernel.or=
g/

