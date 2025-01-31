Return-Path: <netdev+bounces-161873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51AA2455C
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 23:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F55E166C2B
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19901925BF;
	Fri, 31 Jan 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ghhEto4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F2EED8
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363777; cv=none; b=La9mtdmREEkAnb3XjKQ2GM/9RUj/MgaJTSSBYIKO1V732B9A8UMj63+09UsJWRpEVPhRjr4EO0rDA3H79MrDq+wI3i+iinRXVHKGduoNcZWJSYLWjOvs0SMlAcm2rXM8YDFaPPzd+iDfH1Jss9wYxtEHhxqIq+N4EpA6FvYc7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363777; c=relaxed/simple;
	bh=jOlQiEqE+RnBxwYVTBgczv2hEJCdkyI587LKN1Djmjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caf2NdyaKko4lN75W5r7o54SiKS86AUS7I3l2orzrERPIQN5oGWaF+P3jhReFT6eom9vw+vwv97VXWClm8gvBwJyuKN37nnJ6YAVeIpcrqUQ3E9rvg6G3QfBIr8xx9p1tO9kfvyKCnVlwlkXgP8BWavnaV38EzEujRF6gPMXdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ghhEto4e; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3cVDQz2xJyjeugRVsScpFg4k039eEXzlf9ksqnZQRsA=; t=1738363776; x=1739227776; 
	b=ghhEto4ezdSxShOY08b2P72GNYFYgfpedtQmzzut746Gldh1AVjD+68SM87SSMRpCd4ItvzN0IR
	2gisXN2h3/spcCAz+zh33C1Sza0SmSVbOB1q7krBTBz0t6N7OrDJUeeIos8yRztC8/DdDwYxgZU5q
	CvtjFn4ddVY01+BXRue94pjdxzdfV5/OzxAwNMlSMuWcnCFu1APSgPQ37xmh9MqPWniZgglANJMmK
	RjzdZWP8MviR54vDGma/b0cel7PWMoDFWMOm0CmBrF57hpH/mB4Pj51v1FHhdZF1sPupNyCKI5/7J
	Zqt58/jZhAjWb0gF09ODCIm7QxH8S6O1l7sA==;
Received: from mail-oa1-f51.google.com ([209.85.160.51]:43196)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdzpM-0005eF-EE
	for netdev@vger.kernel.org; Fri, 31 Jan 2025 14:49:35 -0800
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b3680e548aso996129fac.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 14:49:32 -0800 (PST)
X-Gm-Message-State: AOJu0Ywl15pe8zEAuVtsO2VXsJKAvmp0c6cbV5TwuOMMVXp5UNlSAGs0
	tLIR3yDZxmoJzTJBgvKrIpgCygAJ0ifNvX4mZb7SdXL7XLtLBXJpqKH1kvrUFIRb17TE4CvpTcD
	0AJ4Yfruk6YzZOM3ACiquIapbhYg=
X-Google-Smtp-Source: AGHT+IEw7BTC7UCr5ZcRxP1Ohr5i0mhEVvcDyjTfYi0c8TVt8wW/7xpo/JnlvwDakdaQXbSe9yqUy8VRCexgjdJWPkc=
X-Received: by 2002:a05:6870:a591:b0:29d:caa2:f0ef with SMTP id
 586e51a60fabf-2b34fe95286mr7339832fac.6.1738363771588; Fri, 31 Jan 2025
 14:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com> <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com>
In-Reply-To: <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 31 Jan 2025 14:48:55 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
X-Gm-Features: AWEUYZk6-0ySoulDcjZK-MYbDVnXaU_ZiLSTauRUCM48W6m9SVtjxH2dVFWaZjk
Message-ID: <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 3.2
X-Spam-Level: ***
X-Scan-Signature: ea2189e9ba68136ff407528fab3ac920

Resending because I accidentally left HTML enabled in the original; sorry..=
.

