Return-Path: <netdev+bounces-161575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0AA22749
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A243A3B96
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195937482;
	Thu, 30 Jan 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="GRga2+FV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4F8F58
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197743; cv=none; b=h3Uo6lFOm3X06aFt0Qe37TXvttSRSjxbzQVuTGly0RWjX2zkRU5rG+PBO8EHxJO5klMMVwPbTThrAkW+dzPFRddiNqER8BiYWo2SmG9UdsZZru+Z4H4H2sBf3LoSPoEPMGZxFFvNxa/Tnzijf+nGB9wa6csO97arZrJUGxnpsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197743; c=relaxed/simple;
	bh=jCA0PYZtm9LG8zQLS8Aj6dNqtKNrGnubwsj6kjNBn+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7NSIz4rKFrVd4B6Bbbc+gz/z9Ogdz3YZUDNcKLsHQ04JKGpnnB/7Ivb51Goh0AjwlFw07x98hgQ9G3zm31QFlUpokEwCMFyWjPQq8TrV9jNucd2xNDYGAva138JbTGWKMaqfCJfGnLh+uYeI2KzPOinkjTkm7bRpzFZ890bikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=GRga2+FV; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u29R+B2PWs1y2ppWuvL5fTNrgX0SFWE93mGhobYlbdc=; t=1738197741; x=1739061741; 
	b=GRga2+FV6uEnK6Bal8KlqK7DGcxUmLlJSW7vMbgQjEsWS2bGXrshxPdsNDf9X/m/lAccDullBZZ
	rM5Rkp5sbPJe4+k52GJkgZCJ3N87EmXMHgr3dnojle3iiUVC3oE4juhPtWI5lzrpuMtv2rrxgTokX
	7FH2+Q3S3+4cLGwhEjWvPl6Get4GsdRWAd8CbQvvt1R7rnk1Hu9GNxIFZ4ua6vGdZNsHE4Dw/I2ZR
	oc723/RQuaJdGC5nhcp4d25JUofe+EYkzj+taQIOW4wNkftBr876q3b3uQ43hmU41IFMgbQEJmX3u
	gqLfbjBAzcS/9U79LjnqPTfkdHOPV8s+KoBA==;
Received: from mail-oa1-f47.google.com ([209.85.160.47]:49596)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdIdN-0005Gt-RR
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 16:42:20 -0800
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29ff039dab2so91038fac.3
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:42:17 -0800 (PST)
X-Gm-Message-State: AOJu0YxolC6UJm6yhyk9xjhU2NdfyuVXlCSYkRSFZtaKBQa+4G6oFtvx
	9lFcwA9x24KMPXIt2y1IgxaUFSw/mAp3dQd4QdakM4ka7v5cFgqxcHVzbf4DXDN30G6oLx5aSRG
	jD7wrJazDoJ9KLSMTOqzSeL7AzCU=
X-Google-Smtp-Source: AGHT+IHXRiZN6sXT6eRWOXpuJKWBFww2TwHB6P+rA+ldknCgtO7U9uVoRH/UGkmmEVytCnYijI+ADlkGC+nNPGJIouM=
X-Received: by 2002:a05:6871:401:b0:29f:b1d4:7710 with SMTP id
 586e51a60fabf-2b32f280701mr2545078fac.24.1738197736925; Wed, 29 Jan 2025
 16:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
In-Reply-To: <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 16:41:41 -0800
X-Gmail-Original-Message-ID: <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
X-Gm-Features: AWEUYZnZuyeZs7aCte676PON4AXEz-f9xcIlbACohWODIPb9ZihWh-ukUl_RYj0
Message-ID: <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 1.7
X-Spam-Level: *
X-Scan-Signature: a5b2f5099b8f1527c2641ef1fbc40d2a

