Return-Path: <netdev+bounces-150426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B969EA321
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83400188738E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5A19E980;
	Mon,  9 Dec 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DdBdyI+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0519ABD8
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788234; cv=none; b=OMCmkONYEfT2MFhvbQpKAHOrnqLAc/MIGdUkBpuairqjD9/ij8dHHD80lENBO0ErWKIP8SSSnrTmM7kJ/5ebE0SVeF5CsywEHapxKwU7fCUzRfAuatkZ+Vs7kPBDqe22c3RFi8XlOEuQKT1MZBkfD48B4UVZFTEQiOyZUnPEOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788234; c=relaxed/simple;
	bh=MQ6BGMkiTZAjDeCz1zpPsWTpFJwiXq+uTUSr/QdtR2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rknYaB80acPiE49PWZKAA7yCD+AF63L8BULoBqvQCb8HD0Og38afN+5SWWHS5b0ojZJKXIyLqng9Yxz//Nki65m28rD2kDz9t0Sz9fetVG0JHxeOppQS0znZS5q1DX0tjJHQB0Gu3apwT5AsVzOTzcqXjSQQbEApkwBwqiZ74oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DdBdyI+4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so3313933a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733788231; x=1734393031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/d2FdrRp4xEcwuQRCr1uin+p1CVpDEnp1yj0gHgEBek=;
        b=DdBdyI+4KWHBMuREHH91F/hEbn1X3+hq1EasOjwYg69aP0T8rbt17FM6TxwAeoWuwp
         KvDxFI4qKeCB4/wKKCEW/TZDH5xuv8inejw5NqpO514qkcSSsGJmdVthOMS0AkojlbzH
         hbt5dH5T+6o3zgMiKxHNRNZj3AlSllk+6j+U4HhE/NKPPwvFyC5qwRVxDVaJrfd0iFI3
         Ofv042kL2Rxp0SkVVvT9UKDpandPUXTfbaZzYnO09/rRReySFG65MJED9A02/6KpbCmZ
         Ajn4Zp1qmiOR0cSEFYfxZ+ckn5gPHHo/RKzozosAHguDMD27MoTU4+BHezgsSe+vhYNX
         ilbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788231; x=1734393031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d2FdrRp4xEcwuQRCr1uin+p1CVpDEnp1yj0gHgEBek=;
        b=mPgYsC/H/05Ghb250C9jacxqLbXDCLLteJYP6dtz39I5fB+4gGlXoIUfffPMeKtFW/
         0w+3vtKC1MksiU7CvPdji56NzxSrxvuM6XMzSscJaRdYfCFQFI4YY5B1nBLPp5PgO5jY
         JczGXzIhBol9e8EO2S6gOD/v5AxV51IQY2ZGQ+P52g54PeQ4M55D3lhbkfensY25u4LD
         zttz1tY8/vEZaNZ2ObrWzCCdDjpI/XdEBHbWh24lJYkdVndokQ17j9kup32HqQJIO3IM
         03AgzRwk/ciVmrClw/CTSWiSbr0y41jFcZKn8Pss/KskPrgC/oQ9OmM02FLCaoQMzJ97
         J5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWgnUjD+xkd6SJU/70CuCGe4iSSR7JcIxpH/VOlDMK4+f0UUYFbhhtEZtdSY1FCZ37Y2pCbqAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCmHk0LbecWtV3yktZBQbFncyaUy2lzIM1RwIPhfgfwHpXedY
	Rg1gt5Lic2XSa0kjr5VTRX3N0RhKOK6ksI5uAVDZtokXi0MvPyZxEc6J2fAV562EUttqzJlw/Nv
	8hG0=
X-Gm-Gg: ASbGncvnmyuEweTA4oUV74gDGbgvMIIH6lixlZXMPYVqbugMV4CY247xyOMPVtArjwq
	o5fgWqZXZztNgYjyHhMw0TIbA59UvB8tin8UqE/qYA4PihPD9Zr8TFEreUCf0gqLnuKW7MpOzw2
	iZlTx3fNkLJjnNmq3hXx/RfteCSiqCDEt1L8vQkA638P1abFWTCQDfSyz/EARnymiBt4R+7z8QD
	/jNX1pE+WUQxJciUgCOzsnqTQ6rTTNX/VjGZlrhfWTv0QyiE5LYr1fMSuik6ZYa5hUJTKoj5RV2
	XiiTjyB3r/3FJoM=
