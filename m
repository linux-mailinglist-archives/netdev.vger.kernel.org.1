Return-Path: <netdev+bounces-256356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP+MLM4jgmnPPgMAu9opvQ
	(envelope-from <netdev+bounces-256356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:35:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D17DC0E8
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF9F30DED6D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78E3C199E;
	Tue,  3 Feb 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNX8DAcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F603A7F56;
	Tue,  3 Feb 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135855; cv=none; b=ECK1NRyLV/iRcI1OHe2uSR4M1krHBAJIibnQTseq5DV2e2e7Xvm4P0MCM2GBRUBBXVq2FSd73huXPyDgnQYclxWcIGC+mLSEAOLtdoVY6uLUhnHAhq8C1ENf8zSV5p+u3YPbnyggN8Ua3XP9/+ReR5AxxVKPUDyQB10+oQMeT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135855; c=relaxed/simple;
	bh=UWL63PlrH5dx1YV4/npYBCR6YdRRIjBmFXH2fSR0HVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxJpUE3qk96OZmZHB8Y2gFfI1k0I9xrem3U0F9WF1idGb5MiUtfFUZNmsLNBOpLWZk8mbChRLk8dGhPwcjuDnQBFpeZGsioKO7l2tzopN3ZaEEGP07DsSXmZMjLtusWjS6ANSdKPR+IPs7enWlJ7iisYYsKBQQagl0aWmY59Jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNX8DAcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E06AC2BC86;
	Tue,  3 Feb 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135854;
	bh=UWL63PlrH5dx1YV4/npYBCR6YdRRIjBmFXH2fSR0HVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uNX8DAcb1rZSnpFRIYqJir9PKQomw7yC3fu896hkVqVDNBVNov64QRbyMvoPx8j1P
	 CbDPmm5Gxi0//DJCgpovRCj8MwIWlQ4Piy0kfRAh6Uk/ca047e7/sbk7qS/qbd+ABG
	 TfG1RQV1VjDQqg7QTE0W6V1sUWeV9jZ44r2lEbzEltUZ6z9NYQ8/nl/2wnhKySvE25
	 SvtBWBro/rMQe0x4NTVGhH3HTWQDjb3CUpomCqP0uebOi3G6GeP355aGibu/i4Ltnb
	 SSdrJDUL2jS2gU8yxs3z3ZDL0GoDEwuntACOWaHIudC1sUmtr2LhWl4RNFE2kjlNKC
	 QE9X2rUEoCAqA==
Message-ID: <1cbd0d2e-2002-4685-99eb-97dd8947cf16@kernel.org>
Date: Tue, 3 Feb 2026 09:24:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] icmp: fix ip_rt_bug race in icmp_route_lookup
 reverse path
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20260128090523.356953-1-jiayuan.chen@linux.dev>
 <892557d1-9408-40e3-8e79-587713116b93@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <892557d1-9408-40e3-8e79-587713116b93@redhat.com>
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
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256356-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55D17DC0E8
X-Rspamd-Action: no action

On 2/3/26 3:41 AM, Paolo Abeni wrote:
> On 1/28/26 10:05 AM, Jiayuan Chen wrote:
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index 19c9c838967f..dc9dcc799824 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -559,6 +559,23 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>>  		/* steal dst entry from skb_in, don't drop refcnt */
>>  		skb_dstref_steal(skb_in);
>>  		skb_dstref_restore(skb_in, orefdst);
>> +
>> +		/*
>> +		 * At this point, fl4_dec.daddr should NOT be local (we
>> +		 * checked fl4_dec.saddr above). However, a race condition
>> +		 * may occur if the address is added to the interface
>> +		 * concurrently. In that case, ip_route_input() returns a
>> +		 * LOCAL route with dst.output=ip_rt_bug, which must not
>> +		 * be used for output.
>> +		 */
>> +		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
>> +			net_warn_ratelimited("%s: detected local route for %pI4 "
>> +					     "during ICMP error handling (src %pI4), "
>> +					     "possible address race\n",
>> +					     __func__, &fl4_dec.daddr, &fl4_dec.saddr);
> 
> The fix looks correct to me, but this patch should target the 'net' tree
> and the above warning message is a bit off: the text string should not
> be broken to fit the 80 chars limit - it need to be greepable - it's
> probably better to not include the function name.
> 
> /P
> 

Does the message even provide value? There is nothing a user can do
about it.

