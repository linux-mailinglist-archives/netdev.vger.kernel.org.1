Return-Path: <netdev+bounces-107186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4791A3EA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09F6B22999
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871013E03D;
	Thu, 27 Jun 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bP6eNK7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AC13E048
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484396; cv=none; b=X+mcWhIxMVfeJV/wmHIyWINFC1RqT6ecuSwg3dgE61NV5Ue0nXMzOzTOJkqq0HaZFRbEIOmjk0wO9KWZLV1D9wN0EFRla1QZPjYixrbVGz7PtdlxEa0o4TQjyaPfSz+efEnht/D4UuNoFlBMB6x5ZkdncXUjgVyz4U1YrnRNdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484396; c=relaxed/simple;
	bh=ufgrCSeDaYULNoG//tPLWOJ81cgbR64iedkOiFsD4OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hoh9cgH9kFGNp7iBmyrlNXCqbuLoIKvTGu2dLGolfsPwVBVl5bmD2XTDrlK/MbemrUhtmYIp8HeRLcVLtjjAblNZ9UZruHtpCtXwKxV9EiZPm5o9NYk6uw5ZzHZICdSWX+f9CcFqpBf+W9FfeM5/1eB6Dq6qpeU9+A5q2JXSGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bP6eNK7X; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so64883121fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719484393; x=1720089193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v2XgQwZi3zYQ2CiYfqQ02KEoB+/elULaumWKlgU5K8=;
        b=bP6eNK7XiUoM5D6x00IFTYCbmbpqesRogROTASTDBviEdXYOOkNIF8rdkIZjeRe3j1
         WHKlTxh+pv758+JaNwNidhNo4DJnkfVqvxeCfNz7K2hzTwOr3hcsv3/eNy520VXXMOaZ
         afXjvHS/muDfPGb/lq77fNivZTLGxTUVGEKJGXPtiFiCVnW2Ke9yVom3WQJswkjP+hqN
         eN3MoH8JXTkeNQzcw2dWUrADYLBLlbAIQZ86c9pgpS2Jy06gWr/i629yg9onzFC26t1g
         J9mi32oT2WHAwhBqPCGWDRzMwgM1d15QjGYfFZQW+htbcA7iOLrOou20H7y3iuGxMpca
         /HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484393; x=1720089193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v2XgQwZi3zYQ2CiYfqQ02KEoB+/elULaumWKlgU5K8=;
        b=ODu0Q5ayrbU7YAlGPi9g14jdQAtLXGUmOTgSIE60dIrGdp4XAPvTIExH+pcwmSjq1a
         TlYvVUy1d9+hqAkmrf2Dddu0QDOU2R1jcdXnYz/IyJ8gYyH0GVk8anWexHDP6QZSIEFM
         p8uLNc/t6yNAIm6exMqKTuUMYvlEdHbZ5qyV+cQMPYxck6trncOExNwxquhem8M+f0eX
         uFA3K/zidkILbkh5WxXJCQ67Z7eUBWeBCtFlWtO2sdWmk7aKmqOij76loVjfQCMbmhki
         9tuuD5THPLvPqvnaiwWv+8gPCcuPYwupl8wOEDFW+XcQwkNhuPBsM4mohwQ/6MAwZODU
         S30A==
X-Forwarded-Encrypted: i=1; AJvYcCUtuG+bNFxdnJhjKE0ApcaNNuH1dWM9kaqY5hXfACaBTvVbhWYMAklyc2TMcbwX37EPwVVhj63KycOgjltqVXz3mHUGuFDb
X-Gm-Message-State: AOJu0YzYB1e2SpFNsoOySJhtC7s6bwnaWyDqV7a1gzJuCRQ+PDnhcahx
	vyfkTG77I4i9zWVPxQGfE45EhWiu2Ri1d3NO/EseiJAuerqdFLEdI58VRRtYCeo=
X-Google-Smtp-Source: AGHT+IHGPMylUOGla/DTzw+nc2T2DDe+sXjEIaL5m55wD9+xJgwd8hTBXzKtPBdz2+s0KGS1V+AbXA==
X-Received: by 2002:a2e:8e8d:0:b0:2ee:45e0:3550 with SMTP id 38308e7fff4ca-2ee45e036d3mr27567621fa.32.1719484392614;
        Thu, 27 Jun 2024 03:33:12 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d1282475sm688375a12.35.2024.06.27.03.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 03:33:12 -0700 (PDT)
Message-ID: <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
Date: Thu, 27 Jun 2024 13:33:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org> <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zn05dMVVlUmeypas@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 13:05, Hangbin Liu wrote:
> On Thu, Jun 27, 2024 at 11:29:21AM +0300, Nikolay Aleksandrov wrote:
>> On 27/06/2024 11:26, Hangbin Liu wrote:
>>> On Wed, Jun 26, 2024 at 05:06:00PM -0700, Jay Vosburgh wrote:
>>>>> Hits:
>>>>>
>>>>> RTNL: assertion failed at net/core/rtnetlink.c (1823)
>>>
>>> Thanks for this hits...
>>>
>>>>>
>>>>> On two selftests. Please run the selftests on a debug kernel..
>>>
>>> OK, I will try run my tests on debug kernel in future.
>>>
>>>>
>>>> 	Oh, I forgot about needing RTNL.
>>>>
>>
>> +1 & facepalm, completely forgot it was running without rtnl
>>
>>>> 	We cannot simply acquire RTNL in ad_mux_machine(), as the
>>>> bond->mode_lock is already held, and the lock ordering must be RTNL
>>>> first, then mode_lock, lest we deadlock.
>>>>
>>>> 	Hangbin, I'd suggest you look at how bond_netdev_notify_work()
>>>> complies with the lock ordering (basically, doing the actual work out of
>>>> line in a workqueue event), or how the "should_notify" flag is used in
>>>> bond_3ad_state_machine_handler().  The first is more complicated, but
>>>> won't skip events; the second may miss intermediate state transitions if
>>>> it cannot acquire RTNL and has to delay the notification.
>>>
>>> I think the administer doesn't want to loose the state change info. So how
>>> about something like:
>>>
>>
>> You can (and will) miss events with the below code. It is kind of best effort,
>> but if the notification is not run before the next state change, you will
>> lose the intermediate changes.
> 
> Yes, but at least the admin could get the latest state. With the following
> code the admin may not get the latest update if lock rtnl failed.
> 
>         if (should_notify_rtnl && rtnl_trylock()) {
>                 bond_slave_lacp_notify(bond);
>                 rtnl_unlock();
> 	}
> 
> Thanks
> Hangbin

Well, you mentioned administrators want to see the state changes, please
better clarify the exact end goal. Note that technically may even not be
the last state as the state change itself happens in parallel (different
locks) and any update could be delayed depending on rtnl availability
and workqueue re-scheduling. But sure, they will get some update at some point. :)

It all depends on what are the requirements.

An uglier but lockless alternative would be to poll the slave's sysfs oper state,
that doesn't require any locks and would be up-to-date.

Cheers,
 Nik


