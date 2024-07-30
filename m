Return-Path: <netdev+bounces-114158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D399941352
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387A2282F16
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EBA1A00F2;
	Tue, 30 Jul 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITq1qJxH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857E19FA77
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346803; cv=none; b=DkCHTuGBhvjYHJ2B/x0s9vVpzGN2q/eYttRahitcIrbAwV21OARH+l0p0DNAWJQllx7kJhKhh6e8GU6uDL+W5s2PvYcdueOhe4N1p66aeiCOvQc1fa98eTtDCqe/k3IaQTsn/jnNQUrCqQAalVSdp9S+K9rawH6NpG2g8HHuwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346803; c=relaxed/simple;
	bh=76yRVcHwQwu0/DBViTueobsPeUpQ9Hkjd8aQTMIBkcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhGmajEpVS63buEaqvOGplcJnsU6WvV5b3E5W+5OEPpTDkx5p5xqkQ1btnTE7cUteeRj9YV7p3gdcqUqMu4/9KJgz0vj9cXhnxqfiHv1bJe0+nYzSMQ4dlRCkpMuOQARCghBjpfFSLie8kh3WEATqxE7QQEONkv3e7aMwBCqyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITq1qJxH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722346800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKqSr+jUwAoXeD5FqzbfCzVxti+uBAC+569cfxSSI50=;
	b=ITq1qJxH9oq+LQv/beDyBjDN4Wus4PIKNjmdq7MMa4tX5JEU/0jPdj92mD1UpxGeTq8yTn
	iv7MuH5yEV4M1T0lKHoyRZ2WgbsY2/vx2p2b2FmigI7Mwl4opqRBM8E1UtIXuNm/nW86rQ
	FPW4aS3au6Y0e2EPJNL0akjcFKXZsw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1x_CJ_WLP1ihVTYJVNQC2w-1; Tue, 30 Jul 2024 09:39:58 -0400
X-MC-Unique: 1x_CJ_WLP1ihVTYJVNQC2w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so5133115e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346796; x=1722951596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKqSr+jUwAoXeD5FqzbfCzVxti+uBAC+569cfxSSI50=;
        b=XfUloD3dD0sMwlJxaXs8xHSnllatLsp2VNj3f7gFrCHV9LFla8cNYBl6KuXnOsVqk8
         qjSQFlAOxh27Xv1QoA06H9ragVWiDU2kbCZko9JLklsz4mAib2x078gJK3zWQ+bzTp8Z
         ZEdIbBWsutigMrhHgcEkJn48Gl/PRSYp9jO70vGFsacKIedsZ6MuCGhl3QTIsq/MPCo5
         RrRo0GmjNvCkx3ouzfjht2bTq9XBiqMCRfZKHVxOe7yuVIjRbMXjGReUZBufg7ymsdcl
         omR++OluxVmrdDYUyFzdPjl6G7Ka4hIMPUzCf+kIrkzMjtTp2iiXU9HXRMpY6+SComv0
         65zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3W0vfpzI4eEiQu3Nmj3nKSs02r6l6WnAjs8KArU/BrSDO/R0UY1TMtO/r84Xjj20sfDJe/LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygDwrfVw3J564mvwiiH8vHL21CITRFszBNUHPEnZxMTYvc0ZQ
	lIRMspxQVlpXbpzU2lGoCUqS5Hq6W0LiUdOeTTSo/I2M2QGTVd/kFwpHk3B4U7/mCW4lNSseM9m
	mJFGthv5siIN1KSGycnJniDxaLyAltCB+hkQlNfFVNrgpFEItrjoGGEgaDojH6Ku7
X-Received: by 2002:a5d:59ad:0:b0:36b:3394:f06f with SMTP id ffacd0b85a97d-36b34e4dbf4mr7672769f8f.5.1722346796373;
        Tue, 30 Jul 2024 06:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8rDMHil8V46t9IR+ddqO1I+oX2K4WDD293Q+ULHFKoURLig38KLBhX0vx83BQzrPrewJx8A==
X-Received: by 2002:a5d:59ad:0:b0:36b:3394:f06f with SMTP id ffacd0b85a97d-36b34e4dbf4mr7672759f8f.5.1722346795879;
        Tue, 30 Jul 2024 06:39:55 -0700 (PDT)
