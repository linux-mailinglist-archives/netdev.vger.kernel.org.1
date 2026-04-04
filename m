Return-Path: <netdev+bounces-275357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFFrCOzy0GmiCgcAu9opvQ
	(envelope-from <netdev+bounces-275357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:15:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B454D39AECA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E64253004913
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85292609EE;
	Sat,  4 Apr 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwtaKlBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DE13A244;
	Sat,  4 Apr 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775301353; cv=none; b=sCmcL+6F/wyJhjTWKcdtoXord+ZqSiWrkcCReigAG1KZxDu1UjSaWrWjz3CWzeCqNeYLClPaQbRMN4VMoEKPtBp8scUzWVwjFuVUukgrpJ/Q7P8AOdXCuW05Z9kNXZ+piCneeKU/d8gg6Q+iCsQbRF4V1mRYrz7WX9C72hP2CDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775301353; c=relaxed/simple;
	bh=dfhS9tV3KlRfmBCVpT5htf8yf6i8XgWSpM3gUYk0qWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlNrkEDnAHtJamrmd8GIuTErwbvm/P/bHoZW3ML6cbWxs4NlB17UcJsq37E6aTlzP0SLg1OCiHVQAPjg8C/bPwVI1AFdub4NKPiDiH3QuTPrsSS+yxIxe+av1o2JVgSnINDeQY/yNCosjcBS6Vr9NOD88NMAXlfmNQlO2ExlHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwtaKlBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFCCC19421;
	Sat,  4 Apr 2026 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775301353;
	bh=dfhS9tV3KlRfmBCVpT5htf8yf6i8XgWSpM3gUYk0qWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwtaKlBJIXQLC2Q1qlJfoy66lVd3RzR/HmkcPFa8cZwECSrdGio9g1mEFcR+Cs0hT
	 qD4dW7pYiXAQSkCLItdKycoIJerG4l3kEnvvR+LXDO7B+yynqa4ONeSkDI3IgBkKi8
	 J3jQ8CmXAD5F7n8jZ78DPLgk8hPcZp9kIEqzNna3NrIVN1KZJFE19Uiq/eMyrokoIh
	 lx/yVj7zlsFoGhy9FXnRqdpHn7NWcaV5vJ0hVC+xMFSNHMuWm7u5OMlQmVwDryvETh
	 cT3BwHM20PQTdsbrKdM/wHe0/HPcE+zwpN5ykqDQOTPLIyRfE69+7RJ1ZXYeyb11Xj
	 tOa3aUZWwQJUA==
Message-ID: <9791b7d2-734b-4148-ad7b-89a374420a9c@kernel.org>
Date: Sat, 4 Apr 2026 13:15:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v1] net: mptcp: fix slab-use-after-free in
 __inet_lookup_established
Content-Language: fr
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260403130734.93981-1-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260403130734.93981-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B454D39AECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jiayuan,

On 03/04/2026 15:07, Jiayuan Chen wrote:
> The ehash table lookups are lockless and rely on
> SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
> during RCU read-side critical sections. Both tcp_prot and
> tcpv6_prot have their slab caches created with this flag
> via proto_register().
> 
> However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
> tcpv6_prot_override during inet_init() (fs_initcall, level 5),
> before inet6_init() (module_init/device_initcall, level 6) has
> called proto_register(&tcpv6_prot). At that point,
> tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
> remains NULL permanently.
> 
> This causes MPTCP v6 subflow child sockets to be allocated via
> kmalloc (falling into kmalloc-4k) instead of the TCPv6 slab
> cache. The kmalloc-4k cache lacks SLAB_TYPESAFE_BY_RCU, so
> when these sockets are freed without SOCK_RCU_FREE (which is
> cleared for child sockets by design), the memory can be
> immediately reused. Concurrent ehash lookups under
> rcu_read_lock can then access freed memory, triggering a
> slab-use-after-free in __inet_lookup_established.

Good catch! Thank you for this patch.

> Fix this by splitting the IPv6-specific initialization out of
> mptcp_subflow_init() into a new mptcp_subflow_v6_init(), which
> is called from mptcpv6_init() after proto_register(&tcpv6_prot)
> has completed. This ensures tcpv6_prot_override.slab correctly
> inherits the SLAB_TYPESAFE_BY_RCU slab cache.

The split makes sense anyway: better to regroup all v6-related init steps.

> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/mptcp/ctrl.c     |  6 +++++-
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  | 15 +++++++++------
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index d96130e49942..5887ddcdb875 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -583,7 +583,11 @@ int __init mptcpv6_init(void)
>  	int err;
>  
>  	err = mptcp_proto_v6_init();
> +	if (err)
> +		return err;
>  
> -	return err;
> +	mptcp_subflow_v6_init();

I think it would be better to move this to mptcp_proto_v6_init, similar
to what is done with mptcp_subflow_init, from mptcp_proto_init.

From there, you can even call it before registering the protocol, at the
beginning, so before inet6_register_protosw, which seems more logical
and similar to what is done in v4. WDYT?

If you send a v2, can you please remove the 'net:' prefix please?
'mptcp:' is enough:

  [PATCH net v2] mptcp: fix (...)

Also, can you add a "Cc: stable" tag please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


