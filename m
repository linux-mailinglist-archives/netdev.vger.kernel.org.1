Return-Path: <netdev+bounces-77962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FD873A0B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99AA28C0AA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1180130AC6;
	Wed,  6 Mar 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BynJ7Ks1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52912F5B8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737273; cv=none; b=JRcsM9TaqtyQa8S/jdKnaH9hWDQw0hQSKX9InlgBIv+czGkFg3fH5bY4wWdkrVU2FS4EB0S6bgtKeDIWfqAi0ebNDR5Kjg3K6oHfPKHYCh/Ogkuqr1bogPt11av9E4qsSYR9vzBP8tBJLDgxt+Zf9MawmFHk3C/zqrhnyK8e1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737273; c=relaxed/simple;
	bh=fzhJ3zEm7N6KmqTe5OsTWhyA853Moyqgh4+h90ivVYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOv6wLahMQOTV4drBhEltsBs8l2qW17+seupaZJgF6nPd0Ah2/pqZSVoGBOIytQAJJ/46RxoQ3T6FJNvg6d4fArPyAVO8Ef+j/kKa2B9BfPU0mLWk56nr6I3uWF8gxc/4yTpInzjBZbkCX/zW4ryYtgjEn5Ghcq/JQKogo5CSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BynJ7Ks1; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28051376eso95766321fa.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709737269; x=1710342069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYMi8hEQlqLV2JsV242VClBYp0K6b0p4jK2VB1kOiM=;
        b=BynJ7Ks13GXXuHs0u/T6jvm++s0we/xUd+wZlBrSo9o4yh5WmmdRoLeGPNZxlxFGe4
         VfK7KfSzlY1X9+FUG1LEJ4iuuoH2bOiu8jDXZmwQWS5dq4a09TTQzWI7rxdR5MGTxq+q
         lTo9n8Uhn5BGLmKZ6kNvITQ1Rnw+EA9WSgE43V8lVsF+4fsK+TjJ/Ey8sKI16UI5gi0X
         spGfdYy+FbsjmQI7Kkxl9YAdc1N8rmC98qZ4+q4OQxKe1+b57Vm3ZzwlFAXgW5hdPrel
         3AM1E9x4dBeJ92a3ICunXDQefNmhL0VGtIKlymmwFX3qczUcd+c4ZPFAF2lMDXl38GPR
         Fj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737269; x=1710342069;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApYMi8hEQlqLV2JsV242VClBYp0K6b0p4jK2VB1kOiM=;
        b=WjvZYP9dJz58rlWag7AlTT7KKQHHD26VTs7H1DrnGynO62krfBmvsLVUX023f+ta/W
         XUVcglJ5qGqb03BaSw872fPYSSwbrKTdyx3Xj5zzRw9vsrATcD0aXUARsv5OvBaQ4qXK
         NLrW1VlxshFYXWzqjaACavJLtxq9veD21/Njh5VqvuwW64GELI6LvWsdvGVC/dG4D73u
         Ey+QNIxH+02ZhFfn/xhDEIJO+ASWvaC7bcNc8RmPPSVbi6TLBZ2t8zUFtn9JELZNTpTx
         cLSgBnjzD7e00nz352An/xeOxhiY5Y5R+IHYAZZ3evhy11KOvATJmOtckbzeiGMxmkIu
         QKIA==
X-Gm-Message-State: AOJu0YxtT/wZt0YwATUGXkNXfSq2nVpH0HC42amYmfTcaziOmiJk/vVG
	Pt4gVMc3Ph5Usf7DD5NrX8AQt2vJQ9CYB9Vll+P0tJNDjIvZYGXtVTkns0xpEB1XrZ15Ah4ybix
	C
X-Google-Smtp-Source: AGHT+IHD/DhI/2jD8izhiWWCe+9N8pYDmTduvAjYIWNtDRdFL1ANS4gkwL2pjAuAPit+S0+jqevqjg==
X-Received: by 2002:a2e:97c2:0:b0:2d3:e236:ddc2 with SMTP id m2-20020a2e97c2000000b002d3e236ddc2mr3572938ljj.30.1709737269411;
        Wed, 06 Mar 2024 07:01:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b00567fa27e75fsm399771edb.32.2024.03.06.07.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:01:08 -0800 (PST)
Message-ID: <4506c981-0d60-4fee-a066-f1e7be57274b@openvpn.net>
Date: Wed, 6 Mar 2024 16:01:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/22] ovpn: implement interface
 creation/destruction via netlink
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-6-antonio@openvpn.net>
 <20240305145147.GI2357@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240305145147.GI2357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 15:51, Simon Horman wrote:
> On Mon, Mar 04, 2024 at 04:08:56PM +0100, Antonio Quartulli wrote:
>> Allow userspace to create and destroy an interface using netlink
>> commands.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 2e855ce145e7..02b41034f615 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
>>   		dev_put(ovpn->dev);
>>   }
>>   
>> +static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	enum ovpn_mode mode = OVPN_MODE_P2P;
>> +	struct net_device *dev;
>> +	char *ifname;
>> +	int ret;
>> +
>> +	if (!info->attrs[OVPN_A_IFNAME])
>> +		return -EINVAL;
>> +
>> +	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
>> +
>> +	if (info->attrs[OVPN_A_MODE]) {
>> +		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
>> +		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
>> +			   mode);
> 
> nit: dev is uninitialised here.
> 
>> +	}
>> +
>> +	ret = ovpn_iface_create(ifname, mode, genl_info_net(info));
>> +	if (ret < 0)
>> +		netdev_dbg(dev, "error while creating interface %s: %d\n", ifname, ret);
> 
> And here.
> 
> Flagged by Smatch.

Thanks for reporting these.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

