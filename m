Return-Path: <netdev+bounces-187497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86710AA771E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC1C4A61CE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130625DB03;
	Fri,  2 May 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqt0+WBT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD73C465
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202922; cv=none; b=Ed5Yo2DgvH9h+ZdYH5b4Vnir+xTgW9aI3ScvQEzTnARMuug2+K8Cm0yKNOiis9zVa+0q4tIi4x7HEhYDlDvB60enIiVsQUOlQQdHYP4zod8olzseBfHu/NIp6epTq+v8UWpHoPKgzAenMAtoT7GhPu+SvfLHNBmiZUyn9fAGeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202922; c=relaxed/simple;
	bh=em0lOFlyFfYwEHN46Zxupx5x/KtMD9KwaA18WnehMN4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=XeYLvYO0wigjZyGGObqoz7fQwyhJV9qeQbwf3OdluVkDSjsydydAECci7IPL6Sv1+wTgEP17vbgttvEFBpE2osGufVSB28pJ6NeBGWi4anlpgSDpLexhum5/7voRoIC/Y2QluTZBsZl/At+4ljaPP0rzuQlbL0qr8vVkQevJpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oqt0+WBT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746202919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbGsWOjIqREezQIcqfHS/kiolPpE7fXwkpLda6geRtM=;
	b=Oqt0+WBT/FRU0abgX9n6kLYkoA9j+MAIiVze0DfyoC+ZeYwGIdgdhyy3CyaeDEejRBMOZQ
	2kV3CF+JZsJIZ6PaRU6+W2VvCd+2dZWjB7hZSlDMK1V5MZpnK3v1CclqnDeptT+77N/KkQ
	zF6hsZzG9kMXqdLWhwEnO5Zywarox3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-eozEl9QTOwCwucTtPkklEA-1; Fri,
 02 May 2025 12:21:55 -0400
X-MC-Unique: eozEl9QTOwCwucTtPkklEA-1
X-Mimecast-MFC-AGG-ID: eozEl9QTOwCwucTtPkklEA_1746202914
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 864F81800876;
	Fri,  2 May 2025 16:21:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC84A1956094;
	Fri,  2 May 2025 16:21:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
References: <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
    netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Reorganising how the networking layer handles memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1069539.1746202908.1@warthog.procyon.org.uk>
Date: Fri, 02 May 2025 17:21:48 +0100
Message-ID: <1069540.1746202908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Okay, perhaps I should start at the beginning :-).

