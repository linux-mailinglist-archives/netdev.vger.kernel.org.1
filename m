Return-Path: <netdev+bounces-128267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B0F978CC8
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE041F25211
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BE8F6E;
	Sat, 14 Sep 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SbyGHzPx"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FFD529
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280902; cv=none; b=BMnFD0vyOvoHV/j1qZymNfSHU+XCAoSIPlSmHbdwpITms0lNHc0vg4usXBYLxWmVoGU+E9SuUNXeHqgr8ty0azmxZNBtJcyDdxc9k2Jp848MZnGijLNDB8FjpcTchU4jtf4rR+W6gIQIacKI8D3Ypmpnua7+x5+LqFvtLwi+sZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280902; c=relaxed/simple;
	bh=mWE5ZnRtqob8y5svUbW5or4BDwYqxpY/ArwSvaK5+dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDyY4jLpLFbjN7eAnewRwtapamfhrYQTj4yxqHqRm+59PlS527zS2N+XfFiUfaSK2lbMP1tumMjMtZRUJIDRmnYyrPhaSqNZVkkbT0cIxPJTwbXHqoSquZsolNOl0GEUyHwo/yDFQv6CLT39smepKmemf8vRLlZzMahRA6Grrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SbyGHzPx; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726280897; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PxeOyrk7YAIWIYcq16mENeyAvdc+NNROmy+EQTjyDn0=;
	b=SbyGHzPx3/UfOd1UnbIJ6cHM5IivBwt3FX47pfj0Utedk328juJyw9X4+xKvX51GsdP8X8JcKT/G75VyJiIUtd3dUr5aY3oOBbJuQZyLTkVEM5vLoWB7QyIeN2jMmxTEZjyV5XSjtxiteiNM3rzNGvvv2K4lbwuVBOSQ17+fHrQ=
Received: from 30.221.148.122(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEwJ3JP_1726280896)
          by smtp.aliyun-inc.com;
          Sat, 14 Sep 2024 10:28:17 +0800
Message-ID: <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
Date: Sat, 14 Sep 2024 10:28:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ZuTehlEoyi4PPmQA@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 8:53 AM, Cong Wang wrote:
> On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
>>
>>
>> On 9/12/24 8:04 AM, Cong Wang wrote:
>>> From: Cong Wang <cong.wang@bytedance.com>
>>>
>>> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
>>> RCU version, which are netdev_walk_all_lower_dev_rcu() and
>>> netdev_next_lower_dev_rcu(). Switching to the RCU version would
>>> eliminate the need for RTL lock, thus could amend the deadlock
>>> complaints from syzbot. And it could also potentially speed up its
>>> callers like smc_connect().
>>>
>>> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
>>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>>> Cc: Jan Karcher <jaka@linux.ibm.com>
>>> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
>>> Cc: Tony Lu <tonylu@linux.alibaba.com>
>>> Cc: Wen Gu <guwen@linux.alibaba.com>
>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>
>>
>> Haven't looked at your code yet, but the issue you fixed doesn't exist.
>> The real reason is that we lacks some lockdep annotations for
>> IPPROTO_SMC.
> 
> If you look at the code, it is not about sock lock annotations, it is
> about RTNL lock which of course has annotations.
> 

If so, please explain the deadlock issue mentioned in sysbot and
how it triggers deadlocks.

> And you don't even need to bother sock lock annotations for this specific
> case at all (I can't say any other case).
> 
> Thanks.



