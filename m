Return-Path: <netdev+bounces-111086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0092FD0B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5DC1C20DEC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1D173332;
	Fri, 12 Jul 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acaJJvBi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A47172BBA
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796311; cv=none; b=ehq+p5mlk4oWmjmL46HR5mDhsef4PsyKLKBXw53Cuy8R8BOV93qoGeMrnjnuAnA0Pi7z8Xr2KLqlf0e8qtHlSAkqMBlCa/B+Y0AtyS/fuEWT2DXcn4TQqK4pAt+ym8W6FD9DfZ2hP6zmaJ0ED/3758gqmfUWSU1/ee70lTsrDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796311; c=relaxed/simple;
	bh=QAQL9WA5yryImtMgoZke+4Qk2yO3SJugkz5uM/GF3iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHmLZ0h6kukiA6t/8LM7T6EcG+lYmIoeo49jFPf5an1gNzzn1R1G1mi3Y0WTeVpoF/cKiit7feNJzZfXBLBYjQNHqy6Od33EgTq4obba9CadzDC1YtUKsyJdUUYoIOaLbj01SgAEf61S0kZZfW7lhZJJxIbxlxM4vJ9jj59yFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acaJJvBi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720796309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooUnRT5bFlp/EtV77Ea4i/3nkK3DE6nGkAg+V4vLiBc=;
	b=acaJJvBilCyS74v14rhvcKM67xDhwMDjEKBFf7WU7q5Y3ak1CFpVXbqrLhQpA5GGXXQr9x
	PWJGOGflVVSJ/EgtH9+/BtutLT1wigj6FRtscyPsYY3rx65YqIXxzZy6s2iP6StjpeKAIv
	3TU/gP84NIdWLfxw5BeMBeat3RrlwSM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-TST7cP6OOW6V7ptuvi0ueA-1; Fri, 12 Jul 2024 10:58:25 -0400
X-MC-Unique: TST7cP6OOW6V7ptuvi0ueA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77e044ff17so160369966b.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 07:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796305; x=1721401105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooUnRT5bFlp/EtV77Ea4i/3nkK3DE6nGkAg+V4vLiBc=;
        b=L5eHobaamPgs0awG42HgA/9HEKNNNNt1EY54ZElcVraWOVzMY/eYLupax/2wFG2EGC
         58TXxKJaBBOzgs4CamJvtCvEp5ZpTy0ToXnH6JIi/xXojBMEQ1DwYs/m6Q7hemOXHDnI
         NE141FVjp905FHz6a1+GNc/7LzWFnrWCcRPe/M/1v4oaffKwmWyscVWTDdsHMbb/2sSR
         PfxoGY/783rFbqNglui+ktTdbk9RHMb06aMuNUe7G0ZHYcqbFDVLKz4NyrbHJTSggb3G
         lkrt+G3fe0j4RuAbmc/G6wZb391+lj+oMpWokJzuqZ7mDRdaU9l6fioWwtlZll5Uc85g
         skyw==
X-Forwarded-Encrypted: i=1; AJvYcCXXRAAeXL6Mz7vd8FCzhF+dVTgzqAIWbBKf5WA13IXphVKn3v0L7IHfP7lKYUtbuhgMYYyfzl0wDCMRAa3BnQmZG58VcwTA
X-Gm-Message-State: AOJu0YwItHX+sXvtVHeOx/PqgYNs9xxH2GDQPkGrWTAlVPro1Xh82zpS
	D6AhVo1BlKzVH+F5tJdnpIYvEN8GsjyCCCW63Mjx4KTDci4V8xM3iJ54QfnarWnKyUKtfHEGRA1
	k/ENBKRChraCMdk+PWaagOvkhN4EcClEwNzN28dRE65D79mg25iWejA==
X-Received: by 2002:a17:907:7808:b0:a6f:b67d:959e with SMTP id a640c23a62f3a-a780b87f058mr736690066b.53.1720796304771;
        Fri, 12 Jul 2024 07:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnyf7vZp/+lmun6GiXaP7igj1JGgPEpX7RNNIRIT8jvy/pkdTitkWwVEFBx3utcpdug494jA==
X-Received: by 2002:a17:907:7808:b0:a6f:b67d:959e with SMTP id a640c23a62f3a-a780b87f058mr736688666b.53.1720796304159;
        Fri, 12 Jul 2024 07:58:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff24esm352434366b.131.2024.07.12.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:58:23 -0700 (PDT)
Date: Fri, 12 Jul 2024 16:58:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] vsock/virtio: avoid queuing packets when
 work queue is empty
Message-ID: <4ou6pj632vwst652fcnfiz4hklncc6g4djel5byabdb3hpyap2@ebxpk7ovewv3>
References: <20240711-pinna-v3-0-697d4164fe80@outlook.com>
 <20240711-pinna-v3-2-697d4164fe80@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240711-pinna-v3-2-697d4164fe80@outlook.com>

On Thu, Jul 11, 2024 at 04:58:47PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Introduce an optimization in virtio_transport_send_pkt:
>when the work queue (send_pkt_queue) is empty the packet is

Note: send_pkt_queue is just a queue of sk_buff, is not really a work 
queue.

