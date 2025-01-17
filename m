Return-Path: <netdev+bounces-159326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D5A151CD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28713188499F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C686337;
	Fri, 17 Jan 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHUI1ANd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCC78F5B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124106; cv=none; b=PjaxSAITB6rGrL2uaD6Iq4gDRp0UcUV31L5z4Sz9rNaLpKfF7+YERJSiry3ZBiQKeeE+/kPjbJVpq9U4oKPAldpax6aOBeWH92RdnzAwKDXek1Se9/53cDqeuvalBr6he/lNODl6HqaXAk59QGvucP6tIPUXP8YuN8PfJaMfiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124106; c=relaxed/simple;
	bh=mDdv8bie31on18kTBHvxq3RFrERNo/c/QthRYx79W8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0R5V6DDSaLqwUverWda/P4UZhzZD69mGkZ4sN8NU/GwJ5PHYhgoK2YtHoQkH55xaxdq1GEWUA1t5KuuYzrwT6p4NDAK7IQasCW4jUvTdJXuf4zIRW1ZoaOZJWbGpfgiZhLqFwJUUquuB1NGHtAiqVSok5mmivLM6whq/bHWpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHUI1ANd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737124103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oi08zdO3Y89Or/bOx5y047G2RaQw5VgeU693ZnudoM=;
	b=KHUI1ANdNsqzgRK8UxRy5TxCvTbnWcb8YFBXmskp4Jx9Q+lHKI9SmPxKOcjTCrL16qfBJb
	yFZ8cjGor/+mI/TnlluO0pGUZPM1Pk1pwT10dADPU1Zp9iSuiSAn4e++k3diLuyBRikudq
	gryf7ndwlXoYBnMSwJmitI8ymx+/g2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-_Oy_IwFFN_KHutCnH90TfQ-1; Fri, 17 Jan 2025 09:28:22 -0500
X-MC-Unique: _Oy_IwFFN_KHutCnH90TfQ-1
X-Mimecast-MFC-AGG-ID: _Oy_IwFFN_KHutCnH90TfQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so11021445e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124100; x=1737728900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oi08zdO3Y89Or/bOx5y047G2RaQw5VgeU693ZnudoM=;
        b=NZjQjldhFuBDKg7MtYHhLBojvyTxZSxLadDtoU6vm6kVgQSUDGHQsCJU2Z9Qo39Gdw
         aGTyQA8xJ5+bvjmjMsjMWl7zsbCGgeaAJ8t/+N9y54pw9lRaCsa0Bo6zlspwqKgMkj1H
         /+VH9mtalQhWl/TOya8A+Vxo7zbAEc+XXtcS3f0dYoVrl2Xsd+VJ0Mz5PtX+adhHGS7Z
         8WjsmB+o3jXv4xU4tDGqfT+z08txHaGoQzQJtjelfQfdRXijtk19p1M6K8ZU+qwpSjLo
         V0y2Mv3t2rUF2y97WIJgzbtRX0YvNidah8IUu4Ye4hSwtvbPAypKYfVVrQQn39vQ711x
         deQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjUDyoq6dVgh0l8Ecz5HaDZu9BwHp1JybuJ4Se2PQONsPbwOHNA32v2M4bD4aXYZbcMsEOMqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJJ0kB+2HMO99LB4wbpWU/07WNnbTfoR6ywSqAn4Cub4/kNeU
	zy/hyMBpXsZd2RCcAWt1iC/jNk9I5E4Vs/dAoONilGoijXkIoShaPLEy7ikxtVHWYnutY2dx/pb
	o8oPh2nInZ5SnEtUbACm3YuZBkEvZammHyWfIqwnkWNkEP5haaYnJ9A==
