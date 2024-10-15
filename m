Return-Path: <netdev+bounces-135483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09899E112
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9161C20E48
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55891CACDB;
	Tue, 15 Oct 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImUce0X6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775318A6A5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980995; cv=none; b=OuUMal/SxemH9+11vWlEjUDhsufVM7/qJtxUJS6yZMSaHQ6IegWPlXBt9lJy29Ke0fYjj9yAzJrmTkChuu3J0MbrXqrbUHwiHqmlvfkeq2jUXF2frlUNGbDKzdxayN2qR1STtaFiFxW+1VPCmJtR8YZ+UE1Rsu/EcXQNWmD92sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980995; c=relaxed/simple;
	bh=jj/LmH7qLvgt4exl6wkE4mjEsmbw+w5cMUOrJUKHKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM7poXYpzdc800ysM/f1W5PDupKHHCHos4H+WyTCF9ILo4gVxw57jPPBXxPZ+Pjln79bKgCP31MvZB04BXle3HDbvTqY9WQDABbhcPVq+p8gRbxb+TQX+zUaV/3RJIR5CGWKjneCHR2ZT3dPI6RMlXqueoGerHZzjxp8J0GFhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImUce0X6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X3HJY57OoNbvtfOdWkdMD2px5S+qJ+6gnDSHv9a5fQ=;
	b=ImUce0X6T4PscQhD02OUwEI0F65Rm+pre/q0hStw0/nxUe8/iSmRu0N27h3VV5VAX/FsUL
	RcHHMm21BvTtpfyNzyFYQTXn3Wz9zUTErXS4n2PNnT5rC2fEuQKbGt7rjygGQRX2sJ+Zv7
	lH9adRE1oRbwfeMJ3gpkjuqqnTFYASI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-UiYI4tYrOS-jRTpkK93VVg-1; Tue, 15 Oct 2024 04:29:51 -0400
X-MC-Unique: UiYI4tYrOS-jRTpkK93VVg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b11be67f75so638605885a.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980991; x=1729585791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X3HJY57OoNbvtfOdWkdMD2px5S+qJ+6gnDSHv9a5fQ=;
        b=GOc3tS7jt9kJCuGqhBWGc4kfYtM9izBQVWd7y0xX3Slk2f9GNMiNW18eGGHlB59sSe
         kpLgM0xjzcQCezosNk0rluXI9l70nLRQJmMso0MtXuvzlPBY9f0J5yHDMCob6i3vqvKe
         ZEFScNGdcx4x4cR57xwakNdo/n9my5kSVjNDoO3ZoLi9TDGg7eT+9GPk383M5akK/OsS
         5l7KVtW/PSs8Xe+EPYJp6lYbn2eHhmXR2DDFi85fj1phUz25fh17PLl7AEftSmjObDE9
         qkd7ZMe7ZZ20vM/SIbneHE8axQLeGr8C9cGtEmznWV90i8YGdUTrPPTs63dANqiO3wqw
         CVVg==
X-Forwarded-Encrypted: i=1; AJvYcCWKiMCpivwlsGS1AEhEufdgmnJXsRYgQAl78MvQmsk7n3BdDWWt2FOVEZLq8i8CPG8wYW375NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx020d1bY86aPIh7WIgxk2G4o7WvSfh1ldKSbqnvxUV0y2HpKDZ
	yW/4dN4Ofk19dLPUgAk5AAgVQWOnSE9wY4aXOfRSRwNn1wFYD/fGtKk6bAlnJrdlNB3KIX/nCdE
	ewUhZ7zhX1r0XwuJ8DTnFt9Ln+5xQF0TPCTtYeU+idWciWNAbfEywXg==
X-Received: by 2002:a0c:fe87:0:b0:6cb:faee:76bd with SMTP id 6a1803df08f44-6cbfaee77c9mr168514266d6.37.1728980990810;
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqXUDY/LzeEwx2rNA73Z6eW1a1VzKmXv3PC0F1n2oqrFc7NEweIEP7pk+3LRVAWTefnnlNA==
X-Received: by 2002:a0c:fe87:0:b0:6cb:faee:76bd with SMTP id 6a1803df08f44-6cbfaee77c9mr168514076d6.37.1728980990453;
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292293asm4011516d6.53.2024.10.15.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:29:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/4] vsock: Update rx_bytes on read_skb()
Message-ID: <beao3to2xe4h3ahidckfcf5upndl7vdeeb4dehqy2mpt42fa34@6d5n44gn3l35>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
 <20241013-vsock-fixes-for-redir-v2-2-d6577bbfe742@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-2-d6577bbfe742@rbox.co>

On Sun, Oct 13, 2024 at 06:26:40PM +0200, Michal Luczaj wrote:
>Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
>calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
>vsock_transport::read_skb().
>
>While here, also inform the peer that we've freed up space and it has more
>credit.
>
>Failing to update rx_bytes after packet is dequeued leads to a warning on
>SOCK_STREAM recv():
>
>[  233.396654] rx_queue is empty, but rx_bytes is non-zero
>[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)

Thanks for fixing this!

LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 884ee128851e5ce8b01c78fcb95a408986f62936..2e5ad96825cc0988c9e1b3f8a8bfcff2ef00a2b2 100644
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
>@@ -1716,10 +1717,16 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	 * works for types other than dgrams.
> 	 */
> 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
>+	if (!skb) {
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return err;
>+	}
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> 	spin_unlock_bh(&vvs->rx_lock);
>
>-	if (!skb)
>-		return err;
>+	virtio_transport_send_credit_update(vsk);
>
> 	return recv_actor(sk, skb);
> }
>
>-- 
>2.46.2
>


