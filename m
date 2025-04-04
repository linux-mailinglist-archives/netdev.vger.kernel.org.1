Return-Path: <netdev+bounces-179252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C8A7B905
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773303B79F3
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3019CC28;
	Fri,  4 Apr 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McSve8l1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83E19994F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755866; cv=none; b=hFXJnAGcaXpniVtclD8v0INQnQsoqDg8XY6qGQR1sbRuMYIhgdZMPBHuxfsVOIedAOxRqXc+jot+eQhfl++HyrT3JXOT79t7HgUAf48zJ52K4C7NvwzO0Wd79kjwV0yFXsqz4q+0cda4A6FyjYaAU4deb4PcHbjYc5454XhGZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755866; c=relaxed/simple;
	bh=QAhyu4E7HQ19zzaz86rUGI9nPrmZDX3iMt2qJViTveA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXrqctbXOqDJr1wEeO7o3K8CedISjcP8QypVY3jwMo6TapBYqIDFpuSLJ4iGpYifs1IOx3lKNx9Rv/4/AeP4DkgUXA0evqBbqmUhOt1OR0qwcW/Dm4yNUsCMl4mxGCiU6ux3qRsJYu+UdsiSYd9xkQLwYgFnAgBWpo4roPr1JCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McSve8l1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OI1Zt3NFcFi/P6TNraRk0oZkTYZ+LV6TSig6Xx970e4=;
	b=McSve8l1yAtjAIJGkbT24GjnRJmi/TAnGmIC45h82EM7zuGHzwa2EM3+CvZ84RKxCLfydX
	/7zg7w7M+KUPLqEn/cN5WTPGEes5tQX3n9I0Q+O6vyFlxJJEzwcUWL7Kp4sHMKrevD23Js
	4E9iHYD0O0ek6pMIYC+71OglSxIkK5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Qxd6mnnmPTeZKY8-B9ADKw-1; Fri, 04 Apr 2025 04:37:41 -0400
X-MC-Unique: Qxd6mnnmPTeZKY8-B9ADKw-1
X-Mimecast-MFC-AGG-ID: Qxd6mnnmPTeZKY8-B9ADKw_1743755861
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c30f26e31so1137657f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 01:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755860; x=1744360660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI1Zt3NFcFi/P6TNraRk0oZkTYZ+LV6TSig6Xx970e4=;
        b=XBMioMgYiggEdC27mjYPZydz8A2qXPR2DKLXvZsMv5NytWVqqYZNEuqHcuHsZyRWRF
         Jnqm+LmlpmKKDlj69eo7/rbzmxST8dB5OzINeY1Rto1UDqVBhhup9LV34j5qi4TC0KwU
         IuTVqPuLSEpHwuYus22dA/6NVqtVaZ5iZZO0P5H8+DrMQigTSSu3JCx3XbtY4wEdNdsz
         boD8BNku4HkfCdPoOD/M4g7Pya5f4kEnXmnhcvk8EZXbDp2lNYweHNitnWl0vdS0BAR+
         SYMuDvhZXJO77fnx/J6gKNcx5LIla6d7K4an1K5g4iZmA/C0FU7grkb4sBKWGKwvTgyS
         EYqw==
X-Forwarded-Encrypted: i=1; AJvYcCVj8PVvoWkuZldxaYV/Fh6daMmRjUKMnpjrFJ92bHdrW+AVRqy0I4btjCR73Qbt2l+EZuCQwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVjshgZO5iGIU6e5E4LS8rSLZKH6lGqpeq0zASxwrkxuzuXjN
	hZKz7PO2Vm6Ml8rgkVUXo6Php8s7N9LJTikyQA9etF4yMUu99Ic8xBKlrff4jY060PIvjEydSRe
	vJSVY30Z5SFYK5CxTJOvGneRjd24GygLaCjnaCACNAHEvF0PDGXRvig==
X-Gm-Gg: ASbGnctNxjVn826z/DoRXU7vYVbvajcZos9BlXh9hG4zJ8PTP5YpyxALQOELYPDvNCT
	3mz9fjsHoILpgXhiT/KqC4zI2lJY5uqfUi4PwuPQ3qZx0BXDuJTL3siwus1wM5FlAFBffJAw2ik
	UyNRQMH8ymZoQb64c0iH2Mq8NDbCsic3LIUvQ9D8QvnelZNcpjDyw3LiEQ6VtW3k8ZxDouP6mkt
	8q4DR6s49ysDmKFSf41bkjhfefENE4hkxRd8b6Er1gyI70ZhyW18dMdGTvN99zpk42LW9S9q4k1
	WHOwrhc0Kw==
X-Received: by 2002:a05:6000:430c:b0:391:2e31:c7e5 with SMTP id ffacd0b85a97d-39cb36b2ab2mr2013770f8f.6.1743755860545;
        Fri, 04 Apr 2025 01:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeh87271OU/aKTaskLblwGps7bO+cJZTClXWXzF8apC0wBecu3MvRM0wP/QWFDltqL8vhYdA==
X-Received: by 2002:a05:6000:430c:b0:391:2e31:c7e5 with SMTP id ffacd0b85a97d-39cb36b2ab2mr2013743f8f.6.1743755860159;
        Fri, 04 Apr 2025 01:37:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7225sm3768866f8f.26.2025.04.04.01.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:37:39 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:37:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <20250404043326-mutt-send-email-mst@kernel.org>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402161424.GA305204@fedora>
 <20250403073111-mutt-send-email-mst@kernel.org>
 <32ca5221-5b25-4bfd-acd7-9eebae8c3635@amazon.com>
 <20250404041050-mutt-send-email-mst@kernel.org>
 <fiyxlnv7gglcfkr7ue4tiaktqjptdkr5or6skrr6f7dof26d56@wmg3zhhqlcoj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fiyxlnv7gglcfkr7ue4tiaktqjptdkr5or6skrr6f7dof26d56@wmg3zhhqlcoj>

