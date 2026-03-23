Return-Path: <netdev+bounces-270512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDIELsI0wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:40:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE722F20DF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFB7304C7F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093503A9624;
	Mon, 23 Mar 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KSyp1VCU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u5OYJ6K3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cm1C5PdI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yoXu0wLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159213A6F16
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269181; cv=none; b=Sh4/kzSyH6ns5gQmddHuO46R/5Y74gt2bkysPU5Foz5dKC443tg1DlOIY7EKACz224O7d3l8wTN1XWSgSHmCS6ayDQRdrktBHGI/bLckcgnjWSsWcn9/w7zm40FNO9azUPU5VQD1h0jAzyYZJaeY6/hOZyT/CtNjFzj6mRxclXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269181; c=relaxed/simple;
	bh=C6AknQJTwVLq6EcVKAY/DNZ+blHJZS/sf+GyHOx+KNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW4h/Xk0MdQyRqtGcFzkYgZP3PvKvLgy8b+lAlxibRcHv2I91OPFd3ETMNGOAMnkD0/QfyHuK8hXvh80+Uy3frEgIlhA+SO4D0+Nk+AyrcIDHYwUvGHwhscR9iPxkZF93aZR7kqKPNYQaLoX53D2dTOPG9M2WvY8H2TxMdwvLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KSyp1VCU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u5OYJ6K3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cm1C5PdI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yoXu0wLk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D02E04D361;
	Mon, 23 Mar 2026 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774269174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fuB2oVomGLSSn53A0JOL5KJFveyWEvLjcUasHMvl4s=;
	b=KSyp1VCUdnwAzsyEsZWVlPgieCiCRNzIK7m7+eOa6+OOaWiCUTb3WyEeD+EhNnO2adn8Lp
	KsKb7aCLgPKbGFpZEyNoxVyVC1mJTvjOZ+iH5aKGtN2g/2bY+uvxI9tY0DQx+TPp2S+uwA
	l4/DTCsVc84HkkwmDn6i28mD2Afu4Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774269174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fuB2oVomGLSSn53A0JOL5KJFveyWEvLjcUasHMvl4s=;
	b=u5OYJ6K3xuCh1imkQF3dbWpwRBdlrYzCN4f0FtbglKZL2/eriLPgrwHnAU9A6WiDKGJ/qg
	sD6tciQ5elXRP9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cm1C5PdI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yoXu0wLk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774269173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fuB2oVomGLSSn53A0JOL5KJFveyWEvLjcUasHMvl4s=;
	b=Cm1C5PdI1rf8hLcfQVOE/D5U1DMYXAaW0sIgVxjswsvpuF2qXKRl0VDHF4sT8bFjDy/+Uo
	HF2LYV0vx+B7to+N6ZznpnpzyZQEndAlyxNmOEElRB+H78CejYWnpdjHSdJVc1l8ZlxI8n
	Sr5m0epQoAOmhnfGHU57fdjdXPb6vNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774269173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fuB2oVomGLSSn53A0JOL5KJFveyWEvLjcUasHMvl4s=;
	b=yoXu0wLkP5U/zzBZ/IKSdXH0QS5yftEJevm6pKOQ36dTG98n7brWLvacv6z9La7nZwXoM+
	27FrYzVmXJe1EPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5265543895;
	Mon, 23 Mar 2026 12:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYQuEfQywWkHIwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Mar 2026 12:32:52 +0000
Message-ID: <cabe1ee3-ca29-4d28-913b-0b55ed8352a0@suse.de>
Date: Mon, 23 Mar 2026 13:32:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260321170354.17a2d888@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260321170354.17a2d888@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-270512-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 2BE722F20DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 1:03 AM, Jakub Kicinski wrote:
> On Fri, 20 Mar 2026 19:55:52 +0100 Fernando Fernandez Mancera wrote:
>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>> a loadable module. While this made sense in the early days of IPv6
>> adoption, modern deployments and distributions overwhelmingly either
>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
>> and memory savings for specific setups, this benefit is outweighed by
>> the architectural burden it imposes on the subsystems on implementation
>> and maintenance.
> 
> I think it breaks BPF LWT tests?
> 
> FWIW you can open a pull request against this repo, and it will run all
> the BPF tests for you: https://github.com/kernel-patches/bpf
> Just delete the code that makes it not build because of the conflict.
> 

All seems to be fine, am I missing something here?

https://github.com/kernel-patches/bpf/pull/11507

