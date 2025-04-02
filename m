Return-Path: <netdev+bounces-178803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13A4A78FAF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939781889693
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9D23A562;
	Wed,  2 Apr 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTB1G5Sp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F590238152
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600388; cv=none; b=eRl+o54GdfznF5zuIJg3HYNkUuN9O1cb/hxxpKJ0lPNPVnCH1jcQ4C5w1G2tFBQkJrBva0TXHLdRYQkt+QY3e0gu6ZaUY5susHHXy6xYXJV0YI/svbf7h/LyzMSzprdyjK5dfEMyYjS6vKF2/18Ky+JR3eLziWFr1pKFktHLx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600388; c=relaxed/simple;
	bh=y7aDu52OtjP82L/t8qz2xzSOvpOmNkeVv0GRqHlG5Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSnX2KVbKBdJ71wz5ztemN0TSlEU1JQ4WEI73hRDJJnCXBX/KnO63d+jwmv6Ghy9XJtJWuyeXVzlqfyiYGmdL3yGkgPcUZEH5/JxdF8wuk18amqEbZqjWcJlit0QT9w6dVNARtZoHGvYyc6A75MsqcVuxVovhBejB51IjpziKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTB1G5Sp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743600385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6110eyhDOYjIRZ5MJbmf8dHwQ9jqIHg+d8375Mf4B3A=;
	b=TTB1G5Sp3cB3vlh9ypJem9K8UQo87FAAB5GPc4ePAXktUQsRoRkiE+DP3j0DzGaJaaLv9T
	gvyeII1M4LSB42NF/tmJaH+lqaIOnOVf7KJnhQuuPll2Tlv0CO84kf9Eq6XyjoU2H6l2cV
	fLiCco0pHdOVtFIAGg2eGqqio2dBsmQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-MKRi5V1JPMO-SnULTjScpg-1; Wed, 02 Apr 2025 09:26:24 -0400
X-MC-Unique: MKRi5V1JPMO-SnULTjScpg-1
X-Mimecast-MFC-AGG-ID: MKRi5V1JPMO-SnULTjScpg_1743600383
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f97d115so464917f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743600383; x=1744205183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6110eyhDOYjIRZ5MJbmf8dHwQ9jqIHg+d8375Mf4B3A=;
        b=FOVBLfx8eYEZOcqmp/kTKIpQY+On7ar20B1REUJKMcD0+Ol68RUY7X2PycoZfuzsU3
         EBR4T6v2Vlj4DmANpXoNjp93Rf9fbCoruJIynIKIDIefOodZEiP9hQ+sksX7F2jKB9pV
         RvEjlPi2dd9RZG4VJ0NPRKwGzRvclP0qWEQxo+GXozSTwx0vtjlcj205u6N2lnoik6L+
         m1hbPMziHWRrufr161KKLCTLWFlQoZMn3WMI4Lr2eRakVHI5FYQ6aRldg9yavhXSYH4i
         Rf+FoWmtzrhivUNSAF2bIJqYUJHhUP/ao3oxcSMeyvEK70ZPsXTOUOQ3W1jAWe2xLvMo
         oiFg==
X-Gm-Message-State: AOJu0YyvJ3rtDtqufDUarlWVFP1CiWM3Wg2QHtI+3YXUuI6iPAyMQNL3
	4myQ+A0/HdvU/jGL21yaPJgo/Y98DCF67hfkE3gLs/eb4R5b4mMdWwG2I8OKbkZxT/kuhcrV4Iy
	zxoFiGQJq0tnVBdl0j4l80D5G5MtybouLANTfxUrfHGAKAH5Tzk0OMw==
X-Gm-Gg: ASbGnct23XI9XK2bE/c3Zk+nSGl6nq41306T3cozoMscPLBPUhaxeFowiSThtkC414X
	l4h6DKW33OtpPjaCc6+lXuOOBN3nzfNjNAfRO6F03EhQ81knBqCjor3OKRhhraJC0FFRjlE+jQT
	jlBs+0KFPAnGv7WcxBjSt1MEvVQn8Q1plH+z0hEr9EQrZzx4aFzNf+riLekliyEKhF79jrn+Mvc
	3uM0waZcPOENJr3l0dWVpZZ3EMwpb/ccAJZ/QhjrKd+SCh8ZMVXYA1hwDt38hNw5rlqyInL7SE5
	7vixOu+sg3R5+vjNq2OZmFJ1keC+EIioq0jQKsA1SFAAriPjruAFSB4YpeQ=