X-Gm-Gg: ASbGncu38+zTneBxyCw+ps4Y1IUqOi7cx4EEJlIYmUWjtwjEMWJk194sfzF3hNn4ZyZ
	4pZ89fbLM+kWzgUk7busk2UZKISmv2EtHCNW00nt2nJqqEFkmDxZAqtBp8/bwmqUkwaHEwLfFsY
	BwSR4IitwsD0/sNeu28kdDDlpsofUYOFQ7sa98+oNRbhZ32N35VmImKpt2Vxa2IYwgBlKrFH5JW
	AZzNNareHtoDYk1hx9hLfclq4zCdsPknJdS3FGFlCZljfM+S5Q0oaT8JVWs+nB3BG3ou6B9nNWw
	Oj2TOWn4DBU=
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-438913cfa0emr30436275e9.8.1737124099127;
        Fri, 17 Jan 2025 06:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFguh3eO0ebu9zvt9jzGDEhcT4DR9FA36zwFEJJvb9LxoI84XCY17GLvDMG2Y5+ZSZ0+MvdsQ==
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-438913cfa0emr30435045e9.8.1737124097250;
        Fri, 17 Jan 2025 06:28:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4388ebdefe0sm50904125e9.15.2025.01.17.06.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 06:28:16 -0800 (PST)
Message-ID: <406fcbd2-55af-4919-abee-7cd80fb449d3@redhat.com>
Date: Fri, 17 Jan 2025 15:28:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/21] io_uring zero copy rx
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250116231704.2402455-1-dw@davidwei.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250116231704.2402455-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 12:16 AM, David Wei wrote:
> This patchset adds support for zero copy rx into userspace pages using
> io_uring, eliminating a kernel to user copy.
> 
> We configure a page pool that a driver uses to fill a hw rx queue to
> hand out user pages instead of kernel pages. Any data that ends up
> hitting this hw rx queue will thus be dma'd into userspace memory
> directly, without needing to be bounced through kernel memory. 'Reading'
> data out of a socket instead becomes a _notification_ mechanism, where
> the kernel tells userspace where the data is. The overall approach is
> similar to the devmem TCP proposal.
> 
> This relies on hw header/data split, flow steering and RSS to ensure
> packet headers remain in kernel memory and only desired flows hit a hw
> rx queue configured for zero copy. Configuring this is outside of the
> scope of this patchset.
> 
> We share netdev core infra with devmem TCP. The main difference is that
> io_uring is used for the uAPI and the lifetime of all objects are bound
> to an io_uring instance. Data is 'read' using a new io_uring request
> type. When done, data is returned via a new shared refill queue. A zero
> copy page pool refills a hw rx queue from this refill queue directly. Of
> course, the lifetime of these data buffers are managed by io_uring
> rather than the networking stack, with different refcounting rules.
> 
> This patchset is the first step adding basic zero copy support. We will
> extend this iteratively with new features e.g. dynamically allocated
> zero copy areas, THP support, dmabuf support, improved copy fallback,
> general optimisations and more.
> 
> In terms of netdev support, we're first targeting Broadcom bnxt. Patches
> aren't included since Taehee Yoo has already sent a more comprehensive
> patchset adding support in [1]. Google gve should already support this,
> and Mellanox mlx5 support is WIP pending driver changes.
> 
> ===========
> Performance
> ===========
> 
> Note: Comparison with epoll + TCP_ZEROCOPY_RECEIVE isn't done yet.
> 
> Test setup:
> * AMD EPYC 9454
> * Broadcom BCM957508 200G
> * Kernel v6.11 base [2]
> * liburing fork [3]
> * kperf fork [4]
> * 4K MTU
> * Single TCP flow
> 
> With application thread + net rx softirq pinned to _different_ cores:
> 
> +-------------------------------+
> | epoll     | io_uring          |
> |-----------|-------------------|
> | 82.2 Gbps | 116.2 Gbps (+41%) |
> +-------------------------------+
> 
> Pinned to _same_ core:
> 
> +-------------------------------+
> | epoll     | io_uring          |
> |-----------|-------------------|
> | 62.6 Gbps | 80.9 Gbps (+29%)  |
> +-------------------------------+
> 
> =====
> Links
> =====
> 
> Broadcom bnxt support:
> [1]: https://lore.kernel.org/netdev/20241003160620.1521626-8-ap420073@gmail.com/
> 
> Linux kernel branch:
> [2]: https://github.com/spikeh/linux.git zcrx/v9
> 
> liburing for testing:
> [3]: https://github.com/isilence/liburing.git zcrx/next
> 
> kperf for testing:
> [4]: https://git.kernel.dk/kperf.git

We are getting very close to the merge window. In order to get this
series merged before such deadline the point raised by Jakub on this
version must me resolved, the next iteration should land to the ML
before the end of the current working day and the series must apply
cleanly to net-next, so that it can be processed by our CI.

Thanks,

Paolo


