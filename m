Return-Path: <netdev+bounces-233840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB39C1910F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054701CC1297
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631333DEFF;
	Wed, 29 Oct 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfywDkZB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCE33DEC8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725934; cv=none; b=ZrXvH2Qw08D8Q/PnQThSvvY2gn2I3cKJ9bLywOaucBdZX7rGYp41n3mcyeuWF+5YivzrsuCY9lF71CeL/wlR6dLgcNghdfbL1ZWvl4JZd8nkQaNOXJLXEmeNWlzozCaCtMXkk4NAykXqXpx+ypbzodreSXb1d8PW7aWzkNHkv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725934; c=relaxed/simple;
	bh=8H8soxGYOT3vCG44vOBwzgrU1KAhGT6U13rFxFdobrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3azMBqti6WAqEfKrB52ZwmntR8lP6IOQttFmlu4m+rwA8liIa+CQOLqq55jz3DO/Kd+Vz5/pF+/Fr8s6gHDPfi5IOnRTa6BCjI20j2ZaUizO0u75GDgHgY0idZMd7z3JEw0MGS+53lvNd2DAdWnqE8lIuihFkMsMk3KGJOQhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfywDkZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761725931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
	b=KfywDkZBEPV0P1bey4jIWH22s+XaVwTnw8GAeGVz10VfNfnigEUZUG3qOuy8hr4t4TkZTS
	X6x3fq06E1+whpa6e973ILcWwWvB90Go+21NIyoSAPZI3YqduTguDRnJYhoY+U+gpMLcBZ
	MiEwNQaOLg/PEo5NTnNZmcjJzXl1NdU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-IOPbAWZgPB2xebe1-ltpNg-1; Wed, 29 Oct 2025 04:18:50 -0400
X-MC-Unique: IOPbAWZgPB2xebe1-ltpNg-1
X-Mimecast-MFC-AGG-ID: IOPbAWZgPB2xebe1-ltpNg_1761725929
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4771e696e76so5484265e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725929; x=1762330729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
        b=Sk3G63VgsHOKh+2S6Ix4leC5DPI1W4X3RFyhGQOaHmhCQct8N3EistjRKOdY4nLWoQ
         0WJNIaHM8KGnrfjimbe+9nEUKraPDMoZIc/i+n4ICCQsZVRsQh3c+6iBBQOY1rQgy/0Q
         yDcUMrsChZGz611ctYxv2ysINlRX2VhTuoU8pq+IuLjPx85ofKOYwEbLhLcMRYfKZEzs
         D+LSQLxsQ4NIrOb1EdU5pbyJqtlztIcm8CH6P4uUcLhEdBGKChtchBJOTxrTZv9rmhPQ
         kydUhclwiHQfUy6LJ5vgh4OEQNYJMgrDUKos/z9mM6rHVQAdH/yMEGwBYk8XV+KE7Tzc
         T9iA==
X-Forwarded-Encrypted: i=1; AJvYcCVAKTCdsWpNmGX2yP7dycUypKDfiC6656uuQwJuwUbnvtrY4XAj90ewk3YLQ92BADW1WoFFaa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKxL2rk3IG+g/8ayZIb/GDDCF8o84ASs4nU4WxQKK8C4Sl5B+
	92ngGkLeHeV+1s/NYOLm7w50xdklI5d0jeHEut/7rbWURC8bUalFLRHCf1Itc/EJyWEJzKpcrkm
	XoiZ2M16F7zAr9PR35AzBcXp9XsHgF3wn3qoyQ7/lX4SsqARGnB7klNyxkw==
X-Gm-Gg: ASbGncsbDAzzFWLh44123n6zb4TlNLDCv6OxvII2fIy+QWp3gjwmnIuEBANhBDJx68i
	1Qbgsl3YCbdaNEDm2XP72ImuQylQMxnpgWgbUZyw9wl2h2tIp/SiXRWr3X/o0ZzIVEivpuqMd5T
	8lyNk7mffG77yMYJh4Fa6w9zaxJe6cG141sBegOdAPvey80fsgeUgQA9xC/BAfMaQ4NjnYcNxp+
	GbJJ9PNXgV4q+sA51lltXr5QkG/y2j58D8GnjI1+tFsPf+U6C4va26UnAFzb9fXCM6KuoM1Vxox
	nn8WhuiNLAn7SgB+IHZ3RmH5QFE2L3+XjqD7fdh4czjr8kz23rE+hMiO2eHX74nglqvr4vzvB6/
	93dC8xopZuiH/BsKM64HqDtGWhyFPOVTl8p6q8RSSTB8ihto=
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18373175e9.21.1761725928787;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7JQwZ5gI4oKfKp7iQpZcTNE4SIKlKh608B1gAeQM0JjYtj8qEfOSjsYmJMqvyHD8orGB/w==
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18372985e9.21.1761725928400;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm27290030f8f.45.2025.10.29.01.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:18:47 -0700 (PDT)
Message-ID: <96f6d774-457e-4bdf-a0b1-eb6f64b99a46@redhat.com>
Date: Wed, 29 Oct 2025 09:18:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on
 features
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251028030341.46023-1-jasowang@redhat.com>
 <20251028101144-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251028101144-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 3:38 PM, Michael S. Tsirkin wrote:
> So how about just fixing the root cause then?
> Like this (untested, if you agree pls take over this):
> 
> ---
> 
> virtio_net: fix alignment for virtio_net_hdr_v1_hash
> 
> 
> changing alignment of header would mean it's no longer safe to cast a 2
> byte aligned pointer between formats. Use two 16 bit fields to make it 2
> byte aligned as previously.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

FWIW, I like this solution. With the u16/u32 change, feel free to add:

Acked-by: Paolo Abeni <pabeni@redhat.com>



