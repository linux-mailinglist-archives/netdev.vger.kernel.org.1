Return-Path: <netdev+bounces-268964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBZrEg99ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C62B9D40
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE553008A6A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791535F178;
	Wed, 18 Mar 2026 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m58w9ODy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c8OUwMOJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m58w9ODy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c8OUwMOJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF235F19A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829151; cv=none; b=Gdw8YZ2h9qeBJxvgt0ofFfLaKEWGKXMarf3HS22ctmdSrjK1OIWxtsSW+eGZHQ71LOwXpc4A/OtwgqHSldTU5xhTf/ccnDNkSN+9xD1msdanfcqCY3UMzCcibbtmBmfAtYnBMcDxPbuinEhNwxI9G6tRCJJ1eaur4o/QLy4xy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829151; c=relaxed/simple;
	bh=RmEpKvcq8I8EY2NBhxBskpaqM0cJKvPOQiX/1zcBsqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaAU8VMZ1T9dmcx7i5BfXmnBDGRmK0nJ8q0kG9QsaDojLMH0nfYI+dyThe4aEOqC9sT1vqSLs7d6vPqfC7Rn3smm8Hu8B/YyhSSGqu1Ffqc0hFIHD4O7RFtJdSEksbwnn7AlopZOVjYD/itNuwhWEwexV5oGQUHIl7aUnw4s1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m58w9ODy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c8OUwMOJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m58w9ODy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c8OUwMOJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 750B75BE63;
	Wed, 18 Mar 2026 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773829147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veqsxEueYua28OB3IyEPWKiA+1Ll3WhKhZ0WzC9oIfQ=;
	b=m58w9ODy85xkrnOId2laanF926AwBNxfqFYW1ScOkm2YPyJBncZ0/rg31d5JSbYf2kIvyF
	/AGiGoJyi7THdLaxUU7xVv2CuqcA0A7lmog2ixUMsivilD/cf419nrqKgIGlC8b2b1SPGz
	QLsPgpYZs2Enf1VGGtuaC+1sGY+irAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773829147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veqsxEueYua28OB3IyEPWKiA+1Ll3WhKhZ0WzC9oIfQ=;
	b=c8OUwMOJiHdQDvu/e7pAv/T0tYTss4HPmuj06kxnCEj5Be44R0DODmADK9QUF2bGoida3W
	w8fZRWbsg0zRr+Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m58w9ODy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c8OUwMOJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773829147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veqsxEueYua28OB3IyEPWKiA+1Ll3WhKhZ0WzC9oIfQ=;
	b=m58w9ODy85xkrnOId2laanF926AwBNxfqFYW1ScOkm2YPyJBncZ0/rg31d5JSbYf2kIvyF
	/AGiGoJyi7THdLaxUU7xVv2CuqcA0A7lmog2ixUMsivilD/cf419nrqKgIGlC8b2b1SPGz
	QLsPgpYZs2Enf1VGGtuaC+1sGY+irAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773829147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veqsxEueYua28OB3IyEPWKiA+1Ll3WhKhZ0WzC9oIfQ=;
	b=c8OUwMOJiHdQDvu/e7pAv/T0tYTss4HPmuj06kxnCEj5Be44R0DODmADK9QUF2bGoida3W
	w8fZRWbsg0zRr+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBB514273B;
	Wed, 18 Mar 2026 10:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYmSNhp8umm1XwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Mar 2026 10:19:06 +0000
Message-ID: <ea482a29-b9bd-4365-b771-2bc03bebad3c@suse.de>
Date: Wed, 18 Mar 2026 11:19:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and
 remove stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317124904.552d57e4@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260317124904.552d57e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268964-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A07C62B9D40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 8:49 PM, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 15:00:56 +0100 Fernando Fernandez Mancera wrote:
>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>> a loadable module. While this made sense in the early days of IPv6
>> adoption, modern deployments and distributions overwhelmingly either
>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
>> and memory savings for specific setups, this benefit is outweighed by
>> the architectural burden it imposes on the subsystems on implementation
>> and maintenance.
> 
> Hi Fernando,
> 
> NIPA flags a few failures, still:
> 
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-17--18-00&pw-n=0&pass=0
> 

Hi Jakub,

This is test is applying the series in top of bpf tree which has this 
commit 
https://github.com/kernel-patches/bpf/commit/972787479ee73006fddb5e59ab5c8e733810ff42

AFAICS, net-next tree do not have it yet. I do not think I can do much 
about it for now. Will wait until they are merged and rebase in top of it.

Thanks,
Fernando.

> See stderr for stack trace. The BPF build issue seems to be:
> 
>    ../net/bpf/test_run.c:1160:8: error: use of undeclared identifier 'ipv6_bpf_stub'
>     1160 |                 if (!ipv6_bpf_stub) {
>          |                      ^~~~~~~~~~~~~
>    1 error generated.
>    make[5]: *** [../scripts/Makefile.build:289: net/bpf/test_run.o] Error 1
>    make[4]: *** [../scripts/Makefile.build:546: net/bpf] Error 2
>    make[4]: *** Waiting for unfinished jobs....


