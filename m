Return-Path: <netdev+bounces-173567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C66AA597E1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B092316E19F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36222A819;
	Mon, 10 Mar 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gx+6zm4g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0fT7hl8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gx+6zm4g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0fT7hl8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C022A4D1
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617475; cv=none; b=m5eEzojTkBmZxPpwIbQvmexW4yg3owzSxW+IfR99/89ofoG/dJYhGwmvxZGedS6II+DR4Ga2H8fu1lvwQ9A2tVdH3w+S6NpAkgw3S53eMHJS5HcnImnXfbuqH2pftS3u0VUNyX0OXdwAoYPEKQKFlRZgTYvUZZCBMlmYQKEKkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617475; c=relaxed/simple;
	bh=7b63uMwzkLhN/nxgqbSv483zC71XjRSOJDwYdVGytm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdNxRfw8cmiH3jDiRQEL2X0UlbaI4Lz8G8zly9FtjAyaSIwHmQO9+XK8ZAIW4OA5NJ1eiQWx6svsiHrZzMFqbg11/WiPfkrTmnNU4H5clGbxy1LUoMEBUQ5MyDc66ItZdAEWwdS7fBqLuAYfoQksCX7NH0agnvMMmQ2kAuge6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gx+6zm4g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0fT7hl8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gx+6zm4g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0fT7hl8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 976592116A;
	Mon, 10 Mar 2025 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741617471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxiMUXvbYUHq9mDtePP9fSrQUwJihrZsyI7jUUFXqZ0=;
	b=Gx+6zm4gH7N/yG83qdJPvfU2q0mJ6mJrroy7ho9A7jtP/8IGQ4g0/2zszpoAPdrzgbpm3N
	2W+xNRKNKq710/FrMEw0cz7o1hd5wJ3zEWqUVX/1TdCCo15NwFXlq3SIsljYXM0PhqAgND
	bF1n5c9sQKsxdw9J60N251auHvrhg9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741617471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxiMUXvbYUHq9mDtePP9fSrQUwJihrZsyI7jUUFXqZ0=;
	b=y0fT7hl8uvnSZBdLvhW1yrMGbTGOxMVq3FPWJ6eTIphSVekyW2wvaGgXuWtFWaFvQEganc
	g5fUclUrdsWbp1CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741617471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxiMUXvbYUHq9mDtePP9fSrQUwJihrZsyI7jUUFXqZ0=;
	b=Gx+6zm4gH7N/yG83qdJPvfU2q0mJ6mJrroy7ho9A7jtP/8IGQ4g0/2zszpoAPdrzgbpm3N
	2W+xNRKNKq710/FrMEw0cz7o1hd5wJ3zEWqUVX/1TdCCo15NwFXlq3SIsljYXM0PhqAgND
	bF1n5c9sQKsxdw9J60N251auHvrhg9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741617471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxiMUXvbYUHq9mDtePP9fSrQUwJihrZsyI7jUUFXqZ0=;
	b=y0fT7hl8uvnSZBdLvhW1yrMGbTGOxMVq3FPWJ6eTIphSVekyW2wvaGgXuWtFWaFvQEganc
	g5fUclUrdsWbp1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89162139E7;
	Mon, 10 Mar 2025 14:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mt8gIT/5zmdFOwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 14:37:51 +0000
Message-ID: <598912d1-0482-434c-b7bb-75e6fdc2e38e@suse.cz>
Date: Mon, 10 Mar 2025 15:37:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
References: <20250310143544.1216127-1-willy@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250310143544.1216127-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/10/25 15:35, Matthew Wilcox (Oracle) wrote:
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

Closes:
https://lore.kernel.org/all/08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com/

> Fixes: 9aec2fb0fd5e (slab: allocate frozen pages)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Note it's a 6.14 hotfix for kernel oopses due to page refcount overflow.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 7 ++++++-
>  lib/iov_iter.c     | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 61de65c4e430..4e118cbe0556 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1539,7 +1539,10 @@ static inline void folio_get(struct folio *folio)
>  
>  static inline void get_page(struct page *page)
>  {
> -	folio_get(page_folio(page));
> +	struct folio *folio = page_folio(page);
> +	if (WARN_ON_ONCE(folio_test_slab(folio)))
> +		return;
> +	folio_get(folio);
>  }
>  
>  static inline __must_check bool try_get_page(struct page *page)
> @@ -1633,6 +1636,8 @@ static inline void put_page(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
>  
> +	if (folio_test_slab(folio))
> +		return;
>  	folio_put(folio);
>  }
>  
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 65f550cb5081..8c7fdb7d8c8f 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		if (!n)
>  			return -ENOMEM;
>  		p = *pages;
> -		for (int k = 0; k < n; k++)
> -			get_page(p[k] = page + k);
> +		for (int k = 0; k < n; k++) {
> +			struct folio *folio = page_folio(page);
> +			p[k] = page + k;
> +			if (!folio_test_slab(folio))
> +				folio_get(folio);
> +		}
>  		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>  		i->count -= maxsize;
>  		i->iov_offset += maxsize;


