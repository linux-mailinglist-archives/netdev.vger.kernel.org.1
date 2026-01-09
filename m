Return-Path: <netdev+bounces-248549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E5D0B361
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA6F30CE21E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2A3009E4;
	Fri,  9 Jan 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKiAbeLy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd7pirNN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF22B5A3
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975512; cv=none; b=CKRrlOD5LYwTzMrz3XdTXgaG5Qem1Yg4ctLbsi24S7suIvw98W/vyA85wCSiFpfS7Jb/ZVJeeBf7XSXnleHmxcQmtbsHGUGDvu73/c95HxECswn1D9Ueqe+yDV7aePrb3GljbY/crAk9Ji3dVpoU+HwpGJkM71mFD4lwjYZNTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975512; c=relaxed/simple;
	bh=a1/DesK3SdmsYTBBaArmoKyDaDj/3FIZv0uZ3aW3q6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDn40Pp50o6dn2x9zTUdS9eTmw1RHMx3MYAmS6gQn5tvnB8mebb2Rhq1HJuWIBBgmjo6sgpQlqA+XVf4J1PQw5XHPJCMPf2Gt/fI68zByUQrnv4C070Y/BpMIKM8KFCPg79hMkJDRyFAKk3YSUzihP4FzqIEQQt2T4/jEYziPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKiAbeLy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd7pirNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767975510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/krVGPsvJddi7hg5z9iCRy/aoNIgxBgy+h5yAK6W1kg=;
	b=cKiAbeLyx1v+pyYLplqORQGMeAGJNFSLGROg77KxFMO6OExlwKL+wVxk+A44NxURO+OnaD
	G9Nv767X6VOHr7Dk79V9DHGeGg8yndM3HFCoVokb3PvEDdH84u46ygfRFm8aWabYuzf/SS
	9BDdpAZsi3NDbloAm9DWgzrz7X44NDI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-HPpJpSZbNdaKbXMpZNQmDQ-1; Fri, 09 Jan 2026 11:18:29 -0500
X-MC-Unique: HPpJpSZbNdaKbXMpZNQmDQ-1
X-Mimecast-MFC-AGG-ID: HPpJpSZbNdaKbXMpZNQmDQ_1767975508
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b79ff60ed8eso329484366b.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767975508; x=1768580308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/krVGPsvJddi7hg5z9iCRy/aoNIgxBgy+h5yAK6W1kg=;
        b=Dd7pirNNdfNA9usNhQzvyK262repY0KT12gqpaLcAlITZwDwQslvtRheuKP8T0pYt0
         2lcxMiRg3r2c1quh9hFsgQF3McmBq0VAnCLBYUnR92+QulvQ0OQL3Y7c3F0HZogjfRA0
         AXvvBTyNX/zaFN7A1LLfETA3KaBMRqvhWXTmWG8f5tCrb+Ka7bY7MSNsRWy/ggQ/1Odu
         G2KL6fq1B3I2/3UzKggCNwBs2uw1xFMSCdD7Gi6cf4VDdPu1HUJWax+0GJLOEhEj4XfP
         B0EyeNFje6mM9a0V811PgZC3PnauDeCuKb8qewUL1JAETr4kyo15EDeIsAlolbWVqaAA
         oXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975508; x=1768580308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krVGPsvJddi7hg5z9iCRy/aoNIgxBgy+h5yAK6W1kg=;
        b=Um11BHx5TwHHkrmBQkqwfMpuBtpqWIrhGCFFAwOAHUnNkuC+r0cFZFIyyuLwc1Kibe
         T6tHixLNNpAwwSJaNWqpK7Lf8FBUTU37EIE/wi2CJM9Wa/fu3qXDVRxjbKprwfcX/k0s
         1b0aWIanyuy4Y+Tk7taFsH91y1meXnI55FpRnBsuYsTomxPBO4tGccGajmHPx4GlDO8/
         cb8jdnwTKuy2ZSvtWX5yJwvSpRTFiw9o+DyohetEI5Eh6DJTNqePgi68THJSYnWA/HRG
         IqGzMW2mhkDxLv4A8bsxRwiMiXKaGVCm7bl73QaKd88tFQo2h3ApU5X8mUerbyAx46Go
         kOzA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0NBcbGRJIe3ChyGSBtLZZdLtnqlKEoTbNhXKTRuZt0bpavJCAvP6/VD1kYwrXuQ64EB3QSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMAkC8uoGK6Rlo1nNb3Khp9FMKvaQyqBl6mYOQ1vrQ/mvaK84
	vrQQgpQGplJUaQLnoEfrmegK/PlIOcR12RLyRLPm2bTSXYKR7VqEHw8KaBuNK+OaqgmGTtj3PCc
	hbkp0B+fRcjKHwhUWNIf1vQ+9Vt3dGSy91ZMDK/Y4Gg2YXgwleRND8H/6Cw==
