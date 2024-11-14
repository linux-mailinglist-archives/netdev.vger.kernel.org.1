Return-Path: <netdev+bounces-144722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6DE9C8490
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587CF281F1D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E01F6669;
	Thu, 14 Nov 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aah1VsOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E921F5846
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571610; cv=none; b=ppplxebA/ffF+DKoIAxjVhFVjhtjWLcGExmZLxrLSMfQhiQIdrWIVeaz4CBk9XfW/euIESnUvVOfM42E9o9I7aiN0EDtyKNnfaHVsuImvrZhPh4jV5uFIVJAlGfL2MaA/h6kLruqaUUyp5m+/W4riYlfxAW0tROTovjDy/PhOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571610; c=relaxed/simple;
	bh=R03XO8IOSVVFaYkaL0RmhVKl4tkSEqMsBWjmeYOwy/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdx4Ubk3Q0FQgu3LSrm44jD+GkdAohqhMw60P3rRjlsOtKjF3MrOXr6DoA4D+BtjbWNcscZVAjpOQ8G/RftMF+I84Z8zOJTR9a96jqCL2ECUdjkmvCKwQToOUSgeY2tQd+2TlzSWhJvK/J6PhuUHuyMjk8UHrHKNreL8reCsC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aah1VsOg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so42412366b.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731571606; x=1732176406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/3rQZK0KKioCoimnvVntQO3wq97Z15vn67PdFpRtyDU=;
        b=aah1VsOgW8Cs/ANlGusXecPhf+3IMyMg7X6f54d3x0XYFRB0BqFBhNrwVik/7KbNZU
         8p0A9AbME5s/T3Jk7jyDoS98cVxiGkOLSpHlluiTFD2kDkvaC2Jr43tx+jzjE2o9M9S0
         Flpxx6QneGsaS4qljYB3MaadRceRpF7J8QdTxwkmZ9O2V8YoU2YK0ERkakHLoMCy1ZgL
         CQbVgUrekk2n0RJdWyoc4Aln/0TF0ZnaUWDFWPm7sZZkGuQOsuPDTOgALZwc6hc8IFT0
         V8IJkJYb+YwPe//j5vjgOR/527lIqT/ZnTzWzCfop8Uu7WKiLwjBEd68jyWTNzthnUYJ
         u+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571606; x=1732176406;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3rQZK0KKioCoimnvVntQO3wq97Z15vn67PdFpRtyDU=;
        b=Grn4IrGQOkCu6B013fkVuwAsxtGb60s3Khe9vcAC1qCnS54fRg94Rup53ETvls0x9W
         L9xasH4X3T+/Uhkc3LmdQe8Nc4PHry/EyDP2SnSAkngiLUH58/1h++d6qKHInrEj+elL
         n1czvPVOCvS3j1AuCKqbuRZ89gQUvS6nSazMc8LZrHYYv7p3svk3j096W3/SnYuNjmLn
         dK23qzin4MJP0TA5jw3RZj5Qt7hhlf/Ei/gA56aJlItCb8+ZUkQQDAUNZ+S1EG6IKiNC
         REulzUub+Vr6T7SZRCb1JY92Q6V/YYEtL/hsS3Cr0cyNBa3gIGtrFx5hidpVc/zTsFaA
         2bQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw2OpSSWxZBAUaE6f55JQKsLHZ/fr/ylv9qKwHFc3XkfeElVDHAOkwGVahpJAMMFwg8SxsUxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuCn1Q1EQ2cda14nzrYOrhd/E8+yb67p0o2twl4Vq5//HQqDG
	57VpCGi1pTjsgus4ZqNi91gOKy0v3Q8rIP0cuYjoa6drHtSEp/tvqlmg+ZFqBOo=
