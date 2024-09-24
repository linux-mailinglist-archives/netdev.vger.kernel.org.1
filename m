Return-Path: <netdev+bounces-129419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED29983B12
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 04:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D81F228BB
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 02:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E244414;
	Tue, 24 Sep 2024 02:06:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476E18D
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727143571; cv=none; b=QU93h4XpW/8Qt/IIIXo8O0mUBf92HcUcnSggQv+wyJAcdr1ZPGbN1vedWGV4vvpoUsyD29deGOYPS0vwXxV4vSS84Be9Jw9m5FAQfaiI90RZTNbzdIx9BvdH/PtjNvxJ37az5OJmz9CpT7d3jp3fBMtlhUm2F6npDbmnjHnE/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727143571; c=relaxed/simple;
	bh=/GPItMpwrQHjOj8ULzL2IjXrWkB5dvGcnnwX3vvXU1s=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WbWdW53QYw4tyOzXqcv7TtyiMxq1qVY71LF1c4iMYDr9pQ3rht95P6XSwjIV1l1/BKe28P4fqmvG+VwMQusyCLFUgYMqTmU+ZUhBwVGpY/CNtCgCWytYSOaSy4WW4fumMwKP0SLpQ3o2FiuXZfG4ryEQCnHU7bVZM2HUdenjk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XCNSy5yJ1zpW5N;
	Tue, 24 Sep 2024 10:04:02 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id B5932180087;
	Tue, 24 Sep 2024 10:06:05 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 10:06:05 +0800
Message-ID: <3346a456-48f7-44e4-b9f4-c7f13032d820@huawei.com>
Date: Tue, 24 Sep 2024 10:06:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, Shengqi Chen
	<harry-chen@outlook.com>, Yuxiang Zhang <zz593141477@gmail.com>, Jiajie Chen
	<jiegec@qq.com>, Mirror Admin Tuna <mirroradmin@tuna.tsinghua.edu.cn>, Salil
 Mehta <salil.mehta@huawei.com>
Subject: Re: [BUG Report] hns3: tx_timeout on high memory pressure
To: Miao Wang <shankerwangmiao@gmail.com>
References: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
 <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
 <F90EE18D-1B5D-4FB2-ADEB-EF02A2922B7F@gmail.com>
 <fb813399-b1a5-489f-9801-f9f468e2beb0@huawei.com>
 <A8918103-4A1D-43FF-9490-1E26ABEDA748@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <A8918103-4A1D-43FF-9490-1E26ABEDA748@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/24 0:12, Miao Wang wrote:
>> 2024年9月23日 21:37，Jijie Shao <shaojijie@huawei.com> 写道：
>>
>>
>> our analysis. I wonder how can I verify the scheduling of NAPI.
>> You can use napi trace to verify it:
>> echo 1 > /sys/kernel/debug/tracing/events/napi/napi_poll/enable
>> cat /sys/kernel/debug/tracing/trace
> I managed to make a reproduce. Attached is the dmesg and the trace log. It seems
> that in the trace log, napi_poll() is kept called.
>
> My reproducing environment is a smart git http server, which is using nginx as
> the frontend, git-http-backend as the CGI server and fastcgiwrapper for
> connecting them, running on a Taishan server. The served git repo is linux.git.
> At the same time, start some programs taking up about 70% of the system memory.
> Using several other hosts as git client, start as many git clone processes as
> possible on the client hosts, about 2000 in total, at the same time, pointing
> to the git server, letting the forked git processes on the server side take up
> all the memory left, and causing OOM on the server.
>
Hi Miao,
Thanks for the reproduce. I checked the dmesg and trace log of napi.
We can see the first tx timeout occured at the time [19555675.553853], and we
can see the napi poll seems keep being called all the time. Exactly the trace
log is for all the napi context, and we can differentiate the napis by the
address of napi struct.

For we can't direct map the queue id with the napi poll, so I just searched
several poll records of them.

napi struct ffff003ffffab350, running on core45: the time interval of twice calling near time [19555675.553853] is 11.8s
Line 1:            <...>-2530388 [045] ..s1 19555667.046219: napi_poll: napi poll on napi struct ffff003ffffab350 for device (no_device) work 2 budget 64
Line 1622:           <idle>-0       [045] ..s. 19555678.885859: napi_poll: napi poll on napi struct ffff003ffffab350 for device (no_device) work 3 budget 64
Line 1630:            <...>-240     [045] ..s. 19555680.934259: napi_poll: napi poll on napi struct ffff003ffffab350 for device (no_device) work 18 budget 64
Line 1664:            <...>-952404  [045] ..s1 19555682.647716: napi_poll: napi poll on napi struct ffff003ffffab350 for device (no_device) work 2 budget 64

napi struct ffff203fdfe83350, running on core88: the time interval of twice callingtime [19555675.553853] is 0.1s~4s
Line 12:            <...>-1370850 [088] ..s1 19555667.066796: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 1 budget 64
Line 65:            <...>-2530388 [088] ..s1 19555669.357841: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 1 budget 64
Line 70:           <idle>-0       [088] ..s. 19555669.921949: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64
Line 913:            <...>-1627419 [088] ..s. 19555670.945995: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64
Line 1117:            <...>-1627580 [088] ..s1 19555674.376050: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 4 budget 64
Line 1118:            <...>-1627580 [088] ..s1 19555674.376113: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64
Line 1119:            <...>-1627580 [088] ..s1 19555674.376202: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 4 budget 64
Line 1120:            <...>-1627580 [088] ..s1 19555674.428469: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64
Line 1121:            <...>-1627189 [088] ..s. 19555674.469891: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64
Line 1131:            <...>-952227  [088] ..s1 19555675.760740: napi_poll: napi poll on napi struct ffff203fdfe83350 for device (no_device) work 2 budget 64

napi struct ffff202fffe7f350, running on core60: the time interval of twice callingtime [19555675.553853] is 7s
Line 668:            <...>-952213  [060] ..s1 19555669.970071: napi_poll: napi poll on napi struct ffff202fffe7f350 for device (no_device) work 2 budget 64
Line 670:            <...>-952213  [060] ..s1 19555669.970094: napi_poll: napi poll on napi struct ffff202fffe7f350 for device (no_device) work 2 budget 64
Line 1154:            <...>-952202  [060] ..s1 19555676.156687: napi_poll: napi poll on napi struct ffff202fffe7f350 for device (no_device) work 2 budget 64
Line 1183:            <...>-952140  [060] ..s1 19555676.239415: napi_poll: napi poll on napi struct ffff202fffe7f350 for device (no_device) work 2 budget 64

We can see some napi poll haven't been called for more than 5s, exceed the tx tiemout interval. It may caused by CPU busy, or no tx traffic for the queue during
the time.

Thanks,
Jijie Shao


