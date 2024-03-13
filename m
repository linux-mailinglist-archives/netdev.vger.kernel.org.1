Return-Path: <netdev+bounces-79653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5A87A6C5
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 12:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D3C285486
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414563E48F;
	Wed, 13 Mar 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oytuo1+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJDoVsnj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oytuo1+m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJDoVsnj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22A3E498
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328112; cv=none; b=mEpHZPTdFbCzTzazCYysqmr0WTwQWrXu4pnrcz3klEm2iPAlURQvNCRJXiYAmp+/28QQNUKt+OH7tSYAIynMGgiFzZaUWk99FoQ/8AqT2HlCFX26S4so2iiVv5ueWb3h9ufAe+o+G1H9ZHHzggkWxRuJ+eZb3phJOtbiDW+7Z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328112; c=relaxed/simple;
	bh=Fmo69yY1+pPYP44JG6f8Wfvyts+gizGod8NnjVy4ypQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CxIpK1SJh3qp//Hgf68U+oHd67ZJbsHyyDm+SxzBXd7HFF3VGMh9pOWL+dqtoixm1C45ssJ4KS8rOzZMF7ZH+liNnwluD7KKpo8sYmp9KsdnElSNX4KcABql6udF77zjxoIYKHwq/8/Sqqbw1my/qN0sr8RDUyPHj2meFom9ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oytuo1+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJDoVsnj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oytuo1+m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJDoVsnj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B114F21C57;
	Wed, 13 Mar 2024 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710328108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4LKd3QAjUvc04sqveYWaQVBmQFJGamxTKrONu69/80=;
	b=oytuo1+mLn/uSW9k4UB0MbTO9HzDQEVlyM+7DOCY3tb66F/suu0mIX1O6QBUXcAcgiJ1fu
	RD3U2Zo0CCe8970r9Tdxxm3Nq0gmELPgStqw2Q0KTfDl2cpoIidWGALc1s7wHsj5oLXw24
	QMEOVJFnug/2AnD0yiBgHDaNAa7v3fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710328108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4LKd3QAjUvc04sqveYWaQVBmQFJGamxTKrONu69/80=;
	b=RJDoVsnjXAzGbFk7MVwgysmp4KEBB+70NOgrVoWkjg3ac+xlZYhPVxK22spBzaAT/37NaZ
	v8k4+l6nssZjFiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710328108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4LKd3QAjUvc04sqveYWaQVBmQFJGamxTKrONu69/80=;
	b=oytuo1+mLn/uSW9k4UB0MbTO9HzDQEVlyM+7DOCY3tb66F/suu0mIX1O6QBUXcAcgiJ1fu
	RD3U2Zo0CCe8970r9Tdxxm3Nq0gmELPgStqw2Q0KTfDl2cpoIidWGALc1s7wHsj5oLXw24
	QMEOVJFnug/2AnD0yiBgHDaNAa7v3fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710328108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4LKd3QAjUvc04sqveYWaQVBmQFJGamxTKrONu69/80=;
	b=RJDoVsnjXAzGbFk7MVwgysmp4KEBB+70NOgrVoWkjg3ac+xlZYhPVxK22spBzaAT/37NaZ
	v8k4+l6nssZjFiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED2213977;
	Wed, 13 Mar 2024 11:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QqkjGyyJ8WUCGQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Wed, 13 Mar 2024 11:08:28 +0000
Message-ID: <051e50e1-9351-4db3-b62d-e7a042115ddb@suse.de>
Date: Wed, 13 Mar 2024 14:08:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 0/5] tc: more JSON fixes
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240312225456.87937-1-stephen@networkplumber.org>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oytuo1+m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RJDoVsnj
X-Spamd-Result: default: False [-2.65 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.35)[76.56%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.65
X-Rspamd-Queue-Id: B114F21C57
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org



On 3/13/24 01:53, Stephen Hemminger wrote:
> Some more places in TC where JSON output is missing or could
> be corrupted. And some things found while reviewing tc-simple
> man page.

The series mixes the fixes with new features like json support.
It makes sense to split fixes and new features  

> 
> Stephen Hemminger (5):
>   tc: support JSON for legacy stats
>   pedit: log errors to stderr
>   skbmod: support json in print
>   simple: support json output
>   tc-simple.8: take Jamal's prompt off examples
> 
>  man/man8/tc-simple.8 | 12 ++++++------
>  tc/m_pedit.c         |  6 +++---
>  tc/m_simple.c        |  8 +++++---
>  tc/m_skbmod.c        | 37 +++++++++++++++++++++----------------
>  tc/tc_util.c         | 28 +++++++++++++++-------------
>  5 files changed, 50 insertions(+), 41 deletions(-)
> 

