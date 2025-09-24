Return-Path: <netdev+bounces-225945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05584B99BC5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06C71B25769
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F592FFDF3;
	Wed, 24 Sep 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxFxWdmb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DbN2gIVp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wA3+pEj+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GgZQGvcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E10303C85
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715289; cv=none; b=Lx+J0Vgg8YvVsucFDtPwqKF3yk60pyIp/ii7L4xdNzx40U+AeQFtJjFlk4VDykk+rQHuaOTi6sK94k3j4NlXJtZlRJzwbFNTBaVzV7gQCih4T9zRWo7GejMmjGRKVu+seIWId93vrd9w3awci2Z1WwcWCMNx6b2H4/2suNdKka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715289; c=relaxed/simple;
	bh=JxpQ4GQd0QGwXDrmw7/TgTMRjebBE9uCZQS2vfgz/20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adw3H0EL/LX6rt/6pqynmXnsq8Ks0eMDrY2WhpOtfbXYgxlZDwuhwNnVJlnGWTkJQiVxdJjBytT8qElIjDi3fqopbwLaX8W3oI554EG/gsLnd9yGGS8/4qVzuT3+bBIEOchXCITsQ+hmhs8sADEmRR78gOBBEXTnZeVD6Z490cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxFxWdmb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DbN2gIVp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wA3+pEj+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GgZQGvcl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E4085C039;
	Wed, 24 Sep 2025 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758715286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPpReJ0yKkGNQbgPUCD2ulQKPYp8UIZzmuSy7ZKjDE=;
	b=LxFxWdmb7IeF5RQayVvAZjIsIxqppwRi2/PgQ1aO/q6Sp4cxxGfu2iHH4I+nDNgFblwvQg
	yjltAKOPLPcMuztfWpw4aVpvFnempFCHjh8/PSSBV0/NN4j6umKbpfEFvq9IMnSrh0cU+b
	8HyFJjvrvbrb/7mzANFBQECphiahYJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758715286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPpReJ0yKkGNQbgPUCD2ulQKPYp8UIZzmuSy7ZKjDE=;
	b=DbN2gIVpQVrUKbWqF31LFSEYPHr4iqsH3lCFTqzqGV/d6gw24uCCe5v8m/YUpfX1Xb1men
	CAZtjOK82pNASnDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wA3+pEj+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GgZQGvcl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758715285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPpReJ0yKkGNQbgPUCD2ulQKPYp8UIZzmuSy7ZKjDE=;
	b=wA3+pEj+O6DV0fBZGAqnuG47XX2XOkdI3WExiqJP5ZFqPMsdLvDnEOoCrbblkOXo9dkJPr
	+w07h1uhngeph1lPQBFoDvAMkIn1THjFZRUhzALv+QtmzbdZxQwq6oXsAWiN2Skxu4H3qE
	rSqLqIrvbGqHKxjBcWC+lJ/gYUpw/ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758715285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvPpReJ0yKkGNQbgPUCD2ulQKPYp8UIZzmuSy7ZKjDE=;
	b=GgZQGvcllPYHHEPauJSj7UIG8NFHJO0X5Y6D+l2ZdJBj0X8w2QzTRBcVBOiyr4z8SLsJfn
	BGL2bp0VCcEl/dAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F3913647;
	Wed, 24 Sep 2025 12:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id is1LLJTd02hpSQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 24 Sep 2025 12:01:24 +0000
Message-ID: <d7bf939b-040c-49da-8769-0f230d5dcb51@suse.de>
Date: Wed, 24 Sep 2025 14:01:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
To: =?UTF-8?B?SsOhbiBWw6FjbGF2?= <jvaclav@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250922093743.1347351-3-jvaclav@redhat.com>
 <20250923170604.6c629d90@kernel.org>
 <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2E4085C039
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/24/25 1:21 PM, Ján Václav wrote:
> On Wed, Sep 24, 2025 at 2:06 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 22 Sep 2025 11:37:45 +0200 Jan Vaclav wrote:
>>>        if (hsr->prot_version == PRP_V1)
>>>                proto = HSR_PROTOCOL_PRP;
>>> +     if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
>>> +             goto nla_put_failure;
>>
>> Looks like configuration path does not allow setting version if proto
>> is PRP. Should we add an else before the if? since previous if is
>> checking for PRP already
>>
> 
> The way HSR configuration is currently handled seems very confusing to
> me, because it allows setting the protocol version, but for PRP_V1
> only as a byproduct of setting the protocol to PRP. If you configure
> an interface with (proto = PRP, version = PRP_V1), it will fail, which
> seems wrong to me, considering this is the end result of configuring
> only with proto = PRP anyways.
> 

IMO, that is a good point.

> I think the best solution would be to introduce another change that
> allows explicitly setting the version to PRP_V1 if the protocol is set
> to PRP.
> 

I think it would be nice to unify the logic inside the else statement 
when parsing IFLA_HSR_VERSION and the later check for HSR_PROTOCOL_PRP. 
It could be simplified while supporting PRP_V1 explicitly set when PRP 
protocol is set.

Which also makes me wonder, should the enum hsr_version be exposed as 
UAPI? Currently it is under include/linux/if_hsr.h. But then, the naming 
should be something like "HSR_VERSION_HSR_0" or similar.

