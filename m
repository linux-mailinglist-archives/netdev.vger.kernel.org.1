Return-Path: <netdev+bounces-189345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC0AB1C16
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767721893489
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5C238172;
	Fri,  9 May 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPjzhc3v"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EE238C2F;
	Fri,  9 May 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814319; cv=none; b=idoJ8Bb5/dXVeNjzvFXRXc9kpsDyjvj9krIgkEIuyDzkItKPsN50q9LLg+bSEX3nn00QMsbjQTCmXKGoWOwD9nusjFyxQNpQtyeobI4+R5liiPdzEY3xshmuYnG7HXXPdVj1Rvu85c0s/OlbQo2dPersA8pOzfpJgCdJXVPvvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814319; c=relaxed/simple;
	bh=n7jAX/r3B0uhQeb4UEEWtNNEjzyibyLhe1W3jfz/SV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyWsnZbva+u1YQfl6KGIZe1G+oIUPd2N45luPmTd1p7N+hsApNku5EuF7N2Zov6QooLsoFbvUDaSpWfLMFm9e3psSr0n51Ya605u6z9IK4yJLdDtnKH5heghBjq3rsBWexdqG7QhhE/17+MjStfkSpFYpYSEkyVsb2WqpkKAVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tPjzhc3v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cspF8g0wB1UfIi4VlU1VP1raE/nG2FyTs+KY08D+XqM=; b=tPjzhc3vcRS833mSbFJ+ZdUcBj
	quuCPKO2GsiEeiReDRqPkHH3MczAQ2wRkTiz/ISzztl9+He02NXoUep5QIlmlV6kyaSSVc48dKFTE
	RLzuvGsm/yyHS9rWKYq0uAgbArYBhgFQQ3Ba5hUrZytSdEll0JwdmoKe9R2SYLGTkTDhANdC0wbel
	4SzR7A+aYQGPVaviUcxbFtah9arShgkhPvDg4u4bzbAPQ6Ocvh+8kLYfWODUmge8S1nWpgr6lYf/+
	kMIR6YcQ865znEVuhyv9etq48FnNN99PrHYVYEEQiPxu50X/DrXtF6E6RZ0KtqYh1sjH2Ez7zwOwd
	/2vUh6dg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDSC0-0000000DqAm-35Gg;
	Fri, 09 May 2025 18:11:28 +0000
Date: Fri, 9 May 2025 19:11:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <aB5FUKRV86Tg92b6@casper.infradead.org>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <CAHS8izMoS4wwmc363TFJU_XCtOX9vOv5ZQwD_k2oHx40D8hAPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izMoS4wwmc363TFJU_XCtOX9vOv5ZQwD_k2oHx40D8hAPA@mail.gmail.com>

On Fri, May 09, 2025 at 10:32:08AM -0700, Mina Almasry wrote:
> Currently the only restriction on net_iov is that some of its fields
> need to be cache aligned with some of the fields of struct page, but

Cache aligned?  Do you mean alias (ie be at the same offset)?

> What I would suggest here is, roughly:
> 
> 1. Add a new struct:
> 
>                struct netmem_desc {
>                        unsigned long pp_magic;
>                        struct page_pool *pp;
>                        unsigned long _pp_mapping_pad;
>                        unsigned long dma_addr;
>                        atomic_long_t pp_ref_count;
>                };
> 
> 2. Then update struct page to include this entry instead of the definitions:
> 
> struct page {
> ...
>                struct netmem_desc place_holder_1; /* for page pool */
> ...
> }

No, the point is to move these fields out of struct page entirely.

At some point (probably this year), we'll actually kmalloc the netmem_desc
(and shrink struct page), but for now, it'll overlap the other fields
in struct page.

> 3. And update struct net_iov to also include netmem_desc:
> 
> struct net_iov {
>     struct netmem_desc desc;
>     struct net_iov_area *owner;
>     /* More net_iov specific fields in the future */
> };
> 
> And drop patch 1 which does a rename.
> 
> Essentially netmem_desc can be an encapsulation of the shared fields
> between struct page and struct net_iov.

That is not the goal.

