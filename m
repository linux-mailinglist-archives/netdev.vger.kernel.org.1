Return-Path: <netdev+bounces-231266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78EBF6B5F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6752B403E5E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F123313E;
	Tue, 21 Oct 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE8wYcCP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554481A2392
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052534; cv=none; b=stJzIe1/V/+aQYt1H21AgXoKqFdQCiC8JjlUd5WxZ5BOYrkcMr9ET3iwh9dwSYviAVXBat0+W9RIldt23wOG1sFLL0+JCoHIv/ZJnKKkxmuKZ7cTF3gu8NCHLhtygXNlWRVUHjSb35JsM5YB/323Rot/SOTSSiESlgdU/D9mBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052534; c=relaxed/simple;
	bh=4lLcQvMnunkz+GAunoPU58cpUiOPw7liFAGLkEBA6QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVHl7A0rFhgLttEaRlOOwWu9ZuwMXhQqHFMnMwJOjwX1Pmsu2L06fILzxFNTcciPUl2a6BkLU6aUa6dZBsqKbAObu0sNJShdwdhsTwO9ZEQ+ZQIgXrGpNkPSx1tuKQesOW33Bf8c+tsMHwmfY+a3TBpJMtUwpNPQw0dNmBqQBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE8wYcCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761052531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paa6y0Umm0pxhPmdABIWbZ6KYckQ88Ey6Dsg8Oz34GA=;
	b=QE8wYcCPeB+kyaSrRTbqgojlmvxYRFod6sEzZ/SpTDuPj8on9A2LXiKNIV/zdRXRwE0XF5
	meSArvKyq6uAdfuerdmvnqG9qcdROeJsubNNnzDAQlmXwNEobA6HBe92BuxoRwClb4zEpo
	FkQK4wyzrJfXENOXrHNwKW5BOHodj9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-mhekcVm3ML6lh2H_6rY4wg-1; Tue, 21 Oct 2025 09:15:30 -0400
X-MC-Unique: mhekcVm3ML6lh2H_6rY4wg-1
X-Mimecast-MFC-AGG-ID: mhekcVm3ML6lh2H_6rY4wg_1761052529
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427060bc12dso5757072f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052529; x=1761657329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paa6y0Umm0pxhPmdABIWbZ6KYckQ88Ey6Dsg8Oz34GA=;
        b=hjtJTHachwSGRinB0ZiYNPq/Y9NgniP5XEz3Tl2FbdE79DOcjDEUbIZNoSfKYLKur/
         xHyH4BwuzQqro7YJ8MgTBJGuwK0exthQLyz3qfGbRFuXCQmuWtDd8MgLHxP5O9ke3TCN
         3DeX4iAQoE+hjPfbHXYUhMvIFOV2cHRseTUPwMoqsqeb13hyA6WbYjhhsZRXPqk0w+pj
         Lw3KsjHZC58MAH/7gYynByKTpfck2a/97yfmTSAbwptNqgZM6VykmJeIr1oXnd9MBzhc
         BM8FfGX+cYAwAuXS5f/yXPZVQhTo13wFjcrPBTm/jDISWNYPJ3WKGtGYDbA3gI8dd2AC
         7DeA==
X-Forwarded-Encrypted: i=1; AJvYcCVqOxLPLBIeb0uDRYlMNI5QNiI2GDNTo8yzHdFXcD769WiHnXg+BNumqtp1JxLA7YXIybUjvDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAMFiXuo/kDJ+bkCvppXxSHO4T15A955wnAGBKdZI6jk9YeNP
	b4WSR0XzqnsXkLEkoSGy/lnQxG9fkHyhS7uNyYGK6OrIO60/UPlTlUreOOCzQDIFWAO1LXw3RDT
	ExxXCqkg+NsUl88hA/gzfFwYyCP5VQoAwBAIuYkQP/N+jhChGsY7pnh0UfQ==
