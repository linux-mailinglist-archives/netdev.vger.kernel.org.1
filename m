Return-Path: <netdev+bounces-233841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90DC1911B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2611C81840
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C472EBBB0;
	Wed, 29 Oct 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbpPYvcj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA79260583
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726005; cv=none; b=cYzFFEjjJn1i1HcY4wq0A1tkp8ArpNZ5PtrkRY9Gk6tLCAwrlILKluYDZg3MLmn+tXuxpkhZjtKj/MQe/sXE9OhLE+wNJwrT/U+pEQGAv3fxPAiGKR9O5ma8aO+u36fZaXaQaLZ32qVWjkb5rT92N6aGu7Tjzc6JlXQ3BMMVk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726005; c=relaxed/simple;
	bh=dF3Bio0TgnJ38n1yJDNKl2Un84TNaqbPbXxpnnYQNmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQs593GM/CjIgkAwJiIhjA2mdZxJAq59dbyidURBoOEfbAbkT2KPJyxAMQcc+SvDkb0RgMSEheEuJNFNS5nEWfVy+zrcGHUZMU9PZR32WlqsR88pWzOYkSb6VJ/mazP8tm1W2eqe1TjM2a6r7nzWxirpQB7r24dzmWQdJCKOZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbpPYvcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761726002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
	b=bbpPYvcjCJmE3PLd+21MfD5M7J1pQZPlUttyOk9YAbe8sZlxshvOgBHc+6AhU4isEOFKT6
	DurP8pi8qYK4YPBN5i3h6Eo+OymCslatmOSCL2B9wksdcwnKhwe8PfmEGRZ9OzCk8qyA4j
	U/VCaHJ9iEVlJjAiAx5ooE4sqnDr8fM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-uvH4pPgyN7qOlL9IYifPJQ-1; Wed, 29 Oct 2025 04:20:01 -0400
X-MC-Unique: uvH4pPgyN7qOlL9IYifPJQ-1
X-Mimecast-MFC-AGG-ID: uvH4pPgyN7qOlL9IYifPJQ_1761726000
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so39603005e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726000; x=1762330800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
        b=jP7q78AaxlYzJ/xd1n0qcoJkVDP+dCZkMA7JIYeM07PQXthYGe2G1ftIDkmD2Aa+5I
         is6AM8BDo4avYzP733chypUcGSKTkZSwTTP/9qI0qNJELVp9N0fSacebnYsSyg3RnvG2
         hW2VfCF4XuXE9ZqM3dU4dnT2vOoniMADOVty3jpb9nkVCJjFUWdDkWTA2qtyoydHDlJ3
         0qFNYSVTJENffPC96GYLXfqvEiDhKVnJYR0fhliLoQZw8oOw53Vht+uvFm5Qiiy35aTp
         3UbCk0S1liK3lhrMimutoj/jtDleMJ05Bu84ahQDVGVXysF+sSyTy6ZRlatvZXGSbtmo
         NWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhg5qnukRNHpMRvxJmsCq6LmAbL8Qph86UPEafpFTLR3Usbpz7IzSmCaYAbEZbSr724+5LOWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHMzEa+Q5M1Hn17Y+vERVduaGCWIJHi5yPn0a84IPwbD/MlIN
	m54ubtc1bSPmKsDTBkYVI75uPIt/VIVSOE1mSI/TrfrHDINVqDgrB87rKxzhHw35T6cJR59AhBF
	nCCpZFZYOeK6yixcKHyuJG/ffQ9rU9CPCMKig1BaYMb9is3VaBKb4N9GVQYgK5bDrWw==
X-Gm-Gg: ASbGncvfF+VQnciTKmJchomra9c1YjC4vSRHGiFMJ6uanJV28m+k+xGpkZdv6fQlOrF
	4hhtxKMy1l1xqiNWHLG8zieQWG0W7wyHYJhwrDqru0pnRj7vEUzUYXBp7Vaac2ICJuO6o7rArnG
	AsxQ0aPVc5OJmQ6vAjE+84WTcSfzywuswfWednn682xbbirLw7P6XmKJ6FGiMfSL/i+YvHHxmjq
	9aR0TflXWfzl4gC/mhTZXkpbnaDBaiK7V1MeJqqtgbB3/enm7pKX0LST96OhpZlMAaHxQh+fTKX
	cru1z6GK4NeYxnqOnhh+k6/GXnZKnlP2MWD/B6qezbGEIgi1UrRrspKJ+0PI17IypcMccKGN30P
	K72kFqsqs37Lu5J/hnGQYV5NWXjjcOwOCoMP47abBVWyyoTU=
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216375e9.4.1761725999688;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKqhZC0CRaoe+oh+5iFeCWKZfBRUDuYDM2nN5t0zCHgNGsk8VxrCIMd1bsBbPfplLJXnHhw==
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216155e9.4.1761725999244;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3937b3sm33177645e9.5.2025.10.29.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:19:58 -0700 (PDT)
Message-ID: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
Date: Wed, 29 Oct 2025 09:19:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251029012434.75576-1-jasowang@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 2:24 AM, Jason Wang wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
> 
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Whoops, I replied to the older thread before reading this one.

Acked-by: Paolo Abeni <pabeni@redhat.com>