X-Received: by 2002:a05:6000:22c6:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39c2a677e96mr1839708f8f.15.1743600383063;
        Wed, 02 Apr 2025 06:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW+mpa2QDuIfLk4f0y2/+06+UXRGWFHMhO1XRJbckZ1MK2jGpB/+Qi23vZe6cIC+p2ME0POw==
X-Received: by 2002:a05:6000:22c6:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39c2a677e96mr1839679f8f.15.1743600382569;
        Wed, 02 Apr 2025 06:26:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658c87sm17171730f8f.9.2025.04.02.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:26:21 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:26:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <horms@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Asias He <asias@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <cumaux64rfyptgzo2ccvp55l5ha2g75z3kptdwbgwgjek6654x@dbavqjiinal3>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402092605.GJ214849@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250402092605.GJ214849@horms.kernel.org>

On Wed, Apr 02, 2025 at 10:26:05AM +0100, Simon Horman wrote:
>On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
>> Ever since the introduction of the virtio vsock driver, it included
>> pushback logic that blocks it from taking any new RX packets until the
>> TX queue backlog becomes shallower than the virtqueue size.
>>
>> This logic works fine when you connect a user space application on the
>> hypervisor with a virtio-vsock target, because the guest will stop
>> receiving data until the host pulled all outstanding data from the VM.
>>
>> With Nitro Enclaves however, we connect 2 VMs directly via vsock:
>>
>>   Parent      Enclave
>>
>>     RX -------- TX
>>     TX -------- RX
>>
>> This means we now have 2 virtio-vsock backends that both have the pushback
>> logic. If the parent's TX queue runs full at the same time as the
>> Enclave's, both virtio-vsock drivers fall into the pushback path and
>> no longer accept RX traffic. However, that RX traffic is TX traffic on
>> the other side which blocks that driver from making any forward
>> progress. We're now in a deadlock.
>>
>> To resolve this, let's remove that pushback logic altogether and rely on
>> higher levels (like credits) to ensure we do not consume unbounded
>> memory.
>>
>> RX and TX queues share the same work queue. To prevent starvation of TX
>> by an RX flood and vice versa now that the pushback logic is gone, let's
>> deliberately reschedule RX and TX work after a fixed threshold (256) of
>> packets to process.
>>
>> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 70 +++++++++-----------------------
>>  1 file changed, 19 insertions(+), 51 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>
>...
>
>> @@ -158,7 +162,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, send_pkt_work);
>>  	struct virtqueue *vq;
>>  	bool added = false;
>> -	bool restart_rx = false;
>> +	int pkts = 0;
>>
>>  	mutex_lock(&vsock->tx_lock);
>>
>> @@ -172,6 +176,12 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  		bool reply;
>>  		int ret;
>>
>> +		if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
>> +			/* Allow other works on the same queue to run */
>> +			queue_work(virtio_vsock_workqueue, work);
>> +			break;
>> +		}
>> +
>>  		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>>  		if (!skb)
>>  			break;
>
>Hi Alexander,
>
>The next non-blank line of code looks like this:
>
>		reply = virtio_vsock_skb_reply(skb);
>
>But with this patch reply is assigned but otherwise unused.

Thanks for the report!

>So perhaps the line above, and the declaration of reply, can be removed?

@Alex: yes, please remove it.

A part of that the rest LGTM!

I've been running some tests for a while and everything seems okay.

I guess we can do something similar also in vhost-vsock, where we 
already have "vhost weight" support. IIUC it was added later by commit 
e79b431fb901 ("vhost: vsock: add weight support"), but we never removed 
"queued_replies" stuff, that IMO after that commit is pretty much 
useless.

I'm not asking to that in this series, if you don't have time I can do 
it separately ;-)

Thanks,
Stefano

>
>Flagged by W=1 builds.
>
>> @@ -184,17 +194,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  			break;
>>  		}
>>
>> -		if (reply) {
>> -			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>> -			int val;
>> -
>> -			val = atomic_dec_return(&vsock->queued_replies);
>> -
>> -			/* Do we now have resources to resume rx processing? */
>> -			if (val + 1 == virtqueue_get_vring_size(rx_vq))
>> -				restart_rx = true;
>> -		}
>> -
>>  		added = true;
>>  	}
>>
>> @@ -203,9 +202,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>
>>  out:
>>  	mutex_unlock(&vsock->tx_lock);
>> -
>> -	if (restart_rx)
>> -		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>>  }
>>
>>  /* Caller need to hold RCU for vsock.
>
>...
>


