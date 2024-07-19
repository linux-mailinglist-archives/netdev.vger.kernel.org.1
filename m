Return-Path: <netdev+bounces-112253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E5937B58
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5BB1C215E3
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B8146592;
	Fri, 19 Jul 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqXhDcDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD414658C
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408168; cv=none; b=J2HqC8sR/Y6Kfa1e/HlTDjsl63MakdTDtZi0D+ljNu1ZLcvzCmY/zLqifccaZyWeEoBgTznmV0/m1ivAjZX6GCaYDDVwJH7gf7LPP5yKDMc9Ax67ngaWdhEIM+ruti8jWNMYWYCa/7dxxUOHYUoGqVbIVZEgJ1gnAVIw1aTW0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408168; c=relaxed/simple;
	bh=lvF0GLCPiwi0BQoWDbKetktKLFHXyf7ys/QdtHkOMSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiJj4Rv+ZqLCuZUQeZtmtFSuf3Un9nRr8VHAkxM9xziorg0nMLndzMOdUdcohPmFSe2hCt6xCxXsVs24HLtDIPHMeFS2j8vE0Y0Gtv/G2MRWkWrJdmOaXeBhuPaz0OTdpUP4I2RGBb7ryXDRtM8mEPbhlsKo1lLbLethbBPlHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqXhDcDC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44e534a1fbeso251351cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721408166; x=1722012966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz7r7VOBQSyS/Yh1U0qLh5mLC8osHvrAJ2HWM7JAv2E=;
        b=xqXhDcDCtZ7HXeU3YhV9jXMqk4G1/e7IqyIrlIONZi8vUGgeMlecFfeMjhqlX2dEOH
         /15XxiNYaN6fV5BXdU278a2bs2O4Y73q5jBK9X+adGRNM5mcc+vlcaXzZXldzq1zUS3E
         fX0gGkODRhDCJgj8hDAFtTaGKZ0+/9sN+l9wuX8/M6V3dFtCgSUfDPeqqcjfo0nU3Ppt
         y5Hl+bNESUasLk73NI6uMcdZQlg8OSl0JLuCT1ZiI/0Pxer+yAZ2hHxvLGpmroBlQ2Nh
         GahUFCg1tR314xc8JRkm1S9YN3hu9ETXHb0TYZ6C8wZLa02PWJNYwuRTCi/lmqZRjPC3
         Le/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408166; x=1722012966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz7r7VOBQSyS/Yh1U0qLh5mLC8osHvrAJ2HWM7JAv2E=;
        b=YkKCzTN8+biDlHjAw19S/P1J9mpDny6XggRoTvfH5u/So1TYtycHvFmpQGwKqu9rF5
         InO+IScEvMNprkn0Msflcz4/QhRk5UlnygrPJU+ljs6gR40DaUETHSDehUO56BOu2ckf
         0e32/59HM/PDsbQMFnX6daM3Y7oRLDJYUafCowEU81iUnuFTf4pzgTS1zo65bjDsx6GD
         vBElTfG7YXZ85Q0zSIglWwSK2+KOqbTZUBTju4FVS0BlPcFa2L1C2sZO65px0bX/yc77
         niNUq7wep4KzWBIfhlfntak/tlUd9b+zaQPsoARIHWLMTvZ9h3z34q6XwhH5gSOoSXdU
         c4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXeJ9MLEq7YXGYgyYguXdavem4b4HvJNvDnFY8D5evdminiCJZ2E1R7IQ1KB/PT1Z/WdgUaHp6RJQ76MZPjGqrACx+sPxtk
X-Gm-Message-State: AOJu0YyeXZzP5zYh8udF1zrIsD64fw5wpZoZTVSkCp3A76TMJT33NwqR
	sPJaaS5IKpfIYoqPBiakg4iLnM1enQGaD3fjcnKHS+28/ur2pIF3Byb3bS9ZuCGLvQ8TeJK/3te
	IzzPtLH8ZlqfDDxTSO91YO5NzxFcavC4XRGdY
X-Google-Smtp-Source: AGHT+IFfrlXPybbsHIi0McYmW+Pz3rbO8+XcQVpIL6HS4WwCDLCVYi9b5Bgbnm/lzf/27Uayqr/Rx0ABvBU9SQjgnb8=
X-Received: by 2002:a05:622a:400b:b0:447:cebf:705 with SMTP id
 d75a77b69052e-44f9a8819c7mr3522231cf.0.1721408165401; Fri, 19 Jul 2024
 09:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
 <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
 <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com> <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
In-Reply-To: <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
From: Bailey Forrest <bcf@google.com>
Date: Fri, 19 Jul 2024 09:55:50 -0700
Message-ID: <CANH7hM4FEtF+VNvSg5PPPYWH8HzHpS+oQdW98=MP7cTu+nOA+g@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, shailend@google.com, hramamurthy@google.com, 
	csully@google.com, jfraker@google.com, stable@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:31=E2=80=AFAM Praveen Kaligineedi
<pkaligineedi@google.com> wrote:
>
> On Thu, Jul 18, 2024 at 8:47=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 9:52=E2=80=AFPM Praveen Kaligineedi
> > <pkaligineedi@google.com> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > +                      * segment, then it will count as two descr=
iptors.
> > > > > +                      */
> > > > > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQ=
O) {
> > > > > +                             int last_frag_remain =3D last_frag_=
size %
> > > > > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > > > > +
> > > > > +                             /* If the last frag was evenly divi=
sible by
> > > > > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then it=
 will not be
> > > > > +                              * split in the current segment.
> > > >
> > > > Is this true even if the segment did not start at the start of the =
frag?
> > > The comment probably is a bit confusing here. The current segment
> > > we are tracking could have a portion in the previous frag. The code
> > > assumed that the portion on the previous frag (if present) mapped to =
only
> > > one descriptor. However, that portion could have been split across tw=
o
> > > descriptors due to the restriction that each descriptor cannot exceed=
 16KB.
> >
> > >>> /* If the last frag was evenly divisible by
> > >>> +                                * GVE_TX_MAX_BUF_SIZE_DQO, then it=
 will not be
> > >>>  +                              * split in the current segment.
> >
> > This is true because the smallest multiple of 16KB is 32KB, and the
> > largest gso_size at least for Ethernet will be 9K. But I don't think
> > that that is what is used here as the basis for this statement?
> >
> The largest Ethernet gso_size (9K) is less than GVE_TX_MAX_BUF_SIZE_DQO
> is an implicit assumption made in this patch and in that comment. Bailey,
> please correct me if I am wrong..

If last_frag_size is evenly divisible by GVE_TX_MAX_BUF_SIZE_DQO, it
doesn't hit the edge case we're looking for.

- If it's evenly divisible, then we know it will use exactly
(last_frag_size / GVE_TX_MAX_BUF_SIZE_DQO) descriptors
- GVE_TX_MAX_BUF_SIZE_DQO > 9k, so we know each descriptor won't
create a segment which exceeds the limit

