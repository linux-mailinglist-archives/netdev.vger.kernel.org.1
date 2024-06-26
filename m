Return-Path: <netdev+bounces-106739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A09175EF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58D82850E8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6AB12B87;
	Wed, 26 Jun 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs2g/cNn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88845C07
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367131; cv=none; b=nODXUntL9r+39P+idT1wXY0kOwLsHZhgnvpmXOGPNOr8F3D/SM39saapPvuEff5CifCMoHCTvpPvOoBDLEO/c2wOo7nKLqLIsMMNw4bQVoWFtiKsUxNjhxMCiLW2hKPxGNb4lMnqB+fAIyTC0Yd2jZGVwmtZxWNctJ/hWQVPTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367131; c=relaxed/simple;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owbeHEoyygiwwGFK4SUYTY2/LHQjqvnYgjmhdw8ylWD0xzbo8i/Lkxz9p6rjcVJpZYG3KrjQSt8jaY3ODExU+TzMQoIFAX4cSj3W+u32w4x+Wl+QD8drHDl2qrD7nFgd7pq0CQgQYiK4vA7sVGJyeQPYR8HmcSdkm2FXtXeUbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs2g/cNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719367128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	b=Rs2g/cNnnjfNIfJ2XJZsYch+YbHRgYCV6KO7SjYjyz88mcpaXaULK+c9fNDcz5oJogBELb
	Wmy6sZfA1gAlP9emjNWpKJ7O7BMtscGjyqzfMjqHMLYVDHGn2jVv8o97HW1muB0E1z7Mhw
	/t8yFJ4L5ikwn0zs5K/PU/rIBz9fqHc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-nkEH-Vd9Pwei5Gv6LbJECw-1; Tue, 25 Jun 2024 21:58:47 -0400
X-MC-Unique: nkEH-Vd9Pwei5Gv6LbJECw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-718c62ad099so5624816a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367126; x=1719971926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
        b=hVx45h5J3Plv1qLYPP2KvsZzCTMCtZKcNLmEVOYrTURcOW65iSaDnsE3H43Sw6t71r
         /ioT86V4XSwMU5AXVCivN4Xlx0z8l4lmb9MquQ4h7NOWNrKbqhuQ8YGJ0IhLq135oiVs
         vIbOplkp+u79TG8PQXLH1PNxH5SbwTkr/6vnft2mkBFw1kUvqHECWXFhwnQkpBfAjoZm
         tg94y6/5MTjMnZYlHV366qGEw/9YTkUH3t6leBy8IvJBkt6t4WnPMELhhODWsvLDEdEV
         QxDbYt7AxfW4SwIDSpb4t4tGkYpCSKo4avvVfzPNpc3qELtjDETTy19Yfhh9m8YzEwoO
         uYhw==
X-Forwarded-Encrypted: i=1; AJvYcCVLXz5DTh7qgIvJyKw+jS52iCucUCqHUthz4D+uQ+swMxVJvzZdT9lBYm7/IhzGJfuZ3Ae1nsk/cS0Mv30jyVgTl7iIXpVc
X-Gm-Message-State: AOJu0Yz6b29JXsJg3foRhcA6PSRu9Ala4O7IdmWBcjCyFlhqvfE8KUg+
	+SijfY+cAwA/TdC7NBajsnX6f5X1YRw38L+A58RVr+ol2pViV5J2XP1UyalLK9XmiQ7PqMtSCKy
	oLD8zb7PJgfq7i7w6Pex/puRjpiGetC9IArZEyxSt6z10Y1Hx6ihADIY45b6GV02zBB9G+st7Vl
	YXa/9qwI8p6psnOvnFfcZfKHmQPXHy
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id 98e67ed59e1d1-2c850573e58mr8416514a91.30.1719367126328;
        Tue, 25 Jun 2024 18:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cItPu7kw+lpFHgT9mFcrgcyIi3eaohdOBIsIuRQUoMjB36Oowm0mQq7gn7+W9fkMRWr+6IMsheb7X2K6btw=
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id
 98e67ed59e1d1-2c850573e58mr8416498a91.30.1719367125794; Tue, 25 Jun 2024
 18:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org> <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
 <20240625043206-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625043206-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jun 2024 09:58:32 +0800
Message-ID: <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> > On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > > Workqueue is used to serialize those so we won't lose any change.
> > >
> > > So we don't need to re-read then?
> > >
> >
> > We might have to re-read but I don't get why it is a problem for us.
> >
> > Thanks
>
> I don't think each ethtool command should force a full config read,
> is what I mean. Only do it if really needed.

We don't, as we will check config_pending there.

Thanks

>
> --
> MST
>


