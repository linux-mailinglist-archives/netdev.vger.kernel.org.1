Return-Path: <netdev+bounces-307135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bcvoAT3QVGqzfAAAu9opvQ
	(envelope-from <netdev+bounces-307135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15A74A7EC
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=M+TfEqy4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307135-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF63304CE87
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957A3EAC74;
	Mon, 13 Jul 2026 11:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7038D40D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 11:44:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943057; cv=none; b=gOu9EqQ2+bVquHethQTCNn9wFdsv8at5Z2HHC1C3OK249sKwFVlE+gVxq0AwSClU3pa7RueOhAH7MfcMKR0Sl3w6NA/iuqCF2/MgBCwfYMUazKgvYGhscOPIGqPdOIjiTepxMGtLJdocoYVkCVgbOVdeW/Xw5kBUt3isDZBzlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943057; c=relaxed/simple;
	bh=fkmsy/qj3nDjH6r51nZM+y+pjrVIbB4xwZRlFVlVYik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tj0X3fRcZHpMdMeDOd9rOf+ZuS9QwSr4Sx1p1sn6dFoWm0eER0u0RP7li5ImT+HIV6MFv3fCMz3ngkGkTmcUInh5bftOXNEwnLCLcjuJ1y9D6tHUDPDZgpBGLsWsSD2Ujpm1HVZlGsTJx9TE5rru8vF4Lco4a85Mu8r7UvdDWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M+TfEqy4; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f36a122fdso1062200f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1783943055; x=1784547855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iCmyiRNgN+jRhAkyFwvAt0xGNMCOhabSbhuO5oOGF5U=;
        b=M+TfEqy4B1o33TzJTzzCbXqdgtGFZhTniN40XnBRJyktulROSxdPsQU58aIn2Qd+e4
         DEUhiiOJEJCy8tFL81K8MIvXBNAFbsN1EBGIqebdbPvFHiNsVLkvDcWD3WNQrL2vaMbH
         aTSXAhTslibYJRFyVkGU4VPLFwex/m7k5D/UmQGalmkUmB/BeKfsgb4nsUyFFkaR4p0t
         fpAPNqyPvq7bV6DlUUGcfFQ5xnLZ860xBcrEtZbwrDxkepqvhZI7K+LKn3BlIzDCcfID
         kxIYu9bD44HRTBB54nZvoba/xMbEhOgEBtJKvH/zUdkKNz/9eVrUA+u1Dt/hya4KAGFu
         pkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943055; x=1784547855;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCmyiRNgN+jRhAkyFwvAt0xGNMCOhabSbhuO5oOGF5U=;
        b=UZ3HCMs17E6uc7MR+u6kywarxGLoXU6A1KaPwKwQMD/pKSGqJtGiC8bAYvdQGXRfhx
         Vnj1PAGR2AhRoGazDvQ7d3VVGNxwP0t/+jQaFKGCj3RHD1vfrqEZcXy8ZsrPqPosGyU3
         yDN/VYBhGCdL67zPde9FbByhudyuUL/TstoaSBZQmpEWsK3HFZ/ylyw//7kPBmZpEvFo
         QbEC4NMOnTLEuyZRXZee3F4rI6EbYqtVeEKaHzSYpWTHHjoQ+PZDwOWijvbPL+7rMO/N
         iiRCU1C7wP58L8Z9/h9wvt/CdIohbA+iqVhRkpJpVM4zPqt4GzbE+//RxvyI8mMB/NZS
         Dmnw==
X-Gm-Message-State: AOJu0Yzvs6N6dkqHGoQb6/psjRNDxSxOxbY/VOWV3OK5ne/7z9rNwPUU
	rzwK9y4mOoRPPwdvCp61LAAnQqGPUFQhpvSTGpg55pLeYC7N3Zc6pPsecQzA2Z4P4ht9nMUaIzc
	C7HMVv6s2ls/o9etlkIe9pzjMZi81VnLFVlD89WzFn0elCXcbwNc=
X-Gm-Gg: AfdE7cmXrU/X/zE7g+P7LHXYt+eEcR1KcRnZFRaliX7Kn2z5z2t7WmFISpx0NnBejh2
	PWLWFvkxCRRKVnUi6Pt7kHt2v5GHPqrCDHjxjYrX/3leXA95P2sdQ/0SvNSdvu3loqfPjuTLNci
	h4Sd35zj7XIMUSyW1WMNVaFHridrlxUXtsE/Rsd61s5nzbgQfdNcV67HPNqK3NK2Y51d55goQK/
	UzLHe20+AXqQQvhHymt5MfLXS9lBnjEUjEC57Jdky3gY66YXhixII3LLUuMQQhzcfVa8OewAKqC
	oRevpM0OOy424VBMEdYdZfHYIc6Ki4cSqFv971q1rDjdQf+lTHKRW5UA/BDTLeve27WM4tCuN4C
	4QWb21Wr6o9joXTjdWeZEZt+r20PKQyVS2PodEP6YixxTm6MVMspPzvRtLZVQwy7eKUeA7bojRY
	VvFNaaAwbrgi77FouWe9DS9E82DO6g+5KM+fLCjFc/6UtwwdWM+qE=
X-Received: by 2002:a05:6000:2612:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47f2dd1f23fmr11029156f8f.29.1783943054642;
        Mon, 13 Jul 2026 04:44:14 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:cb9f:b978:adcf:f7ae? ([2001:67c:2fbc:1:cb9f:b978:adcf:f7ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm82155316f8f.29.2026.07.13.04.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:44:14 -0700 (PDT)
Message-ID: <6eb596f6-5be1-46f2-8f69-b73cd5e8b038@openvpn.net>
Date: Mon, 13 Jul 2026 13:44:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] selftests: ovpn: increase timeout
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
 <20260710-net-sft-fix-containers-v1-4-a2915c294ef5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Organization: OpenVPN Inc.
In-Reply-To: <20260710-net-sft-fix-containers-v1-4-a2915c294ef5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307135-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:from_mime,openvpn.net:mid,openvpn.net:email,openvpn.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C15A74A7EC

Hi all,

On 10/07/2026 20:04, Matthieu Baerts (NGI0) wrote:
> The default timeout is 45 seconds, that's too low for a few ovpn tests.
> 
> Indeed, these tests can take up to 50 seconds with some debug kernel
> config on NIPA. Set a timeout to 90 seconds, just to be on the safe
> side.
> 
> Note that the Fixes tag here points to the introduction of the ovpn
> tests because I don't know when they started to take more than 45
> seconds. That's OK because a timeout of 1.5 minutes is not exaggerated.
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

we didn't really bother tweaking this value because AFAIK NIPA uses a 
much higher timeout value.

This said, I agree that when running locally 45 seconds may not be 
always enough.


Acked-by: Antonio Quartulli <antonio@openvpn.net>

Jakub can pull this one directly without going through my tree.


-- 
Antonio Quartulli
OpenVPN Inc.


