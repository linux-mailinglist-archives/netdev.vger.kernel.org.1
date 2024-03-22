Return-Path: <netdev+bounces-81165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B98865E8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5510285C02
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452015BB;
	Fri, 22 Mar 2024 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNMM3N83"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4EBE4B
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084433; cv=none; b=KTP644uQjMVNYCweJBhyx2P9r3r0lRxuWa4eL+mbsU6jfR4KDo57apP+KmVd0v0GNgOHxYkTMpWMN3cEKAgqaSxN/iC6erQVRTiDOm1pJ4mU7pgeLmAGXaOHTeJJXb7D4qciDKiK+HjyNt17A/znkRrTD0ShaxxdUdsIssajmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084433; c=relaxed/simple;
	bh=BUYMklqmw7+639WJzmrIAMbYivvbfYTPpa1SYTIG0dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdaF+KvaeOdcwF2yG5rMA6Vr1dIjkKCRmMq+Nn7F6kTInusgvv46xq4m+OMdNpBeHsdEkODUm9iEvN2fq4qtMfvAbeI/8r5dtk85V/IbhMjyX2sjtkUBdKpYOD+gV2S1hJ5EWyfoE4pohoyWCbtYNqXC8yWVoGJlaPysgzEZLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNMM3N83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVLbbYCxnNuf6Gw/xnXzjZXwreLI7AHf88DnXBC8tyY=;
	b=CNMM3N83HBu64p3uwKpPFq2KtZghCKr3ygOny2DYyR6qDpgBAU5kioVtrd2AbbHV5ZRuUD
	fIMmfr3ntS74wOHXkLSbnftDvWmQnegQ4NM02W2LMlyGLOopm7JfBp6gQ8kcJsBwJXIcOM
	PdSxreJxOdkc6D8h3jOQP3+wIqJSBSI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-PmyMpaiVPLefeUC1KSwmWQ-1; Fri, 22 Mar 2024 01:13:49 -0400
X-MC-Unique: PmyMpaiVPLefeUC1KSwmWQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so981201a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084428; x=1711689228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVLbbYCxnNuf6Gw/xnXzjZXwreLI7AHf88DnXBC8tyY=;
        b=JLmPgXDlWC6hV0Lirx5kfTMViaHBcmQWMIAc0sS1ULMC2O8+jdQU0/QScJP/KdefNw
         PYpLhWujGRzVH3xpye+AJCAhJ/NgLMiSDZzRaeI5iC9O+LmE+98a3nDHOSsLza7SiWCt
         BU2X2B/fLJ+f2Bx2knXskp43Juf+qb2IINkVa3gmyF/nc5bEw64fuIj7iz2J3Tamo6MV
         sbzsDugfaB0iYtkqBWzWlAutWDZ0P6u38libqZ2gxEXlpSRkw+o7hd+/v+mSOiyBfnBL
         c6eeD0qIbP62wgPegArEIQXIeKYibl1Ud3M9ztThKsRr0BWWMcVtaqnYBDImw6YZbjWK
         LTyg==
X-Forwarded-Encrypted: i=1; AJvYcCXwb77vwB6fHNFSRXR++SzZeeX08nFQSrSjyay32I1LJv6qioXDJaumEygItl+7gbPaaSmVZdt4qZbBTrzDlgr8AjdUwmTD
X-Gm-Message-State: AOJu0Yy8D92zNHeQmHmrVtz7jnvHAp0LztARVD3oPF3ifUuCJDMqktej
	enyQ9/MnmU3en/7Y6itmNsTWolwtlHLAnQDyVPFw0l8kONv1NQ1DBF8w/L5le1PVw1tXeAVgyT2
	VeiAsO3786dEckT+INBIk8MMiEw7NyWwGFwcwpRWLQOxhveO1kNNuP6VAesircH8z/AikVcsY2Z
	mdaWKk5XCB5KZ5RqxWYgtRHyvaR3gt
X-Received: by 2002:a17:90a:1284:b0:29b:c17c:5fa6 with SMTP id g4-20020a17090a128400b0029bc17c5fa6mr1249112pja.33.1711084428008;
        Thu, 21 Mar 2024 22:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Eayi83t0eb1MJcsMUvJ5thFo5csIJL+WG37qUBhny1rRRa9A1HtQYegMbPSe0jgONNu33xOctIxNcksYaEI=
X-Received: by 2002:a17:90a:1284:b0:29b:c17c:5fa6 with SMTP id
 g4-20020a17090a128400b0029bc17c5fa6mr1249104pja.33.1711084427767; Thu, 21 Mar
 2024 22:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-11-xuanzhuo@linux.alibaba.com> <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
 <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:13:36 +0800
Message-ID: <CACGkMEs+x8bObJ0Fr0LbkPzWqYSoU8Y8504=bqZtjux2T5-_Vg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped
 support disable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 21 Mar 2024 14:02:14 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Now, the API virtqueue_set_dma_premapped just support to
> > > enable premapped mode.
> > >
> > > If we allow enabling the premapped dynamically, we should
> > > make this API to support disable the premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
> > >  include/linux/virtio.h       |  2 +-
> > >  2 files changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 34f4b2c0c31e..3bf69cae4965 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >  /**
> > >   * virtqueue_set_dma_premapped - set the vring premapped mode
> > >   * @_vq: the struct virtqueue we're talking about.
> > > + * @premapped: enable/disable the premapped mode.
> > >   *
> > >   * Enable the premapped mode of the vq.
> > >   *
> > > @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >   * 0: success.
> > >   * -EINVAL: vring does not use the dma api, so we can not enable pre=
mapped mode.
> > >   */
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premappe=
d)
> >
> > I think we need to document the requirement for calling this.
> >
> > Looking at the code, it seems it requires to stop the datapath and
> > detach all the used buffers?
>
>
> YES. The complete document is:
>
> /**
>  * virtqueue_set_dma_premapped - set the vring premapped mode
>  * @_vq: the struct virtqueue we're talking about.
>  *
>  * Enable the premapped mode of the vq.
>  *
>  * The vring in premapped mode does not do dma internally, so the driver =
must
>  * do dma mapping in advance. The driver must pass the dma_address throug=
h
>  * dma_address of scatterlist. When the driver got a used buffer from
>  * the vring, it has to unmap the dma address.
>  *
>  * This function must be called immediately after creating the vq, or aft=
er vq
>  * reset, and before adding any buffers to it.

I'm not sure this is a good design but we need at least some guard for
this, probably WARN for num_added or others.

Thanks

>  *
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).
>  *
>  * Returns zero or a negative error.
>  * 0: success.
>  * -EINVAL: vring does not use the dma api, so we can not enable premappe=
d mode.
>  */
>
> Thanks
>
>
> >
> > Thanks
> >
>


