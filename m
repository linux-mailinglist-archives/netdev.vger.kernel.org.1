Return-Path: <netdev+bounces-113216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307793D386
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9371F21C41
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6117B43E;
	Fri, 26 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq0SQC1Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE52B9DB
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998348; cv=none; b=bEGKS5XjwY2K6XBZv1d4ad4LZb2Hc2b64zo9XdX5VFZooCGfaoRnI2djU26MPiwAyfHZViORirvxlnj3GP926Md5Xp0CKO699npOdbTzRI+EJGcm7gKsNVgfRlvecqyhAOV3bFG7TdS47v0yDpoYeLRRmolL7NF/qPdvKS9zAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998348; c=relaxed/simple;
	bh=Sp+ueQmSpfGLiC6k78+rR7dKtxhLr7HvODWfBRy/H98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbVG5XWODiK3GLjnya33hwAXIoGGWvZPX78cXhzlYjskp8tX7P/ueFtIfcRCNc2iSc8Tg1RAcRRClV5ZAHhZWnSRb5ZAaoUuCdk76K6ynTZAXPTPZV8rt/2pqS+rqnPRaa862btUQy3up6LMTCAWuu3jbjGOT9blN0dJYtw3yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq0SQC1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721998346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
	b=Vq0SQC1Z3zBZaXzYRr5LrIjdoItqkJT0a9bcNDeMFdJ+wxIj5qVy3b0VyV/GXdzKHBE0Cd
	Umuc+l9oQKi3fBGrhkQO0/xBfL2KfkzqIlwrjkfNFf7JuNa2GKjqeYXfkLgpbRriR/K5hu
	qcg1IvAHRbWHhrFjMPizxXRay5vu4fo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Dzg80OaJNiCwMvmRJ7YqxA-1; Fri, 26 Jul 2024 08:52:24 -0400
X-MC-Unique: Dzg80OaJNiCwMvmRJ7YqxA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b119a74so6249365e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 05:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998344; x=1722603144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
        b=l4kRSzCg049U4rqmrMMXHn6IFkx7e0WDFzt3ghivsnrm7dwW+rhPH9eGAlsEihtbti
         gTnh2KQAKHOM/bI8Yko+fj3Ydd9HFocXSjOncEgAzWP1xly42CeVCjhh6Q44ZGC6oCz6
         iAKDxZqrurUrbAGWNFvoo3NIDhRpA3eBkjDWq6e+BVVhDMHvQWh/fg/x2tkFyE+y9t5s
         f85S9OmeM79t0a42P1swsWangujoeuCwqD4dO+nsfZaDqUqCVDGUcFLUhLUw+lYqBceO
         W39UoBVk7h4OXjZtd89SglylooGFq65kH4Jy7fBWkxmc5eAr//VGyO/S0I2Mgj7HpQJ7
         sfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqusmMhJwEhELzzdtkVXlPxoj8t7+hprGisIFC3Bv/+tNoD4jxuRFmlyqfxUfY3+WFN7qDpaxs+MiLTz52JrUO8Hoa7OMb
X-Gm-Message-State: AOJu0YwiczSB7QQc2hmopH5DHKNNxxZL6LJLVg6iBrAmeVgDDqsRKa0Q
	8jitlgKoYjtQyqbNCEAGtQ4NIN5G7IfEHp3rasQwwzVeOMY+4d6MJf1xvGUZSBKqLfCluEYMQU4
	vnezz/3Dvvnqu9MmDakm6NL/meiIAJtqo3w67SrhY7d9TnHLp7cQXUQ==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35917515e9.17.1721998343807;
        Fri, 26 Jul 2024 05:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZtYe8A1GZTEmL+i7voXFimPt8dBDRrCiuydzX4tPFYqbNapaldNesLi/P0+Gt5ylw7JbVQ==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35916735e9.17.1721998341579;
        Fri, 26 Jul 2024 05:52:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm5219141f8f.107.2024.07.26.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:52:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:52:16 -0400
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
Message-ID: <20240726084836-mutt-send-email-mst@kernel.org>
References: <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>

On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> But for this use case, we only need a memory region that the hypervisor
> can update. We don't need any of that complexity of gratuitously
> interrupting all the vCPUs just to ensure that none of them can be
> running userspace while one of them does an update for itself,
> potentially translating from one ABI to another. The hypervisor can
> just update the user-visible memory in place.

Looks like then your userspace is hypervisor specific, and that's a
problem because it's a one way street - there is no way for hypervisor
to know what does userspace need, so no way for hypervisor to know which
information to provide. No real way to fix bugs.

-- 
MST


