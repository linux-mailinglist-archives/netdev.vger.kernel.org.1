Return-Path: <netdev+bounces-157253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206DA09BA4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4416A61E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340724B246;
	Fri, 10 Jan 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SyHkDKS5"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FA24B242
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536433; cv=none; b=OYdEtQW0hmFek6xc0f/EK2IPbqOK1v6TQtadgoUUibOFaksXnkIMDj6c8HOgOcVdp0pbPDddrEQVo4IP+m4wobmnh2kpmfFrvnS5ZzeIgA9qkvFyE5a8JfuMx7MquAASPhSQMUgTdQw2yo4w1nYYwLiNhZyF6bxumdNYzc1cStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536433; c=relaxed/simple;
	bh=j0Wrc0ed/VOXhLOb3pFOBYCqlAIDGCPsa/306+UTx5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNROwreA9BntEq8XV67BygT5498LNayfbPmsbZdTlRb7pQxkLVZER6Q5DwXxeDQrY5BPS84Yriq2bDzbFizv/oqV1WOs59PHZSueVIdQDmIbwP1QIO/+mC+IXKs7r8YhnSMyO5FREwsoKOdO8oSnTPNQ3JR5hzbchC63MnmJm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SyHkDKS5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a63e1f1-4130-4862-a543-1715ca45ee6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736536429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtRIzX2/Lk8muF/cohcnBRZPBZvkg/oBhJrZFqqJM4w=;
	b=SyHkDKS5VnPqvVa4YAC77URA+e+u0p15QXVy+nlzuHsQjwUx6r2GLiOXSYwpj2PmApfW9r
	uAOtFp17Ea+JqPKV2izbBnnOvdy75t2m+4nP5VzBPMzxoRFRV0dajWlC3i1rJSJ8RSLQKM
	ebsU/TeEsMQzT3i0ZEkVQ4Iv/WvV7NQ=
Date: Fri, 10 Jan 2025 11:13:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: restrict SO_REUSEPORT to TCP, UDP and SCTP
 sockets
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com,
 syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com,
 Martin KaFai Lau <kafai@fb.com>
References: <20241230193430.3148259-1-edumazet@google.com>
 <20241230160739.351a0459@kernel.org>
 <CANn89iJzjq9w-Z8GJaY1=KDLku00aweoZTB4_XHzHe=Cp7xy6w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89iJzjq9w-Z8GJaY1=KDLku00aweoZTB4_XHzHe=Cp7xy6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/31/24 4:44 AM, Eric Dumazet wrote:
> On Tue, Dec 31, 2024 at 1:07 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 30 Dec 2024 19:34:30 +0000 Eric Dumazet wrote:
>>> After blamed commit, crypto sockets could accidentally be destroyed
>>> from RCU callback, as spotted by zyzbot [1].
>>>
>>> Trying to acquire a mutex in RCU callback is not allowed.
>>>
>>> Restrict SO_REUSEPORT socket option to TCP, UDP and SCTP sockets.
>>
>> Looks like fcnal_test.sh and reuseport_addr_any.sh are failing
>> after this patch, we need to adjust their respective binaries.
>> I'll hide this patch from patchwork, even tho it's probably right..
> 
> It seems we should support raw sockets, they already use SOCK_RCU_FREE anyway.
> 
> Although sk_reuseport_attach_bpf() has the following checks :
> 
> if ((sk->sk_type != SOCK_STREAM &&
>       sk->sk_type != SOCK_DGRAM) ||
>      (sk->sk_protocol != IPPROTO_UDP &&
>       sk->sk_protocol != IPPROTO_TCP) ||
>      (sk->sk_family != AF_INET &&
>       sk->sk_family != AF_INET6)) {

I think this should be mostly aligned with what is supported in the bpf 
reuseport_array and sock_map. This can be changed if other sock supported is 
added to the bpf map.

> err = -ENOTSUPP;
> goto err_prog_put;
> }