On Thu, Jan 30, 2025 at 1:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/30/25 1:41 AM, John Ousterhout wrote:
> > On Fri, Jan 24, 2025 at 12:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>
> >> OoO will cause additional allocation? this feels like DoS prone.
> >>
> >>> +             }
> >>> +             rpc->msgin.recv_end =3D end;
> >>> +             goto keep;
> >>> +     }
> >>> +
> >>> +     /* Must now check to see if the packet fills in part or all of
> >>> +      * an existing gap.
> >>> +      */
> >>> +     list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
> >>
> >> Linear search for OoO has proven to be subject to serious dos issue. Y=
ou
> >> should instead use a (rb-)tree to handle OoO packets.
> >
> > I have been assuming that DoS won't be a major issue for Homa because
> > it's intended for use only in datacenters (if there are antagonistic
> > parties, they will be isolated from each other by networking
> > hardware). Is this a bad assumption?
>
> I think assuming that the peer will always behave is dangerous. The peer
> could be buggy or compromised, transient network condition may arise.
> Even un-malicious users tend to do the most crazy and unexpected things
> given enough time.
>
> Also the disclaimer "please don't use this in on an internet facing
> host" sounds quite bad for a networking protocol ;)

I don't see why this disclaimer would be needed: as long as the Homa
hosts are inside the firewall, the firewall will prevent any external
Homa packets from reaching them. And, if your host is compromised, DoS
is the least of your worries.

It seems to me that this is mostly about helping people debug. I agree
that that could be useful. However, it's hard for me to imagine this
particular situation (lots of gaps in the packet stream) happening by
accident. Applications won't be generating Homa packets themselves,
they will be using Homa, and Homa won't generate lots of gaps. There
are other kinds of bad application behavior that are much more likely
to occur, such as an app that gets into an infinite loop sending
requests without ever receiving responses.

And, an rb-tree will add complexity and slow down the common case
(trees have better O(...) behavior than lists but worse constant
factors).

Unless you see this as a show-stopper issue, I'd prefer not to use an
rb-tree for packet gaps.

> >>> +
> >>> +             /* Packet is in the middle of the gap; must split the g=
ap. */
> >>> +             gap2 =3D homa_gap_new(&gap->links, gap->start, start);
> >>> +             if (!gap2) {
> >>> +                     pr_err("Homa couldn't allocate gap for split: i=
nsufficient memory\n");
> >>> +                     goto discard;
> >>> +             }
> >>> +             gap2->time =3D gap->time;
> >>> +             gap->start =3D end;
> >>> +             goto keep;
> >>> +     }
> >>> +
> >>> +discard:
> >>> +     kfree_skb(skb);
> >>> +     return;
> >>> +
> >>> +keep:
> >>> +     __skb_queue_tail(&rpc->msgin.packets, skb);
> >>
> >> Here 'msgin.packets' is apparently under RCP lock protection, but
> >> elsewhere - in homa_rpc_reap() - the list is apparently protected by
> >> it's own lock.
> >
> > What are you referring to by "its own lock?"
>
> msgin.packets.lock
>
> i.e. skb_dequeue() in homa_rpc_reap() uses such lock, while all the '__'
>  variants of the sk_buff_head helper don't use it.

That's a bug. I  wasn't aware of the internal lock when I wrote that
code, or had forgotten. I'll switch to the '__' variants.

> >> Also it looks like there is no memory accounting at all, and SO_RCVBUF
> >> setting are just ignored.
> >
> > Homa doesn't yet have comprehensive memory accounting, but there is a
> > limit on buffer space for incoming messages. Instead of SO_RCVBUF,
> > applications control the amount of receive buffer space by controlling
> > the size of the buffer pool they provide to Homa with the
> > SO_HOMA_RCVBUF socket option.
>
> Ignoring SO_RCVBUF (and net.core.rmem_* sysctls) is both unexpected and
> dangerous (a single application may consume unbounded amount of system
> memory). Also what about the TX side? I don't see any limit at all there.

