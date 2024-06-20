Return-Path: <netdev+bounces-105166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA990FF08
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE33283B19
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF619B3F3;
	Thu, 20 Jun 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMY4jLIf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FA19B3D7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872673; cv=none; b=TBO1CiJVGQzn9yFkUt9eXWcXJBjARLRpviJiK+ZJMkJypKEyHAmOu3Le6qREGgsTz7liYOLBlm7bV4ih3ljOeuFw/XMff/bK+O731Nn4wEzxzZN5erDYMu8VFX05ohPI8exFye7QhKxdShzYcTMvkssrC0oE5jqYWRxqQ7ylNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872673; c=relaxed/simple;
	bh=bPdIpzcTTvLFCUgmLkJzuvuzlJSVU3NMUPwui9LPBWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVoRMg0kMGpqkB4lZtnwz0Nb9UsuLKIe1o5oUVPIBINm5cANo2nEEA7D3XKLIp5o1E2WxDO6bEgn9Wx3K2nlVcCyERTBAKmhcEAnhshsJ23A9jzUDFZGz9SJO5f9GmSHmB2OI1+GsH3uE8+rfj31ukj9qGV8w/VXPkxJVnBIgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMY4jLIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DiWfvytz7+zAvxiDWnyDm8IkadAMsfzl6Hj18xLwCY=;
	b=TMY4jLIf3BLH35UVMY5DWhCEEjlOcVPbetHpI1WgQthNGTmqg/hkxQsLhle8adz71P6bie
	L5gg7l6bTa0DSOAcnttFtm+ka10IxE/IzYGqvhKDwMkZyNZrxd8uTD+4B6J7YJZ2vy+62W
	+xHX6u48iYg1crgNUlXsPTKQNLcdGNg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-o5K3D0K-PBm1mIa7aYz_QA-1; Thu, 20 Jun 2024 04:37:49 -0400
X-MC-Unique: o5K3D0K-PBm1mIa7aYz_QA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7316658ccso739434a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872668; x=1719477468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiWfvytz7+zAvxiDWnyDm8IkadAMsfzl6Hj18xLwCY=;
        b=mykqdIOO7WOqfikofdeM3SbQgtvbuc9bleV6UkY0LI72n8YfGXAthUM3PtmCA/ApyG
         uoAFBu2A1r77Z6U7MwPmEx4iWaBDKKeK6qO3BKk3LVcLATu2UOZ474e1/PbOBw/xv5Ch
         QcZK48pK2HIBVuoWVSfYI4TNPpRWynHYnO9KPAgoAjHZAnjJZt/LBW/4Ksbo24Mg7WHB
         fGTokA6bCjOskHJLRXMof3T4h012qrPQSKHI52Zxn+vWyNbwEmBpRwlEhifVU4KKVZTu
         1XUqkXSos0NhhmCpsYJQNoI9/X33ZZU0MlTdg+nHJmwQUv0kpFC0qZBhk//BB4bjncky
         zL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXxzq3HsEqOKcj3niPp/EetxbzWKyP6cAtcsfQgQ3MWg+LxQODn3QdnIcs6a6UpaN+PUrRygHtK5fIbVb0NGSq2njq4vaIB
X-Gm-Message-State: AOJu0YzpkqPo0vUX8+PntNV+v3JxeuEa5zPE5h75ANiHGoH67y1UftR7
	ce8ffFP2z//tAcSCAzSRJ2VmMjMLxdx3SMOlznz13YJYpXpFay/GnCzskp+3p3tRSSmY85/iNPc
	eLlCICwNgcijfzcz44kC/NG2qQzgVhN16/JJTN9adpN6qIuEezgSYm2OOqE2mEcAX6yp4YzfxuF
	sHGhNS2rIA+bgTWfXkTdVD+Rpy/1IK5tdvkILL
X-Received: by 2002:a17:90b:97:b0:2c4:aa3d:f1e8 with SMTP id 98e67ed59e1d1-2c7b5b06d60mr4701796a91.14.1718872668039;
        Thu, 20 Jun 2024 01:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvcQbwZkBFWFg/wUVEago0naLsiGLej0AP5gvBK9V6HQqUy/HV6RVsNb52ScnI/bw0YjoaVa4aCEvkfIZRIC4=
X-Received: by 2002:a17:90b:97:b0:2c4:aa3d:f1e8 with SMTP id
 98e67ed59e1d1-2c7b5b06d60mr4701774a91.14.1718872667609; Thu, 20 Jun 2024
 01:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <20240620034602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620034602-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:37:35 +0800
Message-ID: <CACGkMEsCQOKyzR9tjkN=iTiqmcHeOOmuFKKcL2rLA1ENYYN02g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_in=
fo *vi)
> > > >
> > > >   /* Parameters for control virtqueue, if any */
> > > >   if (vi->has_cvq) {
> > > > -         callbacks[total_vqs - 1] =3D NULL;
> > > > +         callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > >           names[total_vqs - 1] =3D "control";
> > > >   }
> > > >
> > >
> > > If the # of MSIX vectors is exactly for data path VQs,
> > > this will cause irq sharing between VQs which will degrade
> > > performance significantly.
> > >
> > > So no, you can not just do it unconditionally.
> > >
> > > The correct fix probably requires virtio core/API extensions.
> >
> > If the introduction of cvq irq causes interrupts to become shared, then
> > ctrlq need to fall back to polling mode and keep the status quo.
> >
> > Thanks.
>
> I don't see that in the code.
>
> I guess we'll need more info in find vqs about what can and what can't sh=
are irqs?
> Sharing between ctrl vq and config irq can also be an option.

One way is to allow the driver to specify the group of virtqueues. So
the core can request irq per group instead of pre vq. I used to post a
series like this about 10 years ago (but fail to find it).

It might also help for the case for NAPI.

Thanks

>
>
>
>
> > >
> > > --
> > > MST
> > >
>


