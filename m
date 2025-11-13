Return-Path: <netdev+bounces-238333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F4C575A3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07073B5264
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45E2773F;
	Thu, 13 Nov 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UB5scEm+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TM9RTeBT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UB5scEm+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TM9RTeBT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671D269CF1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036168; cv=none; b=XGCO6/vnCf5Wmgj0TTrt6F0eBLGXes5oR3xo5BiUt+b5ca3KU3TPba40EqEN/t1sBIJSKzAmFMjjpv4bM+NWOozflVNyVkHOVsJF1WjmhBZOzU2slFjfyhUosd81ZjxJSiLrROQMivQTO4bBpdA0LxWekiVru+2tcatJL+c/7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036168; c=relaxed/simple;
	bh=wsRGG6xExonMteO70KXROm1dUMDMKMRN3Rv+6t7VLOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvhkTY0LDs8f3AFiXLS8N2396evbiR6phjK4zU/BhOLI9Gq/b4QcIsxj2OnoVSaXJ4bB9M1nHDds1OdU2blhzxhD7ERQtioZ8yhmPYOW1J9/4U/R7IlRSZia8197dS2C+BRuw1lk4gPicvq+NgVuYgkFCPMEguHqTiXAjYDYk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UB5scEm+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TM9RTeBT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UB5scEm+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TM9RTeBT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8579E2126D;
	Thu, 13 Nov 2025 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763036164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g12d8xZoJXNFz+zYSIJmfLdfAUQcvdAH17YmNn2i/PU=;
	b=UB5scEm+HmRzLg4hldr0SEMAlHNSLfYycTw+1HmmFQpryh+/kmD+DFBp9dUvTwHVvOeIP8
	sCQETTJfRTvEvXZ9F6TGs4AZOirs7NcaVU9yUD8TiO4MznQjrHW7/BQtHidMIH0HyJR0/E
	s9ucxzSkjXuXceNF+VVPj/MTLJd5ffc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763036164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g12d8xZoJXNFz+zYSIJmfLdfAUQcvdAH17YmNn2i/PU=;
	b=TM9RTeBTDFKgkXKjaVtuLTexnuacmBfua6pOJOLBZAX98EJjjB3bhMBtrP+3yIGKCfoOCt
	DgoU08SEVLYD8KBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763036164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g12d8xZoJXNFz+zYSIJmfLdfAUQcvdAH17YmNn2i/PU=;
	b=UB5scEm+HmRzLg4hldr0SEMAlHNSLfYycTw+1HmmFQpryh+/kmD+DFBp9dUvTwHVvOeIP8
	sCQETTJfRTvEvXZ9F6TGs4AZOirs7NcaVU9yUD8TiO4MznQjrHW7/BQtHidMIH0HyJR0/E
	s9ucxzSkjXuXceNF+VVPj/MTLJd5ffc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763036164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g12d8xZoJXNFz+zYSIJmfLdfAUQcvdAH17YmNn2i/PU=;
	b=TM9RTeBTDFKgkXKjaVtuLTexnuacmBfua6pOJOLBZAX98EJjjB3bhMBtrP+3yIGKCfoOCt
	DgoU08SEVLYD8KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 036173EA61;
	Thu, 13 Nov 2025 12:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UQo8OQPMFWnEHQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 13 Nov 2025 12:16:03 +0000
Message-ID: <60edfea6-7e33-4e95-a6ec-e768ec6f39fb@suse.de>
Date: Thu, 13 Nov 2025 13:15:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: clear RA flags when adding a static route
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Garri Djavadyan <g.djavadyan@gmail.com>
References: <20251110230436.5625-1-fmancera@suse.de>
 <a4c8e0da-700d-4ebe-b5c9-ffc4b9eebc62@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <a4c8e0da-700d-4ebe-b5c9-ffc4b9eebc62@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 11/13/25 1:03 PM, Paolo Abeni wrote:
> On 11/11/25 12:04 AM, Fernando Fernandez Mancera wrote:
>> When an IPv6 Router Advertisement (RA) is received for a prefix, the
>> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
>> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
>>
>> If later a user configures a static IPv6 address on the same prefix the
>> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
>> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
>> kernel sees the route as RA-learned and wrongly configures back the
>> lifetime. This is problematic because if the route expires, the static
>> address won't have the corresponding on-link route.
>>
>> This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
>> the lifetime is configured when the next RA arrives. If the static
>> address is deleted, the route becomes RA-learned again.
>>
>> Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
>> Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
>> Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> Note: this has been broken probably since forever but I belive the
>> commit in the fixes tag was aiming to fix this too. Anyway, any
>> recommendation for a fixes tag is welcomed.
>> ---
>>   net/ipv6/ip6_fib.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>> index 02c16909f618..2111af022d94 100644
>> --- a/net/ipv6/ip6_fib.c
>> +++ b/net/ipv6/ip6_fib.c
>> @@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>>   					fib6_set_expires(iter, rt->expires);
>>   					fib6_add_gc_list(iter);
>>   				}
>> +				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
>> +					iter->fib6_flags &= ~RTF_ADDRCONF;
>> +					iter->fib6_flags &= ~RTF_PREFIX_RT;
>> +				}
>>   
>>   				if (rt->fib6_pmtu)
>>   					fib6_metric_set(iter, RTAX_MTU,
> 
> The patch makes sense to me, but I don't want to rush it in the net PR
> I'm going to send soon. Also it would be great to have self-test
> covering this case, could you have a reasonable shot at it?
> 

Sure, I am fine with aiming this for net-next instead if you consider it 
safer.

Thanks,
Fernando.

