Return-Path: <netdev+bounces-92393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB98B6DB1
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8E1C220E6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B773A29A;
	Tue, 30 Apr 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ai4UCPzo"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B512127B58
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467870; cv=none; b=GxreSmSS4xWtyR9+Bcw9yrDge/sYD43Ga1+zVKmcfOMCaa+ozP42bzE5FTxJYt+GRlmTcM/b3JdSjuMIobuvWX/stNM0QLbzua5UOq2vc7QvjIC02zthfzldHo1jcZBdmPsmWgRZhSMsyg9AvCc0VQYM3k8UU7ILa+xaqhcK2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467870; c=relaxed/simple;
	bh=4rkeTVsMojvgQzGVKa1EZAh/4DHyNBBTiKSnSx1BGXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds7C1WtHkPZYtkbx9MdhuM6lXjozGGtXxnv0xYwdVdBHFF+bf8R5UxKho8g1BOompZdSP3qtSc3bpxX1j15ewaIdyHEdOmV9z9gOT65qmGGjO2L6MZi22/mjAtp0j2XrdirrjbNVH16pzUXTQnmhCIt91Hb6avxldsCjYAswKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ai4UCPzo; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714467861; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uVMb6/8FheJeB+yUltG1KPM/ngAQ1ODypk3q/NfJjaw=;
	b=Ai4UCPzopNoTf+NfQmaXNRIOLzf+1NwK30wQnmmT9c30/B6/ebATMy9bANRbh0u2ew1cG0C2hDsit+6pc8s3ERjwc5kHCKT5Kt7HoRx1aZ7lnH4jYql66kSVPXkP5X+WqRMH2/7hPARMNSJv042DegMW7ESRJ6vEH92B6EWBreY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5blHhn_1714467859;
Received: from 30.221.128.72(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5blHhn_1714467859)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 17:04:20 +0800
Message-ID: <2a60f567-98d3-485c-911c-6383a6c5379c@linux.alibaba.com>
Date: Tue, 30 Apr 2024 17:04:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: add tracepoint for tcp_write_err()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, fred.cc@alibaba-inc.com, xuanzhuo@linux.alibaba.com
References: <20240425162556.83456-1-lulie@linux.alibaba.com>
 <fbeb89142a37a442d0a2184441a0fb4033b82ac8.camel@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <fbeb89142a37a442d0a2184441a0fb4033b82ac8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/30 16:27, Paolo Abeni wrote:
> On Fri, 2024-04-26 at 00:25 +0800, Philo Lu wrote:
>> This tracepoint can be used to trace tcp write error events, e.g.,
>> retransmit timeout. Though there is a tracepoint in sk_error_report(),
>> the value of sk->sk_err depends on sk->sk_err_soft, and we cannot easily
>> recognized errors from tcp_write_err().
> 
> Why not? you can look at the dumped sock protocol and ev. capture the
> sk_error_report tracepoint call-trace.
> 

Thanks for your suggestion, Paolo. I'll try to trace sk_error_report 
with its calling stack and see if this could solve my problem.

Though tcp_write_err() seems to be inlined in my system, upper callers 
may provides useful infomation. Let me have a try;)

Thanks.

> IMHO this provides little value and is not worthy.
> 
> Cheers,
> 
> Paolo

