Return-Path: <netdev+bounces-194398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31DAC9371
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3E3A570A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA501AE877;
	Fri, 30 May 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivGrwFXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390D258A
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622153; cv=none; b=V67b7weqNaCsf20l1YykDtKSBX7OJas0Cb7Rtc3oh70UWT3TbR7yGNyu6WIRIaBfBTf8GGzLLRrJFWyHluMt7cPKBSqli2ciiqpdoFCtJy9msTxcCW/BEIuBcDPo/x8lu7QkYViYxWoD7bbJGNVEHwlFNz5uRMREh/xO4QophPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622153; c=relaxed/simple;
	bh=ZBGTax/rLGYBtNFTsE9QQBLSrJoNOS5o8XO3INA0fdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWsclWzjfUuUxlWp+BW4jX7SX/DEHCdGJtAAw6at9nvsLXP6AAyOcCU2NZOjI9nAMgLziPeuk0dfvSFV+9pEihgZkQZLF3qTDNj1u+5HnncKCWQ2CPfTPJXHGraB9LQX9mJADNy3Kt+CDp9xPlR0+Vgb83YoIFRx+N5ukNbOkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivGrwFXI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2348ac8e0b4so183975ad.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748622150; x=1749226950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf6Yud61p5FojbXNBMIgSMyrP3LQYQ4cOutBnHeT7EE=;
        b=ivGrwFXIrSY9qKABLSoGm7ITyeJOsXL0RdoD36abLhdWnKia+pH+YIsdTOXXie8UtO
         POVKVg3KMlbj9fzknILIutDZC0DuHHs3wvo7XilgvhR8fFKyFd3IpMhImEqAnXxaOAUR
         kIPF9lthSo9X2z9nUNFzEu2nuQ5gtI86SO8kEnd9+BiZfQqL4eV8IfnMS0U7ufAIXuEm
         Bknv8BMjNAbTwOfJaUEbYqfF7sIXxllSS/ZkG+DtFYeU8Fc8k/q1JuueaxQdp3NMmxUs
         gIxR4yNtD+B5mbfZkFZt38E07xVJjKzSG0DOum59YUkZE2sYxQNBBm77d2Wx0NgLHFCm
         1KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748622150; x=1749226950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf6Yud61p5FojbXNBMIgSMyrP3LQYQ4cOutBnHeT7EE=;
        b=djGxHaOtDfqU2oSlhTIP0XNGT8KXecmrq0xNM07eJkdEo8LTO22NLwqahFvQqbG4kF
         QdPhtSMXAMpAqdJkY6bbkzkkyMJLDDSofo2/PuKZW6KmB+HKyGNQUlYgVxJTPM57Gv5u
         wLMK5yv+XnXjl+ohFsFYM7KjV+OVV9+gN3v262AYryZUbUKnpSuzw1PH8RXR/43CYrzC
         +yrsaiQITekzm8cGAzHZLH612xK94sNNI6PJjdq9gotsP7xHFIUqnECpr79bWpNqP3mI
         kWtvrq1qnpe83LW1a4hxiw19WjWWdDXqlUV7oSXWsPzb6mB0mgNtQnaw7bmvgQJtDA0K
         9IOg==
X-Forwarded-Encrypted: i=1; AJvYcCXP9/YFGRA43u7lQTPTA2zMfqCMLO703rzK+wsn0lozVUy8bHPRbbAT4OXbgvDHLOiXAKM+aH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKz5HENWIaOtHsINvPg6mL5Xr0GM20Fvq5jndsScUacpQ0joK7
	2Wfxloq+BD7xp8lXm0x//PO/Mxg5UDvGFu1SSM71Er6aYV0+gjwU5prPs1Yjo0O9GUlhL4+vscv
	dFF8gFLY9/gV6xHh4bpUZCp48A5Ia4mRsT3cns1ko
X-Gm-Gg: ASbGncsgV/8N23rowfgwjUs6TiH0gq7+pGwmbNd8Al49qUfIaihOOdQ/juYRBcFacOG
	WoBfTalmW3Vfik5boUSoi6HNmNzilnoSQ7quVXyOaB5bBJFYdaqg4Mq0DjscdYlcyfREserh8Ad
	K8gYV+idrerb81/R9KGD6vxlKD8CKMNOnBJAxOouw5JD4Ch2/Qjf6l1bM=
