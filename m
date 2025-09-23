Return-Path: <netdev+bounces-225683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38EB96CF2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5474119C656C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED5324B27;
	Tue, 23 Sep 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+Pp50/D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79532322DCF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644646; cv=none; b=Ap3vwnUYovrEww5AkMXXr6zmq86sSm6KJ59prJZItbhA4fwTcLRXHSDF5cHnsMBGm2gySx46riqVWNFA4Uaq9iVyAmLCOaQYoQzPEp2E0903wYOOPkIvfHlwILq9h0cHFvbvVlYPKY5Q+ef/Co2P1KvK+qj0QVu4WPj82TmC8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644646; c=relaxed/simple;
	bh=YT4el4xP21BBB42t2PWFoKpg5+LAf3L0g3UU1WpBtt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSv0PLtlrfH8Uu4msezqDUaN7NWrvaZs0LkBIAZn3vG5PTuztm4GRaSvodDqQ1ePMh6nChm5IyTFUq+t24RalIgWcKT3SvbXiOeO+xedqaKrHzSTit/imOTTJ4iIKVxs+PyZ+ncCjBxBPsa7so7AWwNoUvEzXT1Ea5H6BVUraxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+Pp50/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758644643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3gC4BVDLOnUNLEX5DUiA671iXaBW42g+cMsZG4Zf9r4=;
	b=E+Pp50/DoiQcX1OUgV96NQyRZdqKyTdDywf9AXPD70xrsLp5T9DnnxkXmztps0swrPWglL
	19tyfndKTNH4KOI0CqS10m6nGZaUW96e9e8SBtStZNlS9wtBWzhIJRGpdcULuv88dz+GMw
	Z2lGyFMvz8xBoMvNNJprL0lkWPLLkV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ZbDCypIhP5CApwr63zPZAA-1; Tue, 23 Sep 2025 12:24:01 -0400
X-MC-Unique: ZbDCypIhP5CApwr63zPZAA-1
X-Mimecast-MFC-AGG-ID: ZbDCypIhP5CApwr63zPZAA_1758644640
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e1a2a28f4so11868995e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644640; x=1759249440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gC4BVDLOnUNLEX5DUiA671iXaBW42g+cMsZG4Zf9r4=;
        b=ThK96wHGe9XlydsDn4+y8GIBr3pRErHQ3wzvK1Z6zFNthiNN3EeLg+qQGhODanRNob
         +PZxryFwSbUVdypxku/CKx1sLh0/UVksiq16b9yAEfyDZAzM2d4TObWMm/MRThO2Jvwm
         29YiIYyUu7fvmnUrPZx9TuBn/TsTqOCxSzTYjGjH+/So8sZFbbvmf+es/7QewPdNFRmK
         m0i8T8G5sAIzpVT7RV0p804/zqS02HzJbT3AJGpTQu2vjWQigtNGvqIwQkQYRn2heKae
         +UYJDQfvZI0v9JPR3ZgEbf67wM8CU+RHfmmtHR9hKiR32gwIMNfr14WLjMlJTmUviMoU
         I+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqPIxOZjlLHqaktJVr77+shSaWsG300gqfALl9uPQXibF7+3RGZGqf8G7OBVhf10l0/V++79A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tbsHA0g9RT6QdjyCrOYpV5/tB849/XbXSDm4qWZEpXilX43z
	2vrc2t3+RYSSjnjPTaIKXOptXfoVgE/YAcqvmpkHkqPgObGW8FYjrmLeMoPVg0PJIdzZprtfZk7
	wxD7BSBtdMpPxOfsy8OZMLPqsEU9VBZL5AyZ9lAOd0Z5qvsMNDo2PIcqyLg==
X-Gm-Gg: ASbGncvf2KS0WOYSRTtUYbyWP/zqZJCYigyOPKiNVSsz4Ppbv3oXbfhF5kv/ZzvWva6
	jrTa2V7ry8XaS/ZybsHPTLxVctlCOmg6+nH0LXBsQEKHRD5PnvwbbE/A+0b+JZ2hoKajdT4Rrl3
	nwDRAYs5v1WxVZGupKTkNr19vGSZn8MWBj6XRyvkzJhPLI39xoOzHCZZPJv+IFN1TWFRAuiNc9a
	cZ2bF8BUCgfM61c1lrYhRPj9Cle0jbn76lItyYqCzUVafrs0LT1S/zl2rpYNztVxj5CWUWwZ2Nl
	5XO05pCaSKtU4AcYCNonr3T4ij2RXOI/Iw8=
X-Received: by 2002:a05:600c:1390:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-46e1dad77e1mr32752465e9.35.1758644639819;
        Tue, 23 Sep 2025 09:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GesyF2ByRRbQYOqNW09UyOpostEcyx/74NI3DJWqp5z34Y6omx1cXSzjAbzY9BmBU7BQsg==
X-Received: by 2002:a05:600c:1390:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-46e1dad77e1mr32752205e9.35.1758644639310;
        Tue, 23 Sep 2025 09:23:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46dd4e52b36sm73010345e9.14.2025.09.23.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:23:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:23:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 5/8] TUN & TAP: Provide
 ptr_ring_consume_batched wrappers for vhost_net
Message-ID: <20250923122147-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-6-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922221553.47802-6-simon.schippers@tu-dortmund.de>