An application cannot consume unbounded system memory on the RX side
(in fact it consumes almost none). When packets arrive, their data is
immediately transferred to a buffer region in user memory provided by
the application (using the facilities in homa_pool.c). Skb's are
occupied only long enough to make this transfer, and it happens even
if there is no pending recv* kernel call. The size of the buffer
region is limited by the application, and the application must provide
a region via SO_HOMA_RCVBUF. Given this, there's no need for SO_RCVBUF
(and I don't see why a different limit would be specified via
SO_RCVBUF than the one already provided via SO_HOMA_RCVBUF). I agree
that this is different from TCP, but Homa is different from TCP in
lots of ways.

There is currently no accounting or control on the TX side. I agree
that this needs to be implemented at some point, but if possible I'd
prefer to defer this until more of Homa has been upstreamed. For
example, this current patch doesn't include any sysctl support, which
would be needed as part of accounting/control (the support is part of
the GitHub repo, it's just not in this patch series).

> >>> +/**
> >>> + * homa_dispatch_pkts() - Top-level function that processes a batch =
of packets,
> >>> + * all related to the same RPC.
> >>> + * @skb:       First packet in the batch, linked through skb->next.
> >>> + * @homa:      Overall information about the Homa transport.
> >>> + */
> >>> +void homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa)
> >>
> >> I see I haven't mentioned the following so far, but you should move th=
e
> >> struct homa to a pernet subsystem.
> >
> > Sorry for my ignorance, but I'm not familiar with the concept of "a
> > pernet subsystem". What's the best way for me to learn more about
> > this?
>
> Have a look at register_pernet_subsys(), struct pernet_operations and
> some basic usage example, i.e. in net/8021q/vlan.c.
>
> register_pernet_subsys() allow registering/allocating a per network
> namespace structure of specified size (pernet_operations.size) that that
> subsystem can use according to its own need fetching it from the netns
> via the `id` obtained at registration time.

I will take a look.

> >>> +             /* Find and lock the RPC if we haven't already done so.=
 */
