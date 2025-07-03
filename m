Return-Path: <netdev+bounces-203710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C415AAF6D2B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1761C22849
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05B2D2386;
	Thu,  3 Jul 2025 08:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B32D1F45;
	Thu,  3 Jul 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531935; cv=none; b=FaaUQXBezrO1WKEiJflVpW8L9jga19BtAFBIPQnRs+Pg34lwsqR55tNYVXJT4eJG9I/koWUnoI+u76T8Xof0vEQMnpDTvTO80dIHI5v6+di/HaBeYeHKgodk1TmEAbSy2ithy08ayk0dxzgfQElUDhDRS8jJLoiQWejgDtsMYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531935; c=relaxed/simple;
	bh=TDWtO36xCApLJGHjYfNDmkWqDXAf1lfae4hLzZVvAgI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mODk/8u7rV3irojwvWYIIBaq+ZW+PR0WyamcZeHU3IHBBaJ0lIWaavKJpBtg8b775j9m0IW8OxIUM40XoZtTF/uXdd1h16SQmU731rc81Di4bfDcW6EhK0azNl/TNWlgYMIQu56U/fdBMAzINiMApY7Y1U81n54zaOQ9zn64ZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-454ac069223so2028285e9.1;
        Thu, 03 Jul 2025 01:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531932; x=1752136732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlry0P/PddBF7z9fvMBWRavm2Ir6vmKfUW08If9YO5w=;
        b=T7E95lZcS3qGeWBB0iSr/qpNgIgrBUzagztZJxQWW9DUrpP+tbP9JcUUNo+QzxddFB
         1U+kNJQehB8vX6tuDK4CCHAFVQDuH/5aKWqg429nj2+Vo78eWoG79A3xMd6tl8faQ2k8
         q/z29v3M0N+K2BD1GwfRHoe5ylH3if7DjR9bwPDQTFV7eg+dyQ5UF+XR730RMflUBNs/
         3AAMrgq+WlWEQpXlo0yBcGjsHOvMbGWN0UiZdbcMDxm6L2b812xYSCxMDRbg+UVW4VXy
         PboXboXCw6p1r9nFHggO4juTjQJm175gZmTbNqfQzmChMDM9/BWT+uIFS7oohFE5jPj0
         S3zA==
X-Forwarded-Encrypted: i=1; AJvYcCV+UbLmjloSWoFHLZUO9Zq7HQqJjKIkTsN/mPEvAtxCQb8o4LVGysuzVUKLmKgrqmnqmG7j8NO5@vger.kernel.org, AJvYcCVZporJloyfrGCmbFTxnXFb1HYBuK7FRkt0n2YlR4LWR4x2nzx1kflyztboJ9Hk1eqhLrQWWpc8uUagb+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5Z5UyPMN7b1GPh2uSg1fAt4KaJOPk1gCFSzaJ+yQ5uk+DoUx
	8RWyvsLiJquCV/7s6meAJ/DIVYdBVS85uEeD8AgASWo4iMZXhsoOypbi
X-Gm-Gg: ASbGncuswXHZ2CJboxhtEPTzKBC5a9wC8X8cq15PD0gAIk7zZ0BzXXM8UoO4dpmtd1e
	dYOUKZFNGYqMnunQxQ2PLzeAxuGQZ9l1xXDM2riftNn3lVCRvsy8WSIGVMikhUJAPAmxxe+x0ew
	bx7a5UaF8W32MNV8A2zGlRx7INRASLP+5l9J4sYkYSOwycEZjhgT/ROmXpUuvZz+PmjhakNiLHu
	o45zG8Vw4fNUk7nSuVURlwa/ujh3LlFXUO/INzmK8yqsliBNJH3vFvJYmELQ6OGqNkRnSOmUCIi
	f+FEWid17Gi/PwQ+24TunmtxBLajDuGPd0QtnH5X62x/Xyfg5vJ54dudB0dm3ROZnwovels2A0t
	GETxY+2R4evmPCpY=
X-Google-Smtp-Source: AGHT+IF6NXYnWwX+LpF6525ZA4+YuOAQlaWJhsEKO1vvXGxCBbEeUZdE6UC5ZqiOPsIPuMWi0Z+9GQ==
X-Received: by 2002:a05:600c:a304:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-454ab34ba80mr16504065e9.13.1751531931608;
        Thu, 03 Jul 2025 01:38:51 -0700 (PDT)
Received: from [192.168.88.252] (89-24-56-28.nat.epc.tmcz.cz. [89.24.56.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bcebd4sm20054065e9.26.2025.07.03.01.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:38:50 -0700 (PDT)
Message-ID: <5c0e9359-6bdd-4d49-b427-8fd1e8802b7c@ovn.org>
Date: Thu, 3 Jul 2025 10:38:49 +0200
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
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250702200821.3119cb6c@uranium>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 1:08 AM, Flavio Leitner wrote:
>>>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
>>>> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
>>>>  	}
>>>>  
>>>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
>>>> +		upcall_pid =
>>>> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
>>>> +	OVS_CB(packet)->upcall_pid = upcall_pid;
> 
> Since this is coming from userspace, does it make sense to check if the
> upcall_pid is one of the pids in the dp->upcall_portids array?

Not really.  IMO, this would be an unnecessary artificial restriction.
We're not concerned about security here since OVS_PACKET_CMD_EXECUTE
requires the same privileges as the OVS_DP_CMD_NEW or the
OVS_DP_CMD_SET.

Best regards, Ilya Maximets.

