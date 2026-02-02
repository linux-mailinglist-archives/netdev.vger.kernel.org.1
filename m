Return-Path: <netdev+bounces-255906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OlaEm7EgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D6CE4E8
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF5B2300608A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08D221DB9;
	Mon,  2 Feb 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="uEklFGEc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16337AA81;
	Mon,  2 Feb 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045843; cv=none; b=pMYhhr02Iy9re4v46dXCeZwnNuUHCibwOqDwSzc7cdySGAxwR62PHgllCmVYRy7+5x0OQ4ON5p5Tcc1WVj31VamkSLHg0yqGdelxsvHER+MlIX2PXHSljML5asIESQrYQhYUb4ei8RSAhA6GV9j+sD2r/S9D5e7y39ozYi4i+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045843; c=relaxed/simple;
	bh=ZOMvloZpNoMhFlLtr09Mi3WPCTznnwTUTRzItsEszKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1pWI+Hs3x8zapqh6SJG5e/SWQiPwdp5zvJRxQmTw/o+8AdzqElrIbuJ0FXTJNvegs5OWaZn4zLC5WsGZjpLSsz9bqaAYLSB1HKr48p/eS3ZoBZVjrdtCHCbF+3BMAiWc3aF1PYEvs2BoQyumyGP6dOxyweM4/OwU3r3K6ERR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=uEklFGEc; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 30E9A5A0003;
	Mon, 02 Feb 2026 16:16:05 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhGq3aCiKGkT; Mon,  2 Feb 2026 16:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1770045363;
	bh=ZOMvloZpNoMhFlLtr09Mi3WPCTznnwTUTRzItsEszKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uEklFGEchrx5Q7Mc7TCb+vZYPro4WvC5aOuP1tfKi35uw2e3C7bhPd456HjI6yGO8
	 4HKqkc1EAW/dOQ+xGrAUegk+K1JLV+1m9B+33JBFAV84i+nLm9bnbPGCnM6NJ4NLmy
	 FsWddc/EfMU37CiqI/G79+cw6f7IP18DcPwEPwHOQAvF2aW1leJnFnNXxWV8po0glw
	 HzSoIzPFApqBIUCuYFVmF+rUmAF+wYGN4bhc1RWnqjvdrubRNyB9YkMaIp1WdkXaqA
	 gJSEw3z06Cf5NTAlmHN3jG27AeOhrcJMaSg1hQgPmyX8HkqK6vihVFY4hv961z68iq
	 xSW5D1RVV5hdw==
Received: from [IPV6:2a02:16a:6e09::1f84] (unknown [IPv6:2a02:16a:6e09::1f84])
	by mail.codelabs.ch (Postfix) with ESMTPSA id B0C515A0001;
	Mon, 02 Feb 2026 16:16:03 +0100 (CET)
Message-ID: <4eb261ce-5f05-49dd-a668-6bb18e332f91@strongswan.org>
Date: Mon, 2 Feb 2026 16:16:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [devel-ipsec] Re: [PATCH net-next v4 1/2] icmp: fix ICMP error
 source address when xfrm policy matches
To: Paul Wouters <paul@nohats.ca>, Antony Antony <antony@phenome.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Antony Antony <antony.antony@secunet.com>,
 Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>,
 devel@linux-ipsec.org, Simon Horman <horms@kernel.org>,
 stable+noautosel@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1769595011.git.antony.antony@secunet.com>
 <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
 <20260129184510.01319683@kernel.org> <aYCTfwblH8wtnF6c@Antony2201.local>
 <d54db2a8-d3ab-b8ff-21fc-a26716a21494@nohats.ca>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: de-CH, en-US
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <d54db2a8-d3ab-b8ff-21fc-a26716a21494@nohats.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[strongswan.org,none];
	R_DKIM_ALLOW(-0.20)[strongswan.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255906-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[strongswan.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tobias@strongswan.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strongswan.org:mid,strongswan.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 554D6CE4E8
X-Rspamd-Action: no action

On 02.02.26 15:53, Paul Wouters wrote:
> On Mon, 2 Feb 2026, Antony Antony via Devel wrote:
> 
>> Hi Jakub,
>>
>> On Thu, Jan 29, 2026 at 06:45:10PM -0800, Jakub Kicinski via Devel wrote:
>>> On Wed, 28 Jan 2026 11:25:14 +0100 Antony Antony wrote:
>>>> Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches
>>>
>>>> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
>>>> Cc: stable+noautosel@kernel.org # Avoid false positives in tests
>>>
>>> I don't understand what you're trying to express with all these tags.
>>> We are sending incorrect ICMP packets, seems like a normal net-worthy
>>> fix to me?
>>
>> You're right that we're sending incorrect ICMP packets when IPsec/xfrm is
>> enabled and this is a legitimate fix. My concern with backporting is about
>> potential disruption rather than the correctness of the fix itself.
>> The issue is that some existing test scripts and monitoring tools may have
>> hardcoded expectations for the current(incorrect) source address behavior.
>> When this one-line fix gets backported to all maintained kernels, those
>> tests would start failing, potentially triggering regression reports and
>> requests to revert the fix from stable kernels.
>>
>> Additionally, without the
>> commit 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
>> being present in older kernels, the behavior change could be viewed
>> differently in stable branches.
>>
>> This is also the sense I got from IPsec users.
>> Given these considerations, I opted for the safer path of targeting net-next
>> with stable+noautosel, no backporting.
> 
> libreswan is unaffected, other than the old code showing a weird
> unexplainable log message.  So we are not really affected by whether or
> not this get backported. We would slightly prefer the backport just to
> get proper icmp messages out there (and we might need to fix a few test
> cases but that is okay with us). If someone reaches out with strong
> arguments to not backport, we would be fine with not doing it.

I think the main concern is that without Antony's patch that adds ICMP
forwarding via reverse lookup (63b21caba17e ("xfrm: introduce forwarding
of ICMP Error messages")), which was not backported, packets with the
correct source IP will not get tunneled if the gateway's IP is not
contained in the traffic selectors.  So if at all, backporting should
only be considered to v6.9+ and not anything earlier (the commit
Antony's Fixes tag references, 415b3334a21a, was released with v3.1).

Regards,
Tobias


