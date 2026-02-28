Return-Path: <netdev+bounces-262170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACarGsYYo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:33:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724F1C4591
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19EBF303C4E5
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9822DCF67;
	Sat, 28 Feb 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq5Yx1XO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9376368956;
	Sat, 28 Feb 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296387; cv=none; b=ADeKrT2xDVnmmqhthiHnI6FYPZelj8lIRq4XMrzHy93FWS/mpiCFVgM1zCVRDdrzgco+KNGlyXaWmLXdfKtA7xHRbSfy4AfQhhR225IMsHMqaO7Vy7yODVOfDRtm98eWOEixExBy1ZhMXEsniOedxVisNKkr1DSVAINyFT3ggjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296387; c=relaxed/simple;
	bh=tYLFVsd2BgJkNE6MX++bsoPVLwM2RhCgyA3+444B44o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+v0MIyOKj7Fi1vAEWQkDDtTw+rRzErxL1JjtpRserjuu0SrlBhXKM1pCq/J+RbDvY27riNU/nxm+SSsPrRXCVmV4+WTaUK6Ov9nUzeWSX22QntP+sJvXJAWW9QNqqFWKV39pIljU/ouWKVnHV9lNlE9/Ty0Yw7DuBvTzkIjjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq5Yx1XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149D3C116D0;
	Sat, 28 Feb 2026 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296387;
	bh=tYLFVsd2BgJkNE6MX++bsoPVLwM2RhCgyA3+444B44o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xq5Yx1XO07cmmL+IFyexsA1wRgE90Sr7f2ZJxXBASD3RBVoF6oc1y1ZVxADUMWED1
	 y5ffIAsreRoZYm59BBjtFNfhHYNM3N7NR6of9xXoS0HyCK4hgvxcgLArBWIa/x56OY
	 1LaU2lUZMhUP0JCz+AC3oMJZwl8i3GQS38rY6N06UXAnI8eAsb9TrSge7QBxo1oZbn
	 fKC78d8BdNA7xKJkyC34A7uRzYQI28L4ZNl9XHpV7/4FF0z8BN5550dFyDSFoOKjH9
	 O4JFUAvQx255oO//EEAeeDikjcO9VziUgCx8Eu9I2S0SDGXlV8dqNfEElCcufNZxRt
	 4/Vw4wlaJwr2w==
Message-ID: <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
Date: Sat, 28 Feb 2026 09:33:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route references
 IPv6 nexthop
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
 <20260228073959.0ef1b33f@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260228073959.0ef1b33f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262170-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gre_multipath_nh.sh:url]
X-Rspamd-Queue-Id: 0724F1C4591
X-Rspamd-Action: no action

On 2/28/26 8:39 AM, Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 11:13:59 +0800 Jiayuan Chen wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> fib_check_nexthop() does not validate that the nexthop family matches
>> the route family. This allows an IPv4 route to reference an IPv6
>> nexthop object. When the IPv4 route is looked up, __mkroute_output()
>> accesses nhc->nhc_pcpu_rth_output which is never allocated for IPv6
>> nexthops (fib6_nh_init does not call fib_nh_common_init), causing a
>> NULL pointer dereference.
>>
>> Note that this is not about IPv4 routes with IPv6 gateways (RFC 5549),
>> which uses an AF_INET nexthop with nhc_gw_family=AF_INET6 and properly
>> allocates nhc_pcpu_rth_output via fib_nh_common_init(). The bug here
>> is an AF_INET6 nexthop object being directly referenced by an IPv4
>> route, which is an invalid combination.
>>
>> Add the missing family check in fib_check_nexthop(), mirroring what
>> fib6_check_nexthop() already does for the reverse direction (rejecting
>> IPv6 routes that reference IPv4 nexthop objects).
> 
> AFAICT this breaks a bunch of tests, quickest to repro with is
> gre_multipath_nh.sh but you should probably run fib_nexthops.sh
> on your fix as well.
> 

nothing to fix. The patch is wrong. IPv4 supports IPv6 gateways; that is
a known feature.

please post the stack trace for the panic

