Return-Path: <netdev+bounces-76532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E026486E0B5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C1B2830E3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F26D1B4;
	Fri,  1 Mar 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF12nm7S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E020315
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293996; cv=none; b=rr4XsJO1N11CflzzOvuP3kRZsvV2b5n0tQtv8C6DMf4GMCCZmqyZzK6JDvsWDrWmNNYGynbMDMpxkh/eQO1Ta1ZFL/tHobgh8a3JXnAimRCxPoR9b6PJU/0YQ+Ynec/NPcMCQUd1tZZkveM8j2cLF/Yr1Qjw5XHBpDFexxEQTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293996; c=relaxed/simple;
	bh=WpidZeAtZ+YgQaVLdxWuklMA1DRtSXB3dUMvzxcxpvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTl0ONMXUzDPZ65pgRcuJXSWHzBzm1azA/KMytDpyQOV0x/iQV84mbigIboJYeKAeFeSaQA82utkT+ZvaoHsDWAZ4+xNRkgaXmhzDbJURDkIgji+fXthV9/7Ywb66ynalkZdT0ywyn4i9L5bqeIei8YFTLmmmeY3ZBPAcJSjeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF12nm7S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
	b=QF12nm7S/cKwqW20/nXJE60YJXzcXAAho4dTRwOaN7KZfLwYh0rtusqAnwZENQ8B1Wkl95
	pR6KqGSt9e/tAW4E4SoH3orJNkLnyqtcJtSnscyPIQoBTab6LA0TtXwd9lhMm7ci273uuS
	d+mrVg3c8pgBozX1PeWKvA/lRkoN88Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-mTj14_O-NAOCNg3mqUzQrA-1; Fri, 01 Mar 2024 06:53:11 -0500
X-MC-Unique: mTj14_O-NAOCNg3mqUzQrA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso2169189a12.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 03:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293991; x=1709898791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
        b=wMnIF0GG4qQ4A1e15/KQsjQ808NhLpNxjo/ATExf4/22BYEYUCA7MrjlPIY0tTsKTV
         ELqWZF2Dvs2qHCikBihOPZu+hhN9AMEMbskm8qC+kNk0U8LHR8/vyUi9wej/ysOs1NtL
         EzdDhyK+PFCgSjC1GnX8e373Br+siM0w/nwG6EDQ4lJu6hfo2PBt1JoMvRYLKh+hfS3k
         jFo4TkftHInYHor+YNHy+O3PynjKY1BlJZhEFDFRw7UG3eavi3rHw4028S3kKmfUvJ6+
         4gB5TySXtrvn4OWSW+4VrvbN3Utw4K7H16ldLC7QC34janxy/qZTtbM0gEKTELwfzv+a
         Y1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa70vfW4uns/6dEc3GecLI6ahgJcDYpoBMZBVvN23jeOC7JBBg+4HCXnyAZANq14lunAVGsqLXlw1lkI0PrMEA0qIwGVpp
X-Gm-Message-State: AOJu0YzRLPQTE9zo+XlPOH9v3ZTW7dAkGaoQuNIPBM58Vgu2Y39GP1c9
	M4ymIaaKDX0jrd4frYI6slkexzl4ukIndL90WiNJDSpCvbuWulZQ++ypmIO/vCOtvDIlKnhBSTx
	8VRwHtJ8mK+Gdc0Z8CHBJfD9G53jqJ3pcaAm5+TOJPPsJJ4QLblbd9w==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225110edb.17.1709293990834;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1vmpvGelrIAwSR9YtmqYMH53YWKi9ocFIRHHKWtTOAKDOP50IotWgGwt5cBRTSNWEE/hvcg==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225097edb.17.1709293990541;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402001200b00566d43ed4dasm439183edu.68.2024.03.01.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:53:09 -0800 (PST)
Date: Fri, 1 Mar 2024 06:53:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	xudingke <xudingke@huawei.com>, "liwei (DT)" <liwei395@huawei.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240301065141-mutt-send-email-mst@kernel.org>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223aeca6435342ec8a4d57c959c23303@huawei.com>

On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > -----Original Message-----
> > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > Sent: Thursday, February 29, 2024 7:13 PM
> > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > bjorn@kernel.org; magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
> > 
> > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > >  	}
> > >  }
> > >
> > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > +	struct xsk_buff_pool *pool;
> > > +	u32 i, batch, budget;
> > > +	void *frame;
> > > +
> > > +	if (!ptr_ring_empty(&tfile->tx_ring))
> > > +		return;
> > > +
> > > +	spin_lock(&tfile->pool_lock);
> > > +	pool = tfile->xsk_pool;
> > > +	if (!pool) {
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	if (tfile->nb_descs) {
> > > +		xsk_tx_completed(pool, tfile->nb_descs);
> > > +		if (xsk_uses_need_wakeup(pool))
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +	}
> > > +
> > > +	spin_lock(&tfile->tx_ring.producer_lock);
> > > +	budget = min_t(u32, tfile->tx_ring.size, TUN_XDP_BATCH);
> > > +
> > > +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> > > +	if (!batch) {
> > 
> > This branch looks like an unneeded "optimization". The generic loop below
> > should have the same effect with no measurable perf delta - and smaller code.
> > Just remove this.
> > 
> > > +		tfile->nb_descs = 0;
> > > +		spin_unlock(&tfile->tx_ring.producer_lock);
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	tfile->nb_descs = batch;
> > > +	for (i = 0; i < batch; i++) {
> > > +		/* Encode the XDP DESC flag into lowest bit for consumer to differ
> > > +		 * XDP desc from XDP buffer and sk_buff.
> > > +		 */
> > > +		frame = tun_xdp_desc_to_ptr(&pool->tx_descs[i]);
> > > +		/* The budget must be less than or equal to tx_ring.size,
> > > +		 * so enqueuing will not fail.
> > > +		 */
> > > +		__ptr_ring_produce(&tfile->tx_ring, frame);
> > > +	}
> > > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > > +	spin_unlock(&tfile->pool_lock);
> > 
> > More related to the general design: it looks wrong. What if
> > get_rx_bufs() will fail (ENOBUF) after successful peeking? With no more
> > incoming packets, later peek will return 0 and it looks like that the
> > half-processed packets will stay in the ring forever???
> > 
> > I think the 'ring produce' part should be moved into tun_do_read().
> 
> Currently, the vhost-net obtains a batch descriptors/sk_buffs from the
> ptr_ring and enqueue the batch descriptors/sk_buffs to the virtqueue'queue,
> and then consumes the descriptors/sk_buffs from the virtqueue'queue in
> sequence. As a result, TUN does not know whether the batch descriptors have
> been used up, and thus does not know when to return the batch descriptors.
> 
> So, I think it's reasonable that when vhost-net checks ptr_ring is empty,
> it calls peek_len to get new xsk's descs and return the descriptors.
> 
> Thanks

What you need to think about is that if you peek, another call
in parallel can get the same value at the same time.


> > 
> > Cheers,
> > 
> > Paolo
> 


