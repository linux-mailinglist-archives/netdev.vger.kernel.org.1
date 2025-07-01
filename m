Return-Path: <netdev+bounces-203030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9AAF0372
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 21:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6EB1C069A8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284D280334;
	Tue,  1 Jul 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5yO2nmN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D567242D93;
	Tue,  1 Jul 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397246; cv=none; b=pZK1y4SjFuSf3LN5IbLfMLFuZGYiLn8RG0gnwRwLExwLea5Hl0tPlbsk3d4luPL1B8oPOrw5EbFpwl7GxARbaBRreajfK2nGZOz6vWAet6M86QiNjvTaQ7mpr458AlzG/PpmJypDo7gvB2f3Avr/Ij0E1nFHbOjokZBSjkc5fjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397246; c=relaxed/simple;
	bh=4Rr5RDJD2k8VW/HH+xcrwUxWOxdEDKOztvVdojYX7xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSRn+zjbhSovRfscyNMbhPeOS1uvVfjH9eMdbx4C2tPZF0YD9udqXbu68L+ghS9zCgxPUp6+bq/WcK/3LqvQbAvW46CfYD7/it0Ni4QnFHn78gcEe+HZAVCrM2XulfAsJjfKFrXFMAJaiCmCnI0vG/zUm3wcFwaNuq7SJ9V4ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5yO2nmN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so3839158f8f.2;
        Tue, 01 Jul 2025 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397243; x=1752002043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRAT6iMVdZZIF+G8MBWdHZBgavvJ5RJLj6iKsHMAdfE=;
        b=i5yO2nmNz6SvS4+aRgCTpJGKeDnPrcSi1zHODSfRTngXTTJDPUzbOydk3Lci/67djT
         5TB/alS4+L4k3VKCHSbNB5iZzb1AdQzM72KPTY2EiVPEK8NP4iG+LqstN+jo2MA1Yxq9
         43h5dHqsPCBDh26GVD4gUzSOE2lDPARQ5TFcwvTbwSlZwcD8dkMxmDw8e0NOwAdD7dfo
         xeq9OrO9ipVhhndALe6tWb5cyIRebGhlKBuXLGFHXP4t+RqmOL9I42uoCu9fhiy0WqQv
         LO1dH5Daf1KgNIya0hAHEOn69OzGN3bdccg0Q72nPzLWUxOLk9Pqag1YCyNOrAjE6h/l
         8u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397243; x=1752002043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRAT6iMVdZZIF+G8MBWdHZBgavvJ5RJLj6iKsHMAdfE=;
        b=rxZJT3g/zGiW4yeqwKXdPl+A/7QKwtL1QfQZxCcnftzVgXI2zFBq43GXNOS4cSTEBg
         ggDcvsK8Pv5DItSGUFoGFOsOc9AKmadv2QpRR+VeSCRnzGKqdnwnqmsU4d6oUKUIfIY9
         RpjPzY6sEna0eZvE7B+GcLXHuZHhTvLAlnbHkQaeSLhIVZuzRbxnJX1EVXAwtN4eXsSc
         WcxMgteIvvjK9nUdVLfDvwvQhPY7D7apj6JEDP7D7m6nfUrg7/Mzh2VkwCKYme7rHM5F
         2icYriLE7bs5k2xKHkoY8AA1fVFPybaxGsNEwPJSx6svYFrTq8AqyR3VTWoRpac1aPHl
         0gcg==
X-Forwarded-Encrypted: i=1; AJvYcCXKUOdu9EohXj5wZXBUiPIhn19brQT/tNg5UjMxGh9ZdW2oGoSzDINKyj5qMjUkGfnlEgqQLI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNje1dtYN3rx6m9+vo0lx2vk/G6BV5xl0tE9W+1YhXDyxadUw
	2j16YWuSH25MAoDOc9F1jbZ7cXQX7CS6j+BkynVUbYFEuACHjLlHgyoh
X-Gm-Gg: ASbGncsM5FdINYwDQ9M6kN3HqdM3qMs0NKUrHETcr9XG7gjWH2g3KiZODJ8q2u5NaTl
	t4/1HRKcYeCZBT9fwLqzsgPlSTdoiz7FsvYVUdTcZOJg7qmmIAnfwpZIuJjpXDJWNZRmEOvPhDk
	MjYGmvy1wBHcMVowBN/7aksaKBNZCdS/eCXQMIVOAITMCyKpBJi1O4OZ4QAnUFb35RBDXSnJyh+
	tVKz9wyvPOGW5LIE7yaSZ9sB2dGnwZa6uhZGoFLL9EK+VYm1rm/VvX/gKTpOQh7AjuQfJldyz9n
	Y1Ki5oiCXdRV82UmVmAK53oZrCT6m+MIkxK6UUg0CL0JT6347J9yaEXVxtJIGBdyskpOkge3jRg
	abJmPY1MRWTjEcgG5JQ==
X-Google-Smtp-Source: AGHT+IEKI/YCYtufBuGYyN654gnbiKtO4OJiT+a1rYiFQFL//Efs4Zhe4rDt90TqgDTijo7rz+z8LA==
X-Received: by 2002:a5d:5f4b:0:b0:3a5:2848:2e78 with SMTP id ffacd0b85a97d-3a8ffbd4cffmr17167671f8f.28.1751397242504;
        Tue, 01 Jul 2025 12:14:02 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm204864645e9.20.2025.07.01.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:14:02 -0700 (PDT)
Date: Tue, 1 Jul 2025 20:14:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, Steven
 Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that
 each SKB fits in a page
Message-ID: <20250701201400.52442b0e@pumpkin>
In-Reply-To: <20250701164507.14883-5-will@kernel.org>
References: <20250701164507.14883-1-will@kernel.org>
	<20250701164507.14883-5-will@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 17:45:03 +0100
Will Deacon <will@kernel.org> wrote:

> When allocating receive buffers for the vsock virtio RX virtqueue, an
> SKB is allocated with a 4140 data payload (the 44-byte packet header +
> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
> overhead, the resulting 8KiB allocation thanks to the rounding in
> kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
> higher-order page allocation for the sake of a few hundred bytes of
> packet data.
> 
> Limit the vsock virtio RX buffers to a page per SKB, resulting in much
> better memory utilisation and removing the need to allocate higher-order
> pages entirely.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/virtio_vsock.h     | 1 -
>  net/vmw_vsock/virtio_transport.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index eb6980aa19fd..1b5731186095 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
>  	return (size_t)(skb_end_pointer(skb) - skb->head);
>  }
>  
> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>  #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
>  #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>  
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 488e6ddc6ffa..3daba06ed499 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  
>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  {
> -	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
> +	/* Dimension the SKB so that the entire thing fits exactly into
> +	 * a single page. This avoids wasting memory due to alloc_skb()
> +	 * rounding up to the next page order and also means that we
> +	 * don't leave higher-order pages sitting around in the RX queue.
> +	 */
> +	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);

Should that be an explicit 4096?
Otherwise it is very wasteful of memory on systems with large pages.

	David

>  	struct scatterlist pkt, *p;
>  	struct virtqueue *vq;
>  	struct sk_buff *skb;


