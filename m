Return-Path: <netdev+bounces-113144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B893CDF0
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE9CB21C92
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB710173355;
	Fri, 26 Jul 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzmDsLME"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609213BB25
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973986; cv=none; b=NWv40A/znvuZ8Jk3I9cTehtPHbqv8X59mK4trMzmmc6Rvrq5AdS6fa+LtGyw2wiPDczfi3WQ+L3PwoN49smpfraRGS1XpHmHHlXaOvtQ57CN/ns+ljhc4j+IRESchuhAdGHMaYmkUHRFXcG5CObadVPuZIOGoKiaaXr9IaeGlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973986; c=relaxed/simple;
	bh=6a7x76ue8Tb/QiSBhzrn7bO0FzEBds6B8ZU9VxKhPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3cpwSsuyNc07QE0aibhLNgy5bHw8PqtHmPxLcrOp6zZ0RzYSHoHqLDCopiMiFDYnkrJPeyHzx4Pq+vEpClLbOSeiTdDpT7XdL95J+yAANebpuHd+SXxstgg6lZto/vnuTlNwCA6apqMuk5Nh7qG43Xd5bhncjFRN/zPihRaaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzmDsLME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
	b=NzmDsLMEH51FVrxuW8qTQIm4jt/MsjPaxk+KOCognl04vjKTxqVyTskmGzpugtznMYFp3A
	y5l9Yped6e6+oJGORlxSekLMGRfVmmvlq+Cwc/BvvVgWuKUj3H79i+4PZuiayoC3q37qR5
	fp4Gnz2tswU7Wo061mKpzGvYYeT3uSc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-gr4HDwNYM1yML3WhRZEnIQ-1; Fri, 26 Jul 2024 02:06:21 -0400
X-MC-Unique: gr4HDwNYM1yML3WhRZEnIQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36863648335so1041041f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973980; x=1722578780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
        b=Hv8JcDLMOkpuLEgDCSJZp5MJkT1+kWhUptgE4/EJjJBrieb1w/tH95p7Yt9jvuyurK
         ri+0eZ5UvQ6s7VaD2xyYAgjeQsJS86jM9Xg1L/slxo2lH6b8veipAFZdW3vXsBzZWD3r
         pa7dG9W7BMDeCtTWIUDEIxNSzuevkec4HlfZd5/4sD5aZ19v3w1xN9NjN/J8jzDEKZhp
         4G+Btv3fPz+Zg//WhTRiE0xuVgeLqpv0sUQo5Z0M2yPVSfTwJqsKf1RD1cAoXcVCUBpU
         3GV4aYrb9ok8bDX4U3TVS9BjEWdl5Kz/U7yaY1PNTmN7ftTyaSPeEI0QuQ6nE5xPFNzO
         LuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH1z+7v1s3QyjY6eo0MsJ4qBB4gkcZpSr5bMSc9uVi+uocsmFdtGXHEDAFB7MuY/R8Uwtp6G9HVClkbihbffaXeVKvquql
X-Gm-Message-State: AOJu0Yx5WA2ku1Bp1kj/4JKTIpLkxJc1fpu6pkPV+NlTRvqQjlj2yxhN
	kosFXlBXjEE7wsYnrty4pHUtnDS+0EFVoilcO/lGzAnsdAfvlxhkvsH/v/lQMqBJeVAkLgCCQRY
	IpJ9YcZ6kQ11ZED6KbXAjF9pNGkMWXlavqdNkkDqSFh4CvhB9d/G4Dw==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555961f8f.32.1721973980465;
        Thu, 25 Jul 2024 23:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcqinn2RbOzn7J7peOWcha9uEPwJVbe5Fk8jNLudEw/NhTNHYXX4sldsTgb73GWvF/16VyA==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555913f8f.32.1721973979719;
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm4031338f8f.109.2024.07.25.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Date: Fri, 26 Jul 2024 02:06:10 -0400
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
Message-ID: <20240726015613-mutt-send-email-mst@kernel.org>
References: <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>

On Thu, Jul 25, 2024 at 11:20:56PM +0100, David Woodhouse wrote:
> We're rolling out the AMZNVCLK device for internal use cases, and plan
> to add it in public instances some time later.

Let's be real. If amazon does something in its own hypervisor, and the
only way to use that is to expose the interface to userspace, there is
very little the linux community can do.  Moreover, userspace will be
written to this ABI, and be locked in to the specific hypervisor. It
might be a win for amazon short term but long term you will want to
extend things and it will be a mess.

So I feel you have chosen ACPI badly.  It just does not have the APIs
that you need. Virtio does, and would not create a userpspace lock-in
to a specific hypervisor. It's not really virtio specific either,
you can write a bare pci device with a BAR and a bunch of msix
vectors and it will get you the same effect.

-- 
MST