On Tue, Sep 23, 2025 at 12:15:50AM +0200, Simon Schippers wrote:
> The wrappers tun_ring_consume_batched/tap_ring_consume_batched are similar
> to the wrappers tun_ring_consume/tap_ring_consume. They deal with
> consuming a batch of entries of the ptr_ring and then waking the
> netdev queue whenever entries get invalidated to be used again by the
> producer.
> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> if the netdev queue is stopped before invalidating entries. Like that the
> netdev queue can be safely woken after invalidating entries.
> 
> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> __ptr_ring_produce within tun_net_xmit guarantees that the information
> about the netdev queue being stopped is visible after __ptr_ring_peek is
> called.

READ_ONCE generally can't pair with smp_wmb


From Documentation/memory-barriers.txt


SMP BARRIER PAIRING
-------------------
                                 
When dealing with CPU-CPU interactions, certain types of memory barrier should
always be paired.  A lack of appropriate pairing is almost certainly an error.


....


A write barrier pairs
with an address-dependency barrier, a control dependency, an acquire barrier,
a release barrier, a read barrier, or a general barrier.




> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tap.c      | 52 ++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun.c      | 54 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/if_tap.h |  6 +++++
>  include/linux/if_tun.h |  7 ++++++
>  4 files changed, 119 insertions(+)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index f8292721a9d6..651d48612329 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1216,6 +1216,58 @@ struct socket *tap_get_socket(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(tap_get_socket);
>  
> +int tap_ring_consume_batched(struct file *file,
> +			     void **array, int n)
> +{
> +	struct tap_queue *q = file->private_data;
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +	bool will_invalidate;
> +	bool stopped;
> +	void *ptr;
> +	int i;
> +
> +	spin_lock(&q->ring.consumer_lock);
> +	ptr = __ptr_ring_peek(&q->ring);
> +
> +	if (!ptr) {
> +		spin_unlock(&q->ring.consumer_lock);
> +		return 0;
> +	}
> +
> +	i = 0;
> +	do {
> +		/* Check if the queue stopped before zeroing out, so no
> +		 * ptr get produced in the meantime, because this could
> +		 * result in waking even though the ptr_ring is full.
> +		 * The order of the operations is ensured by barrier().
> +		 */
> +		will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> +		if (unlikely(will_invalidate)) {
> +			rcu_read_lock();
> +			dev = rcu_dereference(q->tap)->dev;
> +			txq = netdev_get_tx_queue(dev, q->queue_index);
> +			stopped = netif_tx_queue_stopped(txq);
> +		}
> +		barrier();
> +		__ptr_ring_discard_one(&q->ring, will_invalidate);
> +
> +		if (unlikely(will_invalidate)) {
> +			if (stopped)
> +				netif_tx_wake_queue(txq);
> +			rcu_read_unlock();
> +		}
> +
> +		array[i++] = ptr;
> +		if (i >= n)
> +			break;
> +	} while ((ptr = __ptr_ring_peek(&q->ring)));
> +	spin_unlock(&q->ring.consumer_lock);
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(tap_ring_consume_batched);
> +
>  struct ptr_ring *tap_get_ptr_ring(struct file *file)
>  {
>  	struct tap_queue *q;
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 682df8157b55..7566b22780fb 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3759,6 +3759,60 @@ struct socket *tun_get_socket(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_socket);
>  
> +int tun_ring_consume_batched(struct file *file,
> +			     void **array, int n)
> +{
> +	struct tun_file *tfile = file->private_data;
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +	bool will_invalidate;
> +	bool stopped;
> +	void *ptr;
> +	int i;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> +
> +	if (!ptr) {
> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> +		return 0;
> +	}
> +
> +	i = 0;
> +	do {
> +		/* Check if the queue stopped before zeroing out, so no
> +		 * ptr get produced in the meantime, because this could
> +		 * result in waking even though the ptr_ring is full.
> +		 * The order of the operations is ensured by barrier().
> +		 */
> +		will_invalidate =
> +			__ptr_ring_will_invalidate(&tfile->tx_ring);
> +		if (unlikely(will_invalidate)) {
> +			rcu_read_lock();
> +			dev = rcu_dereference(tfile->tun)->dev;
> +			txq = netdev_get_tx_queue(dev,
> +						  tfile->queue_index);
> +			stopped = netif_tx_queue_stopped(txq);
> +		}
> +		barrier();
> +		__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> +
> +		if (unlikely(will_invalidate)) {
> +			if (stopped)
> +				netif_tx_wake_queue(txq);
> +			rcu_read_unlock();
> +		}
> +
> +		array[i++] = ptr;
> +		if (i >= n)
> +			break;
> +	} while ((ptr = __ptr_ring_peek(&tfile->tx_ring)));
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(tun_ring_consume_batched);
> +
>  struct ptr_ring *tun_get_tx_ring(struct file *file)
>  {
>  	struct tun_file *tfile;
> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
> index 553552fa635c..2e5542d6aef4 100644
> --- a/include/linux/if_tap.h
> +++ b/include/linux/if_tap.h
> @@ -11,6 +11,7 @@ struct socket;
>  #if IS_ENABLED(CONFIG_TAP)
>  struct socket *tap_get_socket(struct file *);
>  struct ptr_ring *tap_get_ptr_ring(struct file *file);
> +int tap_ring_consume_batched(struct file *file, void **array, int n);
>  #else
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -22,6 +23,11 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +static inline int tap_ring_consume_batched(struct file *f,
> +						void **array, int n)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_TAP */
>  
>  /*
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..5b41525ac007 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +int tun_ring_consume_batched(struct file *file, void **array, int n);
>  
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,12 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +static inline int tun_ring_consume_batched(struct file *file,
> +						void **array, int n)
> +{
> +	return 0;
> +}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>  	return false;
> -- 
> 2.43.0


