Return-Path: <netdev+bounces-245305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB86CCB28D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7368C303E650
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA124331A79;
	Thu, 18 Dec 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAnnD4xt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/sc6azZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFD331A6B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049595; cv=none; b=JLy8Z0YrX3DUllVXc78LBDaSAAkXcPE7HL1GTaS3uQoD2fGyCnHwFdmN9tSt8LaZ+YARVOWHznh2gYc4mBaEWPUsZ9uRJMo4uRLA6Sn/5ntGvLNHIlzHBg7/Pb4Q7c/nkdmI3kWKLXk+v6fTtLCw2d086OPlwoQ7VKY3XviRz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049595; c=relaxed/simple;
	bh=yt0+W7rSVC5sqG/HWU1LuerYwILbmVgG+28GWJkkJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwDJAYvVxuorWcFTGD5WnfmJzVK8x510lErB5+jNFwm9MpiOKEIDqnJyzlSM+rBKV/0trW3pbhhEqvPO8ytWhT8rpPIUBpxhzYhnCjTradb0b0q199tX44ccz0TY/aoiBIwazUZo1jI++EqIzLUC2MvIeghiy1qfGGF5s5AKXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAnnD4xt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/sc6azZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DGUhTzB3JPaoSv5rwYKyV5NjPUkuU9Lam+Ho2USOIg=;
	b=NAnnD4xtekNjrs3HTqLMQFB1m+osh+STmgKUZX90PSD5KjiIWrmUrQdYGgmQEromIi4lIL
	GnC3RK8t3LUsckxpwhHukZd2lmbyzw8HOV8DtdOiimmuSCcDweO9La8X7fK+vWyNx471u4
	xkxP8GuNByarauiTvB5RKppIWn3K4e4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-dMVoBYJhMEWfRfCZ2TpzyQ-1; Thu, 18 Dec 2025 04:19:51 -0500
X-MC-Unique: dMVoBYJhMEWfRfCZ2TpzyQ-1
X-Mimecast-MFC-AGG-ID: dMVoBYJhMEWfRfCZ2TpzyQ_1766049590
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so58888066b.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766049590; x=1766654390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DGUhTzB3JPaoSv5rwYKyV5NjPUkuU9Lam+Ho2USOIg=;
        b=D/sc6azZTLK+fgZQ1JEjLzir+OHU9IRtC3QA0hG85pZrNC26LaYuIxrqFAphgPBLpa
         f/7znE1bFK4X4Sd8Edn0K1YgdzB2lNzoR3X78f1QwfQNqYtCEmLluRM4d4QBYFonZBNv
         cbtTaZ7Tb4QBMwBpR+2U+GUMQsO/xhwHrrrDKJ/CJEBmXRE/12iHGsOyBkJYcQZoYk7/
         g2ldqvTRVXtHPmYCD57k/p2lz8N+pI/ZGqHl/+oP6KWHUxstOGbz5pzmch5bF7NMzLyV
         2XnA/D/YxqoTPCbwSybD6vtpPXllSE7rFIfkmy/MPUYdXKEMXBcBVeaeluT8DVjfg2Vo
         JZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049590; x=1766654390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DGUhTzB3JPaoSv5rwYKyV5NjPUkuU9Lam+Ho2USOIg=;
        b=j7MK4HsEsy3I5zERyFjZk7b19uQR+xH3ISpgLLlC09tPu76CJcXwWNhPpwAyYk7V22
         JOy79W96nCbp8eXvr64t/a+r8Xtuvixk284txX0M/3+YIIMxzJLYQY/x1z43lGWNX/5G
         sQzvt3+zUQUIrRzxrid3SASdSr8X6hI8VUidJZrkaTjCC9S3/McVFOFssEWoZR1XMD+r
         8hBMODFjdsrOIjykGIVF5+A+HGYYquc8ORz2H8uOPdhvvhbz4MZwPV0dLcYXK8luj85f
         wX8AJxr6A29hf0MMX2JsjT6F5RmHekcTsYOk4vnWbR1ZJJ4PZ/rMtpuOTHPuKs+UamGY
         /cQg==
