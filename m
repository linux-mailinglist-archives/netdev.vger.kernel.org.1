Return-Path: <netdev+bounces-179247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFF5A7B89F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A1189CC2F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5441195B1A;
	Fri,  4 Apr 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaM1gGBA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC736185B48
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754501; cv=none; b=AonuAn2RU9KLCl3qon4OdUnsAhT7WRlpZ4HLW6dNWd/FvfvXzWqBKsbtIY1K4yACW10vju5u4VPalmveuY4mTpXtUU19R7xaWmmvj++3fMdBh3XX6ggegWMzxevfHEldzxi35eY6yr9K31ikS389p/YkWpdZmCNz46/B0E2YFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754501; c=relaxed/simple;
	bh=AuER94I0UTEjzFOjOSgVJU84xZwyeesTDx/OyQrBbzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ9B7FdTYikBO6cChlooRN3n1qZ8QVOdrXq5tQQfmuG7FcTTgb7VNrqnq/6+bN7xpJFSsD+kwcPOxTbGry65Vf4178KJm1iCy/WnWXsfQ8mSo3sWJxMEJR6jJ/Zmv4tiVtMecjpEaQnZ/YVv0WtyUQRaIwXwa3ol41uki145jU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaM1gGBA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743754498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6LXxwBQfr8ph0usRujiqrcsoU2uzBJal5na1Y3wac=;
	b=FaM1gGBAxiGt8PI+uuQs3rxUSSQjthJJoYVxpcTlGcpmnSXchY2vQEvoTASc5po4r6vu5t
	8KVZQo8EauYx3OxwXhrZYNqdX92lIQHGH8vSETC25qNmeAI9M8RBeYobwxpKXyGwIaAOC8
	wXyT4pKH1IHutB+1So98nqcHfDEJw+I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-1Ed5TwbbOtC7z4hjWta0uA-1; Fri, 04 Apr 2025 04:14:57 -0400
X-MC-Unique: 1Ed5TwbbOtC7z4hjWta0uA-1
X-Mimecast-MFC-AGG-ID: 1Ed5TwbbOtC7z4hjWta0uA_1743754496
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso1260648f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 01:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743754496; x=1744359296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ6LXxwBQfr8ph0usRujiqrcsoU2uzBJal5na1Y3wac=;
        b=RHTXAGMLbEi4ZtQYXyhLFCeadgNadrF0PbWojuTF3436mphhAnyRdUTJKjaW9SNKy1
         lf/SUYSb/Nifanjh/WvTLY/UTxp1gzZ35dEDwhgsJnGmPg255kVbrPDgJ4aBAIyoYGCe
         ieMO3lZyXtntt4S2jmJAH2WD1AYeh5MTJdbG1qQlolp8qSWxjEBqumsFYlHyPTfiCcxX
         yckmP9XkTifd4d+x17MPji1n3aBlIT/w3RjyjwqIo8KyXBnOSoVskI9c9ad3ZJeLsvCY
         u/14sZTsVk5EfSKk67GtqYGM7uoPo04YJ5xbOcNOJoLRuBhn70uqlnScnPXVSsTZVzfg
         3pkA==
X-Forwarded-Encrypted: i=1; AJvYcCUiES84uStnwOvBp275HxAR4dEE9/Hp5gUNwdL0Y+Ty9fA8luw9Z9eiYq8hgYTr74C/VYGOun0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISF7ZUggBze4UbxxkQHhdANrka/qkgOSiM0VZekT6eH0gBDup
	VPWXh9V35WK4YrQ9uFQtbyoYW0t6JKYmmd84Y2n3T6O5+Qav816VxSOzVIA1Z+iCfmMB/NQLWuJ
	GNHtldgKAUQJq3SBOJGVWiui1JqTB47/ilkMDM/0Cmbc6n8HlTgx8HYYR8desQA==
X-Gm-Gg: ASbGnctWJ/mmbzgx6jjEC8s55+10AwCSTslG4fU3+W8F6j3tdKRlx8FQSUpgrNi5SW4
	zmSRJdlOwbzm811L6B8VqaKcrtGyookrXD3VMDVWQBRJU9ASQgdMXGQBiZHw6BaYnKdZHr22Xcv
	vAQptGNLmJn27qqOrzYqGMCDqVB2KuFXEyiIRMs2/JYuLIOnbo2eHBQmq9HA/vkyQ3AxKcMTpQd
	5qsA1ANqUE6kW10htOTw5iVvkbW62xn3iwHtiRLUuqehIStfaBoYex/yKJThMW2858B+OK5HTvK
	3HVrnjHF9w==
X-Received: by 2002:a5d:5d13:0:b0:38d:eb33:79c2 with SMTP id ffacd0b85a97d-39cb35aed51mr1485118f8f.32.1743754495859;
        Fri, 04 Apr 2025 01:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Vj4KGL4IGFJsWlV8HmZkBJfzGwgl/hz7tDn67gaKw13cLzScEH8EztFdEVpDbeUUKsnsgA==
