Return-Path: <netdev+bounces-112912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FE93BC3B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF971F23949
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B113DDB9;
	Thu, 25 Jul 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg/oqDl3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62B13DBB1
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886866; cv=none; b=BweaLRlq2jzJZNz6BsDDE3s+3Jsd064MQTzbeN0tJ0kMizduwjDHjvdIS946c61RdTMSpGdk4yz63WS8963InsIE+gfO7kFy5W5Dr0FDie9cO/yHmA4RKCUafu9uYdm7VZUoqYhr06i5jCCGS9QnsCBPxY3s9BtbaGc5AmmS9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886866; c=relaxed/simple;
	bh=gAZvwL67v0vt6xsxrH6XS/itsYUgy+inKlxURoSIcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/CX7O/GVNS2eXMwKBKyx3poFmNtRxQyIUlUDl4awz4MwGtQXtU3yL8cwpURPIuKcKzZolMX2st8IF4u74h8vQHWm9EOXZ6w8KaOL6/Icatxo/rJ+16WqLIs9hVOiXg6sGNMwHi1taf3y3XEzoVTeW5Qj67MO//ehNHcmDIOpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg/oqDl3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721886864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
	b=Sg/oqDl3/zMVoIHGHP/9dA9o42bLVI+uErD2W0FnHd5ht+/ozbOH1kk/KqA3weiw0r/QCZ
	Od2bx09pFEGgeEtbU1d6dIsOCp+DW3DmB8qZ9O18JPcbJ8TGLi565oG7HHWD3VbiL3bKv8
	IwAsX6opCb1rXSkEfI1XuzfQyxyk9kE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-VsrO7XOgOuWTTYUXCsB6eQ-1; Thu, 25 Jul 2024 01:54:21 -0400
X-MC-Unique: VsrO7XOgOuWTTYUXCsB6eQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3685e0df024so360563f8f.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 22:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721886860; x=1722491660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
        b=uwuHGXwA6S7OaoUQ+frxix19yl0uXJNXjCKMXAiTllqRsmU3o8VZYaKSVsg10k1k0M
         Thgdyr6c6s/W4nZ7VlSs05y9H0Sogf27cI9sHefUCthxmuPPk1+elcNiPRe2hzEKK/mp
         1WczepVteGmRan0SaUGY4z7DBr1/dkNO2OaSKjkx83DcWXvisru7yvUD8MBi8VIy+qDy
         jb7sI+2GZJo0Oo+KImJouqQA26lqI82D9lUjyK9Bg6XleA8tFqD07ZyXAriiM/jKzoOO
         a81Uj/kMzM2m4y5o4AFzGh3IwjDeqMnUTHrzIEahPT3cm/8MytLS+QVQtNL0bQ/KtfO2
         vVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWotSuHYoSnLQglM7kml8RyAS1/aPyoSPEWnRci+HL/E5YL/WZrbD3tZFD5D6GDVlJshkIY6UJ7SXtGZGamZvpsovcuJdAa
X-Gm-Message-State: AOJu0YxFuhjUNne7grt81farDKQ+z1Q78Zj0Fjh+Mvk/QMQlYwBMnMy+
	uYv7OfSQerpxZlDPQyswgQ8kDCStWHKIFZJ+I1Y57jH4I63gWwprEKbx2Mic5b2mlETkcmYJT53
	ozgMF9hnK4dEaPFgeez/ZreXNiOXrml3lBcBVQaIdU1fUcq7NoHam0g==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707601f8f.39.1721886860525;
        Wed, 24 Jul 2024 22:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3Abal444WmsilGMojUOB9llheQDVQUaMgG30HCOZkmwXntXo9Fy/JkeXGpR8m6xgr9AF9A==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707561f8f.39.1721886859582;
        Wed, 24 Jul 2024 22:54:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm900105f8f.85.2024.07.24.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 22:54:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:54:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725015120-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>

On Wed, Jul 24, 2024 at 06:16:37PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
> 
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
> 
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

one other thing worth mentioning is that this design can't work
with confidential computing setups. By comparison, mapping e.g. a
range in a PCI BAR would work for these setups.
Is there a reason this functionality is not interesting for
confidential VMs?

-- 
MST


