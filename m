Return-Path: <netdev+bounces-248779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050FD0E1D1
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 07:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B108F3009D69
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0369238C08;
	Sun, 11 Jan 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH4olwtb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVQkdGxl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC4242D60
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768114017; cv=none; b=LW/pHh+ISShFYvQ1flPfyWmzgh67URii7coCx1d2DDpe3WJNgQODAaa7Wu5SjawM8ND3+OvLrNXZRcidyrTZZPY+rXnrrTjd/4zaLIu+AQzIs2QHIayeraPozDZuUA99x4y2fZGUjkfo7PpkxC5PsSMdUjA1ZxeREeY/1CJNnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768114017; c=relaxed/simple;
	bh=oJg0P4BTaPqRMdngCealJvjnKfXREQ/BhzD4UuLebrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoee1HqInAh63n+eyFKY4SPNN/ANeEywvUNPQ9MFpHRGWTb8OWibmC7bgHY3FAzm11wj1tLb+ITKekEPMqJtEcIN8h6BhxV5VFjOCW1oiiC7TxRjQ1/s8v9J2JbOzTR263Sik9q50ots9Onq15zn9/OYJZU6DI8I2OGxrQ2iT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH4olwtb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVQkdGxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768114015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
	b=FH4olwtbDVkqLlTmiOQY8N+ejqjOeXDcYMPEnh3d+m/Zw2BLexF1MSjrwBdsc54SzGJgKi
	PVUFzPtcPWmp6orE8sWx40eiGUgNIIuB3lJrHZbR0ZrEK9YgW7WW1omNfecrgIvwB2qwKc
	ubk25IHifgNDHBF0a9NbmMdaHByuX3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-SpU4eVnGMXaLoc2kFmBQTA-1; Sun, 11 Jan 2026 01:46:49 -0500
X-MC-Unique: SpU4eVnGMXaLoc2kFmBQTA-1
X-Mimecast-MFC-AGG-ID: SpU4eVnGMXaLoc2kFmBQTA_1768114008
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso36315885e9.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 22:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768114008; x=1768718808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
        b=BVQkdGxlmes97/Xxz8ptRBGThZdXBaCNR0MDLkKbuAF+QAWaRq0aWy6rM5ANq0Ci8F
         ttKuQoJcdSZQ1K28OhZw520jH236Z1kKM63E9pHXMgmwg5S0jTZcCPyJ1l9kymFpk8og
         r0XSKqzB4ARKbQ7a2fy8jFmmIO2wzpmEDyldZtuEN4ahgEg9QA9y2UEtG8rV1Xz43BB2
         z/1wrmbU996DGFBmBP3s5unkBEen2DHH+khnjxTV43UQXvukTqjg8bAjBnPLjdrsxnNI
         eCrI6+RnKHWIF+7UTKptHPiL65vXp8VbyuBhTuzFiobXPBsK/QNUEaTKCgjSBFg/sPsk
         wktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768114008; x=1768718808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
        b=OqUQikO9bo/JEufhOtzwh9mWTbNtr/X6duFt22mnCc2ca6Z2V87qlrnc8NNL/S/UR1
         4Jp63ITi5cD5msIQst0LwEhKFA3qJidElD48XQe+2DS7n/j+eMcKoFHPFo50REaVvGIz
         oREDY+5YbAy/AaRo+tVCLTXo4IvhK1wMn0mn7xYjypgw+jyKMT0aeTmji+T/r06lmULT
         E/RUTPijhagRwduaVM7mXkMNk0E7cGb1H8zaBKPh13WhGYddLlPEgnwPm1IliibrVWeu
         arV2xBGMl3KCnwE4KrBHGmjVUytfSih511HA+e55jeI2pSLhdgKjWhaF6bMEnb4pFN5G
         5JXg==
X-Forwarded-Encrypted: i=1; AJvYcCWimcUhfMnBNdaRe2EtLBM4TDsfMJfyJPRrY08GT4CdUyvP619GmR1nK4SXdcJYkAdXcgF3KEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfES+ZeS0CmXabdQQJZzm+ho1CrzOd05STJO2XgnC6myzZV8z
	41bMjMnfigoBY7a5AzcD6JiFTQywPdqP9/qE3n0I7UOu5vLRD+nJVdPMf0PWkHNQdR779XQA5x9
	cnzxfgwzTb8eRqtJDou6EtvN5yXQFOXah9tl2aATUM+kDM//9A2EX4Gy0dQ==
X-Gm-Gg: AY/fxX4uL3HN0WxHqCHnvs9ZtEdKsyqUDmvatqQflBF0o6jIYa03OvHv+UdloJiBugB
	lDWOV2zxpvDNDkiXYKy2dUYh43sZWBTLrCsY3nM5vwbuGB6NZ4cj3Iijr+HUOLO48ybVmss9Z/t
	uE8bQc7mWBnsA17VRQOJo22aEZC4fv7IUxBR12d1e2Wf9Ds3tW25H/oJ7gTdHxGAsBhzCIPvxmo
	U8Cp9Li1mEhhAmi6ApgDMwdwKmjR/AdYRSFFJTGxRTcYYX6obaEsP9xugYAJEqLwxj5FxCQZg3P
	IWJH4RyAuQejyOCnADDvWKET6YFB1dC6nozbYnsEaUXU1y1jYexdnHDyuQqXuk2J7i3kJJPsuLI
	79EWuvRGND/hn9ny4TYGR72r7HmIotcs=
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047525e9.3.1768114008084;
        Sat, 10 Jan 2026 22:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2KhXxY5wNvI0FhPEnxgIqYrJLuszMdozjkRjhQaSurG33CO00c2A2r97DP2kFBqnSLT0brQ==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047395e9.3.1768114007653;
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm102237315e9.1.2026.01.10.22.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Date: Sun, 11 Jan 2026 01:46:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <20260111014500-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Associate reply packets with the sending socket. When vsock must reply
> with an RST packet and there exists a sending socket (e.g., for
> loopback), setting the skb owner to the socket correctly handles
> reference counting between the skb and sk (i.e., the sk stays alive
> until the skb is freed).
> 
> This allows the net namespace to be used for socket lookups for the
> duration of the reply skb's lifetime, preventing race conditions between
> the namespace lifecycle and vsock socket search using the namespace
> pointer.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v11:
> - move before adding to netns support (Stefano)

can you explain about the revert please?
I looked at feedback from Stefano and all he said
aparently was not to break bisect.

> Changes in v10:
> - break this out into its own patch for easy revert (Stefano)
> ---
>  net/vmw_vsock/virtio_transport_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index fdb8f5b3fa60..718be9f33274 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  		.op = VIRTIO_VSOCK_OP_RST,
>  		.type = le16_to_cpu(hdr->type),
>  		.reply = true,
> +
> +		/* Set sk owner to socket we are replying to (may be NULL for
> +		 * non-loopback). This keeps a reference to the sock and
> +		 * sock_net(sk) until the reply skb is freed.
> +		 */
> +		.vsk = vsock_sk(skb->sk),
>  	};
>  	struct sk_buff *reply;
>  
> 
> -- 
> 2.47.3


