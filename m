Return-Path: <netdev+bounces-167078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30CA38B65
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DC3A929D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B222DFB4;
	Mon, 17 Feb 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MmCGamMB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c3h1eEAL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQGTzicH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYy7YrY6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145818DB39
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817803; cv=none; b=lt1gLpw6zHdPX6lBTYgDBaNff97lXqtMJV1ksqM1awlDuu3goZo7kOa0K5sSOcij37AiajRsF1jroXpHOYKP8WwGJC6bGFwoP8qaf+BWycsTQmcrfazFpWubYCY9e4Vg+riSL2PnPzCSnU1uZVTWiqCubDtbS1knEGPUC7SgVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817803; c=relaxed/simple;
	bh=aQ8/F+Lh2P9Vy2jF93ARw99yi6bnud3ngrkQ+wzhoGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odmSsempe+lByc65wYGo5BUkRnoiAzvEqTTZhT4v+j/e2FJPTo5K8AyPDwtaUP1md6MKgpvyGzpiSf7tU1JCMj7tRjhxIsFWpeglsBSSm6ExYyUVW3tkI0ksgfzPlJ4/Qy7eeKnhTfUbSbwCumrVGSVuW7lt0ZZxC1++wWI6MHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MmCGamMB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c3h1eEAL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQGTzicH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYy7YrY6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5EE421172;
	Mon, 17 Feb 2025 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739817800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V5lZynmEUR+YeywYZpcWxhoHhkH//bvz+HMMgYXLssE=;
	b=MmCGamMB4yR/kMGuOav/oCZgNlsKbej/iEDivKWQAfphN4rpAwvJjh0aMh0UotpiBHvvQ9
	FhhfvkfMMIL17X2+0o7iuGnjk4vSrZluie8HPcc4RjRvEwBA15Y4CerLh/8IJQhIgtGHqF
	nHNgiCs3lbKg4xNmpImZKHWb0dbg6jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739817800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V5lZynmEUR+YeywYZpcWxhoHhkH//bvz+HMMgYXLssE=;
	b=c3h1eEALIj4xQAPDWcBAgSJvcYNpeaT6PY9xlGPfCUw2ArR70RKQbR6NXIkrwqj5RqU+Tt
	mZMoTpLQVD8g+pAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739817799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V5lZynmEUR+YeywYZpcWxhoHhkH//bvz+HMMgYXLssE=;
	b=rQGTzicHaa/o0iyUdHK+ki7RUOjPeW4cWuYz0nOYWCsmNX0bYf13T/OpDlytCaAkLQjrHu
	2ZA8ZK4/QXcm5zbDs/xEUN0qxJiRERNdbNZbVfV+ItUXWTuN2C2fIREcco8D1YUFxbXb9A
	ObiZXjcHCn15wZhjpfnnTOOUcKN+CiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739817799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V5lZynmEUR+YeywYZpcWxhoHhkH//bvz+HMMgYXLssE=;
	b=jYy7YrY6o22q+HHXYv7P8SMXq/tc3qerKhB7voZpijM+bmV7KAR/SKXMr0Oyy289/o6pQ6
	ozhIswbbCIwhMrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBF6D13485;
	Mon, 17 Feb 2025 18:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lMyELUeDs2fOegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Feb 2025 18:43:19 +0000
Message-ID: <b4a2bf18-c1ec-4ccd-bed9-671a2fd543a9@suse.cz>
Date: Mon, 17 Feb 2025 19:43:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc()
 when GFP_ATOMIC is specified
Content-Language: en-US
To: Kohei Enju <enjuk@amazon.com>, edumazet@google.com
Cc: davem@davemloft.net, gnaaman@drivenets.com, horms@kernel.org,
 joel.granados@kernel.org, kohei.enju@gmail.com, kuba@kernel.org,
 kuniyu@amazon.com, linux-kernel@vger.kernel.org, lizetao1@huawei.com,
 netdev@vger.kernel.org, pabeni@redhat.com, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
References: <CANn89i+ap-8BB_XKfcjMnXLR0ae+XV+6s_jacPLUd8rqSgyayA@mail.gmail.com>
 <20250217165229.87240-1-enjuk@amazon.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250217165229.87240-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,drivenets.com,kernel.org,gmail.com,amazon.com,vger.kernel.org,huawei.com,redhat.com,linux.com,google.com,lge.com,linux-foundation.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 2/17/25 17:52, Kohei Enju wrote:
> + SLAB ALLOCATOR maintainers and reviewers
> 
>> > From: Kohei Enju <enjuk@amazon.com>
>> > Date: Mon, 17 Feb 2025 01:30:16 +0900
>> > > Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
>> > > specified, since kvzalloc() doesn't support non-sleeping allocations such
>> > > as GFP_ATOMIC.
>> > >
>> > > With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
>> > > path and returns immediately after the kmalloc path fails.
>> > > Therefore, using kzalloc() is sufficient in this case.
>> > >
>> > > Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")
>> >
>> > This commit followed the old hash_buckets allocation, so I'd add
>> >
>> >   Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")
>> >
>> > too.
>> >
>> > Both commits were introduced in v6.13, so there's no difference in terms
>> > of backporting though.
>> >
>> > Also, it would be nice to CC mm maintainers in case they have some
>> > comments.
>> 
>> Oh well, we need to trigger neigh_hash_grow() from a process context,
>> or convert net/core/neighbour.c to modern rhashtable.
> 
> Hi all, thanks for your comments.
> 
> kzalloc() uses page allocator when size is larger than 
> KMALLOC_MAX_CACHE_SIZE, so I think what commit ab101c553bc1 ("neighbour: 
> use kvzalloc()/kvfree()") intended could be achieved by using kzalloc().

Indeed, kzalloc() should be equivalent to pre-ab101c553bc1 code. kvmalloc()
would only be necessary if you need more than order-3 page worth of memory
and don't want it to fail because of fragmentation (but indeed it's not
supported in GFP_ATOMIC context). But since you didn't need such large
allocations before, you probably don't need them now too?

> As mentioned, when using GFP_ATOMIC, kvzalloc() only tries the kmalloc 
> path, since the vmalloc path doesn't support the flag.
> In this case, kvzalloc() is equivalent to kzalloc() in that neither try 
> the vmalloc path, so there is no functional change between this patch and 
> either commit ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()") or 

Agreed.

> commit 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour").
> 
> Actually there's no real bug in the current code so the Fixes tag was not 
> appropriate. I shall remove the tag.

True, the code is just more clear.

Thanks,
Vlastimil

> Regards,
> Kohei


