Return-Path: <netdev+bounces-292402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MmoK84hF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF05E80F3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F203018C38
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D6382298;
	Wed, 27 May 2026 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBTkXMg/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s8UJoGuK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FA30149F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900874; cv=none; b=iwpdNMm6Ta5CW4a3KfNhJg5AJboAFBkjt0FDAPL5FazhjVJ0o+oRNXWP7JlaltxXHdK8qZku2AHTzcb8n1VkR2vfPpTPpDV3PpsAaXeJ0zTVjefSjtzOfD5ZXIF7oy2yW+6UBH4uQxvtnCpazoTK8CN0H+FrLpU1viJVVGVSLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900874; c=relaxed/simple;
	bh=/UH3gxOfkxjmHDe+X9hmKxkvO5GRiz0TxX1v5bwnw00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8Q8DbhL+3ltq16aGRwovb9fMawppRDahpPwKN7vckK+YO+dj5Qe+OiOXvixAm9sMra3uea8+/CgxSazOxerQJmPJPDs9jpU0s3Vy3SofSiK+bLCegP+abjIj864Uvb6a1QcRQ8V+rgcTBIsWp/ZIpvZSpMdPmZbHCZSLeeXQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBTkXMg/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s8UJoGuK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779900871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6POY/701re24UOom6BOrGUzqYTwbVA/bGZUL7JBXP08=;
	b=IBTkXMg/XFTSAOCbJax2PX6m8/GKi+Z6H5/WIBcvHJhqDC/L6mQ1NRyIsz86pmFopt+AJY
	piNfy38GSyoWQ8YN95C8MJGw8X5gylCm3Ho5KLxHmTQscahAW29ltVrM2TQKRcYgK5i74Y
	CBjVrfU8sRWqap4SILkZihlDFTm+G0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-g8CnoCttM_aIK15W95Y45g-1; Wed, 27 May 2026 12:54:29 -0400
X-MC-Unique: g8CnoCttM_aIK15W95Y45g-1
X-Mimecast-MFC-AGG-ID: g8CnoCttM_aIK15W95Y45g_1779900868
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so40430215e9.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779900868; x=1780505668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6POY/701re24UOom6BOrGUzqYTwbVA/bGZUL7JBXP08=;
        b=s8UJoGuK54NU8boyReakHOVnf+us5re5T0GgTydBQSwU77MFoKKywrPySP0kyB0UGl
         UquYL53NhVB0p9/qLfk3zZsDeQ3Kf6NxoxlQ7kQrBhLF5PGfo/drsKSr4g/UZdBH0tQV
         1QHgtQT55ge+T2oZGXQssvkaSoWqgHAasEbVmpjF8JQFSPGC8Bo9qjXp0yL3KIUCp4cU
         3v7s3zsvBnIP5x6WInPi0VSDhG0dYZ8alucmrOIIZ8JBmG8lD3tnY8H9ZwPnH2IhOpuM
         vHF8FbHa/+MDkrNqn5JFr8eOcZEPYHQZQnrXaCfifQHVqPri+rXIohUG5pWjYrUT8p+d
         jv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900868; x=1780505668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6POY/701re24UOom6BOrGUzqYTwbVA/bGZUL7JBXP08=;
        b=TuR65gp0Mg17H8FNbc4nJs2czEs0UPzgFn/5Ai+kmy4RtY+nnOnu/at4tfch/rTzKY
         xI4uZVMMIjFiT2aWdlzMF6cZNKvc4dxSvcKmHKMVlpW+MN13FtowIxaG/sZTfcg7VZAY
         qJ/oEdG1PbvZu+2bZqPdYvPKcCD3fAOaQiSmiPb3d/3eHKe8gCbhE9fMU1HLggeXkPWH
         LeDJl1hrN/bmCib+M6wf7SxIku7TFY19ybjDaacV/7lVgy8jy5KOBgKHNfZSLoGTjGwj
         IuC65ZN5wxZJarKPT1lGyjwKzPBgJo6EP5u/HjDUTER37NtPYNnjbswV9wleZFcfcyAU
         SqcA==
X-Gm-Message-State: AOJu0Yw+VjWU1MxzZI/uvN+eMtcSno3DKopE4vibkKXw3xmhOAAGzT2N
	Mmi6Pd/kdKGvjABp9TiWkY/MM+yA5Us4RecYVUZtQqz8NGxw70FFIW5VbPYUQsAFRVCuj4v8C7V
	aNwqppzkpGUyWrWe4liHn3RsKqFHSbpQDPfgFYTSmp4PJVAkfLzFeSKteKuOnf95/PVC2keXl/K
	Uu40DCQCjy+HDY1hdW9rYdXAGCVvIhuh4E1AjFyQnoZQ==
X-Gm-Gg: Acq92OFVoZzRzbfz26s0fCBwcCD+ZXALEvU6erW9tjn/6lhFxLVGP8QcX6cyqd4ryyS
	1vE3/vLzjIgmQ0EeZuKnIcVWQuztP8/Iv7jRZrZUeO7AmT7yusz3Y9ED69BvDDqg9Z2lJzKs2YL
	7Osmd8oFtDoWDWtPxBClzXVsqf7yB+Pk7C3Eyhh5rzkDdIxEKjn372NTHzNuAOHDbZ+ZALC1n+A
	qTn5TusMY+qkK6TqZZfQv+uXrZ3Xu5nK4F94Oa4aCMvtWdRueufiPa1GMvP8sBCfdlMGr3Udt6X
	JY+gMDzUzZfcrd4wxJ5Iwqw8aPaTheYTdfAXp7oYBReflz22v3Eg0oTFFxBauEa2XvqW6UTicGz
	3G9l7S4GUERWqWQon6NUKUxq3Mr47KlqEANUnJfIKqxn4uwwqnl7QrJwZRQAG7TM3sIV3fO8=
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr431263735e9.21.1779900867780;
        Wed, 27 May 2026 09:54:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr431263165e9.21.1779900867275;
        Wed, 27 May 2026 09:54:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm437088985e9.2.2026.05.27.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:54:26 -0700 (PDT)
Date: Wed, 27 May 2026 18:54:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] Revert "vsock/virtio: fix skb overhead overflow on
 32-bit builds"
Message-ID: <ahchEKOnRwGJBL2V@sgarzare-redhat>
References: <20260527164843.125054-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260527164843.125054-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292402-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2AAF05E80F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 06:48:43PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
>overflow on 32-bit builds"). The fix was semantically correct (although
>it would have been better to use mul_u32_u32(), as David pointed out),
>but in practice we are estimating the memory used to allocate the SKBs,
>and this will never cause a 32-bit variable to overflow on a 32-bit
>system, since the memory would have run out long before that. On 64-bit,
>SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
>already in 64-bit arithmetic without the cast.
>
>Let's revert this to avoid unnecessary 64-bit multiplies on the
>per-packet receive path on 32-bit systems.
>
>Reported-by: David Laight <david.laight.linux@gmail.com>
>Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
>Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

aaarg, something wrong on my new setup, CC list was missing several 
people and mailing lists, including LKML. Please let me know if I should 
resend this.

Sorry for the noise,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b143290a311d..d4d26fba9e37 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
> 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
> 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
>-- 
>2.54.0
>


