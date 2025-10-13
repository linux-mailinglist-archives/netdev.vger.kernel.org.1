Return-Path: <netdev+bounces-228696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB8BD2625
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5561883CD3
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35A2FD7D2;
	Mon, 13 Oct 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6oSAc2u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0124469B
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349177; cv=none; b=m/0eFHJugC/YdiD0QYnZZtGZ+hvOLVaK9o9Y3lHuUo90HeSWp5LfxapIMJ+R/FZTBeGIXAsw2/ZStK3xqGl66SSLi7MeY+hdsCXUwLxtYZWcCueQGvFF6UAIrzjJKaR2Tojeyx0+G/D9FddD348rNxJZyKaQ6a2BjETtvEffakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349177; c=relaxed/simple;
	bh=Cv2pxU9WsCUo3pBsuAkVnFh3X1Cxe7DJidXgAYF03Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcu33O5eN6N3wbIuoqlbado4aV/vp6vrQ41ZLYTsr+QeTQ5IDLmCV2nqZfDGs9ieMtAWyp7iNJszTVXkzdW5FUnZDAo75VR9zcBrMN9Rb5pf3fj6OxGUbLOMQmQDjG0a2HEpoXXSdnk8ciOwvN2jyjZUXQPj+BKHK3IsR2N3QE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6oSAc2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760349174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
	b=N6oSAc2uct0bzdVoCIZc39peopA0MOdQEAeZ72eyOzOs2b8ZwTOfJ4RowXhRKakX/V5niH
	ASWMcq0wnPXbUaZUJKe0Ohp8B7zKvnnFVoTbVNT9B71x+Jrkqc4FIIQFY2YLW/G+n9ps83
	hDrkoh0hl5CBm+FMvmNqVfhqJqQrEvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-4rT657DIP7ikzn6VZR6d-Q-1; Mon, 13 Oct 2025 05:52:53 -0400
X-MC-Unique: 4rT657DIP7ikzn6VZR6d-Q-1
X-Mimecast-MFC-AGG-ID: 4rT657DIP7ikzn6VZR6d-Q_1760349172
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42421b15185so2955895f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349172; x=1760953972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
        b=umu/bR0L+NAerayxcfShnUtt6+V1aM0g4adzmiNaISFQZ66LyEkFL8R/8qlXGBWoq8
         5ND1S6N9SGb7zHz4sTAHx2j7z8AD3wV5EY9yE+UOG2rfYBoXHyY5tMkE8J4uXlt16bX0
         O7x4iklEj8hl06LtV2HZaZti2TOU28iZKwY/OgEbf/Adino+cVMVcDJOrIO90LPNesc6
         6tzXaaS0a0piw8G+GA0/f6DJ8JpobSVJIZsmTYkq8fcJcU60PA+RNOdBPwo8ghetmpIz
         BSkYt8aww7X5zZ4iWynELnUSH74ud5ZEvjVyoms1MaFq47BYBfvgktxukZC3/uuB6H4m
         EEjA==
X-Forwarded-Encrypted: i=1; AJvYcCW/tArye0vaM/KkDR30UrjG4RrC51FQt1HxpsLFTVzdPv22kDRJP6tJspEsARFOndAS9PQCk+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2T3jVdAPGSDi9jN90FHIKkCjhUimq7ksePr/OPltnpmwFjUOH
	5Cmd9Q+6tFnOqqsbl2R+MdZn+Gy3310BvGEEr/+5JZa2d+Lw33GY9ArwgRJA9qB7j+NaPMefARL
	1Kg9V7yA9A9lxaeQP0PAIz44Cczacs/Ekxzt9KEo/RwwXni7dYlIHChxAmA==
X-Gm-Gg: ASbGncvIu/60Zfj03oobsSWy0KBQF3ehtJPriE/U3l2gvpRQVf5Z6ZM7PzLiinHX3qk
	fCKXgfqI/9DqJdlTZ/dLKln0j0rG8J0MnTnykw8SdR/BWkgjR1dfRhr6iMI4SnHWC67qRkJ6aVk
	2BqZHhSkfm1dHn/N+da7PH/2z99+/JJOsE3FSeoN+Krm0iYx3hUq9h979AhGN7CwP268R4CuuLj
	lH78PiwKJc+VCOzOab0ve23pDI7FJet+3FwnH0ax0tq96Dr8kZbwvJsxsbl8XdClg61z7ISLIjI
	IhAUJ9ZlEVfJv+5ovUVkxk5yIrEC6UO8PQ==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973497f8f.18.1760349171972;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFToPVmudWTFsq6bFqEIEPs/FQujXTZ0U+mV3FlG97R8DNDTM+O9fu/M5ZF2UtsJ7uQAo9BZQ==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973477f8f.18.1760349171548;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf790sm16929272f8f.28.2025.10.13.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:52:49 +0200
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
Message-ID: <aOzL8f4C27z361P2@fedora>
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

Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
IIUC, using __counted_by() would not end up saving space but adding an
extra check for the compiler. Am I right? In that case, can't I just use
a fixed array of VIRTIO_CAN_MAX_DLEN bytes?

Thanks, Matias.


