Return-Path: <netdev+bounces-246464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E7CEC8AD
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 21:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191F3300DA46
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD330E85E;
	Wed, 31 Dec 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhdCmos3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pvP0z3pG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3230E848
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214118; cv=none; b=H8vNM1L6AhWczYJtEJBwr2voE9TRR+qDG8wrtNaaJayJBVsf+LMcIyn6xi6phsZo2cOcO9apZrNr4An8rV2mu6DI42xKOr6aVqoClTKto4hzM7SKF76l+ruMskPfH8XCy2JGvHxl+JjOnk7QUpT9u6kTAu0P1jBYMGFfjyE+4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214118; c=relaxed/simple;
	bh=BpH6W25VRu697Yn7DFwf7krulZ0ceVuuDV1JpnQSClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMQK9ROXTd75IT5xOYfukAU8d/zqYjdk/9hHbkOmFLN24ZKM3z8AQ5uHEFVOLJW1Ek9SAq9LyL+xo/t+Ef01ZzgqbRkg6VJ7z0mNzZex3na5yqaViVzd83DIZiQQXzdUHQYUdRNvFtCp95vap+R2Jb7OpeOLWzDe/a6ZLAmWyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhdCmos3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pvP0z3pG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767214115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
	b=RhdCmos3H+0DCCh5q5Xk4htwtWcJvQKikAfN0wIKQxxo1lqWjpOM0jG5UajfGJKLPt6opS
	knRspuTgiRQKzjg9vhNo/thcZ6JbVds6dlAwsZ4HyrnJZX695UPd0/XPb3KvraX/WKU2jI
	DaDq9x4czs3y0ANHQOeivAF1CpVlIXY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-uD-UPkV7OH-GWeuRP6zLhQ-1; Wed, 31 Dec 2025 15:48:33 -0500
X-MC-Unique: uD-UPkV7OH-GWeuRP6zLhQ-1
X-Mimecast-MFC-AGG-ID: uD-UPkV7OH-GWeuRP6zLhQ_1767214112
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d4029340aso54937745e9.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 12:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767214112; x=1767818912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
        b=pvP0z3pG4NqUkDHEluND0t26A7txfqzDiv+38R+RThoSWb5dEsO1hy7Cc4yqorCchh
         gik/JRZenBBZc51cql+BtTqJJ63YhG+FLqOw9wpzLarl/BMIS0RnUe/QPBsvoap2cNeP
         FPw9Um2+unbT1MD29TdHNIN5x6W6gv1CorNe9QPA67D0EGBlz4F2Pg+xnhbBbVQOPknf
         JfYCugGl1w2hambIeB0Hr1bPNMdkSO822uk37H8IbRyOPNuPt4eIr1xt94kQ5rA6TcXZ
         m2ERDOWtf+wCEVR++av9x3FewQECEcUv6ApsMPpFpR6DmoQcUZXLYWIoCdEXXmjyyXhP
         SN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767214112; x=1767818912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
        b=cAQwV3On3yOE7Cc/z5lO9VCO7k9noKahYz5VBTptsKElZpn82EDADKNEbW3IO+LGNp
         A8WXtZX6+/ldLkXfc1aTRzOFd35geM8yvmNDVOat46ZS/oKNwWBrknniAz2btPVylmdx
         ZGgdgdSsF98mG/OuqyW0t6jzFSccFhCeFHat6387oVdh5X3nk1NTduDA6azQkdQQRFoo
         9r+HE8ktlxU79FAZMFrNKJCvk0dRGiabtPJZf+O9YYM51l5M2f1nFi7GiaDNDdMtd4XJ
         Bfe4TCpNVRcHkX2Kphe2+epqItswAfpGAhbZbNnAqZ3bhOWOJVTwteSJLdGEP7MAh07k
         oG6g==