X-Google-Smtp-Source: AGHT+IHvqU5pnkLyZyz2Esg/i0XdEZjhmzi7tZ11Jn/xVvlZMUV7WLcTQnNgJYfzKr2uxDkP6wyRvg==
X-Received: by 2002:a17:90b:1d52:b0:2ee:c797:e276 with SMTP id 98e67ed59e1d1-2efcef044b1mr3951123a91.0.1733788231391;
        Mon, 09 Dec 2024 15:50:31 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::7:8c2b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm8543784a91.36.2024.12.09.15.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:50:30 -0800 (PST)
Message-ID: <5a72c16f-311e-46d9-baed-f0a25d2a3dff@davidwei.uk>
Date: Mon, 9 Dec 2024 15:50:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/17] io_uring/zcrx: add interface queue and
 refill queue
To: Simon Horman <horms@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241204172204.4180482-1-dw@davidwei.uk>
 <20241204172204.4180482-10-dw@davidwei.uk> <20241206160511.GY2581@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241206160511.GY2581@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-06 08:05, Simon Horman wrote:
> On Wed, Dec 04, 2024 at 09:21:48AM -0800, David Wei wrote:
>> From: David Wei <davidhwei@meta.com>
>>
>> Add a new object called an interface queue (ifq) that represents a net
>> rx queue that has been configured for zero copy. Each ifq is registered
>> using a new registration opcode IORING_REGISTER_ZCRX_IFQ.
>>
>> The refill queue is allocated by the kernel and mapped by userspace
>> using a new offset IORING_OFF_RQ_RING, in a similar fashion to the main
>> SQ/CQ. It is used by userspace to return buffers that it is done with,
>> which will then be re-used by the netdev again.
>>
>> The main CQ ring is used to notify userspace of received data by using
>> the upper 16 bytes of a big CQE as a new struct io_uring_zcrx_cqe. Each
>> entry contains the offset + len to the data.
>>
>> For now, each io_uring instance only has a single ifq.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> ...
> 
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> 
> ...
> 
>> +int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>> +			  struct io_uring_zcrx_ifq_reg __user *arg)
>> +{
>> +	struct io_uring_zcrx_ifq_reg reg;
>> +	struct io_uring_region_desc rd;
>> +	struct io_zcrx_ifq *ifq;
>> +	size_t ring_sz, rqes_sz;
>> +	int ret;
>> +
>> +	/*
>> +	 * 1. Interface queue allocation.
>> +	 * 2. It can observe data destined for sockets of other tasks.
>> +	 */
>> +	if (!capable(CAP_NET_ADMIN))
>> +		return -EPERM;
>> +
>> +	/* mandatory io_uring features for zc rx */
>> +	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN &&
>> +	      ctx->flags & IORING_SETUP_CQE32))
>> +		return -EINVAL;
>> +	if (ctx->ifq)
>> +		return -EBUSY;
>> +	if (copy_from_user(&reg, arg, sizeof(reg)))
>> +		return -EFAULT;
>> +	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
>> +		return -EFAULT;
>> +	if (memchr_inv(&reg.__resv, 0, sizeof(reg.__resv)))
>> +		return -EINVAL;
>> +	if (reg.if_rxq == -1 || !reg.rq_entries || reg.flags)
>> +		return -EINVAL;
>> +	if (reg.rq_entries > IO_RQ_MAX_ENTRIES) {
>> +		if (!(ctx->flags & IORING_SETUP_CLAMP))
>> +			return -EINVAL;
>> +		reg.rq_entries = IO_RQ_MAX_ENTRIES;
>> +	}
>> +	reg.rq_entries = roundup_pow_of_two(reg.rq_entries);
>> +
>> +	if (!reg.area_ptr)
>> +		return -EFAULT;
>> +
>> +	ifq = io_zcrx_ifq_alloc(ctx);
>> +	if (!ifq)
>> +		return -ENOMEM;
>> +
>> +	ret = io_allocate_rbuf_ring(ifq, &reg, &rd);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ifq->rq_entries = reg.rq_entries;
>> +	ifq->if_rxq = reg.if_rxq;
>> +
>> +	ring_sz = sizeof(struct io_uring);
>> +	rqes_sz = sizeof(struct io_uring_zcrx_rqe) * ifq->rq_entries;
> 
> Hi David,
> 
> A minor nit from my side: rqes_sz is set but otherwise unused in this
> function. Perhaps it can be removed?
> 
> Flagged by W=1 builds.

Hi Simon, thanks for flagging this, I'll remove it in the next version.

