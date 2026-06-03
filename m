Return-Path: <netdev+bounces-294651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lAjXI8naH2q/rAAAu9opvQ
	(envelope-from <netdev+bounces-294651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E509F635524
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xSWk3Sjf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uGZE9rWZ;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xSWk3Sjf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uGZE9rWZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294651-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294651-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8920303BB3B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F0426D0B;
	Wed,  3 Jun 2026 07:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2679423A97
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:30:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471810; cv=none; b=TlaOMLXP78bWlzuUuU9mR9R37jfSYjsHDU3ziI+bC2sWSlEvcAR6BFGuCawdAkZMq3SKz8HyLdTNU9hyL+IVfg6FbYJn5Qk80S5veP9wyIOAc/d4GUxwDd1oAdFJuZcCwC3BivCsYBayYZHI9wjPEVUsNHGvR8q3ZgGtiHwJyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471810; c=relaxed/simple;
	bh=YxzoIVHbPr3oQc1nQVQasy2iwxvsuBJgEY4HXVBZmqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjVxTxH8gbcQla61zeBmqAxo58H5/twBO4HL23qZEgub5wnwCqzJAOqKT35Bru/PZWKHR7fex13BOUThGmgVCxtMVHchCb+FPB6Mho+M9kJ8TAEUISoCDBvUwVaDVmHlaUMFI1N1r9ydDgnZb9HV9ATY4kbF8MkwVb+YjqgIjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xSWk3Sjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGZE9rWZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xSWk3Sjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGZE9rWZ; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D687E6A814;
	Wed,  3 Jun 2026 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780471804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpNk53TJJJrI1vhGNmcCweBe5RxuqLMJWxMWBJp5NUs=;
	b=xSWk3SjfyEUHYnV8RixbV41okdrSBJUTo6bjowgwWEFdhysxlVoiwnQf84p9V+9NCtGJOW
	11gwNYNBpssT0wX4veHWrgIojW9B2+HHf7kf4N44WbbSx+MtYxbWVrbwUAcq6If88KSvZU
	eB+tf+HZmxo2UHrjc3bRYRq/j+mMa3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780471804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpNk53TJJJrI1vhGNmcCweBe5RxuqLMJWxMWBJp5NUs=;
	b=uGZE9rWZF4DQreq5id8Rvv6DiS246Lf7vaPhPxHYTVzxPZ9+qUoNKxBKVys+mba9rFAF5T
	2fP61wqpw5XNIqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780471804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpNk53TJJJrI1vhGNmcCweBe5RxuqLMJWxMWBJp5NUs=;
	b=xSWk3SjfyEUHYnV8RixbV41okdrSBJUTo6bjowgwWEFdhysxlVoiwnQf84p9V+9NCtGJOW
	11gwNYNBpssT0wX4veHWrgIojW9B2+HHf7kf4N44WbbSx+MtYxbWVrbwUAcq6If88KSvZU
	eB+tf+HZmxo2UHrjc3bRYRq/j+mMa3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780471804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpNk53TJJJrI1vhGNmcCweBe5RxuqLMJWxMWBJp5NUs=;
	b=uGZE9rWZF4DQreq5id8Rvv6DiS246Lf7vaPhPxHYTVzxPZ9+qUoNKxBKVys+mba9rFAF5T
	2fP61wqpw5XNIqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4F52779A7;
	Wed,  3 Jun 2026 07:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id piMwNfvXH2pkVQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 07:30:03 +0000
Message-ID: <ee2b92e5-6d95-4c36-9fa8-6cd2a1572556@suse.de>
Date: Wed, 3 Jun 2026 09:29:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org,
 yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 Chris Adams <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
 <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294651-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:ihuguet@redhat.com,m:matttbe@kernel.org,m:sbrivio@redhat.com,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:linux@cmadams.net,m:david@gibson.dropbear.id.au,m:bgalvani@redhat.com,m:andrew@lunn.ch,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,lunn.ch,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E509F635524

On 6/3/26 9:17 AM, Thorsten Leemhuis wrote:
> On 6/3/26 08:53, Íñigo Huguet wrote:
>> Stating that the order is "random" implies that someone will change
>> the default insertion order in the future, as the documentation says
>> that it's not UAPI. So they'll cause the UAPI breakage that we are
>> trying to avoid now. Moreover, if we consider the default order
>> "random" and state that userspace programs must not rely on it, why
>> can't we change it now?
> 
> Because the UAPI is only indirectly important, as it's "something that
> used to work doesn't anymore" is what matters; you in fact can break the
> UAPI all you want, as long as everything continues to work. Or to quote
> Linus from:
> 

I agree with Thorsten here. We must not break the UAPI. Is the current 
order kind of weird? Yes. But software that is running on real systems 
depends on it.

AFAICS, it is not only NetworkManager but systemd-networkd, cloud 
tooling and any other script that uses netlink. I think we must stick to 
the rule of not breaking userspace and the argument of consistency with 
IPv4 is not appealing to me because that isn't a goal of IPv6, plenty is 
different when you compared both protocols.

We should document that the order matters, no that it is "random" 
because it isn't.

> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-what-qualifies-as-userspace-interface-abi-api-documented-interfaces-etc
> 
> "I just wanted to point out that the argument about whether it's an ABI
> change or not is irrelevant. If it turns out that some program - not a
> test script, but something with relevance to conscious user expectations
> ~ depended on the old broken behavior, then it needs to be done some
> other way.""
> 
> Yes, he talks about ABIs here, but it's the same for APIs.
> 
> Ciao, Thorsten


