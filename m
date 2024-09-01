Return-Path: <netdev+bounces-124045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E2F967681
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DB28241C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960117E01A;
	Sun,  1 Sep 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je+u2WhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C417E016;
	Sun,  1 Sep 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194929; cv=none; b=toAQWWJv0/bws05G0YlkrD2BbjNcUj4+k1O3pDYzULsA5/8qfGKdHTcjAkMKm3HHU3zEAADMyNbc2553Bgjrxq6RjNYGRaGrGmXlY+65wV2ZZ7GTi4aVbLKAjApoD3585NfB8UqEFYZ2ylZhcTYVM05fb2vtUarea1TxE/to8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194929; c=relaxed/simple;
	bh=ptKHvA1cZ54hW8NZKWblgQe2i3MrsSZk3J79I6fJSvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7VFHF3Kfj7M3UkNkHWoD5VWv3kb6yjjbbJ7M8xM79n3QunDLzN0Wm3UXIILCC/0CHAi7bOxZHi5Tq+Z+zI/ULnc9BZfi1oZN1OfApPjArE1YDnxevhgtDvyqtcLc+REhynGVpcc2opwQrlM1S2mEZExKhdJcAjz/kunRjs76fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je+u2WhZ; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e116a5c3922so3236903276.1;
        Sun, 01 Sep 2024 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194927; x=1725799727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoIqg8+zAPhpmO63TxrT9mX5bM0uul8AC6qCIVT+yDM=;
        b=je+u2WhZgxw/KCvhOYFVULP79fG1eLCjqEasZghtLQWTG4eU58pBk+Xpdv6ZVmbkLh
         ODHJ3HgQMkSycyyoNEvnNl4Xk0YDcr8hR/JJfjHOOd0go3nrkvRUJ854vk4ljf5pQxnk
         A3abfYjzcv7meqYnCMOlZueka7SavWLTKYcusS3KdXrIHytK/C21Cs5kMBAnDAMWo6Az
         mUQm/cAewEWhfmj6ge2mUgyK4tysHnYmAyOYcxFYEWMZCVY6+gH3KtaKAuynAfq3q8Dt
         UGG6z3bVzaVFr/KN8uAObuIatKhWrc6JGxgBsAD/uSS6pL/r6OgLGthSxl2ynqoTfy9U
         MzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194927; x=1725799727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoIqg8+zAPhpmO63TxrT9mX5bM0uul8AC6qCIVT+yDM=;
        b=Bxakz9lbUDeyD15SoF4BRgmr9nIDCLsPsGJ629iRpmmJzEwDEOv2+rRekd5ZGsBOCz
         XrvA6DfIgwa54sT78MLqN2ioQV5mPaekBt1Tt5vHVXbnIHl8COdIYNdpEkXXgyXB2q+A
         5DITnQDn7zzh0eYl45UOb7aQd3faHk4QhSofEmxVxxtIzef1bKt6rLxVQIU6I7yvx1Ro
         y0qJVZgA9O4rRQJD4dhf0glL11Sfe8TZLgmmA5/wpXZ83G6V7Hj2Ps9gRZsqZK+mssmw
         wH2TdVvqLK3oiha6wbRxlCySrb54Pg3Hwav7eO7TRyYr+TBh02J5i7INUCCvPL6fFtCU
         /cHA==
X-Forwarded-Encrypted: i=1; AJvYcCWJtH82VlF1v4BZcMqOvgWJa1PeOHhvmQErbLa0Ua3KvpVA5vTi1tlw8u1k51GE7H1p6jN/U61398AEYfQ=@vger.kernel.org, AJvYcCXMKibn5EF1u+AJ7N9ocMlaKRP/uqVzpcOOMpjHyId2myHox2t16BbYILNNFBjeLVXH/TlpRf6F@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgmXx4vCvAGvrKg0UcSgZVVcuQnHfL1D3gMF9yvEGAGsv/pvZ
	UGuX3Z511CWhHT8h2cDjkvdiZcF9TYrKk2LJsgBwMGcMtSHnIr9qCHpEuZLIQATFrF+Ta+thXOv
	fjGq9i6Sq5MIS2Dr/lVK9W5N4FF8=
X-Google-Smtp-Source: AGHT+IFgjFeLWSe2M3jQWJMT8imdQxYI9U2W7ghRibCVpb3mzaIrT6+4pV2yFwWFD+m0qqSH4Q6atQWWDRevmiuJbNY=
X-Received: by 2002:a05:6902:1021:b0:e0b:ea37:9c1e with SMTP id
 3f1490d57ef6-e1a7a017a1bmr7908927276.21.1725194927169; Sun, 01 Sep 2024
 05:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-8-dongml2@chinatelecom.cn> <20240830153634.GR1368797@kernel.org>
In-Reply-To: <20240830153634.GR1368797@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:48:48 +0800
Message-ID: <CADxym3Z-rSBH9HvpeZHk4rLOZSb+u=dACUo98upsqFUEqr-Gsg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to vxlan_rcv()
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:36=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Aug 30, 2024 at 09:59:56AM +0800, Menglong Dong wrote:
> > Introduce skb drop reasons to the function vxlan_rcv(). Following new
> > vxlan drop reasons are added:
> >
> >   VXLAN_DROP_INVALID_HDR
> >   VXLAN_DROP_VNI_NOT_FOUND
> >
> > And Following core skb drop reason is added:
> >
> >   SKB_DROP_REASON_IP_TUNNEL_ECN
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - rename the drop reasons, as Ido advised.
> > - document the drop reasons
> > ---
> >  drivers/net/vxlan/drop.h       | 10 ++++++++++
> >  drivers/net/vxlan/vxlan_core.c | 35 +++++++++++++++++++++++++---------
> >  include/net/dropreason-core.h  |  6 ++++++
> >  3 files changed, 42 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > index 876b4a9de92f..416532633881 100644
> > --- a/drivers/net/vxlan/drop.h
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -11,6 +11,8 @@
> >  #define VXLAN_DROP_REASONS(R)                        \
> >       R(VXLAN_DROP_INVALID_SMAC)              \
> >       R(VXLAN_DROP_ENTRY_EXISTS)              \
> > +     R(VXLAN_DROP_INVALID_HDR)               \
> > +     R(VXLAN_DROP_VNI_NOT_FOUND)             \
> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> > @@ -23,6 +25,14 @@ enum vxlan_drop_reason {
> >        * one pointing to a nexthop
> >        */
> >       VXLAN_DROP_ENTRY_EXISTS,
> > +     /**
> > +      * @VXLAN_DROP_INVALID_HDR: the vxlan header is invalid, such as:
>
> > +      * 1) the reserved fields are not zero
> > +      * 2) the "I" flag is not set
>
> Maybe:
>          * ...: VXLAN header is invalid. E.g.:
>          * 1) reserved fields are not zero
>          * 2) "I" flag is not set
>

Sounds nice!

> > +      */
> > +     VXLAN_DROP_INVALID_HDR,
> > +     /** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni =
*/
>
> Maybe: no VXLAN device found for VNI
>

Okay!

Thanks!
Menglong Dong

> > +     VXLAN_DROP_VNI_NOT_FOUND,
> >  };
>
> ...