On Fri, Jan 24, 2025 at 12:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> OoO will cause additional allocation? this feels like DoS prone.
>
> > +             }
> > +             rpc->msgin.recv_end =3D end;
> > +             goto keep;
> > +     }
> > +
> > +     /* Must now check to see if the packet fills in part or all of
> > +      * an existing gap.
> > +      */
> > +     list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
>
> Linear search for OoO has proven to be subject to serious dos issue. You
> should instead use a (rb-)tree to handle OoO packets.

I have been assuming that DoS won't be a major issue for Homa because
it's intended for use only in datacenters (if there are antagonistic
parties, they will be isolated from each other by networking
hardware). Is this a bad assumption?

> > +
> > +             /* Packet is in the middle of the gap; must split the gap=
. */
> > +             gap2 =3D homa_gap_new(&gap->links, gap->start, start);
> > +             if (!gap2) {
> > +                     pr_err("Homa couldn't allocate gap for split: ins=
ufficient memory\n");
> > +                     goto discard;
> > +             }
> > +             gap2->time =3D gap->time;
> > +             gap->start =3D end;
> > +             goto keep;
> > +     }
> > +
> > +discard:
> > +     kfree_skb(skb);
> > +     return;
> > +
> > +keep:
> > +     __skb_queue_tail(&rpc->msgin.packets, skb);
>
> Here 'msgin.packets' is apparently under RCP lock protection, but
> elsewhere - in homa_rpc_reap() - the list is apparently protected by
> it's own lock.

What are you referring to by "its own lock?" As far as I know there is
no lock specific to msgin.packets. Normally everything in a homa_rpc
is protected by the RPC lock, and that's the case for homa_add_packet
above. By the time homa_rpc_reap sees an RPC
it has been marked dead and removed from all lists, so no-one else
will try to mutate it and there's no need for synchronization over its
internals. The only remaining problem is that there could still be
outstanding references to the RPC, whose owners haven't yet discovered
that it's dead and dropped their references. The protect_count on the
socket is used to detect these situations.

> Also it looks like there is no memory accounting at all, and SO_RCVBUF
> setting are just ignored.

Homa doesn't yet have comprehensive memory accounting, but there is a
limit on buffer space for incoming messages. Instead of SO_RCVBUF,
applications control the amount of receive buffer space by controlling
the size of the buffer pool they provide to Homa with the
SO_HOMA_RCVBUF socket option.

> > +/**
> > + * homa_dispatch_pkts() - Top-level function that processes a batch of=
 packets,
> > + * all related to the same RPC.
> > + * @skb:       First packet in the batch, linked through skb->next.
> > + * @homa:      Overall information about the Homa transport.
> > + */
> > +void homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa)
>
> I see I haven't mentioned the following so far, but you should move the
> struct homa to a pernet subsystem.

Sorry for my ignorance, but I'm not familiar with the concept of "a
pernet subsystem". What's the best way for me to learn more about
this?