X-Gm-Gg: AY/fxX6q7q6RTOwGZj1vgzmTUAgGfXsFKzR+gb0cp0wCgpsNM35QrspQB/KDjI3asNk
	RA1SaGPicQL0Y5wjuaGR4s0GZ5ohCPbsoyOhM/mBrLw4fF2/PMzdB2Or970fP7shFejoDLcTVNg
	Zc8S4f3i+tGwNKE6cebOd5r+JBR4rLOqrQNXWXVZFtMeS4Y9Xlmzf8/ipXg5doQ1QWwAH4v9qC2
	4IBfJZ9StfGFZFz0YDbBEI4iZL+vxJ4ygHKjzzl2hVJAwmQiR453nRFsfBPL7iVQTJfDBL94QCX
	jc8of14lCt5/PjmB9S7FOBhCJMFwCA5YEQJT8gN7Ny3dWKTPdEu3thYiWrXAle/pBA5AwU2a3VY
	OQed3feOZwAAXvdQ=
X-Received: by 2002:a17:907:1b0f:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8445179d97mr1040652966b.42.1767975507961;
        Fri, 09 Jan 2026 08:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr2olBdquSj4gJBneVi4T80pCx/5PM/5koZL1efVNkWaXxHFkv/Bw2psyCF7rUeZB6h9BHnw==
X-Received: by 2002:a17:907:1b0f:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8445179d97mr1040648366b.42.1767975507266;
        Fri, 09 Jan 2026 08:18:27 -0800 (PST)
Received: from sgarzare-redhat ([193.207.176.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51183asm1175084666b.49.2026.01.09.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:18:26 -0800 (PST)
Date: Fri, 9 Jan 2026 17:18:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWEnYm6ePitdHPQe@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>

On Thu, Jan 08, 2026 at 10:54:54AM +0100, Michal Luczaj wrote:
>Vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
>(with a spare tail room) is followed by a small skb (length limited by
>GOOD_COPY_LEN = 128), an attempt is made to join them.
>
>Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
>will always be linear is incorrect (see loopback transport). In the
>zerocopy case, data is lost and the linear skb is appended with
>uninitialized kernel memory.
>
>Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
>guarantees last_skb is linear.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..cf35eb7190cc 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1375,7 +1375,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		 * of a new message.
> 		 */
> 		if (skb->len < skb_tailroom(last_skb) &&
>-		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
>+		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) &&
>+		    !skb_is_nonlinear(skb)) {

Why here? I mean we can do the check even early, something like this:

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1361,7 +1361,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
          * to avoid wasting memory queueing the entire buffer with a small
          * payload.
          */
-       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
+       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
+           !skb_is_nonlinear(skb)) {
                 struct virtio_vsock_hdr *last_hdr;
                 struct sk_buff *last_skb;


I would also add the reason in the comment before that to make it clear.

Thanks for the fix!
Stefano

> 			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
> 			free_pkt = true;
> 			last_hdr->flags |= hdr->flags;
>
>-- 
>2.52.0
>


