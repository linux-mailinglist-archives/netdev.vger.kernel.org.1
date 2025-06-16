Return-Path: <netdev+bounces-198052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95DADB126
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97DB169C7D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C0292B5A;
	Mon, 16 Jun 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivpaAujU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C07292B36
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079255; cv=none; b=c8XIdso+WPiJFw7VwAOy86T1jJJvNMEujq2JxBjQzVBSYkBpnHoysCoZ/D5SuhbMeV5I9sksao1FMnTC1RhFQt3TkClkybWbT0D2DR+MTk/yV6qK5Eb+knHZwlzT+OgJpFJvklZOVnnSmpuLS+KpbnvidFVEWvmhouikTCFrjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079255; c=relaxed/simple;
	bh=K+2x3g3ibknHv1jEjab8MkunrvI8egf4XRjyzS3MveA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JglIVqTUtzuHp/r/Jb0aGINUdWOyLKhIlOsJ75cVrRYBHpu+EQE+jXbTvFpOoSq6pxZO9RNvnTIG0H9R3NFeIpItcRAINjWkxzPhzndz6UHL5c5y9G2sIu3ZzMlMptp+jQIVTjg/p40CNi0C6oRlqFrQsG5KotuluHpJBwiz114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivpaAujU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750079252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NEh91vA9Wxz85gRtNA+9lUxQQ56dlvAv6y9wRHW8BUw=;
	b=ivpaAujUntXBJxajdfwulr0RQJ/cirw/me+q/pK0p9smL9ZxdCyi0m+v29sY68zQJd1YIG
	cV9sh3tABPWYo4Y3AkwUft2DL6ugUlJVnrczmKNOoor2nLbBbfJ5tYB+ZksUYlbsHoZ+x3
	rqdLt64b8wX+2PuWWpKPmM5EZuYgVBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-0J2CACD4PFmHOnlBPTfIHw-1; Mon, 16 Jun 2025 09:07:30 -0400
X-MC-Unique: 0J2CACD4PFmHOnlBPTfIHw-1
X-Mimecast-MFC-AGG-ID: 0J2CACD4PFmHOnlBPTfIHw_1750079249
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso2966846f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079249; x=1750684049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEh91vA9Wxz85gRtNA+9lUxQQ56dlvAv6y9wRHW8BUw=;
        b=rbed/n/GzBObV7Yazl2ScHpOvxdjChiOF9JsyyXgHfjUYro1erg1NEYwdF8T+vAYVY
         9CfmmNbB3zvYOX6cGZQV+VX2fu/ZVGcCUM/ogM57HboQKUbjR+MPXLuoPQzePqe4fou7
         24DeWTI245WmVEupxs7eQ7WfsVR7+ySejMYnkzQlcK6O99HqiVjUlIwQzWn/URSKFKdM
         8SKAiHfJm+TlrdEEh3Yq6G1ujaAbhiRCAZMFz6G919rwv+aB9LuxPrQ0ip1p9f5A59JW
         PNKYDVkSarK6yzkg/HFK5Rg2/wZicxE6Hkut1ZQ1ZP/IQZ8J/gSr3MfgUPioMyCqj+hd
         w7fg==
X-Gm-Message-State: AOJu0YzzhNjvzVoOIIydaUp5nRZJW4hAekKBiqdnNE2ewTX9TxgTJET+
	F4jlmtZzNdpMRIBvHwBExRFnmYpDD+WZdRYoJPVQ8ASs6AXxuvxlN+Zg/tGjgBcndGq54s3LRec
	AMWwufHe7ejisO85ju0qyBx4oKAncbJh9rYSqkeOBNiwym56pU4J0J3uU0g==
X-Gm-Gg: ASbGncvN3WF9ODoIlMNI6O8rZdlOZ2zhfX2TaDDEGgeQqDIffO55m5PZYcARrhgFChp
	4H5AYgOvcTwJaEnBOA485e50lCidBp3Am5F6jYpp5sO0e9Nci27l9uo3MI7YS7rksN79VCgMc3w
	r1c/9kD+6r8lOQE3wXZ4uyKY8tb5e8LNbf0nNPO7jE3HsYA8loY2vIkzp/LYti7Kq7tQgUinxvo
	+9EANQi95KcQouDN4/zehg45kDFEim1BoneWa3ido/t8gpsiLgWWTvVZEE23zX2r/qWjO9EdyAT
	2bT3zZFmGNyYRFwVXLAiGnZXnPRvBT9qgTuEbmerGI5RtHcppT21YyFsnR6Mfg==
X-Received: by 2002:a05:6000:144f:b0:3a5:2599:4163 with SMTP id ffacd0b85a97d-3a572e8e56cmr7284425f8f.47.1750079249441;
        Mon, 16 Jun 2025 06:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx1GOoDTc/8rrvBJlWHToytU+R3cfbzVAbYt+/o6NPhC2gNi5p8T4FxpCUlpaE2CWc1vf5UA==
X-Received: by 2002:a05:6000:144f:b0:3a5:2599:4163 with SMTP id ffacd0b85a97d-3a572e8e56cmr7284381f8f.47.1750079249064;
        Mon, 16 Jun 2025 06:07:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b09148sm11418791f8f.58.2025.06.16.06.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:07:28 -0700 (PDT)
Message-ID: <ecfe7d40-257a-426c-b200-4fd62f18cde7@redhat.com>
Date: Mon, 16 Jun 2025 15:07:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
 <20250528031540-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250528031540-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2025 09:20, Michael S. Tsirkin wrote:
> On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:
>> On 5/21/25 11:22 AM, Laurent Vivier wrote:
>>> This patch series contains two fixes and a cleanup for the virtio subsystem.
>>>
>>> The first patch fixes an error reporting bug in virtio_ring's
>>> virtqueue_resize() function. Previously, errors from internal resize
>>> helpers could be masked if the subsequent re-enabling of the virtqueue
>>> succeeded. This patch restores the correct error propagation, ensuring that
>>> callers of virtqueue_resize() are properly informed of underlying resize
>>> failures.
>>>
>>> The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'
>>>
>>> The third patch addresses a reliability issue in virtio_net where the TX
>>> ring size could be configured too small, potentially leading to
>>> persistently stopped queues and degraded performance. It enforces a
>>> minimum TX ring size to ensure there's always enough space for at least one
>>> maximally-fragmented packet plus an additional slot.
>>
>> @Michael: it's not clear to me if you prefer take this series via your
>> tree or if it should go via net. Please LMK, thanks!
>>
>> Paolo
> 
> Given 1/3 is in virtio I was going to take it. Just after rc1,
> though.
> 

Hi Michael,

rc2 is out. Do you always plan to merge these fixes?

Thanks,
Laurent


