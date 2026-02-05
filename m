Return-Path: <netdev+bounces-257228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALilEG61hGk54wMAu9opvQ
	(envelope-from <netdev+bounces-257228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:21:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBDAF4895
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6021B3037D45
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B03421EEB;
	Thu,  5 Feb 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPbYWvSl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644884219EA;
	Thu,  5 Feb 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304640; cv=none; b=jpz2KMKl5eYek7+8QV/URgV5nnrxCY5iYp6pj4mF7xyAOyxu7Pf5YQBMzXk+XoUFG/MreL43M1qRXmHehAMQ3f8IqN7TJ27GgscdVRdU1l8miBgCWvIwXDz/m/wS/4Tv9IXPMrRpfi9mV/BahJ21rUHvco9ThAtLI2DDRUEbqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304640; c=relaxed/simple;
	bh=onueHI0K3xDyK9MbLPw82Ld8YE0/UOYfDnEz+T3CClg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBNTtzQkXnEZRb+MBLvXgtwVvYe3bpUwwLymIiLg23bjwk6RtUn7ipcv/nvKTiMj6k7B5fSMEiX3DAGyCSwnUnoIKcB222DyZodP1KOkiUMNrq5SJ+g/jq8WckZps36b1Iih/c4C9TPs5Bp/jAdo5YIHglZa218S0kXCVAwM/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPbYWvSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81429C19421;
	Thu,  5 Feb 2026 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770304640;
	bh=onueHI0K3xDyK9MbLPw82Ld8YE0/UOYfDnEz+T3CClg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nPbYWvSlmkHWjM5thdi+JMbeCervwbXV+7y5C8SwcL3fjwI5G9gFEv/2faARaM1gq
	 WqKHSBgDYmWITLRclDLzzjVQOt7QO4Xt0rdOVzOA/fdfde92ZO+54g1jjvL+h0/hl+
	 TpgmYdBG+w2zBqTw4eEmyGxPzP5CAkHFXn+5H9C9pUBE803xCftjI++etQ5QMRZITY
	 eSteer2Hvm6K1hj5CTJ8xvCOJpBL3in843n0GhkxNh6YjS8TGPAWYcMNGWSWXBqvqE
	 zG78E2FTMe2H3XH+IyyeW5jps8Fuf/aAC3FyMJVJLZhxEUp5FVWybvslyQ8+Tlu4ai
	 K9n9qiQ9OTTTw==
Message-ID: <62b51184-cc76-42cc-beea-91b6e815132f@kernel.org>
Date: Thu, 5 Feb 2026 08:17:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] xfrm: fix ip_rt_bug race in icmp_route_lookup
 reverse path
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org
References: <20260205070203.61560-1-jiayuan.chen@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260205070203.61560-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257228-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8CBDAF4895
X-Rspamd-Action: no action

On 2/5/26 12:02 AM, Jiayuan Chen wrote:
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 4abbec2f47ef..35816ac749bc 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -554,6 +554,22 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  		/* steal dst entry from skb_in, don't drop refcnt */
>  		skb_dstref_steal(skb_in);
>  		skb_dstref_restore(skb_in, orefdst);
> +
> +		/*
> +		 * At this point, fl4_dec.daddr should NOT be local (we
> +		 * checked fl4_dec.saddr above). However, a race condition
> +		 * may occur if the address is added to the interface
> +		 * concurrently. In that case, ip_route_input() returns a
> +		 * LOCAL route with dst.output=ip_rt_bug, which must not
> +		 * be used for output.
> +		 */
> +		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
> +			net_warn_ratelimited("detected local route for %pI4 "
> +					     "during ICMP sending, src %pI4\n",
> +					     &fl4_dec.daddr, &fl4_dec.saddr);

per Paolo comment on the previous revision of this patch, strings should
not be split across lines like this. It should be:

net_warn_ratelimited("detected local route for %pI4 during ICMP sending,
src %pI4\n",

> +			dst_release(&rt2->dst);
> +			err = -EINVAL;
> +		}
>  	}
>  
>  	if (err)