On Fri, Apr 04, 2025 at 10:30:43AM +0200, Stefano Garzarella wrote:
> On Fri, Apr 04, 2025 at 04:14:51AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Apr 04, 2025 at 10:04:38AM +0200, Alexander Graf wrote:
> > > 
> > > On 03.04.25 14:21, Michael S. Tsirkin wrote:
> > > > On Wed, Apr 02, 2025 at 12:14:24PM -0400, Stefan Hajnoczi wrote:
> > > > > On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
> > > > > > Ever since the introduction of the virtio vsock driver, it included
> > > > > > pushback logic that blocks it from taking any new RX packets until the
> > > > > > TX queue backlog becomes shallower than the virtqueue size.
> > > > > >
> > > > > > This logic works fine when you connect a user space application on the
> > > > > > hypervisor with a virtio-vsock target, because the guest will stop
> > > > > > receiving data until the host pulled all outstanding data from the VM.
> > > > > >
> > > > > > With Nitro Enclaves however, we connect 2 VMs directly via vsock:
> > > > > >
> > > > > >    Parent      Enclave
> > > > > >
> > > > > >      RX -------- TX
> > > > > >      TX -------- RX
> > > > > >
> > > > > > This means we now have 2 virtio-vsock backends that both have the pushback
> > > > > > logic. If the parent's TX queue runs full at the same time as the
> > > > > > Enclave's, both virtio-vsock drivers fall into the pushback path and
> > > > > > no longer accept RX traffic. However, that RX traffic is TX traffic on
> > > > > > the other side which blocks that driver from making any forward
> > > > > > progress. We're now in a deadlock.
> > > > > >
> > > > > > To resolve this, let's remove that pushback logic altogether and rely on
> > > > > > higher levels (like credits) to ensure we do not consume unbounded
> > > > > > memory.
> > > > > The reason for queued_replies is that rx packet processing may emit tx
> > > > > packets. Therefore tx virtqueue space is required in order to process
> > > > > the rx virtqueue.
> > > > >
> > > > > queued_replies puts a bound on the amount of tx packets that can be
> > > > > queued in memory so the other side cannot consume unlimited memory. Once
> > > > > that bound has been reached, rx processing stops until the other side
> > > > > frees up tx virtqueue space.
> > > > >
> > > > > It's been a while since I looked at this problem, so I don't have a
> > > > > solution ready. In fact, last time I thought about it I wondered if the
> > > > > design of virtio-vsock fundamentally suffers from deadlocks.
> > > > >
> > > > > I don't think removing queued_replies is possible without a replacement
> > > > > for the bounded memory and virtqueue exhaustion issue though. Credits
> > > > > are not a solution - they are about socket buffer space, not about
> > > > > virtqueue space, which includes control packets that are not accounted
> > > > > by socket buffer space.
> > > >
> > > > Hmm.
> > > > Actually, let's think which packets require a response.
> > > >
> > > > VIRTIO_VSOCK_OP_REQUEST
> > > > VIRTIO_VSOCK_OP_SHUTDOWN
> > > > VIRTIO_VSOCK_OP_CREDIT_REQUEST
> > > >
> > > >
> > > > the response to these always reports a state of an existing socket.
> > > > and, only one type of response is relevant for each socket.
> > > >
> > > > So here's my suggestion:
> > > > stop queueing replies on the vsock device, instead,
> > > > simply store the response on the socket, and create a list of sockets
> > > > that have replies to be transmitted
> > > >
> > > >
> > > > WDYT?
> > > 
> > > 
> > > Wouldn't that create the same problem again? The socket will eventually push
> > > back any new data that it can take because its FIFO is full. At that point,
> > > the "other side" could still have a queue full of requests on exactly that
> > > socket that need to get processed. We can now not pull those packets off the
> > > virtio queue, because we can not enqueue responses.
> > 
> > Either I don't understand what you wrote or I did not explain myself
> > clearly.
> 
> I didn't fully understand either, but with this last message of yours it's
> clear to me and I like the idea!
> 
> > 
> > In this idea there needs to be a single response enqueued
> > like this in the socket, because, no more than one ever needs to
> > be outstanding per socket.
> > 
> > For example, until VIRTIO_VSOCK_OP_REQUEST
> > is responded to, the socket is not active and does not need to
> > send anything.
> 
> One case I see is responding when we don't have the socket listening (e.g.
> the port is not open), so if before the user had a message that the port was
> not open, now instead connect() will timeout. So we could respond if we have
> space in the virtqueue, otherwise discard it without losing any important
> information or guarantee of a lossless channel.
> 
> So in summary:
> 
> - if we have an associated socket, then always respond (possibly
>   allocating memory in the intermediate queue if the virtqueue is full
>   as we already do). We need to figure out if a flood of
>   VIRTIO_VSOCK_OP_CREDIT_REQUEST would cause problems, but we can always
>   decide not to respond if we have sent this identical information
>   before.

If taking this path, need to consider not responding is within spec or not.
But again, credit update needed is just a single flag we need to set
on a socket. If we have anything we need to send, it can also update
the credits.


> - if there is no associated socket, we only respond if virtqueue has
>   space.
> 
> I like it and it seems feasible without changing anything in the
> specification.
> 
> Did I get it right?
> 
> Thanks,
> Stefano

That was the idea, yes.

-- 
MST


