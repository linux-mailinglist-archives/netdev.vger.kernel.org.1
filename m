Return-Path: <netdev+bounces-149134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF19E46EF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4689D165264
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBA1991C3;
	Wed,  4 Dec 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gIGEHX8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92653192B73
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348240; cv=none; b=Nu8wPjQL8p9CiCSH+ujS1cV+A3XC01J20I/oVU4b1E+k9dYrIDOp1Jy65N6fkhiUycBf6mg6afAOhq8gY+1qq3OulhUQQJ3O4WKcchnAA3+xHihGTJO8QvkR8zzX1FnPwKPLRplL75UJW7wAuSbKmHQlf9P+PRgq3uSKP5RudtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348240; c=relaxed/simple;
	bh=fy+pxMrmnsyQfFxxdCTaRGfuEvaDxfL5SPDCrXubOnA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GPhbEOnUqqO3MZDCAEPpZvygrmPF/Gdjze6id0OhGpbpQ0sQP+hOmr8dy7QLuZEKFJal/KOGKm3t59HRWx/IYA+WJts/eiM2drWa5tnpLUGvj/78KItg0jcY+j3EVynsDIprE+3iZsbl0j7WZT3rHKfxxA8gXPKbOCslZ2jlZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gIGEHX8k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa520699becso40112666b.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733348237; x=1733953037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4IDpXfDUAONKq+cWOVBMq9xtvXDC36Ij7SjYZaH4g8=;
        b=gIGEHX8kj67hBcvLHFlB3hrVnuT37dpNnu+/8lObBZxl5Dtptmkehpez9Em5eiFrTE
         T+qygC+MsM8Q6OMp+yYFwVWGYDTCe5cgNefc6RjPd+sA9zAvyA9iQLwOsklpXnoXAfV4
         w97dcUIet4Ql0vHOxenpMoRSg3nEGywtaXdtQOjxWk8LBWOpukX1pab9tJRXmRAQ9DtM
         AcVVtnEwaiG/yYOJSaJ0Y4zM449d3KmslqbKE4n+IaKYvZM1yK4m8Rn0meqG0k0TVV0t
         SHaQ/eIT3ZtO+PUfAaSv8NBaETKXK/L6/EfGpHR8RSC65dsIeBRLVKniKZNI8IYIvxWA
         Cucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733348237; x=1733953037;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W4IDpXfDUAONKq+cWOVBMq9xtvXDC36Ij7SjYZaH4g8=;
        b=Vnlq4I40kqYAQ7eLMPLiV4fSRhf/wYJ42gE7hePy/mO1sXgKn5fXXJ+BWaG35CQUMC
         3+qmAA9MPCOiE1zndbTuU01iiGwtWOL/4MxOZQIxzjLTX4EMy136gEa3aHkloxF/dAGz
         8LPKl7EswZmurg0UbQ9NjvyYuZL1ORuR5TUbRqKfpsyHhUoFP+6HoXkI8m8l9iJZ8QBF
         7xNW20cDBJpP9WHl0MXyQZJD+bQYBEX9gyhAb6ck2Cax8q41W4i+9h4r8yVhioyqZ6OR
         ynPuTC2HplriHMDOHfv3d61iLMXVWN7P0JHAMlC0EwV/rDoP2Res0/nfsS1wYzSnwJ0a
         QSJg==
X-Forwarded-Encrypted: i=1; AJvYcCWRGB0UyzNc1tIaJT7sXGJ2q9IXzPuJn7thBscFlGjPBv8e3Xx9F6wikYLb+cppyUiyDDwHNXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8e/Dd+6uyQotag5bWmosvYEewXjb5iACIqBZGKW2T9z/OJWXX
	FiX8YePzQepxP3MLv/ZEBTbC7pohCyqNM3+HlJI5ktGaZbrye6nDRILGoFwEWoo=
X-Gm-Gg: ASbGncusDzFKOgLDTO2wJJKF9e7kPy45irtA9gQBfu9Mdb5sNy9DqqNFGmhSRHVNMSe
	pMOMhf6t4uk8u0UTltwFSJ0RmHDnqJZE36pL7vge7KNhdfF7b8RmTpRdLQ1xZYM8efeL7Jeutav
	JB/p/Bpyc6Coc1LSj/6R+HqUDBiHS/QBpLPDWtsBADvLFnRE+d/aOIlV/xCHTC+3WLwRdxmU2Ga
	H95qKkKkctCs2x08hhav3pp36+mkwCAfNupuxma8+bwJCOxAo8jVQsL2ifYT61SxGkd5SM/OFlm
	VgvckFvnzqLL
X-Google-Smtp-Source: AGHT+IGAORJ+Dk+2ScYG31kssFqIu3BwXeqwBMZ24RDyqCAL/h2XcG5Eo/2ESGkKXI1Zgcbz8dhQsQ==
X-Received: by 2002:a17:906:218a:b0:aa5:f331:e052 with SMTP id a640c23a62f3a-aa5f7eee063mr618419866b.40.1733348236929;
        Wed, 04 Dec 2024 13:37:16 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9715:a35f:73a4:7403? ([2001:67c:2fbc:1:9715:a35f:73a4:7403])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62608d2fbsm4615066b.149.2024.12.04.13.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 13:37:16 -0800 (PST)
Message-ID: <af88a027-61ca-44f2-8d93-43d06076e2a6@openvpn.net>
Date: Wed, 4 Dec 2024 22:37:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
From: Antonio Quartulli <antonio@openvpn.net>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
 <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
 <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 12:15, Antonio Quartulli wrote:
[...]
>>> +static void ovpn_tcp_close(struct sock *sk, long timeout)
>>> +{
>>> +    struct ovpn_socket *sock;
>>> +
>>> +    rcu_read_lock();
>>> +    sock = rcu_dereference_sk_user_data(sk);
>>> +
>>> +    strp_stop(&sock->peer->tcp.strp);
>>> +    barrier();
>>
>> Again, is not clear to me the role of the above barrier, please 
>> document it.
> 
> Also taken from espintcp_close(), with the idea to avoid reordering 
> during the shut down sequence.
> 
> Will add a comment here too.

Actually, after checking this specific barrier(), I realized this is not 
needed, because we are doing the socket detach later, after calling the 
ovpn_peer_del() (which is different from what is happening in espintcp).

So I'll just drop this barrier here.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


