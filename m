Return-Path: <netdev+bounces-142087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF39BD707
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966581F23473
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0D215C47;
	Tue,  5 Nov 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jNR27JuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4820FA9E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838515; cv=none; b=TYDsBjv+UHQ11mTNsIgo/ieiwc/MFo77MI46glflB7lqBbRay2A4LDNxgxRCUqzN/KTCSYSf51ArtF36xZ430X8Ujp2hgxmmBDu1e/irCAeYeFt0QgQPhdjmlOZPktbhWHCTKDwCJjDSsFjcTIwACkhiU/OIG+/xc9ORwXdI5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838515; c=relaxed/simple;
	bh=r4wQnQB7TOhhaDz2m1Pn1z5j3SZx+o7iBbQS2F+6OQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW7y1HH9vT+BqdgU9qTFdlheYNBJUaS12VkqKfWiQBm63hSaEzusHxK5Yom1iRUu5nhn/PWei0LkeRD2vzGH/Co2BwJBTbAlEjnVR5ex/Qb2Xvlpz/5PLPpVh93L79txLtSyRxrefafuxfmqRFRybsgQMijFufrUVU1yUwYpnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jNR27JuP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so47757185ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838513; x=1731443313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=jNR27JuPxXJ8NBA0lo8BRIgyEVM0oTh4lrWecL4uh5aJottAOTGNYWP5oeAYBhRN2L
         ARugtuyHvF9y7wi3eSkBEDce5Xbq+8dduDFdPdOifd8R48haU18s+TFKuti5YzpU3ntP
         tQcc6Lqo5g1eGkFkyo6/eYXymTcY9JuVlwzw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838513; x=1731443313;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=kUCmbJXkQZJgoWT5qvBCVqTM2o6AeAvXB/9AB+mjZHH03sHgwqsszCg2ESbZCv0a5W
         AhCNAhBum+X8N9e3Fx+AqWYnpfVg3aGJfjONQ8x8N+LPybsJMuJhgM+CasKFHt0KTOFr
         iiPazyKxMEWwT990DMWIJQHMUUxfdTnLvu3mwe4P2b2SpSJ1ngDD8ihTc+qpNLbWmt4u
         NnFGE9WpyXcewdg8T01gyu6u5sYWUZYcLBA2+rUgE9nyzvecaEaKVwMt6Hrlb7Qs78gC
         j0OMYm+weN/elWKR9/3AFmu5ANTuPAq79a/b0+O9nVSbuw3VuTEJeI+jY/J8rOmIIraZ
         y2MA==
X-Gm-Message-State: AOJu0YxsaXtz38UqXLhpen9sDNEep/c6cXdtMC5K/kg4UnV/qrCsauUl
	xwgotSrTFf+6vTLEK2KSRVfeBtN2zLCCArzCUDMg2HVDvBVPMDCrBIBKMP1qEaJeD8AQEkaE9TO
	Q
X-Google-Smtp-Source: AGHT+IENnWKhXsUeHfoWFHGstrsTSODyhq9Rx+TVaQWEQ9Ryh4qCgsEm60cTkPZKg6zj/kWO5fN5wg==
X-Received: by 2002:a17:902:ea02:b0:20c:a122:e6c4 with SMTP id d9443c01a7336-2111af3f634mr222617155ad.14.1730838513019;
        Tue, 05 Nov 2024 12:28:33 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570865fsm82537165ad.107.2024.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:28:32 -0800 (PST)
Date: Tue, 5 Nov 2024 12:28:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] virtio_net: Add hash_key_length check
Message-ID: <Zyp_7ea-1F9VPEBL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-3-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-3-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:04PM +0800, Philo Lu wrote:
> Add hash_key_length check in virtnet_probe() to avoid possible out of
> bound errors when setting/reading the hash key.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 75c1ff4efd13..acc3e5dc112e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6451,6 +6451,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> +				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +			err = -EINVAL;
> +			goto free;
> +		}

I agree that an out of bounds error could occur and a check here
is needed.

I have no idea if returning -EINVAL from probe is the correct
solution (vs say using min()) as I am just a casual observer of
virtio_net and not a maintainer.

Acked-by: Joe Damato <jdamato@fastly.com>

