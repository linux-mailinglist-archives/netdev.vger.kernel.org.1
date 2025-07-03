Return-Path: <netdev+bounces-203736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CECAF6EBC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A580560071
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FE2D5C74;
	Thu,  3 Jul 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs9FMzO2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1A27F003
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535102; cv=none; b=CiB576TLNc8IO/Y8yUqB7JUxXZRkuAsX2K7HH65cRZZqC1D3uddh10ZV7zBXj5CfLxxYj0bjLn/SfNIuCCpTpbEUUBXQGMGTwa2F63f4yvB/j31XXznc2v5gDu+MoVGBulGTMLaBq/72KMfAXh3Qu7EanhoTtKlcA/Z7r4cXiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535102; c=relaxed/simple;
	bh=PVDBSjyULPbs5x3zIrE5o9Rl0g38caEh9UMxzPrn+Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYHtJCUgmfnBL9ZOc5HUkw8T8uoA4PKz33/LzX89hfOY02pAxRkOF/bBL7AwGoaEYF11vyLEc+07Ii6aUfBDu+DI12fM8GJ3n/dtmOiRPHMMQYL2F89EnjNH9IALNlmeBr9Q5fSWzYxkBJa+tkpGO9BvTSDEuQFEz8PucePjuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs9FMzO2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751535099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiM34ne3qqgNc/PC2+T8kkcXMp5a3XxcjcM9ongF81s=;
	b=Gs9FMzO24do2iNoAJgPz9MLFwFaE6crygdOMmwxtB3G/fRJ5s0hLlFMpBSGFaHsH2Jr83t
	0hXYd/Xj1HBtbrR+4APk2MrI+NwMJUfCS3OcylZPUcTQ5786cf6SRzj/FQKvgGe6HWKCTh
	brSzpbfs+RJv3LQQez6t4I1Z5JY2oIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SL0n2WAwPte5cFccP1XN5g-1; Thu, 03 Jul 2025 05:31:37 -0400
X-MC-Unique: SL0n2WAwPte5cFccP1XN5g-1
X-Mimecast-MFC-AGG-ID: SL0n2WAwPte5cFccP1XN5g_1751535096
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso34658615e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 02:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535096; x=1752139896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiM34ne3qqgNc/PC2+T8kkcXMp5a3XxcjcM9ongF81s=;
        b=ZyiKHFlRV0ch7/GcnzF092MvAxtg9gTjtzL9XMgQK1snOHoZvLyHkD7WvvB9F53tFK
         AZU3zCh5rj7I/QJXVI1zwvyYMN+5+B8rwDeMVTn8GE8P3dB+3sOQ02u/nXbu5asYB0HW
         s0XLo5/e/35iD1ugZNpQZ6NoPF/9pGN3yLTG3EYFURq8UNeSUAZKnPRgaNGGknjMVc3t
         25ZT+MHfGBi0S1yH9scZqTm5ILE9O4g4rpnsqGkZeeJBzGN1fThcDlXv4Io1IxNgqrMI
         ot81t8SltrvFGtVF7X4n/Zos8xmnbkq9NLLnCHjYEqvb05+0fxXF2jnJbpJfyXIfPWpx
         h4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWWAXM3iu/+sjoPFcLfoQVd2B1+yw5VhuT3Ts2p+hRKYiYZRoZghdAapyexjJ14bcXKVei+HjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRh8QNJLLBcCpL92QxFqIjArkD+s3eDXwQwbLzaeB0JpJjq3U
	z+gUwT9zW6Bz/E43n4qe/Lh5XcAF4lvQ76VJOqvX9ISr4B+/UbldQR9/nq9cgTU4MlZLEpzpNjU
	EWMn8IakgZ3ENmd89IPd/pCVwh5vaSrU9Nev8jUSaeG5PivUsw81v6GOOHw==
X-Gm-Gg: ASbGncvOykcqk6FQoMSph7j3q8r1TrgBc1B6+oNKqA4/Mwo9fZUDnXzkHJNdCO24M8X
	i9ffwJr9sDAytg7zln8cLz/q9Azz3tSoaS+qbNmWy2QumvoPgTKzysTJ3d7tethZiBzhH/4o1ZF
	4mC+ARxNmBPJHpnWfu5OLduGCurCrISfxC9y6fq1aGngfQMLH389lNPiV0Ohbf8WAoL6zJ+W5D0
	kaxRytYEZnt19w3yVVehQifMToBXxe18rfLnuTVAB0rDaLALxB0ZlYB8kgy6MgzHpbJjcJsiHuk
	IxCj0K7vO5/aCxxQ
X-Received: by 2002:a05:600c:3b07:b0:450:30e4:bdf6 with SMTP id 5b1f17b1804b1-454a3704fd2mr58221215e9.19.1751535095938;
        Thu, 03 Jul 2025 02:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMIuf6yUQDcBc0LWWmzv/B2M8HuBjvXyhM6QvDp7XQF9yZebMii/qbfs/UzrXjc5q42VPkzg==
X-Received: by 2002:a05:600c:3b07:b0:450:30e4:bdf6 with SMTP id 5b1f17b1804b1-454a3704fd2mr58220935e9.19.1751535095479;
        Thu, 03 Jul 2025 02:31:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be0bacsm20751665e9.32.2025.07.03.02.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:31:35 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
Message-ID: <20250703053042-mutt-send-email-mst@kernel.org>
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

I take it back: given I am still not fully operational, I'd like it
to be merged through net please. Does it have to be resubmitted for
this?

Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST


