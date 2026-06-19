Return-Path: <netdev+bounces-300680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Tz2IVAVNWoYmwYAu9opvQ
	(envelope-from <netdev+bounces-300680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE06A51F4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nymL+0GF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/yrW3OZP";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nymL+0GF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/yrW3OZP";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300680-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913583004C4E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3C36B048;
	Fri, 19 Jun 2026 10:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73549367F59
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:09:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863757; cv=none; b=TFLJXBH7xOe07ZLabmVImkoNhjYDFjDAvJjZkg8fYe6uAfFc6/81MyA4OayeQL4KQN65+Hm+1YaC7gcRMsT0hhSZ9pP+cGi/kSsc2pdivxdJIpfYqNIfE5CqwbfS+QpS8ZUNI7zFfL2HA4iW2ELDjuj03K5pZYWx7xX3Uv1zo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863757; c=relaxed/simple;
	bh=UFL959+C7cKkdPmHgXmA2wm9UVHEOHJbBDfDFgJvrfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGruUwyc0dGMKTp6OJGMRgMlii+w8mOALuGQWyDXwAPKBGG3CeWRvRfCW8rrWGC/vDVcuc1l9siLX/ZJq87YyRxg/4aTZseL67EIZRyx4VDktIGXj+QXTvlnXfmL4BoW/T9q5h6+ae6MeLqHfNuxayC5JIaSkxW508ePwYMjRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nymL+0GF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yrW3OZP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nymL+0GF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yrW3OZP; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A62F075DEE;
	Fri, 19 Jun 2026 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781863751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RG17UvhYBCERNqERIsfaYgDkHBJcdGDq9fqPGsKv8Y=;
	b=nymL+0GFXjJ7NDjXz5Hi5TAr9LFui64ueUMXthSU7D5mB3cCeKDeqszUmkhptf2nxuA8Pi
	gCorT78EubdS0PCgZNgDKZv/Pg2sAk4s1diDh7lKgSnaoK2UOM/ewyJybahYi3Clk6RS5X
	Td1nXa/OArb1wuASn4FK4DgWdtQ6jXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781863751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RG17UvhYBCERNqERIsfaYgDkHBJcdGDq9fqPGsKv8Y=;
	b=/yrW3OZP1T8Q3+5nzRN5dfIbM4rlwVbeHn+E5tnEJWa+GywTEPUrvB0PLdjtS6ZyywxMnj
	JtTKr7LB7CXqhpCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781863751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RG17UvhYBCERNqERIsfaYgDkHBJcdGDq9fqPGsKv8Y=;
	b=nymL+0GFXjJ7NDjXz5Hi5TAr9LFui64ueUMXthSU7D5mB3cCeKDeqszUmkhptf2nxuA8Pi
	gCorT78EubdS0PCgZNgDKZv/Pg2sAk4s1diDh7lKgSnaoK2UOM/ewyJybahYi3Clk6RS5X
	Td1nXa/OArb1wuASn4FK4DgWdtQ6jXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781863751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RG17UvhYBCERNqERIsfaYgDkHBJcdGDq9fqPGsKv8Y=;
	b=/yrW3OZP1T8Q3+5nzRN5dfIbM4rlwVbeHn+E5tnEJWa+GywTEPUrvB0PLdjtS6ZyywxMnj
	JtTKr7LB7CXqhpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D05779A8;
	Fri, 19 Jun 2026 10:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jh4aMUYVNWqNGgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Jun 2026 10:09:10 +0000
Message-ID: <c3fef5aa-f72f-474e-ba4a-fec4484c784f@suse.de>
Date: Fri, 19 Jun 2026 12:09:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] ipv6: reset value and position for proxy_ndp
 sysctl restart
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-6-fmancera@suse.de>
 <491465c3-0d1a-42f6-86fe-6c31812e23c9@6wind.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <491465c3-0d1a-42f6-86fe-6c31812e23c9@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nicolas.dichtel@6wind.com,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8BE06A51F4

On 6/19/26 11:58 AM, Nicolas Dichtel wrote:
> Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
>> When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
>> retried but as the value was already modified by the initial
>> proc_dointvec() call, the restarted syscall will read the newly modified
>> value as the 'old' state.
>>
>> Fix this by restoring the original value and position pointer before
>> restarting the syscall.
> Is it not better to call rtnl_net_trylock() at the beginning of the function?
> It avoids flapping the sysctl value.
> 

IMHO it is not better if we want to reduce the time we are holding RTNL 
lock. I think the idea is that if the user introduces a invalid value, 
we don't need to take the lock at all.

That is the general pattern I see around the sysctl code (IPv4 and 
IPv6). Given the current efforts to reduce the usage of RTNL I think 
this approach would be better.

In any case, it is not a blocker for me so if we all agree that your 
suggestion is better I don't mind taking that path.

Thanks for all the reviews!

>>
>> Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv6/addrconf.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 8ff015975e27..1cfb223476bd 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -6483,8 +6483,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
>>   		void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>   	int *valp = ctl->data;
>> -	int ret;
>> +	loff_t pos = *ppos;
>>   	int old, new;
>> +	int ret;
>>   
>>   	old = *valp;
>>   	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
>> @@ -6493,8 +6494,12 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
>>   	if (write && old != new) {
>>   		struct net *net = ctl->extra2;
>>   
>> -		if (!rtnl_net_trylock(net))
>> +		if (!rtnl_net_trylock(net)) {
>> +			/* Restore the original values before restarting */
>> +			*valp = old;
>> +			*ppos = pos;
>>   			return restart_syscall();
>> +		}
>>   
>>   		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
>>   			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> 
> 


