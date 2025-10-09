Return-Path: <netdev+bounces-228347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E61BC85A0
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BA174E4995
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8C2D73B5;
	Thu,  9 Oct 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbCuFgUo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497A2D6E7A
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003098; cv=none; b=bOv6iqTDpDemHEaRjqvuqC5/G8H4yaZP8ZniJ2W7OKVbbDW8zmMMKDBgOUt1tQIy2RLl44JxgVFsUJqVQDsG5EbYnqXg9zsOUbY3G7YHdxxEX/wSF8jiZhwhhmimas6bSJwudbDgG0IbWON33UsBCpHnXWYAbNRfVr4SNJKDmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003098; c=relaxed/simple;
	bh=VrWDDApLvX2qMH79/+xTLKnVAMMuqqi7MbrMjwSyaCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFB3t+3++WiCxu6CCDtOKRMGr/dp5CWM2yUp8bggopxUwLbZguZ4Q6T9VXuUtd4Nn4d/4zJNyWwf2V9leS20jzAR4apmdpIm4KdirVZbQOi6NT/o5xFhfRn44PL364c5+73+3V9hILPvpYm9UApMyW63S8RQl7oyqVTRxtF8EGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbCuFgUo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760003095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znS/sY1Cp+Lu2TFNQZjRRZlOQYTeUBE60EraEojaqMw=;
	b=BbCuFgUowOTtGJ4gBPoTSX70kOOMq+N/Pjo+FQwlZBYfKtJs1hEhyhrQZxQ7L5jdgEG20M
	iXxS5Cx/HUXG/20m2gA5Nj6icTiLHXpv6+X7J+A0aeQhbYHovvzabZB6VRHW5d5OQKwYd3
	iYjkR3He5M+xaIcjrDCRoY0ZzGKDI90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-9aCwHJGyO7CQZ4JBtT5TIA-1; Thu, 09 Oct 2025 05:44:54 -0400
X-MC-Unique: 9aCwHJGyO7CQZ4JBtT5TIA-1
X-Mimecast-MFC-AGG-ID: 9aCwHJGyO7CQZ4JBtT5TIA_1760003093
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so5011245e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003093; x=1760607893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znS/sY1Cp+Lu2TFNQZjRRZlOQYTeUBE60EraEojaqMw=;
        b=G5pedZw/zC7fRUgFHGL7ZXb+2FFfUKYS1v+BacZpzlAsP+F/Ep9qxbC6nAcS+Br3gH
         OmYhOV1JObf8vcF3+qIEIPEwhZx974EuydkNABC2jEQPUdkrnObYVQkY8T7918NbKTT6
         jMWSZtFeOFnSFzGLSNUEltsfvYpKGw1rNPDQnnYsB9TzPrGdgKzDbRf8bNIiAg3hXyL3
         oDupmjZhXJolxFAuQFUceN+yRw+s5aYsp/XHDMNtYdkwm28AiM6KEy8azAnEGI+TemIe
         zHnV5iMpytyGaPwsypBzD5Vb+lzhIjv98YDmwTMYCR+Jzu/ZUZpkXhs6aj413GOIzBgd
         lJHw==
X-Forwarded-Encrypted: i=1; AJvYcCXYnMUTYwiatddO7ajf4YeBF3sYdkDU6OgLKlfC8d9Q+ee469Eog8Gd+HxlOIDpMwzQqOVJzgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwVge2KEWbsO6KLBrvSRdow7Zc71THyfp77hH7xm8fFVHbxVB
	lAKBORKVMi+8UAOi8qyUDareC2RgEepKMQexjSCTLoCCuBGX3x1bqH6Xx6Qmouu4wKQIOjceK4+
	DQXKAPoBKD3DfUtRYgHZ1Ly9bZJFbLP9B5TmKeuHMPnb1fEviY+851riGaw==
X-Gm-Gg: ASbGncuPZZFYr9p1IEerC4bPeFAAMQm77UQCyhMHDTsPMaozHv99ZExVR+XdpYJi2CA
	ZVYmJlUmc9eczFqfmxjVz+QkFBWO9ttj5P4/zBYGFLDDzPReH8Y/ZWHXtQD7aSriJ4geoUgn2VD
	5BOfzTAgJcqx9l45rCvz+Z0W5oAvRxGNl+7u3LXsnrOnGdJpDt4Oi+NH3ebP9qq/U2s1c/8Faxg
	BizD/FeBGoCrIEeCzY5qluuIrjCwbu+3eUaoGlEzxtY22aEVQ6s9/odbhsMNtpMZ9ixWCtibT/Q
	p97cqq4PRg1ZHHQjzUhYY69GArF1bBQp7siuughXLOLw92aaygmpppfSFZQPZ5c1/tn0ICbVA5L
	8lkagj0Ecg5zMismbkg==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr47582865e9.3.1760003092886;
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9gDsR4HGquo/2JI/lZk6sK8VDkVdB5y9k+m65fa3iHwrikY3mxNzXnp+RSx/jRgjPRDHkiQ==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr47582615e9.3.1760003092475;
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb1e0f019sm18863005e9.10.2025.10.09.02.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
Message-ID: <6c346fd4-3c61-4b31-976a-41a2e2ef0afe@redhat.com>
Date: Thu, 9 Oct 2025 11:44:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] vhost/net: enable outer nw header offset
 support
To: Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, jerinj@marvell.com,
 ndabilpuram@marvell.com, sburla@marvell.com, schalla@marvell.com
References: <20251008110004.2933101-1-kshankar@marvell.com>
 <20251008110004.2933101-4-kshankar@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251008110004.2933101-4-kshankar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 1:00 PM, Kommula Shiva Shankar wrote:
> apprise vhost net about the virtio net header size.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  drivers/vhost/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8d055405746d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
>  	(1ULL << VIRTIO_F_IN_ORDER),
>  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
>  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

I guess this patch needs better testing; the above triggers a compile
warning:

./drivers/vhost/net.c:81:2: warning: excess elements in array
initializer [-Wexcess-initializers]
   81 |         VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

which in turns hints the feature is not actually used/available. The
chunk should be:

  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)  |
	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

/P


