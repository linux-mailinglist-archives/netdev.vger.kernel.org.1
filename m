Return-Path: <netdev+bounces-152835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8859F5E5A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3197916747D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 05:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA71531F2;
	Wed, 18 Dec 2024 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Hq2GglAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B3150994
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500849; cv=none; b=cnJXjiCWPK4hKMVw4aR9k7jFqIafTVN1rL4YU8ZpVFCrAfgXNiUDHSj8WBIGh8KG05FWrpn8K3am+SQOke7Rc0Rtm0HKbZqAi5dGlGx128gqhCTlISVSJ0/2bjiKv4+fLkDm92de/HJvw4zvd+EiUQZCIGH7wJRk8jtNh3kjYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500849; c=relaxed/simple;
	bh=tvqhlA1So2MiJswrm7ua0y5fzCK5kLp9fRv6o6B8fBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtjbt9Wrw6mF2PALB36qA/PG+/mK4tVcyTLM4kaE3BaGuEMh8Aso2rJpkcJQVfKU378Lj9cUYa+oWTbrksJlrzpey6l/Xa/NkWQNkSeKdGmn4uk3SGZCDSSJ9V0TBiZrGJjtcSgXxG+gIFvIOB8TOVhMSjOa3rPCZ1+bAmb4/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Hq2GglAH; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I+9oJElXF7jfg8iSqrdpWeXw+VBvjwloFBZObm8Msww=; t=1734500847; x=1735364847; 
	b=Hq2GglAHu9Oe+HtPfHLnp/6TYbHSY4wHTb0rOSf6qbl6Z2oP/wIJ3GEYWy/QHlpEAF+VZPiUqqB
	87PMEtmeM7B5HoGOUTvaHIIaYRKipKukSCc3FlGpoidatFctmuTo5wEP3kRACDMSqWf7FH38nj0NZ
	VD1o7SCAGAeg+8Be2ccJxRoJrtd2OCp2zMQyH23awjLd5ksz1e2VOXDqE9ZKPYCw1vCPkxCVHk2eW
	9YCYhju9e2WJ0uefsc0xdT5udGc6bK4aQAhCrsEgWCEiiuCIuJLvi8/5eBhtae0StmevKc8ms5u5g
	6cTF4KhrT0hb1KERtLbtfYQJ9VwKDRFwD4dA==;
Received: from mail-oa1-f49.google.com ([209.85.160.49]:46523)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tNmtz-0001VC-HZ
	for netdev@vger.kernel.org; Tue, 17 Dec 2024 21:47:20 -0800
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29f88004a92so3785798fac.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:47:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxHYH82fo2g7ueITstXvzIRMCv1SiLTrg6pRHRfaWVEfqDQ9rcT
	p2Xg/LBnGw2uOrROi2CnVkmC+wo9CFw1O/ZeajBpehqR0KkoD54FrVnHE77MsGJVjMesGxi9DLs
	pne36Yq3MCW/TJaje9PMXikUrimg=
X-Google-Smtp-Source: AGHT+IFhabdXLMbd5amLGMeqVwGU10LGr3ZFzCxhJT6dF+48Lz+OV+BVqo9o5++Ogra5d5vY7n8OCVMhsMrmi05BsIU=
X-Received: by 2002:a05:6871:e789:b0:29e:2bbd:51cb with SMTP id
 586e51a60fabf-2a7b3191587mr784723fac.24.1734500838834; Tue, 17 Dec 2024
 21:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-5-ouster@cs.stanford.edu>
 <8a73091e-5d4a-4802-ffef-a382adbbe88f@gmail.com>
In-Reply-To: <8a73091e-5d4a-4802-ffef-a382adbbe88f@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 17 Dec 2024 21:46:42 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzVYDQtBVwdhazf9R2UgMCOOwppD+EM2-NY25t+N1vJhA@mail.gmail.com>
Message-ID: <CAGXJAmzVYDQtBVwdhazf9R2UgMCOOwppD+EM2-NY25t+N1vJhA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/12] net: homa: create shared Homa header files
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 1.7
X-Spam-Level: *
X-Scan-Signature: 4e86d9cc3a7ad87a05d43251e6cd845a

(note: these comments arrived after I posted the v4 patch series, so
fixes will appear in v5)

