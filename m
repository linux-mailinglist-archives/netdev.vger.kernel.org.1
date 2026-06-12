Return-Path: <netdev+bounces-298747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MP/lNZ89LGrdOAQAu9opvQ
	(envelope-from <netdev+bounces-298747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:10:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8F67B3BF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O7bKAAUb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cvhngrHr;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O7bKAAUb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cvhngrHr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 568863013A54
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8A405C45;
	Fri, 12 Jun 2026 17:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBE405859
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284184; cv=none; b=odIninQBcuKefLHwzTvjV9QYbEkwMjumIajVfqfD5Ec0rUl3YYIlhDuQAIx2bjEOCsp6IN3CrXDOg5hVcTtSNq2FCN7kYqIZUJXtkvyQxpG3umosD5wn+UDN3cqsGg5gYtFr5y5cnU8SVmWazi34eC71A5zGBFi3pyH8iE9sGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284184; c=relaxed/simple;
	bh=9kB0UfTeSCkMBRmWGNDNFjdMSkwixJI8BzEiqxz9eEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb2q347Efjv/dui//1ttq3dSwMURA+UPhOdk2oyAU2099vBDJ8P+dxPOy0PP15nH0VxlKGYeJEHslI+Ejcb3zA9Kcp12czoBy7qVljcimGoblFUWN9O8zdfVST2EAXkJFVy+1zWn1IA02DRdbXfvfeYwfru9BB5CPzonhx9lsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O7bKAAUb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cvhngrHr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O7bKAAUb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cvhngrHr; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B34984BB5;
	Fri, 12 Jun 2026 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781282670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHqaOsvEfvnQhg0gJC43oq0VxUxfZokOBLkTg1vCgbs=;
	b=O7bKAAUbjE2z4+egvHZ0PEf4EGote2/UFmRjbwCsnAy0mjsCpfwjl3QZNL6LowcLGV71OD
	1auMsMLycCU1HMBzlqJa6L0vHfNB+75Z1h34ikJsg1e1hVN/NQuSzNG4G8CipcH57iuMaZ
	q0ZdwAOFWbopR/ias/vXpKXN0uQYq1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781282670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHqaOsvEfvnQhg0gJC43oq0VxUxfZokOBLkTg1vCgbs=;
	b=cvhngrHrvBPrU1HLbUkrQ02naf+wR4muWkL8wfor3ZuDIBxnN+sI3PGwuxEzkUUmes6ScZ
	9LuPAwzXuvQe/dBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781282670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHqaOsvEfvnQhg0gJC43oq0VxUxfZokOBLkTg1vCgbs=;
	b=O7bKAAUbjE2z4+egvHZ0PEf4EGote2/UFmRjbwCsnAy0mjsCpfwjl3QZNL6LowcLGV71OD
	1auMsMLycCU1HMBzlqJa6L0vHfNB+75Z1h34ikJsg1e1hVN/NQuSzNG4G8CipcH57iuMaZ
	q0ZdwAOFWbopR/ias/vXpKXN0uQYq1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781282670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHqaOsvEfvnQhg0gJC43oq0VxUxfZokOBLkTg1vCgbs=;
	b=cvhngrHrvBPrU1HLbUkrQ02naf+wR4muWkL8wfor3ZuDIBxnN+sI3PGwuxEzkUUmes6ScZ
	9LuPAwzXuvQe/dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B33A779A7;
	Fri, 12 Jun 2026 16:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GAoxJW43LGp5IwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 12 Jun 2026 16:44:30 +0000
Message-ID: <71af4535-96bf-422b-9177-8aa7e9666c80@suse.de>
Date: Fri, 12 Jun 2026 18:44:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 net-next v6] ipv4: handle devconf post-set actions on
 netlink updates
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net
References: <20260609204520.4670-2-fmancera@suse.de>
 <20260612123820.673243-1-horms@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260612123820.673243-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,suse.de:dkim,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59B8F67B3BF

On 6/12/26 2:38 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ipv4: handle devconf post-set actions on netlink updates
> 
> This commit ensures that IPv4 device configuration parameters updated
> via netlink trigger the same post-modification actions as sysctl updates.
> It addresses the inconsistency by calling devinet_conf_post_set() inside
> inet_set_link_af() and deferring cache flushing.
> 
>> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>> index 8300516fb38f4..a35b72662e431 100644
>> --- a/net/ipv4/devinet.c
>> +++ b/net/ipv4/devinet.c
>> @@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
> [ ... ]
>> +	case IPV4_DEVCONF_FORWARDING:
>> +		if (new == 1) {
>> +			/* it is safe to use container_of() because forwarding case
>> +			 * is only used by the netlink path
>> +			 */
>> +			struct in_device *idev = container_of(cnf, struct in_device, cnf);
>> +
>> +			netif_disable_lro(idev->dev);
> 
> [Severity: High]
> Does calling netif_disable_lro() directly here without acquiring the
> netdev_lock_ops mutex cause lockdep assertion failures?
> 
> Since inet_set_link_af() runs only under rtnl_lock() and does not acquire
> the device ops lock, this direct invocation appears to bypass the locking
> requirements for netif_disable_lro(), which modifies dev->wanted_features
> and invokes netdev_update_features(dev).
> 
> On drivers that opt-in to netdev_lock_ops, does this create a concurrent
> data race on the device features mask? Should this use dev_disable_lro()
> instead, which correctly acquires and releases netdev_lock_ops(dev) around
> the netif_disable_lro() call?
> 

The device operations lock is held when handling IFLA_AF_SPEC at
net/core/rtnetlink.c. Calling netif_disable_lro() is the right thing to
do IMHO. Keep on mind that FORWARDING case here is only triggered by
netlink path and not sysctl.

AI keeps complaining about this but it isn't right AFAICS.

Thanks,
Fernando.

>> +		}
>> +
>> +		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +					    NETCONFA_FORWARDING,
>> +					    ifindex, cnf);
>> +		return true;
> 


