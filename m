Return-Path: <netdev+bounces-287989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HBRNoDYBWoncQIAu9opvQ
	(envelope-from <netdev+bounces-287989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:13:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07F542DE3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 571B430378A8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2F3FFAD1;
	Thu, 14 May 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLF3Art0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPxPaDw7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106D3FE675
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767691; cv=none; b=EMByI2OySyJtu1+LvxSGJVbs2FNyxXswWlbuZKLWmlINIBilH0X4vez7H4eSfmQH06HdnVY8SXNxSr7RioHGcoR2K+QK8S7NlC7QWiugULYkQfRL3eD8IwPwz8hWCwn1qP1ylFecEj0LZES66CvB+2DU3lcFP7TSa4b9T5prUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767691; c=relaxed/simple;
	bh=zmu7aRd64dS4ZKw6Wk+/frG+xsLmxSMAdItjKBGOrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmI+++zLfmW9RJBlb5eHkyERyy5dL4nuxlPlURUgcPuLOTPM4VqWQg+X8JteEel/iLjD9jwRkA3nyx3BlYkUHUNhvIC9sI31xpT3ViQ+FugxUz0PmR8eFxZhkwVUci7JmxKzq8N3j99v5SahwyFlsnDFmdYB+yPNlP53GySaOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLF3Art0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPxPaDw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778767683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
	b=LLF3Art0zlCjlmc8wr42UynHFMui+sG4z2NCGBYlDXfb1cxHhAbx5wjzMoRAoj17t4r40s
	YIcQMIPw1akB9XFdnLbaCwNsp46KSlhjA0qw0yYIzbl0AbK8n9+ROc+9lbvX2Un0sYP1+/
	JILnjZHfhbvpvVd1jpC6BHYQZw3hKlY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-KmwIfCgCNVSzLtizFHuLKg-1; Thu, 14 May 2026 10:08:01 -0400
X-MC-Unique: KmwIfCgCNVSzLtizFHuLKg-1
X-Mimecast-MFC-AGG-ID: KmwIfCgCNVSzLtizFHuLKg_1778767680
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a122a5128so6149874f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778767680; x=1779372480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
        b=tPxPaDw76R7Jdi/7J194lnT//uEjlYQw2oEK4n8a7DeX/1WxIBI16GX2IVBnba72fX
         /D3p3f0lgQOgiUZe9caX7dUQhDS03xSYHXUpvpkgt4gAxkHLP1bVto2AYujsBTDoSYS+
         hxYOB/c8TbJH0KZVMo+iLZAF5iTf+xzPpE/lo+YVlbVeaDPJ3DwvTcG7iRJ67Oya5d3r
         K7j1gtNlTIP0t5A+xVuKs3newsyFhDGHneG3fihxhEyjcmifIWJrgq2JerV61VwrzJ/d
         Z7MMdM1kCNTrulka678246jzU4Ri3tP1JjGz4XCgFErqDj+fpWXw2B1OW3Flbfp8b/CG
         wcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767680; x=1779372480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A0YZSg/W/8L4/eAOnDT46SJMA7wk53CPNNj0OoZovs=;
        b=Q6ZfZ81YpcZw6CtO93QcAFBoKpIeuR8uFvVW/byiTGlBDC61sNJ1J3R1fd6ENe9xbv
         to8fFbxpnXLnd8Bwfp8dsRO2MXhdiytgO9vcUmyoa/uT9zho1l5uv8KedN2WzH+YSnOY
         r75eBOMHcjiILOu7bao5ZQGEuDq+PTt0E97XEvSFXK/9uh85cpU9RlaMoYqAawy2SnOg
         +LspuMwhbdFdpGIa8QIQ4n0iWvYo6B2YxKvg1Kdq0HMnpMxbmZRJFhG/f5+2UhHj8kOR
         vnmcKxZgFpPUR8hqwLtwxQ+sWr9EXOg4OkHLru+MaJIBzOlofzVusIl/YzqK75/jj6yF
         IyNA==
X-Gm-Message-State: AOJu0Yy8zZbbDqRMhvCfTwYaD+ID1UjnBZ6E7FdX32W9zfG4Q+oC6te7
	PSbGUyOmaeXWj2CPnt3hrJ7MebV+f32TJ1gvnbpR+bnm6YiUIemZ8NsbGW3wva3HoMfIBljyqwZ
	GpiimTpHKvL2srzGGJU0kV0wHZrSwhH4IzSjcVsYMpa/6PprSjSDmR9WULA==
X-Gm-Gg: Acq92OEIVTZs+BWLZ9vOKO5YdLpPRwHkHsnr34EEko9MQ0I1xgF22sx/Z146bDrMq1+
	oJ8KpV7mjl+KxSLfciLL70LBbA4MttKvsCrr8PIGwFzjd2jT50EmEzMPHzVJUxX5tuJFQeHrpqd
	PEUTStlt/XpX1Ia18GUteHMpg8jiImo7l18WkfSgrUcGQIxYpn4A7IOSOpGKgrgaGMszInAuAwA
	byh5/59rQrVBDl5jMdxUGzbUqtO/GctGFIUSvo1wKk4LYEQJk8x+eCXJT5G74yv1AGCHpz8gPFX
	VI5leun8zfBHR9NbkTILofX5lDjM1v7IFe/KAv7zbOvnVTWBTasZJWzb50jeA7t1okSttTVojZM
	EB6zIqrmUTra0hEB62ZplHqSN1dGEVrBmk63DumQq
X-Received: by 2002:a05:6000:2486:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45c580ce320mr12909349f8f.6.1778767680101;
        Thu, 14 May 2026 07:08:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45c580ce320mr12909290f8f.6.1778767679530;
        Thu, 14 May 2026 07:07:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm6741686f8f.17.2026.05.14.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:07:58 -0700 (PDT)
Date: Thu, 14 May 2026 10:07:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260514100747-mutt-send-email-mst@kernel.org>
References: <20260514092948.268720-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514092948.268720-1-sgarzare@redhat.com>
X-Rspamd-Queue-Id: CD07F542DE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287989-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,salutedevices.com,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,salutedevices.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:29:48AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse. If the loop breaks early the uarg is never allocated at all,
> leaking pinned pages with no completion notification.
> 
> Fix this by following the approach used by TCP: allocate the zerocopy
> uarg (if not provided by the caller) before the send loop and attach
> it to every skb via skb_zcopy_set(), which takes a reference per skb.
> Each skb's completion properly decrements the refcount, and the
> notification only fires after the last skb is freed.
> On failure, if no data was sent, the uarg is cleanly aborted via
> net_zcopy_put_abort().
> 
> This issue was initially discovered by sashiko while reviewing commit
> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> but was pre-existing.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 989cc252d3d3..1e3409d28164 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  	return true;
>  }
>  
> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> -					   struct sk_buff *skb,
> -					   struct msghdr *msg,
> -					   size_t pkt_len,
> -					   bool zerocopy)
> -{
> -	struct ubuf_info *uarg;
> -
> -	if (msg->msg_ubuf) {
> -		uarg = msg->msg_ubuf;
> -		net_zcopy_get(uarg);
> -	} else {
> -		struct ubuf_info_msgzc *uarg_zc;
> -
> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    pkt_len, NULL, false);
> -		if (!uarg)
> -			return -1;
> -
> -		uarg_zc = uarg_to_msgzc(uarg);
> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> -	}
> -
> -	skb_zcopy_init(skb, uarg);
> -
> -	return 0;
> -}
> -
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	u32 src_cid, src_port, dst_cid, dst_port;
>  	const struct virtio_transport *t_ops;
>  	struct virtio_vsock_sock *vvs;
> +	struct ubuf_info *uarg = NULL;
>  	u32 pkt_len = info->pkt_len;
>  	bool can_zcopy = false;
> +	bool have_uref = false;
>  	u32 rest_len;
>  	int ret;
>  
> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> +
> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> +		    info->op == VIRTIO_VSOCK_OP_RW) {
> +			uarg = info->msg->msg_ubuf;
> +
> +			if (!uarg) {
> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> +							    pkt_len, NULL, false);
> +				if (!uarg) {
> +					virtio_transport_put_credit(vvs, pkt_len);
> +					return -ENOMEM;
> +				}
> +
> +				if (!can_zcopy)
> +					uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +				have_uref = true;
> +			}
> +		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		/* We process buffer part by part, allocating skb on
> -		 * each iteration. If this is last skb for this buffer
> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> -		 * completion for the current syscall.
> -		 *
> -		 * Pass pkt_len because msg iter is already consumed
> -		 * by virtio_transport_fill_skb(), so iter->count
> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> -		 * accounting done by msg_zerocopy_realloc().
> -		 */
> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> -							    info->msg,
> -							    pkt_len,
> -							    can_zcopy)) {
> -				kfree_skb(skb);
> -				ret = -ENOMEM;
> -				break;
> -			}
> -		}
> +		skb_zcopy_set(skb, uarg, NULL);
>  
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  	virtio_transport_put_credit(vvs, rest_len);
>  
> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> +	 * initial reference to keep it balanced.
> +	 */
> +	if (have_uref) {
> +		if (rest_len == pkt_len)
> +			/* No data sent, abort the notification. */
> +			net_zcopy_put_abort(uarg, true);
> +		else
> +			net_zcopy_put(uarg);
> +	}
> +
>  	/* Return number of bytes, if any data has been sent. */
>  	if (rest_len != pkt_len)
>  		ret = pkt_len - rest_len;
> -- 
> 2.54.0


