Return-Path: <netdev+bounces-154872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6523A002CC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3B163100
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39C14B950;
	Fri,  3 Jan 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="KpJBNdfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17314A08E
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871861; cv=none; b=Gqi8lbXoZIztsQGB7Mi3qFhWE0fCsT+1toQe8wuLJ7PtFhY7xpVrKPb55L/d9ZjmctcfNWgxsnMi4wEKUQub3TohGcqAm4/J9kXPxfGxS+Y3icwwfwd4RoZRIcibMrmK7PzWuGO69GMDWtA5zONDQda/aHSMi9Jgd479fummlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871861; c=relaxed/simple;
	bh=DoTuMDArl3mo2xWBoj7hG+CNIq7vsmiKWJkXJib2M4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAwHbXZUlXUSgLlZpvW4qoxhyG5JsI5UTojuVzWPUiq4yYsLr34SDqjllgmqrcVHG4vwukFuE1YMRzGEZsygt1znh4RmiiG5pFUHOuvJONEm1LSqwvoDG26/69QWTNTumGb7qKhiaQx8dIN/5W7NlKaWNGkpKqsfGmsaDiBjQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=KpJBNdfO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21669fd5c7cso165736185ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735871859; x=1736476659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1iVWzJPR2miPqAPZWUSXyz7V7yso1ZIEtL541TpIdY=;
        b=KpJBNdfODopM7FvkmK20gEtaaumJbUW0erayt3OlOFWFysJ6cfGQnk5vhf+L7F2Toa
         1pjZHbKHBwX7ptVJGON8TOSmJcHmN5BOhc5ZRJPqM/P60iJgyRorcS9+SzoBfxE8Y0Cc
         7XaWypmEgF4AxKA3OsGPO7yAban3yQuVpBbKPpN/46VF8cB4jHHYSXnf58nV2ubW/3AT
         WTTHqFi8AjcPWL/rqMjaPGBIJv0BeDlHe6goCQiByjmfm5kb11MQLhhXlCNMe4iKyJRI
         D1KEbbFvcV4gN9oEnLREhy2xiBc/DkeC7iinQ1sWHWWbBZtLH369YCKaeoXhw+/pvMGZ
         jaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871859; x=1736476659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f1iVWzJPR2miPqAPZWUSXyz7V7yso1ZIEtL541TpIdY=;
        b=DQqINF4Hjyixyvuer5Cfa5t+YTpCBzAZhojgn/AgrtPEbZrJl8uvHIMCwp4MO02uvr
         aodt6eILfoFofKkyhEcURsH/LLthANdt0XF0dUoTKDw2LzHHOY1GREw6EEmhQ+6B8Qxf
         np/W2fwJqzPhkfX0vUZ419Lh4K26yhDxYBTd3Qpke1EdB9gddDGlEjOKsvh5e7oEwf0d
         o+wY92+IQAgPlT3HugfY6G5tbSD0TKT6Nl1JcbsCI6ka7CLKqBRn81AS9C2NwT6hrMLq
         cXCzOeXUpbSk0m17zjxbvkrOlxPAAc2pxsvQXrYgtR524oy6m+O3ZTqgCJkbGVustXux
         BeOA==
X-Forwarded-Encrypted: i=1; AJvYcCXZKAWMf2f87Qw1wKN3RVSKgPqn5zImNonLZVY72EGe1LscCfPX/70LFE3NuCtDva3DOXTChOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRXwxnMPZuzqKRG0DGoRbBljGliJtt+A58+nWO/RniSZmkBh2
	gPap31AOoSYKXDPd9ou3aa9QDn2zyjBIeWLYgWX8oBER8S/bZ8r2RqKQN/akJrM=
X-Gm-Gg: ASbGncv+rrpzD/WN3HGLPz4ftyLWWfNj9XRm1czKuYrnezldn3ua0kxEZ+2sKTvJv6n
	01hgIg0GpkDgvSXzBWKAoBdlxNFRUkqEJ7pnqtVf+6/yM1J1qVk3drzeDlEbACdtNC9AwKViEVn
	5K7omZHgWQ3iMJi+eH5Ea3p9iU57XV30tMzKYiYIlVsNpPdO+jCq7PZQlRNflrVP0Lfxy/VvOFU
	3kKd3mMW5msSfWGsDcjDRC6ne3iCR9mrh3HgqRZhfn65WItD4OTnpDuaTcdzSAgxt4vkg==
X-Google-Smtp-Source: AGHT+IHpB5Y7OW1lducBQWCXmvdTSdZYEj/TmGv0sludHLsA4z/6YwV34YDqoyvDPJvHfr6BcYggCw==
X-Received: by 2002:a05:6a20:2443:b0:1e1:90bd:2190 with SMTP id adf61e73a8af0-1e5e0819124mr76232142637.44.1735871859473;
        Thu, 02 Jan 2025 18:37:39 -0800 (PST)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b2b3e83dsm19544642a12.32.2025.01.02.18.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 18:37:39 -0800 (PST)
Message-ID: <87b14362-cc58-496e-a38c-6db5d4025026@shopee.com>
Date: Fri, 3 Jan 2025 10:37:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Jakub Kicinski <kuba@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
 <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
 <c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
 <CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
 <b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
 <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
 <20250102083915.6e5375a1@kernel.org>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20250102083915.6e5375a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/3 00:39, Jakub Kicinski wrote:
> On Thu, 2 Jan 2025 16:01:18 +0000 Edward Cree wrote:
>> On 02/01/2025 11:23, Haifeng Xu wrote:
>>> We want to make full use of cpu resources to receive packets. So
>>> we enable 63 rx queues. But we found the rate of interrupt growth
>>> on cpu 0~15 is faster than other cpus(almost twice).  
>> ...
>>> I am confused that why ixgbe NIC can dispatch the packets
>>> to the rx queues that not specified in RSS configuration.  
>>
>> Hypothesis: it isn't doing so, RX is only happening on cpus (and
>>  queues) 0-15, but the other CPUs are still sending traffic and
>>  thus getting TX completion interrupts from their TX queues.
>> `ethtool -S` output has per-queue traffic stats which should
>>  confirm this.
>>
>> (But Eric is right that if you _want_ RX to use every CPU you
>>  should just change the indirection table.)
> 
> IIRC Niantic had 4 bit entries in the RSS table or some such.
> It wasn't possible to RSS across more than 16 queues at a time.
> It's a great NIC but a bit dated at this point.

Yes, It only has 16 RSS queues.

