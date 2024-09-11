Return-Path: <netdev+bounces-127232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F14974B23
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EEA2859A7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1C13959D;
	Wed, 11 Sep 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnHYj6xX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC617E107
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039299; cv=none; b=tKh/fK0MK6rPEj0eY9nBXugWGCiaEq6eODDDs3LTU+xbFFpDXItWvh6sDHfn5HRq+UH64jf9xrdrc5D7I4txUQGTqZw9XYHO0/mAUf8bz4cQktVrGC0Rct91NmXd6Cm5mgmF+RTgvvVKc6Wh+ONvdDpnmeIN3WpE1o4+pz4eyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039299; c=relaxed/simple;
	bh=JXF6OhzCcsZA01/jGTXgNZxQHJWmQpIHR1FAPdZ4eg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR+3ovWQdZkvsd87vLI7CyNLA2aSZF4Gz9gALfvdAL0cTmmpzcPfFM79YK2kz28GSM0b/ALlBfHbnaJjHa2Um6FIfeOBLwPi6MZkp7Atrp6OtuWR0yB+grCmNBcQQVQThq59IAPgG2oBA9kQu8KSmTy+2qtlf/QY+3fqeGEZ/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnHYj6xX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so694913766b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726039296; x=1726644096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzQUgkP2p+Exn7+1xDTn8Gs1UAfZCR/a9UsLVUYY7Cc=;
        b=xnHYj6xXYnRKlxl1odbuNhqWZZ6pMn5y6PAOxmaWZ0Hem4ra72aHOD/k/p0pqODFL7
         QSYevzyjhTBd1VtYftNliMI5cdgWSgUfTYTaSII4wSroazKILuV9xxuJsglho0FSS6g+
         w3J7ki9miFCH1SkPrLmwl+tdBLU03WLG6LeM0DbEx8jWK91na/Yb6S5Eg4ChQ5Iy/ec3
         TRLA+kJRrSrG4tcWPYwWn25VVNwWwN7+pkmX0odmB6JRg3c1cJ8t4MXZQjgijnapSgI6
         GLOT2voGcH81ngiX/96YDqZnz6alivCmvXo+n2nbz3w9QiRkhtASRRJAl+U5sejUy0dv
         ye8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039296; x=1726644096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzQUgkP2p+Exn7+1xDTn8Gs1UAfZCR/a9UsLVUYY7Cc=;
        b=nbUhDOhsWr5H5vSqeWJfp9Z54uHjp62CxmZlwvL/RtEpMU1+Ky4QR0fmS7xYzc+2fL
         BhGNCIbR63OdnX6zeLEV2Pqumc23bQAF5T8cNQga9mSO1aIj2t+RaVPnW91zm2E80Nc3
         pd8ULCNT0s3mt3Tak3ktLXS0FcvtE1CK0wqet9hMtFvhoUWnxt5DnjZmNzAKVsgP2C1O
         3YEFM0knaH4digN58VlVZCX9VH/hys5xNC51HirDq+a929ApbTEd6RKLqO5geEyoDy+1
         THBpJr7jrOkmjwbk3Kkl+hhjVWUsfrlY4z1jTWTNVDLDnWIdO6wA401LaHVyEBW5qVRw
         0s5w==
X-Forwarded-Encrypted: i=1; AJvYcCVGj+Fo7uPM/VLlPtxIdiHXJwoxcXo9BiEw/BqHafHu4e1c5H63+01uBBdGeJtVwXay4hhQknM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQnzGcAk73eN7qykqRvF9QMWS6qTrq93U5xD3Eeewp0E9goSF
	+83Z4lZBRTZM8/q5j3HH6tJcjwbz4bhP1hn9cVLcmhvEEbFTclamz1rGoEjSttpfpijBfFIdlW0
	/ShNkJB+ZTtdGOhWkkF6RlEvpWUIlKHk+qBpK
X-Google-Smtp-Source: AGHT+IEF7H8fPS56fvaPS5UfQ7i3nEbghrV7YtS5OYToPd5htarwvawfTxXIStcttABgOf77bFdCnKyvQYfrxZWkD3c=
X-Received: by 2002:a17:907:1c1f:b0:a8d:1970:db07 with SMTP id
 a640c23a62f3a-a8ffad97d3dmr271207466b.52.1726039295124; Wed, 11 Sep 2024
 00:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911034608.43192-1-atlas.yu@canonical.com>
 <20240910205642.2d4a64ca@hermes.local> <CAB55eyUZ=D-vnQZNaNEvLu6gVp33OXvsjJMmdeMiYqVR1FJ2XQ@mail.gmail.com>
 <20240910220016.160ed631@hermes.local>
In-Reply-To: <20240910220016.160ed631@hermes.local>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:21:24 +0200
Message-ID: <CANn89iL6wo_OYw0E4uSsydJNVsfWvj5LytrWrQbbhmrN3k5kbA@mail.gmail.com>
Subject: Re: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Atlas Yu <atlas.yu@canonical.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:00=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 11 Sep 2024 12:17:24 +0800
> Atlas Yu <atlas.yu@canonical.com> wrote:
>
> > On Wed, Sep 11, 2024 at 11:56=E2=80=AFAM
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> >
> > > On Wed, 11 Sep 2024 11:46:08 +0800
> > > Atlas Yu <atlas.yu@canonical.com> wrote:
> > > > diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
> > > > index 797ba2c1562a..b612b6cd7446 100644
> > > > --- a/include/uapi/linux/if.h
> > > > +++ b/include/uapi/linux/if.h
> > > > @@ -244,7 +244,7 @@ struct ifreq {
> > > >               struct  sockaddr ifru_broadaddr;
> > > >               struct  sockaddr ifru_netmask;
> > > >               struct  sockaddr ifru_hwaddr;
> > > > -             short   ifru_flags;
> > > > +             unsigned int    ifru_flags;
> > > >               int     ifru_ivalue;
> > > >               int     ifru_mtu;
> > > >               struct  ifmap ifru_map;
> > >
> > > NAK
> > > This breaks userspace ABI. There is no guarantee that
> > > older application correctly zeros the upper flag bits.
> >
> > Thanks, any suggestions though? How about introducing
> > another ioctl request for these extended bits.
>
> Doing anything with ioctl's is hard, there are so many layers to deal wit=
h.
> Mostly, networking has treated ioctl's as legacy API and switched to usin=
g
> netlink for any new features.

Note that rtnetlink gets the 32bit flags already, this has been the
case for 20 years or more.

include/uapi/linux/rtnetlink.h:566:     unsigned        ifi_flags;
         /* IFF_* flags  */

net/core/rtnetlink.c  : rtnl_fill_ifinfo(...)

ifm->ifi_flags =3D dev_get_flags(dev);

iproute2 also displays more than 16 bits in print_link_flags()

