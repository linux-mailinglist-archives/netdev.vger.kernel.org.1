Return-Path: <netdev+bounces-106790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB364917A7A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCA91C22E85
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E679015F33A;
	Wed, 26 Jun 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSgQYXUM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5B364D6
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389318; cv=none; b=Bww3VYRm0noLIvZcha4doJDD4oTO3hrZ5kvh5AiMQ+Z4d3F+lo2RfxFPA8r7f9BeiG7Va7T1v0f9UxsSQF05IFZZvI2ahStMPe8HQcsR8qgK7PtXMghJzyyfq/A7V70bNsUIjPhPF6JiFTSSEzPfM00/+5gmHeb7UtLIkGZpO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389318; c=relaxed/simple;
	bh=aB1+MldYvxbQUyxEJjAT0rA/UCaRqalple5w1m/mT74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwi3d1NXjfcrqpd/LHXuTQ7+r3LRtQ4nlVZm+Vk2mqxkVbsNe1VLjm7y3TGwjncNYuyeCMjs02duza7mRupif/wmmamwzse29vA5KIixu5acfEDINzf4R5b9XKmDKiK2WDW6ulsJlga6optbfs98hSludHKwDy1E1JpzhsERjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSgQYXUM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719389315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW53FOYz+yPifWkSV3hyL5CpnaqaEZC+cPJs4PgCMlI=;
	b=DSgQYXUMrNUUL0C+xZTlgG6xf1bjJhIkYP2+UrbhwTCs0Df06aY529cHEeEb/mRtU0qTSm
	rcU/KjHiXkRct1ybRpW+hcoFqdKzJxek7M3Bszz5skgNikbkSqYG9X4to0MFvXWLVsxLBw
	HnB7E1TaE6FBixeQ6XfojRCg5SwkabQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-P6KurOtZMiWlhVa7-0AVnA-1; Wed, 26 Jun 2024 04:08:24 -0400
X-MC-Unique: P6KurOtZMiWlhVa7-0AVnA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a706f30724eso169979066b.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389303; x=1719994103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW53FOYz+yPifWkSV3hyL5CpnaqaEZC+cPJs4PgCMlI=;
        b=bWVEz0w2BpM0p+0aKuEcT7Zfh7IvVAHso09oaruSfYKaDK52SEnCrXWQt0CyDNsoHA
         8JYd9xv13vGkroCpjy4u7dRgmSvCjogcuer0r2R8fEhX6gT9+mdwOYFWZQsD2bNwTrRC
         VPQSc0wb9Sn5ls/ybTjuG4YmZCtm+ZTilAANrks1O3G/ptSIlXF2/T8zSDEr47SQstlQ
         He5nmSAbdYyj53WxdFr3cd2IBqPXbPIL36YRNFDj0rht2vrfW1hbcln5zLMy1msFaWrt
         sk+GNieDEuDXDaiDXlB+OUrUR4xI85zUtUJ8MKdV6DbRU3wrACCPia1X0shtcxk8Ls8K
         BeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnbaG5uV0h3PruIFW43HkqiheZLbdG/ICVQf6Ieh8peP9qfxe8vgRPdMp8XajYBrTkAI1m++7lJ5TYR/Z5EdYAeZgNwhoS
X-Gm-Message-State: AOJu0YxnUjNU2+0kjruUIZjttBf0fIVeg9D3OGLfiFK+QpUW/vE0YmrR
	GdAT4fgvnSikQwlbdkqNSWknWvGOuGChrysVg+Kvf8u+Q9zXvFrh3r8URlBH8wLmA2iNtTxvKbO
	+oMeaLNE1QuqiBMmNItOdGCc/uAcsvJwO3wPBaOzW68l7qeruQfUV5A==
X-Received: by 2002:a17:907:c086:b0:a72:7a8c:9885 with SMTP id a640c23a62f3a-a727a8c99e1mr289698666b.63.1719389303023;
        Wed, 26 Jun 2024 01:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkDiUAEeUIIWI4V/2yk1zloNYX8tLrrYKgefPnKiD32Vjr1nbW5zF+5Dx25++4nwNrTrXRvA==
X-Received: by 2002:a17:907:c086:b0:a72:7a8c:9885 with SMTP id a640c23a62f3a-a727a8c99e1mr289686266b.63.1719389301203;
        Wed, 26 Jun 2024 01:08:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a70b248e582sm448516966b.59.2024.06.26.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:08:20 -0700 (PDT)
Date: Wed, 26 Jun 2024 04:08:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240626040730-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnvI2hJXPJZyveAv@nanopsycho.orion>

On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> >> > > > >
> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >> > > > > >
> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >> > > > > > > >
> >> > > > > > > >     /* Parameters for control virtqueue, if any */
> >> > > > > > > >     if (vi->has_cvq) {
> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> >> > > > > > > >             names[total_vqs - 1] = "control";
> >> > > > > > > >     }
> >> > > > > > > >
> >> > > > > > >
> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> >> > > > > > > this will cause irq sharing between VQs which will degrade
> >> > > > > > > performance significantly.
> >> > > > > > >
> >> > > > >
> >> > > > > Why do we need to care about buggy management? I think libvirt has
> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> >> > > > 
> >> > > > And Qemu can calculate it correctly automatically since:
> >> > > > 
> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> >> > > > Author: Jason Wang <jasowang@redhat.com>
> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> >> > > > 
> >> > > >     virtio-net: calculating proper msix vectors on init
> >> > > > 
> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
> >> > > >     can simplifying this by calculating the number of vectors on realize.
> >> > > > 
> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> >> > > >     check whether or not host support control vq because it was added
> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> >> > > > 
> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> > > 
> >> > > Yes, devices designed according to the spec need to reserve an interrupt
> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> >> > > 
> >> > > Thanks.
> >> > 
> >> > These aren't buggy, the spec allows this. So don't fail, but
> >> > I'm fine with using polling if not enough vectors.
> >> 
> >> sharing with config interrupt is easier code-wise though, FWIW -
> >> we don't need to maintain two code-paths.
> >
> >Yes, it works well - config change irq is used less before - and will not fail.
> 
> Please note I'm working on such fallback for admin queue. I would Like
> to send the patchset by the end of this week. You can then use it easily
> for cvq.
> 
> Something like:
> /* the config->find_vqs() implementation */
> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>                 const char * const names[], const bool *ctx,
>                 struct irq_affinity *desc)
> {
>         int err;
> 
>         /* Try MSI-X with one vector per queue. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one shared vector for config and
>          * slow path queues, one vector per queue for the rest. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Is there an interrupt? If not give up. */
>         if (!(to_vp_device(vdev)->pci_dev->irq))
>                 return err;
>         /* Finally fall back to regular interrupts. */
>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> }
> 
> 


Well for cvq, we'll need to adjust the API so core
knows cvq interrupts are be shared with config not
datapath.



> 
> >
> >Thanks.
> >
> >> 
> >> > > > 
> >> > > > Thanks
> >> > > > 
> >> > > > >
> >> > > > > > > So no, you can not just do it unconditionally.
> >> > > > > > >
> >> > > > > > > The correct fix probably requires virtio core/API extensions.
> >> > > > > >
> >> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
> >> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> >> > > > >
> >> > > > > Having to path sounds a burden.
> >> > > > >
> >> > > > > >
> >> > > > > > Thanks.
> >> > > > > >
> >> > > > >
> >> > > > >
> >> > > > > Thanks
> >> > > > >
> >> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> >> > > > >
> >> > > > > > >
> >> > > > > > > --
> >> > > > > > > MST
> >> > > > > > >
> >> > > > > >
> >> > > > 
> >> 
> >


