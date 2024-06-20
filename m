Return-Path: <netdev+bounces-105196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EFB910135
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CD5B20C4D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3171A8C15;
	Thu, 20 Jun 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbiDDaYN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7071A8C05
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878312; cv=none; b=UFsvwor40kI7kqQgt18aS1A58oLqk3xqLMWO/b5SDOvmPqS5kvnYWZvlvXb/6HSW9gKg2NUQtRzAAn1Pg+Wnu4BQ9o9zkyaKHh9P+EHDgVbeCTj8JZ8G8xMsJ+g9LAw77cxPum728J0tFoJofIPNjFCdRnKnDpxXYRDwy075btI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878312; c=relaxed/simple;
	bh=jkzmF9Xid2aLr4XKEkzyb59+U1OT5X9+7JdCqgQaXoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUkSLSpUAairfbXef4oEDoG2T7n1mP+f7jFydlq6s+5e7lxU+cyi7fc2JhLg81pBPO/AZe/GLIE0eh+XewhNjUQ0m8KZAgX/001gfnuwC9WoP3E9/6ylMGsiwGcTmGu/oSshtbl7DlAnacySrLDz1esll/VE6VEC7LBDUZU/oiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbiDDaYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kw9HM3KamhLERa2K67DAsy/gvS+yu9Tp59autjb6IE=;
	b=IbiDDaYNUFfBFVRnXFfFbkqQVCsomhj9jkhJSfvG12Gt8nnHcv5kc6NWbaUt+9BDqUPU7J
	d/oeYpjCMaumItp9J3vCffdi0+C03YTRYNQtwf7150f6XgDP2ZzrFNfUI71DQwP/8XuAgV
	Mzd359Vn8lYVMKTXlW1KsFSEkJr+SM4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-mv-shDaWNCCBH1iLFZNp8Q-1; Thu, 20 Jun 2024 06:11:48 -0400
X-MC-Unique: mv-shDaWNCCBH1iLFZNp8Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6efe58a1aeso32342966b.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878307; x=1719483107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kw9HM3KamhLERa2K67DAsy/gvS+yu9Tp59autjb6IE=;
        b=RCsC8q1L4N97FZj0W8ZEOcsffDYfDtCm9GCgrbbcqX1dJzG03m6h0sVjsgVKiGyM0B
         s6OCqK75O1GtvyjdonBOLE+TGlKJkm5i/SujBQ9V7F8VnZJXvXOAhb64Ve8UCBL7S7VC
         9ZSmPytRgIQeP6uH8iP3yGApWfux6s/zgnkVA/ytux6EGkN9JBcYoxAsvoBePxuLf1AA
         hLsSa6bmH6+kzA9VK3HoOOhkG0tMY/z7TvyDu14MuMmiF3gurHFlmaH4LuWPwZp6gG2T
         u+2dZL1rHpoMfhWRvdOQvuf0X9lx3WskmA4dYZootyZal50jxWyEz4gD1lfo1bgS3/X/
         grKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kEAUt010Ppy2jjhJx7oIv7VoUWOjLnfYIUXC6rbqcupH2GAIT7px4cC7YcTVhFhhd/7U3wNOLutRJfCnVMSezPLc3zHc
X-Gm-Message-State: AOJu0YyCSPSFTa1OgTFfs3+ooPGCvoc+n9WXCY95G/kIlzajT2iulpCS
	KUS5j62jClLPXVWFLWqPetCQIdpyi6lWYXj5Qsr8fJrnIwcPvu21Alop674UC5BWZ6AsLMdjq+B
	YiO1T62TaJGi4uwdSGdygqr2sZFsX9GagA2t5z09dZrIem9mC50VXwA==
X-Received: by 2002:a17:906:d78f:b0:a6f:6803:57ef with SMTP id a640c23a62f3a-a6fab62f55cmr273263866b.27.1718878307083;
        Thu, 20 Jun 2024 03:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9pVkXEno8kTNO8OIeoExPEgy/WSM127G9iCS2Rxcoh4npb4ENAfV+o2MIA0vOkVnV9bbxlQ==
X-Received: by 2002:a17:906:d78f:b0:a6f:6803:57ef with SMTP id a640c23a62f3a-a6fab62f55cmr273259766b.27.1718878306146;
        Thu, 20 Jun 2024 03:11:46 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f7c12f7c0sm461085866b.198.2024.06.20.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:11:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240620061109-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240620060816-mutt-send-email-mst@kernel.org>

On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > >
> > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > > >
> > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > >     if (vi->has_cvq) {
> > > > > > > -           callbacks[total_vqs - 1] = NULL;
> > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > > >             names[total_vqs - 1] = "control";
> > > > > > >     }
> > > > > > >
> > > > > >
> > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > performance significantly.
> > > > > >
> > > >
> > > > Why do we need to care about buggy management? I think libvirt has
> > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> > > 
> > > And Qemu can calculate it correctly automatically since:
> > > 
> > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > 
> > >     virtio-net: calculating proper msix vectors on init
> > > 
> > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> > >     obvious not suitable for multiqueue guest, so we depends on the user
> > >     or management tools to pass a correct vectors parameter. In fact, we
> > >     can simplifying this by calculating the number of vectors on realize.
> > > 
> > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> > >     check whether or not host support control vq because it was added
> > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> > > 
> > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > Yes, devices designed according to the spec need to reserve an interrupt
> > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> > 
> > Thanks.
> 
> These aren't buggy, the spec allows this. So don't fail, but
> I'm fine with using polling if not enough vectors.

sharing with config interrupt is easier code-wise though, FWIW -
we don't need to maintain two code-paths.

> > > 
> > > Thanks
> > > 
> > > >
> > > > > > So no, you can not just do it unconditionally.
> > > > > >
> > > > > > The correct fix probably requires virtio core/API extensions.
> > > > >
> > > > > If the introduction of cvq irq causes interrupts to become shared, then
> > > > > ctrlq need to fall back to polling mode and keep the status quo.
> > > >
> > > > Having to path sounds a burden.
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > >
> > > > Thanks
> > > >
> > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > > >
> > > 


