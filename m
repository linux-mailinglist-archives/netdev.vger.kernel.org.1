Return-Path: <netdev+bounces-134170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07138998428
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37381F251F6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4C1C0DF5;
	Thu, 10 Oct 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AebrzCPf"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45B1BF324
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557397; cv=none; b=ODwh0UcdZXAWJZM1IWSh4ZHGQ3ipsjssDH6hPcW2RR3i99hqvMrUczgZ7+vNSgmYbxJSGJJt1x1HDX3/RhOYTuAENWEJLv4tbr03jdV+v8TXOkkxJ7LgnUaFWKe/9lor2JYJndqeVS5Z5QlSDSywW7/1mzEazg+CWjf7HMU/fBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557397; c=relaxed/simple;
	bh=6sltPCctqp/rgFvuEOg+Gc/PbM1E2Qc2T+qn4Ng46/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiPL0G3pGdIjhSwV8hZMerJcRxfWm4eLsPwWDeb+AOE61hLoocH8e0F8YBqOzQ/D83WmyJ8N8+lyxxXQZr45Dd1F54t2OlPUI3gHNJ7dHjh7ElE9rBGgdOodyPowttf54SPWClvvT7dUIo7PKhrKUi9T0wn/YsFrXGtck6sOKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AebrzCPf; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <759dbb55-cc60-439e-9f7b-c04554e565dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728557392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZKpejyRJLsRI3Ek9KAxnGR+knVDecb2X75ZnWnqBnU=;
	b=AebrzCPfZrwfs8/QpVmYzvtMd7ugC9iOO7pv8iOaWbFFcoa/3zVnPOW+XvSW46WTheEcSk
	TXFmh6QfY6YK2jrXRlEjpNLe8lpe4RcdSH/I823t8FR2yA7D7RA1L8v7NoSeqLkdN/fFWD
	b7fn6uuPTPv7W4y9F8FG+2Z12NCySl0=
Date: Thu, 10 Oct 2024 11:49:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/5] eth: fbnic: add software TX timestamping
 support
To: Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadfed@meta.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
 <20241008181436.4120604-2-vadfed@meta.com>
 <d4413c7d-7c7a-413c-a75d-de876ccf6e09@redhat.com>
 <3f190185-4143-4a0f-af36-eab2ecbfe670@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <3f190185-4143-4a0f-af36-eab2ecbfe670@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/10/2024 11:38, Paolo Abeni wrote:
> On 10/10/24 12:18, Paolo Abeni wrote:
>> On 10/8/24 20:14, Vadim Fedorenko wrote:
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/ 
>>> drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> index 5d980e178941..ffc773014e0f 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> @@ -6,6 +6,16 @@
>>>    #include "fbnic_netdev.h"
>>>    #include "fbnic_tlv.h"
>>> +static int
>>> +fbnic_get_ts_info(struct net_device *netdev,
>>> +          struct kernel_ethtool_ts_info *tsinfo)
>>> +{
>>> +    tsinfo->so_timestamping =
>>> +        SOF_TIMESTAMPING_TX_SOFTWARE;
>>
>> Only if you need to repost for some other reasons: the above could use a
>> single line.
> 
> Never mind, I see the changes in patch 3 now...

Yep, the next patches will change this line..

