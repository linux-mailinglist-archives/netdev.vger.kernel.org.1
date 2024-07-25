Return-Path: <netdev+bounces-112990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857E93C210
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E601C20E2B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4815199EA0;
	Thu, 25 Jul 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY2hGiJM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CB1993BA
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910582; cv=none; b=MJs3SRQd3yaxCN0nmMcHBslhLXwNE00xx81bIgrJTfJ1y0Vb8enhzrZjDP8UYrXT4OIkJ7NSWxqRLTLY093o+HXXSD6jxGKEnE6juv3+/IahcUVpYkq9lUWkM+2hDP31woGqYRM2oER9IEvQhWPD5ZLadAJHZJknyCiCRe0T390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910582; c=relaxed/simple;
	bh=1x+MRrK/gKvb0AP5m2fDvNNFyowu/Kb6wBFKgceGBH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo/Mb4C4OGlNKSoRBthpZuxKMXo3urf4ZbJnlbMaxDAmjHtHKLc23quGeZ9C9OlYg19myLF3lLECdLfoekp2xKds9TP0H52vTqZXQLsPo8LelNpwJyHq4TezlfqG/xoYXCKvhfPSzWiROZFCP1DAC7qx6O7YWSRiLJOSqvXjKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY2hGiJM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
	b=iY2hGiJMegGYi1tgITFilEuNCyQ9dadErA8+BSvpOJsV4n5IM/1X9ioSO1HFszmeoe+FsP
	+4t5sH32FNf+7H7arjaj19g8xoEX9IOC/VDOUfnUdVKggRGtKHOZ6XUJXGwpNn9aVsocRL
	OzI36+BnpUeWf7tq1e9oY/7SxSTguP0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-B9GaXYfSN7uGteV4jC6BPQ-1; Thu, 25 Jul 2024 08:29:38 -0400
X-MC-Unique: B9GaXYfSN7uGteV4jC6BPQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a2ceb035f9so1311235a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910577; x=1722515377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
        b=MfvXRCzsfRt+3uibbZ5jDEnOUMgqSxHogh9riZgGnKpe6nkAbs9JKleOUxT2xoGKDy
         QmEPl9qOi26G1PCXAsMF5cPf1GuIeC1fvjepiTOqNGBNkrYk0uZNlCbh/omPdERcb+X6
         XkpwtBCpqn87PaN4yHCYPOp4tLDS9Rl/+TSRSiej5izLkNbx8hrcq3/YhWKXRTdOD/cG
         w7AaaSX/i601jsUP0zXIMbKKTaqMeA/notZljCbjtkyW97pyd0FOpwM1gcEf22EhYE4N
         3eRACjiltBqBkwyGjq0U9c6zLqjm1HYJTkl2wxCJ1XFacYkdgJ7XptppsoUVNZ3WNgUT
         72Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVRJHb5FN4jNMXg3HaIsrkR/ea4AalPkls92EdLbiiuhDqiFvbaNHGtl/Qg6cOFP+ySR/+El7NYl8zbUV1Hy+8AdMaUHfcK
X-Gm-Message-State: AOJu0YxWyc9YQ7pN8i+B5madwqhTjVenB8YZwuzGwZvw3SpQW6AKJejr
	sPMT4SI0cXs1kRNhgs5dNvaZs8de8ZQdmGqNvxXAxcXp9vZ/DmFMp1QuS/BL++FieZR+YJ6qu4D
	gcQf/0jitUVmgs3Z0w8MTKe88tOdjm+f0/zbjoOqO+fVBM6F4UuEV8g==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616853a12.10.1721910577478;
        Thu, 25 Jul 2024 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzTf1Dq4jXq+lb4GZ/ln7u62lD42/qJf2maAOGtbm2TYn0twTp0kEGmFg6gBHrHiC+FsesQ==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616818a12.10.1721910576749;
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3becsm768874a12.74.2024.07.25.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:29:31 -0400
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
Message-ID: <20240725082828-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>

On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > trying to keep two specs in sync.
> > > 
> > > The ACPI version is much more lightweight and doesn't take up a
> > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > complex in other ways).
> > > 
> > 
> > Hmm, should we support virtio over ACPI? Just asking.
> 
> Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> exists with a DSM method which literally returns DT properties,
> including such properties as "compatible=virtio,mmio" ... do we
> already?
> 
> 

In a sense, but you are saying that is too complex?
Can you elaborate?

-- 
MST


