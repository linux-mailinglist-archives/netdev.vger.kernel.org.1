Return-Path: <netdev+bounces-194385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB15AC9247
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382FFA401A6
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3D235053;
	Fri, 30 May 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOHqxnB1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A7235346
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618105; cv=none; b=h8hRLuKDxcSUjWSM7HBAZVc6tcCINEayjUaamokW8ml6tJQ4GRQMGNaMENAPTtaVT9fowqZzQ2jH9nS5j0pR+QkOsVtPc4e/NzuI6vObfLDnQWQdr4uD9AZQT1RfMocWCbw1H5VMPrRCWXWDttqWHyU8l3Fk1NTVX/dm7szUxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618105; c=relaxed/simple;
	bh=bW6CVJUiHWadt+mYwV5FCQe3aMmTEHPEdErCGuAAsAk=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=CgPOxloUoif6KSJtzLYzTiXz731u/w8+2SgPVFsU0ijLUxyOa7XYmW2xUTHxYgC2t4u2r/CZ7IF3B1000JHG0FMRNj0rujPWxrWdk9l4lW3PmCxcwBplaZ83aRqi6Puj+dNHQ7lNKcA9wMPirFtmH7+3vk0limSf6PACtCSbMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOHqxnB1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748618102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5ChLR8Q53hwqQuQzMZfSkqx9lSmOwysgUPte+4AIEQQ=;
	b=cOHqxnB1+dwgurzY/n2a1R/Sh2xcdMO0tE138CZfGSINixAx3TYuK9ckg+ldAsUDb964Kf
	NS5wLW5kvVspmWwSp4//Ip6yB2W4KCqDZIO4sPEFB+d/hf+sYLdxffirOaejI7k6SDCUls
	jPk3CB62Gpt0Ho0mrAA2hwlTrk3HUbg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-v_-spE01OQm82eg5NQtRIw-1; Fri,
 30 May 2025 11:14:58 -0400
X-MC-Unique: v_-spE01OQm82eg5NQtRIw-1
X-Mimecast-MFC-AGG-ID: v_-spE01OQm82eg5NQtRIw_1748618096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64909180056F;
	Fri, 30 May 2025 15:14:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0477A19560B2;
	Fri, 30 May 2025 15:14:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Mina Almasry <almasrymina@google.com>
cc: dhowells@redhat.com, willy@infradead.org, hch@infradead.org,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Device mem changes vs pinning/zerocopy changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <770011.1748618092.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 May 2025 16:14:52 +0100
Message-ID: <770012.1748618092@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Mina,

I've seen your transmission-side TCP devicemem stuff has just gone in and =
it
conflicts somewhat with what I'm trying to do.  I think you're working on =
the
problem bottom up and I'm working on it top down, so if you're willing to
collaborate on it...?

So, to summarise what we need to change (you may already know all of this)=
:

 (*) The refcount in struct page is going to go away.  The sk_buff fragmen=
t
     wrangling code, however, occasionally decides to override the zerocop=
y
     mode and grab refs on the pages pointed to by those fragments.  sk_bu=
ffs
     *really* want those page refs - and it does simplify memory handling.
     But.

     Anyway, we need to stop taking refs where possible.  A fragment may i=
n
     future point to a sequence of pages and we would only be getting a re=
f on
     one of them.

 (*) Further, the page struct is intended to be slimmed down to a single t=
yped
     pointer if possible, so all the metadata in the net_iov struct will h=
ave
     to be separately allocated.

 (*) Currently, when performing MSG_ZEROCOPY, we just take refs on the use=
r
     pages specified by the iterator but we need to stop doing that.  We n=
eed
     to call GUP to take a "pin" instead (and must not take any refs).  Th=
e
     pages we get access to may be folio-type, anon-type, some sort of dev=
ice
     type.

 (*) It would be good to do a batch lookup of user buffers to cut down on =
the
     number of page table trawls we do - but, on the other hand, that migh=
t
     generate more page faults upfront.

 (*) Splice and vmsplice.  If only I could uninvent them...  Anyway, they =
give
     us buffers from a pipe - but the buffers come with destructors and sh=
ould
     not have refs taken on the pages we might think they have, but use th=
e
     destructor instead.

 (*) The intention is to change struct bio_vec to be just physical address=
 and
     length, with no page pointer.  You'd then use, say, kmap_local_phys()=
 or
     kmap_local_bvec() to access the contents from the cpu.  We could then
     revert the fragment pointers to being bio_vecs.

 (*) Kernel services, such as network filesystems, can't pass kmalloc()'d =
data
     to sendmsg(MSG_SPLICE_PAGES) because slabs don't have refcounts and, =
in
     any case, the object lifetime is not managed by refcount.  However, i=
f we
     had a destructor, this restriction could go away.


So what I'd like to do is:

 (1) Separate fragment lifetime management from sk_buff.  No more wangling=
 of
     refcounts in the skbuff code.  If you clone an skb, you stick an extr=
