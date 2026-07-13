Return-Path: <netdev+bounces-307090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L/+WIK6mVGpeowMAu9opvQ
	(envelope-from <netdev+bounces-307090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47E748EE2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:49:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b="CN/maNTN";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307090-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FA34302AF26
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478C3D3488;
	Mon, 13 Jul 2026 08:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932123D1A99
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932551; cv=none; b=b96+1gqWahQJZCO9429zz9WVqTuN5oy0e6s6B5m0lt2RlI4Fu6LqF2jy/d4aoPPHTHa6fDPwuxkhxz580P9cyMw/sqBMLDD2BzNBeTBhI0a+nlSSeqQnpL/rbyitwNJtJGOxYn7HQxjeKyNmxtrUosUuMDIGVGN2TBcUZGIxCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932551; c=relaxed/simple;
	bh=Q4qiFWad5OiVAx3/h3YdRStz3h0htREQPPpSRvOfM9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjW3MXT5cz/8uHiHhw/n0EAf4GJU5wPDKfLUv1MBD86LGx6iW2M/i/uP9JMYib1PO+W8ko32z3mectYvpz5nj4JTUXFtS3+TuwkNeyiCuwqqlwgnX+Cv/gYPkgi8rl6Pu7aqZ9eqgCKaWkk4HSUxf5kZaQ5hjkiK+/Y3APNgEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CN/maNTN; arc=none smtp.client-ip=188.68.61.103
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gzGLt20W4z8Fw6;
	Mon, 13 Jul 2026 10:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783932534;
	bh=Q4qiFWad5OiVAx3/h3YdRStz3h0htREQPPpSRvOfM9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CN/maNTNwI/GkcTsexEXXajk3Yet7oAKbPKBIG8QsIhR4KanKgAk62TvkTPngUOEw
	 7dwsP3tYwfIiHO3UWlviiA6iL4lTDuweaA0sAnuTx0ESIXjQr+7WSDNlHz0/CN6hRe
	 bPjTNTbR37L1/dqmY/y0Sc8sd/Xh7op9nOK4e40Zp25TrRPJfKfKPk5+MQ5Uo3DA+W
	 7UEYpHkXA3d8hyUE3jv6Pd+BrIoO5VdAOMtCn0a8a6niGZZr6CX5rHHlQnyP6vYhZs
	 o7vui0DcTrXooBhNd6fkECrkO0PfwrPccPKfIHJ7WzvjhggW1uzQjDtiQOwhsQAhWY
	 S1gOhYO0rsiIA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gzGLt1GpZz8DYw;
	Mon, 13 Jul 2026 10:48:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gzGLs1MwMz8tbb;
	Mon, 13 Jul 2026 10:48:52 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 43FE760418;
	Mon, 13 Jul 2026 10:48:46 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <653ebbde-aebf-4526-9d55-63976a18372c@leemhuis.info>
Date: Mon, 13 Jul 2026 10:48:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Broken MPLS routes with multiple nexthops
To: Kuniyuki Iwashima <kuniyu@google.com>, anthony.doeraene@uclouvain.be
Cc: davem@davemloft.net, netdev@vger.kernel.org
References: <036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be>
 <20260625155313.847098-1-kuniyu@google.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260625155313.847098-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178393252650.3576089.12727735396801431284@mxe9fb.netcup.net>
X-NC-CID: b1S1x3EoaZF8hEqbuOzVciKIkS6OyvPAG72FH+7yKlUrKRbBx7g=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[leemhuis.info:server fail,uclouvain.be:server fail,tor.lore.kernel.org:server fail,vger.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-307090-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:anthony.doeraene@uclouvain.be,m:davem@davemloft.net,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB47E748EE2

On 6/25/26 17:51, Kuniyuki Iwashima wrote:
> From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
> Date: Thu, 25 Jun 2026 17:07:41 +0200
>>
>> According to my experiments, it seems that ECMP with MPLS (i.e. an MPLS 
>> route with multiple
>> nexthops) is broken on the master branch of the kernel.
>>
>> Indeed, whenever adding an MPLS route with multiple nexthops, ip route 
>> show the route as
>> a dead route/link down, even if nexthops are reachable.
>> [...]
>>  From a git blame, it seems that commit 
>> f0914b8436c589b7ab32c614d8d7868eb4ebd5bf
>> broke the core logic for building nexthops.
> 
> Thanks for the report !
> 
> It was to balance refcount with netdev_put() in mpls_rt_alloc().
> I'll post the patch below.
> 
> (Updating rt->rt_nhn is not strictlly needed for netdev_put()
>  because it has NULL check and rt is allocated with kzalloc(),
>  but it's a bit error prone, so I'll keep it)

Kuniyuki Iwashima: was this regression ever resolved? This thread looks
stalled, but I fear I might have missed something.

Ciao, Thorsten
> ---8<---
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index ca504d9626cf..4a81514e919a 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -922,8 +922,7 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
>  	struct nlattr *nla_via, *nla_newdst;
>  	int remaining = cfg->rc_mp_len;
>  	int err = 0;
> -
> -	rt->rt_nhn = 0;
> +	u8 nhs = 0;
>  
>  	change_nexthops(rt) {
>  		int attrlen;
> @@ -959,12 +958,15 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
>  			rt->rt_nhn_alive--;
>  
>  		rtnh = rtnh_next(rtnh, &remaining);
> -		rt->rt_nhn++;
> +		nhs++;
>  	} endfor_nexthops(rt);
>  
> +	rt->rt_nhn = nhs;
> +
>  	return 0;
>  
>  errout:
> +	rt->rt_nhn = nhs;
>  	return err;
>  }
>  
> ---8<---
> 
> 
>>
>> This commit modified function `mpls_nx_build_multi` by setting 
>> `rt->rt_nhn` to 0 at the
>> start of the function. However, the loop `change_nexthops` just below 
>> depends on
>> `rt->rt_nhn` to know the actual number of nexthops that it should build. 
>> As `rt->rt_nhn`
>> is set to 0 just before, **no nexthop is ever built**, leading to a dead 
>> route. Even if we
>> remove this modification, this commit incorrectly increments 
>> `rt->rt_nhn` at the end of
>> the loop (`rt->rt_nhn++`),  such that the loop always end with an error 
>> as it tries to
>> constructs more nexthops that actually provided.
>>
>> Commenting these two lines fix the issue, and allows to create once 
>> again MPLS routes
>> with multiple nexthops:
>>
>> ```
>> modprobe mpls_iptunnel mpls_router
>> sysctl net.mpls.platform_labels=100000
>> ip link set dummy0 up
>> ip addr add fc00:1::1/112 dev dummy0
>> ip addr add fc00:2::1/112 dev dummy0
>> ip -M route add 16000 \
>>      nexthop via inet6 fc00:1::2 as 16001 \
>>      nexthop via inet6 fc00:2::2 as 16002
>>
>> # Check the route
>> ip -M route
>> # Output:
>> #     16000
>> #            nexthop as to 16001 via inet6 fc00:1::2 dev dummy0
>> #            nexthop as to 16002 via inet6 fc00:2::2 dev dummy0
>> #
>> # Route is accepted and present !
>> ```
>>
>> Overall, I think it would be interesting to discuss what this patch was 
>> trying to achieve,
>> and how we can conciliate both use-cases.
>>
>> Best regards and looking forward to hearing from you,
>> Doeraene Anthony
> 


