Return-Path: <netdev+bounces-134234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590D99876D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE531F21D33
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117131C57B0;
	Thu, 10 Oct 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YGAKd7/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365C1BE245
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566375; cv=none; b=tG3whyVZUDcBoe7QWRCBzhcs9LQELUoq+GMBAAvkdt5KBOIwXYk4QfK+ujUZpHdmA6zLJK6mY69eQKW0btXGClqp39bSFjfUA+EpwvZnTBztwN+vz4j5W5C8opeKZUdsw0el5iBKpjZuoQGB+v9R6fSYxEAQZ3E7JIwQsQoEme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566375; c=relaxed/simple;
	bh=cpOaercjncQOB9gV1IYhByw7G5IKZygARcivDskCyR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRT0+xwlqCzWFVqofjEIcONqNGaA2mpFXFHVQ2QlEqZlSy62WCcgI3/2x+CAyi6GoF6Janx0sMKachevgJ3kQDsyEbnp7aHdyw+fi5t36ZhoW5pCCHkDWThKK+6Yz2lN1Si5sRY8ZkHtFGQIsMhZGlyOu/l66+pUDm/ZTea/rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YGAKd7/h; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8354cecdf83so16865639f.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728566372; x=1729171172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSOi3DtOdsijIeimPagm2VwpzMqM+VhZby/6Pj6Npv0=;
        b=YGAKd7/h5XCT6IYGI1E+7L3mXjRYtv0h++Q9RVQjgi3PGgnF4nLM6HlHUd03TvNhiD
         jM8J9iGspikMQ4pFc99eVTho1wMkrALqnzMMP5srwsBi6h+uf/steGzn+SUEUszYa8I2
         wMaiobOVOP8QxZkagnEXrf0f5KNrRzixhi0MGf7wXlbXxWdjxfcpM3xNQT+uwOQ7rp9b
         aI0qvmFt7cvK/3i0r42RQhsSx871Ndh3VMotj1EnFeOYVj8/e6bG9NJVNKdSrdppIiFx
         jtLY9WSfW6MQCakSfOeWfD1xhQDoTp3JHeIYlcO4+BiXHAimqEPPYm5TgvFVIaxdgsZu
         CVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566372; x=1729171172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSOi3DtOdsijIeimPagm2VwpzMqM+VhZby/6Pj6Npv0=;
        b=QySfZUoJm1IK1stkss3Eo6jOP/p7wxBDOwO4zhLVhnvl3+TQjfxOM5A1ChvG/osmyE
         DXbptJaPRyZZVgtvKy4Fra15FVmbprWmo4vXu+C/k5Vtq3pefrycq7smUoWgNAQEj11g
         AdF9aY1g4W8k8vSSjzmbTu3UNfaL3aM1865RbFD+c8ltmOE8ylNmlTY1UoPiuTWVBQVS
         hKks3P3rbE/jQxn0fP0jEZf6skC/T0V3ity68Ndnl9bNQherTN1IgwiBZVWhOoGZF3e+
         aNwGnp/oaJegYR+PdT0PaAyESfqa+XHyAhRl4Vii960XPDIOuXchNRffha8sjdj9iwKU
         vcXA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdLD83kfQauHSfY2IXjBNvx+7n92zBCKO9GQ/tzzILgWO2QvotJFfK6M/PU17/BOzbW/YkK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEjBazStzkQCJsFJb9cI5ktyhVa9ZM9SBm/2VEH2O0YzNP9oQ
	+jAfqzPIdgNPmGpLFbZGe9x/fnWqY7ANBKsyUAfs89XHAg3iT/7sLsceTQkf0K8=
X-Google-Smtp-Source: AGHT+IEfuaThIrnTiZMf+XnJ5qGwySu3D9xl7h3sdOh4Z8U7QUEwy1QmNLOVYuh7HK0DKH/HbrPwCA==
X-Received: by 2002:a05:6602:2dcd:b0:82a:ab20:f4bf with SMTP id ca18e2360f4ac-8353d47c380mr522731139f.1.1728566371817;
        Thu, 10 Oct 2024 06:19:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9d604fsm239318173.52.2024.10.10.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:19:31 -0700 (PDT)
Message-ID: <6f8a5e79-e496-4f94-93df-84c66a10e73a@kernel.dk>
Date: Thu, 10 Oct 2024 07:19:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] io_uring/zcrx: set pp memory provider for an rx
 queue
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-15-dw@davidwei.uk>
 <53f1284c-6298-4b55-b7e8-9d480148ec5b@kernel.dk>
 <678babf5-4694-4b65-b32a-55b87017ed87@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <678babf5-4694-4b65-b32a-55b87017ed87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 7:09 AM, Pavel Begunkov wrote:
> On 10/9/24 19:42, Jens Axboe wrote:
>> On 10/7/24 4:16 PM, David Wei wrote:
>>> From: David Wei <davidhwei@meta.com>
> ...
>>>       if (copy_to_user(arg, &reg, sizeof(reg))) {
>>> +        io_close_zc_rxq(ifq);
>>>           ret = -EFAULT;
>>>           goto err;
>>>       }
>>>       if (copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
>>> +        io_close_zc_rxq(ifq);
>>>           ret = -EFAULT;
>>>           goto err;
>>>       }
>>>       ctx->ifq = ifq;
>>>       return 0;
>>
>> Not added in this patch, but since I was looking at rtnl lock coverage,
>> it's OK to potentially fault while holding this lock? I'm assuming it
>> is, as I can't imagine any faulting needing to grab it. Not even from
>> nbd ;-)
> 
> I believe it should be fine to fault, but regardless neither this
> chunk nor page pinning is under rtnl. Only netdev_rx_queue_restart()
> is under it from heavy stuff, intentionally trying to minimise the
> section as it's a global lock.

Yep you're right, it is dropped before this section anyway.

-- 
Jens Axboe