X-Google-Smtp-Source: AGHT+IEtiJzkhMrbT4HUzOjYjtF5aql9Xb8hdrSN3Cti84xfY4Vb6+gwtO/xOvIq6bw5m4mFgqm8TBezlJPtYjT+ba0=
X-Received: by 2002:a17:903:32c2:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-2352dfcade3mr3925465ad.14.1748622149915; Fri, 30 May 2025
 09:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770012.1748618092@warthog.procyon.org.uk>
In-Reply-To: <770012.1748618092@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 30 May 2025 09:22:17 -0700
X-Gm-Features: AX0GCFv_9CblvKqE59Fn0enXIWdu9lK-Q9GgqjjgMg5PEL2NBfaZtCi1kNaSC5g
Message-ID: <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com>
Subject: Re: Device mem changes vs pinning/zerocopy changes
To: David Howells <dhowells@redhat.com>
Cc: willy@infradead.org, hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 8:15=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Mina,
>
> I've seen your transmission-side TCP devicemem stuff has just gone in and=
 it
> conflicts somewhat with what I'm trying to do.  I think you're working on=
 the
> problem bottom up and I'm working on it top down, so if you're willing to
> collaborate on it...?
>

Hi David! Yes, very happy to collaborate. FWIW, my initial gut feeling
is that the work doesn't conflict that much. The tcp devmem
netmem/net_iov stuff is designed to follow the page stuff, and as the
usage of struct page changes we're happy moving net_iovs and netmems
to do the same thing. My read is that it will take a small amount of
extra work, but there are no in-principle design conflicts, at least
AFAICT so far.

> So, to summarise what we need to change (you may already know all of this=
):
>
>  (*) The refcount in struct page is going to go away.  The sk_buff fragme=
nt
>      wrangling code, however, occasionally decides to override the zeroco=
py
>      mode and grab refs on the pages pointed to by those fragments.  sk_b=
uffs
>      *really* want those page refs - and it does simplify memory handling=
.
>      But.
>

I believe the main challenge here is that there are many code paths in
the net stack that expect to be able to grab a ref on skb frags. See
all the callers of skb_frag_ref/skb_frag_unref:

tcp_grow_skb, __skb_zcopy_downgrade_managed, __pskb_copy_fclone,
pskb_expand_head, skb_zerocopy, skb_split, pksb_carve_inside_header,
pskb_care_inside_nonlinear, tcp_clone_payload, skb_segment.

I think to accomplish what you're describing we need to modify
skb_frag_ref to do something else other than taking a reference on the
page or net_iov. I think maybe taking a reference on the skb itself
may be acceptable, and the skb can 'guarantee' that the individual
frags underneath it don't disappear while these functions are
executing.

But devmem TCP doesn't get much in the way here, AFAICT. It's really
the fact that so many of the networking code paths want to obtain page
refs via skb_frag_ref so there is potentially a lot of code to touch.

>      Anyway, we need to stop taking refs where possible.  A fragment may =
in
>      future point to a sequence of pages and we would only be getting a r=
ef on
>      one of them.
>
>  (*) Further, the page struct is intended to be slimmed down to a single =
typed
>      pointer if possible, so all the metadata in the net_iov struct will =
have
>      to be separately allocated.
>

Yes, I'm already collaborating with Byungchul on this, and we're
making great progress. I think this may be close to getting fully
reviewed:

https://lore.kernel.org/netdev/20250509115126.63190-1-byungchul@sk.com/

According to his cover letter, he's actually finding the work that I
did with netmem/net_iovs useful for him.

>  (*) Currently, when performing MSG_ZEROCOPY, we just take refs on the us=
er
>      pages specified by the iterator but we need to stop doing that.  We =
need
>      to call GUP to take a "pin" instead (and must not take any refs).  T=
he
>      pages we get access to may be folio-type, anon-type, some sort of de=
vice
>      type.
>

This also doesn't conflict with devmem changes, AFAICT. Currently in
devmem we take references on the user devmem only because pages also
take a reference on the user pages (we mirror devmem and pages to keep
the netstack uniform without excessive mem-type checks). If the code
path for  zerocopy_fill_skb_from_iter doesn't need to take ref on the
pages, we'll just migrate  zerocopy_fill_skb_from_devmem to do the
same thing.

>  (*) It would be good to do a batch lookup of user buffers to cut down on=
 the
