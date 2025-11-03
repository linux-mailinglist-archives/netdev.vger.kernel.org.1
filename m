Return-Path: <netdev+bounces-235114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D5C2C414
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D507A189475F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D972FF15A;
	Mon,  3 Nov 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXN85PgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F5274B2B
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177886; cv=none; b=rD7Kf6O7pvS3uqfB7rCEwl+ml6kYIjGc+4FiPUzy7pbApt40gJfnFKUk2TuoQsbPUNn2u8qAMToc/eSubzkbEBehzNP7D6ZMihv9sVIhjc6IB3MtG/PvANT7W9xZUqu4MzooWPeAIvajZzD0zaR4ruJD8/9PISD/t4eSHoVBx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177886; c=relaxed/simple;
	bh=BQDuC6r6TWDQJpT9KkmN2q4sS8FD10IGStDubc3vX54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJIRWkFgmNWloFTiokadAGN8jBW8yWUFGt6bM/pqsUfel2pgsvzb1IYhxglUbTXtj4v+Vvjo+F1cq7r63BnaeAp3lLBxsmSW9ybs+zoj7ZBedS2ptMYtfL7/GBa2E9Kzg5BDXUQKRndFmHoaLLJlmnXv8iTF3necqNk4dj8+mV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXN85PgB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711810948aso31456805e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177883; x=1762782683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkgKOXS8iR41FJ7eJBZfn0YxAKuFudOEEAKSm0IDw3Q=;
        b=IXN85PgB9Z7OUh8x8nBUXF+0SXEMrh51nu0sW2tkSgHcqgZi9r9Zr2GK1ySRo1HOeM
         ffxLYagmaz6r6QraZ63Q8HFmP5kdGoXMvW3hYOTpf6HRl7a+zWlRJ4whs2XQ7Fwaouqt
         UnzxMgDcbdVH3ri2Jda596VThu+o6YRhaRgRCy7mrDTr6kqD6OVoD+GjFt1jR3t/Fjqa
         BLnRWAOk4V/EgTIkH+MdDWKk7C4y9jfwKKunsHBc5ez2OLx76+vlNsCk55yovU0vyFkb
         CglmVCgyWMrw/bjdySpdxjWUxVrIlZNS+Ml/ERERTd0EIHtDdhmtBpQvuFIQyVr3fN5L
         S+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177883; x=1762782683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkgKOXS8iR41FJ7eJBZfn0YxAKuFudOEEAKSm0IDw3Q=;
        b=fMo7E7Qzh4sITVhfsaA1uiYtzXTWRqVvnaqviKr39jXq3pZBKnR31EtJcAx6QlzvYz
         liW951gXHODwPNAOzxkv/me1N+vILxtGGLi2hIx1eTvzQHtSxlIW2D6yBCXpPTiqNmmS
         X44GDK/hgew5qK/pyOMcQsJ3NT1wQ5zfIYQ330iAe+aRtwLiWeMKh3DAGjrL+wLHf8NX
         hU0y39Nscp8Tl3doIh1pNIfK/O8Ny3BSDS/DhPnoiShqwChpZSOpvGeHculE8h+19+Pm
         8eP8R3kao8DeW7xHFv/gR2mAqwV/YKOfvw0xqF2DmPEIIA32QfgfOQnGlV4/cE7Y9TN3
         fbag==
X-Forwarded-Encrypted: i=1; AJvYcCW5if99pE+9heHN49q/fPs4VTczvdWHvF4J+sHnIv5nRhsP+RFxqHpgjOfYO3JQ/E5qqqrEY9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7XHyatbnTDBx1egZunYnf1+iV5jpHrEWb35+H5O1t3VzegJz
	mEqk6xlQSfa+WkoP4K50MR6EhufO89ZYzOy+CTx14+Y5dPbZL88eRKxg
X-Gm-Gg: ASbGnctpXXdJro9Cte/+IDDiHBKe/zQRuWvtrrhYUlVKnePz3sC5BKx4G6Qce79aS5n
	bgl8wipHHncF4n7u3gg5TQJxrJ1LFMyx86jaQfJuj2DZlK86XHZGw1tFXuK0G+LG7y1bWm/lkaT
	FKkai1eeBe0DG0/Ig5c6/L00HC41O/FlgX4/RF3aS6Fl5eyxCmC7ilHwbOK0IjbN4+2/WUURo8Z
	V0Hf99Aqi5GCG2HZOlZRAGRwS3nz02dWtdkXTxVtYzVwraE1WV2oVkHA/N1l5K4DiSDTfVUxnDb
	h8vmFy3TXYDnrbI3HBVYeZYBVZInf2nTSxo2edCz2xQbHlRbT2KuSjgpmJpaArv2cTVnn9KJdwb
	w11wRAeufkIVVQJpt/BIOoAfnt2y93DDRxrCjC1IlWJCrP5RkPqPWr1PjfFiBkjQ6o99PTJjl+4
	DxvmgYbZj2c13AuaBjetLWB9TwI+cvZJpv
X-Google-Smtp-Source: AGHT+IGxjdLdbAjuRyDH6Sfd0+V0iMnyxe8nC+AdTMfwTxHuL6tvjznsPScW12HQ+xMzzx7c398mhg==
X-Received: by 2002:a05:600c:83ce:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-47730871fa6mr137194365e9.19.1762177882479;
        Mon, 03 Nov 2025 05:51:22 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:21ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47751794620sm29118545e9.6.2025.11.03.05.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:51:21 -0800 (PST)
Message-ID: <c374df85-23ec-4324-b966-9f2b3a74489a@gmail.com>
Date: Mon, 3 Nov 2025 13:51:19 +0000
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251101022449.1112313-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/25 02:24, David Wei wrote:
> netdev ops must be called under instance lock or rtnl_lock, but
> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
> Fix this by taking the instance lock using netdev_get_by_index_lock().
> 
> Extended the instance lock section to include attaching a memory
> provider. Could not move io_zcrx_create_area() outside, since the dmabuf
> codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.

It's probably fine for now, but this nested waiting feels
uncomfortable considering that it could be waiting for other
devices to finish IO via dmabuf fences.

-- 
Pavel Begunkov