X-Received: by 2002:a5d:5d13:0:b0:38d:eb33:79c2 with SMTP id ffacd0b85a97d-39cb35aed51mr1485105f8f.32.1743754495425;
        Fri, 04 Apr 2025 01:14:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm3754344f8f.72.2025.04.04.01.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:14:54 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:14:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Asias He <asias@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <20250404041050-mutt-send-email-mst@kernel.org>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402161424.GA305204@fedora>
 <20250403073111-mutt-send-email-mst@kernel.org>
 <32ca5221-5b25-4bfd-acd7-9eebae8c3635@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ca5221-5b25-4bfd-acd7-9eebae8c3635@amazon.com>

On Fri, Apr 04, 2025 at 10:04:38AM +0200, Alexander Graf wrote:
> 
> On 03.04.25 14:21, Michael S. Tsirkin wrote:
> > On Wed, Apr 02, 2025 at 12:14:24PM -0400, Stefan Hajnoczi wrote:
> > > On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
> > > > Ever since the introduction of the virtio vsock driver, it included
> > > > pushback logic that blocks it from taking any new RX packets until the
> > > > TX queue backlog becomes shallower than the virtqueue size.
> > > > 
> > > > This logic works fine when you connect a user space application on the
> > > > hypervisor with a virtio-vsock target, because the guest will stop
> > > > receiving data until the host pulled all outstanding data from the VM.
> > > > 
> > > > With Nitro Enclaves however, we connect 2 VMs directly via vsock:
> > > > 
> > > >    Parent      Enclave
> > > > 
> > > >      RX -------- TX
> > > >      TX -------- RX
> > > > 
> > > > This means we now have 2 virtio-vsock backends that both have the pushback
> > > > logic. If the parent's TX queue runs full at the same time as the
> > > > Enclave's, both virtio-vsock drivers fall into the pushback path and
> > > > no longer accept RX traffic. However, that RX traffic is TX traffic on
> > > > the other side which blocks that driver from making any forward
> > > > progress. We're now in a deadlock.
> > > > 
> > > > To resolve this, let's remove that pushback logic altogether and rely on
> > > > higher levels (like credits) to ensure we do not consume unbounded
> > > > memory.
> > > The reason for queued_replies is that rx packet processing may emit tx
> > > packets. Therefore tx virtqueue space is required in order to process
> > > the rx virtqueue.
> > > 
> > > queued_replies puts a bound on the amount of tx packets that can be
> > > queued in memory so the other side cannot consume unlimited memory. Once
> > > that bound has been reached, rx processing stops until the other side
> > > frees up tx virtqueue space.
> > > 
> > > It's been a while since I looked at this problem, so I don't have a
> > > solution ready. In fact, last time I thought about it I wondered if the
> > > design of virtio-vsock fundamentally suffers from deadlocks.
> > > 
> > > I don't think removing queued_replies is possible without a replacement
> > > for the bounded memory and virtqueue exhaustion issue though. Credits
> > > are not a solution - they are about socket buffer space, not about
> > > virtqueue space, which includes control packets that are not accounted
> > > by socket buffer space.
> > 
> > Hmm.
> > Actually, let's think which packets require a response.
> > 
> > VIRTIO_VSOCK_OP_REQUEST
> > VIRTIO_VSOCK_OP_SHUTDOWN
> > VIRTIO_VSOCK_OP_CREDIT_REQUEST
> > 
> > 
> > the response to these always reports a state of an existing socket.
> > and, only one type of response is relevant for each socket.
> > 
> > So here's my suggestion:
> > stop queueing replies on the vsock device, instead,
> > simply store the response on the socket, and create a list of sockets
> > that have replies to be transmitted
> > 
> > 
> > WDYT?
> 
> 
> Wouldn't that create the same problem again? The socket will eventually push
> back any new data that it can take because its FIFO is full. At that point,
> the "other side" could still have a queue full of requests on exactly that
> socket that need to get processed. We can now not pull those packets off the
> virtio queue, because we can not enqueue responses.

Either I don't understand what you wrote or I did not explain myself
clearly. 

In this idea there needs to be a single response enqueued
like this in the socket, because, no more than one ever needs to
be outstanding per socket.

For example, until VIRTIO_VSOCK_OP_REQUEST
is responded to, the socket is not active and does not need to
send anything.


> 
> But that means now the one queue is blocked from making forward progress,
> because we are applying back pressure. And that means everything can grind
> to a halt and we have the same deadlock this patch is trying to fix.
> 
> I don't see how we can possibly guarantee a lossless data channel over a
> tiny wire (single, fixed size, in order virtio ring) while also guaranteeing
> bounded memory usage. One of the constraints need to go: Either we are no
> longer lossless or we effectively allow unbounded memory usage.
> 
> 
> Alex


