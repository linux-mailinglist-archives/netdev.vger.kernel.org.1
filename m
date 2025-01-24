Return-Path: <netdev+bounces-160690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD8A1AE1E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90C816B82B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB11D54F4;
	Fri, 24 Jan 2025 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h333yGq6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863D1D54D1
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681311; cv=none; b=Me4afAe+FB+jBA64hkVbgR5+vDWgAOPr2fZ/9qGkSkpG61Miaw3mSRALHJkL0DZp96jMt0fm3lzAbLybntUVyiYuYUeRaaMSS5Ce1ikj0yUOKZfh+VD5RxGIHVJ1GERktYrO35gcKD2Y/a6+5hC00ezy5cXRoIB4iXPGEjJCNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681311; c=relaxed/simple;
	bh=wVROqD729UaIhKFsEUWh98t7SuHQX1Dmhx5pBp/PPu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qb63QMar8i8e2v0rWFMMm6YFcgb83YBH6WCxKp3C5RIjlp546jBl27GzY5So91A45ocLkdtrWfGLxbtA8dsX1DBgoGQLSMp3zJvVpHlhir9uVJP9tZ7L8KoEgy1yKL56/baESQ+q8vhzD6jPXqckME8+/tG7e1qA201VYChjDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h333yGq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737681308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILIsXvqrol1mCP2F1LpFSlYC1lZdeh26s+qA/ldD0XQ=;
	b=h333yGq6ZAgSdJoa1ZIPLSQmFHwBMW29ViN1QnE1gf955uiTGPpf8aduH8saELAB/3pT8O
	ta5mHbMd1QZlTvTSm7qYD8BppgM/vKEfrXKMChfL9lYJygGo7/EbXj+3Yfz+w3fOpi0Dgy
	dGYWuH+Hx6yv6k07WhylOUBXrjETxG0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-cR-DoefuOwWR3LVxysmxWA-1; Thu, 23 Jan 2025 20:15:07 -0500
X-MC-Unique: cR-DoefuOwWR3LVxysmxWA-1
X-Mimecast-MFC-AGG-ID: cR-DoefuOwWR3LVxysmxWA
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-518773b0471so347424e0c.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 17:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737681306; x=1738286106;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILIsXvqrol1mCP2F1LpFSlYC1lZdeh26s+qA/ldD0XQ=;
        b=SN7zGTR1WVhjQ/x7FtGJTTaUgsGQVialtpS+nrEUxj/syG0hKiUOUvblv9XFQW8yqV
         ZZTXbHGDAtuosppFzlm7caEQHn+5/tpp97udcClwdnbcCx048Nm0ORjFlK9a8JVMursN
         usvsjMWznRfZOkE0oydg0uSOKYjiULJVJAYWvkaX8nSKNb8JhcarD8xMdCXWqECwRCcw
         4yuWU7uEwaSfpoSgvoQI66c5/BTxeWjOPKOb6VBkrnCOZSvHgpd+CG/cPgw9smotal70
         jVgkT01ggqDUfh+8+bcynfh2QkEr8qJKD5UHKir9/FV1htPJC+1nPpiXOASZD8Mot6a3
         c19w==
X-Forwarded-Encrypted: i=1; AJvYcCUH7x/2xpXPzJQrJa8QSG8DE8/fSP3jr6l2Pn0mLkyCDns1MsKw/f9spzZifz7r12lCShsOzxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbssWDqvegcV0meeUyoUohTdW26JioUFI3My1jSaOAp+yJBhUs
	o83l3idjjrf+wavzspQ80FUleHB9R/RzCYsX2J/j0G5w0bcUSZ0YjMLsTQIZLSCXcqz8TGT2QiK
	sk4GCfa/DWLS5BOsTzeh/KNbw0grLsWMNYzydABLmW1yyjSj/ynrr9Qlvm5+GLnRUM0uEGe4Wyd
	IFNZa2e1aEw748IWPlUIeo7vQ9ls6z
X-Gm-Gg: ASbGnctEij3AoCbpFIFgDfwJXiT1wV9/Skl80gku7rCQ2mrRIWcZ925LCDQWOhyO1qO
	cMFkvhyolxcJ5/bMqUn/pRkldqFES7D/DO9RCZmI3H0WzmnOCog==
X-Received: by 2002:a05:6102:2acc:b0:4b6:20a5:776 with SMTP id ada2fe7eead31-4b690c85364mr24491187137.17.1737681306439;
        Thu, 23 Jan 2025 17:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmj2b1Q22f7IVZGtn7j/OIq3ocr2h3rVfbq4tFeu7iIXYoOR4qRTK92z0FMdl7Wq1NkyApn1WAx57UKSWxzGo=
X-Received: by 2002:a05:6102:2acc:b0:4b6:20a5:776 with SMTP id
 ada2fe7eead31-4b690c85364mr24491185137.17.1737681306109; Thu, 23 Jan 2025
 17:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2> <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
In-Reply-To: <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 09:14:54 +0800
X-Gm-Features: AWEUYZkiA2ikm4-7dgBdOU4NH0-wOsctvcu4K-HiEMYrTZ53Ng13lMg9gKspi20
Message-ID: <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
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

On Thu, Jan 23, 2025 at 10:47=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > On Thu, Jan 23, 2025 at 1:41=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.=
com> wrote:
> > > > >
> > > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > > functional changes.
> > > > >
> > > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > > ---
> > > > >  v2:
> > > > >    - Previously patch 1 in the v1.
> > > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > > >      functional changes.
> > > > >
> > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue =
*rvq)
> > > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > > >  }
> > > > >
> > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct nap=
i_struct *napi)
> > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > +                                  struct napi_struct *napi)
> > > > >  {
> > > > >         napi_enable(napi);
> > > >
> > > > Nit: it might be better to not have this helper to avoid a misuse o=
f
> > > > this function directly.
> > >
> > > Sorry, I'm probably missing something here.
> > >
> > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > in virtnet_napi_do_enable.
> > >
> > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > the block of code in there twice (in virtnet_napi_enable and
> > > virtnet_napi_tx_enable)?
> >
> > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > calls virtnet_napi_do_enable() directly.
> >
> > I would like to know why we don't call netif_queue_set_napi() for TX NA=
PI here?
>
> Please see both the cover letter and the commit message of the next
> commit which addresses this question.
>
> TX-only NAPIs do not have NAPI IDs so there is nothing to map.

Interesting, but I have more questions

1) why need a driver to know the NAPI implementation like this?

2) does NAPI know (or why it needs to know) whether or not it's a TX
or not? I only see the following code in napi_hash_add():

static void napi_hash_add(struct napi_struct *napi)
{
        unsigned long flags;

        if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
                return;

...

        __napi_hash_add_with_id(napi, napi_gen_id);

        spin_unlock_irqrestore(&napi_hash_lock, flags);
}

It seems it only matters with NAPI_STATE_NO_BUSY_POLL.

And if NAPI knows everything, should it be better to just do the
linking in napi_enable/disable() instead of letting each driver do it
by itself?

Thanks

>


