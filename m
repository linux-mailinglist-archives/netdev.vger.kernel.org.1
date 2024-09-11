Return-Path: <netdev+bounces-127493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C675975923
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFCB22E83
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A061B29CA;
	Wed, 11 Sep 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvfOstzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01D1A304A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074944; cv=none; b=mArqzgiz0IxZBkAg72uuuyhOxdCObdMmvKH7YefuBsRCaLnxxB8/Aj31f5ZV760mo9b6ELzixxEeuEfIEQR4Bv98UkRC1HKlmBjGGMyysBwFEtuDfGshV1DK2Nmh1tHytjAf7N1zTI/g0O+T2vog9IZq9gLEdsX1mjcnnM8x+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074944; c=relaxed/simple;
	bh=EkfZbnNAKZJKt6YdxlmCLpGjMHhUaFXO+vzODlsvHIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0vqwap3OiLCwc8NHdpN+Vn/TBXOsllfWXHCkj0zNyX8l1tr+LaC9sqhxkme5tqp0uHRRpAW1HDzzdTmXbCmly6+Wd94NSLm66+soYea1cSNj6UJttztHTYRNHlmMSZeuhBWsr5bgsacftL2XJTS9ZbiGt2uPtRMdDdrT0gsRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvfOstzT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso7738a12.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726074941; x=1726679741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wj3u/SZcZ84wv0uyyDUXwk0NeAqrzZGdvX2dGOPDIk=;
        b=FvfOstzTEXHCtEIdWFah15VFcO9wxSGJUok1lP+8LMoWLVYgwGs0cQak3aW5IkP2iZ
         /9tS9wuLFH8ittp755CfxVpjCqMjYS8ZRY8T2eejuuvYYP1GzDVYsK4wh+7c8WNvh8CS
         ZeVPADU8lQcyItxIynaUO0Ov2PBQ2nXYtdVGDVSsdPVanBPfM9HzucMqXK69flCn+qIk
         qWP1C+DDfLrIl0oS568tv5j5muQRVgFA0UwsfoeRfDJQHRimup4Ijg2/EryPQRVYT7Pn
         DHYa0lCCaLEu+ioCJVLS2j/onCD01HX99TgSIZKPTVLITuPLSkT8CZ8xiIUWVrMzXbgW
         AM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074941; x=1726679741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wj3u/SZcZ84wv0uyyDUXwk0NeAqrzZGdvX2dGOPDIk=;
        b=hNmDonDqmc1OEelJXU+6k73At2jrHnjpWk6JvVN13QFCppHaBJzhyzfOFGavMjmiWa
         ylsT7feFIMUDBdfgItmMBE/kPhBaLfNJCkAiL+1dzoshTOk/AtixxOHYnnQcNiMp8z2G
         ICrOfptXYDYt6rhurjSVXeKy15n22Yxbq2rHHAoUXwWPAykj4u24Jrotw2ebM23zDk6G
         U9LOoFmXlfXhP5UI/G5NZR6n7AY129lUz42jBjmXZWt8VOZftWurCU9IROxXFKga4BWQ
         WHM5RAYSFVHWg5nJ/QB2F3xzbwFcfrvCbj7crW9ZqdYwhnxkEvG2fUcM5vNGWT1or17N
         +iZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8nO9+pa9MByBMAXbijHoAhsQupT4XV1fIClPVKKeIQTTdDBeqUDlwXE9GZYmfTnt3WkRPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAr31wIYxObK9QLJzsFb3jZ92zpsS2nS9K2KZrCLdcHM1TyF+H
	er6Oo5DQxhkbwjawck23pQGXk9ifOv/PIOVgSUSm4UFJ595wx4Qygd+jLhWoWGI6tDbhL2ouJy1
	487AShet4R1v1F8ta25xWQEpsPpp11XXQ31olEOkZjCe09dXGrG4G
X-Google-Smtp-Source: AGHT+IG9+mNNmawqAYJSFLQ64vrBkqwuGsEE/AFuujnaeVEYCrzRJ5PrIIKl1JRvWNsXpJGXlLUNrxnEyeaesDYs8xY=
X-Received: by 2002:a17:907:e28c:b0:a8a:837c:ebd4 with SMTP id
 a640c23a62f3a-a9029491985mr19094766b.27.1726074940275; Wed, 11 Sep 2024
 10:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com> <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z> <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
In-Reply-To: <ZuHMHFovurDNkAIB@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 19:15:27 +0200
Message-ID: <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:58=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> > On Wed, Sep 11, 2024 at 10:23=E2=80=AFAM Qianqiang Liu <qianqiang.liu@1=
63.com> wrote:
> > >
> > > > I do not think it matters, because the copy is performed later, wit=
h
> > > > all the needed checks.
> > >
> > > No, there is no checks at all.
> > >
> >
> > Please elaborate ?
> > Why should maintainers have to spend time to provide evidence to
> > support your claims ?
> > Have you thought about the (compat) case ?
> >
> > There are plenty of checks. They were there before Stanislav commit.
> >
> > Each getsockopt() handler must perform the same actions.
>
>
> But in line 2379 we have ops->getsockopt=3D=3DNULL case:
>
> 2373         if (!compat)
> 2374                 copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> 2375
> 2376         ops =3D READ_ONCE(sock->ops);
> 2377         if (level =3D=3D SOL_SOCKET) {
> 2378                 err =3D sk_getsockopt(sock->sk, level, optname, optv=
al, optlen);
> 2379         } else if (unlikely(!ops->getsockopt)) {
> 2380                 err =3D -EOPNOTSUPP;         // <--- HERE
> 2381         } else {
> 2382                 if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
> 2383                               "Invalid argument type"))
> 2384                         return -EOPNOTSUPP;
> 2385
> 2386                 err =3D ops->getsockopt(sock, level, optname, optval=
.user,
> 2387                                       optlen.user);
> 2388         }
>
> where we simply continue with calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
> which actually needs the 'max_optlen' we copied via copy_from_sockptr().
>
> Do I miss anything here?

This is another great reason why we should not change current behavior.

err will be -EOPNOTSUPP, which was the original error code before
Stanislav patch.

Surely the eBPF program will use this value first, and not even look
at max_optlen

Returning -EFAULT might break some user programs, I don't know.

I feel we are making the kernel slower just because we can.

