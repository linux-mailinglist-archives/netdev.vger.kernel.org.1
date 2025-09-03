Return-Path: <netdev+bounces-219586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19528B420A9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20AA189026C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB0302747;
	Wed,  3 Sep 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU+bRK5c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE42FCBF3
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905200; cv=none; b=Rffdopwk0LYm7EDBaqTmWy7ZdzGOwrrBZKQErYoIjXGCSJpemi//1OLcwJZjpeGuTiNpfvChtMqKOEq6+QQVtL6ORX8EcgBIHO1CktBSu6qE7B+vNixV6GoEfxHcsAIISg9mgyVqspvi/nlLWH2honodlHXZfVOae7MiHHX4OQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905200; c=relaxed/simple;
	bh=mBGx6bKd//U8D94s4t2SoXU3lLXnSajCr2AAkuXi1ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkGOOSh+27tWf7SNZmT/WLldxjequUi16IgSRBTTBPIfOOqAyfKX8lUEywQmRdvr11BNjf3L84yfTLnjtFI0e5B3DfXb+iF5AuxiVcIQpNElGEj92IanBwrwBdHKP5XtEOZzCAQppJE4LvlIhPJJroHVRegd8QJV1TYDbDfgtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PU+bRK5c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yc++Bk4gHq8rVQO2rd4UcrQ6O5BuxTUofo1WcPNdozc=;
	b=PU+bRK5cnDI42dEqO7Fn3r+sU3X7W63z6dBH5X8w+xI+GQwIwCNGmOoBIyLXfIRC8LdAPt
	YUl1wFgq3ydzI9klEaXt11E8ANkDmfnJGHZlYePigoGztN19fxEkNUlA9SbcUvbKFmi0+m
	BcFGL5TAw3XER+thYWmpCRaNvVTw1Js=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Ul4KM68CMaGUxAmVWhAeig-1; Wed, 03 Sep 2025 09:13:16 -0400
X-MC-Unique: Ul4KM68CMaGUxAmVWhAeig-1
X-Mimecast-MFC-AGG-ID: Ul4KM68CMaGUxAmVWhAeig_1756905195
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cc3765679fso2455915f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 06:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905195; x=1757509995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc++Bk4gHq8rVQO2rd4UcrQ6O5BuxTUofo1WcPNdozc=;
        b=G7AjcIZpUbk6mDHUaeRPpFOpJ2mrvyxrDDTRxpv7TP2Ppi2LWpKLFeC/h82/AmfInu
         UvdU2dJAjvqPapcjATpVQjHW3ralYR/jq9NWOlTqjrUdtyOm8MHZDWhrsh4NQvNgD4js
         ksMQf6TiTQQWaUsh2mfuc7HkMi961UZln+HhS2KIIxCMmOz3KvAu6Phx+XaUgHLm7sPv
         w6JcJKyEXeDayWpCyEVnjzc/GqfmNeidCdCkJYE/bV+gJS/vryH3xS/0n2Kihz9Irc81
         6pY3ZkNE2jByJ6qSMMHkQ1Bs8C6T+imEPCFo2tr+kDmygMT5APxudrOz6IYJLxGgzhy9
         TgMw==
X-Forwarded-Encrypted: i=1; AJvYcCVyUqs5GOXFpABseIpyp5Ct6v2xT4bS6vJgKO7TGtZHS8IE9KYVG05IVAEwjsH9th17G9RJYuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGsfdVsP+fwo/qe6WS/BiFunY1aCdHv5LvxqiLU3zfR5+kDag
	LUL1p8Q6M5sh4+3TnZ5NH05+WPSnYQAKMArOy6rYFBD03Yltsgh4ixDlUFAnoEm+wumFz/ELr9E
	eV3lts/AGEx/Usk6SHTk0K7rBhTes3E40SXhW8+yN4CaEX7ELI9hmvQ2ErA==
X-Gm-Gg: ASbGnctxMWF41YT2PLzcEXegxY9xf2mGedtqNrXlVQdexAtRQp/B9RfjcSzCE90elg9
	LnFo4fey2wPQcuERH9gj+tJdu5wHj07dRSx46F/LZdZoaNMHYq+RbvyX4tnNuPrPF9+msbXuxbt
	r4MGgSKDlktc759hqaBAqFSHli5WL10asiZEF4RK3onJGfvr2wx/nJBB9W9Ywz0XRkgOJ0bCJOh
	65pHOYQZ6Kx/v0z51UCiWAo8OY7p6gS3DCwtmpbjhMwgUktTk1tun2RpJEFDxP70pqsJWknFTb5
	glwHK5+KfSlj4q3DL/yQrSAi8nDnRA==
X-Received: by 2002:a05:6000:25ee:b0:3d6:92ed:cae8 with SMTP id ffacd0b85a97d-3d692edce86mr10643416f8f.34.1756905195269;
        Wed, 03 Sep 2025 06:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Rd9SrgoaV2dgKrR38B9EwqokmCVv2zYCp6Unv9lrkeF9C49ix2kdTmzDinE3j4u/W7oa3Q==
X-Received: by 2002:a05:6000:25ee:b0:3d6:92ed:cae8 with SMTP id ffacd0b85a97d-3d692edce86mr10643375f8f.34.1756905194800;
        Wed, 03 Sep 2025 06:13:14 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm18102932f8f.40.2025.09.03.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:13:14 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:13:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Message-ID: <20250903091235-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>

On Tue, Sep 02, 2025 at 10:09:55AM +0200, Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.

I think the stop -> wake bounce involves enough barriers already,
no need for us to get cute.


> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there is
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=1.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..735498e221d8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1060,13 +1060,21 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +	if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> +		/* Paired with smp_rmb() in wake_netdev_queue. */
> +		smp_wmb();
> +		netif_tx_stop_queue(queue);
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
> +	if (ptr_ring_full(&tfile->tx_ring)) {
> +		/* Paired with smp_rmb() in wake_netdev_queue. */
> +		smp_wmb();
> +		netif_tx_stop_queue(queue);
> +	}
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> @@ -2110,6 +2118,24 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> +static inline void wake_netdev_queue(struct tun_file *tfile)
> +{
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +
> +	rcu_read_lock();
> +	dev = rcu_dereference(tfile->tun)->dev;
> +	txq = netdev_get_tx_queue(dev, tfile->queue_index);
> +
> +	if (netif_tx_queue_stopped(txq)) {
> +		/* Paired with smp_wmb() in tun_net_xmit. */
> +		smp_rmb();
> +		if (ptr_ring_spare(&tfile->tx_ring, 1))
> +			netif_tx_wake_queue(txq);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
> @@ -2139,7 +2165,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  			error = -EFAULT;
>  			break;
>  		}
> -
> +		wake_netdev_queue(tfile);
>  		schedule();
>  	}
>  
> @@ -2147,6 +2173,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  	remove_wait_queue(&tfile->socket.wq.wait, &wait);
>  
>  out:
> +	wake_netdev_queue(tfile);
>  	*err = error;
>  	return ptr;
>  }
> -- 
> 2.43.0


