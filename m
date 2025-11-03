Return-Path: <netdev+bounces-235218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B17C2DA72
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D540348354
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14528B7EA;
	Mon,  3 Nov 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5Nh+0Zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38C2877FA
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194092; cv=none; b=j/NQNXmQFjb7VfxMfls51iOQZH/x4AdQ/CYrD815XjJs1H/OrbK0ccssuHMUjG8E5E5ni4yuOsQAkQZcnblfSvTuGpdV5xuQ66qyYtoLn9WRzWy27dIGUzvevqGrdqKBo+Do8UqUZQKopr8q07GTocJuvISVlmTkXLWLqY+mCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194092; c=relaxed/simple;
	bh=0SQNynA8VddDnpz9ZxzD00wZ9dZv8gbMqYchXkBE2Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTER+42hJiRmkH27NtwN3JmTHDrk5EPGbXO3I7HNXjekmyCD4x7imLA5tHTYKYJEK0QIfRHj9Y40/kze07k3pzuNdfAcwc6wcOKw1um65Q6OEGadeHSNkP2zkP0EgaFswRutRvIMMd1O2sfltUArWLyt5fRuMavC2BrPkqfYe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5Nh+0Zd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso21830275e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194089; x=1762798889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OQ2QHegR2fAtkFp3wMKAgGG3nOhcvP9QDUj8F3JZwA=;
        b=g5Nh+0ZdxBxmVpBLINSvbgOEYPpjUgiUytLUMl+jbj3mfBxosf9qNOSaWNXXyxwpDm
         TqLZZyKmtKb44dCgy8l7Jgmi+Lh5c71jZDAenskImWCQvhYtV+bu5YHUEbjvIdusP/mA
         y0gaCjwhROHiRthhNUVNKqyckYzVxq/0pdVHsmaL28vAMjh/7rHT4rmWMgZdLBct6/Zz
         2BT4lIXbFrxt+DsnSMefbnLnKBBiuOqU+/yqD8UdjPI/H5tcTYwn6QAjV84YzpqRcl8w
         hKQ5kZKIxs1RQcMpy8SpR9G1SndTc7jiVuTU0zpbA+jkgg9GVpNcosIcpwsViTfbmtFb
         N39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194089; x=1762798889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OQ2QHegR2fAtkFp3wMKAgGG3nOhcvP9QDUj8F3JZwA=;
        b=DJzNq5kfGVFmEgvgQ/xcebCm4+pE4dOBPfx303juTnM5/443ZJIGYNra968CkHKUN7
         qOcYgvgAnc07W+ImFClJ18tthGwgRF4nPq+pgSL5mWMSMnRDPY/8zz8lxKIq/L4o9P82
         JOQF3Xmyr6Flbsvh7495qICx555qW1CJChXzgaROH2gU8KS17n+qxECyF+ySpLD1Qxht
         KZmApKl2ofT0ow73UBsR+TupEJFGm35U8Fi2bWnJb8SxefXZT7FUpVLR/umZZx+KbD5T
         +9cUzuwPfyYKUol3Osa9d8MkP6EUjc8VwoYbAtqkjQj4ztg/C8+xePlTromO4c0OByMI
         vw7w==
X-Forwarded-Encrypted: i=1; AJvYcCVDEsqGl8MjPr8BCqJSYYDFV9DUNwGvswAZ+xWUCjxT2fj6FHwoseDAi983dqGxe8KosBbB+nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnzSVAl+nzn4pmkiJLASdZi8ha/eHOQxOsHHlwZ/O48HMvSs5
	SA23jyweLP3Ec3PBObV5q1TC/hoG5pZnIMaJlIv/INSIUE4+AQcsqHVBELb0Dw==
X-Gm-Gg: ASbGncss3eU8+578umNFoiNhdWjRALFE4Rnc1nVqoklA41bDFBbQktbHGvsZK9Q6qYL
	u8aE0D12lAQYGo5MdILMwKgoD6w2MzZez12ZR5r6x5gnCJxQlLqYQFD4WrQXFynW/dZ0N+0pw0V
	3NI+VYntDRtg/U+2VZvKlp+lQJkAqhNrkO8fgmb8iFDSmeek6VmZWmb6jTYK4VfqSKShpvPwLT+
	Hyp5GALT7PPeeX5OY8jjP0YOs+hBYwJ9LT7HMyE69cX2ekR8qBrPpsrgtEHbCN8NNZuw128bMCo
	/b/C4c7eGP/5qAZ/v26OEDtCf1ycyOXSWK6AzZ09fKlJ5JB9wCzT8x55vbe6VdQg2ccmdTtdAnT
	yrBufBitrjY2ffQRr4ZyDt4USSsB9Nxw7P3ejFaYehFKZGQ1yG5IEQPJ3mXfZxRg7E4LCnxibAz
	xc6TRc4GktWbACAvTBv2xyInddemFCFdRr4ygQXcsUlpFxqyNefe0=
X-Google-Smtp-Source: AGHT+IFtQ1A7biFNab2XYzWjm9i5l+ofr+kW0gooTMlXiDRNgoId/5yjZJdKEWEKHKVqFEx7G1gmmQ==
X-Received: by 2002:a05:600c:a02:b0:471:13dd:baef with SMTP id 5b1f17b1804b1-47730871f67mr100828445e9.26.1762194088703;
        Mon, 03 Nov 2025 10:21:28 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9c8esm76775f8f.33.2025.11.03.10.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 10:21:27 -0800 (PST)
Message-ID: <7805c473-448a-430c-a53b-a42e8d2c24bf@gmail.com>
Date: Mon, 3 Nov 2025 18:21:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: io_uring/zcrx: call
 netdev_queue_get_dma_dev() under instance lock
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251101022449.1112313-1-dw@davidwei.uk>
 <20251101022449.1112313-3-dw@davidwei.uk>
 <c374df85-23ec-4324-b966-9f2b3a74489a@gmail.com>
 <c8d945a3-4b12-4c04-9c68-4c5ad6173af5@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <c8d945a3-4b12-4c04-9c68-4c5ad6173af5@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/25 17:47, David Wei wrote:
> On 2025-11-03 05:51, Pavel Begunkov wrote:
>> On 11/1/25 02:24, David Wei wrote:
>>> netdev ops must be called under instance lock or rtnl_lock, but
>>> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
>>> Fix this by taking the instance lock using netdev_get_by_index_lock().
>>>
>>> Extended the instance lock section to include attaching a memory
>>> provider. Could not move io_zcrx_create_area() outside, since the dmabuf
>>> codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.
>>
>> It's probably fine for now, but this nested waiting feels
>> uncomfortable considering that it could be waiting for other
>> devices to finish IO via dmabuf fences.
>>
> 
> Only the dmabuf path requires ifq->dev in io_zcrx_create_area(); I could
> split this into two and then unlock netdev instance lock between holding
> a ref and calling net_mp_open_rxq().
> 
> So the new ordering would be:
> 
>    1. io_zcrx_create_area() for !IORING_ZCRX_AREA_DMABUF
>    2. netdev_get_by_index_lock(), hold netdev ref, unlock netdev
>    3. io_zcrx_create_area() for IORING_ZCRX_AREA_DMABUF
>    4. net_mp_open_rxq()

To avoid dragging it on, can you do it as a follow up please? And
it's better to avoid splitting on IORING_ZCRX_AREA_DMABUF, either it
works for both or it doesn't at all.

-- 
Pavel Begunkov


