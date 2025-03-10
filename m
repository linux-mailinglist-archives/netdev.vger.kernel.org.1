Return-Path: <netdev+bounces-173595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06EA59BCE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF11631B6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E819004A;
	Mon, 10 Mar 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zs0y5OWI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcyBU8/T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zs0y5OWI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcyBU8/T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3322D4C3
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625876; cv=none; b=pLFvL535B8wOp8fwR3r3Pg847j7v0lm4eljT4+SXRYo5sJhb/QzbNbl5i6Gu64fnQpgEHrWUV4ikLJ2mYu8XOSneTmwQHCjgtUkCZyk7OH6pcnRAtUUDmTv92As1xceIvnqyCTBS6Gy+mRM0/sn5VOrfzZtbrOCNffFidE4Yvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625876; c=relaxed/simple;
	bh=pyEhOZ4T5wEhluI8BXqIg3KeV59X7Xo0LJIEbsHenXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf3kQbQYz7jG7WvJHmroPtCbB887KIFoWtawNAblULHsBihY9nDNVfHlknOrD8d+CsUE3LvTrvGYteltExmbIsAe3iJ9ezgyRhykdVTvtg9hQhlhf9oflb0v8d8d9X2i7+NyBoS9/MZobDdmGja7Og3gpZSIDuHKi/PlNGcDhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zs0y5OWI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcyBU8/T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zs0y5OWI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcyBU8/T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 206C92116A;
	Mon, 10 Mar 2025 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4w45nsVxHeXtophxwQSVEyLK4/8e3QpCJr29a0SzxY=;
	b=Zs0y5OWIMGaKF3QY3KtGKL+PrIhcMj6H+5+6PANETRoJt1VSR0lfFYuedfr2GbiYSwdcR/
	4tYvJsClRG3SNeZnYA4Tbs7u4AmDFp0tWL4y2VyY4zJjVqAVhBYL9yyFd3dHOt6oR1EySu
	Yn/6G3OAltAec7LRnMhxTrv2dWCUXn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4w45nsVxHeXtophxwQSVEyLK4/8e3QpCJr29a0SzxY=;
	b=YcyBU8/T8/9V9L8iiboFv5kiU6Rx8m7MqftYjDlq6jB0qmWVb5UF4jrkPM3JbqusNRssth
	6oUpG5ux1wY9bOAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zs0y5OWI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="YcyBU8/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4w45nsVxHeXtophxwQSVEyLK4/8e3QpCJr29a0SzxY=;
	b=Zs0y5OWIMGaKF3QY3KtGKL+PrIhcMj6H+5+6PANETRoJt1VSR0lfFYuedfr2GbiYSwdcR/
	4tYvJsClRG3SNeZnYA4Tbs7u4AmDFp0tWL4y2VyY4zJjVqAVhBYL9yyFd3dHOt6oR1EySu
	Yn/6G3OAltAec7LRnMhxTrv2dWCUXn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4w45nsVxHeXtophxwQSVEyLK4/8e3QpCJr29a0SzxY=;
	b=YcyBU8/T8/9V9L8iiboFv5kiU6Rx8m7MqftYjDlq6jB0qmWVb5UF4jrkPM3JbqusNRssth
	6oUpG5ux1wY9bOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F110D139E7;
	Mon, 10 Mar 2025 16:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nw1HOQ8az2f+ZwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 10 Mar 2025 16:57:51 +0000
Message-ID: <77fa8d7e-4752-4979-affe-aa45c8d7795a@suse.de>
Date: Mon, 10 Mar 2025 17:57:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: netdev@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20250310142750.1209192-1-willy@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250310142750.1209192-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 206C92116A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/10/25 15:27, Matthew Wilcox (Oracle) wrote:
> Slab pages now have a refcount of 0, so nobody should be trying to
> manipulate the refcount on them.  Doing so has little effect; the object
> could be freed and reallocated to a different purpose, although the slab
> itself would not be until the refcount was put making it behave rather
> like TYPESAFE_BY_RCU.
> 
> Unfortunately, __iov_iter_get_pages_alloc() does take a refcount.
> Fix that to not change the refcount, and make put_page() silently not
> change the refcount.  get_page() warns so that we can fix any other
> callers that need to be changed.
> 
> Long-term, networking needs to stop taking a refcount on the pages that
> it uses and rely on the caller to hold whatever references are necessary
> to make the memory stable.  In the medium term, more page types are going
> to hav a zero refcount, so we'll want to move get_page() and put_page()
> out of line.
> 
> Reported-by: Hannes Reinecke <hare@suse.de>
> Fixes: 9aec2fb0fd5e (slab: allocate frozen pages)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 7 ++++++-
>   lib/iov_iter.c     | 8 ++++++--
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 

I assume we will have a discussion at LSF around frozen pages/slab
behaviour?
It's not just networking, also every driver using iov_alloc_pages() and
friends is potentially affected.
And it would be good to clarify rules how these iterators should be
used.

But that doesn't affect this patch, so:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

