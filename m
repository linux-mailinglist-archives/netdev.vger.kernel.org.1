Return-Path: <netdev+bounces-132991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D6994209
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C991F27B7E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0C1E9062;
	Tue,  8 Oct 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MFcmo2Rb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2961E885F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374507; cv=none; b=INnwep+Lt4b77g7l5NEvSHXMwPRAnSB8gUNzJ9NyjfQjcAEDsm78LWJoAIQ0mR20ln+s95/8XfeOCM/7PIq+iagPhWE0NpMvr7v0sP8uhu7XANuGAcdnHekIS1SJ0uGVgaS1ZVi5sX0DCFWBiL7HQx3/tsoPD5DtA/cKiEFeINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374507; c=relaxed/simple;
	bh=LZmDz6iNhvMt90dfMzQq3WFtioFDN/yJfqXcR37OWuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avvz97MDd2SZXgQ37CM2qURksBtbQP8/hPcPeCm+2WlciQkVtjuahAkaTkDYeQzA86iPcCqXw1dwmqZM7Eoil4FKLrNQnTVssGj86BWEJXdq/MJwLjl4i4+VpdgomqX9plSpB6USKYFDAUSpMk3kYbDMkbwG9wXtD4YepvNjeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MFcmo2Rb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cc60c9838so3003138f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728374503; x=1728979303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TehQzGqlQ7/A72VhokMvGGbcSaxUL90Hefcysi5X+2c=;
        b=MFcmo2Rba4eNnyClR6GWKCNjp/SNCtzlbe9rJjWztDhbLuBepSQ1YKrJRf2P09lnPM
         XxJ9Tl/C4MdB3T2DR02jXkRV5930AuHQmKovGLfJUpwx8Qifi5+BSSoJyotZbJG4zliZ
         FqWAWtgKt0xXTdKMOL1dZXmWu26EWcvpw8YnpOwPajIxTOo7GmEFJUIkvz7aRETgkxDq
         22ZoHo7NHcp0lqfvfWRn4db74u6W67pkFdA7GIxfTLENyiN3mWyl3xFyK+pmFHaCppE0
         rwicJgfzOwBweuNNj6evDFL4ps4lbjZWYEziRbB1GIzZJxf6el6h5rqHs7jK3uaGoVyy
         Hbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374503; x=1728979303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TehQzGqlQ7/A72VhokMvGGbcSaxUL90Hefcysi5X+2c=;
        b=W3nDgW2HzK32QFl6BTHwUgvT4riPc8HiFzrRuau/tKL308TizuTalOzmtUulNNrAlc
         qmUN+LP7f9J1R39hnXzJGy26k6H4AfhqFUVXroEVa3kueHiNtl9NtW7gBoGJ7lPdk86x
         bLOFQV9xKuywx87Udc7v478+5gl8L//twwPdDe44hCLE9zfjEJzL5gf3I+HPxZLtksI0
         MOd5CRivhYpB02Fgilb/ErLBbBhRkuyXcOwvuPwwNI3zqD5vHu6DDpTHgSDWddF3PRAA
         oKK1Yqr8MsIPQOCsKDipAAP7OFEhpY/GigYzozmjHP+Yzz89zPf+8pjqsIfJxVxdGRVu
         ANdA==
X-Forwarded-Encrypted: i=1; AJvYcCUT9+xiHW0U8NKAC2Gbn8ndzmE9RJeFb2HErnB/Ky5ktrY4Kx3PcUT63xQRzchBFDWEwEbZueo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkHpaSRDKI+LKh3pzzlAtNr4CHMVDBL+jPQyFp4e0B4non34Q
	loFBcx/5FmKW1dLRVbjoEHYi3XJlhURLnsMnIwHEPvs6mgz0ct1lZpSz8dGtuPw=
X-Google-Smtp-Source: AGHT+IH9ziQgmbKEumziF2/Xxptvs0roO67voR7Em/ui/HeZGyfcmtQFejktMLrTRIjO41lNztSXcQ==
X-Received: by 2002:a05:6000:2a0c:b0:37d:3161:12de with SMTP id ffacd0b85a97d-37d316113c0mr748358f8f.23.1728374503502;
        Tue, 08 Oct 2024 01:01:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2089:55b1:87be:76d4? ([2001:67c:2fbc:1:2089:55b1:87be:76d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2ce265fdsm943122f8f.83.2024.10.08.01.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:01:42 -0700 (PDT)
Message-ID: <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
Date: Tue, 8 Oct 2024 10:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
In-Reply-To: <ZwP-_-qawQJIBZnv@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 07/10/24 17:32, Jiri Pirko wrote:
> Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
> 
> [...]
> 
> 
>> +operations:
>> +  list:
>> +    -
>> +      name: dev-new
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Create a new interface of type ovpn
>> +      do:
>> +        request:
>> +          attributes:
>> +            - ifname
>> +            - mode
>> +        reply:
>> +          attributes:
>> +            - ifname
>> +            - ifindex
>> +    -
>> +      name: dev-del
> 
> Why you expose new and del here in ovn specific generic netlink iface?
> Why can't you use the exising RTNL api which is used for creation and
> destruction of other types of devices?

That was my original approach in v1, but it was argued that an ovpn 
interface needs a userspace program to be configured and used in a 
meaningful way, therefore it was decided to concentrate all iface mgmt 
APIs along with the others in the netlink family and to not expose any 
RTNL ops.

However, recently we decided to add a dellink implementation for better 
integration with network namespaces and to allow the user to wipe a 
dangling interface.

In the future we are planning to also add the possibility to create a 
"persistent interface", that is an interface created before launching 
any userspace program and that survives when the latter is stopped.
I can guess this functionality may be better suited for RTNL, but I am 
not sure yet.

@Jiri: do you have any particular opinion why we should use RTNL ops and 
not netlink for creating/destroying interfaces? I feel this is mostly a 
matter of taste, but maybe there are technical reasons we should consider.

Thanks a lot for your contribution.

Regards,


> 
> 
> ip link add [link DEV | parentdev NAME] [ name ] NAME
> 		    [ txqueuelen PACKETS ]
> 		    [ address LLADDR ]
> 		    [ broadcast LLADDR ]
> 		    [ mtu MTU ] [index IDX ]
> 		    [ numtxqueues QUEUE_COUNT ]
> 		    [ numrxqueues QUEUE_COUNT ]
> 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
> 		    type TYPE [ ARGS ]
> 
> ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
> 
> Lots of examples of existing types creation is for example here:
> https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
> 
> 
> 
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete existing interface of type ovpn
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
> 
> [...]

-- 
Antonio Quartulli
OpenVPN Inc.

