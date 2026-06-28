Return-Path: <netdev+bounces-302412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFDkEI1pQWqZpwkAu9opvQ
	(envelope-from <netdev+bounces-302412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:35:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6E6D4A92
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TZFGP1kv;
	dkim=pass header.d=redhat.com header.s=google header.b=Al+06Iid;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302412-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302412-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA47D300D319
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFE3101A9;
	Sun, 28 Jun 2026 18:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170D40D599
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 18:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671740; cv=none; b=YuD4MkRUPeO9a3+6gTBHgGJTYYtQKdxR+ihAY2s/BiTKo8quDYKR/0kVHpnBbpwN3acwW4pw2TUnfDmu1zYf/T5nZ7XTTd/w1nuIydwEAC3o51Chx5eavG/Iqwt1UpwDYw6POU3WASJl0+XOfMXIWeExhucKJT7kQGW+ZfKkjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671740; c=relaxed/simple;
	bh=NpueuavD31w+JK7qclqaceH12pxs8f2Li/NN2onxLz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5cisA/U0Levkq4jlVqVy4P3JFm686DSpJjquVcUp/1Z+JVfxPbr9DQ+mEFCkH/1qplkki/lsyGEtZ3+WSgmdjt1OIHoPDIaWoM2l7V3/Y5f+bEBR+2mfDq8a6SkuBf6exiQVabPm1ff1J+q+zfnphFr0NXKcu2xNI44dffWkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZFGP1kv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Al+06Iid; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782671737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
	b=TZFGP1kv/hwSGOwJS8GLC71uc0epPnIae7EaDdJUBHw5YxLALtq/nY1NT3QpCduFADHUme
	aMe7cCoKf6R+1OfaEpq2DHt2NU5VxoPyfQ3tS0u7+7xz0HQnnkXiqqcAhfg6Vgrt/EGjyX
	XyUJ7PFpNkQW4UJZhkV7XusfjytKUnY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-V_-HPrRPOgaCWn1IUoehZQ-1; Sun, 28 Jun 2026 14:35:35 -0400
X-MC-Unique: V_-HPrRPOgaCWn1IUoehZQ-1
X-Mimecast-MFC-AGG-ID: V_-HPrRPOgaCWn1IUoehZQ_1782671734
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so13549525e9.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782671734; x=1783276534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
        b=Al+06IidoHwVGV5GWkOJuz8/MzemOBKp94avYkB3yl1nj+Jvxo83M4FkaYHVnsZSQk
         Rd8tOguq+p5uJy2THZePasdpS3KFBpFoQ7q+sn6uMgnBihdWiyF6bN7I4V0dbUxgwZyH
         TiRFneVKcyK5aYEdbNNl8ANtwSEyYevoLx0Pv7cG/FnxoymLWw6O8v1zsm2FaR3xNL1b
         v2/ExmKAH6sHll6ziFKaak5J/3jPWRjJJCc2KRzH/p5w8DX6cvel1fxv3LuMGQOAVmI5
         dXrenkhpW/v+XUMePtHSAg3KHISivW47O52QIHoxEJmL8STQdGQTz9svoI/b3S5Pm3p5
         cANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671734; x=1783276534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
        b=UeMn3VLn2XApRO/5xdECSkcDEyH/ypLrQgsjoRDRIs/iHGGhu1RniVKDi6wT1ybpRL
         jOv0l/nc/3efgvYQPwf87950MjzxiayhvhkSksJkmTtC+Af33/Xf+3aoEAEd8QH5nt1y
         NNpU+U9e38RtuhA8Ot9Dcd4aepzu/SDCz6IDrTc7m2EwMz83PxDvmMCdpegfWl8V2Cri
         VfddMZIBNgl72x2cpghBZR6Y0VeEGo/xcfyeJFr95KLeWt01LxE1HPhQDER9yP7/2OgJ
         iH6j35trNpDDxh5haP4koFnEdIK1zJ/ZP7XvCXzPJpx5Pkk0D5Ocz0FnOejqaX9JoUlh
         MGzA==
X-Forwarded-Encrypted: i=1; AFNElJ/JEeKUujjnfdpYupnijMnqj4TrZSergM8f3CPvsayu0dCP5vWPisTPH/YfbhpgNDyUxUW8qXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44d4AgRSbT5PnLy9IQ3BcubvCDUQELQ7IsvzbugjQ6sdcPz4h
	SbcP8NzARcBeDRYUec3AupiBWfvbXn7hIWh43kW1I3E8JDACQrvwkUJQPVqNnBWTxH7J5JMzM1l
	ijKehc8PHWnpWB5nk+2ZNin36+5bgeA4MIw5ZK9WJOpMTVL6qZAfvR6S2+KwyIP6lSQ==
X-Gm-Gg: AfdE7cmqjAzAuoB4E4A9y4+REHDyV9l4RrOAH+D4DKkaz9Vo3M9ZtGCUdMLh43Y1pft
	hxdvb6Q2erZ+VsTvMC6vDB4df1S0oPBjnjOqRihhtzn1QefR/jbQz10EPPTjVy05c98Rp+pZCxU
	qKDSnPVB3opOBr3AEKHCfJ2HmUbbcUMTDn2H/SFmnWv0m9NW7DEnUUa/70o2nfiCv9f2vdDWsyQ
	07C8SB8/QoUXtI+RElt39lw/aK4PyhCK1/DT30orsHlrgyzLpZl6HiaL7HXIvM+qSUoVlSM7x1g
	0pd52yQHh0YukCKSDtsUXfGy9Xnov6+eKwLS0D5+HegtOf1FgIkuc3A7JyZ6DJLX0UWf55yr9C3
	1lhs9lUsZMK9qd8LWi6Pj/wE6S0ylKCOT
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218775e9.14.1782671734336;
        Sun, 28 Jun 2026 11:35:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218565e9.14.1782671733893;
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm9226894f8f.37.2026.06.28.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Date: Sun, 28 Jun 2026 14:35:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260628143523-mutt-send-email-mst@kernel.org>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302412-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,meta.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6E6E6D4A92

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
>  Changelog v3->v4:
>  * Update commit message.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> -- 
> 2.25.1