There a number of things that are going to mandate an overhaul of how the
networking layer handles memory:

 (1) The sk_buff code assumes it can take refs on pages it is given, but the
     page ref counter is going to go away in the relatively near term.

     Indeed, you're already not allowed to take a ref on, say, slab memory,
     because the page ref doesn't control the lifetime of the object.

     Even pages are going to kind of go away.  Willy haz planz...

 (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug because it
     doesn't use page pinning.  It needs to use the GUP routines.

 (3) sendmsg(MSG_SPLICE_PAGES) isn't entirely satisfactory because it can't be
     used with certain memory types (e.g. slab).  It takes a ref on whatever
     it is given - which is wrong if it should pin this instead.

 (4) iov_iter extraction will probably change to dispensing {physaddr,len}
     tuples rather than {page,off,len} tuples.  The socket layer won't then
     see pages at all.

 (5) Memory segments splice()'d into a socket may have who-knows-what weird
     lifetime requirements.

So after discussions at LSF/MM, what I'm proposing is this:

 (1) If we want to use zerocopy we (the kernel) have to pass a cleanup
     function to sendmsg() along with the data.  If you don't care about
     zerocopy, it will copy the data.

 (2) For each message sent with sendmsg, the cleanup function is called
     progressively as parts of the data it included are completed.  I would do
     it progressively so that big messages can be handled.

 (3) We also pass an optional 'refill' function to sendmsg.  As data is sent,
     the code that extracts the data will call this to pin more user bufs (we
     don't necessarily want to pin everything up front).  The refill function
     is permitted to sleep to allow the amount of pinned memory to subside.

 (4) We move a lot the zerocopy wrangling code out of the basement of the
     networking code and put it at the system call level, above the call to
     ->sendmsg() and the basement code then calls the appropriate functions to
     extract, refill and clean up.  It may be usable in other contexts too -
     DIO to regular files, for example.

 (5) The SO_EE_ORIGIN_ZEROCOPY completion notifications are then generated by
     the cleanup function.

 (6) The sk_buff struct does not retain *any* refs/pins on memory fragments it
     refers to.  This is done for it by the zerocopy layer.

This will allow us to kill three birds with one stone:

 (A) It will fix the issues with zerocopy transmission mentioned above (DIO vs
     fork, pin vs ref, pages without refcounts).  Whoever calls sendmsg() is
     then responsible for maintaining the lifetime of the memory by whatever
     means necessary.

 (B) Kernel drivers (e.g. network filesystems) can then use MSG_ZEROCOPY
     (MSG_SPLICE_PAGES can be discarded).  They can create their own message,
     cobbling it together out of kmalloc'd memory and arrays of pages, safe in
     the knowledge that the network stack will treat it only as an array of
     memory fragments.

     They would supply their own cleanup function to do the appropriate folio
     putting and would not need a "refill" function.  The extraction can be
     handled by standard iov_iter code.

     This would allow a network filesystem to transmit a complete RPC message
     with a single sendmsg() call, avoiding the need to cork the socket.

 (C) Make it easier to provide alternative userspace notification mechanisms
     than SO_EE_ORIGIN_ZEROCOPY.  Maybe by allowing a "cookie" to be passed in
     the control message that can be passed back by some other mechanism
     (e.g. recvmsg).  Or by providing a user address that can be altered and a
     futex triggered on it.

There's potentially a fourth bird too, but I'm not sure how practical they
are:

 (D) What if TCP and UDP sockets, say, *only* do zerocopy?  And that the
     syscall layer does the buffering transparently to hide that from the
     user?  That could massively simplify the lower layers and perhaps make
     the buffering more efficient.

     For instance, the data could be organised by the top layer into (large)
     pages and then the protocol would divide that up.  Smaller chunks that
     need to go immediately could be placed in kmalloc'd buffers rather than
     using a page frag allocator.

     There are some downsides/difficulties too.  Firstly, it would probably
     render the checksum-whilst-copying impossible (though being able to use
     CPU copy acceleration might make up for that, as might checksum offload).

     Secondly, it would mean that sk_buffs would have at least two fragments -
     header and data - which might be impossible for some NICs.

     Thirdly, some protocols just want to copy the data into their own skbuffs
     whatever.

There are also some issues with this proposal:

 (1) AF_ALG.  This does its own thing, including direct I/O without
     MSG_ZEROCOPY being set.  It doesn't actually use sk_buffs.  Really, it's
     not a network protocol in the normal sense and might have been better
     implemented as, say, a bunch of functions in io_uring.

 (2) Packet crypto.  Some protocols might want to do encryption from the
     source buffers into the skbuff and this would amount to a duplicate copy.

     This might be made more complicated by things like the TLS upper level
     protocol on TCP where we might be able to offload the crypto to the NIC,
     but might have to do it ourselves.

 (3) Is it possible to have a mixture of zerocopy and non-zerocopy pieces in
     the same sk_buff?  If there's a mixture, it would be possible to deal
     with the non-zerocopy bit by allocating a zerocopy record and setting
     the cleanup function just to free it.

Implementation notes:

 (1) What I'm thinking is that there will be an 'iov_manager' struct that
     manages a single call to sendmsg().  This will be refcounted and carry
     the completion state (kind of like ubuf_info) and the cleanup function
     pointer.

 (2) The upper layer will wrap iov_manager in its own thing (kind of like
     ubuf_info_msgzc).

 (3) For sys_sendmsg(), sys_sendmmsg() and io_uring() use a 'syscall-level
     manager' that will progressively pin and unpin userspace buffers.

     (a) This will keep a list of the memory fragments it currently has pinned
     	 in a rolling buffer.  It has to be able to find them to unpin them
     	 and it has to allow for the userspace addresses having been remapped
     	 or unmapped.

     (b) As its refill function gets called, the manager will pin more pages
     	 and add them to the producer end of the buffer.

     (c) These can then be extracted by the protocol into skbuffs.

     (d) As its cleanup function gets called, it will advance the consumer end
     	 and unpin/discard memory ranges that are consumed.

     I'm not sure how much drag this might add to performance, though, so it
     will need to be tried and benchmarked.

 (4) Possibly, the list of fragments can be made directly available through an
     iov_iter type and a subset attached directly to a sk_buff.

 (5) SOCK_STREAM sockets will keep an ordered list of manager structs, each
     tagged with the byte transmission sequence range for that struct.  The
     socket will keep a transmission completion sequence counter and as the
     counter advances through the manager list, their cleanup functions will
     be called and, ultimately, they'll be detached and put.

 (6) SOCK_DGRAM sockets will keep a list of manager structs on the sk_buff as
     well as on the socket.  The problem is that they may complete out of
     order, but SO_EE_ORIGIN_ZEROCOPY works by byte position.  Each time a
     sk_buff completes, all the managers attached to it are marked complete,
     but complete managers can only get cleaned up when they reach the front
     of the queue.

 (7) Kernel services will wrap iov_manager in their own wrapper and will pass
     down iterator that describes their message in its entirety through an
     iov_iter.

Finally, this doesn't cover recvmsg() zerocopy, which might also have some of
the same issues.

David


