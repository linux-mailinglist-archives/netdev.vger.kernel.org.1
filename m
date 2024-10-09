Return-Path: <netdev+bounces-133727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C5996CD6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA702820C4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF0199920;
	Wed,  9 Oct 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCG8j05w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E71993AE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482113; cv=none; b=uUeXtsUunmEluxRBUlCI8YfTM9DihUQw6BYgGT2j2wtaA53fqzhKcvL8v2MNBKH+jowpvQSP3knoPqg83pWca9Y8rNUGbLRI/9Y9juQN5nCOcjQxQzvlf4CuR93/m8XOh9ez4h1i6gs2znCV/5pgZmT1Eex0R15OFpUOaJi8g+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482113; c=relaxed/simple;
	bh=k7DdMpwjWrSVnF70efu9Nz576OUVbA8sKqdX/14wnt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4w7f8nUHiuRuavD598zpL1dOTSFYAkYqB3zD+ANgAJkPAPeuuEFye9/7XslO4pm6XO0heBmBhAfveWENrZTdS0XLftoiKbS+MRMfFTtAB0OMTQtLxWkiDt/+ydo3gduj/Ktrs4Nwfh9QY2rKBWzrYyswveLXiCSGmHRj6n1huE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCG8j05w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so3911481a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728482110; x=1729086910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZu/+gdB6bHOpVTSHgDrGd7M0vlZH+wWHXs8Fc7Ognc=;
        b=oCG8j05wTvCRp6vvzQmviTE+7OxKi2R33pYXFANxx/MoQpPtxXbadjuFE3LAlxp5UX
         AbFmeoLKcmiWcsl0UW/E64zZH3r9oVdxKbWKpBH04Lc+IPRCj/wozgCxdMxo9o/3hrse
         J2vzv8LLWzdP0Mivo24woY9fql9xSSl8SZpi+uKx3CKvc+9ySyjwKQ0rP6yEkSd38Mt0
         hgSFLNYwdZ/ihhUrJSTcPWG5fbCIxFx++eH5GN2h40VDP0BEt9iwBM5w8NevAFrDWN9c
         RZFHgK0t+g65896P1/tcnREi+LaIqdatwjAM7CtJdt2RWt2ZZ/iI9P97C6LDAcNdUCPQ
         LW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482110; x=1729086910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZu/+gdB6bHOpVTSHgDrGd7M0vlZH+wWHXs8Fc7Ognc=;
        b=k0py7Xer7BvDIncMXvaqnKADJSl844ivzoXS+3qLLeYOyUtkz7cv+oIIWZWj/BI07k
         TX1+26ocG/PGl5B8RaBlmnq5Tae6fDF+H9nibjKmWZeAkN7zWUX9fy7fAN0p4bstAtzF
         iKYQs2VOL6vlAdF5GHmj0MrleH1UpezkyjqDXMrSioeyU2+a+ZEGrEWcZmax++UjKce3
         lo8ObuwIyh20GkyItfQ3a/JumNep3HAbGPO1ocHZ8jAxVKgvLXXMzKjgP6n5UUbK/6dt
         O6HdukR/ugjp+r200CTHgAic5oWQW1mUNfcU9ZNZXKQ7gsKdlabKnwoFurxXxUeD5+ju
         ZYrw==
X-Forwarded-Encrypted: i=1; AJvYcCU5DQ4T9EgYGuqpoiGWXpbYuCJWiPKBJ4xI8V24lMD9r/q0dPREE3LEA3l6U0UL1wmtxjhg/Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkB/iHK4NHcpacIQYNTSUcg+ZERwWeV/VvLDDyBbm0NkNVfeh
	YaXgX5ct3LphuPijeAG+lfz2KJ29tGwyol2IeiMjZgX11Zl3zOXTsFDMyiVM+/BSj6va/XAFPjr
	WVYvTQgUEb170po+UABgIGk/qalykikTsVhT4
X-Google-Smtp-Source: AGHT+IEtAzSUDyXHbQ3P6oqVQMFsthgaasp7xwpxPc8RphUDDeGCLQ4wnkjhhmtyLiaqxF2Wb39RmFXqv580ZGOJAew=
X-Received: by 2002:a50:8dc7:0:b0:5c9:1b62:48f4 with SMTP id
 4fb4d7f45d1cf-5c91d58cedamr2219054a12.15.1728482109811; Wed, 09 Oct 2024
 06:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008163205.3939629-1-leitao@debian.org> <cea1458c-6445-45d0-bfa1-3c093384cc90@kernel.org>
In-Reply-To: <cea1458c-6445-45d0-bfa1-3c093384cc90@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 15:54:56 +0200
Message-ID: <CANn89iLH=Y0GuZz3b2p5d7MtEcPFt62+Z4LBbdiRDtE157ER1w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Remove likely from l3mdev_master_ifindex_by_index
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, 
	"open list:L3MDEV" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:25=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 10/8/24 10:32 AM, Breno Leitao wrote:
> > The likely() annotation in l3mdev_master_ifindex_by_index() has been
> > found to be incorrect 100% of the time in real-world workloads (e.g.,
> > web servers).
> >
> > Annotated branches shows the following in these servers:
> >
> >       correct incorrect  %        Function                  File       =
       Line
> >             0 169053813 100 l3mdev_master_ifindex_by_index l3mdev.h    =
         81
> >
> > This is happening because l3mdev_master_ifindex_by_index() is called
> > from __inet_check_established(), which calls
> > l3mdev_master_ifindex_by_index() passing the socked bounded interface.
> >
> >       l3mdev_master_ifindex_by_index(net, sk->sk_bound_dev_if);
> >
> > Since most sockets are not going to be bound to a network device,
> > the likely() is giving the wrong assumption.
> >
> > Remove the likely() annotation to ensure more accurate branch
> > prediction.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  include/net/l3mdev.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

