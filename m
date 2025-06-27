Return-Path: <netdev+bounces-201767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE9AEAF09
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CC83BCB92
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C31FFC48;
	Fri, 27 Jun 2025 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQlxMe6g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB682F3E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005929; cv=none; b=g0FyohMVGKwTg/R0w3UnclNXuotzlTm/NMGSBV40Jf+KJYTcpnG43DR4gI36qMxFDLg7hYfxXF0Tgtgwq8lRyYwn6Ctc5IEsa9gqJDe5qm3DgMwZ7KBBSoIiN/OJaf0qCeXc8uqG30PL97N0k5+jx4NJkls0erHNBRoRz9P1hTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005929; c=relaxed/simple;
	bh=C01a7bu7LDNjAVQEzly7wapfTELeKSHlxAU5Oy/RaDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArV/6eR/3H6BqFQBehrvaZWPesWPXjYHfY5nxZ/GWYVYJjZFUQ3SBZoUNCj8rAqbsvICJ9iMILGBPOdXRUP8kWfrsU+z+a++jN+lHB97uTSsGpIvi985+AtPSl2geWi20yq1vz8qkCWDqp7E6t98ZzFtdzEzlJb4pdmLlMjloxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQlxMe6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751005926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fb6sMSNGmv5woscC2/p6HLiB0RUU9wHUIgeoJsEGz0g=;
	b=ZQlxMe6gpEX8vrPkGqGIIb42Ibou5lE8nU0d11lDqzI7ViRhtsh1mHwSjJ7LMOLm6cwKFz
	tTtnD6zWxpkpf2jMrx7vG9P4zkbjzXKUYFZZMEWspjMpx/bLTVLVTLt4Zq1BidF80bwMGd
	OyqJnQiC4Bj1PVJGlvqD1loG9gq7BIQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-eQUJvH8FOUeQFDLDd-9mCQ-1; Fri, 27 Jun 2025 02:32:04 -0400
X-MC-Unique: eQUJvH8FOUeQFDLDd-9mCQ-1
X-Mimecast-MFC-AGG-ID: eQUJvH8FOUeQFDLDd-9mCQ_1751005923
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f55ea44dso729616f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005923; x=1751610723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb6sMSNGmv5woscC2/p6HLiB0RUU9wHUIgeoJsEGz0g=;
        b=H0Ymwf+PETuT8fG6hi42F1Fowk8iUbg+dR+qHU/+V0ZHNdyAAt8aA9zVq1eGMgYZER
         7sJofti8EUJuYXVwMILNvOGokwI4hs/yZeucstjL57qBwmlp7N3ETGb7eqS0AekFh11P
         +OEEs5Vkv5hFiD+CijCXzuWQ1miYbYho5xKDGzJQD0UyA6iKClPgYQyNkf44GWFJNte5
         W03mbuHDhNEp99R1Z6o6R/iOvIka60VeQc/CBly68ryRx+FCmApdCjedcV2q6vnKiaqW
         MgRNuDqxI6BcLXvlK7/7sw9L3PvqYH7ThcQvjmUv3Td/4NE8dRI7Q8xubG96CzreLRTf
         NOCw==
X-Forwarded-Encrypted: i=1; AJvYcCU28XlMq5slRKmDOHrH2zR+AQ9SSBRB92ajPp0As4T4pb43+p+OiWDig1JzyZRHDYx0nzvhHL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxU+BDmMmPrBEDFC9KO7rqXWN7vXc7dfVu0Dn5u9SE6xkHBaT
	/loK5XU82/leZ+UCmUvKnlixFhC+uZgo2XU2lTsp4kM79adS3vLZMqAlbVZUsQ0xJV+le5R9rVr
	Fi8tGUxlHE4mfjQzSPKfsH3Y3T6j2cbfpH/lvdANWn5gHO/DJR+dlXqafeA==
X-Gm-Gg: ASbGnctFXvWGHkV8G69GLL/mKRO4T5gdkslmJPfMoZDbiumWAUcMynD3ojoXrCXm8X4
	YFpDONegSAzZnHfji8aLsVlGWEsAL/RHtAIsABVgmfZUr4Z9crpSloupoy77FQvoA1z2VLJzo29
	i/oTogqGv1QjwJ43/0Grbblhuxf99VA+rtNBR0lL5Lfd85gmFNacmCBdyR+AJtmtIGJ+icFKj5d
	W6IygTMmAvrGiTzP7b1fO4FcdRjB/M0SGOSApXvVY3++F5eAX3hTaacR0TS6PBrK+fPAAYv1PIq
	Z2ioFrOR1hBJWrGa2lRUZ+JR2YrlfzJMaNv3ODgEec9/A1iGtx2+ffLD+69uKHO5yZD4oQ==
X-Received: by 2002:a05:6000:4719:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3a8f577fcb4mr1688906f8f.8.1751005923005;
        Thu, 26 Jun 2025 23:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmRoO2jR3C6B9IoV3Nhi6cqJF/Sk8g5jX6Q8492iARCkgYDP+HkraOdtYx+QNIex0tOGQ8JQ==
X-Received: by 2002:a05:6000:4719:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3a8f577fcb4mr1688882f8f.8.1751005922562;
        Thu, 26 Jun 2025 23:32:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e595d1sm1800961f8f.71.2025.06.26.23.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 23:32:01 -0700 (PDT)
Message-ID: <b2484912-e36b-4f04-a6e3-c0b1f92ce1c8@redhat.com>
Date: Fri, 27 Jun 2025 08:32:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 00/15] ipv6: Drop RTNL from mcast.c and
 anycast.c
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250624202616.526600-1-kuni1840@gmail.com>
 <6c33dd3e-373a-41b3-b67a-1b89ce1ab1b5@redhat.com>
 <CAAVpQUAT8gs10P9DbwfMNZu2xyzEChgMPMFzO9VKdDJT2oPcrw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAAVpQUAT8gs10P9DbwfMNZu2xyzEChgMPMFzO9VKdDJT2oPcrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/27/25 2:49 AM, Kuniyuki Iwashima wrote:
> On Thu, Jun 26, 2025 at 6:27 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/24/25 10:24 PM, Kuniyuki Iwashima wrote:
>>> From: Kuniyuki Iwashima <kuniyu@google.com>
>>>
>>> This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
>>> RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
>>> multicast code.
>>>
>>> Currently, IPv6 multicast code is protected by lock_sock() and
>>> inet6_dev->mc_lock, and RTNL is not actually needed.
>>>
>>> In addition, anycast code is also in the same situation and does not
>>> need RTNL at all.
>>>
>>> This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
>>> removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().
>>
>> I went through the whole series I could not find any obvious bug.
>>
>> Still this is not trivial matter and I recently missed bugs in similar
>> changes, so let me keep the series in PW for a little longer, just in
>> case some other pair of eyes would go over it ;)
> 
> Thank you Paolo!
> 
>>
>> BTW @Kuniyuki: do you have a somewhat public todo list that others could
>> peek at to join this effort?
> 
> I  don't have a public one now, but I can create a public repo on GitHub
> and fill the Issues tab as the todo list.  Do you have any ideas ?

Not really, that is way I asked ;) Hopefully someone ~here could help.

Quickly skimming over the codebase I suspect/hope mroute{4,6} should be
doable (to be converted to own lock instead of rtnl).

/P


