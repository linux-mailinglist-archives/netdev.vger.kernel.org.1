Return-Path: <netdev+bounces-105194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AB2910121
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9961F22991
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D991A8C01;
	Thu, 20 Jun 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj1NtBgQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CA1A4F2B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878085; cv=none; b=tbUsbRKfpFPIAnCqeGpTwz0WRoLjZMOlkLZto1FjTIESpm8iPpLGOc3Pin90Krs1gh0jDtRUjxxKBCq8bZzF6sgazY8fHKiSoJmH4sL4wzcZB5OHrq7rwucT+0aqaj5Ky5Kjnn2hz8gdtdgEcgU8FjpRC47sA0WBJJi04Mb0i44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878085; c=relaxed/simple;
	bh=HGm0KaCx6Ocn89BBrxwTLQ1xEL4JSLMm6bIBgMNgJ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auTOGXvX2FKpuEb7c2P5mzzytIZnFy8AuD6eBEt2r2oCK3ualtFJv/vJc7suMJc018Pw7LJvbxGbOvDQYSSVqCta/jv+y0SW+goqvliWzgbnpIscKoU7PBfH7AwTeXh2n7TuAdb8RzIsf1572Gtw5ApqPDMBx3eLnhAX2GjppGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj1NtBgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+7J1opjcbTZ+C5oJ7KgbF91tiHQCONXrfeXXVf1Fw=;
	b=hj1NtBgQYn4phE8pfp5Jhb+NF3Q2cL7dDgI+O3V7cIMrx1Wm33/9Xgk5ziGrThgZ7bPR+S
	AvL/mirYEiySl/CYBn2m+iizLJdpEqRMtNHu2CAGT96XcdgConewtjANot7lxrOKF3rRXz
	1zeoYla6sJ8zoPuJjN1M7S3/52yPLYw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-jh3CxInAPbyc3f7FlmJCmg-1; Thu, 20 Jun 2024 06:08:01 -0400
X-MC-Unique: jh3CxInAPbyc3f7FlmJCmg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f1e1bfd67so29217866b.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878080; x=1719482880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM+7J1opjcbTZ+C5oJ7KgbF91tiHQCONXrfeXXVf1Fw=;
        b=tfFHtR73qyOpGCaHMU8x2OmseFOL6ZRGQNLxpmiM1awQJ+J0ju2341/y1PF/XOlvBa
         i9cFDEcuyAdLdtNgWM9UYsOSVzSirPmNE+TD+9XFCPZWcJDYKLUxyfa4g3S8wM+4DkCL
         4wqqxfLDJQjz4azDexzSWMHTPVVK3Idmy2t5FBxJcvHuBlr6x1YxOoX1MJsur0hQAL/w
         wye5++6b9/s3B6XVjX7e5TLtQS3HPH99Z0tidJoLoNyO3cMgafcE5N6ArRGj/jZN1SlW
         6zGpAfB74oo4nr8QEoc/4z6jK4p3UU4BuBajrI8qQCVKVAVvr5Mt/r8yMq0d5NhrAHUg
         Tylw==
X-Gm-Message-State: AOJu0Yys8XXyi0UcMjczkGE8UZRDeN7ZDVcYSPpyfzqJ1DXieo0tRhZ+
	nfGcWn5IQVxlYu/olqlh2CfZsfGQI5ReFBaiHQEFcbujHboQBFAiISbHWCqjpmo9LrEbRjFoMGJ
	5fQHVm13CYb1aZ8SdE68yZT+uvSzSr7lrJIkaoUIfvXcl64UE5aNAgg==
X-Received: by 2002:a17:906:1110:b0:a6f:33d6:2d49 with SMTP id a640c23a62f3a-a6fab778cd0mr300636066b.52.1718878080504;
        Thu, 20 Jun 2024 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3e8fcFZAghGeQWHpopPDQVv6dADSyyjOPeZThEN3Lgab4EApEF461j8jahg4x6lDxY+2dhg==
X-Received: by 2002:a17:906:1110:b0:a6f:33d6:2d49 with SMTP id a640c23a62f3a-a6fab778cd0mr300627066b.52.1718878078040;
        Thu, 20 Jun 2024 03:07:58 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c86esm749414366b.219.2024.06.20.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:07:57 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:07:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240620060522-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <20240620034602-mutt-send-email-mst@kernel.org>
 <1718876302.539031-8-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718876302.539031-8-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 05:38:22PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 04:32:15 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  
> > > > >  	/* Parameters for control virtqueue, if any */
> > > > >  	if (vi->has_cvq) {
> > > > > -		callbacks[total_vqs - 1] = NULL;
> > > > > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > >  		names[total_vqs - 1] = "control";
> > > > >  	}
> > > > >  
> > > > 
> > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > this will cause irq sharing between VQs which will degrade
> > > > performance significantly.
> > > > 
> > > > So no, you can not just do it unconditionally.
> > > > 
> > > > The correct fix probably requires virtio core/API extensions.
> > > 
> > > If the introduction of cvq irq causes interrupts to become shared, then
> > > ctrlq need to fall back to polling mode and keep the status quo.
> > > 
> > > Thanks.
> > 
> > I don't see that in the code.
> > 
> > I guess we'll need more info in find vqs about what can and what can't share irqs?
> 
> I mean we should add fallback code, for example if allocating interrupt for ctrlq
> fails, we should clear the callback of ctrlq.

I have no idea how you plan to do that. interrupts are allocated in
virtio core, callbacks enabled in drivers.

> > Sharing between ctrl vq and config irq can also be an option.
> > 
> 
> Not sure if this violates the spec. In the spec, used buffer notification and
> configuration change notification are clearly defined - ctrlq is a virtqueue
> and used buffer notification should be used.
> 
> Thanks.

It is up to driver to choose which msix vector will trigger.
Nothing says same vector can't be reused.
Whether devices made assumptions based on current driver
behaviour is another matter.


> > 
> > 
> > 
> > > > 
> > > > -- 
> > > > MST
> > > > 
> > 
> > 


