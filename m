Return-Path: <netdev+bounces-113142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0393CD73
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753451F21B11
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980B3032A;
	Fri, 26 Jul 2024 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpWPPULf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5E2B9DB
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970570; cv=none; b=Fo9Ko7b76QHqgeitQPemsncP2v6gWw1Hp0MymGAoIYGgLoELUKHLMRB3HpyaRj2GV683GC4omX4q+zENKcBF0uHFDUXSRCCqfcAzo0OpRLQL+2v7ZFqrdiTogXR0oJzgzwj8UulTFcMU/QxQBzzE3IIcAuDeEU+OUHB1luqUeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970570; c=relaxed/simple;
	bh=mwBiyQNVoMNybA5O6D7Gx2PdVoETiCkHnYn15H6Goyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqAvvLNAWMPtqqaqeBU71bNqNb47DFMEiCRcawocfSnNfcTW48C1eD8IhgiL1nTHXk+Ua5nY5sJ/v1YCC9UKelP9qTUTDDNcMaOfjHWegSApgD47bDoUSOVbPfjq4Lv7pjELba71Zg41+FDxL6/OQcj8kjmTQ8hnSv2QIa6wmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpWPPULf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721970568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
	b=FpWPPULfBm+9iH609S81DU77dt7QeIfHMOznjl0XiJ5f3HlLOE8VCtyJ6ksBapazI599IX
	Y0A1B7Ow/55ShqjO3liy7D5IPMaw3dGKCdCm2PJH5P0NjOCdSY/06OFW0ykBZEkZBFWBK5
	IAJS9+LFzb2AxeMldvH5XvFzJu9wyYg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Lm64H3zqPaikl_f58WdFCA-1; Fri, 26 Jul 2024 01:09:25 -0400
X-MC-Unique: Lm64H3zqPaikl_f58WdFCA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280cf2be19so1884665e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970564; x=1722575364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
        b=ludQNmMSokEgLYTcROnlCIf3E722pw6n6NhxttG5FceR0LwG/REiQJ9SU7XJ7uxhBd
         gESYBUL6NlT3SOcZYsfYVJmuHx2yF8fFW0dH+yPOdcEJuVEdwKU8b2x025eJ4DgxvtWQ
         Yp7vnpJp0IuaTD49vuca0UAApJEH1xypybBl02SgjuSYb1xcGzMAILm6ONoaWTLkqtiG
         cHmL+s/O68yI5hbmeL1YUdolgpHKWwwOgM23M0wuPmI5+HXg8Bq0cV78Z7Ioa3WgydpI
         PtdQ2ZGiGRotzM6Fze/9pzmo8m7nxc/1yB31LK8nQCV2rCEo5XmTEtD/RKRdco6P4r4b
         P/5w==
X-Forwarded-Encrypted: i=1; AJvYcCWjQ/P61958uVgTES7QpgxtW0ib80js1sKgqWn2hlmjTn8MXuIMH5PGU++xVmbOrgE9XK9qgqd7Pb3izzRag2XN4g2WpHz2
X-Gm-Message-State: AOJu0YyPMM+ZgZxdY3MXEYyzwOOJCJJZtU4Sq1GxFgd5sFFbctnU3erd
	enhQYiL1+z8tAxlJSLhu0lgJN24KFns0IfkHQuOgukaamGfqIFQpC3WM1ahgo5Un6c/nxIDJgbw
	a3NFi1mJHMrMNmTUvmqkJfv6LHRNP033u91Lu+dJSgPZ8//IILytMtA==
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-4280570fe50mr29400605e9.19.1721970564582;
        Thu, 25 Jul 2024 22:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGThAmioKqXVYW1bGCeFOTJCJYjUraPBu1ns0STXkcb4YEMtbOBAAif1jc1w6fYVZOAbSOQ==
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-4280570fe50mr29400405e9.19.1721970563829;
        Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6871sm105269105e9.30.2024.07.25.22.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:09:13 -0400
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
Message-ID: <20240726010511-mutt-send-email-mst@kernel.org>
References: <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>

On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > 
> > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > the ABI issue - kernel has its own ABI against userspace,
> > > > devices have their own ABI against kernel.
> > > > It'd mean we need a way to detect that interrupt was sent,
> > > > maybe yet another counter inside that structure.
> > > > 
> > > > WDYT?
> > > > 
> > > > By the way the same idea would work for snapshots -
> > > > some people wanted to expose that info to userspace, too.
> 
> Those people included me. I wanted to interrupt all the vCPUs, even the
> ones which were in userspace at the moment of migration, and have the
> kernel deal with passing it on to userspace via a different ABI.
> 
> It ends up being complex and intricate, and requiring a lot of new
> kernel and userspace support. I gave up on it in the end for snapshots,
> and didn't go there again for this.

Maybe become you insist on using ACPI?
I see a fairly simple way to do it. For example, with virtio:

one vq per CPU, with a single outstanding buffer,
callback copies from the buffer into the userspace
visible memory.

Want me to show you the code?

-- 
MST


