Return-Path: <netdev+bounces-54637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A0807ADC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8911C20B6F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B2B5638E;
	Wed,  6 Dec 2023 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQDJie59"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77172D5E
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701899634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
	b=eQDJie59n9wMPHQz3sp27gDgqCJvSlq+VnLMWo7vFOEUqmbGIoAB4J6Nf8ELSrSrXHM2vh
	zGoOOcQwHRdtgXOK12n7aiS+TBMVFecFjq8QhKgKH2KPSkRSz6g0z0SfQXgf19BtTP+UzA
	CYJ/OvxQlLu3Ay5Kgrm6S1AVXIK1fhI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-0K2g9XJMNjedg3PU-moAtg-1; Wed, 06 Dec 2023 16:53:53 -0500
X-MC-Unique: 0K2g9XJMNjedg3PU-moAtg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3333aaf02b0so217842f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 13:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899631; x=1702504431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
        b=B7Ct2MQbtQOCyRCE/J4KdC5HUqYC1No0IhGO0OpJzY9Rm+aza/qR1RdgMBtd6rL6cU
         nc2JiV2S2gswTnnOTwYqf/e4jHRXKhVufcaD2mRQ3Ql441SDcaOJfI98DC348oWVMUaD
         p3jBufLX9c1MRXGFW5KLKR/1cAdaAawwDAe4z/68TSeZOStFxYVk9Bcl6gLHFGul8L/5
         NPsiLS/rn9bX7cag+JR/mUVtDt1Bau2mElBRVxNPbsrf1x/vi8U8iPvXnye7281BjA5S
         I5PCUz123NGJpp+Y9IH32sO81yokbz1FbbaY80+aMtS12F/AgsSKf/7n/PA54fOonl6n
         UiWg==
X-Gm-Message-State: AOJu0Ywibz+LAhK+iWESndfmRgoNp44dRrXNgJ9FCtk43W2/W+HsZONZ
	mgu5biE6JviIoqx+qbCn9oTNXHVFvI5SX63Rt99xkXP+bw/WkBrGq5imlK9JIO8etC4egtz2f3U
	enZwjI8iAshOnmlg7HOYJ4ihl
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416131wmc.125.1701899631158;
        Wed, 06 Dec 2023 13:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKupXK9Nk8V+FfPP14UqB6ekz3NO+3af+wasE4pH9WneljAze4p+zMe4/8H113wgoXLXea/w==
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416114wmc.125.1701899630826;
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a1d8626d650sm435564ejr.208.2023.12.06.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Date: Wed, 6 Dec 2023 16:53:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <20231206165045-mutt-send-email-mst@kernel.org>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206211849.2707151-4-avkrasnov@salutedevices.com>

On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
> Add one more condition for sending credit update during dequeue from
> stream socket: when number of bytes in the rx queue is smaller than
> SO_RCVLOWAT value of the socket. This is actual for non-default value
> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> queue to wake up user for reading data (in corner case it is also
> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
> not.
> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v6 -> v7:
>   * Handle wrap of 'fwd_cnt'.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> 
>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e137d740804e..39f8660d825d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	size_t bytes, total = 0;
>  	struct sk_buff *skb;
> +	u32 fwd_cnt_delta;
> +	bool low_rx_bytes;
>  	int err = -EFAULT;
>  	u32 free_space;
>  
> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  		}
>  	}
>  
> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> +	/* Handle wrap of 'fwd_cnt'. */
> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);

Are you sure there's no off by one here? for example if fwd_cnt is 0
and last_fwd_cnt is 0xfffffffff then apparently delta is 0.


> +	else
> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;

I actually don't see what is wrong with just
	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
32 bit unsigned math will I think handle wrap around correctly.

And given buf_alloc is also u32 - I don't see where the bug is in
the original code.


> +
> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> +	low_rx_bytes = (vvs->rx_bytes <
> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>  
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	 * too high causes extra messages. Too low causes transmitter
>  	 * stalls. As stalls are in theory more expensive than extra
>  	 * messages, we set the limit to a high value. TODO: experiment
> -	 * with different values.
> +	 * with different values. Also send credit update message when
> +	 * number of bytes in rx queue is not enough to wake up reader.
>  	 */
> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +	if (fwd_cnt_delta &&
> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>  		virtio_transport_send_credit_update(vsk);
>  
>  	return total;
> -- 
> 2.25.1


