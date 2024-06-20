Return-Path: <netdev+bounces-105163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197590FEDC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EBE1F22C7B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C6198836;
	Thu, 20 Jun 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xtxo184g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0903196DA4
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872348; cv=none; b=aceQYbWapYfmt9cnROfcYqhu4yylgGz06s8lM53/FICkemPmGxbMawvy6mn+hasUVMeiCCHGCRdSjO4CH+IuefVhBJ/O4xePMAuHItr1UMiv3raHfsaWIJXjIZDxg4t89DychW1sF19Bs6+BJVVbzQkExjkwxIqRiGzInJAYGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872348; c=relaxed/simple;
	bh=GQNRhUjmNKYB0xE7ASaE6oaKaYPy3J1MSACbDVFZWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLJprtZl33NPVQsVx57wdJ1FtvI58kCe80suZ8w3jduIJw2JQhzrJwaA4X570Y5+94fdmHebMBSkmctNrv0ILH/SyubYgLrVdV1v/GgqCXYi4GnoIsxIDrBRGWrCRlRXybiPMwDkmPmrxsM6lJtSBupcdg8uBCrnsS8yt55Dz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xtxo184g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDDbMoWZfx/vXxAx/4Eg+jzcGaLWU8gh+nxmgU1GRuc=;
	b=Xtxo184g5HqCxPURx4YB6LUufrgmkPtVqfmlCYpIWxoEkapW+q92gyX4CikrONI+7b7pXy
	V9z+kSGG5KAZ0Liarv4P3Fh0anlN0p5RqNXugamLKxaK2bE2vJOn0+oYhbeY+qCUdzkA9x
	LiJwJOJbyLxPdcMA1JezlAjlIENK2O0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-zSekMK-7NYSljzZNKXeOVA-1; Thu, 20 Jun 2024 04:32:23 -0400
X-MC-Unique: zSekMK-7NYSljzZNKXeOVA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fb670da30so23722566b.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872343; x=1719477143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDDbMoWZfx/vXxAx/4Eg+jzcGaLWU8gh+nxmgU1GRuc=;
        b=MtWCI2TlvgiUfBqXz+iG0uDLGsBM8yooo7OB5z2dThAjSVnOP4CzF7aftsdS220qhS
         SG++avduEzlPC7xHgpw11NnMC500kJmSwEhkhjK6aOFDmezTf9ol6wD2Ei1a2lwjzg/s
         hcn0dpF4KqAIVU5l/TleOf20zwbPNUuISncxDC3QC+OM5yN/btW8f0mmCXmku39yBKE3
         Zb9RM2xaecTRGIk7NMTEIgloEUNY8UkccOUbObgpDYA8ou5PVwnNl2q075rCb/v5gu3U
         P2qny8UD4CJDH/D7tPGR00b+uOKpyNgSh4gGph9K9fmCbU8p7+Fymrxr67rTNwy+AOEQ
         xXeA==
X-Gm-Message-State: AOJu0Yw4glzaAHdjEq/v3Pch0A28ak0uUVD7AwT4lK/02+IlzrEK8keh
	J2ieJCifYXHAcBwCppFTOaqnTjOrvAR1hxoGASBejcgDuYZbGT7wyyHMrSVoYkVc1bgPj1EDkzg
	6XP7RBbl27kucpqXhSVbNBvUrDUXHQl5LP5L2PbHckQaDZxKpGuLydg==
X-Received: by 2002:a17:906:2602:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a6fab648b9emr212075166b.40.1718872342620;
        Thu, 20 Jun 2024 01:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmi3doNwpOomaLDgEbZMUZ3ch8SbQR86SfC/uSFp3Z5frtzLHKiBLh4szJKHSYEPJKzsZ6Pw==
X-Received: by 2002:a17:906:2602:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a6fab648b9emr212073866b.40.1718872342152;
        Thu, 20 Jun 2024 01:32:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f988cdsm739390966b.193.2024.06.20.01.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:32:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 04:32:15 -0400
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
Message-ID: <20240620034602-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718868555.2701075-5-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  
> > >  	/* Parameters for control virtqueue, if any */
> > >  	if (vi->has_cvq) {
> > > -		callbacks[total_vqs - 1] = NULL;
> > > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> > >  		names[total_vqs - 1] = "control";
> > >  	}
> > >  
> > 
> > If the # of MSIX vectors is exactly for data path VQs,
> > this will cause irq sharing between VQs which will degrade
> > performance significantly.
> > 
> > So no, you can not just do it unconditionally.
> > 
> > The correct fix probably requires virtio core/API extensions.
> 
> If the introduction of cvq irq causes interrupts to become shared, then
> ctrlq need to fall back to polling mode and keep the status quo.
> 
> Thanks.

I don't see that in the code.

I guess we'll need more info in find vqs about what can and what can't share irqs?
Sharing between ctrl vq and config irq can also be an option.




> > 
> > -- 
> > MST
> > 


