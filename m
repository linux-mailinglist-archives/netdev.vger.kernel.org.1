Return-Path: <netdev+bounces-264916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGNhNjJBq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:03:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5921F227B33
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0293020FEF
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5648166D;
	Fri,  6 Mar 2026 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FuY1ViFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054573750CC
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831020; cv=none; b=MVUUB7qEhXVZTB5WeSg8NjvPbQcKvNLn1z81i3ttlbrS6ZVJOy9t8yAHTHcvGSfLQdg1uibuS4k8DM8/IQCth1F4IXSYwNg0ni/6OosaI1vuOWYr6CxIFPt9jc6013coKpeUm7M0ZF3kT6Vxu6XqL+E/WOkyZDRs3BQVxv/jbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831020; c=relaxed/simple;
	bh=f9HPLplmGZJT6ekH3d6OaVwO0sJIVGcElbBUIIYf2jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc/WEIhXL2A9XjX0jNv9wN4CNk0HbIS1BDfZdEw5AkJQrctE8DDabZCJ33H2KJAMPGvUsw02hUex3VVJjMoEJZa1q5dBFDjWJGnnPpmeNDJJOJBADyg2WmkoYEnlpzvsr0Lp8V4Ody4WViEu8sJrH8xscBnfc0GCiEAispNaAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FuY1ViFH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806bf39419so78352145e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772831017; x=1773435817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LmPd7fKX1MJWS9YsyWAU5zz19VwQyuopGfhjBZOhMCI=;
        b=FuY1ViFHTP2jvul8QpIoOb70v973prOxLeqnAjIK2d24OGCEGUXbIjvX6b/EqnpLnQ
         awzOYN4eqjkFZkEQg66aGRRshB4plFKr4lzGET9Mq664c8cW+tDuOPYx94wB4pymR87d
         fr94Tji/+JdsubR3YhOHQqMkkwwlJr3JtoCTFiJdUfTjCCzmXsoJpemYnWpVZUU6mN2S
         QQiX7rIkZKLBmE9ETtIUOTWLryRqNpzm8ss6X38cal4KZnO9FpdhJQ7HGh/m7cQBFqU0
         0IJ705v0yM2dbOwybA9+nDXwQglFE7DZaNrLbnBB71NSkCHoKoYGxj6aeJcldhqgH3hm
         n8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831017; x=1773435817;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmPd7fKX1MJWS9YsyWAU5zz19VwQyuopGfhjBZOhMCI=;
        b=fhkO8Ga2rjIbnXUWRxuo9ACczVdOApd0cpbNL03j04DrW3D0Nbfmnr7dNoKUiMhPR5
         Si9qXXNB7fVbQMDU5dLibmnLNA5IO/ZgiMYOQ0/Y4SWC+N432FjyhyUVJ69f/4c6rC15
         LYpgu/1ZGymL5lJhxX0ei4eJmZoEAQJBJco5/4HSf4FMf26fCVdM9GsfQAaJeMuEFIFl
         hdcWHxq2RJavmF4mDchNPnFD33YeYX79sOcIeellNaW9yDNKOt+eTOYC7CaURYEvgsJN
         8ILg5QohFcihL1s90HfmVTFKf2Xv5xTeOaWrB7CIAYmMm7vonWXuleTU3qnIKYwWLlMd
         2umw==
X-Gm-Message-State: AOJu0YxoyuzYw4ldg5UjWr/XdlfC1GKU4cQpffHNI3ltQYVKGV614Tey
	lMgcuC5Ygbk2f9stDt0aHrtaEEFp9D6ZV1Q7vsKRS+6DcLg/2wBABYkd9K8a3mM3kdbVpDi7qDV
	gCbsT//x3Enym+VcQLdIIJQbITsXt3TJ19O145bH6WjbCMxqsi7I=
X-Gm-Gg: ATEYQzyQn/2XB+S8KAqA2j+kH86LvYMv81Bd95VPOzLKqrbPXzs9+DZfNV+Uhd+0Av8
	0P8+AZGP994VIeSxEJeUEbty8ub7V+0UF91rlFDmdTAF66oiNW/QQttc/mhtDYJYpWf161QIrIf
	Snc6Z3zCSPSd1G8kt6Wv/lYxPrjFAeWaIKlZJrpub1X56m5De0PzZWpV6xQCeUzLtO7Di4H+TgD
	6LELixvtJbdo7d2enizNIEy8FAFWKQpbyOQ8Y6Fn3SIXVnSnLvSJ9UGOeAGyyd/PXXPMg4f1VA0
	8T4LHaWnIT0KnrKsa8HY9SwxPM2rx7P9BzYPIMUF8Eek3W29CvITvWIpa1aBHKRI9CWpwJ9fbn2
	tOPWdVP4wFCK7hYGBfMl9cGE6wZp9TDsZfR5Z6RCtHToDSYJAiqXgJnZ6f2VpPrgc/UGy9cah4z
	vmT1XyiccNcXcABpt6Cs/vm/TtP5+BijPoQGlXsm20dnmZRDGjrdPbUZu5XqRb3g==
X-Received: by 2002:a05:600c:154b:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4852675edf7mr53802145e9.17.1772831017315;
        Fri, 06 Mar 2026 13:03:37 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:99eb:76f9:2124:56da? ([2001:67c:2fbc:1:99eb:76f9:2124:56da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527648a19sm58448065e9.0.2026.03.06.13.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:03:36 -0800 (PST)
Message-ID: <618d8073-8191-41ed-9fc8-e0a36f45bdea@openvpn.net>
Date: Fri, 6 Mar 2026 22:03:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org
References: <20260304230643.1014-1-antonio@openvpn.net>
 <20260304230643.1014-6-antonio@openvpn.net>
 <20260305191732.2bbc386b@kernel.org>
 <b3197cdc-83db-4739-966c-018f8570070d@openvpn.net>
 <20260306125738.73a17bb4@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260306125738.73a17bb4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5921F227B33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-264916-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,requirements.py:url,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Action: no action

On 06/03/2026 21:57, Jakub Kicinski wrote:
> On Fri, 6 Mar 2026 14:05:53 +0100 Antonio Quartulli wrote:
>>> There should probably be an else branch which prints some kind of
>>>    echo "SKIP - requirements missing"
>>>
>>> Your requirements.py script prints stuff but the output needs to
>>> contain the word SKIP
>>
>> If "has_listener_requirements" is false, the test script still goes on,
>> but it won't check the received netlink notification content.
>>
>> So we're not really skipping the whole test, just one specific check
>> that requires extra tooling (which is normally found on all standard
>> distros).
>>
>>
>> Do you think we should rather SKIP the whole test so that we can easily
>> spot that something is missing?
> 
> No strong preference. But speaking speaking just from the netdev CI
> perspective it's probably best to report SKIP and then keep going.
> The system does string matches on the output. If we report FAIL after
> the pass it will show as FAIL, if it's SKIP + PASS the report will be
> SKIP.

Got it.
I agree that reporting SKIP and then keep going is probably the best option.

Will change the script accordingly.

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.


