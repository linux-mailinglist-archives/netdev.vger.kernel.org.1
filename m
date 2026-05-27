Return-Path: <netdev+bounces-292420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA87LIUzF2rd7wcAu9opvQ
	(envelope-from <netdev+bounces-292420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215F5E8BB7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D5DA3049235
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8F3DF000;
	Wed, 27 May 2026 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Yn8NdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1433A6E0
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905372; cv=none; b=oncONooo2k5Ch9y2Zog3KHti+0sa43LrYOiRmWpMza85CjIYXs6KgOBAXJ2Fa6jnk0MUjPw5D6NsmIRFYttWdcg/6Jy3Z9nREXa1ClWHPTEdtdygkGtDjebwkLCL+nHTgVVlK0kFDDjmkhCkarjUaD8p69Thc3e0SEvOsuz0HzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905372; c=relaxed/simple;
	bh=htlmsUpxEnizeUP3B6xI1XKO3j5rovXUVkrwa4G5o5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/YeydqHmJxhudOD6RHM0jHxnLcn4hqBA7uOQBUfYBS1KucG+6AP+ai8OQJUzGf5VEmHZOwdgaYrMLg98SwftX1fn0socZWEC6GlIiXZAauPp6xgzLF82SDEhw9ehfjq0/PkJ+cVsNIGarBGOyVQ0VYjGUY1+NsCc4GcQfUqGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Yn8NdN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ed9336049so1688486f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905369; x=1780510169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=F5Yn8NdNL9c4NbDDRW5PZl20wXG3n3jyg0nkznUa8TAGyHolFlWmsExFaafP3VfDZl
         yNGYsB/u+4eAHMVSk6/HJKadwiUL40EJJLSCElu4i7HILGjdebPN/r6OVfN3fzyv1O9/
         Y0Gx6Z2bUnRwif8Dgsza4mqX8SSL8+eG5QlyspygG+nsNKOgylrTPrXTC9OB9phhZZY2
         d4X6ZxBgguZNpfATgF2rEPQkqEwtxptm1el7s73vJVBSXUwI06FFgq6X2A9eKvsEy2dC
         9u+l4JDfSNmmvBn7PFSBh5fOYEh9INedHcR2/caTc/3ExznQqJ6pfsgdCH95UqYK4gm0
         O6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905369; x=1780510169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=NsnEe0cG/w7MmCUQ5IPDuw/kgToqAdIezDpv8Juv5XXYZkJcTAUCogLQ3ocKpm48Z9
         2XL3rS+scr1EPi4ynIcArfVpdc/RkFt0/UGh0Lrbzbk+KKUSRvjsqzrPB58PY/fseiXE
         ITsSzFjGhoDmnigxwlnGxAFtwdrGg4d1ltHSrnQj+3Nc4Nh7ha7+pELfMlATrGVcSqQF
         9dK+jbUyluEIg++pB823Zyda0kcbw7AUNkyh32U9FIL27eQiWAa0BZHZli8GfM5W0Gr3
         tdVCej9WasArKS3LyHfYeuHoWTDdY9OIRpmgZBtkQ9xAyRxMhxBdKSnR5b0gOPH2MQMx
         lZ8Q==
X-Gm-Message-State: AOJu0YwTX4fBoGDtxmw28gL1NpnBlaAdTnk7oDJDMk+T7BOJcAz/7ZGu
	0hJQTKSCNo2wGOQFxj3RBlChN3Jq+ziQvYOJ9yym0OPFtbIyAYiQzp6b
X-Gm-Gg: Acq92OH+ABZbhVo80Kj03zAc2QSFV5oducyQoUGAye8rs+DihqLZ+Q7QVnTnSPFomi0
	rwgZggthR6a7sO1kzYc0IpEVjvi1e/T2fwZUgzR/6glTWRPjz3VeBJdXYby9AR5wMh9UVVCOkxf
	VQAvYb62Jl74yWGxtlCU4iK0acdFniy6KC9mBqML9uXAeeI1x+VLIw3O52/Iql2ywoWaTg3+rMg
	qWNXb46ez7cPYNf53PKdHdV73WR8Jg6OhpQJDb6zQ8/HRM7RhACbHDhQiX0soHXT6IwlCvds+9b
	HibYKW8tUuF6ux2Nyq2+Yd0TuUAeRWlzNrc95e+WZDz86ZBIJ6bWl+SCOO6Ay1o2LI9IOrHzYgT
	QsoizyqP72CZgc14GbIWrsBM6Bp5sdoMK7++t95D9HK9hXIpMthj29TV4hYBFAoJ7MGZGaDuq/W
	acNv0nnSFsSs4ehqAGfo1z2kQSPscaHF2rmFJ6P2SmFadcQzDOlJ+an+EpoNR1p2OX
X-Received: by 2002:a05:6000:461a:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-45eb38a8032mr33753535f8f.39.1779905368393;
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558449sm7086121f8f.13.2026.05.27.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Date: Wed, 27 May 2026 19:09:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527190926.1a2d6095@pumpkin>
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
References: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292420-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3215F5E8BB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 19:10:46 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> Let's revert this to avoid unnecessary 64-bit multiplies on the
> per-packet receive path on 32-bit systems.
> 
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

FWIW:

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b143290a311d..d4d26fba9e37 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff


