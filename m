Return-Path: <netdev+bounces-106396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FF916155
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FB1F2158F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E3614A4D9;
	Tue, 25 Jun 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmf94YCq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9914A09C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304320; cv=none; b=bG+yFx8Va6QUYU01R/Xtc5P2jv1c7/DkGiN4jSHoN2EY8DVYaoIrhwoutRY1h9MMVvsFmO4xbL/GfgtGN8gI/c7geA2XAE9yfDkAykmDGSyMlDehRrTkUFAUCKiqgYcn0n0Qfd6MxfPnRls3JiHFWJYse+/Bdk9lpzowjLy5RQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304320; c=relaxed/simple;
	bh=4GQMcGauM1sM2qcIuTQSJ5+jNSGplBUnYe9YXxdjt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naJ0eQe8HbCBnMF2DLXowbmZ/UkxIewwTK2aZH+9l4M0gAEqEfI0Exuf5vbGDWPK4v1daIVXGNfAwtIeXMw8h7psbvEaXoioLyqy8CvDCiumsrtVLTgtx+zHOtsUsL6rlIXW6Yxun+kqrntrXZ2tXf3ewPvA9dZFNFLMMUYVgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmf94YCq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
	b=Nmf94YCq/rqCBhy4y5Jan93rXaw5rjFeNvU2P/xh28FmL3g25JuON6tp8f+Vn/wYu5gchE
	onCEs72Lnjlc8SdhCZiKml3wqOYax7F27ktaKZfGt6KepaOFXNW9HbDxKx4jYuTklDAlZy
	n5sk2bFo3iSiIe1AnmkCOU4WCqX8krQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-6rbVt3tsO16raE46k6D9BA-1; Tue, 25 Jun 2024 04:31:49 -0400
X-MC-Unique: 6rbVt3tsO16raE46k6D9BA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d0f3455ceso954688a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304308; x=1719909108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
        b=a7hBEvTdKy8EcKyItZRH4NphqCaPdbFFQAz1Lw+68GobFJKFYmWUDhNOk7V/SiQzYz
         tRgM5lzMs/IbhuBcGSELS/DNfzYWLpGyjsY4ZkRiIjYhNbYqzMZY55C5f8xivu1ESdXH
         BsN4CbzlSyRq63y4CYLsKWJORCYMGLMpSiDJKURmiiM5TZMpyKytXTFvay+xXWRYKQk1
         PeHxJMEB0xHN70K8mecgYUaXsjwy+00nycytLuPJ7Rilym7B2aalZSXVsa+dBYtsdEOU
         9+bSK+x5gLbT5nOhifyUGkgTxf+L3OKHQYm8jmOe2amBzHQSpUTVGs6yyNXAh8cTs6h9
         2vbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWct2+jnhTl3jHeFQ+yQ0F1VbohnZ8eQx99DD0xiY0qqe1Jk3DnW3fBh/X9oyfh9IXqoJvymDrr58xjwkNv5Two2lLR+LDX
X-Gm-Message-State: AOJu0YzS3MsGvnkunhX+8OsPvsxubWZwu8ZFmziurUZfSld8F4LmXeph
	Vd36brR+6whIVzYs3esvYoDyMGi9qlCFPGqP+1Zo7gWSXw/nM/MHRhHqT07Ml1quuioLOZu2Ol3
	B+nOPj5A2CtxBY3S2wQHiiB+oR3FIRai32A8RAX7oWBOQ5YO8mAF29jC2UMItEA==
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403370a12.15.1719304308211;
        Tue, 25 Jun 2024 01:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxhsR1+izX70xNnvyhK6UwUVonlEeFQMV9kch7eEfTNcHpuqfZ/z/U8gcxRPMmp8lA3q60mQ==
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403333a12.15.1719304307535;
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535232sm5638857a12.72.2024.06.25.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240625043120-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
 <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org>
 <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
 <20240625035746-mutt-send-email-mst@kernel.org>
 <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>

On Tue, Jun 25, 2024 at 04:18:00PM +0800, Jason Wang wrote:
> > > >
> > > >
> > > >
> > > > But in conclusion ;) if you don't like my suggestion do something else
> > > > but make the APIs make sense,
> > >
> > > I don't say I don't like it:)
> > >
> > > Limiting it to virtio-net seems to be the most easy way. And if we
> > > want to do it in the core, I just want to make nesting to be supported
> > > which might not be necessary now.
> >
> > I feel limiting it to a single driver strikes the right balance ATM.
> 
> Just to make sure I understand here, should we go back to v1 or go
> with the config_driver_disabled?
> 
> Thanks


I still like config_driver_disabled.


> >
> > >
> > > > at least do better than +5
> > > > on Rusty's interface design scale.
> > > >
> > > > >
> > >
> > > Thanks
> > >
> > >
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > >               goto out_ida_remove;
> > > > > > >
> > > > > > >       spin_lock_init(&dev->config_lock);
> > > > > > > -     dev->config_enabled = false;
> > > > > > > +     dev->config_enabled = 0;
> > > > > > >       dev->config_change_pending = false;
> > > > > > >
> > > > > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > > index 96fea920873b..4496f9ba5d82 100644
> > > > > > > --- a/include/linux/virtio.h
> > > > > > > +++ b/include/linux/virtio.h
> > > > > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > > > > >  struct virtio_device {
> > > > > > >       int index;
> > > > > > >       bool failed;
> > > > > > > -     bool config_enabled;
> > > > > > > +     int config_enabled;
> > > > > > >       bool config_change_pending;
> > > > > > >       spinlock_t config_lock;
> > > > > > >       spinlock_t vqs_list_lock;
> > > > > > > --
> > > > > > > 2.31.1
> > > > > >
> > > >
> >


