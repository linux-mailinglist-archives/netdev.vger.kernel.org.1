Return-Path: <netdev+bounces-92882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC818B9373
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C11F224F2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7017583;
	Thu,  2 May 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BYJhR07v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988828FA
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714617880; cv=none; b=TerQhhM61SBaTuoT/ivw8vac1w9rrGzay93givKlOANDj2kcscjokr3rnfHFdkZEM9QMZ2gmNhpj3LHlGGLNixoPvq+Bp5WYuz2qOrlsGUSY5Zs/fWuRocoQF1R9FLKNTWR5QLqe80HyxxNvjEFA0hrVJ08rIoAT/z6bYpQqgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714617880; c=relaxed/simple;
	bh=ZlqLFXmRKFw0qrLqP0rnqkWfksHNQiGL74jNA/wxdMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ml1rV1tVoyI1zlRA0/IO8/3KSAOFAy1C2v568bOcWeQKkNDYSCW7jm9IhCqLgn7WK2zDaVW0FgXa1rva+qMtVjRLexOmkWXWrNal5QZbhN2IiUJVukO9KTq4d4lSO92JNPXEEH1KHebAinR8awo9+NctBdgT6qbmOWUIC0CPMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BYJhR07v; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c86560e96eso2154396b6e.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714617878; x=1715222678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv4rDt2hIySWK7sF0TMwLkZwC/cN4InENZLiWYre4b8=;
        b=BYJhR07vOWnHYMtrblEVLYfSqimjiNf4SlomXAVNSNjaXdPK2VPjJ2G1zGTZp3M8ef
         KNYQ7TuTOKqMqeCuXIrONwxrattqo4wX7Yb/PwvolHVEnL1tRscZmPdmrzJuFL0/PkcG
         bg5JywKLp1IE/rE7/kGdlp1JXUSUrXT9gmiiBlHVIG1U2LMr0TFwLYg4f93hiWl/xPFP
         k6rNrgXyoR+e39gh8FdpRaI0rMk3+PIzwCiRu0cHEyb83fhPLyMqcS1mlsQIIeNeD9Jq
         Jtr4vnwldldFS08diioLzdLM81gvXg9cCLGVCthrqNN5YV7faheQph4TlmU0FuZvO7HB
         icLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714617878; x=1715222678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv4rDt2hIySWK7sF0TMwLkZwC/cN4InENZLiWYre4b8=;
        b=qdBxpS4WRf32RxszFtpsBQftEIgdgKAsImKxHv5FFe7ZVKNpnXzERhF5MCAY1N49dU
         Mon8Y4Gpq2uWP+10VI2+EmybS5nNkNx3cplYagzKa2hv2xS4QBEuX+waGCUe2D3KnnUw
         IGHH839Z2HKLqs/PBYe+sCYq8zpY1NVnkH+Ry/sgDRNMZmDmEYz8HPtRSSbH0F2FnAUS
         /NyREuCJy8aZnfzuAeW0odo9k02nu7F4M2DRgIUfnIhlogtN+jc1ashkP0ve3w09D7qm
         s2bpubs0lp6mAcD47YK84OuJMaPBsBVEa5MrUrP3Hy/niy9FUbC7WHOq6yDunZtA68Dx
         2BQA==
X-Gm-Message-State: AOJu0YzhYlqV9JhAOchHJqMC+KDPns8KjusxYUgoDm5JlKJSkKn4mvI+
	0UEFxyCvE8qvf9s3IOlYtg6Dy8RkG2fqD2kiwEpgdVvsqJTiNYXgr8cHDT9omDY=
X-Google-Smtp-Source: AGHT+IE2L/AVY7V9XKLw71PtJD0VRosXARfmxnk3OycpOcrw6R/ncBUfonlQeJTFQybIIBNeE4Qovg==
X-Received: by 2002:aca:1e07:0:b0:3c8:664a:f839 with SMTP id m7-20020aca1e07000000b003c8664af839mr4258456oic.51.1714617877931;
        Wed, 01 May 2024 19:44:37 -0700 (PDT)
Received: from [192.168.1.4] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id k3-20020a6568c3000000b005f75f325db4sm61988pgt.29.2024.05.01.19.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 19:44:37 -0700 (PDT)
Message-ID: <15333409-0cad-4580-b093-aeae58664034@davidwei.uk>
Date: Wed, 1 May 2024 19:44:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v1 1/3] queue_api: define queue api
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Shailend Chand <shailend@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240430010732.666512-1-dw@davidwei.uk>
 <20240430010732.666512-2-dw@davidwei.uk>
 <CAHS8izOsZ+nWBRNGgWvT46GsX6BC+bWPkpQgRCb8WY-Bi26SZA@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izOsZ+nWBRNGgWvT46GsX6BC+bWPkpQgRCb8WY-Bi26SZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-30 11:00 am, Mina Almasry wrote:
