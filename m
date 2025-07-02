Return-Path: <netdev+bounces-203228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34AFAF0D82
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ABD4A7572
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9123505F;
	Wed,  2 Jul 2025 08:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7B199FAB;
	Wed,  2 Jul 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443841; cv=none; b=CKAB4sGbA5L8SRVT2LmlfDalDEhUaJCdgKEP8vTITgxDRZ+zDU5jSxwlNfwaqtHGRBzCc+hH+jrULVJL6iaPGYESZyIbK8ov1tdOuZ8ibANrctSXzG1m9Xph1Jrh2cOd7Amvcx4gUmR4uvU+GlPqL7YS2KznONfYZCcAqMZz3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443841; c=relaxed/simple;
	bh=IYdvsYFoOUmuWzYIFan9Coo0HGpRMXkdIvOtm1XmZtI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sBMjh84L8rWnp7Qhf3S0aogMHZkwCG0w6CQ1UyU/vLywwRYdwdIO0AotgG2QTBtW6J6Es+Joo+VWe14BBM7vxv4/oHSpBd+g4i7cBhpEUgQNFmLW08rNycAdPoh4dw1FLZNK5DtZvXN+1N8OKLnO3GXoAmj2ifDXBPWR/Phev0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-453643020bdso56211425e9.1;
        Wed, 02 Jul 2025 01:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443835; x=1752048635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4qNZUHHOq7vIov1oUqkCmQg1k5Vs9lKcvLglpbvPJE=;
        b=QUOgfC92I2+RhyAo03TZqW5moBRrBev+K1j7/uPHwZJZ99MjqrVPqW2LBSzb0qXyY0
         dQFX/kx5/4+AzuGt17UMefXCPojxgpPQkpHpyrf+q0qgdlMlyJW5ftq3RhrQnxcd+3OQ
         H0nQ76T6fxpP54+UVNycXio6B3NJt+fJgyXtRUXd+4TJCx8YT96V/App/oQHlCDv/FcW
         UPJ/En3IC0aVY1tMa0HR/EDNBE9H9mn4wkCys5kSL8FCA0JtBc/FxS4RYua4JPJyQf3l
         iCQ6bsW9HCg4Lus04Ozlz2xvaaeP72V6/jyzDuX7Thn0vTloAdSPW0qJPV+u12KeGVUp
         x+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMnqkeAx0Ke/4ZFY1ylgsG/7ZRaHxrN4ipcTQEprXbH9aJogg9N9TPqDmRhwRWG2ucDR72/U6F@vger.kernel.org, AJvYcCWQI1fUcy9KYKRiu3CLsgftbEJs8Nr5SiryIOq2+8rH+W1/nU/ks+9zSgWFpivU7o+I1B2Jcvlh7Q0hFNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lgb7WRB/OzZ3Ol2ouDg6jFNbwIrGfOUzZmQHdPmnXnMn9ZfS
	0nnc5UUQ8SmX3Qn7Eq1YBW879ikE+sCQ+afr4xj3JX9nxKqitkEb2B/U
X-Gm-Gg: ASbGnct6V5vJ5be6lxyHWcabVgdO27axB3VksgUmkK6mfyHZI5NMh3UBhldDZq2cjpY
	PZJayFqUN8V+8PK3c4usT2Gr1rEoz2OqxJ7T5dqEwJZVmxz5biFuZucfQwUZCZSMl1MaIU7h/Tp
	0jPEkXoWO7ixBrl4tNjBoZhJS/BjXrcdXTO6YbDW63qiQ6Rw6s1BJWxf/BgtGCgExjvDCXEVri7
	1i7Agp6fgRZOopnnWIaRExL31NNqJFRJqYNP+ql49js+olngy9lWXHt0RHjdUMfA/rj6g36kRaB
	DLTx3rLzizRFKX7qEvcWKDLSvAMXbJr/+MnY6lfPzKk1BnUEHOU6dtXNsnzXLv0Uu6ePEd2epPQ
	L3ZV9Y3xYm47Qn2NDoqnwckNwCGF+Oyw=
X-Google-Smtp-Source: AGHT+IGbHZ0eATGm/cLpijHlH7XRGb1emK4wOWRsjwB6YvW8gqEFhowwHkPbKbDFQ67cgFgAZjE4oA==
X-Received: by 2002:a05:600c:3b01:b0:453:99f:b1b0 with SMTP id 5b1f17b1804b1-454a3706e45mr17164755e9.20.1751443835437;
        Wed, 02 Jul 2025 01:10:35 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz. [78.80.97.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453b35349f0sm32966705e9.1.2025.07.02.01.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 01:10:34 -0700 (PDT)
Message-ID: <1040d742-35b3-443d-bcb4-5df0eeb42f93@ovn.org>
Date: Wed, 2 Jul 2025 10:10:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: allow providing upcall pid for
 the 'execute' command
To: Jakub Kicinski <kuba@kernel.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
 <20250701192136.6b8f9569@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250701192136.6b8f9569@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 4:21 AM, Jakub Kicinski wrote:
> On Sat, 28 Jun 2025 00:01:33 +0200 Ilya Maximets wrote:
>> @@ -616,6 +618,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>>  	struct sw_flow_actions *sf_acts;
>>  	struct datapath *dp;
>>  	struct vport *input_vport;
>> +	u32 upcall_pid = 0;
>>  	u16 mru = 0;
>>  	u64 hash;
>>  	int len;
>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>>  			       !!(hash & OVS_PACKET_HASH_L4_BIT));
>>  	}
>>  
>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
>> +		upcall_pid = nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
>> +	OVS_CB(packet)->upcall_pid = upcall_pid;
> 
> sorry for a late nit:
> 
> 	OVS_CB(packet)->upcall_pid =
> 		nla_get_u32_default(a[OVS_PACKET_ATTR_UPCALL_PID], 0);
> 
> ?

No worries.  I was actually looking for ways to collapse this
block, but somehow missed these "new" accessors.  I'll send a
v2 a bit later today in case there will be no further feedback.

Best regards, Ilya Maximets.

