Return-Path: <netdev+bounces-292399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPN+AcYgF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:50:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA675E803B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04C5B302BCF5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DA4418E4;
	Wed, 27 May 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7S5Urss";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUcTm7db"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50D3EFFB7
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900589; cv=none; b=P8CLS1l8n2fZPewdyMWZEphUYr/JA6ATcvUWRq5ovOAg/CjftfPKVUfvfF4Mg8MDolKdaT62JAxrrTVWFynsYdEi6qOgRsWKa11b60Hs7/pi73gSFkWlsSknV4lOSD9cK6LgQovDNqqOz2maApu24dP1IQKqMQKPYLm+ANuL+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900589; c=relaxed/simple;
	bh=TnSgeay2CUs5BYvI/ZhWaS19lMNFDZqGeqXNxn+jFqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqly51sMBKfDz3Urk7BKc/MsThePEUSXKU15cJRtQQYCTQ8iGWINbIarjmQEZgGZ8WKRvgFtsPv2B2fj6vULY3jtOCj84NsrZdG+TQ7Rtq7cGhXW4RNMNxiv24CwQdFJ3nUwT2BLviMey3zd8stWlPWi4lc9b05HCscT05AeAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7S5Urss; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUcTm7db; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779900585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTkmNQRyg9gWSP0GvLk20jWUq0q72HEW9jYmpmAF2qI=;
	b=W7S5Urss4bTEgECXn9Nk84+9/2bP47I+pC5dKrm/55kNoiOuM6+kUGxUp1SuGAcRahWqmp
	cG91+akGITFO+kREoPbZSsz5VygzzsdFByMiCZXsGxkbVIoV/TFXulfkpKL4M1XipIL5rl
	F4vfEVdfwHF0ue0tlW8d4IkYUSzwGdI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-4lcoNJYDNX28g4uKjJNVQw-1; Wed, 27 May 2026 12:49:43 -0400
X-MC-Unique: 4lcoNJYDNX28g4uKjJNVQw-1
X-Mimecast-MFC-AGG-ID: 4lcoNJYDNX28g4uKjJNVQw_1779900582
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso10319963f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779900582; x=1780505382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTkmNQRyg9gWSP0GvLk20jWUq0q72HEW9jYmpmAF2qI=;
        b=UUcTm7dbnYDLBXV/uW7Gm6unHwbi52Gzjr2elKcCrlL27m9H3GXUDVQnPLc7yB2E6m
         OYyeeVUr8PbTKeTSpDbOcEMlWY2jPXcMwBcyJapahwLPmzGTobz4hYXWXXLQdHcR5NPw
         OxGRMBRsxeVoj3qZFDCJO4U4twgEE28BahxLP0Y9SmxJjafdXFFtEL28nrF1KRSjN5gg
         l9JHpMps3Ty8+ZcgO2L+E/v0w9LLATKXSdwTz7fNkRfaAKc+5pFr1cYV8Jp/Rdclv+0R
         0PqLYe51EmmsmQhwk0UoFFvevkSkG179fX3wTkQk3qYnxanXRxUP3z1JcjmcAZ5cFp+W
         b8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900582; x=1780505382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTkmNQRyg9gWSP0GvLk20jWUq0q72HEW9jYmpmAF2qI=;
        b=V95jdMuwCUnhh0r0l8fB5yoOJTn+uaiG5VjiGRlLlx5dZ1B0UlmzQMj1HPLEnYP2o2
         l3THDgLrpIVP/Aorga8h9iLD82k84iFQA5e8Lvl+e79ZK/tmXY0snis8fe4vMd43VJo6
         ppKSalML3MF9iGYQd5xQGcG5w0bWIra3oKl93vgyQqAnFJuofcc8aiTERH8zeBmBd/y5
         eaKYkw0p0FGvsXc/ADOYKysnwFl5xGWz/QHuAF+TI/ETzjiOyblRFWMTj+jTJbeXJOMf
         /ub0z6dIPVmgR733+3EFDcsj34Rqx4C4dtWFqdslh5mKENhCTwO0+tyCjVSe7gax6nkU
         saUw==
X-Gm-Message-State: AOJu0YzUqYCZsY9vyTNlUBb3SiWjp+MkzqERp7RJtRLEJWDlikJCb3YB
	AEYHIQdUyqeScQuGDTNu7NxQscbAUODLobjw38Mne4qCzpxWhg6ir/QvRj3/yrs4iTwmMMLcLXa
	wNSYR3bFuwleTQI1hTGf9v5zqOBvYTG1B0uGSuhdtx2yLPTw9gDYmgE0owA==
X-Gm-Gg: Acq92OGATqLiW/L5CLp9BYhwPCFJST2NN2zwQLi5oA/jvbtcySVfi8ftLT/vBRPktol
	OKlxUADrj7NXPLY2jl7MrPNYNsEAWVjujzXv0L0akUK/YDHqswaCkMxMiNIRpvH8JY2YBZrSMWt
	oNYtB1luX0bwu0uI+b8678vYteviMtIQeYK0kwBg3+bUX+egClpM/0tkUtuCvLQ9fGBalQn0Cen
	BYcQZVaURyoythrcobquSR9K35Sf8pXToslTlpztlEtV9K/WXisuU2mjKDCTmoRTmGXzzjFt/Y1
	Eaog6iitG9/h4KCTGb4w7/VFMJ9vP2xrcNgszkYSGbPxWxAqG0+kdXZPfPe97FwoU4VidFucnux
	lYHonzU5L4T1OYogn84jS/yc=
X-Received: by 2002:a05:6000:40db:b0:45e:df08:b02 with SMTP id ffacd0b85a97d-45edf080c6dmr3334576f8f.28.1779900581895;
        Wed, 27 May 2026 09:49:41 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:45e:df08:b02 with SMTP id ffacd0b85a97d-45edf080c6dmr3334522f8f.28.1779900581419;
        Wed, 27 May 2026 09:49:41 -0700 (PDT)
Received: from redhat.com ([31.187.78.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54959bsm7881042f8f.1.2026.05.27.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:49:40 -0700 (PDT)
Date: Wed, 27 May 2026 12:49:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net] Revert "vsock/virtio: fix skb overhead overflow on
 32-bit builds"
Message-ID: <20260527124929-mutt-send-email-mst@kernel.org>
References: <20260527164843.125054-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527164843.125054-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292399-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FA675E803B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 06:48:43PM +0200, Stefano Garzarella wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
> -- 
> 2.54.0


