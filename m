Return-Path: <netdev+bounces-223170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A11B58177
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3D41AA3958
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264372417D4;
	Mon, 15 Sep 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo8MGimQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87923C50A
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952199; cv=none; b=RCdbMzJ0R/6Ti6QJ9KBUrC+jYbfKMSVCI/fxW/HpSXR3zbAqFscP5wQ6oyR7rsVDupkF7GLFrfz5X26cMVUGX3+Okn5h0xoeAcJirXU7FtUn8hOqFh1Uma23bDq/pL/koRGD8JfXy9k0jzi32ZVUGaL4OrmUKEAjb0LGzNtTVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952199; c=relaxed/simple;
	bh=UgpAiUSkfqsIiMi/5vuPzG4RqiLKzyDrVtzPJiZs6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im/eK6abAaM1B9oh76io+tUOKYvzqyQO4QNId84bHS0s8IYlu+K+tFJtfGfVYqZz9HKOroyByOnFRps0FliiRqtqRpC9H8qcp7XhxV6+ziVW2uMzat2pJAJHUD9gRRm9JK2cXQnorSn90xYpt92aIM2Ox5mSBjDGCZlT8kBE1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo8MGimQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
	b=Yo8MGimQEtEz58ms+MRAdrkKlonl1Iy265VbTsZ3BrbCXe8fBYK8roDMjUN27uZyw7Evkv
	V5QkUi2zJ4mQCle+ul4xucDCeSj1C7GT4MjV/IzJsQmQTxTMqMdiHZSWmJwXpaR2H/ss6a
	CR63mdVmeXwTN/ugI3r+JRmvP+khSLc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-4v7RH-caOOqH0rxZ8f3hIQ-1; Mon, 15 Sep 2025 12:03:13 -0400
X-MC-Unique: 4v7RH-caOOqH0rxZ8f3hIQ-1
X-Mimecast-MFC-AGG-ID: 4v7RH-caOOqH0rxZ8f3hIQ_1757952192
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b04b436012bso315054066b.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952192; x=1758556992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
        b=q9yB/CIvOU/63un87WP3shsqvKeu/JWCkTUW3vTZlcO5zBeEZDU96WBMCEn+AyKKYS
         Kl39UBcW7JkZaPM+wQCtJAB+16GUAbh91sfqfyS12fH8oQXVPIX2kRIUyKtKagI2uz0F
         jNmH9o+EyVPUTcfQ0Ut0bP7MXVA/k/jpfekdSr+04I5mC1Dco7AK3tVY4fNv3W+Hfw85
         mgV5ocu4IQZc6O/X/GfQlnzw2FWGUV1FDEJSJ1R3UlA9v4fYENspMIP7FawyCVN9zNGQ
         NIW6FqiJgyiPob77dhmkDwJO0g0cQl+U+x00jfbVvJv/Z9tHDN8dP3LthAuOz0rvAgQi
         321A==
X-Forwarded-Encrypted: i=1; AJvYcCWdhTya6agO/GlC6iT4/YXvNSzEhNGa9OxjfjjdnWSEBuC3IObHAKxTl9jQnk48tZMkhKXgLNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2NfGS1i93nA4SQ9vsdF6ksj0e1aZ8noEOQXoVAiBiqBESjNK
	02vrDwnvbhD5mRpSXGReFOldhe4OPmQqZlY+C+AKyDikNeqDB0ZQGc+lnlg7KdAnUsgl9lsZfWH
	OVvunMa8/qrOFczWzc7N6jzpcypr/ErfV3E+1tV3Hzd24A+ENOMbuPVUuRA==
X-Gm-Gg: ASbGncttq3XBtBUBcf3ZY4wX8fGdKw7XjENMOUjxNmnvHDXE8mk+FVuL6uvAFOiMvLT
	bDwz25jRWTFFCaV1fTU3jz9Q7/SKjuQVv3VpEwPpzMGUhgH3vFZw5IkH4zMqEYzvKI30GcpjqiM
	Sonv1GXH5JDUSNI+rgIunKHqDsAieEkqOZfS5XxwSTzVCj7NmSpYQJRNQDCYhaUK8gVZIBZS6dc
	ov222caL9PBMFlBn4FctDVflRhFzkNelY19CoClcxecvd0Vxnmysp7lW4xpCkRcG4TwNzkaeKbO
	PkNrjULGhp1JDp6p0YdGGqdLHfbH
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216489a12.29.1757952191743;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjGn2Z0BOy+sfljpNHO+I5IXHBbdbcb8SYTOdauYndHQ59yMvvIQnAzpSL9eW6X/im0GKszQ==
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216441a12.29.1757952191084;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f454f4288sm1899363a12.5.2025.09.15.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250915120210-mutt-send-email-mst@kernel.org>
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
> 
> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
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
>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);

So why don't we do this in the "else" branch"? If we are busy polling
then we are not enabling kicks, so is there a reason to flush?


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


