Return-Path: <netdev+bounces-141677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A19BC028
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D621C20D73
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED411FA278;
	Mon,  4 Nov 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9GjRT1V"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6A70816
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756015; cv=none; b=LBEoo/CiU7Vf+rhQWybyPs5O73pYquZ0WmCO0Sk5BAyR/xNlRhPiyxdE2b9nwxJMohDpXtEk2PO2IIDQ+OElwsedWvkIDSQbX/69QhBTZuI9dH/7YArJwM/ToWbN7QabIsKk1GJulMd7il0geACOz6boc2MdkgTfligBckavyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756015; c=relaxed/simple;
	bh=vfeLNUPzwPOEva320f6J4B7HvufepFlF9GWnSPUtgLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1ns/6f4d2+QsDKQSbLBQdS6HDSZYQq0OoukVfzDFqnO8/oulwZSsGlv7SCockPUNACyBjTDIa1NziUJ+ZGLShNC9TmaglVjUU83xHELuOO4wNkPXEYRPqmlA2wyWsAsC3EFR9K/Y3HNwW6DKIblqzZcQMyBRd8Isja7dZ7s5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9GjRT1V; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730756010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pC9hgER1+nxJehzeQYmJEgJ+Kh/FdIGxW22i1KP6Q=;
	b=Q9GjRT1VLyp/DStztlmnZpo2XONGDwD5sQFq7CBIIeJQ8uGenbnNNlK1L1F4TuN/wl+aq0
	A2IUjzB0MgV2G3hZ6ePG2a0C/RJYEMEYs4zbHp98Ep0EwKJtZU50cz6dzL3NkxH6hIAhm8
	Gdlx/sp+iWrcx2CuFTvLAslfgHA7n2A=
Date: Mon, 4 Nov 2024 21:33:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/11/2024 20:26, Alexandre Ferrieux wrote:
> On 04/11/2024 18:00, Pedro Tammela wrote:
>>>
>>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>
>> SoB does not match sender, probably missing 'From:' tag
> 
> Due to dumb administrativia at my organization, I am compelled to post from my
> personal gmail accout in order for my posts to be acceptable on this mailing
> list; while I'd like to keep my official address in commit logs. Is it possible ?

Yes, it's possible, the author of commit in your local git should use
email account of company, then git format-patch will generate proper header.

>> Also, this seems to deserve a 'Fixes:' tag as well
> 
> This would be the initial commit:
> 
>   ^1da177e4c3f4 (Linus Torvalds           2005-04-16 15:20:36 -0700   19)
> 
> Is that what you mean ?
> 

you can add
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

>> 'static inline' is discouraged in .c files
> 
> Why ?
> 
> It could have been a local macro, but an inline has (a bit) better type
> checking. And I didn't want to add it to a .h that is included by many other
> unrelated components, as it makes no sense to them. So, what is the recommendation ?

Either move it to some local header file, or use 'static u32 
handle2id(u32 h)'
and let compiler decide whether to include it or not. But in either
cases use u32 as types to be consistent with other types in the
functions you modify.



