Return-Path: <netdev+bounces-226292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81317B9EFF9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9AA4E2B84
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB720CCCA;
	Thu, 25 Sep 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPMuqA5X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFA25B67D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800991; cv=none; b=rHhfP/BVCb/sLJD9QNqeENqurglZViq/ssrF5tA1o5SxZ/Q5dZAlXt+xBM5+n2Unkm5/Tb/nlvme+yyX9dAbQy4yXHDI9lXz5wsi9rD0p+qz+0q9Xyt5NcpxtTan1NKeYgR4lsVpNTgKO25JX1xz+KbE73QU9KZkWwkEsNDufdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800991; c=relaxed/simple;
	bh=t0e0Wy9HiD96QW6i2mmx1lwB0XsE2scmYpVQv+XaRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/5fL576zBM/kh8yZYqp1UV491siX1BshmY5QHPQrUQ7brW+v6tIfi0RbXLZpf5Sfu/MG2YXuLFjvy57789y2pYNISm/UTbZfO36Fu7BvxeEx5UpPcRYoxv/n/kn+SMvyMiStn+GIDHGYdyHhLXI388cGaE8XyPH7uAreU6kZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPMuqA5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758800988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+KVPxjCMCSupXy09kWALvkdL9X3jhSe67fQlVKrtFiE=;
	b=PPMuqA5X0Wcw1QxpvWtAcHBrNCag0aCKOOb7iWC5QYzMrUX4KKNPLRJuNlTg4YqLorIqBu
	wZP4YI6FB5ckYAbn/gr+CQcTKZhH/JkZo10ElUNDDI2bPgkOLMgPlAEagYUmBzvy/SwItF
	Gw5138gYA4Jz38jdGrYxrj14/tSqe1c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ejHZcBBgNjmGvWouO9MQ1w-1; Thu, 25 Sep 2025 07:49:46 -0400
X-MC-Unique: ejHZcBBgNjmGvWouO9MQ1w-1
X-Mimecast-MFC-AGG-ID: ejHZcBBgNjmGvWouO9MQ1w_1758800985
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so5229035e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 04:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800985; x=1759405785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KVPxjCMCSupXy09kWALvkdL9X3jhSe67fQlVKrtFiE=;
        b=Dem6AuUPC83lDjbFCA+N7QJpDL1j4KcgY2LfhEyJy5PtefBqGJZk5TIalTnbi+8SUh
         VoL3+QRfuboTkfw3gYzLKVvaVwFSv3pAcMHNvtocSmetZrkf7uqt2MVzF1tipxPOq6L5
         KwWCgihWRss41AkkyK2eqojp5qXGh4LYParPnnD4tMAQXcU86pfabYI0ucLHNPAZPrvM
         +3o653/LAb2hUY8bqW7MFVAgtU4Q2i8gQsmFaLldPHnLrlXCMEr8DKNnFjirCIkMAzCV
         JNVk7wz6pShbgKhd8mObVWdC48mRfr3GccgoVx992aZjGED+QR6gUU8lnivQrV+WHnOe
         DZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMMPrtNGzurxZWpRN7Gs4ghDXRYvl0nev57f41c88mOa74R4FPInkVxURwNiajsWZTUPXICDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDfildBINfndkAR7lslxkMogmfUQubYaJzSqMyiwBTk50OLD7
	PArO+XIwnwtFpt01EcYdPr/WJeK9Ntm+s5o9WWdtV+9xEH2aoZN7f8QsMVhkWorGx6g6nSLc5X1
	pOBQFMZXa6Ke7A6wk7TVAaxquNk8IMGb9cJJpqa02YcxebfBYoZSwPPDE/Q==
X-Gm-Gg: ASbGncutVpagDa0YXhbFfetHBg82ZwMfXYWWDnXteZ9f/19YNZIN5VG8jR3B7uxbzfH
	/I68gC7fbnMvNxCrblXHOYLf6wQas7bcmD4Rtpg4m/FscfnRa5LagMLSF5r3g3HRH9i7uY9BKSR
	S/4ZKFzG2wUhJfeLTxl0GNL3N67lY2LfSMb5pz02b85RsMyeqCtwU+mXfv8Majw4vwZx+P9QqyC
	w43afr+pdEwd7AVEfHixFCyTDIcbRTm3y9z4cuS65+S27EFVGWJgBGKOji+OxKtm0STWaDx6IWY
	aFhtHfJem78987Cr2f0KOqKPwGt7Z2BcqA==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr21722965e9.15.1758800984854;
        Thu, 25 Sep 2025 04:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkMk4Mj0ELsCsrAjcuQkpsgbxny3/tEAQCMvsxl7J67IGzgbX3TMTdlCtiY5/jDU50JELDA==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr21722805e9.15.1758800984415;
        Thu, 25 Sep 2025 04:49:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb74e46bcsm2758466f8f.8.2025.09.25.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:49:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:49:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925074814-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>

On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
> 
> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> > > Function pointers are there for multiple transports to implement their own
> > > implementation.
> > My understanding is that you want to use flow control admin commands
> > in virtio net, without making it depend on virtio pci.
> No flow control in vnet.
> > This why the callbacks are here. Is that right?
> 
> No. callbacks are there so that transport agnostic layer can invoke it,
> which is drivers/virtio/virtio.c.
> 
> And transport specific code stays in transport layer, which is presently
> following config_ops design.
> 
> > 
> > That is fair enough, but it looks like every new command then
> > needs a lot of boilerplate code with a callback a wrapper and
> > a transport implementation.
> 
> Not really. I dont see any callbacks or wrapper in current proposed patches.
> 
> All it has is transport specific implementation of admin commands.
> 
> > 
> > 
> > Why not just put all this code in virtio core? It looks like the
> > transport just needs to expose an API to find the admin vq.
> 
> Can you please be specific of which line in the current code can be moved to
> virtio core?
> 
> When the spec was drafted, _one_ was thinking of admin command transport
> over non admin vq also.
> 
> So current implementation of letting transport decide on how to transport a
> command seems right to me.
> 
> But sure, if you can pin point the lines of code that can be shifted to
> generic layer, that would be good.

I imagine a get_admin_vq operation in config_ops. The rest of the
code seems to be transport independent and could be part of
the core. WDYT?

-- 
MST


