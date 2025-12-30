Return-Path: <netdev+bounces-246290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FACE86CE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 01:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 255003010766
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FC2DC77E;
	Tue, 30 Dec 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b75GFGci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D22DC76A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055063; cv=none; b=dL2OIPYrwNCUs1bI8Ttk8ZX6ObJ6xjwuXHVooURB9ZmTfujyWlD+WQ8hF1WEN5qIvvtEiwSIAxC9EMuI0yGRiO0NeWm056+mmQQXQmao0kUMiTzCcOQKtE+4Yx7fUd2LBGaNDYWtihsox7rhaOkmowFiYsIW85vl6o6LDQ+zOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055063; c=relaxed/simple;
	bh=Eu/0MvqtXzKZbDhFka3bibWxt0bbXBOC90Q2iECgF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXOkxz2s/8QsY153mb8C2plNKT8EaTRprcYEMwx8YOj2y52GP0uvInCLj8Iuka3zjF2TCHfDQI+TC6BLQYTw2PsWj/W17HDNv8dwjRCVjenKaHhefQmaAnNcc9/2BIZfz98/GgmKMJxPFzXJRoU5nedQkOCfehFd1m3QoAkmY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b75GFGci; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c7aee74dceso3708665a34.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767055052; x=1767659852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=b75GFGciNFmZMA1pAddG/IJyk0M4t8bjXViGqRPJUtlIXNSocJ3qCuRdzql4roVBtZ
         Qrdqe8iYz7Gqxf7ywr3VQyWONwdpO/lDW9ksNyJh+w7vmT1izd2arvO0pJy3QYropwn/
         A878rasRxsLtm+n5QK7MVcxyJlV40ig9KrV5JxxKyw8D0H+0TEIhgGsjCLH95Z0hiE7N
         8RWNwEm1HWyVBonRBhvnnUCwchniJf2BQPG5K6oxn0ODRncyVibOZ2qJcE15PPfMUrMk
         gB59gvD00SHa7wjiux9LcA7lI81kBy2sSg0xT3VH7QaujB/0Qbq9W14ydND7Y6Xw/Eft
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055052; x=1767659852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=G1mICt3FyK8FH1Su9j0X2Q8ZkmLHhpBI4w8hK4GPCKULSHpI3Wj4b5rMJQsTjEfzyx
         ogNKdxTuy7q/05jupz1Z0l3ZYGw+Fx8Ni9Ja8pgMkzJnqFcBg8IIBiIHonmahV7Z9yYg
         o4st5ju/9bmlVRtAEXs+vHVx+I8sVFxT/JY/MHLy5Ke0SPwTauYwfuBhp+w5MgmdAQeJ
         jPqUYk3FLbRJjPNfWkRzlEisIOs+MnZGIiz0TPqeT3J4kIhcDrSnsRXTtffgsVV4cqoj
         wogVQkWh4ad4cVe2CE+2fZnHiY8p1GiJIaaCWrjILJujW6QDrI3nwXFNuPCGiHoHetuK
         Qjdg==
X-Forwarded-Encrypted: i=1; AJvYcCUpwbkI+syRIQ5URqv5PLcQE5wZpxp2JnISYovEZJlGripHgU7AASGsvqA8EFpsyQXPAitMosE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xU7ze3A7eRS3LwDVqtU2YneDCymIlXUmfueocpz8dgdZKqG2
	ZalbVc8Y7r/PdTQjCXwrctEeM8vlrG3MSF0Y7ctnQxrE3FtHeBmgGyWnycGJXDpyvZ8=
X-Gm-Gg: AY/fxX5o1KxnC3vnFAP2yVZzeCAkHzY+cj/DZI8XxZhH8b6ImT4AJQjkDC+6rT3NUaN
	/oPZcUg2kFY3ST/sEu2u+So4+t/h2/aU1cOhYXmt/qHGQJYVRe0Ysrbl5McQK9/VoVTt1kc8neS
	HOfpvr1yZmKgGsTazeb4Xg98hmR83EaIDSQSmOI9ql6CZvMzl8+phX6thHFi9CTFwPGHy/4/o+E
	yDu27CJ4co0xUiYiYXidXgQNOZ4W8uPGF7N8+w+c895wle+YymTIdO3uSKhDx6JNLsMFU7I4F0L
	0+TA1eAc0xv5VCjYak6imIAz8kWr7AxeH2Hs3B5WMiAVWFK5jr+S/ARmzfXsT2bSdzhJsO+FzDF
	Un7k+jnXAHsITTTmnNdwOet9nfZcJEI4NiD4K61fo3KFQWtVjfixkiW+X8dGLUn9EbM/T7EkMId
	bL68f7nlsg
X-Google-Smtp-Source: AGHT+IFl9yxlJpaq7sZYozgWoQTaTewr4cBUOiverIAjbR/CmqFwp/DL9X0O2bEGHsivPH5Emtcv9g==
X-Received: by 2002:a05:6830:2642:b0:7c7:6217:5c60 with SMTP id 46e09a7af769-7cc66a603d6mr14529090a34.25.1767055052471;
        Mon, 29 Dec 2025 16:37:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f62sm21773347a34.19.2025.12.29.16.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:37:31 -0800 (PST)
Message-ID: <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
Date: Mon, 29 Dec 2025 17:37:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224134520.33231-10-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
> The block subsystem prevents running the workqueue to isolated CPUs,
> including those defined by cpuset isolated partitions. Since
> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> modifications, synchronize against housekeeping using the relevant lock.
> 
> For full support of cpuset changes, the block subsystem may need to
> propagate changes to isolated cpumask through the workqueue in the
> future.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1978eef95dca..0037af1216f3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  
>  		/*
>  		 * Rule out isolated CPUs from hctx->cpumask to avoid
> -		 * running block kworker on isolated CPUs
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.
>  		 */
> +		rcu_read_lock();
>  		for_each_cpu(cpu, hctx->cpumask) {
>  			if (cpu_is_isolated(cpu))
>  				cpumask_clear_cpu(cpu, hctx->cpumask);
>  		}
> +		rcu_read_unlock();

Want me to just take this one separately and get it out of your hair?
Doesn't seem to have any dependencies.

-- 
Jens Axboe

