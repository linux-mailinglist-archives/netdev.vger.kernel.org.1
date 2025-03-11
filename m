Return-Path: <netdev+bounces-173766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61418A5B988
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAB31892DA5
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5301EE7B9;
	Tue, 11 Mar 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f7QfzR3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z1FfIyBB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f7QfzR3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z1FfIyBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF53211C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676730; cv=none; b=hpNDjaVRwOhvmKxjQbggMTZ/vA3rYbojxQg+0Uzwr3NBWnmLx+Y2X7VClpZnFMwN8dpbL72fNam0YQdFyPxqLusrnw585qDY4tACYT0jKwy/HVIfkk4rraJD0MCcZqaqCcNG/PT6kpmbJ/n7/CG/dJhKWNQiZzeZcizNMfaUPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676730; c=relaxed/simple;
	bh=PgeoD+W+2LCzSgq2uSlBykh/r4a4AXh4mp0YJyog2Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSOZFNwqwAeyqV1wW5f4bMBuDKoSY4BvwfgYr7JkW41pTSJDbOFeWUxyS87vjRkD0PoA2fR1+UP/xSxYvVQKdhvdIoTXmm5INDi1+5jfWO1BDKCMYq5Ld+7yxVDkc9zo77Eprkbwwr1LtRg8s0nr6/QGXPnJfzynGnP06bod1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f7QfzR3h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z1FfIyBB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f7QfzR3h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z1FfIyBB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DB311F394;
	Tue, 11 Mar 2025 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741676727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFNQexwKrOnJSyYnBMdIDbS9bdKHSGBO3AimUNT58e8=;
	b=f7QfzR3huV30/sFDSqdEyGI5H3xMTzha/amP8oj1djcUIDxTr+mBcf5nBdFmWVgdl9bUrB
	jLjgWomRqYVTyU3qJRwNfaGj3ZFmqV5txPGJSeMICIbeQApqOHL044vZMtp4idvVqumFFt
	Fzr4FWuCCDeTzEzkZXQrw+27HdhnlNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741676727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFNQexwKrOnJSyYnBMdIDbS9bdKHSGBO3AimUNT58e8=;
	b=Z1FfIyBBJGTBBzBtwZPSEkNMvjCfguxqDNZIFHdh+MlTd/jYcTf9GTQbqYw2ErHNonsrs4
	H90tL8ldjmeYvtBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741676727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFNQexwKrOnJSyYnBMdIDbS9bdKHSGBO3AimUNT58e8=;
	b=f7QfzR3huV30/sFDSqdEyGI5H3xMTzha/amP8oj1djcUIDxTr+mBcf5nBdFmWVgdl9bUrB
	jLjgWomRqYVTyU3qJRwNfaGj3ZFmqV5txPGJSeMICIbeQApqOHL044vZMtp4idvVqumFFt
	Fzr4FWuCCDeTzEzkZXQrw+27HdhnlNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741676727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFNQexwKrOnJSyYnBMdIDbS9bdKHSGBO3AimUNT58e8=;
	b=Z1FfIyBBJGTBBzBtwZPSEkNMvjCfguxqDNZIFHdh+MlTd/jYcTf9GTQbqYw2ErHNonsrs4
	H90tL8ldjmeYvtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC89C134A0;
	Tue, 11 Mar 2025 07:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zyyYI7bgz2dBRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Mar 2025 07:05:26 +0000
Message-ID: <e67952a9-f810-4fc9-9fc3-2f94dfba16b6@suse.de>
Date: Tue, 11 Mar 2025 08:05:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
To: Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
References: <20250310142750.1209192-1-willy@infradead.org>
 <77fa8d7e-4752-4979-affe-aa45c8d7795a@suse.de>
 <Z88vUFweLyk5s8UD@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z88vUFweLyk5s8UD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/10/25 19:28, Matthew Wilcox wrote:
> On Mon, Mar 10, 2025 at 05:57:51PM +0100, Hannes Reinecke wrote:
>> On 3/10/25 15:27, Matthew Wilcox (Oracle) wrote:
>> I assume we will have a discussion at LSF around frozen pages/slab
>> behaviour?
>> It's not just networking, also every driver using iov_alloc_pages() and
>> friends is potentially affected.
>> And it would be good to clarify rules how these iterators should be
>> used.
> 
> Sure, we can do that.  I haven't conducted a deep survey of how many
> page users really need a refcount, so I'll have things to learn too.

That would be awesome.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

