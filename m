Return-Path: <netdev+bounces-160459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C2A19CFB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9A1887D48
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9F1DDEA;
	Thu, 23 Jan 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1ED6VOj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE431BC3F
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600060; cv=none; b=NTfDxC5uauMZ0LB0iO7nvYAWd5JxdZkkyB6LQKe9hr8XMUKT2+ggMA55Lliavwe0y4R6oDGhpOlubV5u++BKWkzPD6ccit1KphgdtXpb8fP+jH7n3yWSnQofM85uiV7dqeSLECEr37wuzimU7yyCRDkGn34ts+UmrLz0R1lxEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600060; c=relaxed/simple;
	bh=IDSq31qW43H66Z9jxE0sZh2yPTgWaD4smSeqie292eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=u9JhJ31omVnsgXVvLUl2negzZqO7GPzLX3z6Gdn+2K+JbmGuoNuWhaPHpEtJFMiRubsxt2+8HBH3cEg9te5pZ66AYEk49ttcz3RmI0dk6DE8OKlrcrIpelJ7ZeSYlue+5mImrVRL2oJFcKBbEwAFRAc+QVF5DdoBusCqDa+H7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1ED6VOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737600057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfzyYNEJmxf5GB0OtHAkM67x1flGOjXSV05Ky8+TnvM=;
	b=X1ED6VOjNR9KJrgoaOB4Cq00PQuGvQ1oAiiQHsMZF0cDeW81TpxJwSJ9b9p86zhIFFVzEU
	d5f6Nuv9EKsG+E8RT/BCadP5o6UfrnxiLC4TMgrErk/0cGWxJA4B/7c8K7iBklw9/Kikh2
	FJvqnqdX/AK+80ruZ50DmkPduCQrJ/8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Jjb0Ke-rPOK0OEIkl7IgSQ-1; Wed, 22 Jan 2025 21:40:56 -0500
X-MC-Unique: Jjb0Ke-rPOK0OEIkl7IgSQ-1
X-Mimecast-MFC-AGG-ID: Jjb0Ke-rPOK0OEIkl7IgSQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso950902a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737600055; x=1738204855;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfzyYNEJmxf5GB0OtHAkM67x1flGOjXSV05Ky8+TnvM=;
        b=w6Vp2NQbL9olPtxyXDEl8YKqx+DZYz9jT52eog+++Dd1hgWLUzp1dMr8daeyHCRnLD
         txuk8yYexqj9CgmoATV5tX/77CxcJb1FBj4dWUrFdYSpfQEniliGbruJ95UI95gZGIT5
         k5/bRgei1lsMA3aI0kOghWdaOzNDXRkZkKkIFbDSeyWIWdfCyTGqwIeNUG6L+bNd+Re/
         r7bnd7J7AjImMrRadMKKWQOtyJNXuzpzU10q89CmOMXo/tvfx5fw0V68622/hsbqJ9ao
         1yLrvS1JPqrBdi7U32fMQp6B0QG85bS0Cglx6lg1scJUVZMUMrPS5FjZViwKYLD7eOqe
         ZqSw==
X-Forwarded-Encrypted: i=1; AJvYcCXe6Y7quwQ0tCYZgYG1o+QsfQTtg8NurCmI7JcGemtqRmwFxGo8SwCmF/ZUD1vZC5JlIU1YcUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Tqng3evU2+Y+kGCL4Q05x+7/i3pakNNgkgTBD9mwjaUDF46r
	8ua5kcYV2WmtlDzDi30fg6jPs85/XkLr3TRKUjjV0xUaH1axDMyAXYxftYL3q/0IRr1bpnIo3CR
	xm7KGgddM00Gcqs7QARvwfr9o+POhuNdMAsgrB2tl82xf9DACFOmiMJOpkln5SI+xy5da1Hy+zB
	Jc0xNlT6LDRSWKltER88SMBrIXlTd0
X-Gm-Gg: ASbGncu5G9AsoYrSL6C1DIr9O7plhpnagQCd2iKFuIIdchT8jsJHAT4/y8zNqxMaFWc
	ukkgYpf9e9dAVowV+s7uLNUtLPlp9aCtZWP5RYD5ZA4Ksbp71Dg==
X-Received: by 2002:a05:6a00:6088:b0:72a:a9b5:ed91 with SMTP id d2e1a72fcca58-72daf99ed03mr32272027b3a.13.1737600055349;
        Wed, 22 Jan 2025 18:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOsl6RhEOba8DlPMonHjaLopM4A3V0dc+2Z0w4d/Rjw3AFA4pJXIvcNU1iOes3FHDYO7VUJ4YeWGEcPJaHEBk=
X-Received: by 2002:a05:6a00:6088:b0:72a:a9b5:ed91 with SMTP id
 d2e1a72fcca58-72daf99ed03mr32271996b3a.13.1737600054923; Wed, 22 Jan 2025
 18:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com> <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
In-Reply-To: <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 10:40:43 +0800
X-Gm-Features: AbW1kvY-san13m47F8mgbLh1NqP-onuXWgGkl7kTYp-BPipcolLCBzWZ9gcC2sM
Message-ID: <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, 
	gerhard@engleder-embedded.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:41=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > functional changes.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > ---
> > >  v2:
> > >    - Previously patch 1 in the v1.
> > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > >      functional changes.
> > >
> > >  drivers/net/virtio_net.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7646ddd9bef7..cff18c66b54a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq=
)
> > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_st=
ruct *napi)
> > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > +                                  struct napi_struct *napi)
> > >  {
> > >         napi_enable(napi);
> >
> > Nit: it might be better to not have this helper to avoid a misuse of
> > this function directly.
>
> Sorry, I'm probably missing something here.
>
> Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> in virtnet_napi_do_enable.
>
> Are you suggesting that I remove virtnet_napi_do_enable and repeat
> the block of code in there twice (in virtnet_napi_enable and
> virtnet_napi_tx_enable)?

I think I miss something here, it looks like virtnet_napi_tx_enable()
calls virtnet_napi_do_enable() directly.

I would like to know why we don't call netif_queue_set_napi() for TX NAPI h=
ere?

Thanks

>
> Just seemed like a lot of code to repeat twice and a helper would be
> cleaner?
>
> Let me know; since net-next is closed there is a plenty of time to
> get this to where you'd like it to be before new code is accepted.
>
> > Other than this.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks.
>


