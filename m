Return-Path: <netdev+bounces-142685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB39C0026
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4841F217D8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451A1D8DFE;
	Thu,  7 Nov 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vCMSK8Ij"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF9198A19
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968690; cv=none; b=UINAkI7l8gOGsVFVGoFbPWSWVluEW0lq2seyittaSF9yyR5gIAWTVPM8SBOG7I5jT2GEozYcSArpbMnmyvVRjEc2ns/4DZG/kgA3GeChsQl0wUtnHfvjcrfZjosi9k23KZbetHL9VXmj8YqbYljvaBZVQtFmU9MkJ+Hw4Br6+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968690; c=relaxed/simple;
	bh=wNDVS52YhF+6G3l4wOoxsHdU8x3toVQLtYF9saHltZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNIiUZZz7CP3TDZacbTzLMaCgX6sICMCTIL5mUFnsSJe00pSrhLQiamlcei/wGfUHwiIkUX+2Z0Hu54uMmclJs524o7AsZbmZw0Pzd7FauBD9Epepgq2UqZ3uhf+sYTiKw828nsSiJiZYMJMJORZ5htXuW7EkKSuZWVf5tEwyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vCMSK8Ij; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730968680; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=94Xce1o7UQKdGO23tlbNrTTUEGnhP7t4W7fm9A3zuAw=;
	b=vCMSK8Ij2oFCOrevCDWbgdxs0PdLjyRS86PhFioHFppI0bpZm73xDFjI2BD4q+Sd1wpFKFr35TcybrnfvytehdaP/UFwB0L8cHUIpWF+fSAj4pcApEkhzqZ9gI5XqnCbEuKmK8XmGfdxc37M33zjlvOgYQjMV5ZdPHxpHnOlIYE=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIuuZnl_1730967745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:22:26 +0800
Message-ID: <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com>
Date: Thu, 7 Nov 2024 16:22:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com>
 <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/7 16:01, Jason Xing wrote:
> On Thu, Nov 7, 2024 at 3:51 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> Hi Jason,
>>
>> On 2024/11/5 10:55, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> We found there are rare chances that some RST packets appear during
>>> the shakehands because the timewait socket cannot accept the SYN and
>>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
>>>
>>> Here is how things happen in production:
>>> Time        Client(A)        Server(B)
>>> 0s          SYN-->
>>> ...
>>> 132s                         <-- FIN
>>> ...
>>> 169s        FIN-->
>>> 169s                         <-- ACK
>>> 169s        SYN-->
>>> 169s                         <-- ACK
>>> 169s        RST-->
>>> As above picture shows, the two flows have a start time difference
>>> of 169 seconds. B starts to send FIN so it will finally enter into
>>> TIMEWAIT state. Nearly at the same time A launches a new connection
>>> that soon is reset by itself due to receiving a ACK.
>>>
>>> There are two key checks in tcp_timewait_state_process() when timewait
>>> socket in B receives the SYN packet:
>>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
>>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
>>>
>>> Regarding the first rule, it fails as expected because in the first
>>> connection the seq of SYN sent from A is 1892994276, then 169s have
>>> passed, the second SYN has 239034613 (caused by overflow of s32).
>>>
>>> Then how about the second rule?
>>> It fails again!
>>> Let's take a look at how the tsval comes out:
>>> __tcp_transmit_skb()
>>>       -> tcp_syn_options()
>>>           -> opts->tsval = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + tp->tsoffset;
>>> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
>>> other is tp->tsoffset. The latter value is fixed, so we don't need
>>> to care about it. If both operations (sending FIN and then starting
>>> sending SYN) from A happen in 1ms, then the tsval would be the same.
>>> It can be clearly seen in the tcpdump log. Notice that the tsval is
>>> with millisecond precision.
>>>
>>> Based on the above analysis, I decided to make a small change to
>>> the check in tcp_timewait_state_process() so that the second flow
>>> would not fail.
>>>
>>
>> I wonder what a bad result the RST causes. As far as I know, the client
>> will not close the connect and return. Instead, it re-sends an SYN in
>> TCP_TIMEOUT_MIN(2) jiffies (implemented in
>> tcp_rcv_synsent_state_process). So the second connection could still be
>> established successfully, at the cost of a bit more delay. Like:
>>
>>    Time        Client(A)        Server(B)
>>    0s          SYN-->
>>    ...
>>    132s                         <-- FIN
>>    ...
>>    169s        FIN-->
>>    169s                         <-- ACK
>>    169s        SYN-->
>>    169s                         <-- ACK
>>    169s        RST-->
>> ~2jiffies    SYN-->
>>                                 <-- SYN,ACK
> 
> That's exactly what I meant here :) Originally I didn't expect the
> application to relaunch a connection in this case.

s/application/kernel/, right? Because the retry is transparent to user 
applications except the additional latency. I think all of these are 
finished in a single connect() :)

-- 
Philo


