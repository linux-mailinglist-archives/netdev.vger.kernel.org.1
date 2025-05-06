Return-Path: <netdev+bounces-188350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F05AAC714
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736437AD41E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC7280319;
	Tue,  6 May 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4+QEZ9G"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE38280012
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539782; cv=none; b=n6WvpV81TRnAzlcm+X+6RIqeB0Rn2B/2AVRpJilra2H6t/8dQpes01NucwaOTuonPSTl+J5bzDNkBgW7mTdYo5tzewiNmBaJxMjNDs19DbvQFDsBKVzZ+sZVlinA1JwzTy+lfd9uqENRlACAnDVhXLKQZ3SgsfgJB9lG609XnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539782; c=relaxed/simple;
	bh=lf6YtdrdwJ2QtsANp3wjNVE6niIZ90eHUTTGp1DiNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ4iLd4tW29o+Envyv7mTT8Zgdw4DEZIaBbpk15KzqEkl7rxpP4i4I/Hl9aO7mfLmg2m96zFidl2Xy09ErEBQ61LzqZIfx9FCoXaRw2Ry7l6YqKW1e6ZW4ycYzXIb68RQWLWXzh+q22I7mNLlJzuELeWZ3La65zwReLg/mpk5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d4+QEZ9G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sDSa7bE8NOJXLelvEMpU/rC6sYcMXis7kEsdOk5BpI0=; b=d4+QEZ9GFyHLyMVwJ48TKE6Ihn
	S1FaSH9ltOcNp8C2wL3927zufKs6vPAHstgRsiUbOBT/avqnIvnJLb7XBsytAf6hUbBRr4DgcLD5E
	QxXqrbiDvqWJCSj2su4ZAgm5Q24jQsVEwnveMOLWQOD3Acy7oJfqgeOursDLY7diLPcQGrKbhQfz1
	2MtbfQJI/M5z/exkUBLhgl5GT5inYAirRFLHgqvcAauiRhQlDigbzHxDM9FPDkScK6uy9NW0KpzHo
	s+JcggW/WUYOWoHuOaWCNLI3mFZnAJNRXSqKNpYdStdAjwQHF0vy1LmTYJlZviuRWeeFgcQVT4zGa
	YJ2py6yA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCImP-0000000CDgT-3Equ;
	Tue, 06 May 2025 13:56:17 +0000
Date: Tue, 6 May 2025 06:56:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: Reorganising how the networking layer handles memory
Message-ID: <aBoVAd-XX_44RKbC@infradead.org>
References: <20250505131446.7448e9bf@kernel.org>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <1216273.1746539449@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1216273.1746539449@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 02:50:49PM +0100, David Howells wrote:
> > > (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug because
> > >      it doesn't use page pinning.  It needs to use the GUP routines.
> > 
> > We end up calling iov_iter_get_pages2(). Is it not setting
> > FOLL_PIN is a conscious choice, or nobody cared until now?
> 
> iov_iter_get_pages*() predates GUP, I think.

It predates pin_user_pages, but get_user_pages is much older.

> There's now an
> iov_iter_extract_pages() that does the pinning stuff, but you have to do a
> different cleanup, which is why I created a new API call.

But yes, iov_iter_get_pages* needs to go away in favour of
iov_iter_extract_pages, and I'm still annoyed that despite multiple
pings no one has done any work on that outside of block / block based
direct I/O and netfs.

> > >  (3) sendmsg(MSG_SPLICE_PAGES) isn't entirely satisfactory because it can't be
> > >      used with certain memory types (e.g. slab).  It takes a ref on whatever
> > >      it is given - which is wrong if it should pin this instead.
> > 
> > s/takes a ref/requires a ref/ ? I mean - the caller implicitly grants 
> > a ref  to the stack, right? But yes, the networking stack will try to
> > release it.
> 
> I mean 'takes' as in skb_append_pagefrags() calls get_page() - something that
> needs to be changed.
> 
> Christoph Hellwig would like to make it such that the extractor gets
> {phyaddr,len} rather than {page,off,len} - so all you, the network layer, see
> is that you've got a span of memory to use as your buffer.  How that span of
> memory is managed is the responsibility of whoever called sendmsg() - and they
> need a callback to be able to handle that.

Not sure what the extractor is, but we plan to change the bio_vec
to be physical address instead of page+offset based.  Where we is
a lot more people than just me.

> Once advantage of delegating it to the caller, though, and having the caller
> keep track of which bits in still needs to hold on to by transmission
> completion position is that we don't need to manage refs/pins across sk_buff
> duplication - let alone what we should do with stuff that's kmalloc'd.

And the callers already do that for all other kinds of I/O anyway.


