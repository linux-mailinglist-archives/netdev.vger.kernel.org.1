Return-Path: <netdev+bounces-203671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914EAF6BD4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F64748207C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E79298994;
	Thu,  3 Jul 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIbbGulE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26922D78F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528634; cv=none; b=RgR5/im4IE149qktbR6RKztbqnbaPABDs8klySXlQ46jbl0danDs9C49Ez+2j4OiReCiw5CiKel8kM06TiK34ofQS1Mo8+xiG/WntlQW6w9i45Yu+J3V2b9sQYPn8JZMKaXWjXTAaLU7ck/decl8KdRH/TVjQMxkFnhSPZdm6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528634; c=relaxed/simple;
	bh=R12TjoQqtaP+OHOg5vELHjQDxeyg7kZReIjNyGXwKnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daVtk/KIELqTzXk9I/j5DEREDJqgUR8301WPkI4jGCc8rXI2xrzSy1QGq6cmFZ5PxCrYxCrzqZjv08onkliHOwuWhdMNX/8w8qbABMxCnyT9xXl8l2ioTe3XIKCRfjY2yutvlwe7GxefDGpXX6b1FWQSD++rtk/+w82OuePRuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIbbGulE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6EpDYxyy2mrZVYzfWYPjxHIrTItJ7JlFF1ncAGLURGQ=;
	b=CIbbGulEb0MmFEiSIud+Cp5U3zz3Lj3poqEtPi12v8aAk+vKMoZPXcyE4AOX2xmNZhzS/P
	1ZBYRhWgvV4fovwnWZTVuH8LL8BxbgHKVz06RqRsCPdoO18SFy2bfu+k2V3I9tIvQ+v2r3
	KzyEcsKxidq3K7C3e5v5gH6XSUPElSg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-aPIeHyRdPAacQ2UpjGgvAQ-1; Thu, 03 Jul 2025 03:43:49 -0400
X-MC-Unique: aPIeHyRdPAacQ2UpjGgvAQ-1
X-Mimecast-MFC-AGG-ID: aPIeHyRdPAacQ2UpjGgvAQ_1751528628
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so3552510f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 00:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528628; x=1752133428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EpDYxyy2mrZVYzfWYPjxHIrTItJ7JlFF1ncAGLURGQ=;
        b=PBfDkitSlB28hkDCUZt4NDuARlCvzQvRxzh2Bbo4uKXf7XxwvxS57dITmKd9z4y6aK
         d0oByR1/M3GfFjo/TXCSbxu/uEnJLpCVVSHXfhn/8dhU1HjFpgiD72ONmkEf5WiUFPrN
         bT+HfKGSQ9J+xIgWKZ0lgJCSz5PwtSmiZAxQt7J07O5aUDEkdysbkNh73UBbmcxjMapr
         GMVj1OBpL2038xHE8gNmCPX/nU5mwLrtMupv3fGCxkzZMWdkBYKFcE30zHecCMQ/sEsM
         ei6DZVqkfQjIEpSVbe9uHf+faf32EsGcZlRXa/oyh8VaAtVUnXOEW4M1Sgqko1ZYiyI5
         Ttng==
X-Gm-Message-State: AOJu0YzMcfhCN3IlA62axA5kCGutOxw6vliZ3h8d8Dr5toztcnJAnBGP
	obdvYToNy4yINkuuwZ+3If3/5YyUBaGkRVnC++Hf8GkIHkjjEULCEDzxvzVY2HWFjKdw0q96dZM
	tshO/Au1yXo/K1bPqbUO6pGg3k0L+TeslBunjl/0GfzldiytInkS4HaOA7w==
X-Gm-Gg: ASbGnctQgaNI5LZVzgk5+y0psGh/mG4OquT0l61hNKt7ALES2xWX3Fs1hvFehP41x9W
	uLPgwTe3J0IQ9tHl4Y5WR9/K8Tok3FzqrXLX/Ec/xsldYLUEDENP+AOnk7vmq0gicYoc5gOKTLf
	AYqy7P+FmeSiZEkWgHgCk7Ke+dEuA9+ZKyUMc1Yuj1BkPvxtS+OAmbdunQFomVvZ55sTaGx0W//
	Sq8p6OXI7mvYJzWODhS81bQrJjhDPKO+ZaEMxPMNQHdtv/wyJN5nRDGDYPkwO9WZDGh/R2uCKyq
	W7mq7xjqpoh2d/Ok8fuwzgfW0NJ187CoG8NUKSxocTHdagNOilHI5HUL8l6zLg==
X-Received: by 2002:a05:6000:1a88:b0:3a5:8905:2df9 with SMTP id ffacd0b85a97d-3b32ebd79f0mr1569341f8f.37.1751528628425;
        Thu, 03 Jul 2025 00:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvFrMwfp7e/fgq6XK2cDp/19q243cAhOekmS354fLqpt9h5aal0IYzzF1RmWfR/wO3yuF5tw==
X-Received: by 2002:a05:6000:1a88:b0:3a5:8905:2df9 with SMTP id ffacd0b85a97d-3b32ebd79f0mr1569317f8f.37.1751528628045;
        Thu, 03 Jul 2025 00:43:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f918sm17831437f8f.100.2025.07.03.00.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:43:47 -0700 (PDT)
Message-ID: <770fc206-70e4-4c63-b438-153b57144f23@redhat.com>
Date: Thu, 3 Jul 2025 09:43:46 +0200
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

Michael, if you don't have time to merge this series, perhaps Paolo can?

Thanks,
Laurent


