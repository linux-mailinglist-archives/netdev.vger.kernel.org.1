Return-Path: <netdev+bounces-211675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED356B1B1A3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9167A9ED6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A42580CF;
	Tue,  5 Aug 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccQ2XHSD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20061E9B2A
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388134; cv=none; b=T4Sk5BRoFR+mJPwOnElBtTDVsLJu8CcLiCQIjsJU+PDNJQQ204bIGUxPdGtQgRYxS1pxS6S99WgR1wBQt8eBjfa7zbTgvCvRK5Zs5R4Y3C5WrYe027/0csA8JXzA0xDh6fUGnhNKghHWyDTFOu8ORuvAI8+YmRwcXwmbru1BWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388134; c=relaxed/simple;
	bh=ghVc4jUywvAFQR8Cbgq1AJpVrOuHaExsk9z8LbGUnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4SkLOODYd4L/R1r+mQ++r1jDJxEb0e0aRsfGn+WlXx1ORLMnpBvbFWmdpwCgD405GRILyP/lI63Efk8GbuShEd7TEJ28aEb6lJ+9oimDBbJQMh2ZM7PaWh7wRJT9nJNlqODBtLOzTX6mJ8YE7sVimXhhc9QRNl4zb68b8D8Etw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccQ2XHSD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754388131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8iq3DcQDje5KaWsGWyrnSm7HvAQMMkFMgKVgyZHegI=;
	b=ccQ2XHSDfFZ4MT0Ppu2Inx6A8Lcumf5RxtcBADimZD4KV/Uea/mMLJ+T5XfNLYbrgTMBMV
	g5DFO8gCsyyKrg7jshTTagG38yV4mQbSa8lIXos2dlo73ftuf1J6Gm38JpiEVUYsxzp8WD
	l5lPw+4OVZfHBn38++A/LJbsH8ypwNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-gsoWdgQlMCuqI1hiaxRC8Q-1; Tue, 05 Aug 2025 06:02:10 -0400
X-MC-Unique: gsoWdgQlMCuqI1hiaxRC8Q-1
X-Mimecast-MFC-AGG-ID: gsoWdgQlMCuqI1hiaxRC8Q_1754388129
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e30e4477so2837045e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 03:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388129; x=1754992929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8iq3DcQDje5KaWsGWyrnSm7HvAQMMkFMgKVgyZHegI=;
        b=jIPLtNaXxMOXXmn/xaWKqDiaMr8uSWRSBHNRX9phzNEfITjaBECnLf9DZ0gwvpBHtz
         lbmNxcdPJlvY4WQh7WVDXhcJEaxDjcNpik9SxMaDFQk+cDCv89VG7yAnoAx74T5Et/BM
         9uq7J221ZEooCJB0O0UAnk8rFvgVpR4dkCTQq7Apj3Lbrfx1rZjisgOvhH1eqlF06J4V
         W0QY3YWAJXQ/sAMCwkLdyLEyqw+zAlDif5nap6eHczF3tIIplk7TzJnQDYok3Gpo0OEt
         DuYoLZ6eSFe6m+Y5eUxztUhmBiEwjjhMZsmUm6Y7NP6M1/ABev7SoxCIG2Iu4LjOqhQr
         uWdg==
X-Forwarded-Encrypted: i=1; AJvYcCWt8ZqWrjvx9+DtIwtX9KwIu182bIlFE+E7zda11LCXvXZ0GkgoqhGDT2qIj7JGu5eldqRkkQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzVxOJejPPY7TcOg8y32DaqTASlePqjK/ytBFlF/SRrwfk1Lc
	PoJIkTadb4lg8aqiWall/B7XvXvePG7jzeg7mBWV4rI+izg5DeSntWEdlb+gEH0RL9GEnSDHnS2
	R263BK84il+D4tuDnA+mObr5WMZL6rbErQun+Dd0qNNTFilPq5BS9uLzgIw==
