Return-Path: <netdev+bounces-65388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991EB83A4F0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AC91F23387
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885417BBA;
	Wed, 24 Jan 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2pBuAw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9117BB5
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087479; cv=none; b=bhhOanLXj2Grlo8uxsaVWUjiRh910RYA+Df5/dspFyoJeIkGI7bGx7IW9il224dMDjO93sFYIY5eZzXxsoSHjK6wt3mFrpYurABzn+mRHstxehIFs/a7alQfxzH/RRvl99Mh5I0MCF5zxM91lUa4LXHc5d5ejl7FqteJyEEE8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087479; c=relaxed/simple;
	bh=9VGADBg2rk9fBxxcm/OMGHk9Zz+UDqkgETRFSqOnxzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um+RHhFxeRSLkskhMhtl/VJ7fXFKtaZhQbFiCL4vlgul9aKF7VzqpmiWVxfa4yQPYRiEG+GzKPceceTV0VDzSS3tFV9OuAx5m09b8V0pKmwwugMc/4USwYNLY5kxhuLlnVoCNxMldlq4m6ol7EVJZQo7151piZl+7YfjGqX+9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2pBuAw3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33922d2cb92so4629436f8f.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706087476; x=1706692276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xExOFXYHp9oFZy3D2ue/Dkdid2DJ1Tpm/C/gQxBNuaA=;
        b=j2pBuAw3frZ/OxTvrYPG24V04OYgH4tDUKwPPRJHHF2NeGUFRYWCNN0jxhR5z22CjD
         FbtgdNgYTPz4Q6SAWJlRCMMJriYELQVI/iXiP/v2Y3cL1QM0/Kol5xgkrnWFN4EKR0QY
         +0ONFQmbF+JKSAzYoFhOIw+8joRJQbFqcJv8NoUCQOIdrTo6HHFDuqLTY6CISpnX+DKx
         dAwtgHpeuee/TUrYhCXRVLBn1nR3c6woxDKDNtFX7nx1+jCYtj0DyBZkqHzZQoAgxyr3
         aCIl3PNSi0ZcQdSIPL+e99t3+r0uoxpknxmHbrz7uJpIf08LUL/OI6gUK84vMZJKHal6
         CbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087476; x=1706692276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xExOFXYHp9oFZy3D2ue/Dkdid2DJ1Tpm/C/gQxBNuaA=;
        b=rrOKTcYQu/FS2bXAz49J7bQyVgWgIoAiRJwLnimNh5fUABgvJ1pzVfAQXE4Amf9L2B
         1GbWbacn9ThcEa6Yrsoc12pGlZtZCeuxoH6raMs+D/pEFouNZ7htkZobUqTjxxOXrvGs
         bF6fFpZcBvIJfR0S6ZXWmMpgRHWT+TT3fu6Q2wErXgr+ldyg//3XlmiaqZD5JpYc22aI
         +HQoen5VezEm+RDtDN1FbkGM2TXlrdAVe964qYiCZdTVk6sJkr84gU+XTr1ZE6DNmF9w
         j/wuKrVg+qbreTkkTD8OTXuo/w4pZH49GSA5cXb9g06rjLSOTnJ28KjXRqf6pcVSpMK4
         8A8A==
X-Gm-Message-State: AOJu0YxlRbzXvmEKzXMGEVsDMr7odtNcHjSCa0ZSXt54N6PPnELapNUc
	5t14F2v0VGB0nesGZ5fNcx0MINOM7PjR/CU5DOvbG48nhgz6fjZ7
X-Google-Smtp-Source: AGHT+IGSNI4SICpkIYJzMmJu7XnrOmm9ruA+XmlTgnfIxDlf/vB7/jCshKwpZWwkRaJIAFcYXGgBgg==
X-Received: by 2002:adf:ef12:0:b0:337:bb11:53d7 with SMTP id e18-20020adfef12000000b00337bb1153d7mr181560wro.39.1706087475594;
        Wed, 24 Jan 2024 01:11:15 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d594b000000b003392bbeeed3sm9848836wri.47.2024.01.24.01.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:11:15 -0800 (PST)
Message-ID: <17795933-a5ca-44c6-be4c-58ed2e573aff@gmail.com>
Date: Wed, 24 Jan 2024 10:12:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tools: ynl: add encoding support for
 'sub-message' to ynl
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
 <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
 <m2v87kxam1.fsf@gmail.com>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <m2v87kxam1.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 17:44, Donald Hunter wrote:
> Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:
>
>> Add encoding support for 'sub-message' attribute and for resolving
>> sub-message selectors at different nesting level from the key
>> attribute.
> I think the relevant patches in my series are:
>
> https://lore.kernel.org/netdev/20240123160538.172-3-donald.hunter@gmail.com/T/#u
> https://lore.kernel.org/netdev/20240123160538.172-5-donald.hunter@gmail.com/T/#u
I really like your idea of using ChainMap, I think it's better than mine and more concise.
>> Also, add encoding support for multi-attr attributes.
> This would be better as a separate patch since it is unrelated to the
> other changes.
You mean as a separate patch in this patchset or as an entirely new patch?
>> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
>> ---
>>  tools/net/ynl/lib/ynl.py | 54 +++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>> index 1e10512b2117..f8c56944f7e7 100644
>> --- a/tools/net/ynl/lib/ynl.py
>> +++ b/tools/net/ynl/lib/ynl.py
>> @@ -449,7 +449,7 @@ class YnlFamily(SpecFamily):
>>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>>                               mcast_id)
>>  
>> -    def _add_attr(self, space, name, value):
>> +    def _add_attr(self, space, name, value, vals):
>>          try:
>>              attr = self.attr_sets[space][name]
>>          except KeyError:
>> @@ -458,8 +458,13 @@ class YnlFamily(SpecFamily):
>>          if attr["type"] == 'nest':
>>              nl_type |= Netlink.NLA_F_NESTED
>>              attr_payload = b''
>> -            for subname, subvalue in value.items():
>> -                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
>> +            # Check if it's a list of values (i.e. it contains multi-attr elements)
>> +            for subname, subvalue in (
>> +                ((k, v) for item in value for k, v in item.items())
>> +                if isinstance(value, list)
>> +                else value.items()
>> +            ):
>> +                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
> Should really check whether multi-attr is true in the spec before
> processing the json input as a list of values.
Yes, you're right. Maybe I could resend this on top of your changes, what do you think?


