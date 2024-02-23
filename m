Return-Path: <netdev+bounces-74315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE26860DE0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3131C21664
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E81AAA9;
	Fri, 23 Feb 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfGiMo5S"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A717BAC
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680162; cv=none; b=u3WdKvVkjI9hvPJpxNbcx6KtQF2tq9/58pAN8zxg51xzXFCzFdsBDMVaPyobyoejD0rHwW3sPRttQy9grJfgC/5cMCPGK9KbGwWtq5DjkIINU2pQosfN/tPKSZ0v2tKOIwVgzHVGzJKXOtxwZNYKCklN2varnPwQdmhcNaKWjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680162; c=relaxed/simple;
	bh=PqLyVPUfpt2QbTP/JwRoCBrUNo2i/vGnuAtfDQIbg3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6FW0bWextXYpEjiHy8xiPCGSn1BedNw7jds3D6u2LTbzlacj4nOGIpQupuA3Jix8YZOOgk2PQwANsS15NIQxE2kNi+Xyn8b3I5K4CIYVzskE78Or3EvJb+GXUFRrfa/70cdc0G39GMFXNAvQXaYs9itxjQ0boHemylz17zNblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfGiMo5S; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7be440bb-9be5-4565-bb24-48328548e909@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708680157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+M7SJtc6GFtxfLOMHR4gW99wDA6CUxO2dV7KXT73i4=;
	b=YfGiMo5SRMlT5fuplYL9MysapLcfRLd0oog1jFahqxzHCGBnODFa9/LqSdDvtpFmOFtBJP
	2Ijy9WjuDAkZ1wNxSSr4BMae1sm8/sE1+BVzo5i5CDfbUOy3HsnsdFKwG/kwh5S7LnBP+4
	xB514hiVjMf4jSwaTyX6ofbnw8aPqDc=
Date: Fri, 23 Feb 2024 09:22:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: amritha.nambiar@intel.com, davem@davemloft.net, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, danielj@nvidia.com, mst@redhat.com,
 michael.chan@broadcom.com
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
 <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
 <20240222174407.5949cf90@kernel.org> <Zdgf3EkGEWRfOjq5@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <Zdgf3EkGEWRfOjq5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/02/2024 04:32, Stanislav Fomichev wrote:
> On 02/22, Jakub Kicinski wrote:
>> On Thu, 22 Feb 2024 16:29:08 -0800 Nambiar, Amritha wrote:
>>> Thanks, this almost has all the bits to also lookup stats for a single
>>> queue with --do stats-get with a queue id and type.
>>
>> We could without the projection. The projection (BTW not a great name,
>> couldn't come up with a better one.. split? dis-aggregation? view?
>> un-grouping?) "splits" a single object (netdev stats) across components
> 
> How about "scope" ? Device scope. Queue scope.
> 

"scope" or "view" looks better, WDYT?

>> (queues). I was wondering if at some point we may add another
>> projection, splitting a queue. And then a queue+id+projection would
>> actually have to return multiple objects. So maybe it's more consistent
>> to just not support do at all for this op, and only support dump?
>>
>> We can support filtered dump on ifindex + queue id + type, and expect
>> it to return one object for now.
>>
>> Not 100% sure so I went with the "keep it simple, we can add more later"
>> approach.


