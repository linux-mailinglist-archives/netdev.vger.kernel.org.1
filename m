Return-Path: <netdev+bounces-166136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1C6A34BC9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29F7188564E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0EC1FFC54;
	Thu, 13 Feb 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEV9l0I7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677641553BC
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467424; cv=none; b=d1pn66DQ5DsIAxjiIct/CPPX/FvkVjrOYc4i5e0GEcArIdApJAGCCGnhwFgFTS9zvn8OzzmD7FIU6nVvQalx+OFuoUICPZ8ZL9Mu/bQTIKGrADQiIp+DPS7Hwm7g+xY67J+iI3wyIhsaHc3B8eFV2/J02RFdzkFNozcEbr0hMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467424; c=relaxed/simple;
	bh=VD8K1ibfxChT5WyJ0i3+ym04wMjxn8BnCWY5k8M/bxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gb85J53J+aLhYJFnTqePDKxTDfb8d2eOBcjFcLJk9MiOGaXC2LmkOanydLAiA/yJYagVf8hhNZtWlE2r/Ul67n4gOlvS7zLpypgJUHnRJ1lT8YoA1NtQOn/wOGFIOCYweINs88D53a2KvmFGdDo2VFkS3lInu0zmwvQo0RdiH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEV9l0I7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739467421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58OzlUVWQGZmHA33kPozN82hLrJKAvaVSD/BbcIBUrU=;
	b=WEV9l0I71gK9jM2D30NJaTG38rPPYXORQpKtvpisMPKDVRXkpZM2P4dHfWnq4PuB2Bptmy
	Y6DYsGImFhKkECqqG+TNiCcU0WQ4+S8N29rMotsi313Dd8I/ZfAQCVgkHOlSzmM/XSLEGv
	Sfh/Y5dBmNhoBDxD+U3IBVryGTh253A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-ModAcQxmN0CYemhAVKiSmg-1; Thu, 13 Feb 2025 12:23:40 -0500
X-MC-Unique: ModAcQxmN0CYemhAVKiSmg-1
X-Mimecast-MFC-AGG-ID: ModAcQxmN0CYemhAVKiSmg_1739467419
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43943bd1409so9171485e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467419; x=1740072219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58OzlUVWQGZmHA33kPozN82hLrJKAvaVSD/BbcIBUrU=;
        b=euFsTbtUZXbF2Lj4JncXPEBXOGsb/dfMEX2Ham1kROuqaw2f7QRzDNR9BfNT+H5f0y
         Jv6mVeG/JCTrqf40u0Q6YoQWXz/txbb8ZayrnxbXTII3pc7GcMUyrqciXhhZ8XmwpQaX
         tu2/6HzzFaolLXihwxwYSMEcYxAnBVXXmpWTLqRJAZBj0s88hhYV4fC6OHxzZjdrzCjO
         4UburE5xjeSP6KUF91H5gAXxNBtW1o5buH92KiXxRm3hdMfxWfru3yduQitBoke9mXIg
         Tjuhy54+fgtZvEB9f0Y9RJHexFn6wdMzHB6AGXJgEdkc7kuBzchyo57FnhfmBUo6hDuj
         qxVg==
X-Forwarded-Encrypted: i=1; AJvYcCW70KRYBObUTPJVtvoUB5hc50sBENmil/cRAPL+kGWBFQNHRfCMo1jrqDmhixlJ+Qu6prffoys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYuzBKyskh8PtmKo/W9oZEyaH6duLMpcUNq94HNabXK/3D1hE
	1sWoOgLLOK4RnPfBz3rxnbYPXAFh8+yJpqcFUbOTdXcvbIX0YVK92afPmCQKFd8TU00ZWts/jlq
	+MT92AMbP1xNjBjWxlL3Hrw49sgHQT0VKVJ9KLLg7i64tRi+QaHmU/Q==
X-Gm-Gg: ASbGncsM6SHAK6VXQlP/xir+v8hkrjYoemQOXGi4D+lg+Y5rFqa02qkfpoDFNkil7uG
	+NkAYpVxvy3ZNKfxzgpQs4oMEWF2gpChzOms0jM3oZQDzL3fwtr8SHC9FDy05uUgjlmLjyEi/Qz
	kycQ5H4pzC+ZyNrUDJkPDEhB7lCkWT00UpfYY6ml+HzXjMhzsXmlvRVpoiJrHZLLvMpm1nOE/kb
	aFkFRzs6tmc5qdnnUtTN4dyiAE35lzc/jq2Uer4KrQGsf9SJp8QVPYonhayXhJR8XCK/iHYISTG
	hZ6bSgP3GjR3QShAb7fZUWznPCAvbW2ZhT8=
X-Received: by 2002:a05:600c:3594:b0:439:331b:e34f with SMTP id 5b1f17b1804b1-4395818fb43mr95091265e9.17.1739467418826;
        Thu, 13 Feb 2025 09:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNRSOMEuOQ2nA6L/5P2TSNx1BR3k6oBF2Zb6V0hv0Ni4vswnVb8iPhovh/7EaSWs0bV16fNA==
X-Received: by 2002:a05:600c:3594:b0:439:331b:e34f with SMTP id 5b1f17b1804b1-4395818fb43mr95090835e9.17.1739467418341;
        Thu, 13 Feb 2025 09:23:38 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm54802255e9.3.2025.02.13.09.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:23:37 -0800 (PST)
Message-ID: <a54dd426-3842-4c3b-8ad8-3e6bd59019dd@redhat.com>
Date: Thu, 13 Feb 2025 18:23:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] ipv4: remove get_rttos
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, horms@kernel.org, Willem de Bruijn <willemb@google.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
 <10ef7595-a74c-4915-b1f7-6635318410f7@redhat.com>
 <67ae1c7ba11bf_25279029419@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67ae1c7ba11bf_25279029419@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 5:23 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 2/12/25 3:09 AM, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> Initialize the ip cookie tos field when initializing the cookie, in
>>> ipcm_init_sk.
>>>
>>> The existing code inverts the standard pattern for initializing cookie
>>> fields. Default is to initialize the field from the sk, then possibly
>>> overwrite that when parsing cmsgs (the unlikely case).
>>>
>>> This field inverts that, setting the field to an illegal value and
>>> after cmsg parsing checking whether the value is still illegal and
>>> thus should be overridden.
>>>
>>> Be careful to always apply mask INET_DSCP_MASK, as before.
>>
>> I have a similar doubt here. I'm unsure we can change an established
>> behavior.
> 
> This patch does not change behavior.
> 
> Does not intend to, at least.

Doh! I misread the comment and the code so that the patch inverted the
cmsg vs sockopt priority.

Reread more carefully, I'm fine with this patch.

>>> v1->v2
>>>   - limit INET_DSCP_MASK to routing
>>
>> Minor nit, this should come after the '---' separator. Yep, it used to
>> be the other way around, but we have less uAPI constraints here ;)
> 
> Okay. I have no preference. I thought the latest guidance was to have
> it recorded. Is this something to clarify in maintainer-netdev.rst?

It's sort of a recurring topic, so I guess it would help.

Thanks,

Paolo


