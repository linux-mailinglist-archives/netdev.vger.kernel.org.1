Return-Path: <netdev+bounces-215510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F4B2EE94
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D1D1C84A00
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D982E8B94;
	Thu, 21 Aug 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JbydOtTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3zNQ49Rl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JbydOtTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3zNQ49Rl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A292E88B2
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758836; cv=none; b=UR3rYqVK8B6T/8IFotn9sF6J92oqlXTjXpfKe/pou91FccnN/FCjU7Q4QxfwwFwkin3cq79EFV4sDA5budFG8JKFzOU5Ef/fx1CfI30KtoQq88PNmZJ3bpdR8WyKvLUuL6bUL/EjkFbXoFJD/eMnVp5JqxJQuHglN7oXbJsNrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758836; c=relaxed/simple;
	bh=TjXWvJKB+2qBJCYpvpMyHm9kWT+TXRQtLMuQMwKQW/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpTnAE/Aq/yzKxZHD9mNRYhhmy1gIgc9wR0VUyPxNmTq7RHmdJauw4dVU+Kw3p0KS5fz3G4HsGQnAfAECCQjDJGzKIDffNImE/HwpxLRsDm5lhDPI8sBo18t2kNqF107zNakWSAuWIxbbvJpnum8ziOBUoV8/PD2esOU0iqrXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JbydOtTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3zNQ49Rl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JbydOtTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3zNQ49Rl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 169561F7C7;
	Thu, 21 Aug 2025 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755758833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLRhyqFm8SiIehFhfynIEPF7Ujw9moFt7tZyPdJKd68=;
	b=JbydOtTbDFmLuEqIpOQfYA/bUuMS4guyS0mz4Hsasw+nERRNzfwZbcbAVOXqkL7ChoqqUS
	EQNp3OC42Ei2hyJ/uVSVwuMuEnxinulyvfn6Kf5/44gIEO8HcRSB8i+I9/4MGH2Jns0ek7
	owYjlyDgZQdOoyR+XBffD5f2Zpey18s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755758833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLRhyqFm8SiIehFhfynIEPF7Ujw9moFt7tZyPdJKd68=;
	b=3zNQ49Rlga5TKHqwFMLXoy11oYEGWjJI3FtYxtYdbHf6eAp6m1ZHy2Hf55baNfXDzJait/
	2kKWkOR9TBXtDqCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JbydOtTb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3zNQ49Rl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755758833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLRhyqFm8SiIehFhfynIEPF7Ujw9moFt7tZyPdJKd68=;
	b=JbydOtTbDFmLuEqIpOQfYA/bUuMS4guyS0mz4Hsasw+nERRNzfwZbcbAVOXqkL7ChoqqUS
	EQNp3OC42Ei2hyJ/uVSVwuMuEnxinulyvfn6Kf5/44gIEO8HcRSB8i+I9/4MGH2Jns0ek7
	owYjlyDgZQdOoyR+XBffD5f2Zpey18s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755758833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLRhyqFm8SiIehFhfynIEPF7Ujw9moFt7tZyPdJKd68=;
	b=3zNQ49Rlga5TKHqwFMLXoy11oYEGWjJI3FtYxtYdbHf6eAp6m1ZHy2Hf55baNfXDzJait/
	2kKWkOR9TBXtDqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8841913867;
	Thu, 21 Aug 2025 06:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiZDH/DApmg0dwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 21 Aug 2025 06:47:12 +0000
Message-ID: <1bc0eb81-3ccf-479e-924d-f0672daf5fab@suse.de>
Date: Thu, 21 Aug 2025 08:47:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/1] net/tls: allow limiting maximum record size
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, chuck.lever@oracle.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, borisp@nvidia.com,
 john.fastabend@gmail.com
Cc: alistair.francis@wdc.com, dlemoal@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250808072358.254478-3-wilfred.opensource@gmail.com>
 <20250808072358.254478-5-wilfred.opensource@gmail.com>
 <a9ea0abf-1f11-4760-80b8-6a688e020093@suse.de>
 <90cc9b71e356a94e593b66614bbb28a542ca204c.camel@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <90cc9b71e356a94e593b66614bbb28a542ca204c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 169561F7C7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 8/21/25 08:18, Wilfred Mallawa wrote:
> On Mon, 2025-08-18 at 08:31 +0200, Hannes Reinecke wrote:
>>
> [snip]
>>> --- a/include/uapi/linux/handshake.h
>>> +++ b/include/uapi/linux/handshake.h
>>> @@ -54,6 +54,7 @@ enum {
>>>    	HANDSHAKE_A_DONE_STATUS = 1,
>>>    	HANDSHAKE_A_DONE_SOCKFD,
>>>    	HANDSHAKE_A_DONE_REMOTE_AUTH,
>>> +	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
>>>    
>>>    	__HANDSHAKE_A_DONE_MAX,
>>>    	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
>>> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
>>> index f55d14d7b726..44c43ce18361 100644
>>> --- a/net/handshake/genl.c
>>> +++ b/net/handshake/genl.c
>>> @@ -16,10 +16,11 @@ static const struct nla_policy
>>> handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>>>    };
>>>    
>>>    /* HANDSHAKE_CMD_DONE - do */
>>> -static const struct nla_policy
>>> handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
>>> +static const struct nla_policy
>>> handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] =
>>> {
>>
> Hey Hannes,
> 
> I did consider using HANDSHAKE_A_DONE_MAX, but wasn't sure if the
> existing convention is there for some reason. But I can switch over if
> you think that is best.
> 
I guess, no reason, just an oversight.

>> Shouldn't that be 'HANDSHAKE_A_DONE_MAX'?
>>
>>>    	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>>>    	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>>>    	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
>>> +	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32,
>>> },
>>>    };
>>>    
>>>    /* Ops table for handshake */
>>> @@ -35,7 +36,7 @@ static const struct genl_split_ops
>>> handshake_nl_ops[] = {
>>>    		.cmd		= HANDSHAKE_CMD_DONE,
>>>    		.doit		= handshake_nl_done_doit,
>>>    		.policy		=
>>> handshake_done_nl_policy,
>>> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
>>> +		.maxattr	=
>>> HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
>>
>> HANDSHAKE_A_DONE_MAX - 1?
> 
> Shouldn't it be `HANDSHAKE_A_DONE_MAX`? Unless the existing
> `HANDSHAKE_A_DONE_REMOTE_AUTH` is incorrect?
> 
Yes, you are right.

Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

