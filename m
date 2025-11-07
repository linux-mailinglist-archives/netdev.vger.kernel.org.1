Return-Path: <netdev+bounces-236821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CDC405C9
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC21898978
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AF32936B;
	Fri,  7 Nov 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="b1duxy+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395B2BEC3A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525796; cv=none; b=jm5JbT+hZ/+u1A/WHSzzipJrxWv4ck5bPpK8N088y2WnYslD0kzE1HA2ogGNCydIB6y4n7xn3NwN0M+Enk5wv05CxDtpqkiiANjdhFkFQcq3OjSlne0pYnU7SajThn/WotGP2yiAsAu8pXMi4WKP4aX2u+bS9ZOCeSwxgRD6PAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525796; c=relaxed/simple;
	bh=XvGsdko66qV0k4xPDbTZEbgpVLrPEiw4KDoSeNOMQLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfDVKDWS3SQdiIROxG1BeHdIEvxjDuX0I91G6kJtzXwAKCD6dE2TArsnM/EUmsSqLCwopmwppH0rGEgzx6MITsFKopjZhapAH4ZxSgs2MvcyhX8nrJ5hE8lz/fpM5+LaQd2Z8z46wcn1TIbUUdel5+zkRz/Wu/TVuPFym6HPKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=b1duxy+3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775dbde730so816955e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762525793; x=1763130593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lbC/1Hpq7o/Ra6ELN2FjkqwvxvOMfaKVKbbN5oM3SG4=;
        b=b1duxy+3hKK0BfAK5A7WV1yR4kgsqrv1BjByUvUD1qDe3isGlzB0geoJsGPDReidbJ
         tact/2ZroRbNzRMGVtN8X2hzRJ45YNTJxzvKbL0tfbAd3Q2b/PohO2H+e3sK+YX90ViW
         DmH6A2i0NcdDr6xkUAyrqwQw7KS77xzosFyBCD0HqqKJQ1DpwKsMMw7qcqoyMi8vBgO8
         n9393z+Afwmuv4eSD6T4BMqt1q5klbOtNtNFdRBFkzm7g2DMsFo9+cFt5Tr13QZ311nX
         S91eOc0LfWyG7lmHIRuJL/WeJBiXSfV8jHMaIu/8QsuSAAE5bx1rH1Pek3jG40McBDyn
         GWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525793; x=1763130593;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbC/1Hpq7o/Ra6ELN2FjkqwvxvOMfaKVKbbN5oM3SG4=;
        b=JhdU3spJwCieMbgInLIVeOxXMOnehR7V/Qbx4/Gd9r/S2g3yvA3tLdlrmEbSjDUoRu
         0S3r3+f5Zlh2q35GqYg7FJvFobGzI8T1sRr2i+CDzu7glB7cC6UvMOE9MimQwpQ51J2a
         IW9Gsl7Wt2hHqw8sLo30k4K/bKstee2sCT2MakJipJskRV858E/XxGxmP50tzp4DMlb1
         O/DZiyJM7KmebRx4vWW4F3oiQlTkrxocB+Gjq394WYztCY8yVWnxye0aLK5srvkqIyeY
         BJuckD/PhExBQwmdui61Mc5DTCGWjQERzSmeg5Z7EtQXxru3iZpfKmmfrv4/I0I9LJh+
         hdYg==
X-Forwarded-Encrypted: i=1; AJvYcCWSF5QnOY7pFo+jeMayYm1l00ybPb9XskwqO6Xa+w/ElaShbtTAQuEXKdq50W1373V2w5hirL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCPVFGO7WSyQgMJAnpMd3DAdjTyluD3LPWxOYX3O9Pr0a5eMW
	N6Ez5k7mOef8GVLk1y7QLKRtHmIqXg7iRLCQcVCfv+bNDFhPzpGeB8aDgU+imaenBFw=
X-Gm-Gg: ASbGncs1sUYH9WJLRbbW38XjpgljNPmnl6MVQYXXZKhW4usPfAlDS4O1YmaJEWXqVo3
	5T2ebk5VgUSk8HzxrLJA8lpXmEJAgS1V53FEn4kNuLWkqxRnP/pFI+jIX/j6UegrSM8nK3V0uyi
	iWIRdafWh2bRXK5cESUiEbbgH+ougAkmyqSaIFj8HUqyiRyChaUcxlgVzep2p5lydwi1Y7psvSc
	4HwkibKYkiSf+htJrrXt83Y4NMLc+28rJgJGqnoFI9wb9HWsYfm+r1ck3nXorMELfHMgHXJm1pL
	/2gEUs6PY7q58lcseNWufhjETECV42e3/JHmyXaIKzG6jLZ/soGedFMlTTiYURnUTASehQN88pw
	ZeT/YVhuff1byOqv5QmoRdBRua6abFW02HO4xM8gnHHHf+Cpf3i9D70sUOAybME9qdKVLFN6dwq
	wSyaWWxJcbYmQF2BaoiyqR0tR1uhGZZwHZ1JCW20QkoHOuopfCf8eo
X-Google-Smtp-Source: AGHT+IG4ZjHnXCuG0GuJe+Qpgn+2EINgD25KAbdNWOHQHh4CYicR+hBGZc/dgFvG6Y5w2mfK0LAsaw==
X-Received: by 2002:a05:600c:8010:b0:477:362c:1716 with SMTP id 5b1f17b1804b1-4776bcd518amr15045685e9.6.1762525793425;
        Fri, 07 Nov 2025 06:29:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cad2sm5737777f8f.29.2025.11.07.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 06:29:52 -0800 (PST)
Message-ID: <a249ba44-a339-4f67-89a0-af08f9464c05@6wind.com>
Date: Fri, 7 Nov 2025 15:29:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
 <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
 <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>
 <fbc92957-4cf4-4687-bc2d-ed09cedf8572@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <fbc92957-4cf4-4687-bc2d-ed09cedf8572@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/11/2025 à 14:55, Andrew Lunn a écrit :
> On Fri, Nov 07, 2025 at 09:10:58AM +0100, Nicolas Dichtel wrote:
>> Le 07/11/2025 à 03:36, Andrew Lunn a écrit :
>>> On Thu, Nov 06, 2025 at 07:02:52PM +0100, Nicolas Dichtel wrote:
>>>> netif_carrier_ok() doesn't check if the slave is up. Before the below
>>>> commit, netif_running() was also checked.
>>>
>>> I assume you have a device which is reporting carrier, despite being
>>> admin down? That is pretty unusual, and suggests its PHY handing is
>>> broken. What device is it? You might want to also fix it.
>> Yes, one slave is put down administratively. Before the mentioned commit, the
>> status was correctly reported; it's no longer the case.
>> It's a regression.
> 
> I agree with your fix, but i would also like to know more about the
> interfaces you are testing on. We should probably fix that device as
> well. What is it?
There is no bug. It is manually put down by one of our internal tests.

Nicolas