Received: from [192.168.1.24] ([209.198.137.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280f9e3721sm148951445e9.29.2024.07.30.06.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 06:39:55 -0700 (PDT)
Message-ID: <7195630a-1021-4e1e-b48b-a07945477863@redhat.com>
Date: Tue, 30 Jul 2024 15:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
To: Jiri Pirko <jiri@resnulli.us>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "madhu.chittim@intel.com" <madhu.chittim@intel.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "sgoutham@marvell.com" <sgoutham@marvell.com>,
 "kuba@kernel.org" <kuba@kernel.org>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
 <ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>
 <ZqjYKXLmeriWbYyC@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZqjYKXLmeriWbYyC@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 14:10, Jiri Pirko wrote:
> Wed, Jun 05, 2024 at 05:52:32PM CEST, pabeni@redhat.com wrote:
>> On Wed, 2024-06-05 at 15:04 +0000, Cosmin Ratiu wrote:
>>> On Wed, 2024-05-08 at 22:20 +0200, Paolo Abeni wrote:
>>>
>>>> +/**
>>>> + * struct net_shaper_info - represents a shaping node on the NIC H/W
>>>> + * @metric: Specify if the bw limits refers to PPS or BPS
>>>> + * @bw_min: Minimum guaranteed rate for this shaper
>>>> + * @bw_max: Maximum peak bw allowed for this shaper
>>>> + * @burst: Maximum burst for the peek rate of this shaper
>>>> + * @priority: Scheduling priority for this shaper
>>>> + * @weight: Scheduling weight for this shaper
>>>> + */
>>>> +struct net_shaper_info {
>>>> +	enum net_shaper_metric metric;
>>>> +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
>>>> +	u64 bw_max;	/* maximum allowed bandwidth */
>>>> +	u32 burst;	/* maximum burst in bytes for bw_max */
>>>
>>> 'burst' really should be u64 if it can deal with bytes. In a 400Gbps
>>> link, u32 really is peanuts.
>>>
>>>> +/**
>>>> + * enum net_shaper_scope - the different scopes where a shaper could be attached
>>>> + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
>>>> + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
>>>> + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtual
>>>> + * function.
>>>> + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues under the
>>>> + * same device.
>>>> + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given device queue.
>>>> + *
>>>> + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
>>>> + * PF devices, usually inside the host/hypervisor.
>>>> + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
>>>> + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
>>>> + */
>>>> +enum net_shaper_scope {
>>>> +	NET_SHAPER_SCOPE_PORT,
>>>> +	NET_SHAPER_SCOPE_NETDEV,
>>>> +	NET_SHAPER_SCOPE_VF,
>>>> +	NET_SHAPER_SCOPE_QUEUE_GROUP,
>>>> +	NET_SHAPER_SCOPE_QUEUE,
>>>> +};
>>>
>>> How would modelling groups of VFs (as implemented in [1]) look like
>>> with this proposal?
>>> I could imagine a NET_SHAPER_SCOPE_VF_GROUP scope, with a shared shaper
>>> across multiple VFs.
>>
>> Following-up yday reviewer mtg - which was spent mainly on this topic -
>> - the current direction is to replace NET_SHAPER_SCOPE_QUEUE_GROUP with
>> a more generic 'scope', grouping of either queues, VF/netdev or even
>> other groups (allowing nesting).
>>
>>> How would managing membership of VFs in a group
>>> look like? Will the devlink API continue to be used for that? Or will
>>> something else be introduced?
>>
>> The idea is to introduce a new generic netlink interface, yaml-based,
>> to expose these features to user-space.
>>
>>> Looking a bit into the future now...
>>> I am nowadays thinking about extending the mlx5 VF group rate limit
>>> feature to support VFs from multiple PFs from the same NIC (the
>>> hardware can be configured to use a shared shaper across multiple
>>> ports), how could that feature be represented in this API, given that
>>> ops relate to a netdevice? Which netdevice should be used for this
>>> scenario?
>>
>> I must admit we[1] haven't thought yet about the scenario you describe
>> above. I guess we could encode the PF number and the VF number in the
>> handle major/minor and operate on any PF device belonging to the same
>> silicon, WDYT?
> 
> Sometimes, there is no netdevice at all. The infra still should work I
> believe.

Note that in the most recent incarnation of the shaper APIs has been 
removed any support for shaper 'above' the network device level (e.g. no 
device/VFs groups). The idea is that devlink should be used for such 
scenarios.

Cheers,

Paolo