X-Gm-Gg: ASbGncusB+eQLRfu4Ibo1DqxEKy9qZ7400mOdwinjHpe5h83enxZRPyP1nVopMVocsV
	p1T39i/9gZghGdjThFo7GfMBAYjRGuML8KCDVW7pyMOxi25pF4c1J27LvJ7/zKwcufxXPhaMYXL
	6J2yA0Bwp4iVvyj3MPeQ+BKxGdfbn1dvytKVIHgZxl7sM6PNYdx0z6E8B4f1d5ZIci6dXZsHHSV
	fx+VlBBFwriaIQ+e2jSvJ4qHi1/Zlo6P8Cp8vo+75NwGVYTtcL5TjSQeIkAlMinEO6JgVvgY9rU
	zidp+2D+eEhuLCdFN/oJEVhf+ykq0DbIFZI6SRIRul3zYFhgPnZ8wY5XBM9tMeAN+jgw
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-42704dce7bdmr12202121f8f.54.1761052528656;
        Tue, 21 Oct 2025 06:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtT4dHlzzmepxbEEmjHJkJHD2FwCKCqSVsiJy1urptxBGYwBKtZyQJidvDZgwFYhtUThLA/A==
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-42704dce7bdmr12202091f8f.54.1761052528186;
        Tue, 21 Oct 2025 06:15:28 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm164559345e9.8.2025.10.21.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:15:27 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:15:24 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aPeHbKES6yHkh5Rj@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box>
 <aPdU93e2RQy5MHQr@fedora>
 <28156189.1r3eYUQgxm@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28156189.1r3eYUQgxm@fedora.fritz.box>

On Tue, Oct 21, 2025 at 02:08:35PM +0200, Francesco Valla wrote:
> On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > > > Hello Mikhail, Harald,
> > > > > > > 
> > > > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > > > 
> > > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > > 
> > > > > > > [...]
> > > > > > > > +
> > > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > > > +{
> > > > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > > > +	struct net_device_stats *stats;
> > > > > > > > +	unsigned long flags;
> > > > > > > > +	unsigned int len;
> > > > > > > > +	u8 result;
> > > > > > > > +
> > > > > > > > +	stats = &dev->stats;
> > > > > > > > +
> > > > > > > > +	/* Protect list and virtio queue operations */
> > > > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > > +
> > > > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > > > +	if (!can_tx_msg) {
> > > > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > > > +		return 0; /* No more data */
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > > > +	} else {
> > > > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > > > +		 * layer to an end.
> > > > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > > > +		 */
> > > > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > > > 
> > > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > > > 
> > > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > > > a problem in the rx path and this is the tx path. I think the comment
> > > > > > refers to improving the way the driver informs this error to the user
> > > > > > but I may be wrong.
> > > > > > 
> > > > > 
> > > > > Since we have no detail of what went wrong here, I suggested
> > > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > > > more appropriate.
> > > > > 
> > > > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > > > enough, as the application sending the message(s) would not be able to detect
> > > > > the error.
> > > > > 
> > > > > 
> > > > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > > > is misleading.
> > > > > > > 
> > > > > > 
> > > > > > I'll remove the counters below.
> > > > > > 
> > > > > 
> > > > > We don't really know what's wrong here - the packet might have been sent and
> > > > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > > > reference implementation from the original authors [1]). Echoing the packet
> > > > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > > > counters feels wrong, but maybe someone more expert than me can advise better
> > > > > here.
> > > > > 
> > > > > 
> > > > 
> > > > I agree. IIUC, in case there has been a problem during transmission, I
> > > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > > > stats. Is this correct?
> > > > 
> > > > Matias
> > > > 
> > > > 
> > > 
> > > That's my understanding too! stats->tx_dropped should be the right value to
> > > increment (see for example [1]).
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> > > 
> > 
> > I think the counter to increment would be stats->tx_errors in this case ...
> > 
> 
> I don't fully agree. tx_errors is for CAN frames that got transmitted but then
> lead to an error (e.g.: no ACK), while here we might be dealing with frames
> that didn't even manage to reach the transmission queue [1].
> 
Let's use tx_dropped then, I honestly do not have an strong opinion
about it. We can change that later if we are not happy.

Matias


