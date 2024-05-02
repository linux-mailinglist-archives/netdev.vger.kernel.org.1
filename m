Return-Path: <netdev+bounces-92866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD68B92FF
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 03:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF05B20AAB
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D294101D5;
	Thu,  2 May 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BWBxn2b8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C3611E
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611622; cv=none; b=EZL3S+yKBle76upJqshTFH7ifaRH69O0JSczg9y3XG5x+3WCXg8VwpH3WO0UeMaMFPJeLPU8r+P6+3C3+0AiH6yMT7Lrs+ELE5jsTTErA1bQLV7OFS+x4UNCWNrQJQuoj5fklKa/4/9hBVjW+4U81sf8nzj3LirlYdhzqzPfcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611622; c=relaxed/simple;
	bh=jKawsEeVw7whucsie2c9Hc41uL1z+KkFo+ymR1TPv5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP6TeK4TdAsDuPxkPSonWI4kSNR7T7mKA3mFNTYahLxlArJQqzn8u3SwqH9YtL6oz+SofM6hfXSIU+BcDcGd8aWa5V6GDkzBs5wo0u2B+AR6tXmiNwd5K6V1qScwETOZvyehCLiMojYWUwqHU17P6ZlZTpyhlzSpbH95G9WfqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BWBxn2b8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso48696425ad.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714611620; x=1715216420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjNPBSw6n2u5d05726enHTt7JomDvuTD2xvd2dYi3gw=;
        b=BWBxn2b8P4A2fSTV/EWcpH/z7drufbDsmUZX7xH7L2+0eQFpXT/374FQ78Kh3uSkMa
         wB7v4tj9jA00AI3BIUFkAe4JC7SXvjXZ8P6Mdn6Uvi4dvqweA/KfZZFew7ex4EMNeuDI
         EWMyhb8TRkaboSjW+OxHpIcXBmNBdaubNdKWEaSdJZ4+H8eopFaQpPeuJA6C/vHHTQPo
         WGgxEvB46FqbUmjC2zK+2AV6LJimpaxQAerZlEBicjNz6umGsR8ex/rgGCSoHb9QG/Y+
         spPO0SjDPLex0g3nu2js8CfMWAn5qjuWNLYKBSylR5+100SDKss9TkBei0jbnJHzS75a
         EMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611620; x=1715216420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjNPBSw6n2u5d05726enHTt7JomDvuTD2xvd2dYi3gw=;
        b=v4HV0vXxDDGthX4eMcusYESH1UKG+BxcwZtcPaPt7kIT8eGqEKvB/b5qlScaiQbQS1
         SwQgsKte40gXHEAZ2B+sVRnAvJeEsZ0FyCkMW7BYn6g7tSu160GY+wSKPoz5SeQDkEe5
         ngza6DVJ6924Meqoo9JT5FVmGhKl53V9mrhfx5P8/oIujc5pCqiGQ7oPC1ACLM1ISRtM
         yOiDXjGWyzItF1AJsZjwavx24sAAMH1JbB/oVxbjCUctxcaFM8Jwof+8nNHoeI2VqXxN
         n+XuC/TMXfUJ5RbGPY2jqGFjtSohSp7/3kU0nB2ooEiwGjyCufYgebc0C7ssPXSwHO/i
         7ozA==
X-Gm-Message-State: AOJu0Yz//7RuAGhdndp1L8/5mloH70IW3I8uSTdY5sBPfs6wMRvnz0DM
	pMIwdFT+Mh4WSgixO5ktz7IJjQyUkwAFpets2rB3YqmnBX9mMJ6toel1ergMef4=
X-Google-Smtp-Source: AGHT+IEhyUHWo2ctAs6y2hCgX5gMhE6/8pTkfJUDk1SEPtJ/JbHoRkk8J9F29muxf0mcrvIaUSft2g==
X-Received: by 2002:a17:902:fc46:b0:1e9:2d03:7c5d with SMTP id me6-20020a170902fc4600b001e92d037c5dmr549507plb.47.1714611618230;
        Wed, 01 May 2024 18:00:18 -0700 (PDT)
Received: from [192.168.1.4] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001eab3ba79f2sm12414616plh.35.2024.05.01.18.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 18:00:17 -0700 (PDT)
Message-ID: <80adf4dc-6bfd-4bef-a11b-c2f9ef362a2d@davidwei.uk>
Date: Wed, 1 May 2024 18:00:16 -0700
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

Thanks, I'll update this.

No race, I'm just working on the bnxt side at the same time because I
need feedback from Broadcom. Hope you don't mind whichever one merges
first. Full credit is given to you on the queue API + netdev queue reset
function.

> 
> The rest of the functions are slightly modified to allow core to
> allocate the memory and pass in the pointer for the driver to fill
> in/us. I think Shailend is close to posting the patches, let us know
> if you see any issues.
> 

Great, I'll take a look when it is posted.

