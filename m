Return-Path: <netdev+bounces-275380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF+NKnMd0WnFFQcAu9opvQ
	(envelope-from <netdev+bounces-275380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:17:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1B39B55F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B15300C023
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8987263B;
	Sat,  4 Apr 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECv+mqvj"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CE1E3DCD
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312228; cv=none; b=n1/0SRoJwZW3bVRR+et0GfXbZjC/guc88aP+ANA3yVstbpPGpROgTxb294lkXKEXDG1Uxr4iSy82Qi5Iv6hv24FICLOBhxLen4GVPd/izXc519cIFducDow3VixrgMieA34y60wLErVN8AhyjxUU2hFAdk2VMzLkWSQ9GQDCTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312228; c=relaxed/simple;
	bh=LYr0ubPAGC0RgbCC1h4re3cPGkEuCMDWXjm3pGKMC1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBROHQR+KaNO+84t3Av1WWiNgg+mw5L0nVo0S4aT2QkvzCdhEfl7+qQGsplc9DmHmjAly3vr9ZSEBzYHKCyzKRVDnKco4AjxsHO5gKyPFy5DGE3/M0heeu1ba0GU/LKbmg4gYOFQJ/xW2c/PjDdAevY4gPteayctPFjNqIBoif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECv+mqvj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7465950-f378-447e-b269-55d4677940fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775312214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6otXDqEJcaWeLw2CxyHD4auHUlaDtEnRsjD2i6Qrl0=;
	b=ECv+mqvjCDNItoiMRVVRqBmd2Hw+WxdbwfnHmpYA9Lcmnu3tnhrljlrInjJMy8VHWXVFxM
	IBS4cRICZL6XphTmrcv9j2xSO1On2a/JC2vtBRVHt0olFyb0Lr0axxSOMMw9z2R48LIecZ
	l1Sw25igELo13CJwIwrfCyqKiOuaPgs=
Date: Sat, 4 Apr 2026 22:16:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: mptcp: fix slab-use-after-free in
 __inet_lookup_established
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260403130734.93981-1-jiayuan.chen@linux.dev>
 <9791b7d2-734b-4148-ad7b-89a374420a9c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <9791b7d2-734b-4148-ad7b-89a374420a9c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275380-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE1B39B55F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/4/26 7:15 PM, Matthieu Baerts wrote:
> Hi Jiayuan,
>
> On 03/04/2026 15:07, Jiayuan Chen wrote:
>> The ehash table lookups are lockless and rely on
>> SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
>> during RCU read-side critical sections. Both tcp_prot and
>> tcpv6_prot have their slab caches created with this flag
>> via proto_register().
>>
>> However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
>> tcpv6_prot_override during inet_init() (fs_initcall, level 5),
>> before inet6_init() (module_init/device_initcall, level 6) has
>> called proto_register(&tcpv6_prot). At that point,
>> tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
>> remains NULL permanently.
>>
>> This causes MPTCP v6 subflow child sockets to be allocated via
>> kmalloc (falling into kmalloc-4k) instead of the TCPv6 slab
>> cache. The kmalloc-4k cache lacks SLAB_TYPESAFE_BY_RCU, so
>> when these sockets are freed without SOCK_RCU_FREE (which is
>> cleared for child sockets by design), the memory can be
>> immediately reused. Concurrent ehash lookups under
>> rcu_read_lock can then access freed memory, triggering a
>> slab-use-after-free in __inet_lookup_established.
> Good catch! Thank you for this patch.
>
>> Fix this by splitting the IPv6-specific initialization out of
>> mptcp_subflow_init() into a new mptcp_subflow_v6_init(), which
>> is called from mptcpv6_init() after proto_register(&tcpv6_prot)
>> has completed. This ensures tcpv6_prot_override.slab correctly
>> inherits the SLAB_TYPESAFE_BY_RCU slab cache.
> The split makes sense anyway: better to regroup all v6-related init steps.
>
>> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   net/mptcp/ctrl.c     |  6 +++++-
>>   net/mptcp/protocol.h |  1 +
>>   net/mptcp/subflow.c  | 15 +++++++++------
>>   3 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index d96130e49942..5887ddcdb875 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -583,7 +583,11 @@ int __init mptcpv6_init(void)
>>   	int err;
>>   
>>   	err = mptcp_proto_v6_init();
>> +	if (err)
>> +		return err;
>>   
>> -	return err;
>> +	mptcp_subflow_v6_init();
> I think it would be better to move this to mptcp_proto_v6_init, similar
> to what is done with mptcp_subflow_init, from mptcp_proto_init.
>
>  From there, you can even call it before registering the protocol, at the
> beginning, so before inet6_register_protosw, which seems more logical
> and similar to what is done in v4. WDYT?
>
> If you send a v2, can you please remove the 'net:' prefix please?
> 'mptcp:' is enough:
>
>    [PATCH net v2] mptcp: fix (...)
>
> Also, can you add a "Cc: stable" tag please?
>
> Cheers,
> Matt


Hi Matt,

Thanks for the feedback! I'll try all your suggestions in v2.

Thanks!

Jiayuan

