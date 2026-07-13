Return-Path: <netdev+bounces-307134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wo/4HETPVGqMfAAAu9opvQ
	(envelope-from <netdev+bounces-307134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE174A792
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=dUPA5kzW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307134-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E3B63012CC1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3B3EB0E8;
	Mon, 13 Jul 2026 11:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3203E9589
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 11:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942970; cv=none; b=L7iBKufnooaoizVce5suNIaEqtT0B6ehkXWwQJyU0g3iJ2ocTg8EoKpEjknJAHA9nMXtYr8fliVkrnYboTreD0YVJBAH8wlZ0gZEAYUhpigLMJflYR8dWuZhCRY/uPjvWYypUPp3XonDW0KpPAR1250rQIf9105qDD34v5o+g84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942970; c=relaxed/simple;
	bh=JkbTCkSFok8pzMwNoDJhNxzudjFtN+Y7wellUDbyKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+cKyYE3/c0QXs8hcYCOEjP2AtKBPE2lqXbjAiui2/cEfqFdLtWg2r9rtGq3y6wKqmTqXTilOJM6I/1iyms1xSqMiVwncNFs4VbM5C7XPwTJ/zDdk5AhBZ7itf2RKaPjO8JIQcAFSpu15mkMQ9W0NIwsqwwqb6AxgcIIk5mbXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dUPA5kzW; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so24277655e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1783942966; x=1784547766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/BI+PK8dROb8ix9/i5YgRp0GeZ+iS8+CIrvJVAabmjw=;
        b=dUPA5kzWomtOnJMXoX9kM+7oUVHwDQ95bBuBhJ+8k5BoAqss0auASZ7i0lY1PnmFe/
         jsoOD+86P6mG51X1/6iLy+o9jKr3FUIuc5ly4NVn1bGx3T1a2aqN3ZPfKkrTlz1ADibK
         MvjaRAqMDntlyWtk/bJIGLGea3hbOrW2bBW3HfORxz2AfYpzEvTasVToPRkVIHGzAzKJ
         AEsqj88XeoDSVFEpqtAaCAiwpxH4qUkiTorM1NAnZ5l5iXQW81Us6fkwLZnXg8EGIGvi
         syzhYbptYK9cRL7Tu+t6VgJYAJHcpGjWLGV6VCg+67po39UZWZ5jadinGpL6xoXcZOzy
         eOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942966; x=1784547766;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/BI+PK8dROb8ix9/i5YgRp0GeZ+iS8+CIrvJVAabmjw=;
        b=YJjxilJ2N2DDvj4MCwuP7XmKZ2qiEPEk7/fbC16USQMcpjDeJsqsui+7ZVde+gObgw
         HartuH0ncFSbMjL1rwehv3+PxBT8MSPxPJFR2JpkMq4YyU86glB0X1FNKFh1hGlQvEVR
         XyxL2J2kIp83gZGEg8IU9KbryV/5/vIhKq4gCbQ2HAC3fPWVI4LgQUTo9YW6qdH/msa3
         mnawjfQFE64QBQCcoB6TJB/VEjNcI0pWbo5FOaXwJYmM2otXmpyXPQV7knxu30Ox8G47
         ZoQLVAUne2uH07SGyPA2EsrfM46VugQLENWCiyOC8/F4gIQ4uEciTyKiBCMwa6B1F5oN
         xHDg==
X-Gm-Message-State: AOJu0YzswiuG3NMtjRkk4eOwQZcVllyE83h+Av2xWN8IjXSAGwoZdOmy
	+FcwFTIlBfF6tCVBhbngPFvFI3XtkqBxOAQfapI/n689SSCWM+4QtyfLWLbmA9h1/uvDVMnuQL6
	i+/6XH9dwyb8za2/oNWjVrqCU0INu7NdryAnd3Ndpgcux7o9K6gI=
X-Gm-Gg: AfdE7ckcUZ8TLPTn5wyKAo/PI/jo6H1rUbH2DyRNNPBBACO+k8xwKSFmO9WCyX3X18G
	+/S/5AKIl/XmW5Sb+ZXKCbXlPgHECJ0MzsficcVEaDzw1VRU1XW1NTPDXkDAjXR6pPglVbiC7VI
	M5N9ojyRvmLaSFnRA+3jOG1JEGDjvhsaakQWooKyRsbSLuhSmL/COkKpxxx/QWrjf+ug824vRQw
	Trb4+qOgrHMA0KDOTN2OwR5q6xwyxT+11zRsDs88xUrW64Dd0OEK5RP8z8QzwMxWwZDtiuCu0/w
	1LqW3BQvlVYyqBGcWiBHufE0nMXmdYBaMVp6RkcX9B8rwzq6kLjqf6UJD4rG0dxLDj5HD7/KxnP
	F3WDfjLGWt4+qo6cyyAdjVjrf8EG50BBwgYX/kVOoRsMJoVGYPvyLN9m8XjryUblozsRkjrB1aT
	mSKcLKVMeGYNUQOT+m0j/OoOK3gDl8tuyZEBcUSlfNdBuX/RwV1kQ=
X-Received: by 2002:a05:600c:c4b7:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-493f89523d2mr86184745e9.6.1783942966286;
        Mon, 13 Jul 2026 04:42:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:cb9f:b978:adcf:f7ae? ([2001:67c:2fbc:1:cb9f:b978:adcf:f7ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f49755f9sm272831015e9.8.2026.07.13.04.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:42:45 -0700 (PDT)
Message-ID: <0fcbf44d-10db-4745-b89a-faea329c0074@openvpn.net>
Date: Mon, 13 Jul 2026 13:42:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/7] selftests: ovpn: add IPV6 and VETH configs
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
 <20260710-net-sft-fix-containers-v1-3-a2915c294ef5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Organization: OpenVPN Inc.
In-Reply-To: <20260710-net-sft-fix-containers-v1-3-a2915c294ef5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sd@queasysnail.net,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:from_mime,openvpn.net:mid,openvpn.net:email,openvpn.net:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8FE174A792

Hi all,

On 10/07/2026 20:04, Matthieu Baerts (NGI0) wrote:
> They are required to run the selftests:
> 
>   - Tests are executed in v4 and v6.
> 
>   - Virtual Ethernet are used between the different netns.
> 
> This has not been seen on NIPA before, because the 'ovpn' tests are
> executed with the 'tcp_ao' ones, merging their config files. These two
> kernel config are present in tools/testing/selftests/net/tcp_ao/config.
> 
> This issue is visible when only the ovpn config is used on top of the
> default one. This is the recommended way to execute selftest targets.
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Acked-by: Antonio Quartulli <antonio@openvpn.net>

Jakub can pull this one directly without going through my tree.

-- 
Antonio Quartulli
OpenVPN Inc.


