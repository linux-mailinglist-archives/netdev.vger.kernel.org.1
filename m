Return-Path: <netdev+bounces-67318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38EA842C31
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EE31C20F85
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE97993B;
	Tue, 30 Jan 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="r67Hu7PH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956879938
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641069; cv=none; b=Ni9g6N9wXc6aEwmAJf1UXKIyRBSoh2yd15aqwor3iZ3Ytut59/uf0UOeXjD1kGJLXqb+2QXSXAN/53tSa3heg4Mgzb0YqBgXXuZD1/0xKWZ1S/tMNbxMAvDD7A7/q2Q44Ridl5FqLqSYYew/KHlgzdfdKWAEFFSxk+2F6gklYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641069; c=relaxed/simple;
	bh=lUe0axQOgc305VGCI33fdAt13QhrEYeOH68ZRfGv8so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WReIZnKUEciblpEt62xnRrLZtaH7o4+zuJkjHjfAMNoHqmn9mUiAOW64qWm9jx0kHSFwIRm6MCDvE6roigNRYIHHkh6fOhsmJeXnkHksFHBBjR6MFX82V9a9OwmK5DFE5AzIpH0zrWWT4GU5sZMVTZVwZbJqwb3I0ik4DsjEUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=r67Hu7PH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3464988a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706641068; x=1707245868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwUfpYBCXz8laykxIJFAS+u/K3GLIrL+W117hL/7XMA=;
        b=r67Hu7PHOqPpl2OQMePGSAcyl71dgzqWCTnj4qgX0SBzd9dXiZKQNqbaqsOf8h0SJa
         CFvpLzmK54gyAKCbXFyIA6XMd6pJblh76f/lnvgi4o8Z0147AaSBa1JpuXKKWpFzMGTZ
         3Pd3xy4cG5u4vkycFX9Q60peizQTSSVWUvfIpOKHlgAA/1V6+Mtb1w1gf6vB9cWTK85B
         ujI0vB/stnRD+ccd/blvHxULH2m6QC0CQIgYCUBwChV8SdKZuNCTZLD0qw5FQDwItA2h
         T5Qohm4EBP5Dy9t58YY7WXs9XGnkTGbuKeMdb2+Kb67uYGTJ+FwQoIWpQU+1EvKqau3g
         LN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641068; x=1707245868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwUfpYBCXz8laykxIJFAS+u/K3GLIrL+W117hL/7XMA=;
        b=i231rcQskynFUOey1VDiQi3GLiPktcvR1PotKdacKJqweLFjiGOC8jZgD2DlDXmNkM
         KzJdietd5uXdgWqCW6YwR3rno7YVsqd/q1wUtTglikiD8ccmZxcPn4UxN/f7SkpqBiiK
         tICsDZkQWTfZn4MI3xS41hRAe9n9Iw9M5F3ocoCR9XetZLN/6lefONd/veMO9TElsvLA
         lcStGVTo6SVPHzpYktM006u6K2v4JPv7gCK1yafhwNvqqcXe0bA9jtY/ZRgy+0rKcfqe
         EZGMLovlKuEfPhyeMgRNg4LLT6RhGAylHFkQvsghBepVWvbkBthn+N6WeDf9X78xvxGt
         VUGw==
X-Gm-Message-State: AOJu0YyX+rVQ1yA9QZoMb3ouxWfyyFnoXDPHLUJVpqYMKXAFrGs/f5YI
	h/klJqzJXuaMkfUElIr71ILqkeeUWSDsdiDzfys/ognWnK6FvnHtlrl+UI+PjYI=
X-Google-Smtp-Source: AGHT+IHemzUC2+a/r6cqAqO+9yN8riWTsCtxuCRbzVVCfb62eMfIpinIifgQ15Ub/USwVV+AhRUp/A==
X-Received: by 2002:a05:6a20:1a9c:b0:19d:afe5:fd5 with SMTP id ci28-20020a056a201a9c00b0019dafe50fd5mr3294617pzb.33.1706641067692;
        Tue, 30 Jan 2024 10:57:47 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:e9e7])
        by smtp.gmail.com with ESMTPSA id w188-20020a6262c5000000b006dbd94fc7ebsm8535179pfb.38.2024.01.30.10.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 10:57:47 -0800 (PST)
Message-ID: <9bba3a59-9281-4029-958f-71b17c5670a7@davidwei.uk>
Date: Tue, 30 Jan 2024 10:57:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/4] netdevsim: add selftest for forwarding
 skb between connected ports
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240127040354.944744-1-dw@davidwei.uk>
 <20240127040354.944744-4-dw@davidwei.uk> <20240129203401.GR401354@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240129203401.GR401354@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-29 12:34, Simon Horman wrote:
> On Fri, Jan 26, 2024 at 08:03:53PM -0800, David Wei wrote:
>> Connect two netdevsim ports in different namespaces together, then send
>> packets between them using socat.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  .../selftests/drivers/net/netdevsim/peer.sh   | 127 ++++++++++++++++++
>>  1 file changed, 127 insertions(+)
>>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
>>
>> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
>> new file mode 100755
>> index 000000000000..05f3cefa53f3
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
>> @@ -0,0 +1,127 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +NSIM_DEV_1_ID=$((RANDOM % 1024))
>> +NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
>> +NSIM_DEV_1_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_1_ID
>> +NSIM_DEV_2_ID=$((RANDOM % 1024))
>> +NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
>> +NSIM_DEV_2_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_2_ID
> 
> nit: NSIM_DEV_1_DFS and SIM_DEV_2_DFS appear to be unused.
> 
> Flagged by shellcheck.
> 
> ...

Hi Simon, thanks for flagging this, these were leftover from previous
changes. I'll remove them in the next version.

