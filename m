Return-Path: <netdev+bounces-193885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B008AC62D6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF87D7AA07A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B724469A;
	Wed, 28 May 2025 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfVQn4xz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826F1F872D
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416868; cv=none; b=YknB/3bcu3VEOQiADZWD685OJ8W0zoSs74NV1gWCoGPaZzGKzXKDsVNZObes0qF9H5jQIMshuLixk00B1ieaY3vPAnCzG3KRnns/zEO+AYT+yYF/1PLDLKP8QJUUtjNwVHQBi03p5s20MFnbBjr3Ycm8lakRgyid3SJRP3hwZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416868; c=relaxed/simple;
	bh=2qHmQEB1E1zkN71QCfVoyToUf5ogIWK0R6isdin/Ad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr2KZNcxsaHVNn0IYk/ILzdAIqsukRKmWnxIP6vHkqLQM05e4GyavY9g0DVW35xUkH+dORSGKmI0/BKKvSU5d7OVoVxF9cmm1jbm67pZoUoD829RwTBh0g4S2f3pYEAbQXBooKTMT4z9F4cksChfmKCG3JAJ4I/q1fSHn0PXGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfVQn4xz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748416865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb7F8w++tHPp3njA+diY9i2D1I8vF7wYtoKldSCXI70=;
	b=QfVQn4xzyiZOFSr3fJUJ7sV1dJ6Po3FbuhywhUQbZnA41wnMMRZpyDXXm23TMr9EQ22APa
	4BZ3UNVuQomwdY4YCLuL6d6gnlBnnQnprwiNMQ4Dz+bKM/53OQj2MZ0B+/O4QU0TF3C4eK
	ohd51nbSc/86nom1Ruvzp6uSpAnwJ+A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-mMDvY0EyPUicXLhFnG6KfQ-1; Wed, 28 May 2025 03:21:02 -0400
X-MC-Unique: mMDvY0EyPUicXLhFnG6KfQ-1
X-Mimecast-MFC-AGG-ID: mMDvY0EyPUicXLhFnG6KfQ_1748416861
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450cb8ff112so255705e9.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416861; x=1749021661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb7F8w++tHPp3njA+diY9i2D1I8vF7wYtoKldSCXI70=;
        b=grGstzPpxryNEV/+ya8NVKzTpl2FdsEllmti7TquY/BtNPnbkHb6UHMOPDq9pSMtqb
         OhStNMBb0megbsyD7LoqmJPehOFJc+l60XH8rAQ8St5Q0xwZIFNRoU2ojsER9ZiNGpdy
         4rMRwwbJzlW4o7WG2WyhOpsQ22DZlmMxHX5l+Mm40gHr4IuU6ai5wiP/yeWe34bAS3Mp
         L8tQ++wGBvd7/Cj5ULCWhbkb3WQutKTwoXIu62sOnw214K5SxRLmYhrOsS5holntRN8s
         RLVeVhW6VqdPoR2uIwXv3kgLNAklKD6NQlGhijnKf86FdYfPtpr/cD0R3tOcV4hSjKP/
         d23g==
X-Forwarded-Encrypted: i=1; AJvYcCVHEcjVyONmFiULhBZZb3g+zZurb/O8MFZ7nBMLnAzlnieoAzTP9zYk2syMv/CZGkQ4p1S+e78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoABDfCXpGII3fLtEiYiBjrLX4FSTuSa+KUpV3auD4qvcITLfm
	BlmCMz2xJyrMQB5GNFTau49c+U9LM2uT+IEE8YkFZTXKrDYZPKb4Pja7NWnYRtmoDs1Y8iSK9v7
	fTzU22f4VdreuETCeoFAJX5S7YZW7RPJzY0T3Q/9XuAgQsg4njShfalpJh8jGFY4tSQ==
X-Gm-Gg: ASbGncudS3aI5idsyE69LtmztcSo8467J0k0mpnQJrZfTzjvJxGaqONkFLMoeCCLZDa
	Q/jS1bWoGu9RumPYXQOAHm4Hg8dXOUR8e2n9OqAG7QEhz7FGE5ub5+O+o+UMqfPDCTl4mnC+dWK
	5bWRpLlq5UcN7iqsuQXa91znFwHWYftKSiDuEVwCFlrodwAr3FvkDOdLzFq3YBDna230LzGZDPI
	RL6HQgUSxbdkKS8blH/se7+MvvHLYh/HOHl8yHQIeZG0IrSgiwZYW7KLLw0YdlQwODOcHO7224L
	SGgzkw==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-450725459f7mr9070065e9.2.1748416861116;
        Wed, 28 May 2025 00:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtS9Q0iEWdCKqSBK4rpAPZvD0CQFR0nxD5Boy80MHIXn1Qzua/IJWOZxrhYd51QhCIxJ9zSA==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-450725459f7mr9069825e9.2.1748416860757;
        Wed, 28 May 2025 00:21:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4507253becasm8466095e9.2.2025.05.28.00.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:20:59 -0700 (PDT)
Date: Wed, 28 May 2025 03:20:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
Message-ID: <20250528031540-mutt-send-email-mst@kernel.org>
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>

On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:
> On 5/21/25 11:22 AM, Laurent Vivier wrote:
> > This patch series contains two fixes and a cleanup for the virtio subsystem.
> > 
> > The first patch fixes an error reporting bug in virtio_ring's
> > virtqueue_resize() function. Previously, errors from internal resize
> > helpers could be masked if the subsequent re-enabling of the virtqueue
> > succeeded. This patch restores the correct error propagation, ensuring that
> > callers of virtqueue_resize() are properly informed of underlying resize
> > failures.
> > 
> > The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'
> > 
> > The third patch addresses a reliability issue in virtio_net where the TX
> > ring size could be configured too small, potentially leading to
> > persistently stopped queues and degraded performance. It enforces a
> > minimum TX ring size to ensure there's always enough space for at least one
> > maximally-fragmented packet plus an additional slot.
> 
> @Michael: it's not clear to me if you prefer take this series via your
> tree or if it should go via net. Please LMK, thanks!
> 
> Paolo

Given 1/3 is in virtio I was going to take it. Just after rc1,
though.


