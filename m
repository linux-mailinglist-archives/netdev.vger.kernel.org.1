Return-Path: <netdev+bounces-173954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C50DA5C8A1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15A87AB54A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1AB1E9B2C;
	Tue, 11 Mar 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KoOUzBlM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjOPsmIx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KoOUzBlM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjOPsmIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E201A5BA4
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708010; cv=none; b=KC9M424EhGkAWNxW3s/qTOOkdsHYoJFSSsguAjqZmgheoJCt9/ImrSGCeZyPzAANOm90SzQnRzj7uoNowfwJbcnCLb105BvmwK1wru+TTodBTwLr6aiy4njycr18wbOZihu9k3y5Q2yTDXTIqzEPLRGGsQlTGpwv9zI2KHPm3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708010; c=relaxed/simple;
	bh=XsjNpBK5ZcSrSC/xc3DxnK1gVpo2zmX3Vqc8ZJJCPWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiJbYpgbZhJTLicNDUeF34pSNlmVXMBr8xvjMxw5CQgrQ8sBpXo44qAa0FlEfC3ceOe8vOAdMO/C0MiFYVCtVKaiBFlfO8LSz6BvtYqLib50yn33YiolnrnCINx15Fg9yA8paHUadvSWxzVEl7rAvcaT2wKHyKSBHDTgzvgWXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KoOUzBlM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjOPsmIx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KoOUzBlM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjOPsmIx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29B39210F4;
	Tue, 11 Mar 2025 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741708006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3oherzCMUXjtYIF1ejjUtJkcZvyvW/dxDTzBhXyNRQ=;
	b=KoOUzBlMemMLreYbo46bxIO96b32y+jV55OjpF3JGKg6XBo4TTcle/UhCUx/P+d5Q8KLt0
	bqS+d/3EIwjTFQZiieuqp5t1ANE7o0DXw5gS2kwUh9nAK3ifTPQ3+A40uI8gg9lPOnAZnE
	kenh69Zfx+Jhi5Pkb3ZrevD3q93KqKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741708006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3oherzCMUXjtYIF1ejjUtJkcZvyvW/dxDTzBhXyNRQ=;
	b=fjOPsmIxa2oKzV/8IOob/bR1RN4azFo89M9K5mUHusbUxsNueDNrelb4XFI3/muKWbbNzI
	/eNJIrXZY7bPLEDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KoOUzBlM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fjOPsmIx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741708006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3oherzCMUXjtYIF1ejjUtJkcZvyvW/dxDTzBhXyNRQ=;
	b=KoOUzBlMemMLreYbo46bxIO96b32y+jV55OjpF3JGKg6XBo4TTcle/UhCUx/P+d5Q8KLt0
	bqS+d/3EIwjTFQZiieuqp5t1ANE7o0DXw5gS2kwUh9nAK3ifTPQ3+A40uI8gg9lPOnAZnE
	kenh69Zfx+Jhi5Pkb3ZrevD3q93KqKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741708006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3oherzCMUXjtYIF1ejjUtJkcZvyvW/dxDTzBhXyNRQ=;
	b=fjOPsmIxa2oKzV/8IOob/bR1RN4azFo89M9K5mUHusbUxsNueDNrelb4XFI3/muKWbbNzI
	/eNJIrXZY7bPLEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB3A9134A0;
	Tue, 11 Mar 2025 15:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbFwOOVa0GficgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Mar 2025 15:46:45 +0000
Message-ID: <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
Date: Tue, 11 Mar 2025 16:46:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
To: Jakub Kicinski <kuba@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250311111511.2531b260@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29B39210F4
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/11/25 11:15, Jakub Kicinski wrote:
> On Mon, 10 Mar 2025 14:35:24 +0000 Matthew Wilcox (Oracle) wrote:
>> Long-term, networking needs to stop taking a refcount on the pages that
>> it uses and rely on the caller to hold whatever references are necessary
>> to make the memory stable.
> 
> TBH I'm not clear on who is going to fix this.
> IIRC we already told NVMe people that sending slab memory over sendpage
> is not well supported. Plus the bug is in BPF integration, judging by
> the stack traces (skmsg is a BPF thing). Joy.

Hmm. Did you? Seem to have missed it.
We make sure to not do it via the 'sendpage_ok()' call; but other than
that it's not much we can do.

And BPF is probably not the culprit; issue here is that we have a kvec, 
package it into a bio (where it gets converted into a bvec),
and then call an iov iterator in tls_sw to get to the pages.
But at that stage we only see the bvec iterator, and the information
that it was an kvec to start with has been lost.

All wouldn't be so bad if we wouldn't call get_page/put_page (the caller
holds the reference, after all), but iov iterators and the skmsg code
insists upon.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

