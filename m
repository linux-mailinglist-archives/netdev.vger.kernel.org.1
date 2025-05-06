Return-Path: <netdev+bounces-188426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56438AACD12
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DF5174AAB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048E286405;
	Tue,  6 May 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABQu3iKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE728031E
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555615; cv=none; b=ajU+NQ/yOxJJP5L8zGZbVWG1XNt2NGmAwBrzvMe+LWG4v0+I6RUc/thHXUzdaUXRoT0yiD7dHfdoz3f8u9wqtl7/dIAAvnp9Bqtd3Z4iptOx11T85efSdj8/yej1Yq4RN5OUah83tL+anFHcJmdAT/v78TPcb2XnlruOy6SMLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555615; c=relaxed/simple;
	bh=MwR5vRWIc9Q59dY7j226r9RQUC2uGk4RTq05VY0f+38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUHm2IAvmENg05fVksCrZpoKT+/AfbQ+VW2zBM0mgcVRH/xI3RB9sJu6i61SJP4AraEO4Rpmes4XzLn2wTqjo3n/jsgkW5eeSLXVjyQA9IRJjxhFBHChN3OIMbr/3JrIRJEj3Xq+qhEv/anOrB/Hh8N93g0a2eGvPBCo92o6uSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABQu3iKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F89C4CEE4;
	Tue,  6 May 2025 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746555613;
	bh=MwR5vRWIc9Q59dY7j226r9RQUC2uGk4RTq05VY0f+38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ABQu3iKwqXYRUoedkXMsorP2MmQWaEkB2apdmZTi4yq4gcQpjbP61S/w6uKVXEzrU
	 9wyf7K3jFEfdPoWjBNSCbBd9Oq69OFVVbdf86ThWLmvD1U0TbII/EyftWOLo1+B0Q2
	 n5elEwqti9/86AASCEz/S7JabQ8/Th4H5iDVPjqtm99cL5Mlpb5FSOvlF3YCUVnivi
	 VXtG60adeIxv+XMnUwsEphz8tahcwm28NNucQ0bGXMhR9fOdeqzYxKMKf9lSNptfU0
	 dFaszo8khBDeBsun9+N/P752IZzRodGHN0Y2nCzWIuXIewhQv7lmeo37lDYJoCGl6E
	 XH/IUxG7KZlJg==
Date: Tue, 6 May 2025 11:20:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 willy@infradead.org, netdev@vger.kernel.org, linux-mm@kvack.org, Willem de
 Bruijn <willemb@google.com>
Subject: Re: Reorganising how the networking layer handles memory
Message-ID: <20250506112012.5779d652@kernel.org>
In-Reply-To: <1216273.1746539449@warthog.procyon.org.uk>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 May 2025 14:50:49 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > > (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug because
> > >      it doesn't use page pinning.  It needs to use the GUP routines.  
> > 
> > We end up calling iov_iter_get_pages2(). Is it not setting
> > FOLL_PIN is a conscious choice, or nobody cared until now?  
> 
> iov_iter_get_pages*() predates GUP, I think.  There's now an
> iov_iter_extract_pages() that does the pinning stuff, but you have to do a
> different cleanup, which is why I created a new API call.
> 
> iov_iter_extract_pages() also does no pinning at all on pages extracted from a
> non-user iterator (e.g. ITER_BVEC).

FWIW it occurred to me after hitting send that we may not care. 
We're talking about Tx, so the user pages are read only for the kernel.
I don't think we have the "child gets the read data" problem?

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

Sure, there may be things to iron out as data in networking is not
opaque. We need to handle the firewalling and inspection cases.
Likely all this will work well for ZC but not sure if we can "convert"
the stack to phyaddr+len.

> > TAL at struct ubuf_info  
> 
> I've looked at it, yes, however, I'm wondering if we can make it more generic
> and usable by regular file DIO and splice also.

Okay, just keep in mind that we are working on 800Gbps NIC support these
days, and MTU does not grow. So whatever we do - it must be fast fast.

> Further, we need a way to track pages we've pinned.  One way to do that is to
> simply rely on the sk_buff fragment array and keep track of which particular
> bits need putting/unpinning/freeing/kfreeing/etc - but really that should be
> handled by the caller unless it costs too much performance (which it might).
> 
> Once advantage of delegating it to the caller, though, and having the caller
> keep track of which bits in still needs to hold on to by transmission
> completion position is that we don't need to manage refs/pins across sk_buff
> duplication - let alone what we should do with stuff that's kmalloc'd.
> 
> > >  (3) We also pass an optional 'refill' function to sendmsg.  As data is
> > >      sent, the code that extracts the data will call this to pin more user
> > >      bufs (we don't necessarily want to pin everything up front).  The
> > >      refill function is permitted to sleep to allow the amount of pinned
> > >      memory to subside.  
> > 
> > Why not feed the data as you get the notifications for completion?  
> 
> Because there are multiple factors that govern the size of the chunks in which
> the refilling is done:
> 
>  (1) We want to get user pages in batches to reduce the cost of the
>      synchronisation MM has to do.  Further, the individual spans in the
>      batches will be of variable size (folios can be of different sizes, for
>      example).  The idea of the 'refill' is that we go and refill as each
>      batch is transcribed into skbuffs.
> 
>  (2) We don't want to run extraction too far ahead as that will delay the
>      onset of transmission.
> 
>  (3) We don't want to pin too much at any one time as that builds memory
>      pressure and in the worst case will cause OOM conditions.
> 
> So we need to balance things - particularly (1) and (2) - and accept that we
> may get multiple refils in order to fill the socket transmission buffer.

Hard to comment without concrete workload at hand.
Ideally the interface would be good enough for the application
to dependably drive the transmission in an efficient way.