> > +{
> > +#define MAX_ACKS 10
> > +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> > +     __u64 id =3D homa_local_id(h->common.sender_id);
> > +     int dport =3D ntohs(h->common.dport);
> > +
> > +     /* Used to collect acks from data packets so we can process them
> > +      * all at the end (can't process them inline because that may
> > +      * require locking conflicting RPCs). If we run out of space just
> > +      * ignore the extra acks; they'll be regenerated later through th=
e
> > +      * explicit mechanism.
> > +      */
> > +     struct homa_ack acks[MAX_ACKS];
> > +     struct homa_rpc *rpc =3D NULL;
> > +     struct homa_sock *hsk;
> > +     struct sk_buff *next;
> > +     int num_acks =3D 0;
> > +
> > +     /* Find the appropriate socket.*/
> > +     hsk =3D homa_sock_find(homa->port_map, dport);
>
> This needs RCU protection

Yep. I have reworked homa_sock_find so that it uses RCU protection
internally and then takes a reference on the socket before returning.
Callers have to eventually release the reference, but they shouldn't
need to deal with RCU anymore.

> > +
> > +             /* Find and lock the RPC if we haven't already done so. *=
/
> > +             if (!rpc) {
> > +                     if (!homa_is_client(id)) {
> > +                             /* We are the server for this RPC. */
> > +                             if (h->common.type =3D=3D DATA) {
> > +                                     int created;
> > +
> > +                                     /* Create a new RPC if one doesn'=
t
> > +                                      * already exist.
> > +                                      */
> > +                                     rpc =3D homa_rpc_new_server(hsk, =
&saddr,
> > +                                                               h, &cre=
ated);
>
> It looks like a buggy or malicious client could force server RPC
> allocation to any _client_ ?!?

I'm not sure what you mean by "force server RPC allocation to any
_client_"; can you give a bit more detail?

> > +                                     if (IS_ERR(rpc)) {
> > +                                             pr_warn("homa_pkt_dispatc=
h couldn't create server rpc: error %lu",
> > +                                                     -PTR_ERR(rpc));
> > +                                             rpc =3D NULL;
> > +                                             goto discard;
> > +                                     }
> > +                             } else {
> > +                                     rpc =3D homa_find_server_rpc(hsk,=
 &saddr,
> > +                                                                id);
> > +                             }
> > +                     } else {
> > +                             rpc =3D homa_find_client_rpc(hsk, id);
>
> Both the client and the server lookup require a contended lock; The
> lookup could/should be lockless, and the the lock could/should be
> asserted only on the relevant RPC.

I think we've discussed this issue in response to earlier comments:
the only lock acquired during lookup is the hash table bucket lock for
the desired RPC, and the hash table has enough buckets to avoid
serious contention.

>
> > +             case UNKNOWN:
> > +                     homa_unknown_pkt(skb, rpc);
>
> It's sort of unexpected that the protocol explicitly defines the unknown
> packet type, and handles it differently form undefined types.

Maybe the name UNKNOWN is causing confusion? An UNKNOWN packet is sent
when an endpoint receives a RESEND packet for an RPC that is unknown
to it. The term UNKNOWN refers to an unknown RPC, as opposed to an
unrecognized packet type.

> > +                     break;
> > +             case BUSY:
> > +                     /* Nothing to do for these packets except reset
> > +                      * silent_ticks, which happened above.
> > +                      */
> > +                     goto discard;
> > +             case NEED_ACK:
> > +                     homa_need_ack_pkt(skb, hsk, rpc);
> > +                     break;
> > +             case ACK:
> > +                     homa_ack_pkt(skb, hsk, rpc);
> > +                     rpc =3D NULL;
> > +
> > +                     /* It isn't safe to process more packets once we'=
ve
> > +                      * released the RPC lock (this should never happe=
n).
> > +                      */
> > +                     while (next) {
> > +                             WARN_ONCE(next, "%s found extra packets a=
fter AC<\n",
> > +                                       __func__);
>
> It looks like the above WARN could be triggered by an unexpected traffic
> pattern generate from the client. If so, you should avoid the WARN() and
> instead use e.g. some mib counter.

The real problem here is with homa_ack_pkt returning with the RPC lock
released. I've fixed that now, so the check is no longer necessary
(I've deleted it).

> > +
> > +     if (skb_queue_len(&rpc->msgin.packets) !=3D 0 &&
> > +         !(atomic_read(&rpc->flags) & RPC_PKTS_READY)) {
> > +             atomic_or(RPC_PKTS_READY, &rpc->flags);
> > +             homa_sock_lock(rpc->hsk, "homa_data_pkt");
> > +             homa_rpc_handoff(rpc);
> > +             homa_sock_unlock(rpc->hsk);
>
> It looks like you tried to enforce the following lock acquiring order:
> rpc lock
> socket lock
> which is IMHO quite unnatural, as the socket has a wider scope than the
> RPC. In practice the locking schema is quite complex and hard to follow.
> I think (wild guess) that inverting the lock order would simplify the
> locking schema significantly.

This locking order is necessary for Homa.  Because a single socket can
be used for many concurrent RPCs to many peers, it doesn't work to
acquire the socket lock for every operation: it would suffer terrible
contention (I tried this in the earliest versions of Homa and it was a
bottleneck under high load). Thus the RPC lock is the primary lock in
Homa, not the socket lock. Many operations can be completed without
ever holding the socket lock, which reduces contention for the socket
lock.

In TCP a busy app will spread itself over a lot of sockets, so the
socket locks are less likely to be contended.

> > +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> > +               struct homa_rpc *rpc)
> > +     __releases(rpc->bucket_lock)
> > +{
> > +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     struct homa_ack_hdr *h =3D (struct homa_ack_hdr *)skb->data;
> > +     int i, count;
> > +
> > +     if (rpc) {
> > +             homa_rpc_free(rpc);
> > +             homa_rpc_unlock(rpc);
>
> Another point that makes IMHO the locking schema hard to follow is the
> fact that many non-locking-related functions acquires or release some
> lock internally. The code would be much more easy to follow if you could
> pair the lock and unlock as much as possible inside the same code block.

I agree. There are places where a function has to release a lock
internally for various reasons, but it should reacquire the lock
before returning to preserve symmetry. There are places where
functions release a lock without reacquiring it, but that's a bad idea
I'd like to fix (homa_ack_pkt is one example). One of the reasons for
this was that once an RPC lock is released the RPC could go away, so
it wasn't safe to attempt to relock it. I have added new methods
homa_rpc_hold() and homa_rpc_put() so that it's possible to take a
reference count on an RPC to keep it around while the lock is
released, so the lock can safely be reacquired later. This is how I
fixed the homa_ack_pkt problem you pointed out above. If you see any
other places with this asymmetry, let me know and I'll fix them also.
The new methods also provide a consistent and simple solution to
several other problems that had been solved in an ad hoc way.

It would be even better if a function never had to release a lock
internally, but so far I haven't figured out how to do that. If you
have ideas I'd like to hear them.

> > +
> > +     if (id !=3D 0) {
> > +             if ((atomic_read(&rpc->flags) & RPC_PKTS_READY) || rpc->e=
rror)
> > +                     goto claim_rpc;
> > +             rpc->interest =3D interest;
> > +             interest->reg_rpc =3D rpc;
> > +             homa_rpc_unlock(rpc);
>
> With the current schema you should release the hsh socket lock before
> releasing the rpc one.

Normally I would agree, but that won't work here: the RPC is no longer
of interest, so it needs to be unlocked, but we need to keep the
socket lock through the code that follows. This is safe (out-of-order
lock acquisition can cause deadlocks, but the order of lock releasing
doesn't matter except aesthetically).

> > +struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int flag=
s,
> > +                                    __u64 id)
> > +     __acquires(&rpc->bucket_lock)
> > +{
> > +     ...
> > + }

> The amount of custom code to wait is concerning. Why can't you build
> around sk_wait_event()?

I agree that it's complicated. sk_wait_event can't be used because
Homa allows different threads to wait on partially-overlapping sets of
RPCs. For example, one thread can wait for a specific RPC to complete,
while another thread waits for *any* RPC to complete. Thus a given RPC
completion may not apply to all of the waiting threads. Here's a link
to a man page that describes the recvmsg API for Homa:

https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

That said, I have never been very happy with this API (and its
consequences for the waiting code). I've occasionally thought there
must be a better alternative but never came up with anything I liked.
However, your comment forced me to think about this some more, and I
now think I have a better idea for how to do waiting, which will
eliminate overlapping waits and allow sk_wait_event to be used instead
of the "interest" mechanism  that's currently implemented. This will
be an API change, but if I'm going to do it I think I should do it
now, before upstreaming. So I will do that.

-John-

