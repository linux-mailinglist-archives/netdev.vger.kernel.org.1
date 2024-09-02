Return-Path: <netdev+bounces-124159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09143968559
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BA1C2273C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1C13C810;
	Mon,  2 Sep 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcSRg2jU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210313D8A0
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274508; cv=none; b=VuAr6EnbE/XLxn+QD7KgOaPfh1yEUykql7OdgQwhB6WToHHK2apu3iwetac9E/nju3+6J8qxwrqkzw1dTsWKDmGZCI9YeF3sNLJqxAyWn/fccFG+FVKWNlfjgT5fYZu4yJl1QB9jFVwyTUKBwcTjEyucEeyQjWKhglDFVSdP/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274508; c=relaxed/simple;
	bh=biXYaLkVDJQdgMg7o4/oWqxaKpiCsRm1L/ne6FPsBmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5bfLUpd4OPomAx70fp3aAEC+UHYCEwae0F5uKnp+7YpzOCV0uMU/jIZpW9RJ7R+S7cXg5lGEoeG7Haf75gt74pQZUbnFEVysDseraoJbP36DpAkJQZNvLng9G/blfpGqrdja61obPymHpB1hgfVctx7mmFjhrip0Y987XsnBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcSRg2jU; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-846c4ec2694so497100241.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725274506; x=1725879306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpXiGgWoCGy43aEJ1j4jnW7Jz0iNp79u/n4St4BHXFo=;
        b=JcSRg2jUMEhYidYqYEVf3S+dRSU6UC4h5t0zZWFRtYSVbfrHtOQAoDRO+0wFs7VstQ
         nYR6y8OsmDYWd1V3udAXqg5b0UDNNBlJKpyS32QoH3Y+2iBvJeNudJkv3tBDQhbtoMnD
         FItJn6cWPPzQ99PDNgCk1hLIMVBSiD7GDHe1JHgkSGflAw52xSELTxKfEmu6HXWkMBY6
         pyXbcrZ4P+FhtNFxQ4yunJ6gryruJcQI4KYxsZi7hy/liiR7kivGhRa///ZZf/O//rR8
         AokEmlOLfwK3Gy2O/5T/k4PYZhp+mAyM7I1kYT1UBV8AQFb5GUHU2mxP29ZFWXSKk2am
         Bqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274506; x=1725879306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpXiGgWoCGy43aEJ1j4jnW7Jz0iNp79u/n4St4BHXFo=;
        b=HDcP4/b8Y0o42Ydb1ZC2y23LnhzI9k0Sd0hfDNxvEqgrR6Mh06S7d4D1Hp03uGb4Zs
         iT0uGaCLLXN3yDJzF7TspoekqfF2hZ6wKhZVNquFOwCtPcYmKoCuJJ9N6UOc/pV1TFp7
         J2Max/nflaQccxb4YAX51NeUmTnw9u1Sq68jJUvYNg6ZLFreoPqaPpx1q6B/bpnYhGRf
         S8RhMWypt6S7xBNVIGWabXKTwIzjlYZs2OlloJf6IJix58Izpzfgv+LmnLuNxEY9vUo3
         A0kVqnxJZfhD3gQyseYgljpJy4qjvkAVheVmYoG7zTHTlf2uX6l7bohg8HTr3P5ZtUQg
         In9w==
X-Forwarded-Encrypted: i=1; AJvYcCW9OQ2adfGmJtSh1qSkvBSEYAmr3sR2REyeEV8/0uT8ydSIMeY/5VayuYG5ZS9ydDOJcaynGk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqfcaqkD+UFjmnEawNvRYJbwLiOyMWXDcnX1G4Zm4Tmk/xZZl
	to6EW3PLf4VLZw1mfMxzLVFOpUkm73Z+p0S1Xe+MR1JhmbTn6V4Rd9Qt3Y+N5kt+kD1Xo4sRGii
	aiCxVdBiv99WCkR6zcEis/kmqPdnil6KA
X-Google-Smtp-Source: AGHT+IGpewliNNRTFWDgcF9oZ/wQN4CM6M9zcGf+RRsUAA0RsxS8VeQTRV3eqoAfCVwEhZX3XPVchXoV+L5mX+xvAOc=
X-Received: by 2002:a05:6102:b09:b0:493:e60c:e6d2 with SMTP id
 ada2fe7eead31-49a7992c5a3mr7157166137.12.1725274505799; Mon, 02 Sep 2024
 03:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901235737.2757335-1-eyal.birger@gmail.com>
 <20240901235737.2757335-2-eyal.birger@gmail.com> <20240902093207.GG23170@kernel.org>
In-Reply-To: <20240902093207.GG23170@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 2 Sep 2024 03:54:54 -0700
Message-ID: <CAHsH6GtRW4jHPMMWrkRGo8u6EZFxx4stYp_3SGLLEdfojYo5=g@mail.gmail.com>
Subject: Re: [PATCH ipsec 1/2] xfrm: extract dst lookup parameters into a struct
To: Simon Horman <horms@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Sep 2, 2024 at 2:32=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, Sep 01, 2024 at 04:57:36PM -0700, Eyal Birger wrote:
> > Preparation for adding more fields to dst lookup functions without
> > changing their signatures.
> >
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
>
> ...
>
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
>
> ...
>
> > @@ -277,9 +279,12 @@ int xfrm_dev_state_add(struct net *net, struct xfr=
m_state *x,
> >                       daddr =3D &x->props.saddr;
> >               }
> >
> > -             dst =3D __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
> > -                                     x->props.family,
> > -                                     xfrm_smark_get(0, x));
> > +             memset(&params, 0, sizeof(params));
> > +             params.net =3D net;
> > +             params.saddr =3D saddr;
> > +             params.daddr =3D saddr;
>
> Hi Eyal,
>
> Should this be: params.daddr =3D daddr;
>                                ^^^^^
>
> daddr is flagged as set but otherwise unused by W=3D1 allmodconfig builds=
.
>

Sorry about this, thank you for this catch! will fix in v2.

Eyal.

