Return-Path: <netdev+bounces-203738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD4AF6EDA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE5D163E83
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A02D7810;
	Thu,  3 Jul 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsNz4cM6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A92D77E3
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535303; cv=none; b=ehcxA4NhJYeemY6bkADi9vOYUmkatpaaZkVNei27DJaR7XSQRVagUjh+N1MSqIOFBkDVID1sWjnJWjnNRzItwfWm+RTSjWsvtfQwhWjlKrzMxQDM7cuD0vPL0QOBKyKY4YWT3Jdwe9oawKn2U3PR2DMEvvNNIGKyzip8CD09DfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535303; c=relaxed/simple;
	bh=VR6ewPlkDFxYVcgxyd675Ed+HjCla7X/pFXJY9SXONM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeT5SGI33bj1HanqzjJmD8ZeaGIcim6HCF7zFPr3CznCLe1MF7unJ6rc+vBJvAWNzD67I7KaT/lhARzb9tP7EDOq2gzLqMjsW9RJED8ja3kMd6/z82J+Y1pCQIXCDxr6fW21XySlE7eh5NLGy9pt7vKrU1otsMYFI4EwRqA6KQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsNz4cM6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751535300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/ecjRiZ4n4Bi63qDTEf/0ZSKiFCmEcZDCqQjBwaZSE=;
	b=EsNz4cM6h4/ptiaMsKO7dKr56tplXuMS2RlGXegtBd1SswWumsaFaXCLAj5CD3PexRb2cj
	OPmQoNIKdhTbzEW8cLvtB3ZOf9UqImnCylVTerswFDTBv5tNsnI+HIfcBTcQiy9xbPt4XS
	xfL8zuWU1Lfo4YhjoH0b85a/aKtJc2M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-ymZI5M67NW6i3NqKzdB6iA-1; Thu, 03 Jul 2025 05:34:59 -0400
X-MC-Unique: ymZI5M67NW6i3NqKzdB6iA-1
X-Mimecast-MFC-AGG-ID: ymZI5M67NW6i3NqKzdB6iA_1751535298
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d64026baso42306825e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535298; x=1752140098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/ecjRiZ4n4Bi63qDTEf/0ZSKiFCmEcZDCqQjBwaZSE=;
        b=DQ/zFHFSFYh9z6RfHfjA0Z0eehg6KXa3vz+YxBhftvNnnzvZGCPM4obKyQWnbscvmY
         Wd92tXnXNbhpHjKUgEj+zEMvXATNBajDFwOiLcufucRVNYnzTRpfHq+RnTkQTpYIvnvA
         aEmSS/T3P4g9MIyOCOH/Zocqads+AwDGzDarCPrOIhU+oKLi267RSvNJyUB/ENFyPYAY
         iZXOJN/5o3LxBn6cyAKZyHmc/zpZxWMZoVQsG7xQldXrKE12qIc4XagA+fgFpgJUeClc
         FKkEkcKsCLSYaThddyqEONxnMzfap2qtbwBgJkZeoAmNxgtHobH4dLYURKPXGWK4kfrW
         UPuA==
X-Forwarded-Encrypted: i=1; AJvYcCWRzh7c2S2iIcEjCBo3EjK0npxCJE1BSggAbbUY5IrByesulxW7Rpi1e3CMPHBFNlL2KshtTzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6wYxJ1NfTaaoZIPOou8qHl50hxwnQY+VCXNE5BdUN+VBj70r
	vtKTBVx66ri57FpDPQzaXpUl6I7NFQddh64ZVT+5LKggB/ui8RrGaWiF4ii0vGlZ6PEvpJMpXUY
	904XugwcV1VW1wLc+zevR5DG6LH8e/ubCrMUgBclHO/rrGWwJbatuRfL4Mw==
X-Gm-Gg: ASbGncslAkFIJSxidEtjd1HJOOpZuYgCDm3+pY35I5urApuw0KDj1z+QrA2mS/zDUxb
	GOq9SqJj+59FvF7d7zX3jeD0LB80UrAFkMDOPT/Vkm64PRYIU6X7QV3X2K/ET8DzyTJCxTP/h9s
	Rr4JGqYAjx8HY3UBLxR6uWLRk26ILSNhgswNXmhEbGg46wnUmR88M6sHLRs1rU3J2VM03OOeb30
	Fe88jqfPs8hGdBUUoolkPezC9RGd8/eQkzdodRFYCfS9rY6vS0qjaRcBUjpqNX/NobZMiIKKNt9
	MliSIiB9uUdXkzUhgzYSGxjYX43184RKXEtNip22QEdFFQVMwmeV64N+C9jx1TQK8k8=
X-Received: by 2002:a05:6000:25c7:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b1fdc22221mr5018372f8f.13.1751535297786;
        Thu, 03 Jul 2025 02:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Sup7XyxN+vlAC3A6KR6EYEEhcRygZVV8MNmYtKBfNlpT2OJsvFJElmDrry1SsdzOsPGkZg==
X-Received: by 2002:a05:6000:25c7:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b1fdc22221mr5018346f8f.13.1751535297350;
        Thu, 03 Jul 2025 02:34:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7098sm17827679f8f.4.2025.07.03.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:34:56 -0700 (PDT)
Message-ID: <c7eb3517-2fc3-4d91-8fa3-e5c870acece1@redhat.com>
Date: Thu, 3 Jul 2025 11:34:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
 <20250703053042-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250703053042-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 11:31 AM, Michael S. Tsirkin wrote:
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
> I take it back: given I am still not fully operational, I'd like it
> to be merged through net please. Does it have to be resubmitted for
> this?
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

I just resurrected the series in PW, so no need to repost it.

Thanks,

Paolo