X-Forwarded-Encrypted: i=1; AJvYcCXqZ7Ix57a769Bvt1b+5TSQRXnrqe1f3qFXIFKkNpA+D0SkgGNLUKL68yuNbshqSPdB/irZxCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADRgYIjp7bsZnwu2H7t4lK7Kh7RxR0TP7OnUW793WXo6oZ/ll
	PbYHQZwijFkPvI8W0QHQcOO3BkY6Wc9jHzVvpTI2P2rKROzigp0rVBnSK9jDwsS2LZK0Ivy0LaR
	4mgRl9dA6o9zftxeKyLeJUz3OppGN8TAZ/4Jfoi/k8tG5YFIidWISheorZw==
X-Gm-Gg: AY/fxX74RYY2WOXXXuds5QOk4D05Jcx62UUK7HXh9oRJFfRDb5McEmCISNb0TrqDUan
	x24aaa/JMyxhuiCQmZoDiEVD7qiu+FVagk9A3jcYSvzWEmJjH4bBrn5V0qsAR0btg4kZRvljJcs
	Q7Y4VD5ZWyN0AQwUPXy17eESjajQklH+t2joKYU3Vfs9z+ak1CrKa5PBvMPeh2fTjdGbegf4AKZ
	l8cB+YKpBPpLB/ROYA8HLI9J1V4N+dWrTfmeM2i6SGhGT4fAGYYSA+LRlWIUOxniBly0e7lohTN
	Fd8ozXAJLgc+WWHwWs4VDPEQiqqgxgTh1HrvyxtPIqc6oEQ2fZxtsX9tFSG+sae1hWjixUTe/N7
	m8SEv/Oe5+Qvh/no=
X-Received: by 2002:a17:907:94c7:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b7d23619397mr2068561966b.2.1766049590087;
        Thu, 18 Dec 2025 01:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwBxz8gZtgWPTcDUiRKsVSV+WI8XYHTkiS4tl6rPio3Z5g8v52QwhDNNNXIZbHjAuO8agkcQ==
X-Received: by 2002:a17:907:94c7:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b7d23619397mr2068558266b.2.1766049589503;
        Thu, 18 Dec 2025 01:19:49 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b58891994sm1894793a12.29.2025.12.18.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:19:48 -0800 (PST)
Date: Thu, 18 Dec 2025 10:19:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 1/4] vsock/virtio: fix potential underflow in
 virtio_transport_get_credit()
Message-ID: <7oq7ejyud46smrlinz543xrczxyiz5bor62o7xpg6g4eiaa4ad@chcc25mgxc5q>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-2-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251217181206.3681159-2-mlbnkm1@gmail.com>

On Wed, Dec 17, 2025 at 07:12:03PM +0100, Melbin K Mathew wrote:
>The credit calculation in virtio_transport_get_credit() uses unsigned
>arithmetic:
>
>  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>
>If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
>are in flight, the subtraction can underflow and produce a large
>positive value, potentially allowing more data to be queued than the
>peer can handle.
>
>Use s64 arithmetic for the subtraction and clamp negative results to
>zero, matching the approach already used in virtio_transport_has_space().
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..d692b227912d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -494,14 +494,25 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>+	u32 inflight;
>+	s64 bytes;
>
> 	if (!credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>-	if (ret > credit)
>-		ret = credit;
>+
>+	/*
>+	 * Compute available space using s64 to avoid underflow if
>+	 * peer_buf_alloc < inflight bytes (can happen if peer shrinks
>+	 * its advertised buffer while data is in flight).
>+	 */
>+	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
>+	bytes = (s64)vvs->peer_buf_alloc - inflight;

I'm really confused, in our previous discussion we agreed on re-using
virtio_transport_has_space(), what changend in the mean time?

Stefano

>+	if (bytes < 0)
>+		bytes = 0;
>+
>+	ret = (bytes > credit) ? credit : (u32)bytes;
> 	vvs->tx_cnt += ret;
> 	vvs->bytes_unsent += ret;
> 	spin_unlock_bh(&vvs->tx_lock);
>-- 
>2.34.1
>