X-Forwarded-Encrypted: i=1; AJvYcCXl3Ydbx1jr/5FTUKp3ht1AH0dB74N4LuYnUPZsLj9+YRmlRGzdFFx4+LuBs8SOV2vLmVB2VGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrv6phVuk1hkYqjjbsWgplBBvIp9S2fgLroat9a6HPKO8DIAml
	D0ASr+Q8Rvtad1lv3J9xlV3FBB5G8fAWZyMocTr59tC/bzu1Vg7q9UirSkjJ4Jvg3VhLqQTxznc
	kzY2HRJpfk/4SF25YVzGTpELqBgd6WHUVk3+IdfdnldL1QleDcOv363fzUA==
X-Gm-Gg: AY/fxX6bqSGPSponEazcNK4JSqeJN0F6OV28+tx4UXsaU8iNYEA/TeisrKxs52M8JFx
	oLBvy31BA3qsLQ5wa+dt32WXfac8BrIW5Kf6r4UTmeK4o6zhFrZKCJUkF0zellYal5UldaL8GZv
	TEIVj+9KAo5YIWQjxoQNIWzhUbruOHygb0jWLqnWgHNWZF5L+sDo8NQsd+dNQ/0tXq4kSjb8DDU
	IgxhZnNmDBcwcp0fSkOSnXEGdl5L0d5KGMpYosWZRQckDRsIi5PZcmKY8OmF6Nb/xr/8P/OQlSk
	FpeIyicvMnijjSMfkjbgtT+tDIMv2k1bHfEsUylNUmRuCvOxGxKYl57S9FJQiHGblbHZs39rBVe
	rvFzLjeURyjKt7s+Elbf4hI2OLzu3M1uT+A==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890955e9.5.1767214111822;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUX2S3Ts6MrXbJAEZ1+1hODDbGMnh81w30kfQclg714E6BWRq3zDXGinSJodthec3i9GHMDw==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890515e9.5.1767214111286;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm662070775e9.6.2025.12.31.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:48:30 -0800 (PST)
Date: Wed, 31 Dec 2025 15:48:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
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
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231154722-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
 <20251231150159.1779b585@mordecai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231150159.1779b585@mordecai>

On Wed, Dec 31, 2025 at 03:01:59PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:46 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > When a structure contains a buffer that DMA writes to alongside fields
> > that the CPU writes to, cache line sharing between the DMA buffer and
> > CPU-written fields can cause data corruption on non-cache-coherent
> > platforms.
> > 
> > Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> > annotations to ensure proper alignment to prevent this:
> > 
> > struct my_device {
> > 	spinlock_t lock1;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > 	__dma_from_device_aligned_end spinlock_t lock2;
> > };
> > 
> > When the DMA buffer is the last field in the structure, just
> > __dma_from_device_aligned_begin is enough - the compiler's struct
> > padding protects the tail:
> > 
> > struct my_device {
> > 	spinlock_t lock;
> > 	struct mutex mlock;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > };
> 
> This works, but it's a bit hard to read. Can we reuse the
> __cacheline_group_{begin, end}() macros from <linux/cache.h>?
> Something like this:
> 
> #define __dma_from_device_group_begin(GROUP)			\
> 	__cacheline_group_begin(GROUP)				\
> 	____dma_from_device_aligned
> #define __dma_from_device_group_end(GROUP)			\
> 	__cacheline_group_end(GROUP)				\
> 	____dma_from_device_aligned
> 
> And used like this (the "rxbuf" group id was chosen arbitrarily):
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin(rxbuf);
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end(rxbuf);
> 	spinlock_t lock2;
> };
> 
> Petr T

Made this change, and pushed out to my tree.

I'll post the new version in a couple of days, if no other issues
surface.




> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/dma-mapping.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index aa36a0d1d9df..47b7de3786a1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
> >  }
> >  #endif
> >  
> > +#ifdef ARCH_HAS_DMA_MINALIGN
> > +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> > +#else
> > +#define ____dma_from_device_aligned
> > +#endif
> > +/* Apply to the 1st field of the DMA buffer */
> > +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> > +/* Apply to the 1st field beyond the DMA buffer */
> > +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> > +
> >  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp)
> >  {


