Return-Path: <netdev+bounces-222466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32798B545F3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8B8560F96
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6E26FA6C;
	Fri, 12 Sep 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw7lbyV1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29B26E708
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667045; cv=none; b=kmBlrpyEBrZoUkun5uSeOgzz/aKdCt1QK9d3IVG4mFZ/m9QDRdCuN18qHT0XlGFeyTW94H7g4UsIM21wUYdZFnde2DBKHtZxi3ivRcKtUVu+7BfUryqHo0/6MKSpSO5Dl7p29pQhjfxoLy7HBhwMgcjH6RP3RxUCUjQ/gM0LScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667045; c=relaxed/simple;
	bh=eIehRNox/dG9Q/NjSvCbhxAAOwBQCzMl/Y+73D6b6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4I617lAAdTH7l5nw1jTZ9RMCmT/ehemdegieTEDS2x7nQRiGMns2W8utGEFjQNbDhAq8jmx8RZLeiqprGRDlD6LYHRA2YPjsRYsrIVhmSKZo/WVJbkLnYkzF12FlCtD2vqNvYbazED7h1NJvIKZvSeJV4E3UvU+tCJfGSZTypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw7lbyV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
	b=dw7lbyV1uAyUvQeBntax1lqec9je/V7K4z0hn4m+rei4jme5QqeFr5bG+oLLrRnKnxsbic
	7dkcHCag5IQEPQgn1An8VEF7XuPUaK30wcATMnsUoiOTzicV9fUFbG6TiGg8aMlTB5g4j9
	Y9n49vofSTJyfeOMcJ6W5hjFAp01uu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-OsgKKkjhOYGydn7k8GPPuA-1; Fri, 12 Sep 2025 04:50:40 -0400
X-MC-Unique: OsgKKkjhOYGydn7k8GPPuA-1
X-Mimecast-MFC-AGG-ID: OsgKKkjhOYGydn7k8GPPuA_1757667039
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e7691b7dfdso224546f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667039; x=1758271839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
        b=HGLqD5we1SQ4pSPHq1KBPN//dKkon3Ld0Y4Ex08j0bc2kI+v1f4nL1sT3hQwD2lmoH
         2Y/P9i5y+gZq8bakQ8W51Fk68eUz9lL5RhcgDtrOpXnrALdkkdopMeHvvyvuphRiaVqD
         vGygddPOSqwkjG5mDJM5XPIOK5r/eTkBW0JagrmRQr3+Uoh5lSuZUQacEUsHufkTYWAr
         oCjI3680Duk0RABQX5rcIUJMajPpNpNSssoelDRsIYxRQ76T5AjCeKPSoonuTzrK/yeW
         tgKYhzILWHBWG1rhV6q7H8DcaBqZdwVnYQmP/8UcW27msH6a3QdQjGEVHH0MXbuCSMOa
         qpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXahpVMDOGklVvJNmpCEjQCqiB7qWUTOMS67AOhXjxOB2/33J1aTdxQ4VRgqc1Cn9+nycB1PJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAaGAWyyRZwC5m5ewZuURv1/wfueXK0FVrk5VU8+jAMFuFhH5
	akJpbQ+F3gmxK5q/Eh9TZP8kw7KBYlHjiaVeV/y6EtIi/GP4yjejb4HSOvpamXno5YwWlLTGUz+
	I4dnwM7WccjIM5lYQimKdXnaD0aruncezceR1U+lhgRKJ3G9xIeJ8HuKBcg==
X-Gm-Gg: ASbGnctMnLgsgZ9B9hoQWGfLQpe+y3aV6a9oGGpY2bCdkjoJSLBHyn5RB6bV4xXdDZY
	VU4HOZ0eD4AdArQm+Y1nkCSWZzTzGqSBcbdAzT0xzSRhl4lvjzkcikT9EULv5pZV6Klvjjab3k9
	QcDw91xTRlUPodvK9MmjfZlVjrbsGUurk+Q6L5XJYNORsYDe2LJIwdgKBBIw1waKxYLOmLMdMzL
	4WkVd+WBrGd/aatNlJwKzY68pPbwjLXxIoB0+PdX9xjQZCnsPZWVRHELNToojCG67OXWNEGdfDd
	knLufpSNdfCQHReVY0gRZoZi2d53h6OE
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991851f8f.25.1757667039437;
        Fri, 12 Sep 2025 01:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS2Tz/SulTKIR1f9nSWXhOdRDsMn29o7jRrHZHGh4hg8LiyfPRYgIJgThyJhmqJvpcfuVOUA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991827f8f.25.1757667038953;
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7b42bdc5asm321061f8f.21.2025.09.12.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912044523-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912082658.2262-2-jasowang@redhat.com>

On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and may
> trigger the TX watchdog in the guest.

It's not that it might.
Pls clarify that it *has been reported* to do exactly that,
and add a link to the report.


> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So this is mostly a revert, but with
                     vhost_tx_batch(net, nvq, sock, &msg);
added in to avoid regressing performance.

If you do not want to structure it like this (revert+optimization),
then pls make that clear in the message.


> ---
>  drivers/vhost/net.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..3611b7537932 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> -	bool busyloop_intr;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	do {
> -		busyloop_intr = false;
> +		bool busyloop_intr = false;
> +
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			/* Kicks are disabled at this point, break loop and
> -			 * process any remaining batched packets. Queue will
> -			 * be re-enabled afterwards.
> +			/* Flush batched packets before enabling
> +			 * virqtueue notification to reduce
> +			 * unnecssary virtqueue kicks.

typos: virtqueue, unnecessary

>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);
> +			if (unlikely(busyloop_intr)) {
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev,
> +								vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
>  			break;
>  		}
>  
> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> -	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> -
> -	if (unlikely(busyloop_intr))
> -		/* If interrupted while doing busy polling, requeue the
> -		 * handler to be fair handle_rx as well as other tasks
> -		 * waiting on cpu.
> -		 */
> -		vhost_poll_queue(&vq->poll);
> -	else
> -		/* All of our work has been completed; however, before
> -		 * leaving the TX handler, do one last check for work,
> -		 * and requeue handler if necessary. If there is no work,
> -		 * queue will be reenabled.
> -		 */
> -		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.34.1


