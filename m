Return-Path: <netdev+bounces-183714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE72A91A23
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1816C5A06E9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F12376E0;
	Thu, 17 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F+cqJcuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390923644A
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888262; cv=none; b=X/bueTZ6QA/2TazdzM47SxQXd0IbiHRzC14dnaTQS8cuwzoNElmdaFMVajYE0xH+bJQ6rdB/G+QQrVPEvViQNl8VDNS3mUOdFkd1mZ2lktiwD0nazGLO38PFC/JSrSELvIwjAnRcdE8z9csY8pBa5EGMDuiaiKS/WzwZL5lGEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888262; c=relaxed/simple;
	bh=4WVa4tlHKmMnIZkrmijwlyWKAyT/54rWx0L6IZz43t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIW9ew+SMvNbwBF9gbLRtUuywY6LNOqyVuEfmxlYOzNeRoWJDP4hM5M2uvnzy0ZBnALUQAk7bmAx/DANfoegdVd3T/H3wPio1NMCz5RO30IhPnikpz9JVSF01r4uJD7N7OImyL+pj7TDTppVMiZ8QhW1Q1VTOxHg5aVZnXvqC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F+cqJcuT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso591433f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744888258; x=1745493058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ecxvMlFGge0FVUqk6iTuFS/LC9a5IfwQDFL8JLrgw=;
        b=F+cqJcuTKMOmndEhClG8lFakbh6I0gpNORpBskyeGn4qOyUmaug+l27q/jTHnAA87H
         PHraTYYXUp5XS88EnXbsSrJt3zLHGZVhrNQV7h9cwZxBP92mL84gIGsXyGot+2lbKwsl
         EyaB2mRDycpeeZV2fshJJ6nkoAaexAlOvvyEV5lvvpnxNtYzxJJepB21qMy+pMQ3fUbg
         uTwHZ/vv7htX6fOfTPFDPinoVoh4yLyuBpCAcmJaXTA2sQsWmtoTT4TXzEqUfNTvCUBL
         S04qsnVq/m29kzCAn+ct09Pldo05ha36yUrtE9JVu/jQDstxtznU93Roau0N0T1qlXDE
         x09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744888258; x=1745493058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ecxvMlFGge0FVUqk6iTuFS/LC9a5IfwQDFL8JLrgw=;
        b=JlGWrwfeLLkPphy2jvFGouUwtakPSk32oyDmYe2AYThYgs6GAvF+qx+qKHMNmm6jsC
         KWUZcVkyk7ZHhvh1iMNABncgRJlav1+OU+Ak3ATLDXu2l2fcAmBbDxKQBVx6HCrHkXbT
         ysYV/A0DOivPjREsDMklkOleZrw7ipSj5zyKjAFNGkimuqwkY+S1EiREmT/QUuMCyyNI
         x1wuM7lbFekKvB396M3l4UXBB5Yq4xzAoBtk3/ASSNalzXoxgUlmO6qt1OsHkwlopFLC
         M5Ag5Qh5kaXRI2CJbllXcmzN4Rlshh3dfhY0Bv0praoazoV7E+SKtTIRXr3zpkBS9y4b
         12zA==
X-Forwarded-Encrypted: i=1; AJvYcCXiIq9wMG6GqgjcQfH4YevjAjvb6DxCc1ZohO+bF7G1sUV35CbtReGIfPu+ea73dK1skYOG25w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UrtMhurNSkECCrlktzbv3kf4W/znClEsaVxEv/Gr+DwOu/hc
	6W33qGbJE20kPaWIv75S2hAvlMkGEl8NhjMQ4uTSIuhGTjdAQjAE1x2tPwFH/t/1wHA9cSmSt1b
	9RUEt9r7kY/zwlgvRPiGZ44F4sk/xttelthJKGgikQ2c0P3c=
X-Gm-Gg: ASbGncvdd5nT8bfSLiM7QYzil4+rmlqDN0UwAwBlLy757M77JdQncdSPJbjCv1FPCDQ
	p2WdhnB9fHjU7X4cNpboyk5C823zBnhqGOwu0PCwfuP0NhOmL/y+TwnVN7r04RzwL581nMb7Ru8
	9gJzNHiPIq5FBr6S7jCc+ej5ztMrobmGe7RxCbp/+ZxMbRZcx7ecOgokhKxp9NXvr3+XRPlU00L
	5qbUA8kre11AkT4o/Usf+1EwO4n7is6tBg02OHOMiqzEEldTfx24Ydxip9pTLU3u9WvRx6GtSiY
	/2sLsen9BfRFN6nifMZD01wuaDbEFwVBfQ5tjVk0JdrxoK5kO2t3u0pDw202Ga75hV5vTujYoJo
	J1gfjCPtp
X-Google-Smtp-Source: AGHT+IGBNChZlUvCoOUWUTudYlb6W7GE4ujI1IR03t50H3uSVsX3Rmw4vcS6YA7Xt3NrcYcWnSBZpg==
X-Received: by 2002:a05:6000:1887:b0:38f:2766:759f with SMTP id ffacd0b85a97d-39ee5b9d6f7mr4706617f8f.41.1744888257677;
        Thu, 17 Apr 2025 04:10:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:dbd:fe3b:43d:324c? ([2001:67c:2fbc:1:dbd:fe3b:43d:324c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979620sm20052067f8f.52.2025.04.17.04.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 04:10:57 -0700 (PDT)
Message-ID: <39f2793b-97c9-4e84-a62f-34c25f1fd635@openvpn.net>
Date: Thu, 17 Apr 2025 13:10:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
 <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/04/2025 12:48, Paolo Abeni wrote:
> On 4/15/25 1:17 PM, Antonio Quartulli wrote:
>> Notable changes since v25:
>> * removed netdev notifier (was only used for our own devices)
>> * added .dellink implementation to address what was previously
>>    done in notifier
>> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
>> * fixed author in MODULE_AUTHOR()
>> * properly indented checks in ovpn.yaml
>> * switched from TSTATS to DSTATS
>> * removed obsolete comment in ovpn_socket_new()
>> * removed unrelated hunk in ovpn_socket_new()
>>
>> The latest code can also be found at:
>>
>> https://github.com/OpenVPN/ovpn-net-next
> 
> I think it's finally time to merge this. Thanks Anotonio for your
> patience and persistence and thank you Sabrina for the huge review effort.

Thanks Paolo and thank you all for the reviews (especially Sabrina!), 
suggestions and hints!

It's been a bumpy ride, but we crossed the finish line! :-)

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