On Mon, Dec 16, 2024 at 10:36=E2=80=AFPM Edward Cree <ecree.xilinx@gmail.co=
m> wrote:
>
> On 09/12/2024 17:51, John Ousterhout wrote:
> > oma_impl.h defines "struct homa", which contains overall information
> > about the Homa transport, plus various odds and ends that are used
> > throughout the Homa implementation.
>
> Should parts of 'struct homa' be per network namespace, rather than
>  global, so that in systems hosting multiple containers each netns can
>  configure Homa for the way it wants to use it?

Possibly. I haven't addressed the issue of customizing the
configuration very thoroughly yet, but I can imagine it might happen
at multiple levels (e.g. for a network namespace, a socket, etc.). I'd
like to defer this a bit if possible.

> > +struct homa_interest {
> > +     /**
> > +      * @thread: Thread that would like to receive a message. Will get
> > +      * woken up when a suitable message becomes available.
> > +      */
> > +     struct task_struct *thread;
> > +
> > +     /**
> > +      * @ready_rpc: This is actually a (struct homa_rpc *) identifying=
 the
> > +      * RPC that was found; NULL if no RPC has been found yet. This
> > +      * variable is used for synchronization to handoff the RPC, and
> > +      * must be set only after @locked is set.
> > +      */
> > +     atomic_long_t ready_rpc;
> > +
> > +     /**
> > +      * @locked: Nonzero means that @ready_rpc is locked; only valid
> > +      * if @ready_rpc is non-NULL.
> > +      */
> > +     int locked;
>
> These feel weird; what kind of synchronisation is this for and why
>  aren't any of Linux's existing locking primitives suitable?  In
>  particular the non-typesafe casting of ready_rpc is unpleasant.
> I looked at sync.txt and didn't find an explanation, and it wasn't
>  obvious from reading homa_register_interests() either.  (Are plain
>  writes to int even guaranteed to be ordered wrt the atomics on
>  rpc->flags or ready_rpc?)
> My best guess from looking at how `thread` is used is that all this
>  is somehow simulating a completion?  You shouldn't need to manually
>  do stuff like sleeping and waking threads from within something as
>  generic as a protocol implementation.

This is a lock-free mechanism to hand off a complete message to a
receiver thread (which may be polling, though the polling code has
been removed from this stripped down patch series). I couldn't find an
"atomic pointer" structure, which is why the code uses atomic_long_t
(which I agree is a bit ugly).Memory ordering w.r.t. @locked is
ensured by using atomic_long_set_release to modify @ready_rpc. I'm not
sure I understand your comment about not manually sleeping and waking
threads from within Homa; is there a particular mechanism for this
that you have in mind?

I improved the comment a bit, plus added accessor functions
homa_interest_get_rpc and homa_interest_set_rpc; hopefully this will
make the code a bit less mysterious.

> > +     interest->request_links.next =3D LIST_POISON1;
> > +     interest->response_links.next =3D LIST_POISON1;
>
> Any particular reason why you're opencoding poisoning, rather than
>  using the list helpers (which distinguish between a list_head that
>  has been inited but never added, so list_empty() returns true, and
>  one which has been list_del()ed and thus poisoned)?
> It would likely be easier for others to debug any issues that arise
>  in Homa if when they see a list_head in an oops or crashdump they
>  can relate it to the standard lifecycle.

I couldn't find any other way to do this: I want to initialize the
links to be the same state as if list_del had been called, but
list_del requires the links already to be initialized. I couldn't find
a function that just poisons the links. I suppose I could first
initialize them and then call list_del, but that felt a bit awkward
also?

> > +/**
> > + * struct homa - Overall information about the Homa protocol implement=
ation.
> > + *
> > + * There will typically only exist one of these at a time, except duri=
ng
> > + * unit tests.
> > + */
> > +struct homa {
> > +     /**
> > +      * @next_outgoing_id: Id to use for next outgoing RPC request.
> > +      * This is always even: it's used only to generate client-side id=
s.
> > +      * Accessed without locks.
> > +      */
> > +     atomic64_t next_outgoing_id;
>
> Does the ID need to be unique for the whole machine or just per-
>  interface?  I would imagine it should be sufficient for the
>  (id, source address) or even (id, saddr, sport) tuple to be
>  unique.

IDs are unique to the client machine. I've updated the comment to indicate =
this.

> And are there any security issues here; ought we to do anything
>  like TCP does with sequence numbers to try to ensure they aren't
>  guessable by an attacker?

There probably are, and the right solutions may well be similar to
TCP. I'm fairly ignorant on the potential security issues; is there
someplace where I can learn more?

> > +     /**
> > +      * @throttled_rpcs: Contains all homa_rpcs that have bytes ready
> > +      * for transmission, but which couldn't be sent without exceeding
> > +      * the queue limits for transmission. Manipulate only with "_rcu"
> > +      * functions.
> > +      */
> > +     struct list_head throttled_rpcs;
>
> I'm not sure exactly how it works but I believe you can annotate
>  the declaration with __rcu to get sparse to enforce this.

I poked around and it appears to me that list_head's don't get
declared '__rcu' (this designation is intended for pointers, if I'm
understanding correctly). Instead, the list_head is manipulated with
rcu functions such as list_for_each_entry_rcu. Let me know if I'm
missing something?

> > +     /**
> > +      * @next_client_port: A client port number to consider for the
> > +      * next Homa socket; increments monotonically. Current value may
> > +      * be in the range allocated for servers; must check before using=
.
> > +      * This port may also be in use already; must check.
> > +      */
> > +     __u16 next_client_port __aligned(L1_CACHE_BYTES);
>
> Again, does guessability by an attacker pose any security risks
>  here?

Potentially; how can I learn more?

> > +     /**
> > +      * @link_bandwidth: The raw bandwidth of the network uplink, in
> > +      * units of 1e06 bits per second.  Set externally via sysctl.
> > +      */
> > +     int link_mbps;
>
> What happens if a machine has two uplinks and someone wants to
>  use Homa on both of them?  I wonder if most of the granting and
>  pacing part of Homa ought to be per-netdev rather than per-host.
> (Though in an SDN case with a bunch of containers issuing their
>  RPCs through veths you'd want a Homa-aware bridge that could do
>  the SRPT rather than bandwidth sharing, and having everything go
>  through a single Homa stack instance does give you that for free.
>  But then a VM use-case still needs the clever bridge anyway.)

Yes, I'm planning to implement a Homa-specific qdisc that will
implement packet pacing on a per-netdev basis, and that will eliminate
the need for this variable. Granting may also need to be per-netdev...
I'll need to think more about that. Virtual machines are more complex;
to do Homa right, pacing (and potentially granting also) must be done
in a central place that knows about all traffic on a given link.

> > +     /**
> > +      * @timeout_ticks: abort an RPC if its silent_ticks reaches this =
value.
> > +      */
> > +     int timeout_ticks;
>
> This feels more like a socket-level option, perhaps?  Just
>  thinking out loud.

Possibly. Several other configuration options may also fit in this
category. As I said above, at some point I need to think more
comprehensively about managing options; hopefully this won't be a
show-stopper for upstreaming Homa?

> > +     /**
> > +      * @gso_force_software: A non-zero value will cause Home to perfo=
rm
> > +      * segmentation in software using GSO; zero means ask the NIC to
> > +      * perform TSO. Set externally via sysctl.
> > +      */
>
> "Home" appears to be a typo.

Fixed.

> > +     /**
> > +      * @temp: the values in this array can be read and written with s=
ysctl.
> > +      * They have no officially defined purpose, and are available for
> > +      * short-term use during testing.
> > +      */
> > +     int temp[4];
>
> I don't think this belongs in upstream.  At best maybe under an ifdef
>  like CONFIG_HOMA_DEBUG?

I've now arranged for this to be stripped from the upstream version of
Homa. I'll keep it in my development version.

> > +/**
> > + * homa_get_skb_info() - Return the address of Homa's private informat=
ion
> > + * for an sk_buff.
> > + * @skb:     Socket buffer whose info is needed.
> > + */
> > +static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *=
skb)
> > +{
> > +     return (struct homa_skb_info *)(skb_end_pointer(skb)
> > +                     - sizeof(struct homa_skb_info));
> > +}
> > +
> > +/**
> > + * homa_next_skb() - Compute address of Homa's private link field in @=
skb.
> > + * @skb:     Socket buffer containing private link field.
> > + *
> > + * Homa needs to keep a list of buffers in a message, but it can't use=
 the
> > + * links built into sk_buffs because Homa wants to retain its list eve=
n
> > + * after sending the packet, and the built-in links get used during se=
nding.
> > + * Thus we allocate extra space at the very end of the packet's data
> > + * area to hold a forward pointer for a list.
> > + */
> > +static inline struct sk_buff **homa_next_skb(struct sk_buff *skb)
> > +{
> > +     return (struct sk_buff **)(skb_end_pointer(skb) - sizeof(char *))=
;
> > +}
>
> This is confusing =E2=80=94 why doesn't homa_next_skb(skb) equal
>  &homa_get_skb_info(skb)->next_skb?  Is one used on TX and the other
>  on RX, or something?
>
> And could these subtractions be written as first casting to the
>  appropriate pointer type and then subtracting 1, instead of
>  subtracting sizeof from the unsigned char *end_pointer?
> (Particularly as here you've taken sizeof a different kind of
>  pointer =E2=80=94 I know sizeof(char *) =3D=3D sizeof(struct sk_buff *),=
 but
>  it's still kind of unclean.)

Good points. I have reworked homa_get_skb_info to use "- 1" as you
suggested. homa_next_skb is no longer used and incorrect; I have
removed it.

> > +
> > +/**
> > + * homa_set_doff() - Fills in the doff TCP header field for a Homa pac=
ket.
> > + * @h:     Packet header whose doff field is to be set.
> > + * @size:  Size of the "header", bytes (must be a multiple of 4). This
> > + *         information is used only for TSO; it's the number of bytes
> > + *         that should be replicated in each segment. The bytes after
> > + *         this will be distributed among segments.
> > + */
> > +static inline void homa_set_doff(struct data_header *h, int size)
> > +{
> > +     h->common.doff =3D size << 2;
>
> Either put a comment here about the data offset being the high 4
>  bits of doff, or use "(size >> 2) << 4" (or both!); at first
>  glance this looks like a typo shifting the wrong way.
> (TCP avoids this by playing games with bitfields in struct tcphdr.)

I added a comment.

> > +/**
> > + * ipv4_to_ipv6() - Given an IPv4 address, return an equivalent IPv6 a=
ddress
> > + * (an IPv4-mapped one).
> > + * @ip4: IPv4 address, in network byte order.
> > + */
> > +static inline struct in6_addr ipv4_to_ipv6(__be32 ip4)
> > +{
> > +     struct in6_addr ret =3D {};
> > +
> > +     if (ip4 =3D=3D htonl(INADDR_ANY))
> > +             return in6addr_any;
> > +     ret.in6_u.u6_addr32[2] =3D htonl(0xffff);
> > +     ret.in6_u.u6_addr32[3] =3D ip4;
> > +     return ret;
> > +}
> > +
> > +/**
> > + * ipv6_to_ipv4() - Given an IPv6 address produced by ipv4_to_ipv6, re=
turn
> > + * the original IPv4 address (in network byte order).
> > + * @ip6:  IPv6 address; assumed to be a mapped IPv4 address.
> > + */
> > +static inline __be32 ipv6_to_ipv4(const struct in6_addr ip6)
> > +{
> > +     return ip6.in6_u.u6_addr32[3];
> > +}
> ...
> > +/**
> > + * is_mapped_ipv4() - Return true if an IPv6 address is actually an
> > + * IPv4-mapped address, false otherwise.
> > + * @x:  The address to check.
> > + */
> > +static inline bool is_mapped_ipv4(const struct in6_addr x)
> > +{
> > +     return ((x.in6_u.u6_addr32[0] =3D=3D 0) &&
> > +             (x.in6_u.u6_addr32[1] =3D=3D 0) &&
> > +             (x.in6_u.u6_addr32[2] =3D=3D htonl(0xffff)));
> > +}
>
> These probably belong in some general inet header rather than being
>  buried inside Homa.  There's __ipv6_addr_type() but that might be a
>  bit heavyweight; also ipv6_addr_v4mapped() and
>  ipv6_addr_set_v4mapped() in include/net/ipv6.h.

I was able to replace is_mapped_ipv4 with ipv6_addr_v4mapped, and I
found ipv6_addr_set_v4mapped to replace ipv4_to_ipv6, but I couldn't
find replacements for ipv6_to_ipv4 or skb_is_ipv6, so I left those
functions in place.

-John-

