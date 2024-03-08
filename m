Return-Path: <netdev+bounces-78553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A92875B5E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413C31F2146C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86215364;
	Fri,  8 Mar 2024 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZTWzXoct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EE184
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856097; cv=none; b=oVVR2LdjvixPDf7W8Y8Bcy+J6vqlUsa4idxIB1FDAqJcRgRjm/4bcCzFsHVmIkXkFpFtQxre0x31eSI9sVvPDfFyxx4phws3jXxK0MRPijT0DpeOKIF9MYIH6F6kdVMj1pFKzHxn59Ff91u3rURi8BwCD71n6kWHpwUBEymVB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856097; c=relaxed/simple;
	bh=BQgVTX1XrhQirUYpGWnlm/YpEHkVQmJOw3sr0JEv3FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikZwEh4I0btTY2NcnuweUcH+t8/eBmuqxpjMbWTus5lb8goGIjyxvGU1L1JKeYnV8ydFSJvhy3B/XOnFDMVE8fGm3FZdvWWGsbduwQY5d6O38YkGilcmXHmit1G7duGtoDRpcDlU1EgsMCnNDQPhepse1hGQAdIhES6aizHu7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZTWzXoct; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-567fbbd7658so1647468a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709856093; x=1710460893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DPhEXD9ojiu59TcMBYHbdGKnNXR2tNwaQDJP2dPhCGY=;
        b=ZTWzXoctHAG9r0aoMK+sjFkXsYnvQiJZ0eSHXP0LOKSnF4Z7kTY6Ep+p2jOdDzdDMC
         klXcK3iVT0MzmVtJeVDkfvi7vhGwWyvULW4Nb+MOwDtXwIjSSgGiAtDgexxSzw0l9CI5
         KAQKFQL9+wRH6uI2PXMT6/9ZXpXkuzst1A80J+ZUVQRPrmFl4NjRJn6CCLWtNPPaJesM
         Z6qX720vSllH7J7ywNX9McK+1jUwBebQc6+soGcL47Le2h2cCnXwXCrLFiaG5Vkz5D0S
         iM9cYp9hdKpH+pkxcKDGzDKOFtBhRFqSylnh8noYnJJJ0HyX7x+I1GyjXzqZ47Yaik7A
         hgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709856093; x=1710460893;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPhEXD9ojiu59TcMBYHbdGKnNXR2tNwaQDJP2dPhCGY=;
        b=kgcD+u5IgK14mJfEoOyma9MAfH6jGFfd+ghi6UKeX21EXdDd5UnJ3XlY5NbDvGQ4qK
         oxwy+mQo8o4o9hl8xUDq94vkTyf6DyemIeE4oS0/8dZ3ahBWaspe37Gif0rD/pUI1P3C
         2VyM4N/cEN0OiDkTthDWYMhmdfUWXmYuqUxlyLoBKYfTWgKmFwqKAlkLGJ3EkF/ijJY/
         kBEkqnKVd6FYsJ51oL/laL+aa1OmVJwVBEktRTelclNpiMVK83lUnHCU4O5pGwtsHNsu
         4x0QsHm1L9toX7RYwH3MOr6nqT8QcTTkFIGv0o6eWcHwz9Gg0VOYRghxkq2v6mExEsgy
         iCAw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQBHedPn97XF7hYDo4FJhIKUNzI0yUOnr6/FG96cYZgOv8bXQH4Q7DrIcmWCeCU5I0RogZdB8DlqWL4EzGGe+JTB2nLXq
X-Gm-Message-State: AOJu0YwW/gGhz/8PquCOSq8/o8WNmkBw4N1oI/AcLv7sC2nKGC56TBrr
	/OVsV+CvS1ibKiSlXuoH2eHP6UBbt2UKx285Z0rXzG4Znuptq1oeCPeyp1SnaxvhOxAw5TMMlJQ
	9
X-Google-Smtp-Source: AGHT+IHo+hkmpLM69HIl/OtyuHSXWakda9fWrqYC56CujewVkbBubHz4DpdjyikVFRUyD80JqigWeA==
X-Received: by 2002:a50:bb2c:0:b0:567:a8f7:2233 with SMTP id y41-20020a50bb2c000000b00567a8f72233mr697459ede.40.1709856093043;
        Thu, 07 Mar 2024 16:01:33 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:460d:9497:9f21:53e7? ([2001:67c:2fbc:0:460d:9497:9f21:53e7])
        by smtp.gmail.com with ESMTPSA id el8-20020a056402360800b00566d6e30f1fsm7448863edb.31.2024.03.07.16.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:01:32 -0800 (PST)
Message-ID: <f5906a82-36f5-4e9a-8fca-d8bc65ca5fff@openvpn.net>
Date: Fri, 8 Mar 2024 01:01:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
 <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
 <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
 <d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
 <20240305113900.5ed37041@kernel.org>
 <5f7f088c-426a-493b-9840-02f3003a7381@openvpn.net>
 <8033ea62-7ecf-4703-9d7b-d18f66751b8c@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <8033ea62-7ecf-4703-9d7b-d18f66751b8c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 20:10, Andrew Lunn wrote:
>>>> Right, so this in general makes sense. The only question i have now
>>>> is, should you be using rtnl_link_stats64. That is the standard
>>>> structure for interface statistics.
>>
>> @Andrew: do you see how I could return/send this object per-peer to
>> userspace?
>> I think the whole interface stats logic is based on the one-stats-per-device
>> concept. Hence, I thought it was meaningful to just send my own stats via
>> netlink.
> 
> Ah, interesting. I never looked at the details for
> rtnl_link_stats64. It is buried in the middle of ifinfo. So not very
> reusable :-(
> 
> Idea #2:
> 
> A peer is not that different to an interface queue. Jakub recently
> posted some code for that:
> 
> https://lwn.net/ml/netdev/20240229010221.2408413-2-kuba@kernel.org/
> 
> Maybe there are ideas you can borrow from there.
> 
> But lets look at this from another direction. What are the use cases
> for these statistics? Does the userspace daemon need them, e.g. to
> detect a peer which is idle and should be disconnected? Are they
> exported via an SNMP MIB?

Yes, they are used by userspace. Main usecases are:
* inactivity timeout (if configured, when less than N bytes are 
transferred in a given time the client will be disconnected)
* stats reporting during connection (during the life of a peer, stats 
can be periodically pulled by the user for reporting purposes)
* stats reporting at disconnection (stats are pulled upon disconnection 
in order to report the total traffic related to a peer)

These stats can be reported via a status file or via the "management 
interface" (an interactive interface that can be used to issue live 
commands to a running openvpn daemon).

How this data is actually used is up to the user.

Regards,

> 
> 	Andrew
> 

-- 
Antonio Quartulli
OpenVPN Inc.

