Return-Path: <netdev+bounces-203768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4BAF71E8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B814E54B4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6612E2EFD;
	Thu,  3 Jul 2025 11:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F072E03FF;
	Thu,  3 Jul 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541322; cv=none; b=ObOxbhq2l+AsFQStA0mlrUKChmGDInJ5LkX1mKPyECplranGuUS0QaQsLfuRed1ACKPvdoRyni2GX6RLo9YQaIhN2ft2sO9NA2VsXz2Qx9QM0JbVqpaO1KEP/mSiXfSBCiM556s96x1wNpC2LWiqY6IAVV3yM6bVP9DLI7RpFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541322; c=relaxed/simple;
	bh=a2P1NFsZ45zyW8Eyngw/Ef0J7dSYuVF2LnaGms9ElP0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RlthD2CFDKcZxW3UPArAevl2xYQFjAxkf/tjRQdrVyB2HBGmyyH+PqiLwQ+7TGeQ/NIIEme8nfImSJyd7yLV2Ai8yAePoedaYyOQ0vKjirR8rDTDaTAsSVzxsidhNyhkxVPzCvIQBqeRztBuJ1D6hIJu5vaXymv6GZQx/UZYLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0de1c378fso780344266b.3;
        Thu, 03 Jul 2025 04:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541319; x=1752146119;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhBz/XDu78RFu53NUL9qTdd+x4xhCvqmnXMSLMSDWOk=;
        b=P0Q1h6Aco0k6fznaLzrdRGsVa6ZCUYMMFqcrwh9L6jbxzXcOT5yrKsnt+SlSEJswpL
         NSWUffv9OFGZHWLfk7fCnICWxLDXrJ3dpzJ5oGVwOCfcibmsb/nRr/zRSY4RoHaDXYjo
         dVHndsnAw9aS7x4EUbh8Q8qoEKMZS8M5NTmv5oEq+cezlyt9TVEGUH0D9L8V+vlTOx8c
         BB/1agr7+FuPZUCIlMhYDlq05ZNPPDliAIYQLLl69eF5XmQfqZT+NTHVWo3grFei7o3w
         YEXkkK05eAF9oz/L0JR8Nv6UpGoecd+WjQACrxOr8AvEga7c1fs6Mxhzex6MHMPbYHCo
         7XoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSOvOd4K/Mx76lzyXAYr8cJCi/qf4tMkt9Z6MIztDpmDj713pzNdza3AQ2PTHClmwlCXkDqCAz8r0Nptw=@vger.kernel.org, AJvYcCUW1S3RwbFmJOGEgX/4FOQ7aJDj6xE2yEYHHq0kmoZcv7hr0SsmpNE+9NeKv37J99qHcei1kGd+@vger.kernel.org
X-Gm-Message-State: AOJu0YwCX86ReSilmnOWuHyp9c8tYLm+sl+xa6XEUbYdPK0gHm5nH2J6
	26t/esiFM1f5DonRZXP0fuPWlNAyzv367AMsxYn0EWBKGZGQcqBGNtenLbPivxOP
X-Gm-Gg: ASbGncvtGPECl/vnhDx2TzMgyjXBQLvTT2sa519luqCGLlVL28PS74HgHfO/tjGO68P
	g/88y/w3OLATu6YcJ2NwdgsOUOiLWO03xZv/U3Vb6ODEOG3BkSHA4Me4WldQmExzRdF26fSwYT1
	glVNRoh0FTZoy+5dSu12Na7iYbBWsMlqltyBUewTNIj0J6eYWQIhd0HHawDfGj263JBOo7yG7Wy
	ICn2pJc/CYBIu2S1tCT5TnPCUPeHG9N0NWA53HwM1HD2yyew9MM6wVtF290GwaYcMprm6ZfTV/Q
	NrG5ww7RGzNkz3TKOsSEbePlNHlrASZxcodffxk1XS+312hVkonhiCy8Ov5nHQWWxE/X0omhtqa
	anmAIWjrJ8oqMjTg=
X-Google-Smtp-Source: AGHT+IFlXYHb9El3cIR5LnonKhSlt50cBMiWyQZvmo825lM0WCri8eIymxPQ4JEi6g2vKJYHDVYEqw==
X-Received: by 2002:a17:907:da5:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-ae3d8421867mr287991266b.15.1751541318619;
        Thu, 03 Jul 2025 04:15:18 -0700 (PDT)
Received: from [192.168.88.252] (89-24-56-28.nat.epc.tmcz.cz. [89.24.56.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a732sm1255553666b.65.2025.07.03.04.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 04:15:18 -0700 (PDT)
Message-ID: <1039a336-5f4e-4197-a27d-f91c58aa5104@ovn.org>
Date: Thu, 3 Jul 2025 13:15:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: allow providing
 upcall pid for the 'execute' command
To: Flavio Leitner <fbl@sysclose.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
 <20250702105316.43017482@uranium>
 <00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
 <20250702200821.3119cb6c@uranium>
 <5c0e9359-6bdd-4d49-b427-8fd1e8802b7c@ovn.org>
 <20250703080411.21c45920@uranium>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250703080411.21c45920@uranium>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 1:04 PM, Flavio Leitner wrote:
> On Thu, 3 Jul 2025 10:38:49 +0200
> Ilya Maximets <i.maximets@ovn.org> wrote:
> 
>> On 7/3/25 1:08 AM, Flavio Leitner wrote:
>>>>>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
>>>>>> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
>>>>>>  	}
>>>>>>  
>>>>>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
>>>>>> +		upcall_pid =
>>>>>> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
>>>>>> +	OVS_CB(packet)->upcall_pid = upcall_pid;  
>>>
>>> Since this is coming from userspace, does it make sense to check if the
>>> upcall_pid is one of the pids in the dp->upcall_portids array?  
>>
>> Not really.  IMO, this would be an unnecessary artificial restriction.
>> We're not concerned about security here since OVS_PACKET_CMD_EXECUTE
>> requires the same privileges as the OVS_DP_CMD_NEW or the
>> OVS_DP_CMD_SET.
> 
> What if the userspace is buggy or compromised?
> It seems netlink API will return -ECONNREFUSED and the upcall is dropped.
> Therefore, we would be okay either way, correct?

If the userspace is compromised, it can overwrite the upcall_portids
and do many other things, since the userspace application here has a
CAP_NET_ADMIN.  And if it's buggy, then the packet will be just dropped
on validation or on the upcall, there isn't much difference.

It's a responsibility of the userspace application to make sure these
sockets exist before passing PIDs into the kernel.  From the kernel's
perspective dropping the upcall is completely fine.  So, yes, we should
be OK.

Best regards, Ilya Maximets.

