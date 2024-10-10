Return-Path: <netdev+bounces-134115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8C9980FD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D420B1F27171
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FB1BBBD0;
	Thu, 10 Oct 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byN5CX3T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114614386D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550177; cv=none; b=eWa1Vxnw6f1Vc9FXmLtV7hmoQSKVHQViNvGbHA7S20SAzDbvzvuZPm5TxHar/BS5tTaZXBvtxFBJ3gzCsgNvVbii90iCwptnOqHaKpxK4eG4zMGqKEfYCCBTcJbt2TGt70E6VTG7XlvShlplCPja0cK3T97xD8pLhZJ/gh5VmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550177; c=relaxed/simple;
	bh=68stV1OpW6b+DKiYGjzw+PqPRUZWqvm/GCbQHnNgX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy+0eWeYDxv+KnMIpa85+zeiarcmQdefzUmlUGAGiTVqAHHPapIRswjKr7f5igvdX1qeXgKGXTEHu5F/JwAtik7spEPnUJdH9GIVWMoVtk4RUZyqYrvvNBGJodVu2XjhLQEk2GooWcND3Ir47CMQwmaZ4jC8cGYfF2jvWNuT50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byN5CX3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTgUkKZySvZu+l2XKGcPyGoCj4q4zZnZ31rqscd6vJo=;
	b=byN5CX3TLgO93K+XIS1EFejAObeZOKaiHQMJuP/bWZ1qJac+Z8d8I5szZzTD5wBa3e/Tqe
	JkYG1K/C1EKFEoZSs9mKQsFnnR77go5OHP69Om4whrVb2aquQiv7wHqM4lpO1H5bFPCPwe
	2C4adzSlVlUqnmALbLiqO3CC7P/LgIs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-_SDqEDCRNZ2wuxmpCoKmdA-1; Thu, 10 Oct 2024 04:49:33 -0400
X-MC-Unique: _SDqEDCRNZ2wuxmpCoKmdA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fad296738fso3937931fa.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550172; x=1729154972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTgUkKZySvZu+l2XKGcPyGoCj4q4zZnZ31rqscd6vJo=;
        b=f4GY9IQ2Uf6za8vqA6d74ChQkEud3KSTUimaNRXVzllFyue3dXj/xb4rWGKOpgmqP7
         fr4sEC++XGfeFDPUIacPpHayXfEj+BH0rzFGdZYe55kvh6C6uHh8j2svpt1hBXjCg3yN
         Andv/Oiqpvm+8tGqupUX1dyHUBTAREvksaqfDJvv5PkmFszp4tSdB9IZNgsOas52szB2
         5A7RTFcp/uaj8ZfqErTDl/0wI5C3iqTCm1oFIk/L0AaVzaHbL/KjsAlPNMDX7xKl5AYF
         OwxMLWz8MM9sb2OomfgJFkrfyCgbSj0QXqYdN+n383IzdyOoBRw7BBfySsU3aX6r2Zgc
         To0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSXb251XJOt/pY/wuq5l3KpdxNWV+PqJsdzhPA4/j6bgFV4ydLKx4MFDzyHNscMatcGymT7PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1LlAbjPEoYBC7/JwRZ499x5rMMmvJjwBd7u6SzpbbXPn3onP
	6/sKo2/M6xWicvAftkXxYjNa7+gjHHPzLKLvG4APOBUmsIS6L+6KcTzOc2BvGFjUbKfam8Iqfyh
	/8KwhXIZJW850FX2kP9Mg3cT5snx/NGEBijW1Jn+k38md1TiHtVakwg==
X-Received: by 2002:a2e:bc0c:0:b0:2fa:cb44:7bde with SMTP id 38308e7fff4ca-2fb1871209dmr37374381fa.4.1728550172073;
        Thu, 10 Oct 2024 01:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3c4fKyUkorKvGuaI1mTPxi1c7YQHi5OLwGxivpJhfR3vsBw4cdN68p2gBi+K23ol/4JvnA==
X-Received: by 2002:a2e:bc0c:0:b0:2fa:cb44:7bde with SMTP id 38308e7fff4ca-2fb1871209dmr37373911fa.4.1728550171329;
        Thu, 10 Oct 2024 01:49:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153027sm484047a12.51.2024.10.10.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:49:30 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:49:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>, bobby.eshleman@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] vsock: Update rx_bytes on read_skb()
Message-ID: <mwemnay5bb7ft5zvlrh5emdtkilqvkj42xnxnatnh3hmmtkhce@fqe64sbx6b2z>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>

On Wed, Oct 09, 2024 at 11:20:51PM GMT, Michal Luczaj wrote:
>Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
>calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
>vsock_transport::read_skb().
>
>Failing to update rx_bytes after packet is dequeued leads to a warning on
>SOCK_STREAM recv():
>
>[  233.396654] rx_queue is empty, but rx_bytes is non-zero
>[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)


The modification looks good to me, but now that I'm looking at it 
better, I don't understand why we don't also call 
virtio_transport_send_credit_update().

This is to inform the peer that we've freed up space and it has more 
credit.

@Bobby do you remember?

I think we should try to unify the receiving path used through BPF or 
not (not for this series of course).

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 884ee128851e5ce8b01c78fcb95a408986f62936..ed1c1bed5700e5988a233cea146cf9fac95426e0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1707,6 +1707,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	struct sock *sk = sk_vsock(vsk);
>+	struct virtio_vsock_hdr *hdr;
> 	struct sk_buff *skb;
> 	int off = 0;
> 	int err;
>@@ -1716,10 +1717,14 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	 * works for types other than dgrams.
> 	 */
> 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
>-	spin_unlock_bh(&vvs->rx_lock);
>-
>-	if (!skb)
>+	if (!skb) {
>+		spin_unlock_bh(&vvs->rx_lock);
> 		return err;
>+	}
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
>+	spin_unlock_bh(&vvs->rx_lock);
>
> 	return recv_actor(sk, skb);
> }
>
>-- 
>2.46.2
>


