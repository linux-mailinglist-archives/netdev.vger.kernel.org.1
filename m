Return-Path: <netdev+bounces-81727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA788AE96
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0303229C251
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF4839FB;
	Mon, 25 Mar 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPq48287"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5A73175
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391080; cv=none; b=EVefgteQTx9tWWQRCJ67ApcP+Bbf385k6WsKtMNgZgAwZpfgdRHptd/doYB3immfP9WM8wfcfUxZvzL5RCZf8UnhY8AnNvPiPy2GgXepLD+VSivHndTEMCRYe3dfA4+FNFTt0jm3GNtKVvzNYwpxNjYKu01PN9CPXIdQa8GO7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391080; c=relaxed/simple;
	bh=1y7PY1oTFX7Axkh8dq81egggxtYVixKQqkHsEHIH+zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC1BKiQFq5sENV77jCLXtEvngihNU7LIdJdqRb1BNvbKlP9Me8g0sQvedR+2veZZcAOUv3maVj3E5E4Z62zbFcg1z0DDWQCHliViJmbn0wspq7I5arTDPbMGdXxHbakFEM19hbi6f7GI3VrqEBxlJdw4wYqB2BOew3SHXh6HtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPq48287; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711391077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8m7155r4ZtiZ6OJmssDUl1N2SECV45y4cCUPbb/2rA=;
	b=IPq482879s/e87DUaOmJy2IZg1VNwBbWCuzYF1pGxh0dAI/dChkZWXvdFq/YDoYzLbEM4m
	rQk8KOJS7gMbU5p1fmoesMatRMwt2g2Vn6nAbunJPQjTilNXyN1Fv08Gi2nk8KxVSO1r2B
	bEyi+toHGwWh9n19BTBDveoR6j7Kbdo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Oj3cNWW_MTyzQYZcOc1oTw-1; Mon, 25 Mar 2024 14:24:35 -0400
X-MC-Unique: Oj3cNWW_MTyzQYZcOc1oTw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33eca7270ccso1982897f8f.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 11:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391074; x=1711995874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8m7155r4ZtiZ6OJmssDUl1N2SECV45y4cCUPbb/2rA=;
        b=SDj0Q8QqlwMC3n6U9nrdWo8JPo97d8AiOSj6BspsPNW24p0wzPnGdRitZULXkOjAS4
         Rz6eYD2wmeb1bclMeM2lXGD8OpzUy0K+0s9L2MdOpxkEqBL0kg76Jfnd2gH6UbcR6y3A
         iZz5LZ7Nhw3/zYAVJVYQgks0ABh2rFi1Pw1HtIU7qWjVHYKPhmeAhOPSL/l61gUh7tqH
         U7Cx7zvoqOrCan+bSBBEb8HhfvQba7b/LjVhqtjEgjw02q3duNHvHDWzRuIZTmUYr9OG
         xQpt3R4vwH8yIlO+pz/vJTddHCwLqqg34t68S37RRqxhLKsMe5nIMojjQOhkNm7jGUAH
         q3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUQiHfM83RSzKPkhfBvcC63bFzQ2jvnGERJ1UELAON6K5MMn7VBCyJazsVVtukoqQ/u9MqrkwdyQM0vpN7u4x961gwUkPjD
X-Gm-Message-State: AOJu0Yx6c1WqPtwRhhkQY2fKlauSfha8LBbHLxlapjoEqWJQYihQAwyk
	FV/SuZ6fVR1fky6H889IylzUIUr98I8KIUGXJPpqjKCSqNAogcBtppEyYycF/C+D9gdPQt8WYk5
	gzmcMRJ5wYq43fuD7BpKaTuRehyA2kvPE3ydoj5HkE5XWAkajs3Mw4w==
X-Received: by 2002:adf:c04b:0:b0:33e:bed4:c418 with SMTP id c11-20020adfc04b000000b0033ebed4c418mr5929000wrf.3.1711391074131;
        Mon, 25 Mar 2024 11:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5r/lLnQrrP+FsfZkx/tzC+B0pi96TLNpWuweDBMHLcZfzhANDx6D6CScWAtrWW3d5fWN17Q==
X-Received: by 2002:adf:c04b:0:b0:33e:bed4:c418 with SMTP id c11-20020adfc04b000000b0033ebed4c418mr5928981wrf.3.1711391073750;
        Mon, 25 Mar 2024 11:24:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b0033ecbfc6941sm10112932wrw.110.2024.03.25.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:24:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:24:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Marco Pinna <marco.pinn95@gmail.com>
Cc: stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ggarcia@deic.uab.cat, jhansen@vmware.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: fix packet delivery to tap device
Message-ID: <6vlaxnqqyhppbajmmwyco62b7gzasflgrxpgl4h3ippuk4jwme@qfne3i72eej4>
References: <20240325171238.82511-1-marco.pinn95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325171238.82511-1-marco.pinn95@gmail.com>

On Mon, Mar 25, 2024 at 06:12:38PM +0100, Marco Pinna wrote:
>Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
>virtio_transport_deliver_tap_pkt() for handing packets to the
>vsockmon device. However, in virtio_transport_send_pkt_work(),
>the function is called before actually sending the packet (i.e.
>before placing it in the virtqueue with virtqueue_add_sgs() and checking
>whether it returned successfully).

 From here..

> This may cause timing issues since
>the sending of the packet may fail, causing it to be re-queued
>(possibly multiple times), while the tap device would show the
>packet being sent correctly.

to here...

This a bit unclear, I would rephrase with something like this:

Queuing the packet in the virtqueue can fail even multiple times.
However, in virtio_transport_deliver_tap_pkt() we deliver the packet
to the monitoring tap interface only the first time we call it.
This certainly avoids seeing the same packet replicated multiple
times in the monitoring interface, but it can show the packet
sent with the wrong timestamp or even before we succeed to queue
it in the virtqueue.

>
>Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
>and making sure it returned successfully.
>
>Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..ee5d306a96d0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		if (!skb)
> 			break;
>
>-		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
> 		sgs = vsock->out_sgs;
> 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 			break;
> 		}
>
>+		virtio_transport_deliver_tap_pkt(skb);
>+

I was just worried that consume_skb(), called in
virtio_transport_tx_work() when the host sends an interrupt to the guest
after it has consumed the packet, might be called before this point,
but both run with `vsock->tx_lock` held, so we are protected from
this case.

So, the patch LGTM, I would just clarify the commit message.

Thanks,
Stefano

> 		if (reply) {
> 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> 			int val;
>-- 
>2.44.0
>


