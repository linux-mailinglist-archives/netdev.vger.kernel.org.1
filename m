Return-Path: <netdev+bounces-103639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE064908D9E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6598628E570
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568C107B6;
	Fri, 14 Jun 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFdwplrC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2C10A0D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375885; cv=none; b=uB4FNsh2j+RQMz+5zKSVSkgX/JGWtAcscAIbltpj/u/IBDhMEFCNak03IF585UIurFj+6QkBr8p6nB/mrgpkkJePZPtL5YIT+D0fivmVt/PxDmZr0k0xD0rFAquVNSAGKtaYoyNUeZISg8R+q2cqJ2yAKrxlj/H0MfVm+jM/44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375885; c=relaxed/simple;
	bh=zRcSTM/jhvBjnbHtwwSwnO+RyKYuFmGLajopZybpesk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od28itr1Hduh6DS81X1gYLXXl9xH3k1GGZU61vdkdYGGzR+RD5xpGGGbApCqCxc//Bj5gt4QSv7Hhmo6mtqqQPj9owJtItvNc3TjQYULK57qnG1pYduYM7XRGKIpc6xL9HtnSjHncNOV4J6402hAHQD6z80ODyzKPAc7wtoKNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFdwplrC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718375883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ma55eji0wwByhy1PlNAJaDlIbtX5hUNyQUsxW6m6B4Y=;
	b=FFdwplrC5r2TxQnTraRfwxiOjzz/3t2G78rBBIDydWIYNuhoQMuhUgyxY9Z/5Jvu/RuQKW
	e7kBIS5ovUAlGAvdL1NLKH6f2TAF/QJv9WxyhyBOdfsZTA48mWgx/GMajdec4HDUhdahc+
	YyU2b2P98KU3sDmpByv9PKigsu6pAPA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-7ZBwZGACP2ugDBHdC3TXlg-1; Fri, 14 Jun 2024 10:38:01 -0400
X-MC-Unique: 7ZBwZGACP2ugDBHdC3TXlg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c82e67810so1755496e87.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375875; x=1718980675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma55eji0wwByhy1PlNAJaDlIbtX5hUNyQUsxW6m6B4Y=;
        b=WbXrzVMm2Kjsff6+egme/57+G3tGqhOB/mG/KYDvB469fqoB5q2yrABji9Ufkuym/m
         oEt6dnXYgQKlzienU/Y3VRBNzRyT0EmkdrzGB8aaqUZatRbC4IP5VfNDjgE1JvsHsRgC
         LQ4eXWKtgPh5AexdJVGWsAEL9aw/bTQm5WToNZLgb2Oyyo3KGBt6NsMgvdC4s7Zs4BLX
         3A8FNhfNdPfjNbDYsOERfJoIQUGySJ8ZNP6hhxEETtuGfCaoiyZNl+zINm78wt/jEmrZ
         dB77NjNHfBP0Wtdw1KlT03zaJPpuDAeUNggC2Tfe5u1Sv9U1e35cyHr0dVSrNs7SVtDx
         uTRw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0Y9yMYAEqDLdrVNCsE4wkctVwNi9577MxeeT06dZygIEE+WHWknZfmE+rdptPGPMDPh5lRsY1a6Ie+CjcqrhlSslEH/b
X-Gm-Message-State: AOJu0YwCHOKr1Q0fxR0+Z1qSKh/Zf4pYe07PQ41q5gwXsIZhdK6UwTnu
	voqdow9jGSDvoeRqiBHT3mKBbEdBblAccxpXTU/lpf9WElb2VXB7XTkgRU8J6YumqelscQAjuUJ
	IKqKqbBPkcnwno7iDGuveU/jztrpi118WLOKjOdBfZDHh2MCRXcOHaA==
X-Received: by 2002:a05:6512:1386:b0:52c:823f:2a10 with SMTP id 2adb3069b0e04-52ca6e56edfmr2747330e87.1.1718375875239;
        Fri, 14 Jun 2024 07:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFak61X5Q4K8Fy3vqgh4FnlQ8USF63/URwCi1pVyOdl1kZeb7CjFn+k73mvZyYTw9AmJzOfKQ==
X-Received: by 2002:a05:6512:1386:b0:52c:823f:2a10 with SMTP id 2adb3069b0e04-52ca6e56edfmr2747312e87.1.1718375874854;
        Fri, 14 Jun 2024 07:37:54 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4486sm191157266b.1.2024.06.14.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:37:54 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:37:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, 
	pabeni@redhat.com, davem@davemloft.net, Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next 2/2] vsock/virtio: avoid enqueue packets when
 work queue is empty
Message-ID: <2ytwqkmnmp3ebdnhioevunpkyfe5nh2lcpitzggqeu4ptao7ry@ivxkicurl5ft>
References: <20240614135543.31515-1-luigi.leonardi@outlook.com>
 <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Fri, Jun 14, 2024 at 03:55:43PM GMT, Luigi Leonardi wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>This introduces an optimization in virtio_transport_send_pkt:
>when the work queue (send_pkt_queue) is empty the packet is
>put directly in the virtqueue reducing latency.
>
>In the following benchmark (pingpong mode) the host sends
>a payload to the guest and waits for the same payload back.
>
>Tool: Fio version 3.37-56
>Env: Phys host + L1 Guest
>Payload: 4k
>Runtime-per-test: 50s
>Mode: pingpong (h-g-h)
>Test runs: 50
>Type: SOCK_STREAM
>
>Before (Linux 6.8.11)
>------
>mean(1st percentile):     722.45 ns
>mean(overall):           1686.23 ns
>mean(99th percentile):  35379.27 ns
>
>After
>------
>mean(1st percentile):     602.62 ns
>mean(overall):           1248.83 ns
>mean(99th percentile):  17557.33 ns

Cool, thanks for this improvement!
Can you also report your host CPU detail?

>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index c930235ecaec..e89bf87282b2 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -214,7 +214,9 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr;
> 	struct virtio_vsock *vsock;
>+	bool use_worker = true;
> 	int len = skb->len;
>+	int ret = -1;

Please define ret in the block we use it. Also, we don't need to initialize it.

>
> 	hdr = virtio_vsock_hdr(skb);
>
>@@ -235,8 +237,34 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	/* If the send_pkt_queue is empty there is no need to enqueue the packet.

We should clarify which queue. I mean we are always queueing the packet
somewhere, or in the internal queue for the worker or in the virtqueue,
so this comment is not really clear.

>+	 * Just put it on the ringbuff using virtio_transport_send_skb.

ringbuff? Do you mean virtqueue?

>+	 */
>+

we can avoid this empty line.

>+	if (skb_queue_empty_lockless(&vsock->send_pkt_queue)) {
>+		bool restart_rx = false;
>+		struct virtqueue *vq;

... `int ret;` here.

>+
>+		mutex_lock(&vsock->tx_lock);
>+
>+		vq = vsock->vqs[VSOCK_VQ_TX];
>+
>+		ret = virtio_transport_send_skb(skb, vq, vsock, &restart_rx);

Ah, at the end we don't need `ret` at all.

What about just `if (!virtio_transport_send_skb())`?

>+		if (ret == 0) {
>+			use_worker = false;
>+			virtqueue_kick(vq);
>+		}
>+
>+		mutex_unlock(&vsock->tx_lock);
>+
>+		if (restart_rx)
>+			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>+	}
>+
>+	if (use_worker) {
>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>-- 
>2.45.2
>


