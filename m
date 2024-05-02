Return-Path: <netdev+bounces-92867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD188B9302
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 03:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F01F223C6
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9D10A19;
	Thu,  2 May 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Gh9RdDpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BC29A0
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611865; cv=none; b=SJ8FoUBCVD65geYLYcxudVYiuUn8XovRcwxQg+yjq0uqp03sN1Eijc8LuvVvdrxcODGEShatXvtf8uqDrvVBQTOQmdg+zsw1zQ/Ft8OzrKE3dRIfouryjV4BPWdgGgI9jrDngAHWjpyVzQ23ma2Jlo1rNKI2Nk0ETEsnW58UGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611865; c=relaxed/simple;
	bh=NbjgfLoYkk8RuyMZtJqYRq87qDam9hykwLcH780MlHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ashSC6oRvZmEczmPJ9HevmNPjQ0xGAJNRDjCY7VoRNRkUt//w51/q/8SmAUbq56jEiu6dp7B4kw8SQhEMnR8PvMzLU7CBLtXUCkVbxeFRIRbCj9YZ3+A68A2TBpKK+cXU9acGKCX++Fq9J7y0TzcQyX5q+DbLx3PgGV2fLqKYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Gh9RdDpL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb66b6953cso41017465ad.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 18:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714611863; x=1715216663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z28IInCM5UtOlJTtExeF9xgcpy7CTuS3M0sUxTvjLVs=;
        b=Gh9RdDpLvYG30lbqH30S6V+1JLlWmV9mKA1D3FomkHXabjvsw1irnPfTM8SDHhREYM
         JmuBFAi9BcvpeVPpRLwM2ga9Jzshrituq5wlcrxXDq6J/koMU8k4ag13iyO9Q0Qoj7in
         IOkWkiyZbfXP0Ulx5aJvYBzCphg5D1mC1N7fr24EMpWz7FXvVXYXb9M00bmRmapDHtHv
         NgTRu1OXIpqUVD1J2bxTgoIMYPX22DPv0XhjKHuClmaZ5mOqMkJLpTUpKuCSUxrH9/qh
         G+7pJILc48NjOVOGhF54KcLJhi3425slOE3hiunkR/lv5J5Bm1Aa3vZzIDbCN4X/xPLG
         KIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611863; x=1715216663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z28IInCM5UtOlJTtExeF9xgcpy7CTuS3M0sUxTvjLVs=;
        b=fXPFNNd8TMJJjGeoGLpDEiY4CHU74mCZkWlOVu8cKa85RA2uGxYN71U7Lw2FSa2H1I
         hIjwrQZZLFX+TCwR42H3Wh6rhuYA/kaZIcQihDGJRwRBZkbXhJLgZ70Q5kgBwQ74whxg
         zDH/AD7JluhJOMR1fFtimtQ+7LsQsPInukJBU6c7WTV9C+IHURlo0SvfyP5aGm3zJ4vm
         mTLBGhvrtt4MHCjasIGJl+RMJpAXxnqIt+++iN9uuQi1w3AU5c5dbLT4pzMKa3b/CjeC
         LVCjGnTGeDnM5xqmu6E+KYwI+WA06vkUxwKkb+qxWJFwCVF4732N4Pn39cZuht/btYBA
         Ip1g==
X-Gm-Message-State: AOJu0YyFnvLmqcup3zd/zyp4jC+nf+a/W5O6KVb0xApIxvFbeMyQ2ksV
	XcFxzgMkzZnacJ0GSZMEirh02pIrRYkb5PyVexD/1iSHPNEJCx9Rw3HmnLUdOcU=
X-Google-Smtp-Source: AGHT+IHYcOJwuR7EjYPAvwrvXHA2bsbGPNxxzaE4WP078UtFkdmtygoya/oH2cdMphnlM60WGyiPtw==
X-Received: by 2002:a17:902:ea10:b0:1e4:24cc:e020 with SMTP id s16-20020a170902ea1000b001e424cce020mr4731457plg.67.1714611862874;
        Wed, 01 May 2024 18:04:22 -0700 (PDT)
Received: from [192.168.1.4] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001eb2e6b14e0sm9665110plh.126.2024.05.01.18.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 18:04:22 -0700 (PDT)
Message-ID: <5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
Date: Wed, 1 May 2024 18:04:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add netdev_rx_queue_restart()
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Shailend Chand <shailend@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240430010732.666512-1-dw@davidwei.uk>
 <20240430010732.666512-4-dw@davidwei.uk>
 <CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-30 11:15 am, Mina Almasry wrote:
