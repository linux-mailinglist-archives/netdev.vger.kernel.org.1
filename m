Return-Path: <netdev+bounces-174468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA09A5EE19
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF44B3BC433
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C11E32C5;
	Thu, 13 Mar 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztubE1m4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1znLMpF9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztubE1m4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1znLMpF9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF551EA7E1
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854883; cv=none; b=uiyUjSnB152LmL03I5CSPloirtyPSPkqdsI45xp9BWLttVBsyYaVbw65qlYMVjUd7jqyYNe9IFXIpJT1Yju3dYa/P9VpCu2bPCESzE3nv6J0PrGSs6RdXRbGmwgID9t17hNiucWEZUYAxHCL7t1BwJn6SXFujYTpPPH/5AasZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854883; c=relaxed/simple;
	bh=yfWIEB3MjoBFoE0JMc/2xmRmhX7pJeIAHJest/0HYvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPuGx8aw+slfVpZr11OgOVebRQKAN6Kz29K7OtQxpwKUIcEUvey9t2bUqAwEvX4uv8MJan3y1oQq5xhCNBpWdqbKGwQlBsGVPPgiIdLS4XUNo0N36Usv4MC89fcV9tHOW/9yV4hayZwPEa5XVfWT8Fg1G+JRa5F/Qxyyak5ryWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztubE1m4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1znLMpF9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztubE1m4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1znLMpF9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E68F21191;
	Thu, 13 Mar 2025 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741854880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP7boMH3wqqe/EGsSuYJc4m+1bxXXUrqxhpS2yfOCuI=;
	b=ztubE1m4hMbac+7jmqiqSxqq5+H8eF5Ts8fb2T+kPOsf11aBUSTZJMM1+Unb5oRHNbR4yx
	CUMfwZWFq6NYfnX9I7nYDohbOrNkiBZ6wQLt8myhPnWaOUpJiNgWodGGf1F5m8fM8WY5NK
	XGMyzVxZpCBoWmF8WBQzXBZc4D5Ib+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741854880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP7boMH3wqqe/EGsSuYJc4m+1bxXXUrqxhpS2yfOCuI=;
	b=1znLMpF92glsMlj3vovGWy6n9BEeHiZFsroeL0hwjjWQ+1ZAua0jOhCgkRhbTvJOCdBBUY
	WYm0jFYO3RSLXNAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741854880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP7boMH3wqqe/EGsSuYJc4m+1bxXXUrqxhpS2yfOCuI=;
	b=ztubE1m4hMbac+7jmqiqSxqq5+H8eF5Ts8fb2T+kPOsf11aBUSTZJMM1+Unb5oRHNbR4yx
	CUMfwZWFq6NYfnX9I7nYDohbOrNkiBZ6wQLt8myhPnWaOUpJiNgWodGGf1F5m8fM8WY5NK
	XGMyzVxZpCBoWmF8WBQzXBZc4D5Ib+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741854880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP7boMH3wqqe/EGsSuYJc4m+1bxXXUrqxhpS2yfOCuI=;
	b=1znLMpF92glsMlj3vovGWy6n9BEeHiZFsroeL0hwjjWQ+1ZAua0jOhCgkRhbTvJOCdBBUY
	WYm0jFYO3RSLXNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C578E13797;
	Thu, 13 Mar 2025 08:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U8wfLp+Y0mfWJwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 08:34:39 +0000
Message-ID: <17f4795a-f6c8-4e6c-ba31-c65eab18efd1@suse.de>
Date: Thu, 13 Mar 2025 09:34:39 +0100
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9KK-n_JxOQ85Vgp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/13/25 08:36, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 08:22:01AM +0100, Hannes Reinecke wrote:
>> On 3/12/25 06:48, Christoph Hellwig wrote:
>>> On Tue, Mar 11, 2025 at 04:59:53PM +0000, Matthew Wilcox wrote:
>>>> So I have two questions:
>>>>
>>>> Hannes:
>>>>    - Why does nvme need to turn the kvec into a bio rather than just
>>>>      send it directly?
>>>
>>> It doensn't need to and in fact does not.
>>>
>> Errm ... nvmf_connect_admin_queue()/nvmf_connect_io_queue() does ...
> 
> No kvec there.  Just plain old passthrough commands like many others.

I might be misunderstood.

nvmf_connect_command_prep() returns a kmalloced buffer.
That is stored in a bvec in _nvme_submit_sync_cmd() via
blk_mq_rq_map_kern()->bio_map_kern().
And from that point on we are dealing with bvecs (iterators
and all), and losing the information that the page referenced
is a slab page.

The argument is that the network layer expected a kvec iterator
when slab pages are referred to, not a bvec iterator.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

