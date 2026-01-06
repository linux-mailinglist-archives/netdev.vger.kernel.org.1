Return-Path: <netdev+bounces-247371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F1CF8F06
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3879F3060EF0
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73AF333434;
	Tue,  6 Jan 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVNXdlRH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoAHoHrm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D28330B18
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711015; cv=none; b=nKk0hMBTQF0otVQyAu60hvXp90OeqOU3MFev0C8IV2/rJIljh89ifb0LZ98nSC2qqaEjgUM7ZOjY4SXI/UhbkhoNXhzcRYRDQO2bUTyLmx2c91VfoafcHxTiQpvD6XZFkW22VP03sWobbJv+nXywFRDC1j0FZtAi1CDWkJjQcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711015; c=relaxed/simple;
	bh=RqfJjI32FdZ7MpeaFMqvXp4bO7LyOB4RofYVb7BWxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxH+oCVbesgIJlYeE2mlpnstYvfmGtLN3tfVrorq+oVuimT8rtP0wTXJ955C0zhHXDYKSedd2mJyXqsOFrowOzDKG8H/I3v3ZN4hym8lWrDr80E7Aii0EXMK71RbUACRwtdUsCuYZTO+QBD8g9fGBF/H2wF5kWayH9iFpSn9Fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVNXdlRH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoAHoHrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767711010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
	b=UVNXdlRHuKXdR4/EdcsXd6W7F4xoryw/rYoU1bQ1ijpLzKrlLnT5LgvfbHyNhkMhiLpQgr
	dlK0AoqiBt7bJQD1RnLflMXscmYi77HppNMo0oBAihDa7Z6L3hQDw1tUCYa3VAT7+MsL7G
	pzK8XpoALM0VNilGDGD/eIlNf2ILifQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-WVVz0YCyO2qcFAlhuO1S4Q-1; Tue, 06 Jan 2026 09:50:06 -0500
X-MC-Unique: WVVz0YCyO2qcFAlhuO1S4Q-1
X-Mimecast-MFC-AGG-ID: WVVz0YCyO2qcFAlhuO1S4Q_1767711006
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so9130665e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 06:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767711005; x=1768315805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
        b=aoAHoHrmwMZxBs2Qp69OPcSFyaa1ig8teHOPJlTckRJ36lo6MAUEbtcC31JPG6FdXt
         r8wn0YoUmXby44f4lHbgR1uSQGC250mufP2o8GPX7n8jjsh3a/4d0o7zyVeYiY7or4wP
         5fNAD2ypUG6iOfyMx50WuECY+vE25qV7VYCmDh2JcvSmkuCmk0jV6tgIRzf+JgvRWkZV
         /tyDnQ8+btDHVPo2V53lrmTUi6h1X5KXIFtPigLUhEhrf0OZfRoIPXQSNa8Sq6KPyslf
         ekrDkyLn4FoULpuMDI1pdSm/qjS0v7F1JRtZwgfRIfIsynaHmQ0FNYWqHLh8MavZgcjF
         OJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711005; x=1768315805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
        b=YiEJ6m87dinon+2nJY41LTQjs5e3E+qZeSUaxSblboijP1iD1NqC0Rg7OJZdYKsfBg
         mwM3GZi9zB1Vl1wARmYioEUtCopLDcY2ENQ+wJ/+Fo2r20np/zDArzrX48CLr0/2sQae
         uTUXvvS4zrl/2aEFzcEEPAti3Xt7kBCnYRmWrZzeo6t827/ceavJ7lzY3pUAwNUWQNVW
         3WmX2m0eozOgMMIKOuvZTh6WjVBopE9N8H6eTsBUXInebdAgsDXnkXQRzuKpK5qH0WOJ
         /R56n01Jw+9wnXs4dctUSK5VIQfSlfvuyWKmrhBzGpcOwZXz0V7FKlj6hipFpQ9Bymu3
         +Khw==
X-Forwarded-Encrypted: i=1; AJvYcCWhtXV0S1ggUa8oLbN/M+RoGPeVQAKg/GiCqvj2GuJeh2llzfNfwB1aJFWfK6lCi6D+B+YXa2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eoBqT9tTDIPQNh5VQP8ByCPitJxXZY6BqZTJpi04KMyBsKOB
	XhHM9wLgmB4AXT/67jgfGfDcIlXiOdG7TaGJGQx0Cc2EftCDevBXuEZm/G9oosBFFCgIVqqXl5/
	SL8FoJ8zXo7E7F5JzLH78tX5YSGVpM/JxWIg3cDPhyIft/maT/pkDM+FbyQ==
X-Gm-Gg: AY/fxX6d2/z7WqjVck6exdVYDtFm8YxuqW67KbSl0PbaWke7YTqszRg3UvYFIuAqDio
	A9f3dsVFL1PMtXK6yolth4UHOdlpn8s/kivXiOpAxSgQ9L1X0RnCORVVZ5SKej/89ctI9TGQZRv
	kKSVYHwpRH0s/GRKKWyORO45bgdMcLQhAT0LvWs15xR+AN76R/Oj2PLCUAIRXmPAbMbun1eJCuZ
	NG4Gmwkf/VGJYRBztDioJA6HO74IxEFQS3/URoVdGw3xkeoFaY1IRom/fQQdKdcWscVKpSowkpz
	HjAYxdMlkk7zTUnopk3/EOsAHE2yFu+Gta386tRZpkzi0VqzKR93vq/VsRP0CmbiQUx+MOEqC/8
	EyLlRkoWsrbo7MIj6XgwBQ9/ArVSx0g/niA==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820745e9.23.1767711005514;
        Tue, 06 Jan 2026 06:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXHeGoEH1PxicAu3pvp2IKmLzneQBM5bSFfOKMFfLat4mQRdOWLJ6nIuVR4bStC0oG3LJdHw==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820345e9.23.1767711004990;
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm48129575e9.6.2026.01.06.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Date: Tue, 6 Jan 2026 09:50:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <20260106094824-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
 <20260105181939.GA59391@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105181939.GA59391@fedora>

On Mon, Jan 05, 2026 at 01:19:39PM -0500, Stefan Hajnoczi wrote:
> On Mon, Jan 05, 2026 at 03:23:29AM -0500, Michael S. Tsirkin wrote:
> > @@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
> >  
> >  struct virtio_scsi_event_node {
> >  	struct virtio_scsi *vscsi;
> > -	struct virtio_scsi_event event;
> > +	struct virtio_scsi_event *event;
> >  	struct work_struct work;
> >  };
> >  
> > @@ -89,6 +90,11 @@ struct virtio_scsi {
> >  
> >  	struct virtio_scsi_vq ctrl_vq;
> >  	struct virtio_scsi_vq event_vq;
> > +
> > +	__dma_from_device_group_begin();
> > +	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
> > +	__dma_from_device_group_end();
> 
> If the device emits two events in rapid succession, could the CPU see
> stale data for the second event because it already holds the cache line
> for reading the first event?

No because virtio does unmap and syncs the cache line.

In other words, CPU reads cause no issues.

The issues are exclusively around CPU writes dirtying the
cache and writeback overwriting DMA data.

> In other words, it's not obvious to me that the DMA warnings are indeed
> spurious and should be silenced here.
> 
> It seems safer and simpler to align and pad the struct virtio_scsi_event
> field in struct virtio_scsi_event_node rather than packing these structs
> into a single array here they might share cache lines.
> 
> Stefan



