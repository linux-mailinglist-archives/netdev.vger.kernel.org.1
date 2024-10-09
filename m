Return-Path: <netdev+bounces-133857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF199746C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59771F2248E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C91E3785;
	Wed,  9 Oct 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y0/rcEq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1E1E3795
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497395; cv=none; b=KXAUnBH635T/8KinOApOj446uJdcw7Rmm2QUPKQKB1xusK1XGVCwha3pRYcrMi8375Cbl6aVHDz4OdvPswWxWSFKtiCTFAN92iJKI7Pow5g+ZOIHP+pi31uc6t35HabJe7NeQVrvYmgr4qcaoR7RXYkm4IlAVTVFXDExejMHOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497395; c=relaxed/simple;
	bh=7ZckoosOJg5lt+fGLV3IgX3ru9jsNenyyZEteqixIhM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IBM3H5xS5mFiNd+qrJnoyjOaHZj3Y6niIdGew7MVpO7QF0H7Rh5V7sWihOwHWNc2VuvMHNtjH8JWYAISFI5JWRmabtcy95iYsNpojhoPjt04UbsJpoUQcQvDh66XiPjTVHgY0J0BGjy1gEd+3LfWUe9mX3NUy5/+ON5E58GIlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y0/rcEq6; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-831e62bfa98so3070739f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728497393; x=1729102193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E1jAV6Csa9b7Umapqy6D5mKXVweTDrHhQslvN6XHIrQ=;
        b=y0/rcEq6e4siVCu5f5DZ4jlQtLvi46IrysFYN+e0JwqUzNAHCi85Gi0WQn/Dh1XUWP
         iwqPVg9Yn20qqlmDiYIRVs2FY74E+isPRhUKA7ua6hQpxZfPHOJTBwztqkGg9yxqEKV8
         NmUFTJnZC91T6sLrg1nVoTmZrg+NjzhV7i52WWHdpWJRq9qA1t5QV/d/ljD4aYD4erhO
         Zyyv72qU064Kb8MYLLKipoucUbka/KG32r1rEWJL/OcezO7WY4ZeSFhTBg4wykr5LNfX
         uVBh4d9+DlA7iy/0ply4ewqE5w7tMvniLHGgosSwX6UI88SUe48PTvv2HJXtdsTI8rKo
         tLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497393; x=1729102193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1jAV6Csa9b7Umapqy6D5mKXVweTDrHhQslvN6XHIrQ=;
        b=mUPDIqc/XnZS8yCk6tGtix6nDqIIcoqA1xv307c4sQHbVXFevixjxo1QBmzLOe9SEU
         ImeQExGa1D8IT0jMwg+o4ivFBnI9t/TRaTmS6vjCMAgchqldp6rQQecrLrAGQcLGdNYs
         zKfN2ZFrLukkuK4C1ztm73jkaTJqxKyiEaDy53EMTAkx8BeJ5zdIK2FdnaWOtEmD6gZQ
         7o+siGTfglJ9zDjmeEp4g3Qqt3s3R6Kj+8O6dMftdz5ORCpmmz+I5CWHu6QK/q8tsHI8
         nWHTBHOB/3e4xxKZuDif8st9u49E1pHMn8LI9OXtw6GTVBh4Ka9nrWlUaMna33cN/RsH
         3Kag==
X-Forwarded-Encrypted: i=1; AJvYcCUr0zowrif0w+oRBFs3Jhh0bEbHT7R9gKbFlNPHcgXp3o2CXgDGJmPnQaFEPLNSlB46Om6DkwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVj61l/UePJ6Uiha3gqyNa567COCzRusm+Aw0fa7VZFwtrmsG
	5XkkCtgeWxMEvFzyQmP8ZRfNFHyo9e6vJ5dX4N+2nmu4eqkXKz0lDgtlfctFnGY=
X-Google-Smtp-Source: AGHT+IF8Qe4fCL/c86CeDxV9U2SJmYSHr/HQ+Cny1xrRXaf9BAF7TwIpLEzpfWjU5vQjXxs0L2VV3w==
X-Received: by 2002:a05:6602:13c5:b0:82a:23b4:4c90 with SMTP id ca18e2360f4ac-8353d47bf54mr373507839f.1.1728497393420;
        Wed, 09 Oct 2024 11:09:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8354797ea3asm9909839f.24.2024.10.09.11.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 11:09:52 -0700 (PDT)
Message-ID: <36dc2b93-e519-4ff5-93b2-62a767ad0528@kernel.dk>
Date: Wed, 9 Oct 2024 12:09:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/15] io_uring/zcrx: add interface queue and refill
 queue
From: Jens Axboe <axboe@kernel.dk>
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-10-dw@davidwei.uk>
 <8075828d-74c8-4a0c-8505-45259181f6bb@kernel.dk>
Content-Language: en-US
In-Reply-To: <8075828d-74c8-4a0c-8505-45259181f6bb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 11:50 AM, Jens Axboe wrote:
>> +struct io_uring_zcrx_rqe {
>> +	__u64	off;
>> +	__u32	len;
>> +	__u32	__pad;
>> +};
>> +
>> +struct io_uring_zcrx_cqe {
>> +	__u64	off;
>> +	__u64	__pad;
>> +};
> 
> Would be nice to avoid padding for this one as it doubles its size. But
> at the same time, always nice to have padding for future proofing...

Ah nevermind, I see it mirrors the io_uring_cqe itself. Disregard.

-- 
Jens Axboe

