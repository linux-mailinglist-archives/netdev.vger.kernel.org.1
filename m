Return-Path: <netdev+bounces-195114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D492EACE19F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448C67A1B21
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD91917D6;
	Wed,  4 Jun 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHSdrBfd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCA3595E
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051277; cv=none; b=lO8a03zFMOG1ZL3DH/7d1zbsb89UQ1Ylp2YwfOW+4UnE19nyceYTVJk/suJV9/Gjt1JEpFMwQ6uDBQ5IaqjXdGrkIbp03cGEd6PRGqjog/c0RlVPlGnUxGlmHkDZkfKvfcXIML+RBYi90YWD4LMIuhXJ2nZg/YqQ+DSQxdlbRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051277; c=relaxed/simple;
	bh=qTXEgU4faK8V3+o1webIL89G6tLPcijOJ2B4kkypv04=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Gm4uqi9uHN6PE17w9Q0aukV3aixug3AuHCIyuv3jsge1a7zOZvthCHUXeqUiUf4cA49AHFExftU0Jm34ZUvCXr+3Qusv6B+W95QFA0Si9/A6lXWWYyhi1SALyodsrdo6Ami2ao2YY8o2woq+1sxfXCxGC8McXgEG/Y2vZm7din4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHSdrBfd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749051274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2KiML0jpnv35I2ryANTISLMOhOT0NTQ+BIj5SUwYgU=;
	b=aHSdrBfdpWo+VlBMNNWLM7vQrYqmLAhHjLfHW3BIKRcNXwgCJ+8JB/VLGOI/IVOhV0Xs+6
	p9/Z3AUkfvexKcKsu8azXafIuEEjYMHYLyBThi1g7u61UqMOFgFmiudpSUxqKvtK+9wpGL
	wapQT8R9p1LTdooCJyidUqYer8+IYk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-NZydtSNtNuymBvMkhyhlXA-1; Wed,
 04 Jun 2025 11:34:31 -0400
X-MC-Unique: NZydtSNtNuymBvMkhyhlXA-1
X-Mimecast-MFC-AGG-ID: NZydtSNtNuymBvMkhyhlXA_1749051269
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41659195608C;
	Wed,  4 Jun 2025 15:34:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD6919560AE;
	Wed,  4 Jun 2025 15:34:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com>
References: <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com> <770012.1748618092@warthog.procyon.org.uk>
To: Mina Almasry <almasrymina@google.com>
Cc: dhowells@redhat.com, willy@infradead.org, hch@infradead.org,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: Device mem changes vs pinning/zerocopy changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1098852.1749051265.1@warthog.procyon.org.uk>
Date: Wed, 04 Jun 2025 16:34:25 +0100
Message-ID: <1098853.1749051265@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Mina Almasry <almasrymina@google.com> wrote:

> Hi David! Yes, very happy to collaborate.

:-)

> FWIW, my initial gut feeling is that the work doesn't conflict that much.
> The tcp devmem netmem/net_iov stuff is designed to follow the page stuff,
> and as the usage of struct page changes we're happy moving net_iovs and
> netmems to do the same thing. My read is that it will take a small amount of
> extra work, but there are no in-principle design conflicts, at least AFAICT
> so far.

The problem is more the code you changed in the current merge window I'm also
wanting to change, so merge conflicts will arise.

However, I'm also looking to move the points at which refs are taken/dropped
which will directly inpinge on the design of the code that's currently
upstream.

Would it help if I created some diagrams to show what I'm thinking of?

> I believe the main challenge here is that there are many code paths in
> the net stack that expect to be able to grab a ref on skb frags. See
> all the callers of skb_frag_ref/skb_frag_unref:
> 
> tcp_grow_skb, __skb_zcopy_downgrade_managed, __pskb_copy_fclone,
> pskb_expand_head, skb_zerocopy, skb_split, pksb_carve_inside_header,
> pskb_care_inside_nonlinear, tcp_clone_payload, skb_segment.

Oh, yes, I've come to appreciate that well.  A chunk of that can actually go
away, I think.

> I think to accomplish what you're describing we need to modify
> skb_frag_ref to do something else other than taking a reference on the
> page or net_iov. I think maybe taking a reference on the skb itself
> may be acceptable, and the skb can 'guarantee' that the individual
> frags underneath it don't disappear while these functions are
> executing.

Maybe.  There is an issue with that, though it may not be insurmountable: If a
userspace process does, say, a MSG_ZEROCOPY send of a page worth of data over
TCP, under a typicalish MTU, say, 1500, this will be split across at least
three skbuffs.

This would involve making a call into GUP to get a pin - but we'd need a
separate pin for each skbuff and we might (in fact we currently do) end up
calling into GUP thrice to do the address translation and page pinning.

What I want to do is to put this outside of the skbuff so that GUP pin can be
shared - but if, instead, we attach a pin to each skbuff, we need to get that
extra pin in some way.  Now, it may be reasonable to add a "get me an extra
pin for such-and-such a range" thing and store the {physaddr,len} in the
skbuff fragment, but we also have to be careful not to overrun the pin count -
if there's even a pin count per se.

> But devmem TCP doesn't get much in the way here, AFAICT. It's really
> the fact that so many of the networking code paths want to obtain page
> refs via skb_frag_ref so there is potentially a lot of code to touch.

Yep.

> But, AFAICT, skb_frag_t needs a struct page inside of it, not just a
> physical address. skb_frags can mmap'd into userspace for TCP
> zerocopy, see tcp_zerocopy_vm_insert_batch (which is a very old
> feature, it's not a recent change). There may be other call paths in
> the net stack that require a full page and just a physical address
> will do. (unless somehow we can mmap a physical address to the
> userspace).

Yeah - I think this needs very careful consideration and will need some
adjustment.  Some of the pages that may, in the future, get zerocopied or
spliced into the socket *really* shouldn't be spliced out into some random
process's address space - and, in fact, may not even have a refcount (say they
come from the slab).  Basically, TCP has implemented async vmsplice()...

> Is struct net_txbuf intended to replace struct sk_buff in the tx path
> only? If so, I'm not sure that works.

No - the idea is that it runs a parallel track to it and holds "references" to
the buffer memory.  This is then divided up amongst a number of sk_buffs that
hold refs on the first txbuf that it uses memory from.

txbufs would allow us to take and hold a single ref or pin (or even nothing,
just a destructor) on each piece of supplied buffer memory and for that to be
shared between a sequence of skbufs.

> Currently TX and RX memory share a single data structure (sk_buff), and I
> believe that is critical.

Yep.  And we need to keep sk_buff because an sk_buff is more than just a
memory pinning device - it also retains the metadata for a packet.

> ... So I think, maybe, instead of introducing a new struct, you have to make
> the modifications you envision to struct sk_buff itself?

It may be possible.  But see above.  I want to be able to share pins between
sk_buffs.

> OK, you realize that TX packets can be forwarded to RX. The opposite
> is true, RX can be forwarded to TX. And it's not just AF_UNIX and
> loopback. Packets can be forwarded via ip forwarding, and tc, and
> probably another half dozen features in the net stack I don't know
> about.

Yeah, I'd noticed that.

> I think you need to modify the existing sk_buff. I think adding
> a new struct and migrating the entire net stack to use that is a bit
> too ambitious. But up to you. Just my 2 cents here.