a
     ref on the lifetime management struct, not the page.

 (2) Create a chainable 'network buffer' struct, e.g.:

	enum net_txbuf_type {
		NET_TXBUF_BUFFERED,	/* Buffered copy of data */
		NET_TXBUF_ZCOPY_USER,	/* Zerocopy of user buffers */
		NET_TXBUF_ZCOPY_KERNEL,	/* Zerocopy of kernel buffers */
	};

	struct net_txbuf {
		struct net_txbuf	next;
		struct mmpin		mm_pin;
		unsigned int		start_pos;
		unsigned int		end_pos;
		unsigned int		extracted_to;
		refcount_t		ref;
		enum net_txbuf_type	type;
		u8			nr_used;
		bool			wmem_charged;
		bool			got_copied;
		union {
			/* For NET_TXBUF_BUFFERED: */
			struct {
				void		*bufs[16];
				u8		bufs_orders[16];
				bool		last_buf_freeable;
			};
			/* For NET_TXBUF_ZCOPY_*: */
			struct {
				struct sock	*sk;
				struct sk_buff	*notify;
				msg_completion_t completion;
				void		*completion_data;
				struct bio_vec	frags[12];
			};
		};
	};

     (Note this is very much still a WiP and very much subject to change)

     So how I envision it working depends on the type of flow in the socke=
t.
     For the transmission side of streaming sockets (e.g. TCP), the socket
     maintains a single chain of these.  Each txbuf is of a single type, b=
ut
     multiple types can be interleaved.

     For non-ZC flow, as data is imported, it's copied into pages attached=
 to
     the current head txbuf of type BUFFERED, with more pages being attach=
ed
     as we progress.  Successive writes just keep adding to the space in t=
he
     latest page added and each skbuff generated pins the txbuf it starts =
at
     and each txbuf pins its successor.

     As skbuffs are consumed, they unpin the root txbuf.  However, this co=
uld
     leave an awful lot of memory pinned for a long time, so I would mitig=
ate
     this in two ways: firstly, where possible, keep track of the transmit=
ted
     byte position and progressively destruct the txbuf; secondly, if we
     completely use up a partially filled txbuf then reset the queue.

     An skbuff's frag list then has a bio_vec[] that refers to fragments o=
f
     the buffers recorded in the txbuf chain.  An skbuff may span multiple
     txbufs and a txbuf may provision multiple skbuffs.

     For the transmission side of datagram sockets (e.g. UDP) where the
     messages may complete out of order, I think I would give each datagra=
m
     its own series of txbufs, but link the tails together to manage the
     SO_EE_ORIGIN_ZEROCOPY notification generation if dealing with userspa=
ce.
     If dealing with the kernel, there's no need to link them together as =
the
     kernel can provide a destructor for each datagram.

 (3) When doing zerocopy from userspace, do calls to GUP to get batches of
     non-contiguous pages into a bio_vec array.

 (4) Because AF_UNIX and the loopback driver transfer packets from the
     transmission queue of one socket down into the reception queue of
     another, the use of txbufs would also need to extend onto the receive
     side (and so "txbufs" would be a misnomer).

     When receiving a packet, a txbuf would need to be allocated and the
     received buffers attached to it.  The pages wouldn't necessarily need
     refcounts as the txbuf holds them.  The skbuff holds a ref on the txb=
uf.

 (5) Cloning an skbuff would involve just taking an extra ref on the first
     txbuf.  Splitting off part of an skbuff would involve fast-forwarding=
 the
     txbuf chain for the second part and pinning that.

 (6) I have a chained-bio_vec array concept with iov_iter type for it that
     might make it easier to string together the fragments in a reassemble=
d
     packet and represent it as an iov_iter, thereby allowing us to use co=
mmon
     iterator routines for things like ICMP and packet crypto.

 (7) We need to separate net_iov from struct page, and it might make thing=
s
     easier if we do that now, allocating net_iov from a slab.

 (8) Reference the txbuf in a splice and provide a destructor that drops t=
hat
     reference.  For small splices, I'd be very tempted to simply copy the
     data.  For splice-out of data that was spliced into an AF_UNIX socket=
 or
     zerocopy data that passed through a loopback device, I'm also very
     tempted to make splice copy at that point.  There's a potential DoS
     attack whereby someone can endlessly splice tiny bits of a message or
     just sit on them, preventing the original provider from recovering it=
s
     memory.

 (9) Make it easy for a network filesystem to create an entire compound
     message and present it to the socket in a single sendmsg() with a
     destructor.

I've pushed my current changes (very incomplete as they are) to:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Diov-experimental

I'm writing functions to abstract out the loading of data into the txbuf c=
hain
and attach to skbuff.  These can be found in skbuff.c as net_txbuf_*().  I=
've
modified the TCP sendmsg to use them.

David


