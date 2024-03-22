Return-Path: <netdev+bounces-81174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCA88668E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 07:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7FE1F22123
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD7BE66;
	Fri, 22 Mar 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aYnimi1H"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EA8F6F
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087399; cv=none; b=jll0ggadPpAZldLKkfGf4vGRPk5Yfw7tx96dfV1buyMaV1SPWdoYKeRWaipBDcYI8EH76lR7I7ssN8lIXdbUD64Uo8curvnD/OurnEXVXvohy1iawwKBBJmL8SY4zKEnBJZKrR5vtE3o1ddNGXlsfcWLkGve6ahrTblEmj8Iwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087399; c=relaxed/simple;
	bh=caCmcTzq12y+jqWMv9A7kwwJIN7zLpIY6BF1bQNHflM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=bJiZxf+4gRB905z52ExNcPNUKM4WFGXbe5r8hE9MJDB5j9tXizUfhjZ0goKR0A6VKbxxhSw9Mqa40UYIXZbAWlwsra8qjEdtUCokCpYIDCfhMArDavNAF7vNOLCdZCdV7YKN7E37zKD9VgwG5+6jmimcpD6s6nMDoJZKri7GpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aYnimi1H; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711087388; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=XmHyb2TAUIWlcUq9ZQ14Lpel252a1eCeznWun+VNgYw=;
	b=aYnimi1HJUsLoXjyQ3uUwaf4DzGIChnMp7TetIn6c4n8x6y5f5Rt/zCsRUW/tF+o+BndnULAdrQMmK+E+QtZDUH8P1N5xAMj2PS9nxraLYhfgrobZcG8ejwg/ViWK2vADkGfJjPGlj6Mz9VZ5n4vRkFQiQQxnx2yCYd+m71MGrc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W315pdr_1711087387;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W315pdr_1711087387)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:03:08 +0800
Message-ID: <1711086955.58408-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the indirect desc table
Date: Fri, 22 Mar 2024 13:55:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
 <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
In-Reply-To: <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 22 Mar 2024 13:15:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 21, 2024 at 4:29=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > This commit structure the indirect desc table.
> > > > Then we can get the desc num directly when doing unmap.
> > > >
> > > > And save the dma info to the struct, then the indirect
> > > > will not use the dma fields of the desc_extra. The subsequent
> > > > commits will make the dma fields are optional. But for
> > > > the indirect case, we must record the dma info.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++-----------=
----
> > > >  1 file changed, 38 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 0dfbd17e5a87..22a588bba166 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > > >         struct vring_desc *indir_desc;  /* Indirect descriptor, if =
any. */
> > > >  };
> > > >
> > > > +struct vring_packed_desc_indir {
> > > > +       dma_addr_t addr;                /* Descriptor Array DMA add=
r. */
> > > > +       u32 len;                        /* Descriptor Array length.=
 */
> > > > +       u32 num;
> > > > +       struct vring_packed_desc desc[];
> > > > +};
> > > > +
> > > >  struct vring_desc_state_packed {
> > > >         void *data;                     /* Data for callback. */
> > > > -       struct vring_packed_desc *indir_desc; /* Indirect descripto=
r, if any. */
> > > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect des=
criptor, if any. */
> > >
> > > Maybe it's better just to have a vring_desc_extra here.
> >
> >
> > Do you mean replacing vring_packed_desc_indir by vring_desc_extra?
>
> Just add a vring_desc_extra in vring_desc_state_packed.


I am surprise to here that.

Do you mean this: #1


struct vring_desc_state_packed {
	void *data;			/* Data for callback. */
	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
	u16 num;			/* Descriptor list length. */
	u16 last;			/* The last desc state in a list. */

	struct vring_desc_extra desc_extra;
};


Then desc_extra is included by desc_state. I do not think so.

I guess you mean this: #2

struct vring_desc_state_packed {
	void *data;			/* Data for callback. */
	struct vring_desc_extra *indir_desc; /* Indirect descriptor, if any. */
	u16 num;			/* Descriptor list length. */
	u16 last;			/* The last desc state in a list. */
};

indir_desc pointers to memory:

|struct vring_desc_extra | struct vring_packed_desc desc[] |


>
> >
> > I am ok for that. But vring_desc_extra has two extra items:
> >
> >         u16 flags;                      /* Descriptor flags. */
> >         u16 next;                       /* The next desc state in a lis=
t. */
> >
> > vring_packed_desc_indir has "desc". I think that is more convenient.
> >
> > So, I think vring_packed_desc_indir is appropriate.
>
> It reuses the existing structure so we had the chance to reuse the
> helper.

Which helper?

But, if you mean #2. I am ok.

Thanks.

> And it could be used for future chained indirect (if it turns
> out to be necessary).
>
> Thanks
>
> > Or I missed something.
> >
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> >
>
>

