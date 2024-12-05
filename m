Return-Path: <netdev+bounces-149328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD99E5265
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F2C1882250
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E61D89E9;
	Thu,  5 Dec 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVFVg+B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158921946B3
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394851; cv=none; b=uvKFPHx8oZW2VzlqT8oCbzV94Et3sEBArSRkKUsUAA4vEO7l6QSHE9OBk105avmkcko1zVQJnDDcRo93vDaj3igqjXU1DYBOxYi0oCIdM+MNQY0J8IMwzEw5KluUMS5zKcGrtdI44TL9YmSa/l6dTxMOnq8lHw0soosVCA90hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394851; c=relaxed/simple;
	bh=4iSivaet3eWbcYQfu+va8eySU1IR4UGuLLebIGaqXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFc0dcHIiSJWAFG+wUB4kMTMu0SC/TilcUsh0k8brGMFBCQ/tzJTIis/uaG9uiST9AB66sN6hOUMzDlTYw3RFWk+zxxNmiv+TLW4HEuN9GpiVWATYT4ww82QbuQniHMlm5XJAeAqUT1O7IdWzhd53r3Ow/HInUzI8JWElkjU13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVFVg+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733394848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
	b=hLVFVg+BOVMljeoA00eQgysoxre3Uowf1+7ZiHJOcRKgFmpxqO+bf+ccNyvVA5MUKZTbK2
	UEHdDE4K1sY/c6fnqA1HYY39mVmwuTf+d1wuXVGtj4Yv2EuU9l9RjweThJr93Z3Y/af2UP
	kHhgc/kZvaAIUIP1tIu3Ebzh+W+Tp4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-XT43NBdtM1CWMPkCYB7K5w-1; Thu, 05 Dec 2024 05:34:07 -0500
X-MC-Unique: XT43NBdtM1CWMPkCYB7K5w-1
X-Mimecast-MFC-AGG-ID: XT43NBdtM1CWMPkCYB7K5w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e49efd59so309346f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 02:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394846; x=1733999646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
        b=CwgVzWf1XlC+otZRmnd+Fr6UUjZDAHT8dXFzCvYojX2VwvnaZ8j991dmXf7/COIh4a
         KiAVZ96PN/HrOrAyZ+EC4bRy40DbZs03GfIYZ+KDLIoyb5RZLwOES6ZPFaJWR+au/i3f
         hMqL4g8jp/xffJJruN1UbAlqFxsG2BWLE0Bb2jVLJvVyvyMQttEG6O/UM4Ci9pysHYCx
         QN8L6Q3425MiIxIaOZrn3QLYsYWZb6Io+iFi20idvBNVc/BcGqXANoxPhNLV77bL+W/7
         yJl4K1gdPEFq7sE9TgzZ9L+H5pIhwgbAPFv2q/Sb5RpukOlQmIY05wZ5ebcmfBCOkRgT
         4hPg==
X-Forwarded-Encrypted: i=1; AJvYcCVIraf+ltBGzM6UOxGomHZT3TznnvhNIH1QO3a2YiQ7Yg5H48o7S6HfVXAgyBGYD0FGjpzZo3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJZgdB8OpcBehaTADN+XQcG7KvwBzVe3yWAfKosCzfqu+G5ye
	gJ+QCArns79xuPas5ANSBJZTzZqC7hfzVKm3/yhOchYsFi/cYQwRyJ1bI7mi3G0qhtK0DlS+Mnp
	af0pEEuYQlepcieMk2SSTg7GmxjWYbXOslbETTpY+C9I6Xtavmtlvog==
X-Gm-Gg: ASbGncuyKFcfkvbarCZrqf3C+f4UhkS3oHUKy3MrCeE8tRXe1LVciBsDu9/HtHXAYW4
	O97moaHQ/suaCUw/woVv1gYh1Jss81cPWfhwVbT6BaDpKb/Q5GSFcOrnQrKBo5MYIV7DSyHMCcK
	YIj3mZO+tv4FOVMCojDAGBcLZ+oxvJC2licUY0siQgtGjiSAlcTxpQgSOBIfGubRYQTVJt9EAJ8
	lF6JmHuOhE1suWRx79nADbUJ1BRiZKAsoqa0XA=
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027398f8f.23.1733394845863;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJNPFWgvbSY2I3/I8jqi8rh7xZnIPunyw/bGll0UrDgSSCV6D1wzgUrHuDPt3xOF7WivnpAg==
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027369f8f.23.1733394845539;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909952sm1556182f8f.69.2024.12.05.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:34:04 -0800 (PST)
Date: Thu, 5 Dec 2024 05:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
Message-ID: <20241205053355-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-3-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>

On Wed, Dec 04, 2024 at 02:07:19PM +0900, Koichiro Den wrote:
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 48ce8b3881b6..1b7a85e75e14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	struct send_queue *sq;
> -	int i = vq2rxq(vq);
> +	int i = vq2txq(vq);
>  
>  	sq = &vi->sq[i];
>  
> -- 
> 2.43.0