>      number of page table trawls we do - but, on the other hand, that mig=
ht
>      generate more page faults upfront.
>
>  (*) Splice and vmsplice.  If only I could uninvent them...  Anyway, they=
 give
>      us buffers from a pipe - but the buffers come with destructors and s=
hould
>      not have refs taken on the pages we might think they have, but use t=
he
>      destructor instead.
>

The above 2 points are orthogonal to devmem. There is no page table
walks, splice, or vmsplice with devmem. We just have to make sure that
the generic changes you're implementing also work with the devmem
paths. I can test your changes and point if I see any issue, but I
don't see a conflict in-principle.

>  (*) The intention is to change struct bio_vec to be just physical addres=
s and
>      length, with no page pointer.  You'd then use, say, kmap_local_phys(=
) or
>      kmap_local_bvec() to access the contents from the cpu.  We could the=
n
>      revert the fragment pointers to being bio_vecs.
>

Ok, this part conflicts a bit, maybe. skb_frag_ref no longer uses
struct bio_vec. I merged that change before 6.12 kernel, it's not a
very recent change:

https://lore.kernel.org/netdev/20240214223405.1972973-3-almasrymina@google.=
com/

But, AFAICT, skb_frag_t needs a struct page inside of it, not just a
physical address. skb_frags can mmap'd into userspace for TCP
zerocopy, see tcp_zerocopy_vm_insert_batch (which is a very old
feature, it's not a recent change). There may be other call paths in
the net stack that require a full page and just a physical address
will do. (unless somehow we can mmap a physical address to the
userspace).

>  (*) Kernel services, such as network filesystems, can't pass kmalloc()'d=
 data
>      to sendmsg(MSG_SPLICE_PAGES) because slabs don't have refcounts and,=
 in
>      any case, the object lifetime is not managed by refcount.  However, =
if we
>      had a destructor, this restriction could go away.
>

This also sounds orthogonal to devmem.

>
> So what I'd like to do is:
>
>  (1) Separate fragment lifetime management from sk_buff.  No more wanglin=
g of
>      refcounts in the skbuff code.  If you clone an skb, you stick an ext=
ra
>      ref on the lifetime management struct, not the page.
>

Agreed, and AFAICT devmem doesn't get in the way. Let me know if you
disagree or are seeing something different.

>  (2) Create a chainable 'network buffer' struct, e.g.:
>
>         enum net_txbuf_type {
>                 NET_TXBUF_BUFFERED,     /* Buffered copy of data */
>                 NET_TXBUF_ZCOPY_USER,   /* Zerocopy of user buffers */
>                 NET_TXBUF_ZCOPY_KERNEL, /* Zerocopy of kernel buffers */
>         };
>
>         struct net_txbuf {
>                 struct net_txbuf        next;
>                 struct mmpin            mm_pin;
>                 unsigned int            start_pos;
>                 unsigned int            end_pos;
>                 unsigned int            extracted_to;
>                 refcount_t              ref;
>                 enum net_txbuf_type     type;
>                 u8                      nr_used;
>                 bool                    wmem_charged;
>                 bool                    got_copied;
>                 union {
>                         /* For NET_TXBUF_BUFFERED: */
>                         struct {
>                                 void            *bufs[16];
>                                 u8              bufs_orders[16];
>                                 bool            last_buf_freeable;
>                         };
>                         /* For NET_TXBUF_ZCOPY_*: */
>                         struct {
>                                 struct sock     *sk;
>                                 struct sk_buff  *notify;
>                                 msg_completion_t completion;
>                                 void            *completion_data;
>                                 struct bio_vec  frags[12];
>                         };
>                 };
>         };
>
>      (Note this is very much still a WiP and very much subject to change)
>
>      So how I envision it working depends on the type of flow in the sock=
et.
>      For the transmission side of streaming sockets (e.g. TCP), the socke=
t
>      maintains a single chain of these.  Each txbuf is of a single type, =
but
>      multiple types can be interleaved.
>
>      For non-ZC flow, as data is imported, it's copied into pages attache=
d to
>      the current head txbuf of type BUFFERED, with more pages being attac=
hed
>      as we progress.  Successive writes just keep adding to the space in =
the
>      latest page added and each skbuff generated pins the txbuf it starts=
 at
>      and each txbuf pins its successor.
>
>      As skbuffs are consumed, they unpin the root txbuf.  However, this c=
ould
>      leave an awful lot of memory pinned for a long time, so I would miti=
gate
>      this in two ways: firstly, where possible, keep track of the transmi=
tted
>      byte position and progressively destruct the txbuf; secondly, if we
>      completely use up a partially filled txbuf then reset the queue.
>
>      An skbuff's frag list then has a bio_vec[] that refers to fragments =
of
>      the buffers recorded in the txbuf chain.  An skbuff may span multipl=
e
>      txbufs and a txbuf may provision multiple skbuffs.
>
>      For the transmission side of datagram sockets (e.g. UDP) where the
>      messages may complete out of order, I think I would give each datagr=
am
>      its own series of txbufs, but link the tails together to manage the
>      SO_EE_ORIGIN_ZEROCOPY notification generation if dealing with usersp=
ace.
>      If dealing with the kernel, there's no need to link them together as=
 the
>      kernel can provide a destructor for each datagram.
>

To be honest, I didn't follow the entirety of point #2 here, but the
problem is not related to devmem.

Is struct net_txbuf intended to replace struct sk_buff in the tx path
only? If so, I'm not sure that works. Currently TX and RX memory share
a single data structure (sk_buff), and I believe that is critical.
Because RX skbs can be forwarded to TX and vice-versa. You will need
to implement an net_txbuf_to_skb helper and vice versa if you go this
route, no? So I think, maybe, instead of introducing a new struct, you
have to make the modifications you envision to struct sk_buff itself?

 >  (3) When doing zerocopy from userspace, do calls to GUP to get batches =
of
>      non-contiguous pages into a bio_vec array.
>
>  (4) Because AF_UNIX and the loopback driver transfer packets from the
>      transmission queue of one socket down into the reception queue of
>      another, the use of txbufs would also need to extend onto the receiv=
e
>      side (and so "txbufs" would be a misnomer).
>

OK, you realize that TX packets can be forwarded to RX. The opposite
is true, RX can be forwarded to TX. And it's not just AF_UNIX and
loopback. Packets can be forwarded via ip forwarding, and tc, and
probably another half dozen features in the net stack I don't know
about. I think you need to modify the existing sk_buff. I think adding
a new struct and migrating the entire net stack to use that is a bit
too ambitious. But up to you. Just my 2 cents here.

>      When receiving a packet, a txbuf would need to be allocated and the
>      received buffers attached to it.  The pages wouldn't necessarily nee=
d
>      refcounts as the txbuf holds them.  The skbuff holds a ref on the tx=
buf.
>
>  (5) Cloning an skbuff would involve just taking an extra ref on the firs=
t
>      txbuf.  Splitting off part of an skbuff would involve fast-forwardin=
g the
>      txbuf chain for the second part and pinning that.
>
>  (6) I have a chained-bio_vec array concept with iov_iter type for it tha=
t
>      might make it easier to string together the fragments in a reassembl=
ed
>      packet and represent it as an iov_iter, thereby allowing us to use c=
ommon
>      iterator routines for things like ICMP and packet crypto.
>
>  (7) We need to separate net_iov from struct page, and it might make thin=
gs
>      easier if we do that now, allocating net_iov from a slab.
>

net_iov is already separate from struct page. The only commonality
they share is that we static_assert the offset of some page pool
fields are the same in struct page and struct net_iov, but that's it.
Byungchul is already handling the entire
netmem_desc-shrink-struct-page in the series I linked to earlier and I
would say his work is going well.

>  (8) Reference the txbuf in a splice and provide a destructor that drops =
that
>      reference.  For small splices, I'd be very tempted to simply copy th=
e
>      data.  For splice-out of data that was spliced into an AF_UNIX socke=
t or
>      zerocopy data that passed through a loopback device, I'm also very
>      tempted to make splice copy at that point.  There's a potential DoS
>      attack whereby someone can endlessly splice tiny bits of a message o=
r
>      just sit on them, preventing the original provider from recovering i=
ts
>      memory.
>
>  (9) Make it easy for a network filesystem to create an entire compound
>      message and present it to the socket in a single sendmsg() with a
>      destructor.
>
> I've pushed my current changes (very incomplete as they are) to:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Diov-experimental
>
> I'm writing functions to abstract out the loading of data into the txbuf =
chain
> and attach to skbuff.  These can be found in skbuff.c as net_txbuf_*().  =
I've
> modified the TCP sendmsg to use them.
>


--=20
Thanks,
Mina

