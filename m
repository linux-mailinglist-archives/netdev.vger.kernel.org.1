Return-Path: <netdev+bounces-81169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD88865F7
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E051C2351E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EE883D;
	Fri, 22 Mar 2024 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC6/uxPG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37AC121
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084970; cv=none; b=t1fkms9geUa45KVh8+RYLi7SvrORxz5uUaTa5tl67gAykJDPWVjIlYHuk6/ELwJrbhb3QUyjueI48QjMcLr8TFpXvhr2QfIarLkZEjVHBIgIkFf/PZUlYYVs0PkbiyhAkyRiHtrfwDqp5J/JIDflIIoJX/RA95qPKVliiMlP9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084970; c=relaxed/simple;
	bh=QytD35JuDlG+En/9t6sSJpgNDREt9E94XyMto3Rpa+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZeRELZuvSanWGAydYN+wPV5uUdsVpFyB7LLXKluA9DBsolA0P4X73WA8jcayfEMaYZeuzYRS+nutCUCqi9gNsFIDoS205wZhDI7DyvlFIY0mBK9oRprJB2rGzdLQ5n3tqFv/IkW1zc1xRbY96PJGUvV/9zu2cN/slnNMEhr5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HC6/uxPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f64uD3ctRKLKxfrmn6XfohoQXF2Xm9nnpbY3kz4u4o4=;
	b=HC6/uxPGlKvn/TQFqbM3AXLbVl1M7EY0nurNODlV6q4WUfQd/kJlXd7Xx+mqBf6po3P4jO
	ZM5WzRxAUVkSEH2OM/xSzADMKBkOgDcQP7EKU/8JpfAXYeqysjdAKmcoW48mXPojH+oH+K
	Z8wa7VQ1+v1EFDKmp5DoVUesjKfqhtY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-lci3sBWPMueXcGDIzi9epA-1; Fri, 22 Mar 2024 01:22:43 -0400
X-MC-Unique: lci3sBWPMueXcGDIzi9epA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6962767b1e7so29245356d6.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084962; x=1711689762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f64uD3ctRKLKxfrmn6XfohoQXF2Xm9nnpbY3kz4u4o4=;
        b=WAlprAMldNlt+18GjTjCDcynHQ/bKhl+rii1520DRWl/0dPetoqY8DdW/lB2noZNLa
         Bt6WSPLAJ3tSsdK5pfqW24mT21cDtMPnBOIZZjLgxifxNyLocGsnKdRh5IxylRuTgFW/
         zlgl8S7lIZZtvoL48sDMgGrr/oHDIsgvt54ZvI/Tas8wHCf+tUgy6gDc4xvQOyOF1OKI
         0SaIBW2Ej7fAD2wkpiTvYaQ/jAl0RG8sZRVsufrY9/AYyNC9KPMud0IBuAAQWp+CstfT
         T/VtQ0i9fbP+SgvWOXUCfUSg8R0g9r/xflqdbdAyUZczrL4vZquASSDuAzgArA3cW6xn
         wjug==
X-Forwarded-Encrypted: i=1; AJvYcCVsVIUQZt4eRUqA84n4k+xpprZ2n7hTk1F2kUNUZOCi05SoS9QyXoLRFmi/M11kVE+9cEZBKH/CgGmOmECSscauVOcONf9Z
X-Gm-Message-State: AOJu0Yz++e7orMdKacdrIAhy+jZII2+xJPBTMhnyndexE6Kaw8SALfrq
	be0QCCW/vsxAXfW4tRDhjEkmPJ1YRQ9N2e5td0btf1k6yxlJxBqAXXuUNUL35lE+cpilImIZZGt
	1+UT+BpetP2QyqXW1AVADf5FeocVOxrk5NOvJ5fptpZXHvJqtZUtwYczBVrjp91fUBZMQbYTXSf
	RIOJGTNVaexpzxRVQ2bVD4VPH+l/qdm0iOXWtNA+9YjA==
X-Received: by 2002:a05:6214:e4e:b0:696:32d5:98d3 with SMTP id o14-20020a0562140e4e00b0069632d598d3mr1346531qvc.36.1711084962425;
        Thu, 21 Mar 2024 22:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5yXn3+w5s6+ehppU+kKXkeJABGiiv8v0yk9v5XPd/nmqIS5A83FzmMfiZGNHonIsnis37fDEgTrVhYHLvbiI=
X-Received: by 2002:a05:6a20:4f23:b0:1a3:69f8:b6eb with SMTP id
 gi35-20020a056a204f2300b001a369f8b6ebmr1346699pzb.14.1711084521278; Thu, 21
 Mar 2024 22:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-4-xuanzhuo@linux.alibaba.com> <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
 <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:15:10 +0800
Message-ID: <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:29=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > This commit structure the indirect desc table.
> > > Then we can get the desc num directly when doing unmap.
> > >
> > > And save the dma info to the struct, then the indirect
> > > will not use the dma fields of the desc_extra. The subsequent
> > > commits will make the dma fields are optional. But for
> > > the indirect case, we must record the dma info.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++-------------=
--
> > >  1 file changed, 38 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 0dfbd17e5a87..22a588bba166 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > >         struct vring_desc *indir_desc;  /* Indirect descriptor, if an=
y. */
> > >  };
> > >
> > > +struct vring_packed_desc_indir {
> > > +       dma_addr_t addr;                /* Descriptor Array DMA addr.=
 */
> > > +       u32 len;                        /* Descriptor Array length. *=
/
> > > +       u32 num;
> > > +       struct vring_packed_desc desc[];
> > > +};
> > > +
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor,=
 if any. */
> > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect descr=
iptor, if any. */
> >
> > Maybe it's better just to have a vring_desc_extra here.
>
>
> Do you mean replacing vring_packed_desc_indir by vring_desc_extra?

Just add a vring_desc_extra in vring_desc_state_packed.

>
> I am ok for that. But vring_desc_extra has two extra items:
>
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>
> vring_packed_desc_indir has "desc". I think that is more convenient.
>
> So, I think vring_packed_desc_indir is appropriate.

It reuses the existing structure so we had the chance to reuse the
helper. And it could be used for future chained indirect (if it turns
out to be necessary).

Thanks

> Or I missed something.
>
>
> Thanks.
>
>
> >
> > Thanks
> >
>


