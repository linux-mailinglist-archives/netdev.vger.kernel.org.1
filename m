Return-Path: <netdev+bounces-142668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E199BFF62
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6037BB21558
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40F194AD5;
	Thu,  7 Nov 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jg0EfmHE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550777F9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965887; cv=none; b=ZJxga4kHd5FWG06Oy4koPFwkslwnwEw6b9EPLvv68ExoGdo/xCm+dOak0vNjdPLuE1SZuww80wgzF+77DfKLEg4pvXA7IVVV0DTrN+j8e/ENoBAG1QFI4iFh37XCyc/CiKhhDCR5EjHo0CR1mvENSntmi5KlPj8JREJebYBMQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965887; c=relaxed/simple;
	bh=4cswRO9mj5VXxYFsub5U95e9Cb0k5k7HDbtLEJTM6Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucA6/70Uha2n6MF4YhmsphA8Da2wCb+97wHbSpzKsDCt+yDmXllhixWGVYyKJlLKvaWZAjA62RJ7LK5kcptcDjv0hqZ/sQewA4IIKg7t8qoBDql8AqvupyBcpzQ6woyr2R6C1UowGAXdsn0fSN5bMr4+ysEe8omWg7p4xW6z6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jg0EfmHE; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730965876; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fBs/snzXMAFjbS5YKxYdiv9o+aOCrsCevo/7XuMofrE=;
	b=Jg0EfmHEUqggIzI3obwH+knYAq2ehMnVr7EKYq1bXlc9A+GfCce4gc2pJnpDZ3gjskeV+1ddmn0or1qzxOK0WYBQS9vY1r+VtiRW/FhoVaUZrPWnexQnhz4X/0zITD7D6bOx28wcF/fjUFNqUTieT1mu7v66s+I+QYnyrk67hfY=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIuo2rp_1730965875 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 15:51:16 +0800
Message-ID: <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com>
Date: Thu, 7 Nov 2024 15:51:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 horms@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20241105025511.42652-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 2024/11/5 10:55, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> We found there are rare chances that some RST packets appear during
> the shakehands because the timewait socket cannot accept the SYN and
> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> 
> Here is how things happen in production:
> Time        Client(A)        Server(B)
> 0s          SYN-->
> ...
> 132s                         <-- FIN
> ...
> 169s        FIN-->
> 169s                         <-- ACK
> 169s        SYN-->
> 169s                         <-- ACK
> 169s        RST-->
> As above picture shows, the two flows have a start time difference
> of 169 seconds. B starts to send FIN so it will finally enter into
> TIMEWAIT state. Nearly at the same time A launches a new connection
> that soon is reset by itself due to receiving a ACK.
> 
> There are two key checks in tcp_timewait_state_process() when timewait
> socket in B receives the SYN packet:
> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> 
> Regarding the first rule, it fails as expected because in the first
> connection the seq of SYN sent from A is 1892994276, then 169s have
> passed, the second SYN has 239034613 (caused by overflow of s32).
> 
> Then how about the second rule?
> It fails again!
> Let's take a look at how the tsval comes out:
> __tcp_transmit_skb()
>      -> tcp_syn_options()
>          -> opts->tsval = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + tp->tsoffset;
> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> other is tp->tsoffset. The latter value is fixed, so we don't need
> to care about it. If both operations (sending FIN and then starting
> sending SYN) from A happen in 1ms, then the tsval would be the same.
> It can be clearly seen in the tcpdump log. Notice that the tsval is
> with millisecond precision.
> 
> Based on the above analysis, I decided to make a small change to
> the check in tcp_timewait_state_process() so that the second flow
> would not fail.
> 

I wonder what a bad result the RST causes. As far as I know, the client 
will not close the connect and return. Instead, it re-sends an SYN in 
TCP_TIMEOUT_MIN(2) jiffies (implemented in 
tcp_rcv_synsent_state_process). So the second connection could still be 
established successfully, at the cost of a bit more delay. Like:

  Time        Client(A)        Server(B)
  0s          SYN-->
  ...
  132s                         <-- FIN
  ...
  169s        FIN-->
  169s                         <-- ACK
  169s        SYN-->
  169s                         <-- ACK
  169s        RST-->
~2jiffies    SYN-->
                               <-- SYN,ACK

Thanks.

-- 
Philo


