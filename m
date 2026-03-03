Return-Path: <netdev+bounces-262958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IObwNbwmpmnwLAAAu9opvQ
	(envelope-from <netdev+bounces-262958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:09:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C01E6FD1
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FE6D3004CB2
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E81448E0;
	Tue,  3 Mar 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPLCqVB2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B22628D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496567; cv=none; b=KaNMJT7yQLTStuHfkAOVfxLafsnqhtz4eetM2XFIBVUjWmI1/n7gjkIgEen1dABJD7l3ZWzi2QUIi7enh6cpdZesTT/G2PQenMfkEZTJq2ICtffrIC7GUXAj9wbMRUh9kDzBQReE97GY0/jfLK+kkdjGw2ouiannpQ4PzpaDz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496567; c=relaxed/simple;
	bh=HqNBeUrhcvvRGpuRd5ewX60ZDg7J6Gyn50Q1X2rJ8jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYMAInG7l212XKfM5geF6ZxW8BQPoP/2jIKXdXJk8YF87ZtgIIQvTssQbkv+940OA5U9clIfU1f/9R4nELaSnVQMxeUDOSJ0gYuonIwiF9J/hcnuwzISk5gEeFZCrdvzay8J5FOl+dsnqs9PNqPWpYWvRs58ifd4NoYBmfWxYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPLCqVB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9409BC2BC86;
	Tue,  3 Mar 2026 00:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496566;
	bh=HqNBeUrhcvvRGpuRd5ewX60ZDg7J6Gyn50Q1X2rJ8jg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tPLCqVB2Efjz50R21BlBMTiGUbTaG1aE0T0UIc1IVfy0tqKaiND3iZ+Bcpp7XXNCW
	 gei96MMc8wgFFWfayFdCig6M+6HiBS8k894OZa4jsg975k8GkUw3IP6oNKF5+Sq743
	 sbtmxRzQMJ0S9hPvPasI0Ix1vgyfcJ7c1Ro7aA9kew2caRFn2S6vFnvIgUT87piT6g
	 XRvUJxsKEPJaVj1DyksrmPuVaatDjYn9d89Cjr8Z4apgOD2mQNLRTr8cTQ+fcmUz3L
	 db+/5SO9GsxHHJng5ZqoSmC9nq+MNPqB0IMuO5fQP+U7I1cA0jG4n9GdA4abnBAc3k
	 S7jPKjF5FL5DA==
Message-ID: <8040efce-34fd-4758-939a-bbeeacbfce12@kernel.org>
Date: Mon, 2 Mar 2026 17:09:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20260301194548.927324-1-kuba@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260301194548.927324-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF0C01E6FD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262958-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tc-action.sh:url]
X-Rspamd-Action: no action

On 3/1/26 12:45 PM, Jakub Kicinski wrote:
> l3mdev_master_dev_rcu() can return NULL when the slave device is being
> un-slaved from a VRF. All other callers deal with this, but we lost
> the fallback to loopback in ip6_rt_pcpu_alloc() -> ip6_rt_get_dev_rcu()
> with commit 4832c30d5458 ("net: ipv6: put host and anycast routes on
> device with address").
> 
>   KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
>   RIP: 0010:ip6_rt_pcpu_alloc (net/ipv6/route.c:1418)
>   Call Trace:
>    ip6_pol_route (net/ipv6/route.c:2318)
>    fib6_rule_lookup (net/ipv6/fib6_rules.c:115)
>    ip6_route_output_flags (net/ipv6/route.c:2607)
>    vrf_process_v6_outbound (drivers/net/vrf.c:437)
> 
> I was tempted to rework the un-slaving code to clear the flag first
> and insert synchronize_rcu() before we remove the upper. But looks like
> the explicit fallback to loopback_dev is an established pattern.
> And I guess avoiding the synchronize_rcu() is nice, too.
> 
> Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> now that NIPA is not full of the tc-action.sh crashes this 1 in ~30 runs
> crash in fcnal_ipv6.sh pops out quite clearly.
> 
> CC: dsahern@kernel.org
> ---
>  net/ipv6/route.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


