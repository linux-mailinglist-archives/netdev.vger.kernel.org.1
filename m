Return-Path: <netdev+bounces-203735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C3AF6EB3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F574E546B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0BA2D878C;
	Thu,  3 Jul 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4BXHVOK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAE2DA75E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535042; cv=none; b=mv6+6bAP0ZF4qxmNb1lnKJtbs0RxnK+uj+XV0hfO61Pwal+5ROS8ZtkCup4d7XTxbaiqBdsCaQiobxv2z1urLUuAuM6iAxg48hR6mGXhZ77OxXYu3qSVv+nZLeQQapv4pWZb5amulyyDTuzLJy/mfatN1/qFAZZzJn/Gr9u+t7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535042; c=relaxed/simple;
	bh=+9LY65EJRBu4Z+OtHRUlcwV0eyAifNrUhOiPBXIMhGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMCWR6J1gIcJGYSgt4VXGMduxKlzB3ENpfhA27Pj3K/+AmxWGYjWf8w6vZD9audH/GiUGLrydmFFeJYwW1mpZX1R9xD5Mg89dcmx0VmKmSGhUtJeWsuMVuX1gj3qguUJzdPfLFVE1YRp2dmYLM0gOy3tH/YZ0WRRKtiTrZE7zOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4BXHVOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751535040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRFdLYJ4q7/MAXUEMWlpPtrPV11dB3OuQtvNTnayJQo=;
	b=D4BXHVOKop+JmmO5kOf30mgX08WDZ5D+QWx7xoL49YfF94JFjZZ/36VQ/QoEXV2MoKx0KJ
	YM+SqW1Il/vAZhp1ZjDIUgKTJ3aVlVbpg4NtZ+RMCrbC/FA6feqYBRnag7XqsGON+UMMXi
	uLoAdMbeoT4M0U6sxDAxGZ2jXjkPnXw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-w2LyIZMJPDe4cLf2tH1WMg-1; Thu, 03 Jul 2025 05:30:38 -0400
X-MC-Unique: w2LyIZMJPDe4cLf2tH1WMg-1
X-Mimecast-MFC-AGG-ID: w2LyIZMJPDe4cLf2tH1WMg_1751535037
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso5331291f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 02:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535037; x=1752139837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRFdLYJ4q7/MAXUEMWlpPtrPV11dB3OuQtvNTnayJQo=;
        b=LrlxT+fkO+JOnw1d6soSdA6xONzSX+FrmXCX6+/g8asrSXs15eBbdlWGKE3lO4wyyh
         S+9VOSfEb2F/x0sd+n3POcdS7ZQwHF8zwnlXYcoPELqeJjjToDpjVTyBjg+M3gNR+zxx
         XopSOAaL4dFlHs/rCMLt1OUmtT2jP17wepMGd8O3qDx3560r7AFGO1RQCHc4j4FPaRjI
         ajYd4QKF0G41SleDsuNZGPx6YXuCUx30oVlugFcX4hJ2tOqxT1LN77QBhwUWJQJVJzDt
         Ac8feXr4osecM+tbWYhRJucfihZf1NdcuRLcWIuXw5+F8tb0tSSvT3BoJjPqhd4cGHBF
         IHgw==
X-Forwarded-Encrypted: i=1; AJvYcCUqhQmJi8I/y+aAQd5KX1wEnaBJtzs8p+Cwsop5WjiUJPl70SFVbKHaHy+J17otsB5QXhpdV3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoxGNIDBj2AM3FsIJbKdvVjQJgjJ1UrVgIv3UvkkotzFBWodd
	Mv6kGKc8461pjYZJ7hrbidTA5UUt4dgyBkpibqkdUAZzWghHTyyok10kPnmrAsLP/rejvJfq/0q
	Fx4ySgKu43yi0fO0Zt+qx+vtrJCGPhOk9n72u9AL/SLXA7eVHHNpVcHXm/Q==
X-Gm-Gg: ASbGncu7LS08SMbnh0rC2SOBbZioa3uYFNMjlt1zfBmJhtFi2bFbp/Hx9jG/iw9XPOS
	isJx2xrhYaZAVn9RRVZJZ2W6agNMLIif1n6EHyQ2n3+hvTKdWIit3ZUNF0MGC9bflHZvIGOF5bA
	MML6o61/t875/Jnurm1SzS4CvQ4+ZWZWZ3Uu6goEP2+6jYQGqBq1xV1PgeT2CalPkJy2UTVI0g8
	Kcgu+25Xn+cLNC5xhrvQFbN0iNbHsgJl4G9qAC0qlUtGhHeydCyNLHGSyWX4yc7CpCVFE4DmidK
	GB5waLeoZbhbXCgI
X-Received: by 2002:a05:6000:1a8f:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b3a6b29e99mr848230f8f.48.1751535037400;
        Thu, 03 Jul 2025 02:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELWFqj9I+aIUDU/5RiZ+sKsYw2mzWKRfT/gfXBnwZnWoC9nFVXzrA0v3mthR9QtuA2m2qUlQ==
X-Received: by 2002:a05:6000:1a8f:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b3a6b29e99mr848203f8f.48.1751535036898;
        Thu, 03 Jul 2025 02:30:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e24bsm21380565e9.16.2025.07.03.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:30:35 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:30:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
Message-ID: <20250703052907-mutt-send-email-mst@kernel.org>
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
 <20250528031540-mutt-send-email-mst@kernel.org>
 <770fc206-70e4-4c63-b438-153b57144f23@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770fc206-70e4-4c63-b438-153b57144f23@redhat.com>

On Thu, Jul 03, 2025 at 09:43:46AM +0200, Laurent Vivier wrote:
> On 28/05/2025 09:20, Michael S. Tsirkin wrote:
> > On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:
> > > On 5/21/25 11:22 AM, Laurent Vivier wrote:
> > > > This patch series contains two fixes and a cleanup for the virtio subsystem.
> > > > 
> > > > The first patch fixes an error reporting bug in virtio_ring's
> > > > virtqueue_resize() function. Previously, errors from internal resize
> > > > helpers could be masked if the subsequent re-enabling of the virtqueue
> > > > succeeded. This patch restores the correct error propagation, ensuring that
> > > > callers of virtqueue_resize() are properly informed of underlying resize
> > > > failures.
> > > > 
> > > > The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'
> > > > 
> > > > The third patch addresses a reliability issue in virtio_net where the TX
> > > > ring size could be configured too small, potentially leading to
> > > > persistently stopped queues and degraded performance. It enforces a
> > > > minimum TX ring size to ensure there's always enough space for at least one
> > > > maximally-fragmented packet plus an additional slot.
> > > 
> > > @Michael: it's not clear to me if you prefer take this series via your
> > > tree or if it should go via net. Please LMK, thanks!
> > > 
> > > Paolo
> > 
> > Given 1/3 is in virtio I was going to take it. Just after rc1,
> > though.
> > 
> 
> Michael, if you don't have time to merge this series, perhaps Paolo can?
> 
> Thanks,
> Laurent


Sorry I forgot I asked that netdev guys don't handle it.

-- 
MST