>put directly in the virtqueue increasing the throughput.

Why?

I'd write something like this, but feel free to change it:

When the driver needs to send new packets to the device, it always
queues the new sk_buffs into an intermediate queue (send_pkt_queue)
and schedules a worker (send_pkt_work) to then queue them into the
virtqueue exposed to the device.

This increases the chance of batching, but also introduces a lot of
latency into the communication. So we can optimize this path by
adding a fast path to be taken when there is no element in the
intermediate queue, there is space available in the virtqueue,
and no other process that is sending packets (tx_lock held).


>
>In the following benchmark (pingpong mode) the host sends

"fio benchmark"

>a payload to the guest and waits for the same payload back.
>
>All vCPUs pinned individually to pCPUs.
>vhost process pinned to a pCPU
>fio process pinned both inside the host and the guest system.
>
>Host CPU: Intel i7-10700KF CPU @ 3.80GHz
>Tool: Fio version 3.37-56
>Env: Phys host + L1 Guest
>Runtime-per-test: 50s
>Mode: pingpong (h-g-h)
>Test runs: 50
>Type: SOCK_STREAM
>
>Before: Linux 6.9.7
>
>Payload 512B:
>
>	1st perc.	overall		99th perc.
>Before	370		810.15		8656		ns
>After	374		780.29		8741		ns
>
>Payload 4K:
>
>	1st perc.	overall		99th perc.
>Before	460		1720.23		42752		ns
>After	460		1520.84		36096		ns
>
>The performance improvement is related to this optimization,
>I used ebpf to check that each packet was sent directly to the
>virtqueue.
>
>Throughput: iperf-vsock

I would reorganize the description for a moment because it's a little 
confusing. For example like this:

The following benchmarks were run to check improvements in latency and 
throughput. The test bed is a host with Intel i7-10700KF CPU @ 3.80GHz 
and L1 guest running on QEMU/KVM.

- Latency
   Tool: ...

- Throughput
   Tool: ...

>The size represents the buffer length (-l) to read/write
>P represents the number parallel streams
>
>P=1
>	4K	64K	128K
>Before	6.87	29.3	29.5 Gb/s
>After	10.5	39.4	39.9 Gb/s
>
>P=2
>	4K	64K	128K
>Before	10.5	32.8	33.2 Gb/s
>After	17.8	47.7	48.5 Gb/s
>
>P=4
>	4K	64K	128K
>Before	12.7	33.6	34.2 Gb/s
>After	16.9	48.1	50.5 Gb/s

Wow, great! I'm a little surprised that the latency is not much 
affected, but the throughput benefits so much with that kind of 
optimization.

Maybe we can check the latency with smaller payloads like 64 bytes or 
even smaller.

>
>Co-developed-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> net/vmw_vsock/virtio_transport.c | 38 ++++++++++++++++++++++++++++++++++----
> 1 file changed, 34 insertions(+), 4 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index c4205c22f40b..d75727fdc35f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -208,6 +208,29 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+/* Caller need to hold RCU for vsock.
>+ * Returns 0 if the packet is successfully put on the vq.
>+ */
>+static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struct sk_buff *skb)
>+{
>+	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>+	int ret;
>+
>+	/* Inside RCU, can't sleep! */
>+	ret = mutex_trylock(&vsock->tx_lock);
>+	if (unlikely(ret == 0))
>+		return -EBUSY;
>+
>+	ret = virtio_transport_send_skb(skb, vq, vsock);
>+
>+	mutex_unlock(&vsock->tx_lock);
>+
>+	/* Kick if virtio_transport_send_skb succeeded */

Superfluous comment, we can remove it.

>+	if (ret == 0)
>+		virtqueue_kick(vq);

nit: I'd add a blank line here after the if block to highlight that the 
return is out.

>+	return ret;
>+}
>+
> static int
> virtio_transport_send_pkt(struct sk_buff *skb)
> {
>@@ -231,11 +254,18 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 		goto out_rcu;
> 	}
>
>-	if (virtio_vsock_skb_reply(skb))
>-		atomic_inc(&vsock->queued_replies);
>+	/* If the workqueue (send_pkt_queue) is empty there is no need to enqueue the packet.

Again, send_pkt_queue is not a workqueue.

Here I would explain more why there is no need, the fact that we are not 
doing this is clear.

>+	 * Just put it on the virtqueue using virtio_transport_send_skb_fast_path.
>+	 */
>

nit: here I would instead remove the blank line to make it clear that 
the comment is about the code below.

>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
>+	    virtio_transport_send_skb_fast_path(vsock, skb)) {
>+		/* Packet must be queued */

Please, include it in the comment before the if where you can explain 
the whole logic of the optimization.

>+		if (virtio_vsock_skb_reply(skb))
>+			atomic_inc(&vsock->queued_replies);

nit: blank line, how it was before this patch:

	if (virtio_vsock_skb_reply(skb))
		atomic_inc(&vsock->queued_replies);

	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);


>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>
>-- 
>2.45.2
>
>

I tested the patch and everything seems to be fine, all my comments are 
minor and style, the code should be fine!

Thanks,
Stefano


