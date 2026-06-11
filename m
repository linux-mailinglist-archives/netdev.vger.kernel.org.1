Return-Path: <netdev+bounces-298217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pl5qH3jjKmqPywMAu9opvQ
	(envelope-from <netdev+bounces-298217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59167393D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:34:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="p5txUp/x";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298217-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298217-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AFA03059A4F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CB4279E0;
	Thu, 11 Jun 2026 16:24:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DC42DFEF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:24:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195094; cv=none; b=sCVBZP4oiFRJOyy/DVAHkjDOCqvXGoGWA2Y5eY5xUclrhV/zdRspELN0hAhz049Lfh5Qa8vvy3LkT7k1lBaPLdZ7vqXN2M8qj/1sRr6wFGqjXM51qXkhApUXEZyi2NbVHn3FoTn5GSKOuMlTkeSyXuvIUhVxQzKzQ0R1JobxLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195094; c=relaxed/simple;
	bh=6y9b/y+mwIlmIt3T9GWYo/xRhdsQvmmJFA2Lw1sy2T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spvs408S/MqVoZy5JdsMXQ1MFHQaah9WW1vCKtEO2KfYvODAq8s7gw8R1Yh5JL86uzuOa9mX5nJPudwcKaLri76CARlBaq4iDQhJKoAtbVXFsLoRHX3gGrW6CZ+moXbm82QUyHDkbd1SnYd6FQXrASJ92bzb1BMhuAMQyaY6bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5txUp/x; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84236f9b638so62101b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195092; x=1781799892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GIVt44QUH/d+IWxlXuw18ksP9yT6I/Eko++PuSKJGA=;
        b=p5txUp/xuWmz0qf3lyvP25/5+Q5YL0OJWturDaSYTq7nsNxZzJKd0YmfWSiZdoGl3i
         Oe5lxEoW47DGb8BYyDPWcJIgeHJJvQH+4zghzJMPoQ6BGjleFHizz5jM+bBFBqltKILI
         ++5c3ZPYVhWn6cUY1t/xi0nruIbO43/f0WnfWF1wYCf941GxaRlkYxidP5I9MKRXu2KS
         jflcWLIc2JQpeNt4OJtY6/bgUT7h/x0XC11Xo733d9+dUEtGkbk5ThBq36rJWjWt59hH
         pGTNAx2j/3bStP0S9Uh7Rx41VRaaBYChVXjJoyWRG5RdTqGDq7JvVb69Q1IOSQ5IUEZX
         4Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195092; x=1781799892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GIVt44QUH/d+IWxlXuw18ksP9yT6I/Eko++PuSKJGA=;
        b=b2+8EQ4wfxthCBmFCSAl2IU38K+BSbBAgUqerYQJZDCbifv5kKycRW127Y05Scvt23
         0Dm0CB3yiPpsdeXtke5rSVKiqjewmxNJmERZ29ueRGKaaYb491P7W6uLQ5cIREkEEqqs
         qO5gvK0Wf1UMSq074fCETwh2BrRD5JB6boQF/p41bWgZQl+KsTqr0357hm8WTD3rtWfN
         5C7tOik1U6qWmAWfJQSGaa26TOVPCcBHhoTvU5o6wHrCmc0bBrpJXvXV98WJR5ih+hUk
         hdeQKJn61S4mGXdtneOXVe9yZeRAboe6ebb+YsAZ/iRQ4Lft0lOjcUhludqmUyyeSv42
         q0GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bU0vtwva5BcnIR45oyOqiN1TqIVtkHxYEeW6Mnn/SdskjocqfAzo8ih4LWd8MIm9JU9OdKTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzya4uTEk869pra/t0YT/ICz5D90Od2Ffjx8aNotIKukUQnufOG
	hvV/7jRPMeEMR5o+VvdRSQ1dEVqR/jUb4ZioYTLZgTdk9nZ+UvbChXnx
X-Gm-Gg: Acq92OFvqjzoamxhDDlB7+cczquWPgYPz3u5c8eY1LEIYjW+N6XBtAMRv6Q7NJPZh58
	PDMH0bS7nyg3cq2MiF6pw333yd4iYpQDfh2zHBTn7r3KHqAV/uVtkwJLQTL0gukEb4/7tBfjz/A
	r2JF75nR6Py9nELxlqFgWON3PKxs0497NYmjJSKf2H0+qmspq8s79lBSQ0UAYg080xtnny3m8HN
	zuffHmNaC9YyBV7J27HNZTctHOyhkiCOhdISHkegZKtfLFyUfyRfMXCgPlH+PTlSPZsxNMp/AiR
	+SVtjePSAxmn7KhLePl39oGkWSmsMMvvtqxNwh+r8in8H+P9VKNZO4qVHYsxkH92+ABr6Vshuy0
	fFqs+HNdUeGm5WNGAAm6yCfukIqViYI2o/7lcnHVrSope14E1ncmqTqiHfcO0Ud/KGiC+9UkZ43
	TiM4bnrBzRFb5+Jgf5ia0TX7bVmTKD8Ar86me+Yo3CNW64RQ7JoPG4PSWfvRpTeO/jzUzqjaUit
	4teHd/a2Cm98UF0
X-Received: by 2002:a05:6a00:3991:b0:841:d0a9:76e with SMTP id d2e1a72fcca58-843367db2ccmr4131774b3a.5.1781195092027;
        Thu, 11 Jun 2026 09:24:52 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0c:3090:eba9:46c1:1423:bd93? ([2001:ee0:4f0c:3090:eba9:46c1:1423:bd93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bce087sm2520701b3a.22.2026.06.11.09.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:24:51 -0700 (PDT)
Message-ID: <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
Date: Thu, 11 Jun 2026 23:24:44 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
To: menglong8.dong@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298217-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,redhat.com];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F59167393D

On 6/11/26 09:56, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dongml2@chinatelecom.cn>
>
> During packet receiving in virtio-net, the rq can be empty, which means
> "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> can be empty too, which means we can't allocate anything from
> xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
>
> However, if the user clean all the data in rx ring and fill the
> "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> napi will never be scheduled: the rx ring is empty, which means we will
> never receive a packet to trigger the further recv fill. The rx ring is
> empty now, so the user will not check the flag too.
>
> Fix this by set the XDP_RING_NEED_WAKEUP flag before
> xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
>
> Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> rq->vq.
>
> Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..4b5b3fa62008 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   				   struct xsk_buff_pool *pool, gfp_t gfp)
>   {
>   	struct xdp_buff **xsk_buffs;
> +	bool need_wakeup;
>   	dma_addr_t addr;
>   	int err = 0;
>   	u32 len, i;
>   	int num;
>   
> +	need_wakeup = xsk_uses_need_wakeup(pool);
>   	xsk_buffs = rq->xsk_buffs;
>   
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */
> +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> +		xsk_set_rx_need_wakeup(pool);

I think when polling the receive queue, the userspace program needs to 
check the XDP_RING_NEED_WAKEUP flag if it does not see any packets. The 
flag check is quite lightweight in my opinion. Here are some examples I find

- 
https://github.com/xdp-project/xdp-tools/blob/e9469501622aa22a7e452a671000bec8685edcde/lib/util/xdpsock.c#L1206
- 
https://github.com/xdp-project/bpf-examples/blob/43e565901c4287efa863edca7f0e6cd6e35ed896/AF_XDP-forwarding/xsk_fwd.c#L540

Furthermore, the XDP_RING_NEED_WAKEUP flag related functions does not 
provide any memory orderings. So even with your patch, I'm worried that 
this case is possible

kernel userspace

xsk_buff_alloc_batch -> failed
                                                             submit fill 
ring
                                                             flag != 
XDP_RING_NEED_WAKEUP
// reordering due to lack of memory orderings
xsk_set_rx_need_wakeup

I'm not expert here, so correct me if I'm wrong. I think the wake up 
flag is designed with no orderings so we cannot rely on it to reason and 
skip further checks.

> +
>   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>   	if (!num) {
> -		if (xsk_uses_need_wakeup(pool)) {
> +		if (need_wakeup) {
>   			xsk_set_rx_need_wakeup(pool);
>   			/* Return 0 instead of -ENOMEM so that NAPI is
>   			 * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   		}
>   
>   		return -ENOMEM;
> -	} else {
> -		xsk_clear_rx_need_wakeup(pool);
>   	}
>   
>   	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   			goto err;
>   	}
>   
> +	if (need_wakeup) {
> +		if (rq->vq->num_free)
> +			/* We have free buffers, so we'd better wake up the
> +			 * rx napi as soon as possible.
> +			 */
> +			xsk_set_rx_need_wakeup(pool);
> +		else
> +			xsk_clear_rx_need_wakeup(pool);
> +	}
> +

Why do we need to set XDP_RING_NEED_WAKEUP even when 
xsk_buff_alloc_batch succeeds?

>   	return num;
>   
>   err:

Thanks,
Quang Minh.



