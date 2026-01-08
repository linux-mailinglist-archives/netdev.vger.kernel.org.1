Return-Path: <netdev+bounces-248097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C6D03EE0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 916093039294
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DE3EDAD9;
	Thu,  8 Jan 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC+z1wRw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJtvfR4w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556293D1CDE
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881284; cv=none; b=EeHwE/dFpiDU8MaSzmdVIfNu5BYy9dL8yM35RnPM8qN+uOcNAG+aWTy8hP39rfBz70ziA5zGgO3lYiBAoBacRp2b31q9Js4nh4ktLfjlNAHpE+e6GHcjMYe/EVoK4xl5zMQbgHlRivmr1vHYjuVRZkmeSmCEmuQlbQHx5dPgcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881284; c=relaxed/simple;
	bh=KaqiKIrSwJ+ZnBNZThkRID6OHOTJLOwB/Uij0QQJV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx9U6cABjgwYbZEri1qifMbiC/zhgGq/rZTzz675aJt1+01NAUuv3MeZBKYrbYCMMgt2uvrxDShCNYALxejJrIKI2dty8ae/VUcKQwdcpy7vLwET3tbrsbCdQGdc4MR1E9Ho/eJ2zC2LnppfUNaoSvTsGlU/a+sYNOQCQd6HC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC+z1wRw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJtvfR4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
	b=DC+z1wRwPZkoDB0V0nMq+zA2bs5MIJYw6bINgXSFjswyryJ2mTCrLatbKQcGDywcl4AY4c
	eKHEl1A+UnE4VMdCeTw7WV+p9T6ZhhZ4lswneW3nNG770YRFTVy5tkuXUu05TSgrEMyhMM
	1paeVsIad1KhDgwvR2ZRh4+89SfFcdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Ke0CXGNkNhy5ojEXnr_HeA-1; Thu, 08 Jan 2026 09:07:59 -0500
X-MC-Unique: Ke0CXGNkNhy5ojEXnr_HeA-1
X-Mimecast-MFC-AGG-ID: Ke0CXGNkNhy5ojEXnr_HeA_1767881278
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47a97b719ccso20930555e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767881278; x=1768486078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
        b=JJtvfR4w4xzmRRJLIFv0Z2Ls4vcVnxXpVq0cDbdZAEDqA9oJlAEnLpS47UXoffDo0c
         Tuv0DGAZbIwG4Q/byrvWw+PmIJiLcKMTbHVXMNqjBK5t4WtuO+r4oZCGSHEndY44gNzM
         LTBiVFnmpoU+6OgAJJtOsPePT2Z0d4rB/7WV4BnuctdP/p5VMd2r2fj+ammVO+UiPBQ7
         Y/EO0Z0X5f3aQTbIIcVkWFpIjkd7YLncBknXk9ZOigYHgCE4EPeFa+LV3610GDrg2WNT
         zWrgFo+hzkL7V9NLI13Mi2c2FMPhzKaI48L+00N50mbySmahQoWxvuhO3pE2cNZEAFJ4
         aZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881278; x=1768486078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
        b=KizigmmIvMs2Qa7VWhVpy94TtOOEqe96pCWLWmNOgeWf75yMYPdwFCJX14Qxn7Al4Q
         GVouaOr/4F7GgkPaWRj7H3VmXvOqD9rZxZagBKoarbfgZVGTdCyMkUzsXvjrA3g+XU4r
         WUEQqY+7Jktx33NJr7LtLuqE0c2QB7dUou8RWrudc51jUP8rArP5JzVVInI2oOXHPOOo
         TcObZmEad2qlGS3Sik520hW29bo/f+98jPt9PDP5Mlh/sVaO6Md4S1AaJLhCTdQR0VjW
         Ih3c4Udmb9YnML9roWKa3AK5AOcXFcBEoU3NIxOct8R3kTlCDQW+J8PboxMHu9FRMztt
         stAA==
X-Forwarded-Encrypted: i=1; AJvYcCWjFLD6I4SqjNHYIWWlK9MQyF/6g/73SO4fPsXJln0qKA5Q54GhUOZRvM5Byv6MQMQKgkAQgrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/MjceHSttd+YT84qeEvI1tErh/wxFPj4/jikOJ2sO0U3o0IK
	wWMPfsBzMmYKPDc4/N/oYVJTYmIQUuVn/Zku7LzGhYlP5xojlidWLMG3LoKScCqIuN+EtbpwzS7
	pYZt81S82isXJpDRgyArRz1ACOr4f6YQMj5FxgyyrE3NX/HLW2xEFwY1Nsw==
X-Gm-Gg: AY/fxX6uF7cJOfOGPtFibOIjgtfs39RR0ZFxPccRoXvSqx0w3C/mD/kZliZ1vATTkKR
	p8v0oEEgxsggE7xwrl+PA9gsagu8EQyO2xXkGHRBaGd783tG0DjN/MK4g48gyIVSKtAfz5NsUXL
	5mFqU1/hE8SE8O+5G3CSZltgBSz6SPJ5japiRRCaJ7nn69EzvnFzjBtyygGWbuG0o74vW1vTZ8Q
	pW47XNq1DnxwA1uyUG+XO9K0p8Wnijnuy8PQZ65vujyjIVe2Sby+OKoa+hzqnnWbm/YYg7ZitdZ
	XFxwtYivBJbqKeN0KWKeXyj/qF7hTDgLomClPdVvODx11zKcIuAEXpAfI2gllRLHjqCLKrCG1Yg
	6np7/uHFD5aSNibFfq/Df8aS5YUvbtZR6Rg==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72552975e9.12.1767881277887;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRCfp6entO3V/BR31Far6TJcGMp3EAPQ3dAY6QbDFNrKF2+2e3Jhs1Nmifuq8757Npv4Rh0Q==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72552445e9.12.1767881277386;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm160806445e9.2.2026.01.08.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:07:56 -0800 (PST)
Date: Thu, 8 Jan 2026 09:07:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <20260108090639-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
 <aV-4mPQYn3MUW10A@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-4mPQYn3MUW10A@sgarzare-redhat>

On Thu, Jan 08, 2026 at 03:04:07PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
> > On non-cache-coherent platforms, when a structure contains a buffer
> > used for DMA alongside fields that the CPU writes to, cacheline sharing
> > can cause data corruption.
> > 
> > The event_list array is used for DMA_FROM_DEVICE operations via
> > virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
> > written by the CPU while the buffer is available, so mapped for the
> > device. If these share cachelines with event_list, CPU writes can
> > corrupt DMA data.
> > 
> > Add __dma_from_device_group_begin()/end() annotations to ensure event_list
> > is isolated in its own cachelines.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 8c867023a2e5..bb94baadfd8b 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -17,6 +17,7 @@
> > #include <linux/virtio_ids.h>
> > #include <linux/virtio_config.h>
> > #include <linux/virtio_vsock.h>
> > +#include <linux/dma-mapping.h>
> > #include <net/sock.h>
> > #include <linux/mutex.h>
> > #include <net/af_vsock.h>
> > @@ -59,8 +60,9 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > +	__dma_from_device_group_begin();
> > 	struct virtio_vsock_event event_list[8];
> > -
> > +	__dma_from_device_group_end();
> 
> Can we keep the blank line before `guest_cid` so that the comment before
> this section makes sense? (regarding the lock required to access these
> fields)
> 
> Thanks,
> Stefano

A follow up patch re-introduces it, so I don't think it matters?

> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > -- 
> > MST
> > 


