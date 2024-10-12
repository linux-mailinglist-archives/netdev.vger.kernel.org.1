Return-Path: <netdev+bounces-134776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FB99B0C1
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 06:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96829282042
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06050126F2A;
	Sat, 12 Oct 2024 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IdsQhUAm"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E99126C1D
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706442; cv=none; b=VrNKS20W6dHCmyMN8XoKOUyoCW4LRWLXnopZUpg/jRD5dNHndPOf51WrzqroNlWdkbGfzrHaRiMc1svFOBJsIUffiDEFyouEWvavYyWKQiVhCVaqE9KEYVNJWCVywSUDUC6xPTYdYZXMxa4LL8Mm/jbOsBfeTeh+GQh5fth6Jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706442; c=relaxed/simple;
	bh=3/COKabr3s1cIuEZtlXUilPJwGsygzEoIzHq94kqQU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMUpqeJoxkkGssy5jt1PTGu2o5YS0lpkU+UfZvfPtNafBqUtdGw3KrFp/KqCoDLHgiNbfubDMdrR9hvvrZiLMx4K7y/ksp/w7eJSxSx+98Jf8qCurxFMIbFtW6x2Li0j1V3JhRhr97+at1OTyXuEsHnP4lHsEbXF1/JX/3QKuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IdsQhUAm; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f19948a-aaaa-439d-9cad-64ac24d92303@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728706438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HBHKIISatsXE8x6W/JRYxGwyCTjSOKOzYoCqnDFozc=;
	b=IdsQhUAm5UCyIa63RpCfeZZr4qqC7GOQsFHsDF+aULCPyIrKWgaCgxoRkgt4ZiRVYoheQF
	p2L/A6wt8CxPP4Kv1kvMqqBDLqKpPqP5pVqQN6vhLJT0fzOAzkITmDeuLfi7GsdltycZq0
	eV+2NUTPay4ZwnMuqJXphUTtV3rZ4oU=
Date: Fri, 11 Oct 2024 21:13:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, martin.lau@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <a1ecbca9-52c8-4653-a404-961b8e4fc674@linux.dev>
 <20241010173651.68780-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241010173651.68780-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/10/24 10:36 AM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Wed, 9 Oct 2024 22:46:57 -0700
>> On 10/9/24 10:42 AM, Kuniyuki Iwashima wrote:
>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>> index 2c5632d4fddb..23cff5278a64 100644
>>> --- a/net/ipv4/inet_connection_sock.c
>>> +++ b/net/ipv4/inet_connection_sock.c
>>> @@ -1045,12 +1045,13 @@ static bool reqsk_queue_unlink(struct request_sock *req)
>>>    		found = __sk_nulls_del_node_init_rcu(sk);
>>>    		spin_unlock(lock);
>>>    	}
>>> -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
>>> -		reqsk_put(req);
>>> +
>>>    	return found;
>>>    }
>>>    
>>> -bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
>>> +static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
>>> +					struct request_sock *req,
>>> +					bool from_timer)
>>>    {
>>>    	bool unlinked = reqsk_queue_unlink(req);
>>>    
>>> @@ -1058,8 +1059,17 @@ bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
>>>    		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
>>>    		reqsk_put(req);
>>>    	}
>>> +
>>> +	if (!from_timer && timer_delete_sync(&req->rsk_timer))
>>
>> timer_delete_sync() is now done after the above reqsk_queue_removed().
>> The reqsk_timer_handler() may do the "req->num_timeout++" while the above
>> reqsk_queue_removed() needs to check for req->num_timeout. Would it race?
> 
> Ah thanks!
> I moved it for better @unlinked access, but will move above.
> 
> Btw, do you have any hint why the connection was processed on a different
> cpu, not one where reqsk timer was pinned ?

Just saw this after replying on v1. I don't know what exactly caused this. I am 
only aware we have a recent steering test to test different packet steering setup.

[ I had some email client issues, so the reply ordering has been wrong :( ]

