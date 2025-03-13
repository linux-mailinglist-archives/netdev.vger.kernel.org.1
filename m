Return-Path: <netdev+bounces-174472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D771A5EE7F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981FB3AC921
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD96F2620C9;
	Thu, 13 Mar 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vDwo1wH5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIxVTYRF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vDwo1wH5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIxVTYRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C81EFF98
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855943; cv=none; b=I10c/UjgfhEo+JTt3ikj8qisi4mVRN8oJIBxNbEdmRDTPwt6xDXAi/2R1kUa4ngNjcsZt8LUzJcALGOuA+sF+yue/dSGH1foZsvA9PjaAUWbxm7/4XSUQj1m9FhDtPD4BuO12ejyTs2sRyJSunx6cBkukTG14KODsvugaOraNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855943; c=relaxed/simple;
	bh=95b3AuP6DHoqGU9is0p0FCM6kAicBFZnMJh5DY7ZkhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhDXVzp9fIFBH4KeuoY5qOtbEOoZ9k+Howy0tNZIpYhyN0f5feF5xtR3epIveIwtbNKT8utuHmC99ZjMuyCg45GPV2PFxIEIY1O0NCr2mz2eDoOW5n2fntgKdznAd8jGOFCKgW2OlrWR94vvssD7arJSWOItOmXan6UYMhAXfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vDwo1wH5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIxVTYRF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vDwo1wH5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIxVTYRF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCF4221192;
	Thu, 13 Mar 2025 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741855939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy5BLDWhW5tuLfn5o9uPMUppzn8JjYggSaYxs0/2H10=;
	b=vDwo1wH5sNx2LEe91tHBU7tx3tj7gx4jeCwXWal7Ga+SOqtw1Ph92bYT9m1n1J8GBL7dVw
	Q2IEvfCensqEtxU1PZ0mg/JHLQ9IYpSbDgICzPzlXx1SIhjjsn/Mz92PbCy8mv5crAgOBW
	5aoGDwTAPRiY2zmLhJW9IU+uWO0b4DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741855939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy5BLDWhW5tuLfn5o9uPMUppzn8JjYggSaYxs0/2H10=;
	b=sIxVTYRFgVIu7DkLYzXwvPJaVdCyD5Z98Q87Q1E4AomzIXpZD+xiDNaUMl9QjNuylqv9NM
	1sg/DCaWRFoGz7CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741855939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy5BLDWhW5tuLfn5o9uPMUppzn8JjYggSaYxs0/2H10=;
	b=vDwo1wH5sNx2LEe91tHBU7tx3tj7gx4jeCwXWal7Ga+SOqtw1Ph92bYT9m1n1J8GBL7dVw
	Q2IEvfCensqEtxU1PZ0mg/JHLQ9IYpSbDgICzPzlXx1SIhjjsn/Mz92PbCy8mv5crAgOBW
	5aoGDwTAPRiY2zmLhJW9IU+uWO0b4DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741855939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy5BLDWhW5tuLfn5o9uPMUppzn8JjYggSaYxs0/2H10=;
	b=sIxVTYRFgVIu7DkLYzXwvPJaVdCyD5Z98Q87Q1E4AomzIXpZD+xiDNaUMl9QjNuylqv9NM
	1sg/DCaWRFoGz7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B9FC13797;
	Thu, 13 Mar 2025 08:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 44qlF8Oc0mdlLQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 08:52:19 +0000
Message-ID: <5075cd03-0a4a-46d3-abac-3eda27b9ddcc@suse.de>
Date: Thu, 13 Mar 2025 09:52:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org> <Z9EgGzPxjOFTKoLj@infradead.org>
 <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
 <Z9KK-n_JxOQ85Vgp@infradead.org>
 <17f4795a-f6c8-4e6c-ba31-c65eab18efd1@suse.de>
 <Z9Ka8-aGagGH0rd5@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9Ka8-aGagGH0rd5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/13/25 09:44, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 09:34:39AM +0100, Hannes Reinecke wrote:
>> nvmf_connect_command_prep() returns a kmalloced buffer.
> 
> Yes.
> 
>> That is stored in a bvec in _nvme_submit_sync_cmd() via
>> blk_mq_rq_map_kern()->bio_map_kern().
>> And from that point on we are dealing with bvecs (iterators
>> and all), and losing the information that the page referenced
>> is a slab page.
> 
> Yes. But so does every other consomer of the block layer that passes
> slab memory, of which there are quite a few.  Various internal scsi
> and nvme command come to mind, as does the XFS buffer cache.
> 
>> The argument is that the network layer expected a kvec iterator
>> when slab pages are referred to, not a bvec iterator.
> 
> It doesn't.  It just doesn't want you to use ->sendpage.
> 
But we don't; we call 'sendpage_ok()' and disabling the MSG_SPLICE_PAGES
flag. Actual issue is that tls_sw() is calling iov_iter_alloc_pages(),
which is taking a page reference.
It probably should be calling iov_iter_extract_pages() (which does not
take a reference), but then one would need to review the entire network
stack as taking and releasing page references are littered throughout
the stack.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

