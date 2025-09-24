Return-Path: <netdev+bounces-225809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA862B98957
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F373AEB98
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5E27FD4B;
	Wed, 24 Sep 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvTDVNw8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA927FB32
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699731; cv=none; b=GIzQVULT7shv2zPgSlWgNnMyohbIknYzZ8FEF0Tx/hFZiEaDI26UFc7c7LqU8sLG4ZW8oxxMEbT5Kx/YgxDzg2DwbN9MTHrQWIVtKmTSc2CEc4eI4pbezN33VUQWLOMK/Igt49kYXcRrHwzTMgsQsZEQgbaYYekUw8pl1m7oIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699731; c=relaxed/simple;
	bh=s22C2XkvtqXbgWCggQzklD/42otLP53lpOCy5Alg7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPupipQjjCI3VHsHabR/bvcZLd0u8YgM/1K3XtPkNzdhdMmmv6M0DHAEeogZ7WqpJwE1stj6yEWvFgKTwEbwHN6W0PHqFVo/j50eo1qNW7HoolVYafU+t4xQP0ABvHADw02unFqMzMwivRG69TlebKskw09xzmDeLkjQNUr8i5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvTDVNw8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
	b=fvTDVNw8vSyoIoDvRaIFjotSK95C7nrfiZXAgQQWKj+s42QVKLPL7ejmv1SiI7YC60cjy0
	chFmDu3PdgAlhq/6Evno+/bzEOh5SNHrkmkWzziBrythH34P4Sn82yWLiF8gtGdeGcJNzJ
	T1OF1cRK8MCHknit/fBqGqY5qLJ2AwI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-C3Jb2jmENvCctM0AyiPAMw-1; Wed, 24 Sep 2025 03:42:01 -0400
X-MC-Unique: C3Jb2jmENvCctM0AyiPAMw-1
X-Mimecast-MFC-AGG-ID: C3Jb2jmENvCctM0AyiPAMw_1758699720
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso2508595e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699720; x=1759304520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
        b=X/XJIRGaTyWYMfBg39cfI5gqjnsxC+GUzUusQ+ULtWqQw8UCUN0earQySuqDJQV/Ey
         vVQd4qnSqI4jAMHHIfitHpeEFhtaD+7G3BBdNjiqBwLaau/Azr+pCuoJqPH1+MvdVIpK
         7PAhNeozj06Xp5wJ3WAC5qn4VcDncfkzdMLNESRQ580HkQyaJ6yfx2r+S9DCLlK4Saao
         +2D3wPIJk28ZLs4NW5VK4rnVyI8NE144A4jqq5XUtKE4Lxx6hPnVjHSPiVYK3nn/0Rq5
         4+BRktj9Ld0mawS5UKlX/yk0mCNznauWFDy2CcPAY/qMRgvGrr0ssS4sOZrhxyRXwubv
         jeKg==
X-Forwarded-Encrypted: i=1; AJvYcCXFt8B5D37gukBip67+wLtK3ouN9OZVZlqEzsN89C0UhlVyFf/l0QEb+9ZjyKrV3gIV1TXK1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z35d+808NwuU4IjCQsJaJTwRsLX/2q0rKwIi4xOG8w+kXDTK
	rIsr4ifLfHS+99epB8cszIG6xFAiZlCfwXwTUyo+/7poMfzB6w0+gM/qWm7KivDOOa/OG53j5Ez
	2aL1tHZj6ilncukGXtdmXB0P9tVyxfzxfoXjno6m+O+g+V/69/I0czt9uGA==
X-Gm-Gg: ASbGnct2/GJRzkJ5SDVqsnagnvxBiknV8BvITUBk5PdTHMmjBlMNnEKoRYl5R+Gt1ZF
	B8RI4/6nnM2/ifkmUKUXgTXzPjboC6AlTt9aC+eNcxUfbW6nKJecfsBg130BwscFPwv0Mh5xqS8
	Y9/skiMsnklgxcGgVjOl+wppeun+gyNXIjiu99rP2erelJMFJ2qcIZA75wVI/O9ZIrLpB4ZSWiz
	9fZKetgbiYiZe/fp8qtGdVz2ABTThcypT43IfTdG0hLcmsao9iE7cjCvrtMEecRIkI85S6WGuA2
	InG7b7rBYWSvzaePK9THMw237cMs9cNNm8c=
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676325e9.20.1758699720375;
        Wed, 24 Sep 2025 00:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBaH8Qcz+geVHLVmG1y55L66i7iUAa9TF2rE/T5FQj6JWkFbMfTzOEnJtYBSrJWjTl6QSAhw==
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676015e9.20.1758699719977;
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40bd194c0bdsm1287994f8f.61.2025.09.24.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:41:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924034112-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>

On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > patch series, the associated netdev queue is stopped before this happens.
> > > This allows the connected qdisc to function correctly as reported by [1]
> > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > the theoretical performance differs only slightly:
> >
> >
> > About this whole approach.
> > What if userspace is not consuming packets?
> > Won't the watchdog warnings appear?
> > Is it safe to allow userspace to block a tx queue
> > indefinitely?
> 
> I think it's safe as it's a userspace device, there's no way to
> guarantee the userspace can process the packet in time (so no watchdog
> for TUN).
> 
> Thanks

Hmm. Anyway, I guess if we ever want to enable timeout for tun,
we can worry about it then. Does not need to block this patchset.

> >
> > --
> > MST
> >


