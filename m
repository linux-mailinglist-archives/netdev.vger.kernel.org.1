Return-Path: <netdev+bounces-140077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88539B52DA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D148281C34
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63862071FC;
	Tue, 29 Oct 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bijO1axr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677201DDA2D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230790; cv=none; b=n17exv/goETm+tCujR62qPsnyGaxIP5pAzD1qHnxz9Q9qxpFvKAhqO5l3n9i4uZs3TdzXWA5geECSOHyz1GFvNyvuxQYuPjRs6useoJ1hKPSthVwMNb6xn2pptAutbmZYlLjR9+uPKitJLNk9A3Zsuk5WY8JS/MqifFDBgzCKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230790; c=relaxed/simple;
	bh=tZoHZ1gNY3Xi+Qc/Y7qW+YMGUsuwV/4cBoNGuW9nF4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EKxO0xuiNIjoftwX1caRbzdjseeL7jNg/cxuhoYL/J4fzwfX4yXQ6xNCwGEgbn9E7y8IQexesef9/4at9bied/YziyHjMi8J4gLcc/M4x3w9wbpBI0IN3onCh8n3Z7DaKXT4ZUKK8UtDKmH6tCGx7SoJ7NRQPcrZbo/v2naTN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bijO1axr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so6678356a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730230787; x=1730835587; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2Qh5NffAmjgnjiXE8C64a7evCdv5ui7XPKs/zH+TkQ=;
        b=bijO1axrD1YifI/2S/6bbe2bosg9lt6nvzX9TQcf98hx6U9W2W1hvpSN2h1AfvkUPX
         RYogEZXydCHm0wGvzafDlw6eEc6AMJK+/yrQotTN9KipQXHmTYp402elebM53Vv56OMQ
         CIUu+pKldC8nKzzWgDzIM2r496LfIml/wWGwxmPUeAH84Y7MEZnHSVP0lzxqrpZPRlcy
         B4tGPt4ormHdWZiFUn8uGYz5MNYl6VTxL3GIlwgYToKmthG6aSxILUSsiEgeCbvmYA2E
         zPx5MGMZNOw+fNzzv1+36Nx28YFiO69YnVijcQvB42hCh0GGCjcdaGgT8sBBHvap8eyh
         qRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230787; x=1730835587;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2Qh5NffAmjgnjiXE8C64a7evCdv5ui7XPKs/zH+TkQ=;
        b=SPpChXnu/oNl7R+YSIHEFZjTYkLgptkZpIE0P6UbhWs4bAh9bBYHjDc+1j053+XpUk
         g/OGJGLxcyt05LwbTWfntljrnAl8XV/WJWpbgbqdbJNyvjfo1+B0TV0kuX+5C1+RIzdB
         tpkDZQHz3GhGYQjQv+5uyGRemfI7rDld0gf07KCUnKtfrw76tEfdiU0s9CuPSWa7iIrz
         POCWN+sh60F7XE3kB4tHG//ELeP5k+S4BRdm651rQqc/QsGjTcJOVhwIIv3cKytgpAIY
         Z4+3zm1eeiTytV9fOVePoAmP1z/JoUQznduZYCztyTn/av9zis6qUinAIoXqSpXHTM15
         q6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5cvkEn2Hq4kK7JrT3RRdhFihD5ROecb/XGTM0K20TRUno1gP6f+kITQVFU2mUPVUOG2EFM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUfx4Lwg7FkLzOs/Ei2DRoHv8RgXfv/O+YiovPkQbHyHErZwe
	3IgNqYYVGHyFfDpnPgNjwM9SHYDYR4a6SuQFKxhgw2PCd18ycbQtNhyvlM1bE/F+ngdB49kzh0w
	Nf6YgyzTNB3UD2dWqOhN5K4YuYd5+ipFJXQMT
X-Google-Smtp-Source: AGHT+IF5ye8Kc55bBa7QJa8TZS/1B31juiYJQu80XCLqccue85qasdADdcKIxV748TSnjrmsKtOuLUpyZ3m702PkRNw=
X-Received: by 2002:a05:6402:1cc8:b0:5c2:6311:8478 with SMTP id
 4fb4d7f45d1cf-5cbbf9208c3mr10802195a12.25.1730230785856; Tue, 29 Oct 2024
 12:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029191425.2519085-1-edumazet@google.com> <ZyE4sn-F0ed9YQFQ@LQ3V64L9R2>
In-Reply-To: <ZyE4sn-F0ed9YQFQ@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Oct 2024 20:39:31 +0100
Message-ID: <CANn89iKFbtMM2XvXdFDi1hrCn8UdRdPsuhZ0Js7Vo61e__ULpw@mail.gmail.com>
Subject: Re: [PATCH net-next] dql: annotate data-races around dql->last_obj_cnt
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:34=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Oct 29, 2024 at 07:14:25PM +0000, Eric Dumazet wrote:
> > dql->last_obj_cnt is read/written from different contexts,
> > without any lock synchronization.
> >
> > Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/dynamic_queue_limits.h | 2 +-
> >  lib/dynamic_queue_limits.c           | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynam=
ic_queue_limits.h
> > index 281298e77a1579cba1f92a3b3f03b8be089fd38f..808b1a5102e7c0bbbcd9676=
b0dacadad2f0ee49a 100644
> > --- a/include/linux/dynamic_queue_limits.h
> > +++ b/include/linux/dynamic_queue_limits.h
> > @@ -127,7 +127,7 @@ static inline void dql_queued(struct dql *dql, unsi=
gned int count)
> >       if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
> >               return;
> >
> > -     dql->last_obj_cnt =3D count;
> > +     WRITE_ONCE(dql->last_obj_cnt, count);
> >
> >       /* We want to force a write first, so that cpu do not attempt
> >        * to get cache line containing last_obj_cnt, num_queued, adj_lim=
it
> > diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> > index e49deddd3de9fe9e98d6712559cf48d12a0a2537..c1b7638a594ac43f947e00d=
ecabbd3468dcb53de 100644
> > --- a/lib/dynamic_queue_limits.c
> > +++ b/lib/dynamic_queue_limits.c
> > @@ -179,7 +179,7 @@ void dql_completed(struct dql *dql, unsigned int co=
unt)
> >
> >       dql->adj_limit =3D limit + completed;
> >       dql->prev_ovlimit =3D ovlimit;
> > -     dql->prev_last_obj_cnt =3D dql->last_obj_cnt;
> > +     dql->prev_last_obj_cnt =3D READ_ONCE(dql->last_obj_cnt);
> >       dql->num_completed =3D completed;
> >       dql->prev_num_queued =3D num_queued;
> >
>
> This looks fine to me. I noted that dql_reset writes last_obj_cnt,
> but AFAIU that write is not a problem (from the 1 driver I looked
> at).

Yeah, I think that dql_reset() should not exist in the first place.

When all skbs are properly tx completed, BQL state should be known and clea=
n.

