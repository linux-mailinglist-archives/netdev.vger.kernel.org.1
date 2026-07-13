Return-Path: <netdev+bounces-307191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tfmrErnwVGqThgAAu9opvQ
	(envelope-from <netdev+bounces-307191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:05:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C893474C19A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:05:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T8UF+O3K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oJ1G8QTi;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YB/8fcVT";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ssZMiUNO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307191-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307191-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD5DF301413F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B789437472;
	Mon, 13 Jul 2026 14:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934D390991
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951444; cv=none; b=eSe/l0z0aMcFS8BWetDzLStxCdk3agJ4yO9QjPzhhtDqSSnVhN1t5AJ40doF/ORmFQ1P04B37Q3PBH2UzGUzZyWSOF1uVpwbSU28bA6woSohbvOiDkcjFuwl7M1On5UJPGg2/VoSEfb8PLrGr6aqLcFAtZUGWKiW9m2+ZDRjNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951444; c=relaxed/simple;
	bh=CxF2moK+A61fQkhbS3WbbJ+a+YTPNLHUXCeIvc33z/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOo5A/RFYWk6dWhvMIaYJLh+RC1fdzvkJU+frDIX1qAN5dSUlazxvdTh4+APYU7KC7cWrrDGik1pGDRJsJuRBZZn5p8twPO/TIHto1tbQJqvfzNdBcSHExiK8Nc+mWkx1cCi5bXlOllc2u7gk4CJSYFXZOEpI5M4RwZuXO0y3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T8UF+O3K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oJ1G8QTi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YB/8fcVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ssZMiUNO; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CCB777909;
	Mon, 13 Jul 2026 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783951441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lklOTcojfYV6TXEmKMEq8kH2N2t+SFSLC6IHkycTE=;
	b=T8UF+O3KxjjjbGiJ+9v1QYn+HFOo3VghJiE1gRlD3tiMfuleDJ0FQgDaAEcdjX+8Q6THql
	kXK2IQt0e6gvyzx8bhaTLUsFXz692VVFhovT0Rn4L0dmBh4ABB4WjEilA+xBTLYsrxYEBc
	AXjQb8YDe2klVXuwkpkcJ9NLfLIUMio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783951441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lklOTcojfYV6TXEmKMEq8kH2N2t+SFSLC6IHkycTE=;
	b=oJ1G8QTi+QAWY5v8EdiY64beLONUL+BeH6njUVhSH1+IUOCsDe69SW4gNbnfJS2Xfp6JJ1
	8k4Yjv0nUnMyI7Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783951440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lklOTcojfYV6TXEmKMEq8kH2N2t+SFSLC6IHkycTE=;
	b=YB/8fcVT0jn9EeLJ6tgssh4D/muXTLuBB72/FsdwfMkDu1x5ZayvnxXH56DIDxQTGsbtUn
	6bTFrcR7DetMLgNYGayOZYAA35DRQchfBHJs9E3zP1dAXa1exCaQVCQ76ibLXIjSlHdBTu
	pgzInPuYEdjVxD9Vnzk0hbtRfqVAbT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783951440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lklOTcojfYV6TXEmKMEq8kH2N2t+SFSLC6IHkycTE=;
	b=ssZMiUNOQ0W4R/OUiXUWzFVNee9MOghtE12gDInBb9HZvFjrSFBCQ1ZYSUB70s3NPPjHoo
	oyJvZJoLWPq/MQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E899A779AE;
	Mon, 13 Jul 2026 14:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ChAmNk/wVGoaFAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 13 Jul 2026 14:03:59 +0000
Message-ID: <1647cdf5-4602-4088-a543-d84daec7d788@suse.de>
Date: Mon, 13 Jul 2026 16:03:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13 RFC net-next] net: cipso: guard IPv4 packet
 manipulation functions
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-12-fmancera@suse.de>
 <CAHC9VhTA8Y+BLOcLcv6X9u3nRU=X7NQz-u4kZuVNL-Yz1mWKxw@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAHC9VhTA8Y+BLOcLcv6X9u3nRU=X7NQz-u4kZuVNL-Yz1mWKxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-307191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:mid,suse.de:email,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C893474C19A

On 7/12/26 6:22 PM, Paul Moore wrote:
> On Sat, Jul 11, 2026 at 9:41 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> To enable compiling the network stack without IPv4, the CIPSO functions
>> that manipulate IPv4 options and generate ICMP errors must be bypassed.
>>
>> Ideally, CIPSO should not be compiled when IPv4 is disabled but
>> currently it is too integrated within netlabel, so let's just bypassed
>> the relevant functions.
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv4/cipso_ipv4.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
> I think I would prefer to make CONFIG_NETLABEL dependent on
> CONFIG_IPV4 at this point in time.  This will keep the code cleaner
> and allow time to do the proper work of wrapping the CIPSO code with
> CONFIG_CIPSO (or similar) and making that dependent on CONFIG_IPV4.
> 

Fair, that works for me too. I am gonna drop this on the v1.

Thank you!
Fernando.