> On Mon, Apr 29, 2024 at 6:07 PM David Wei <dw@davidwei.uk> wrote:
>>
>> From: Mina Almasry <almasrymina@google.com>
>>
>> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
>> taken from Mina's work in [1] with a slight modification of taking
>> rtnl_lock() during the queue stop and start ops.
>>
>> For bnxt specifically, if the firmware doesn't support
>> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
>> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
>> attempt to reset the whole device.
>>
>> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasrymina@google.com/#t
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  include/net/netdev_rx_queue.h |  3 ++
>>  net/core/Makefile             |  1 +
>>  net/core/netdev_rx_queue.c    | 58 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 62 insertions(+)
>>  create mode 100644 net/core/netdev_rx_queue.c
>>
>> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
>> index aa1716fb0e53..e78ca52d67fb 100644
>> --- a/include/net/netdev_rx_queue.h
>> +++ b/include/net/netdev_rx_queue.h
>> @@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>>         return index;
>>  }
>>  #endif
>> +
>> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
>> +
>>  #endif
>> diff --git a/net/core/Makefile b/net/core/Makefile
>> index 21d6fbc7e884..f2aa63c167a3 100644
>> --- a/net/core/Makefile
>> +++ b/net/core/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>>
>>  obj-y += net-sysfs.o
>>  obj-y += hotdata.o
>> +obj-y += netdev_rx_queue.o
>>  obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
>>  obj-$(CONFIG_PROC_FS) += net-procfs.o
>>  obj-$(CONFIG_NET_PKTGEN) += pktgen.o
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> new file mode 100644
>> index 000000000000..9633fb36f6d1
>> --- /dev/null
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <linux/netdevice.h>
>> +#include <net/netdev_queues.h>
>> +#include <net/netdev_rx_queue.h>
>> +
>> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq)
>> +{
>> +       void *new_mem;
>> +       void *old_mem;
>> +       int err;
>> +
>> +       if (!dev->queue_mgmt_ops->ndo_queue_stop ||
>> +           !dev->queue_mgmt_ops->ndo_queue_mem_free ||
>> +           !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
>> +           !dev->queue_mgmt_ops->ndo_queue_start)
>> +               return -EOPNOTSUPP;
>> +
>> +       new_mem = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, rxq);
>> +       if (!new_mem)
>> +               return -ENOMEM;
>> +
>> +       rtnl_lock();
> 
> FWIW in my case this function is called from a netlink API which
> already has rtnl_lock, so maybe a check of rtnl_is_locked is good here
> rather than a relock.
> 
>> +       err = dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq, &old_mem);
>> +       if (err)
>> +               goto err_free_new_mem;
>> +
>> +       err = dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, new_mem);
>> +       if (err)
>> +               goto err_start_queue;
>> +       rtnl_unlock();
>> +
>> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
>> +
>> +       return 0;
>> +
>> +err_start_queue:
>> +       /* Restarting the queue with old_mem should be successful as we haven't
>> +        * changed any of the queue configuration, and there is not much we can
>> +        * do to recover from a failure here.
>> +        *
>> +        * WARN if the we fail to recover the old rx queue, and at least free
>> +        * old_mem so we don't also leak that.
>> +        */
>> +       if (dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, old_mem)) {
>> +               WARN(1,
>> +                    "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
>> +                    rxq);
>> +               dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem);
>> +       }
>> +
>> +err_free_new_mem:
>> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
>> +       rtnl_unlock();
>> +
>> +       return err;
>> +}
>> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);
> 
> Does stuff outside of core need this? I don't think so, right? I think
> you can drop EXPORT_SYMBOL_GPL.

Not sure, we intend to call this from within io_uring. Does that require
exporting or not?

Later on I'll want to add something like
netdev_rx_queue_set_memory_provider() which then calls
netdev_rx_queue_restart(). When that happens I can remove the
EXPORT_SYMBOL_GPL.

> 
> At that point the compiler may complain about an unused function, I
> think, so maybe  __attribute__((unused)) would help there.
> 
> I also think it's fine for this patch series to only add the ndos and
> to leave it to the devmem series to introduce this function, but I'm
> fine either way.
> 

I'd like to agree on the netdev public API and merge alongside the queue
api changes, separate to TCP devmem. Then that's one fewer deps between
our main patchsets.