X-Google-Smtp-Source: AGHT+IH2TiT81RziNLKAvCJL/Hw8KEXJesHLo/N+/7ZhKpkSfKqH35uYBSfv5Pru+cDJiL35jpRCPQ==
X-Received: by 2002:a17:907:3d88:b0:a99:ef5d:443e with SMTP id a640c23a62f3a-aa20cd0aa94mr105945666b.13.1731571605894;
        Thu, 14 Nov 2024 00:06:45 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043b84sm32671266b.137.2024.11.14.00.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:06:45 -0800 (PST)
Message-ID: <3da3a4a6-f88d-4b60-be99-42860e1b8b2d@openvpn.net>
Date: Thu, 14 Nov 2024 09:07:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sabrina Dubroca <sd@queasysnail.net>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com> <ZzOGqP9AAGSN2E7y@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzOGqP9AAGSN2E7y@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 17:47, Sabrina Dubroca wrote:
> 2024-11-09, 03:01:21 +0200, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> +/* When the OpenVPN protocol is ran in AEAD mode, use
>>> + * the OpenVPN packet ID as the AEAD nonce:
>>> + *
>>> + *    00000005 521c3b01 4308c041
>>> + *    [seq # ] [  nonce_tail   ]
>>> + *    [     12-byte full IV    ] -> NONCE_SIZE
>>> + *    [4-bytes                   -> NONCE_WIRE_SIZE
>>> + *    on wire]
>>> + */
>>
>> Nice diagram! Can we go futher and define the OpenVPN packet header as a
>> stucture? Referencing the structure instead of using magic sizes and offsets
>> can greatly improve the code readability. Especially when it comes to header
>> construction/parsing in the encryption/decryption code.
>>
>> E.g. define a structures like this:
>>
>> struct ovpn_pkt_hdr {
>>    __be32 op;
>>    __be32 pktid;
>>    u8 auth[];
>> } __attribute__((packed));
>>
>> struct ovpn_aead_iv {
>>    __be32 pktid;
>>    u8 nonce[OVPN_NONCE_TAIL_SIZE];
>> } __attribute__((packed));
> 
> __attribute__((packed)) should not be needed here as the fields in
> both structs look properly aligned, and IIRC using packed can cause
> the compiler to generate worse code.

Agreed. Using packed will make certain architecture read every field 
byte by byte (I remember David M. biting us on this in batman-adv :))

This said, I like the idea of using a struct, but I don't feel confident 
enough to change the code now that we are hitting v12.
This kind of change will be better implemented later and tested 
carefully. (and patches are always welcome! :))

> 
> 
>>> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>>> index 8516c1ccd57a7c7634a538fe3ac16c858f647420..84d294aab20b79b8e9cb9b736a074105c99338f3 100644
>>> --- a/include/uapi/linux/if_link.h
>>> +++ b/include/uapi/linux/if_link.h
>>> @@ -1975,4 +1975,19 @@ enum {
>>>    #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
>>> +/* OVPN section */
>>> +
>>> +enum ovpn_mode {
>>> +	OVPN_MODE_P2P,
>>> +	OVPN_MODE_MP,
>>> +};
>>
>> Mode min/max values can be defined here and the netlink policy can reference
>> these values:
>>
>> enum ovpn_mode {
>>    OVPN_MODE_P2P,
>>    OVPN_MODE_MP,
>>    __OVPN_MODE_MAX
>> };
>>
>> #define OVPN_MODE_MIN OVPN_MODE_P2P
>> #define OVPN_MODE_MAX (__OVPN_MODE_MAX - 1)
>>
>> ... = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_MIN, OVPN_MODE_MAX)
> 
> I don't think there's much benefit to that, other than making the diff
> smaller on a (very unlikely) patch that would add a new mode in the
> future. It even looks more inconvenient to me when reading the code
> ("ok what are _MIN and _MAX?  the code is using _P2P and _MP, do they
> match?").

I agree with Sabrina here.
I also initially thought about having MIN/MAX, but it wouldn't make 
things simpler for the ovpn_mode.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


