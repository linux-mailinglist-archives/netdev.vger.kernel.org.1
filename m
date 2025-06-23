Return-Path: <netdev+bounces-200166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D6AE384F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF0A3A7013
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F75214801;
	Mon, 23 Jun 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGrxby1/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1F4409
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667030; cv=none; b=IyuQ/KTILonEl2KDixRk1VGCdySs1Gp2zwN6oqjgjtN2mzzj1bdagALgz9UH94SaIZnNX95dRTtJQjeAw62MD3UEhFaD93BK4PiGDT1sRQvYRmVxxdBx+AzEElXniTeUILTTcuTpB1Fvpv0d094QIgpm2r21Gtt8QqmpDJ0Jlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667030; c=relaxed/simple;
	bh=en8QrJPhsNrl7YK82mZ5WzMrvKzHhr21END3yzfm6LI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tUlnwlfGTj5mtSyczPb4dCXatN81wYoWt1dNCztmGRZxKV38ANU3w6eG2nhSXTJWHZomVQjnz5hth1b1U6r7jMmcmQEgdJZiJ0m38uGfouH+OhRgWR6Y+NCJ14o9Z7tvwZlYPq6DCj+PbGWCHHDTZXg1DixSZIxDlvE5nzXOQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGrxby1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750667027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jSW9p1LFhnQZlRzlNm8vMLHTJK3KRvHXtgF/U+dj4Q8=;
	b=iGrxby1/C6WSYW0+ahVVr3RrPQ1cG/pw+z0w6M4HMPJyF7/wgcQYX1xthMOHQcsQfXU+jT
	2mwT2SMEvFdipKobKmpEw4VcPE37RF27tC7n3CbXyzDZIZZPNzd7LqUUWeLM7AgPP0SbYS
	yY//MYhJ+jKNPcrWYGBNZkPg/h9T5s4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-9bl7TVSkNdeCF3AltvByEQ-1; Mon, 23 Jun 2025 04:23:45 -0400
X-MC-Unique: 9bl7TVSkNdeCF3AltvByEQ-1
X-Mimecast-MFC-AGG-ID: 9bl7TVSkNdeCF3AltvByEQ_1750667025
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1412031f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750667025; x=1751271825;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSW9p1LFhnQZlRzlNm8vMLHTJK3KRvHXtgF/U+dj4Q8=;
        b=Zai47WBNUdfrTejJR4N69/syeF5rURqldw8hGvRa0K6DiTF5vopMuzBytgJaqD463C
         722EIaGBqAPvRuoZ3oKpigWYpiZfrLrFP++Rg3KB/84mRw5mQ4LPgujS4sfY0uggseD3
         1K4banzGis6bK0GGpi1NLrd1TGdK7PKtvdhdoORvANBxlmSbapgZvvTGmBlz2v0oAhFY
         gxmkaHW5gcBfePjA/xtnLHt+pWNNhDwQ3ccWTvqGGAC8DMeHvBZUWxjdCnnMA4XBa+gC
         rQnaX78nJQJik6AVllLK+F4fZp0h0q+/MMBMy/fRnkQp6cM8YCFbYiv+vGcKmzUgT9RI
         sOaQ==
X-Gm-Message-State: AOJu0YygnWdDR92suvlaBdHiELzqHGdcDA8kmpZu59/xwvqswbC9ikV6
	pGwPBecFSKgod4batU4nX/IYwKbtd0pW81+shJe4ycN+qF0XnOfCegH2fQKFias4A0YJiclIpLe
	s+g4unRK0COcyHX/oo91qNC3wK0HNkaQ4NZneJPEfxquQN7HoBcwj2GO+yA==
X-Gm-Gg: ASbGncseZttefCKnJpWxVMvK56DU+plAolvFsMff7sGXcINew5hOUolG5U3VYQacaMn
	uHtELJ+W79dDl1flo/8X+iTgFG6cqsxISyjOB+QR+Ijkylm72whCnkJu/gR5IxQ2pgX/aAi37jw
	O+Y+e8XfEFrPemRFDvYiQ/BLTSWO8v7lnSx50imsPt6yiomCaBDGsjcFVG0Mg+laJ/ot2D4hBGq
	MFAkf9z+I670gRwIGPPqRO1D5VjbAsWxo0m+cqozwcKz5Tr8jj42VKQrj79k3mgOjWDc5bie7Lz
	RYxa2mpeqNzr1ngZbtJT6LpPlL+I705K9q5zsz/S0i4pdyBW125QObUzpf2LWQ==
X-Received: by 2002:a05:6000:4282:b0:3a4:ed1e:405b with SMTP id ffacd0b85a97d-3a6d13130b3mr9743549f8f.46.1750667024672;
        Mon, 23 Jun 2025 01:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD4FMRtntVzqGm4uW67TEz4zWMScYCoKrEWMQ/X31AJVb/Pub9G52VV3df8sIk+2vF8etjpg==
X-Received: by 2002:a05:6000:4282:b0:3a4:ed1e:405b with SMTP id ffacd0b85a97d-3a6d13130b3mr9743527f8f.46.1750667024316;
        Mon, 23 Jun 2025 01:23:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8edbsm136655255e9.24.2025.06.23.01.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:23:43 -0700 (PDT)
Message-ID: <0c4b28a6-44c9-4b9b-a917-634c24d0e01d@redhat.com>
Date: Mon, 23 Jun 2025 10:23:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
From: Laurent Vivier <lvivier@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
 <20250528031540-mutt-send-email-mst@kernel.org>
 <ecfe7d40-257a-426c-b200-4fd62f18cde7@redhat.com>
Content-Language: en-US
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <ecfe7d40-257a-426c-b200-4fd62f18cde7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2025 15:07, Laurent Vivier wrote:
> On 28/05/2025 09:20, Michael S. Tsirkin wrote:
>> On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:
>>> On 5/21/25 11:22 AM, Laurent Vivier wrote:
>>>> This patch series contains two fixes and a cleanup for the virtio subsystem.
>>>>
>>>> The first patch fixes an error reporting bug in virtio_ring's
>>>> virtqueue_resize() function. Previously, errors from internal resize
>>>> helpers could be masked if the subsequent re-enabling of the virtqueue
>>>> succeeded. This patch restores the correct error propagation, ensuring that
>>>> callers of virtqueue_resize() are properly informed of underlying resize
>>>> failures.
>>>>
>>>> The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'
>>>>
>>>> The third patch addresses a reliability issue in virtio_net where the TX
>>>> ring size could be configured too small, potentially leading to
>>>> persistently stopped queues and degraded performance. It enforces a
>>>> minimum TX ring size to ensure there's always enough space for at least one
>>>> maximally-fragmented packet plus an additional slot.
>>>
>>> @Michael: it's not clear to me if you prefer take this series via your
>>> tree or if it should go via net. Please LMK, thanks!
>>>
>>> Paolo
>>
>> Given 1/3 is in virtio I was going to take it. Just after rc1,
>> though.
>>
> 
> Hi Michael,
> 
> rc2 is out. Do you always plan to merge these fixes?
> 

Gently ping

Laurent


