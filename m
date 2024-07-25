Return-Path: <netdev+bounces-112978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A493C153
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335A21C21C24
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC31993B2;
	Thu, 25 Jul 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdlbuJOY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9B199231
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908855; cv=none; b=motZ/JHq0XNK+lBR9wxABuDNMq8D0IIFN9jx0mAl127rqGmVYR8K0srpMmZeFinmHG0716SzD/dUkoLhTWnySHceOeFN9Px5oo6q2kt9OGYkZ2GeXZypnU3QsqaWHlxkcgoBhrGDcChtoAh2Hi/pW28Z/g4bCSx4OLR1e/UkQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908855; c=relaxed/simple;
	bh=P5jGrdaBYAwkwtyNWIgiyvQvfBY3BKYxB8RMoQ1g3XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pww8hIh1wO7IYzujngbfJYYHA8yS94fN+lG0LOsH03U3WSa28+JtHK9aO2k8XrkC3HxR+srylRW5hbGtQnPdHqybwpkaSESiAnvDmiEkk4GcqR9Q/bBBRAWAl3yCW7WWzw1V1wTq8UDG+V8liepb8+3jvY8TfsOnSAiE6y8wNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdlbuJOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721908852;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys2kUGxklyDGscsOVEN9kILYtzx3YDKJ1q7CjI4xn9U=;
	b=bdlbuJOY2sr442V5+4xRfPWn7v+KqzAjNc+5mnEpMx3WGDnnXGvf+jZ0J46lbR8KVjNtWB
	Bo4G1KW+o3OSgxAyPMT9PY5gS1Dlfk0oW5plpAmmh6ogdkvVhbgjcquVgZVxTigjyAt2Yk
	i7F/O0H+gir8YtfNUpIOGpnaRCJ9/OA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-p9345v9QP3yM6LJRRw8iOg-1; Thu,
 25 Jul 2024 08:00:46 -0400
X-MC-Unique: p9345v9QP3yM6LJRRw8iOg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75078195608A;
	Thu, 25 Jul 2024 12:00:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 423C51955D45;
	Thu, 25 Jul 2024 12:00:22 +0000 (UTC)
Date: Thu, 25 Jul 2024 13:00:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
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
Message-ID: <ZqI-TyjlMe-G_xFs@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <ZqI3ntUR6bfY1kxo@redhat.com>
 <603aa858ca961a5c4fdfc9b44834343adf1c73d2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <603aa858ca961a5c4fdfc9b44834343adf1c73d2.camel@infradead.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Jul 25, 2024 at 12:53:34PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 12:31 +0100, Daniel P. Berrangé wrote:
> > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > Hi Michael, thanks for the review!
> > > 
> > > On Thu, 2024-07-25 at 01:48 -0400, Michael S. Tsirkin wrote:
> > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > trying to keep two specs in sync.
> > > 
> > > The ACPI version is much more lightweight and doesn't take up a
> > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > complex in other ways).
> > 
> > In general it shouldn't have to take up a PCI slot, that's just
> > a common default policy. virtio-devices only need a dedicated
> > slot if there's a need to do hotplug/unplug of them. There is a
> > set of core devices for which hotplug doesn't make sense, which
> > could all be put as functions in the same slot. ie virtio-rng,
> > virtio-balloon and virtio-rtc, could all live in one slot.
> 
> But if you don't have any virtio devices already, you still need one
> slot to put them in.

Perhaps - it may still be practical to be a function within a slot
shared with non-virtio PCI devices too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