> On Mon, Apr 29, 2024 at 6:07 PM David Wei <dw@davidwei.uk> wrote:
>>
>> From: Mina Almasry <almasrymina@google.com>
>>
>> This API enables the net stack to reset the queues used for devmem TCP.
>>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  include/linux/netdevice.h   |  3 +++
>>  include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index f849e7d110ed..6a58ec73c5e8 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1957,6 +1957,7 @@ enum netdev_reg_state {
>>   *     @sysfs_rx_queue_group:  Space for optional per-rx queue attributes
>>   *     @rtnl_link_ops: Rtnl_link_ops
>>   *     @stat_ops:      Optional ops for queue-aware statistics
>> + *     @queue_mgmt_ops:        Optional ops for queue management
>>   *
>>   *     @gso_max_size:  Maximum size of generic segmentation offload
>>   *     @tso_max_size:  Device (as in HW) limit on the max TSO request size
>> @@ -2340,6 +2341,8 @@ struct net_device {
>>
>>         const struct netdev_stat_ops *stat_ops;
>>
>> +       const struct netdev_queue_mgmt_ops *queue_mgmt_ops;
>> +
>>         /* for setting kernel sock attribute on TCP connection setup */
>>  #define GSO_MAX_SEGS           65535u
>>  #define GSO_LEGACY_MAX_SIZE    65536u
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index 1ec408585373..337df0860ae6 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h
>> @@ -60,6 +60,33 @@ struct netdev_stat_ops {
>>                                struct netdev_queue_stats_tx *tx);
>>  };
>>
>> +/**
>> + * struct netdev_queue_mgmt_ops - netdev ops for queue management
>> + *
>> + * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory returned
>> + *                      in the form of a void* can be passed to
>> + *                      ndo_queue_mem_free() for freeing or to ndo_queue_start
>> + *                      to create an RX queue with this memory.
>> + *
>> + * @ndo_queue_mem_free:        Free memory from an RX queue.
>> + *
>> + * @ndo_queue_start:   Start an RX queue at the specified index.
>> + *
>> + * @ndo_queue_stop:    Stop the RX queue at the specified index.
>> + */
>> +struct netdev_queue_mgmt_ops {
>> +       void *                  (*ndo_queue_mem_alloc)(struct net_device *dev,
>> +                                                      int idx);
>> +       void                    (*ndo_queue_mem_free)(struct net_device *dev,
>> +                                                     void *queue_mem);
>> +       int                     (*ndo_queue_start)(struct net_device *dev,
>> +                                                  int idx,
>> +                                                  void *queue_mem);
>> +       int                     (*ndo_queue_stop)(struct net_device *dev,
>> +                                                 int idx,
>> +                                                 void **out_queue_mem);
>> +};
> 
> Sorry, I think we raced a bit, we updated our interface definition
> based on your/Jakub's feedback to expose the size of the struct for
> core to allocate, so it looks like this for us now:
> 
> +struct netdev_queue_mgmt_ops {
> +       size_t                  ndo_queue_mem_size;
> +       int                     (*ndo_queue_mem_alloc)(struct net_device *dev,
> +                                                      void *per_queue_mem,
> +                                                      int idx);
> +       void                    (*ndo_queue_mem_free)(struct net_device *dev,
> +                                                     void *per_queue_mem);
> +       int                     (*ndo_queue_start)(struct net_device *dev,
> +                                                  void *per_queue_mem,
> +                                                  int idx);
> +       int                     (*ndo_queue_stop)(struct net_device *dev,
> +                                                 void *per_queue_mem,
> +                                                 int idx);
> +};
> +
> 
> The idea is that ndo_queue_mem_size is the size of the memory
> per_queue_mem points to.
> 
> The rest of the functions are slightly modified to allow core to
> allocate the memory and pass in the pointer for the driver to fill
> in/us. I think Shailend is close to posting the patches, let us know
> if you see any issues.
> 

Hmm. Thinking about this a bit more, are you having netdev core manage
all of the queues, i.e. alloc/free during open()/stop()? Otherwise how
can netdev core pass in the old queue mem into ndo_queue_stop(), and
where is the queue mem stored?

Or is it the new queue mem being passed into ndo_queue_stop()?

My takeaway from the discussion on Shailend's last RFC is that for the
first iteration we'll keep what we had before and have the driver
alloc/free the qmem. Implementing this for bnxt felt pretty good as
well.

