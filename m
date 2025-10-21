Return-Path: <netdev+bounces-231131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98BBF58E8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4904FF6D1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4B2F6933;
	Tue, 21 Oct 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en0ww0HG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08B2EA47C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039618; cv=none; b=Yz3YIYCJ9T/qVKSTG3fEky/WdnRSCnuT/mOh40+gdaKI0QyQeGUIM9s7kY60kh9pLryP/AuiePywSpwGIah1/5bX+Gj50PpYstUQdyiJKyB6lGlCZcbM6ZCSzov8OqWIJdGzZF+MU+AZnFnoH8qWojtXcRXk5IMUNAYgD0Tzmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039618; c=relaxed/simple;
	bh=joioCTHNcicHEl18wOj/vKbeHGh0dtHXxJrEocOCvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4v5EGdvagdX2gPsDeJaHuDtCCkkyXngg+JyIb4uOIrc0HjmBtvVmYkY7c1KqvOJcQu/wGt83ajUWLgyJV+Il1u+abw5cA/7ValW2m19CKZr4B6hXR0VA12m2YXK4qlpRFIeueK0+njbo16fpVLcHkm20lBMlVyEvmvpL5XXoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en0ww0HG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58p/SRCqJ0LAx3dnpJuwG+DdvwsYHwAoukVUv/kmb8g=;
	b=en0ww0HGHzRWkDE+pjf65xXKf52vaUYu456z5EfiTl39SOe+L6UwBQvxl6015Byg323/bf
	bnti0qInA/sIxXJRJ/0QeKJYkT10qzyg+L0KgCQ4ITCaCE5niMILHNPcwH6sm/EqTyn7L0
	f9lHP6j6Jq9k5oSapvgNLq9LaRccrXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-JAEa1pTJNAC3Yh5gR01T_g-1; Tue, 21 Oct 2025 05:40:12 -0400
X-MC-Unique: JAEa1pTJNAC3Yh5gR01T_g-1
X-Mimecast-MFC-AGG-ID: JAEa1pTJNAC3Yh5gR01T_g_1761039611
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso59897165e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039611; x=1761644411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58p/SRCqJ0LAx3dnpJuwG+DdvwsYHwAoukVUv/kmb8g=;
        b=Jb5p3awRE57ZYtZMeaewQG5q7RyInDFYKwFr0BSDEdeVljqobIyXOykm0TnEJRLjba
         dHwtgqsC/L9EOifqmVigMo3z85ie8990iOhjsViAscc5UOVFdoC/dD48j4iyMM8e5IGi
         PWitqvK9lDrubL+4xFVuGlpR0R1fgDr7hfWhJX3zMONcQydNO1OGj+fNcVeGYWms519Z
         fCZ+XVABnHarFeh873SaF9YGylO1YUqFlmLFkPI66AL5Zzy5iAkXcJsJQ9RUIrQ0XxbW
         MPgPjL/Xeocd45dqTFZPxljRs4GLTefnLYjf/2SI/RQEvSK8epjFhtEFUXtEb78qod27
         Nnfw==
X-Forwarded-Encrypted: i=1; AJvYcCUsWIWLXZZ//pjKo7lkN4fcZR9JLqO/cEHoVvya5xZbAzP+9l9A8MTz0enYqwmPsEGLrfi9KcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTy1tQW7hxiCbRmO03pdPRUgZYzJiCxMSPWOlr+r7xRasPK+eX
	TEy/d8qklP6zrb+hpI3qIKakmoogvw+hbL/ktuGErXAF2jv9rvlx6np1/BE+L8/Ixf93TBV3OI1
	aCi0A6uvPBqBEHd3/GbsrxSZ5QnYSOMWv14XhAlZQEZzRJkPv1ibxEUIx0Q==
X-Gm-Gg: ASbGncvOocwNzvL063jxgUiWWsbXswz8tYwl3w+tMakymPKxka1BW5EqhGHHU82h/Xz
	wUEKpw6109rFYE3z1lQxyWC8/J62/xvi7k6+r5z3KpqKMgSZLRNghrmy3atw8GwdVPhhDIWHZNg
	36mMgvS4mHPfdY7y4UGRfjC6Pjy7gdm5a0eDqAOP8/STZaiPeor5YcujDTI7lOl9Y/cFqXjoehA
	+NLdhdVJYdbKnCfX4XQo2Yx/25q5znkl/8V/CVp12qEHDerbd4T0+zG03/nGR2d//H4ldA4FcsQ
	QxzAG0yBxs0QZeLwQS1j3IjV0At7zxMTghV+V4SHsRxAwrtib1pPX3yxb8Jlygcukxnx
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr115492785e9.10.1761039611095;
        Tue, 21 Oct 2025 02:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnKSW02QAXJ0oFhtSLv5TjL06FH3eXdLlv337/+4vkyG1qVajLc6qLhwPGLEda7bmT57ysBw==
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr115492395e9.10.1761039610598;
        Tue, 21 Oct 2025 02:40:10 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949dd479sm15669425e9.0.2025.10.21.02.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:40:08 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:40:07 +0200
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
Message-ID: <aPdU93e2RQy5MHQr@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <1997333.7Z3S40VBb9@fedora.fritz.box>
 <aPZNiD1SN16K7hmT@fedora>
 <27327622.1r3eYUQgxm@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27327622.1r3eYUQgxm@fedora.fritz.box>

On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > Hello Mikhail, Harald,
> > > > > 
> > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > 
> > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > 
> > > > > [...]
> > > > > > +
> > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > +{
> > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > +	struct net_device_stats *stats;
> > > > > > +	unsigned long flags;
> > > > > > +	unsigned int len;
> > > > > > +	u8 result;
> > > > > > +
> > > > > > +	stats = &dev->stats;
> > > > > > +
> > > > > > +	/* Protect list and virtio queue operations */
> > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > +
> > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > +	if (!can_tx_msg) {
> > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > +		return 0; /* No more data */
> > > > > > +	}
> > > > > > +
> > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > +	} else {
> > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > +		 * layer to an end.
> > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > +		 */
> > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > 
> > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > 
> > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > a problem in the rx path and this is the tx path. I think the comment
> > > > refers to improving the way the driver informs this error to the user
> > > > but I may be wrong.
> > > > 
> > > 
> > > Since we have no detail of what went wrong here, I suggested
> > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > more appropriate.
> > > 
> > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > enough, as the application sending the message(s) would not be able to detect
> > > the error.
> > > 
> > > 
> > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > is misleading.
> > > > > 
> > > > 
> > > > I'll remove the counters below.
> > > > 
> > > 
> > > We don't really know what's wrong here - the packet might have been sent and
> > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > reference implementation from the original authors [1]). Echoing the packet
> > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > counters feels wrong, but maybe someone more expert than me can advise better
> > > here.
> > > 
> > > 
> > 
> > I agree. IIUC, in case there has been a problem during transmission, I
> > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > stats. Is this correct?
> > 
> > Matias
> > 
> > 
> 
> That's my understanding too! stats->tx_dropped should be the right value to
> increment (see for example [1]).
> 
> [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> 

I think the counter to increment would be stats->tx_errors in this case ...

Matias


