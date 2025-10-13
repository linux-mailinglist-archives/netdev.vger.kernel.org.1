Return-Path: <netdev+bounces-228739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4EDBD37E3
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 107F7349E3C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0C3090D9;
	Mon, 13 Oct 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxvJ9B5+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B23308F2E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364948; cv=none; b=a8G7jfm/iyfJnTbqn9QZ43kBl4iCG9m6/z2ghaGQn+MGRrC1GXGwuTp0JhaSEZ6KZLoAudOK1NUXQeQy3xdSNK6/z9esWAwH95BvZEti7kp/II4qj9Ifa1Ekn3nwgMLvxgjomWCYn5PnhLndolvcA2LVCDWDt4HMyu8nBBGSTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364948; c=relaxed/simple;
	bh=X6/q1bHsLK+ZhgGEzfdnTYkllaQ39VA9H94eFOB9hyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep8/iGJVckgOaqSAa704p/NKaQsPkU6NQOOlO1cqci9diYNf2ITSACUvqEKbGDe5VX2rw9gbjr44IsOoanrtr/Op8d4LoNZsH4ZeW0j8wRsIRNEdZSVBM4oWeuAf96CZQ4EYnJJLYBkHI0U5aQjh+d5yinbYixAQfTNEf/8ob44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxvJ9B5+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760364945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
	b=OxvJ9B5+Ov0+JYuUbY/CpHKdEMN8k9UsUM/YcDt+ySUsd//bH/N+I23vdQmxQPitI2GkdM
	6rLS0m44nKF2PFpiHdY9wM8mXdrCEqqpTgZCrq+m0igJmHAkn94ZIOATPfRn8Z+HdV9pBU
	QBvUt5nU8mDSsb6+enDMKP2R6ktuFeY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-C4xh4F-QMm-CDU2SV2wIIQ-1; Mon, 13 Oct 2025 10:15:44 -0400
X-MC-Unique: C4xh4F-QMm-CDU2SV2wIIQ-1
X-Mimecast-MFC-AGG-ID: C4xh4F-QMm-CDU2SV2wIIQ_1760364943
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso39068105e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364943; x=1760969743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
        b=AzZKx7QOlF3OJT7Bd2pzVuOMYjxqaCnl2/5aAFgyZNCjAAFI9FIXmBYhTPzZaPZ4pu
         tcvRft3D9cNBX+8sbKAPFO6xzsPOS7siU86cbUX2l/T//hTtcbVjTDtxBw33VuaRSzot
         hdb2BltZxb6V7gpc1dr75Y1Y26P5gfDkJ9rGwA9bbzdbBt3BAb0XXEUmf9fvqjC5rA+c
         s69OB5e6Jtccyfn0kJXdWUVcMkn86NQgbEA9G/67C5qrUNrgqxDGZHVSUdNyZLFoLeAZ
         Qd94B9g6NWZ44AFUmMWtAaM9AJXmfJTJxmYsCH4UuAVHDK54zlYDnDsEXaaioPYWyaPz
         PzEw==
X-Forwarded-Encrypted: i=1; AJvYcCUIC3fRsHgJ+vayoKBWkDei9tSZmC+ukz7FL89EXuam/IBeAJaKzHWujjV8OtP986Fp0FaJDRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWDnipF2KGG6iDL+Evp0feaDmI8kw82jbzcHACfkk4wGiF7B2
	3Y/BRqpzCR8K0xs3eZLIraS0i5K+mSzL8xQLHg8jY5zKYh0WqqdJK249QJuNuoh4u5IePQvZG6n
	BJpDTaUCZqLB70YgYoqauX///rtsZ4vP7yuBiqcGWf79BRI8vK64UA8z6yw==
X-Gm-Gg: ASbGncuMFaAjmQ17gq4IxRZ/fds8qpyu7YHQhtfsbP7MpclDNeYNbujONGz85nojsP1
	xUSmdHfZCF3sMqK0VPh8yNMVd9f1Jpox3Y0z9w++K/JqwLTx9VZReoJEzAReHju8U/zQnS35It5
	e79yKa+cBr3jXK4MxPp7BTKBPmHmx0hLRNmym0fhdftYI/J66N0OI8Mtnjix2qWYM8Dcvs6y+yL
	JYfmizDCzJ6GSUDsb4tlhvIrHzHu4brjpU00kQfCCUpRxqcktxBw7+uaiVLtvgb9k/Q8YKScIra
	0wsVIMw8DvbVYoMVv+DWdNjUamfldd6uFw==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543335e9.9.1760364942887;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9AfQG1bPxhSVGiAWctJCWR2+PTWw1bYga2tLxdTe6Ieug+DROBY5xi12o8AGOXPV/OiFfQ==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543115e9.9.1760364942471;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3520sm136542145e9.2.2025.10.13.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:15:40 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aO0JjDGk2zLlzB1E@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aOkqUWxiRDlm0Jzi@fedora>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2318164.vFx2qVVIhK@fedora.fritz.box>

On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > 
> > I am working on the v6 by addressing the comments in this thread.
> > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > 
> > > > +
> > > > +/* virtio_can private data structure */
> > > > +struct virtio_can_priv {
> > > > +	struct can_priv can;	/* must be the first member */
> > > > +	/* NAPI for RX messages */
> > > > +	struct napi_struct napi;
> > > > +	/* NAPI for TX messages */
> > > > +	struct napi_struct napi_tx;
> > > > +	/* The network device we're associated with */
> > > > +	struct net_device *dev;
> > > > +	/* The virtio device we're associated with */
> > > > +	struct virtio_device *vdev;
> > > > +	/* The virtqueues */
> > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* I/O callback function pointers for the virtqueues */
> > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* Lock for TX operations */
> > > > +	spinlock_t tx_lock;
> > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > +	struct mutex ctrl_lock;
> > > > +	/* Wait for control queue processing without polling */
> > > > +	struct completion ctrl_done;
> > > > +	/* List of virtio CAN TX message */
> > > > +	struct list_head tx_list;
> > > > +	/* Array of receive queue messages */
> > > > +	struct virtio_can_rx rpkt[128];
> > > 
> > > This array should probably be allocated dynamically at probe - maybe
> > > using a module parameter instead of a hardcoded value as length? 
> > > 
> > 
> > If I allocate this array in probe(), I would not know sdu[] in advance
> > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > defined as flexible array for rx? 
> > 
> > Thanks.
> > 
> 
> One thing that can be done is to define struct virtio_can_rx as:
> 
> struct virtio_can_rx {
> #define VIRTIO_CAN_RX                   0x0101
> 	__le16 msg_type;
> 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> 	__u8 padding;
> 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> 	__le32 flags;
> 	__le32 can_id;
> 	__u8 sdu[] __counted_by(length);
> };
> 
> and then allocate the rpkt[] array using the maximum length for SDU:
> 
> priv->rpkt = kcalloc(num_rx_buffers,
> 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> 		GFP_KERNEL);
> 
> In this way, the size of each member of rpkt[] is known and is thus
> suitable for virtio_can_populate_vqs().
> 
> 

From the spec, VIRTIO_CAN_MAX_DLEN shall be 2048 bytes that corresponds
with CAN-XL frame.

Matias


