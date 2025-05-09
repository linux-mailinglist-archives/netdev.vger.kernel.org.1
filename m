Return-Path: <netdev+bounces-189353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631BAB1D76
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2613B063E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7C25E477;
	Fri,  9 May 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtkAbn2m"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBEB25E45B;
	Fri,  9 May 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820126; cv=none; b=dS1bN+4Q1aF89GW7Cze749VI5BS2WZCW4RxT0GCPDVioVvFfPc7ltBsJlgL7GQy8WsqfFR0OSKNDDTSaifTDsbGgAUEU37izgcZqA5KUYMlQYzgb88J5Puuiyr4pR5ETHGe1/jxGx6KQRxJxrShaAHoNCq3Y5v7VsWT2lfE3pT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820126; c=relaxed/simple;
	bh=KGhFHYEIxwjIBJu3+qNdIII2b9QWNi6R/vnEJwBpNio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQfHh3otxPxCZiNi5Zvl/uUKHIXLyyhezdSDtEu3P24zTZzJAg7Er+35hoXa8I8gtLUjOKSjgAJ342NmEtCTXgfiYBXnqN0OmGsVd8iKBL0A36wSnQso/vHDkJ83ndDiJbADDA3JmqBLglOQrK8C3RGzLbbl1UQBjpEkzbYuU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JtkAbn2m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LHzIEA61Md5/xpeDzeP5A1UdrB0NGR5BHd5W1xhlBOs=; b=JtkAbn2mI5hQHgI6W7flVzUtrh
	mpI1gsSyMvrONBoXr3Zj/SOFDfINrQ4etEVWyKOw8ZuwruWJJ2depHPJc6SbVr6digw77yzcyQhLe
	pZ37NhsrRcVzroJdOhFDB2qvriramcVdh2Y8a5pBw05k/p2J4U3AFiZFb0H5ssU80NoSj2lachYXK
	fWHuJeSvmJuwSLqHbeqSZPCnmqbLqEftte0N6IGtrjeH02unmwWnkdvWjts06PMAU1U9Igz7WAXtD
	4lp8YFtAYhnQV46q8I90J9k8nU3Xxn5icnEKgJNBZWk37Xv1QwCOOIKH1wNwl8eorM8VJJ+ouFwQs
	Fs6mNgZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDThc-0000000H3Vg-1HTz;
	Fri, 09 May 2025 19:48:12 +0000
Date: Fri, 9 May 2025 20:48:12 +0100
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
Message-ID: <aB5b_FmBlcqQk09l@casper.infradead.org>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <CAHS8izMoS4wwmc363TFJU_XCtOX9vOv5ZQwD_k2oHx40D8hAPA@mail.gmail.com>
 <aB5FUKRV86Tg92b6@casper.infradead.org>
 <CAHS8izMJx=+229iLt7GphUwioeAK5=CL0Fxi7TVywS2D+c-PKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izMJx=+229iLt7GphUwioeAK5=CL0Fxi7TVywS2D+c-PKw@mail.gmail.com>

On Fri, May 09, 2025 at 12:04:37PM -0700, Mina Almasry wrote:
> Right, all I'm saying is that if it's at all possible to keep net_iov
> something that can be extended with fields unrelated to struct page,
> lets do that. net_iov already has fields that should not belong in
> struct page like net_iov_owner and I think more will be added.

Sure, that's fine.

> I'm thinking netmem_desc can be the fields that are shared between
> struct net_iov and struct page (but both can have more specific to the
> different memory types). As you say, for now netmem_desc can currently
> overlap fields in struct page and struct net_iov, and a follow up
> change can replace it with something that gets kmalloced and (I
> guess?) there is a pointer in struct page or struct net_iov that
> refers to the netmem_desc that contains the shared fields.

I'm sure I've pointed you at
https://kernelnewbies.org/MatthewWilcox/Memdescs before.

But I wouldn't expect to have net_iov contain a pointer to netmem_desc,
rather it would embed a netmem_desc.  Unless there's a good reason to
separate them.

Actually, I'd hope to do away with net_iov entirely.  Networking should
handle memory-on-PCI-devices the same way everybody else does (as
hotplugged memory) rather than with its own special structures.

