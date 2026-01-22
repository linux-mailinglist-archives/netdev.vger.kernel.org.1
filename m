Return-Path: <netdev+bounces-252264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOmwKcL6cWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA165333
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43A186821EE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7236C0CE;
	Thu, 22 Jan 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz9fvI/O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6sYLfAA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1C3A961E
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076953; cv=none; b=fLSf+K7ZqLv8J5PHhmYEs7OJ+KpdLayzuskzbCnuRDdAPap5VTMalElbbDDxDG3vdBtl+PqlysXP+wuNwoD9I2B8n4l2EKj0q06PdKIPwmaErZt37l24Nu828Tm98SQjlVvHF9952vi2tpWwZWYdjAePalBJTqxJORgoAVQluR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076953; c=relaxed/simple;
	bh=cLWD5StyzKOyO7yoCmi6CCtfpC4wozVdHrKYhZlWRqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al6l8DSb6w5EAycTePqvwkjXnGKjxruErf/4k34mEBNqjMOvsbeOfmURPd9KZdabATOOPbJEKQRNjP65xTNMqDGyN+BwZ5UUZctn381moWAscR7yqd0tQehrrCAs5EOYZVzN0cOn53KCmmFoBmmo0CyVs9Y2KkAh/hcVr/C4bY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz9fvI/O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6sYLfAA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TlFQ4aqfsVGvAfPKjF05UStD/LMGRRXDrUJQq0z6pY=;
	b=Nz9fvI/OlE0n64bQS60xhiq/VkQ7CWQcxO2s2FX5PkYVs/Iczyzq8ZHi+uQZAehPPvvHN/
	C8RqZ55qvkT4nUKAHhGc0jrQz/SOTnRLTvAVM+VDDpg5OOZvAPYDFhLa5wq7Z3NaJCHQXq
	nUKuhe81BLMtWnA+pUKhduVnlAX0IV0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-TgxENhrfORyRBFy0XeVgPw-1; Thu, 22 Jan 2026 05:15:49 -0500
X-MC-Unique: TgxENhrfORyRBFy0XeVgPw-1
X-Mimecast-MFC-AGG-ID: TgxENhrfORyRBFy0XeVgPw_1769076948
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so15030665e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076948; x=1769681748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TlFQ4aqfsVGvAfPKjF05UStD/LMGRRXDrUJQq0z6pY=;
        b=b6sYLfAA++1TChK3VIncwHYGWNOprzymAykJiszc6m1MWIia6jx0eJ8bLWc49uCoJT
         +OFYp18R+L4fZ2q+pA3xhgY6MLuAI/z31rOMkklovnsDToJBowhORlcA493Nwy5jht8+
         cp4HughJvorwu4MtKzuv0gOBfd5cZxzKbmqwUr6BNY927Y0HLXTSrfDJqIuFD2wvhcF+
         zcJ0RWCUWUKqHvluYWvui00qV2nb6s6bxEuCb3QODPhpxRWsmthsKj2BTXKXfu3Y2/9Q
         lKRLy9a4VqV4RZsOM3z42SlM5It9RYmXXZMcTEHW2KlDjJOCgDHfpa00yURWif8DaCZB
         TE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076948; x=1769681748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TlFQ4aqfsVGvAfPKjF05UStD/LMGRRXDrUJQq0z6pY=;
        b=nUB620IP/n9G6f4ih2MKRaM8/AqoiKCwPmXlkS/OKS1s/tdovMjURDi8siE4pBtE3q
         /O6QdnoTRYRX/hhPjvzqwCrOFKIBQ6CH45pgHWX7mkJ1qOkIGKhMbjeMCB4aqysD7OwJ
         apzaTKUUOSo7XvINlG8z/1r1dPlJ/numL9cni2CUmGvf4+VtKhicLHbKesXzOYKiv3GL
         WE1Tc0T4asEtXaNxbJO31Y408PsTFXlLIkCuFtPXgIvtaA2Acvl2G+VSHhZGA8Kj7MFL
         wvzoB7qC5WrR3RX9AaS5NQTLVyrMQWLmqiCooSiJAGdI36p1lkplug7r/oSnMBSmQ2K2
         p1Xw==
X-Gm-Message-State: AOJu0YyWmehmSJ6i2ruA5gGQRhY4BZbseyLVYWMAcbstMNCOyzmm42iI
	W3vf83sre6b6aux2/IHAQs2aA12GR8wcJZkNu1JRRafRJwvcn5OP1nZEm1Dw429Hqb+Jorkqtl7
	ejxEahZPWi7wNx8aRaz6DWew6aHTHgANbaKdAMklcicsy3rJlCCvtsvrlrA==
X-Gm-Gg: AZuq6aLpeODhb5W1lUE15/GyD9K1i1Zt6iYrwrNbGQJco1J6DCup5HMoGcP4G1e3p9h
	ctizgk//y1RJcxqCGLi35XfxFwbBj89phw8WrQdKFwa0oSc45TjrCfprjxMvECaj9HHJX/hmrv6
	OzaCF59cRVUhEsFwrm/GnoSoZo7+DyfpQKjzRLYyQ5AKJPPCIwaHblbBZbrs71DhBv5G9GI0nT2
	BBafDJl6SF+JaB5a8Esl2CBigS9EY9fVnWFYDL78HsYcYx55qWfhm5C4CEG7L9BxwJ95IkdfYgK
	rg+KYm3JjqWBlW9W7n9TAnEktiT8J40RA+YKdxzhLDFp/MtHvCjLiHHcVFTmFW5IAk8crA6vipj
	OhDvjlKh3rRjBWM17OTi4SzRWdXXuxdGeDA==
X-Received: by 2002:a05:600c:45d1:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4801eb03358mr249608755e9.23.1769076947681;
        Thu, 22 Jan 2026 02:15:47 -0800 (PST)
X-Received: by 2002:a05:600c:45d1:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4801eb03358mr249608225e9.23.1769076946866;
        Thu, 22 Jan 2026 02:15:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b5b4sm55737715e9.5.2026.01.22.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:15:46 -0800 (PST)
Date: Thu, 22 Jan 2026 05:15:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Message-ID: <20260122050904-mutt-send-email-mst@kernel.org>
References: <20260122091527.339180-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122091527.339180-1-schalla@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FEA165333
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:45:27PM +0530, Srujana Challa wrote:
> Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
> the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
> 
> The virtio specification requires devices to support at least 40 bytes
> for the RSS key size.

Indeed:
	The device MUST set \field{rss_max_key_size} to at least 40, if it offers
	VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.



> However, devices may support larger key sizes
> up to 52 bytes (as reported by the device's rss_max_key_size config
> field). This change allows such devices to work properly.
> Previously, devices reporting rss_max_key_size > 40 would fail with
> an error during initialization.

This one, yes?

                if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
                        dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
                                vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
                        err = -EINVAL;
                        goto free;
                }


Hmm but why do we do it like this? I suspect we just got confused with
the spec: > vs <.


Can't we just do:
min(vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE)


If yes I'd like that fix in addition to the increase.



If we are validating rss_key_size  against 40, I think we should clear the
feature rather than failing init completely.






> The driver already handles variable key sizes dynamically through
> vi->rss_key_size, so increasing the maximum limit is safe and
> maintains backward compatibility with devices that support smaller
> key sizes.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..5f06cbc058d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,7 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> -- 
> 2.25.1