X-Gm-Gg: ASbGncuXwo49jUhZjv+CQgYf4Rdu3SdjhT95bn/k2j4nY1crnih7Hp+88Y3Fsw7Quzz
	J24jp+akNva2jnKgbFONPiLpB6HPpwYTNlx4JIyP1ZnNZv3AyUNYvYA0ijBMOaJQ/N0ZoPImkFw
	8jx3VvGgGuWSt1AqKbzuRL/vGbrYsdqsoFk08/O+m1B5EwilErFjgY3hGpxcYfzSuNNixZvU08v
	Urd0w9ftNk10pzFdD7kkdmQUscfipmHLtfcMasYO8czKVIEGtUdaonlJcz053o52M196NnsSifC
	h/2ew+i+W2bdUi3M/Y+qdfzXnetvJ0E/
X-Received: by 2002:a5d:584b:0:b0:3b7:924a:998f with SMTP id ffacd0b85a97d-3b8d946b3a2mr10486261f8f.5.1754388128677;
        Tue, 05 Aug 2025 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0h3EuzIaMa9Wir/mQMI0EF1I5NZk8tEiHqXjJLyBPOFpTj+sXNt2uVT98K1ru7T8YB22hmw==
X-Received: by 2002:a5d:584b:0:b0:3b7:924a:998f with SMTP id ffacd0b85a97d-3b8d946b3a2mr10486210f8f.5.1754388128107;
        Tue, 05 Aug 2025 03:02:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm18532205f8f.67.2025.08.05.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:02:07 -0700 (PDT)
Date: Tue, 5 Aug 2025 06:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lei Yang <leiyang@redhat.com>, Hillf Danton <hdanton@sina.com>,
	stable@vger.kernel.org, Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in
 ubufs reference
Message-ID: <20250805060149-mutt-send-email-mst@kernel.org>
References: <20250718110355.1550454-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718110355.1550454-1-kniv@yandex-team.ru>

On Fri, Jul 18, 2025 at 02:03:55PM +0300, Nikolay Kuratov wrote:
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
>                              // &ubufs->refcount == 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_and_wait()
>                                                        vhost_net_ubuf_put()
>                                                          int r = atomic_sub_return(1, &ubufs->refcount);
>                                                          // r = 1
> int r = atomic_sub_return(1, &ubufs->refcount);
> // r = 0
>                                                       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs here because condition is already true
>                                                     kfree(ubufs);
> if (unlikely(!r))
>   wake_up(&ubufs->wait);  // use-after-free
> 
> This leads to use-after-free on ubufs access. This happens because CPU1
> skips waiting for wake_up() when refcount is already zero.
> 
> To prevent that use a completion instead of wait_queue as the ubufs
> notification mechanism. wait_for_completion() guarantees that there will
> be complete() call prior to its return.
> 
> We also need to reinit completion in vhost_net_flush(), because
> refcnt == 0 does not mean freeing in that case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Suggested-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Tested-by: Lei Yang <leiyang@redhat.com> (v1)
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>


Nikolay should I expect v3?

> ---
> v2:
> * move reinit_completion() into vhost_net_flush(), thanks
>   to Hillf Danton
> * add Tested-by: Lei Yang
> * check that usages of put_and_wait() are consistent across
>   LTS kernels
> 
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..69e1bfb9627e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>  	 * >1: outstanding ubufs
>  	 */
>  	atomic_t refcount;
> -	wait_queue_head_t wait;
> +	struct completion wait;
>  	struct vhost_virtqueue *vq;
>  };
>  
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> -	init_waitqueue_head(&ubufs->wait);
> +	init_completion(&ubufs->wait);
>  	ubufs->vq = vq;
>  	return ubufs;
>  }
> @@ -249,14 +249,14 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	int r = atomic_sub_return(1, &ubufs->refcount);
>  	if (unlikely(!r))
> -		wake_up(&ubufs->wait);
> +		complete_all(&ubufs->wait);
>  	return r;
>  }
>  
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put(ubufs);
> -	wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +	wait_for_completion(&ubufs->wait);
>  }
>  
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
> @@ -1381,6 +1381,7 @@ static void vhost_net_flush(struct vhost_net *n)
>  		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = false;
>  		atomic_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
> +		reinit_completion(&n->vqs[VHOST_NET_VQ_TX].ubufs->wait);
>  		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  	}
>  }
> -- 
> 2.34.1


