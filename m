Return-Path: <netdev+bounces-186048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAFA9CE65
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DD917721E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3231A3152;
	Fri, 25 Apr 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kLEeiQJI"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA21A315C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599265; cv=none; b=GX6I68H131cwyQrSLKxohV7Qj9ideodADI/3MP0GYL6QpEIJf22Iqaaj4eVPve948KCUhQz60EIHWKgyjXdJXuiz+9xJXm9eJ4xjg25O5Vzgw2YLvTtxjw1JuQZwnbDBVA3+QLtYSAPcif+Jk99nZwC1ws63vQKA0FdQagK8W84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599265; c=relaxed/simple;
	bh=vethVVunbe1Q5SQCylYzutdqWco+Ngv8Xi7v6r+iMZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEz830B9idBgFmmvf/tpDj+aWkpx9K6zsi8ZZ8ZADX8AZQBr2n8AIGVoBv+i5rJ5s8X94lMfTM9Fn83RqLfsfmjdf4v8BfNaZx8qWtm/idUhAeGxjWEanyLqMfsYPwu1qUM9FZ7f0zYvxjFZKq4t5IfHBA/geF5QCnU+/i4Qf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kLEeiQJI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81fc481c-5421-42ad-a13a-b9e9c6ededb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745599258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHSrpe12Y1pxiw8ELGseS+nSJC0BYehyKGWYkJrVVkU=;
	b=kLEeiQJI+lSVpNE+MujsvDmdOvFr+GTsmzeNP/ArvocV6l9t6cL8/aSF2dIfE2+q+ou+Cs
	x9TRK1jwO9Iouhdtqu4fUk+7tfOU5SJ7DWlS2Qj39um3BiI7NEow+q4+KhM106ur7WHTdc
	zDCqpaWIIDBxHfq3Dn+4NyvM2+5YDQ4=
Date: Fri, 25 Apr 2025 09:40:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250423235115.1885611-1-jordan@jrife.io>
 <20250423235115.1885611-3-jordan@jrife.io>
 <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>
 <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 8:39 AM, Jordan Rife wrote:
>> It looks like overdesign.
>> I think it would be much simpler to do GFP_USER once,
> 
> Martin expressed a preference for retrying GFP_USER, so I'll let him
> chime in here, but I'm fine the simpler approach. There were some
> concerns about maximizing the chances that allocation succeeds, but
> this situation should be be rare anyway, so yeah retries are probably
> overkill.

No strong opinion on how many retries on GFP_USER, so no objection on trying 
GFP_USER only once and then retry one last time with GFP_NOWAIT|__GFP_NOWARN.

> 
>> grab the lock and follow with GFP_NOWAIT|__GFP_NOWARN.
>> GFP_ATOMIC will deplete memory reserves.
>> bpf iterator is certainly not a critical operation, so use GFP_NOWAIT.
> 
> Yeah, GFP_NOWAIT makes sense. Will do.
> 
> Jordan


