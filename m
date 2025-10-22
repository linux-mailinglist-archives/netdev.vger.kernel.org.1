Return-Path: <netdev+bounces-231626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337ABFBA14
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035B7406DC5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3815336EE5;
	Wed, 22 Oct 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="L3z7L7HM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AD336EF3
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132240; cv=none; b=ak9EEwzVJSbDu9/uyyZEdsZEXjS0jxj+TZWYDAjMsur55qCD5PDz9aDfpuggDY/RPZPpS/10U+hUCYvxeHJgUF+tOuzmcXRbLy7cE5IvEccO8M0MgHPhqpwh8hmTW8zyfkVNpwdljK8eCI5KVbpSPUYYOv1hNNq7g+Qm89eZiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132240; c=relaxed/simple;
	bh=N8BmnloG0Liu8m1fUat9M/14n031gTIHE7qF3n1sd8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/dVKpEsHo9zJqaU8m0dcZtXQ5UknYVxhVX2G6uU4hCiC/97F+lds+Cg6iBgdXlHkmAXivEAda4xuSCRyLp/Hh9GJvvWUpcEWxxKLKjM/2AsWODme/3sgqynufhYzD911ZszIsvxaRw6NXxi254geZIKNbdQnYgjXO9zsa0Y4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=L3z7L7HM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b54f55a290cso1027505666b.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761132237; x=1761737037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAAu3r6hLvvmVj2HX3mdxxnwYRVWton/8389KmKNzus=;
        b=L3z7L7HMeVw8sIFe1c8lpiXMSuQHiocT74qtFW/NRCXIN407s79BDKAmVUpIz6dfBQ
         qmk7RaHd+iCj67pQZHZb2HY4SiccfORHkBitg8mycvcFDf6WrUq/h97tWNX2a0G3xBRa
         uSDbzYdDAhmhbmSDJAMNovjBM/ZFX0r6niKtmCRyDybrnfnmEKCgrW4JzOyHvQ6qg46O
         bRarbHmWQXhmGPu2tOLD/ObniUItVqzRPgEl+6cY8wfcNdX8CYVVc9v2l3fBwndKumwq
         BuyLmhZygSI7WkC6EJ8OEY1+vdQ00f2YR0v88SvQmrYGnhIWvA/DtNElsO/ktDNM/A7a
         8n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132237; x=1761737037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAAu3r6hLvvmVj2HX3mdxxnwYRVWton/8389KmKNzus=;
        b=ZPCSoUvZ0SIoUtnbYBq6wODUhDG/mTR4moRkOBwikQFXVRu2SRVeWUImF/VlxQbbvd
         hPbFDkQ9GHIXrMhqDG2T28KS8MEYRpVsZZMj/VJyOseOpvmlYGNBw+ULFmm0yoFtzPf/
         AJc+p9wlWqyLCwMT6P5IyeS+MYlfYAZIMhFr4rWs9zI3PqTZQBCskNaF2/w/60CVjScN
         aqy2huS4iS3SUv+TlJvFV4QKRl96smhpS3VXqAi3mrcxedYTb84fWjRQ8bUkmWTgoqP7
         UVtTfdA8Vw8beMAkRPU9ttGHBSw8zSENQXIJvCMgPWCiTLo3Zs1fhk15DdH+Xn8sZry6
         C7FA==
X-Forwarded-Encrypted: i=1; AJvYcCWrvM8Mm7Ceics+0Pdl8MKHEOKQpS7U1LlLaAeyga5lNwn/YqtosyZl6EI7o0S4QN+gXFnvoHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iOyl2bc6crk6rAVsNle0a8xEmD139zFLMonAHEgbKOKJnkNv
	FkNDspMbdvwPEdNGvVWGAB/KnklVKfD6DlleDyqzXd5M6p1FmgTpyPoaMuPw0UaZI5k=
X-Gm-Gg: ASbGnctiIO5UiAaWUxuYW8RSoicSsb9UfE7TbsZZwShC1DxADO6U2vnN57w6OBXoVa6
	vJKLQFWOHtFUWb/e8TRadLjyPEVwJ71+MJRzOoZrMbWWU06DY4CHU6j8pX3i5BmcL45cyzJ+CA6
	DSzbbZYJlrARUY48IOkAjZpzjzCXBVLciAjLOvGPcpuzxvD0i841vSF54lSxtEMfiu5u90yJWAn
	w3yZDOmEFVzVjnuxB1ofPUuZEpyJiCPBBGoyO+Pp+Cd0I/ZRhOwEpCQCI2u2d0YRg91eHREtMwa
	gU22c7RwWRcVJxa4TFz8+Uq7Hedwcpw9F9xrvmpxnT4WHgdqHWGhp0ANMF71F0BLJ369wlIWV8n
	4vSL4qXloDMyOiMHfNh27uCViy2+/bZxpnvC7vYo32f0Cn0unfhS9EuZNlKYHGCF3iLZzUyKYns
	B2EnW+pisvxQFNDyX/WKTuC6EeMAPFSeAi
X-Google-Smtp-Source: AGHT+IGy1yjjle6fjE97Lwgq8boy26Ux0Rfpas8YJC9FueCoulD9ANNrqWANmWoQ6Hf7OOi2Hpo4ow==
X-Received: by 2002:a17:907:c11:b0:b3d:9261:ff1b with SMTP id a640c23a62f3a-b6472d5bb36mr2156880366b.5.1761132237361;
        Wed, 22 Oct 2025 04:23:57 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm1302205066b.20.2025.10.22.04.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:23:56 -0700 (PDT)
Message-ID: <0dd28272-6131-4fe2-aa32-df315a6c4a0f@blackwall.org>
Date: Wed, 22 Oct 2025 14:23:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a nested peer field to the queue-get response that returns the peered
> ifindex and queue id.
> 
> Example with ynl client:
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}peered, both devices are locked, thus if netdev_rx_queue_peered()
> returns true, the peer pointer points to a valid device. The netns-id
> is fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  Documentation/netlink/specs/netdev.yaml | 24 ++++++++++++++++++
>  include/net/netdev_rx_queue.h           |  3 +++
>  include/uapi/linux/netdev.h             | 10 ++++++++
>  net/core/netdev-genl.c                  | 33 +++++++++++++++++++++++--
>  net/core/netdev_rx_queue.c              |  8 ++++++
>  tools/include/uapi/linux/netdev.h       | 10 ++++++++
>  6 files changed, 86 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

