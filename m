Return-Path: <netdev+bounces-71279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0036852E95
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1811F23BC7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5B2BD1C;
	Tue, 13 Feb 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejTodT8k"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FE2BB1E
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821989; cv=none; b=EbZAd9YWbmZBQFslY2GR/0UHlqnmzj3mwbSOg8er1DDLNaUb6j8v0jll4g4k+onwjsvXjNJAxMtgzAW6jkWXKt3t4vLxQjmVgwVscsWq86uUY2YmJoi6e6pFHj12xBth/TbDHUeUPvMONtBG7fuVRFTUcxga6kkbECYT1SytjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821989; c=relaxed/simple;
	bh=FCh3rfThwSrcd/cICy2U1FJsOYlLOMBpdInVK8P04Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCYTjoDT72GfmkwzXEX8R34q0Cd/NqDBZkIGexbStE25Wg7Tmaa2i/9uyDGkmKxFYPZy418eOBfG5Cq1x7eckzFAts4ng+eqgTF4QDpxp3yx4y60ze+WrN2Nn8Rb8Jrntjkku3lrIK91G8uvY/Qqhf//jbBiS7XLTNw6U/GSEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejTodT8k; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e70cfd35-5114-40d4-b1b4-7a145cc4ce34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707821984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkyJRd3yFvvSirf8vuaIZWoKv5oqHAm5X0GnkkL2/8s=;
	b=ejTodT8kdgMo4LG0gN6H92w2hN3mFLAa4f2ffEZnIkOE7col4MGP4PXqsTolGgDN0P2iTo
	/IVve2dgCcfC68kfJgyYKm0dzLaeF4xdZctEqqvBiZIzcQ/l0bDlhPHyl8/g2de2X0LaLc
	vkvjs4/mczrMbOqj09lU+Ingc3ASCG4=
Date: Tue, 13 Feb 2024 10:59:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net-timestamp: make sk_tskey more predictable in
 error path
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org
References: <20240212001340.1719944-1-vadfed@meta.com>
 <65ca450938c4a_1a1761294e3@willemb.c.googlers.com.notmuch>
 <567a7062-9b4a-42dd-a8da-e60f948a62f0@linux.dev>
 <65cad127de7c3_1b2b61294f6@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <65cad127de7c3_1b2b61294f6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/02/2024 21:17, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 12/02/2024 11:19, Willem de Bruijn wrote:
>>> Vadim Fedorenko wrote:
>>>> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
>>>> the sk_tskey can become unpredictable in case of any error happened
>>>> during sendmsg(). Move increment later in the code and make decrement of
>>>> sk_tskey in error path. This solution is still racy in case of multiple
>>>> threads doing snedmsg() over the very same socket in parallel, but still
>>>> makes error path much more predictable.
>>>>
>>>> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
>>>> Reported-by: Andy Lutomirski <luto@amacapital.net>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>
>>> What is the difference with v1?
>>
>> Ah, sorry, was in a rush.
>>
>> v1 -> v2:
>>    - use local boolean variable instead of checking the same conditions
>> twice.
> 
> No, I meant that the code is exactly the same :)

omg, missing commit changes... will send V3, sorry for the noise

