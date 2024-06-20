Return-Path: <netdev+bounces-105195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2BE91012F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DE1B21475
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F331A8C0D;
	Thu, 20 Jun 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSjMIc/H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E481A4F2B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878257; cv=none; b=gN8ONrIKntpFjnkFSu7PeGXGEPm2onYaR/HGa/XoKf1eBnk98BvZCRmbdcpkK5093RjJYAxgOrkVsANmc8ZUP5shc4D5FYE0pMBwgZiODzEf9i1wM+GaDoQbe8AGOWNK1+bh0stbYSKO5rGv1ocEWtBeaW4VuQULblbt7vWhiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878257; c=relaxed/simple;
	bh=kKoUm3PO7qYSJlhRKqspHcMFqm6a0tyYtDVoSFqz474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATuGvcWEegYOieRbeDdnloxg/3vrg8OUrQehCBRV1WuCnRd+XhIl7z2GoYJwm6fNpzl2ssRCenZ6usYtQWMhuJgbMbZXe/kfFN8/pWGHz+koPtOMPYMukxCFmugTS1o2o2dtpC0JxYpcCxBS4wzzC+z5B0LtDDjkjPGHBbTMcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSjMIc/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HpbUlkLZ8ibKoVaeJCN4Dk5U1yWp1DtsYjK01WnZis=;
	b=TSjMIc/HRFLUtEUcJJvG+5mziN64bqxoXIODbEk/JAIDcbyCrnUWsDHDw+D/k/nRSOItc1
	m+vMi3uD/JE3Zcfa2Hw/ik1XojfjiefEo0ZvUw4Rn+Vq1yVdzTn9f3g86E+wo37XKBOa6k
	Z1PIr4g4bPoKTE+orS+J/gtSHgRN/7E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-TYGPH61MM4qUcuKiNZUriw-1; Thu, 20 Jun 2024 06:10:53 -0400
X-MC-Unique: TYGPH61MM4qUcuKiNZUriw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6ef9e87ef1so34932466b.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878252; x=1719483052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HpbUlkLZ8ibKoVaeJCN4Dk5U1yWp1DtsYjK01WnZis=;
        b=B7UUoljbSgE6F/VwXpGzUIkbYBWwMoscfum1a0qA//zgEt0hnGQbCFIW24iVvUhQ/R
         OfYHroAPWZC1ku193wR94YSN3BG6yhQyADqimiyUisOTTVJbL25WtSVSCFk0A972qCpp
         nuMHlBttp8mDY70ac4iOsGsxri8DeoIwiBPLBDOX4bA1HEsn9NToEhjr/J+utCP8pFQg
         DMtfveehN8RLQcslyV3Wh/wmcEbVs8Lqe0olJDehQZ/7HPCvz5ZF8eUiT7JhmwfBokx8
         j9GCB26SFV5zNit1T0UHwvvnL5Mj5oJ6QkGyE/BDi/cJpUob9ef//kIWAJ3t5jGzZ2XI
         ICjA==
X-Forwarded-Encrypted: i=1; AJvYcCX7xwqyo071fc3zGgcY4dQEg4bQIXm2kj5q6+UpJud2Jtr/sOCIbitY6wWDOnM8HNmsArDUIdAjkMG07Mv5uc8xCIM79xzu
X-Gm-Message-State: AOJu0YxHx2wz1epMBWIjO9puXYMetHqSfMOsoUcbhuawPZ4OYnOvaXcF
	SAVcsiJJ667v454tKdW7JTZF9O2IV12a3cxQdj33rzetGS8yBgFWoLCvGcF4wfY1u6qsn7xIkwl
	/3PfPE3PKDMVZMfbwVehTxA5XcK1VYZv8ZGHUCXyZ0oI8WZPFLTByag==
X-Received: by 2002:a17:907:a646:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a6fab60321fmr334918466b.8.1718878252285;
        Thu, 20 Jun 2024 03:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfawUQaD0CC/3GEg4kloU53QXav4qYoiS7hHVhoX5VS5ncH1y5JPi/ciJOk+O7GOYKvfjyg==
X-Received: by 2002:a17:907:a646:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a6fab60321fmr334913866b.8.1718878251396;
        Thu, 20 Jun 2024 03:10:51 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f788f46c6sm504148166b.23.2024.06.20.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:10:50 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:10:46 -0400
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
Message-ID: <20240620060816-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1718877195.0503237-9-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > >
> > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > >
> > > > > >     /* Parameters for control virtqueue, if any */
> > > > > >     if (vi->has_cvq) {
> > > > > > -           callbacks[total_vqs - 1] = NULL;
> > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > >             names[total_vqs - 1] = "control";
> > > > > >     }
> > > > > >
> > > > >
> > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > this will cause irq sharing between VQs which will degrade
> > > > > performance significantly.
> > > > >
> > >
> > > Why do we need to care about buggy management? I think libvirt has
> > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> > 
> > And Qemu can calculate it correctly automatically since:
> > 
> > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Mon Mar 8 12:49:19 2021 +0800
> > 
> >     virtio-net: calculating proper msix vectors on init
> > 
> >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> >     obvious not suitable for multiqueue guest, so we depends on the user
> >     or management tools to pass a correct vectors parameter. In fact, we
> >     can simplifying this by calculating the number of vectors on realize.
> > 
> >     Consider we have N queues, the number of vectors needed is 2*N + 2
> >     (#queue pairs + plus one config interrupt and control vq). We didn't
> >     check whether or not host support control vq because it was added
> >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> > 
> >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Yes, devices designed according to the spec need to reserve an interrupt
> vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> 
> Thanks.

These aren't buggy, the spec allows this. So don't fail, but
I'm fine with using polling if not enough vectors.

> > 
> > Thanks
> > 
> > >
> > > > > So no, you can not just do it unconditionally.
> > > > >
> > > > > The correct fix probably requires virtio core/API extensions.
> > > >
> > > > If the introduction of cvq irq causes interrupts to become shared, then
> > > > ctrlq need to fall back to polling mode and keep the status quo.
> > >
> > > Having to path sounds a burden.
> > >
> > > >
> > > > Thanks.
> > > >
> > >
> > >
> > > Thanks
> > >
> > > [1] https://www.linux-kvm.org/page/Multiqueue
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > > >
> > 