> >>> +             if (!rpc) {
> >>> +                     if (!homa_is_client(id)) {
> >>> +                             /* We are the server for this RPC. */
> >>> +                             if (h->common.type =3D=3D DATA) {
> >>> +                                     int created;
> >>> +
> >>> +                                     /* Create a new RPC if one does=
n't
> >>> +                                      * already exist.
> >>> +                                      */
> >>> +                                     rpc =3D homa_rpc_new_server(hsk=
, &saddr,
> >>> +                                                               h, &c=
reated);
> >>
> >> It looks like a buggy or malicious client could force server RPC
> >> allocation to any _client_ ?!?
> >
> > I'm not sure what you mean by "force server RPC allocation to any
> > _client_"; can you give a bit more detail?
>
> AFAICS the home protocol uses only the `id` provided by the sender to
> discriminate the incoming packet as a client requests and thus
> allocating resources (RPC new server) on the receiver.
>
> Suppose an host creates a client socket, and a port is assigned to it.
>
> A malicious or buggy peer starts sending an (unlimited amount of)
> uncompleted homa RPC request to it.
>
> AFAICS the host A will allocate server RPCs in response to such incoming
> packets, which is unexpected to me.

Now I see what you're getting at. Homa sockets are symmetric: any
socket can be used for both the client and server sides of RPCs.  Thus
it's possible to send requests even to sockets that haven't been
"bound". I think of this as a feature, not a bug (it can potentially
reduce the need to allocate "known" port numbers). At the same time, I
see your point that some applications might not expect to receive
requests. Would you like a mechanism to disable this? For example,
sockets could be configured by default to reject incoming requests;
invoking the "bind" system call would enable incoming requests (I
would also add a setsockopt mechanism for enabling requests even on
"unbound" sockets).

> Additionally AFAICS each RPC is identified only by dport/id and both
> port and id allocation is sequential it looks like it's quite easy to
> spoof/inject data in a different RPC - even "by mistake". I guess this
> is a protocol limit.

On the server side an RPC is identified by <client address, dport,
id>, but on the client side only by <dport, id> (the sender address
isn't needed to lookup the correct RPC). However, it would be easy to
check incoming packets to make sure that the sender address matches
the sender in the RPC. I will do that.

> >>> +             case UNKNOWN:
> >>> +                     homa_unknown_pkt(skb, rpc);
> >>
> >> It's sort of unexpected that the protocol explicitly defines the unkno=
wn
> >> packet type, and handles it differently form undefined types.
> >
> > Maybe the name UNKNOWN is causing confusion? An UNKNOWN packet is sent
> > when an endpoint receives a RESEND packet for an RPC that is unknown
> > to it. The term UNKNOWN refers to an unknown RPC, as opposed to an
> > unrecognized packet type.
>
> Yep, possibly a more extended/verbose type name would help.

OK, I'll rename it.

> >>> +
> >>> +     if (skb_queue_len(&rpc->msgin.packets) !=3D 0 &&
> >>> +         !(atomic_read(&rpc->flags) & RPC_PKTS_READY)) {
> >>> +             atomic_or(RPC_PKTS_READY, &rpc->flags);
> >>> +             homa_sock_lock(rpc->hsk, "homa_data_pkt");
> >>> +             homa_rpc_handoff(rpc);
> >>> +             homa_sock_unlock(rpc->hsk);
> >>
> >> It looks like you tried to enforce the following lock acquiring order:
> >> rpc lock
> >> socket lock
> >> which is IMHO quite unnatural, as the socket has a wider scope than th=
e
> >> RPC. In practice the locking schema is quite complex and hard to follo=
w.
> >> I think (wild guess) that inverting the lock order would simplify the
> >> locking schema significantly.
> >
> > This locking order is necessary for Homa.  Because a single socket can
> > be used for many concurrent RPCs to many peers, it doesn't work to
> > acquire the socket lock for every operation: it would suffer terrible
> > contention (I tried this in the earliest versions of Homa and it was a
> > bottleneck under high load).
>
> Would a separate lock for the homa_pool help?

I don't think so. The main problem with reversing the order of lock
acquisition is that the socket lock would have to be acquired for
every packet lookup.

> >>> +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> >>> +               struct homa_rpc *rpc)
> >>> +     __releases(rpc->bucket_lock)
> >>> +{
> >>> +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> >>> +     struct homa_ack_hdr *h =3D (struct homa_ack_hdr *)skb->data;
> >>> +     int i, count;
> >>> +
> >>> +     if (rpc) {
> >>> +             homa_rpc_free(rpc);
> >>> +             homa_rpc_unlock(rpc);
> >>
> >> Another point that makes IMHO the locking schema hard to follow is the
> >> fact that many non-locking-related functions acquires or release some
> >> lock internally. The code would be much more easy to follow if you cou=
ld
> >> pair the lock and unlock as much as possible inside the same code bloc=
k.
> >
> > I agree. There are places where a function has to release a lock
> > internally for various reasons, but it should reacquire the lock
> > before returning to preserve symmetry. There are places where
> > functions release a lock without reacquiring it, but that's a bad idea
> > I'd like to fix (homa_ack_pkt is one example). One of the reasons for
> > this was that once an RPC lock is released the RPC could go away, so
> > it wasn't safe to attempt to relock it. I have added new methods
> > homa_rpc_hold() and homa_rpc_put() so that it's possible to take a
> > reference count on an RPC to keep it around while the lock is
> > released, so the lock can safely be reacquired later. This is how I
> > fixed the homa_ack_pkt problem you pointed out above. If you see any
> > other places with this asymmetry, let me know and I'll fix them also.
>
> I need to see the new code :) (plus a lot of time, I guess)

I have now gone through the code myself; I think I have now eliminated
all the places where an RPC is locked on entry to a function but
unlocked on return.

> > The new methods also provide a consistent and simple solution to
> > several other problems that had been solved in an ad hoc way.
> >
> > It would be even better if a function never had to release a lock
> > internally, but so far I haven't figured out how to do that. If you
> > have ideas I'd like to hear them.
>
> In some cases it could be possible to move the unlock in the caller,
> eventually breaking the relevant function in smaller helpers.
>
> >>> +
> >>> +     if (id !=3D 0) {
> >>> +             if ((atomic_read(&rpc->flags) & RPC_PKTS_READY) || rpc-=
>error)
> >>> +                     goto claim_rpc;
> >>> +             rpc->interest =3D interest;
> >>> +             interest->reg_rpc =3D rpc;
> >>> +             homa_rpc_unlock(rpc);
> >>
> >> With the current schema you should release the hsh socket lock before
> >> releasing the rpc one.
> >
> > Normally I would agree, but that won't work here: the RPC is no longer
> > of interest, so it needs to be unlocked,
>
> Is that unlock strictly necessary (would cause a deadlock if omitted) or
> just an optimization?

That RPC definitely needs to be unlocked (another RPC gets locked
later in the function). It would be possible to defer its unlocking
until after the socket is unlocked, but that would be awkward: that
RPC is never used again, and there would need to be an extra variable
to remember the RPC for later unlocking; the later unlocking would
drop in "out of the blue" (readers would wonder "why is this RPC being
unlocked here?"). And it would keep an RPC locked unnecessarily.

> > but we need to keep the socket lock through the code that follows.
>
> Why? Do you need the hsk to be alive, or some specific state to be
> consistent? The first could possibly be achieved with a refcnt.

The socket lock must be held when examining the queues of ready RPCs
and waiting threads.

> > This is safe (out-of-order
> > lock acquisition can cause deadlocks, but the order of lock releasing
> > doesn't matter except aesthetically).
>
> I think the existing code would trigger some lockdep splat.

So far it hasn't, and I think I've got the lockdep checks enabled.

> >>> +struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int fl=
ags,
> >>> +                                    __u64 id)
> >>> +     __acquires(&rpc->bucket_lock)
> >>> +{
> >>> +     ...
> >>> + }
> >
> >> The amount of custom code to wait is concerning. Why can't you build
> >> around sk_wait_event()?
> >
> > I agree that it's complicated. sk_wait_event can't be used because
> > Homa allows different threads to wait on partially-overlapping sets of
> > RPCs. For example, one thread can wait for a specific RPC to complete,
> > while another thread waits for *any* RPC to complete. Thus a given RPC
> > completion may not apply to all of the waiting threads. Here's a link
> > to a man page that describes the recvmsg API for Homa:
> >
> > https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
>
> sk_wait_event() could deal with arbitrary complex wake-up conditions -
> code them in a function and pass such function as the __condition argumen=
t.
>
> A problem could be WRT locking, since sk_wait_event() expect the caller
> holding the sk socket lock.
>
> Have you considered using the sk lock to protect the hsk status, and
> finer grained spinlocks for specific hsk fields/attributes?

That's the idea behind the RPC locks, and they reduced hsk lock
contention to a tolerable level. The main place where socket lock
contention still happens now is in the handoff mechanism for incoming
messages: for every message, both the SoftIRQ code that declares the
message complete (homa_rpc_handoff) and the thread that eventually
receives the message (homa_wait_for_message) must acquire the socket
lock. This limits the message throughput for a single socket, which
could impact server apps that want to balance incoming load across a
large number of threads (especially if the workload consists of short
messages with short service times) . I have a few vague ideas for how
to get around this but haven't yet had time to try any of them out.

-John-

