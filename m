Return-Path: <netdev+bounces-219017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7577B3F676
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2125F3A195F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5DE2E7BB5;
	Tue,  2 Sep 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln46g6/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3C2E6CBD
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797565; cv=none; b=f9ZSUXxL4e/jFiYjjodsLIF93XE7fl611cDVSC48xmFheByym9JNZaSHDr3nEy+MdFkxTtI+fbAV4OEEVQe4QHBc847Dr0gzZ64daGO69iYxljzebXT1Zs+j8pcBANSjPOh2c9Z5onP0HEJWrOfRjYDcrDWmwn43CLJDEu4yzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797565; c=relaxed/simple;
	bh=7pulyN6P1UMltVogNBEOhHWM7a7NlhJg/P/pN3gnb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKfoi1dEXyNzyiUmkuV+fFNlzmGpw1Ufj2X97a4TUQaCLjCrRsU1nMEl0/FA8N669AKeNVYAjFX/jmbC8WFBNQLruTXLD3eGgKMV6NH6eaCWFdVkQS/+xMpwYDk0ZzO438meFJAFeqevsEUS5plwE2R40JByDZA66kDoqZ3auzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ln46g6/d; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b33032b899so13038881cf.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756797561; x=1757402361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYiQih6LQlSS4wCHe01CQIu1aJZClb5Ij/8uZNq4DJI=;
        b=Ln46g6/di2HgUI1fBHk/aSerQJhY2NF/p8/byAr+UjukQrhJ4UkDu9hZZ/2CNBd7MN
         h10llLdfqSW77CMX/zzoQ9P6M7Tnlc6YGMsIcWsq5lXvKdTWiGI3RAfKF6cROXd6668b
         vJiXVsyyKyQvQiTg1/9thIquAISMrUvTQx+BrNn29fZ0zjMZdHIaIAmxYaHRv8faxLWF
         1qF3QZOdvAAqWL/Hf4CbX/WbLcnVLKRnKsl4ndOrMucinmcceeGWtk2WQ6PQFHegale8
         gf55FYVx/MHhevfqN4yGF1Dg38q6mW7/YjwC0mZYvUesUsjsHPfpPmV685kZeZ8MhDgp
         cJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797561; x=1757402361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYiQih6LQlSS4wCHe01CQIu1aJZClb5Ij/8uZNq4DJI=;
        b=YHjXLiWvjTnXz6mmV34PgtY1hqSeNfhiH3mrQ5SYYLD/qG1J4Q5NRwKYZyMMDsLwfT
         TAEu7K2ytfWBrk7mIqCXUmpoMvJrdJrrcg20gUbyJ2eCbt80/prFkEqmWr75v6lgopJ8
         Es7eAYDmzcT0hD1DGzfkzSm0Xh3E1MWK/wTesmPHsoHzq+X+2vzE8EC24UVa8jzC8IW/
         A3+VpHfEsnYg6iwE+yq9k5oJrSThWOm41BdyzJ+2MOXiH7uerb1G47ZhR5XqIAFS00Cs
         stXIxYfjk/X7hGIBl/GbXH+xwBxuNd+0cmypUIK/m4SDpdMFOVBm5kZZTQpp8nKdANUh
         ZIIA==
X-Gm-Message-State: AOJu0YyJ0v//yhz64yzDS5uwXzIJHcYXzZh1rDpRed6cghuZwFPmPZQk
	AWedXWjY/UOSbf7OPndez/BLBuzMhS66FoncjylaPnd5hL/JskUd4I6Ej1KbQte99c2ZbPJbYYk
	zeRyQGA4ii4uYdit2rv7TAciEV7zZRirFbv96aC94
X-Gm-Gg: ASbGnct6JIU9z3hIVtOOAJ/E8wqCFtb1bvoPfGyazrN2ACXJgZilp0FJ342Kphzy7Tx
	DuXWJiNWofSB6PxWyrCZqycYoRaeqICKFePJZLhC+Kkxam8QD3UUTbTo4Yfov9NUNvGkExDHnok
	m9kFa+jJCZAxKWmKzrAUeD5nBE00h5udIyPdcHCHHizyzmUI6moHJJRPtJ5AQZqrNfeIRNGNwQP
	EmoVa5OrUaRgT74hR7zB8m3
X-Google-Smtp-Source: AGHT+IHuQGNwFDyujdp8mhw8FuxWYOdQdgGsU9dgeJNLdA09MWxNExuI173nNP9mVxiVpcIVbAJhgqWoReziVtKK7jE=
X-Received: by 2002:a05:622a:1ba4:b0:4b2:9b3b:2bce with SMTP id
 d75a77b69052e-4b31dc8f2d6mr119283241cf.64.1756797560574; Tue, 02 Sep 2025
 00:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-13-ouster@cs.stanford.edu>
In-Reply-To: <20250818205551.2082-13-ouster@cs.stanford.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 00:19:08 -0700
X-Gm-Features: Ac12FXx64pOU_XJvIP0PmiLDHpD94R9gItYkZmesk77fzPozHGx7kg5BgSHdFUU
Message-ID: <CANn89iJ26WjmTBrEKwMJbQCKWYFmz2h25T+kOgLASXPvsDR1BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 12/15] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:56=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> This file contains most of the code for handling incoming packets,
> including top-level dispatching code plus specific handlers for each
> pack type. It also contains code for dispatching fully-received
> messages to waiting application threads.
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
>
> ---
> Changes for v14:
> * Use new homa_rpc_tx_end function
> * Fix race in homa_wait_shared (an RPC could get lost if it became
>   ready at the same time that homa_interest_wait returned with an error)
> * Handle nonblocking behavior here, rather than in homa_interest.c
> * Change API for homa_wait_private to distinguish errors in an RPC from
>   errors that prevented the wait operation from completing.
>
> Changes for v11:
> * Cleanup and simplify use of RPC reference counts.
> * Cleanup sparse annotations.
> * Rework the mechanism for waking up RPCs that stalled waiting for
>   buffer pool space.
>
> Changes for v10:
> * Revise sparse annotations to eliminate __context__ definition
> * Refactor resend mechanism (new function homa_request_retrans replaces
>   homa_gap_retry)
> * Remove log messages after alloc errors
> * Fix socket cleanup race
>
> Changes for v9:
> * Add support for homa_net objects
> * Use new homa_clock abstraction layer
> * Various name improvements (e.g. use "alloc" instead of "new" for functi=
ons
>   that allocate memory)
>
> Changes for v7:
> * API change for homa_rpc_handoff
> * Refactor waiting mechanism for incoming packets: simplify wait
>   criteria and use standard Linux mechanisms for waiting, use
>   new homa_interest struct
> * Reject unauthorized incoming request messages
> * Improve documentation for code that spins (and reduce spin length)
> * Use RPC reference counts, eliminate RPC_HANDING_OFF flag
> * Replace erroneous use of "safe" list iteration with "rcu" version
> * Remove locker argument from locking functions
> * Check incoming messages against HOMA_MAX_MESSAGE_LENGTH
> * Use u64 and __u64 properly
> ---
>  net/homa/homa_impl.h     |  15 +
>  net/homa/homa_incoming.c | 886 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 901 insertions(+)
>  create mode 100644 net/homa/homa_incoming.c
>
> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> index 49ca4abfb50b..3d91b7f44de9 100644
> --- a/net/homa/homa_impl.h
> +++ b/net/homa/homa_impl.h
> @@ -421,22 +421,37 @@ static inline bool homa_make_header_avl(struct sk_b=
uff *skb)
>
>  extern unsigned int homa_net_id;
>
> +void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +                     struct homa_rpc *rpc);
> +void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
> +int      homa_copy_to_user(struct homa_rpc *rpc);
> +void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
>  void     homa_destroy(struct homa *homa);
> +void     homa_dispatch_pkts(struct sk_buff *skb);
>  int      homa_fill_data_interleaved(struct homa_rpc *rpc,
>                                     struct sk_buff *skb, struct iov_iter =
*iter);
> +struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int e=
nd);
>  int      homa_init(struct homa *homa);
>  int      homa_message_out_fill(struct homa_rpc *rpc,
>                                struct iov_iter *iter, int xmit);
>  void     homa_message_out_init(struct homa_rpc *rpc, int length);
> +void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +                          struct homa_rpc *rpc);
>  void     homa_net_destroy(struct homa_net *hnet);
>  int      homa_net_init(struct homa_net *hnet, struct net *net,
>                        struct homa *homa);
> +void     homa_request_retrans(struct homa_rpc *rpc);
> +void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
> +                        struct homa_sock *hsk);
>  void     homa_rpc_handoff(struct homa_rpc *rpc);
>  int      homa_rpc_tx_end(struct homa_rpc *rpc);
>  void     homa_spin(int ns);
>  struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
>                                        struct iov_iter *iter, int offset,
>                                        int length, int max_seg_data);
> +void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc)=
;
> +int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
> +struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking=
);
>  int      homa_xmit_control(enum homa_packet_type type, void *contents,
>                            size_t length, struct homa_rpc *rpc);
>  int      __homa_xmit_control(void *contents, size_t length,
> diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
> new file mode 100644
> index 000000000000..c485dd98cba9
> --- /dev/null
> +++ b/net/homa/homa_incoming.c
> @@ -0,0 +1,886 @@
> +// SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
> +
> +/* This file contains functions that handle incoming Homa messages. */
> +
> +#include "homa_impl.h"
> +#include "homa_interest.h"
> +#include "homa_peer.h"
> +#include "homa_pool.h"
> +
> +/**
> + * homa_message_in_init() - Constructor for homa_message_in.
> + * @rpc:          RPC whose msgin structure should be initialized. The
> + *                msgin struct is assumed to be zeroes.
> + * @length:       Total number of bytes in message.
> + * Return:        Zero for successful initialization, or a negative errn=
o
> + *                if rpc->msgin could not be initialized.
> + */
> +int homa_message_in_init(struct homa_rpc *rpc, int length)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       int err;
> +
> +       if (length > HOMA_MAX_MESSAGE_LENGTH)
> +               return -EINVAL;
> +
> +       rpc->msgin.length =3D length;
> +       skb_queue_head_init(&rpc->msgin.packets);

Do you need the lock, or can you use __skb_queue_head_init() here for clari=
ty ?

> +       INIT_LIST_HEAD(&rpc->msgin.gaps);
> +       rpc->msgin.bytes_remaining =3D length;
> +       err =3D homa_pool_alloc_msg(rpc);
> +       if (err !=3D 0) {
> +               rpc->msgin.length =3D -1;
> +               return err;
> +       }
> +       return 0;
> +}
> +
> +/**
> + * homa_gap_alloc() - Allocate a new gap and add it to a gap list.
> + * @next:   Add the new gap just before this list element.
> + * @start:  Offset of first byte covered by the gap.
> + * @end:    Offset of byte just after the last one covered by the gap.
> + * Return:  Pointer to the new gap, or NULL if memory couldn't be alloca=
ted
> + *          for the gap object.
> + */
> +struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int e=
nd)
> +{
> +       struct homa_gap *gap;
> +
> +       gap =3D kmalloc(sizeof(*gap), GFP_ATOMIC);
> +       if (!gap)
> +               return NULL;
> +       gap->start =3D start;
> +       gap->end =3D end;
> +       gap->time =3D homa_clock();
> +       list_add_tail(&gap->links, next);
> +       return gap;
> +}
> +
> +/**
> + * homa_request_retrans() - The function is invoked when it appears that
> + * data packets for a message have been lost. It issues RESEND requests
> + * as appropriate and may modify the state of the RPC.
> + * @rpc:     RPC for which incoming data is delinquent; must be locked b=
y
> + *           caller.
> + */
> +void homa_request_retrans(struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_resend_hdr resend;
> +       struct homa_gap *gap;
> +       int offset, length;
> +
> +       if (rpc->msgin.length >=3D 0) {
> +               /* Issue RESENDS for any gaps in incoming data. */
> +               list_for_each_entry(gap, &rpc->msgin.gaps, links) {
> +                       resend.offset =3D htonl(gap->start);
> +                       resend.length =3D htonl(gap->end - gap->start);
> +                       homa_xmit_control(RESEND, &resend, sizeof(resend)=
, rpc);
> +               }
> +
> +               /* Issue a RESEND for any granted data after the last gap=
. */
> +               offset =3D rpc->msgin.recv_end;
> +               length =3D rpc->msgin.length - rpc->msgin.recv_end;
> +               if (length <=3D 0)
> +                       return;
> +       } else {
> +               /* No data has been received for the RPC. Ask the sender =
to
> +                * resend everything it has sent so far.
> +                */
> +               offset =3D 0;
> +               length =3D -1;
> +       }
> +
> +       resend.offset =3D htonl(offset);
> +       resend.length =3D htonl(length);
> +       homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
> +}
> +
> +/**
> + * homa_add_packet() - Add an incoming packet to the contents of a
> + * partially received message.
> + * @rpc:   Add the packet to the msgin for this RPC.
> + * @skb:   The new packet. This function takes ownership of the packet
> + *         (the packet will either be freed or added to rpc->msgin.packe=
ts).
> + */
> +void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> +       struct homa_gap *gap, *dummy, *gap2;
> +       int start =3D ntohl(h->seg.offset);
> +       int length =3D homa_data_len(skb);
> +       int end =3D start + length;
> +
> +       if ((start + length) > rpc->msgin.length)
> +               goto discard;
> +
> +       if (start =3D=3D rpc->msgin.recv_end) {
> +               /* Common case: packet is sequential. */
> +               rpc->msgin.recv_end +=3D length;
> +               goto keep;
> +       }
> +
> +       if (start > rpc->msgin.recv_end) {
> +               /* Packet creates a new gap. */
> +               if (!homa_gap_alloc(&rpc->msgin.gaps,
> +                                   rpc->msgin.recv_end, start))
> +                       goto discard;
> +               rpc->msgin.recv_end =3D end;
> +               goto keep;
> +       }
> +
> +       /* Must now check to see if the packet fills in part or all of
> +        * an existing gap.
> +        */
> +       list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
> +               /* Is packet at the start of this gap? */
> +               if (start <=3D gap->start) {
> +                       if (end <=3D gap->start)
> +                               continue;
> +                       if (start < gap->start)
> +                               goto discard;
> +                       if (end > gap->end)
> +                               goto discard;
> +                       gap->start =3D end;
> +                       if (gap->start >=3D gap->end) {
> +                               list_del(&gap->links);
> +                               kfree(gap);
> +                       }
> +                       goto keep;
> +               }
> +
> +               /* Is packet at the end of this gap? BTW, at this point w=
e know
> +                * the packet can't cover the entire gap.
> +                */
> +               if (end >=3D gap->end) {
> +                       if (start >=3D gap->end)
> +                               continue;
> +                       if (end > gap->end)
> +                               goto discard;
> +                       gap->end =3D start;
> +                       goto keep;
> +               }
> +
> +               /* Packet is in the middle of the gap; must split the gap=
. */
> +               gap2 =3D homa_gap_alloc(&gap->links, gap->start, start);
> +               if (!gap2)
> +                       goto discard;
> +               gap2->time =3D gap->time;
> +               gap->start =3D end;
> +               goto keep;
> +       }
> +
> +discard:
> +       kfree_skb(skb);
> +       return;
> +
> +keep:
> +       __skb_queue_tail(&rpc->msgin.packets, skb);
> +       rpc->msgin.bytes_remaining -=3D length;
> +}
> +
> +/**
> + * homa_copy_to_user() - Copy as much data as possible from incoming
> + * packet buffers to buffers in user space.
> + * @rpc:     RPC for which data should be copied. Must be locked by call=
er.
> + * Return:   Zero for success or a negative errno if there is an error.
> + *           It is possible for the RPC to be freed while this function
> + *           executes (it releases and reacquires the RPC lock). If that
> + *           happens, -EINVAL will be returned and the state of @rpc
> + *           will be RPC_DEAD. Clears the RPC_PKTS_READY bit in @rpc->fl=
ags
> + *           if all available packets have been copied out.
> + */
> +int homa_copy_to_user(struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +#define MAX_SKBS 20
> +       struct sk_buff *skbs[MAX_SKBS];
> +       int error =3D 0;
> +       int n =3D 0;             /* Number of filled entries in skbs. */
> +       int i;
> +
> +       /* Tricky note: we can't hold the RPC lock while we're actually
> +        * copying to user space, because (a) it's illegal to hold a spin=
lock
> +        * while copying to user space and (b) we'd like for homa_softirq
> +        * to add more packets to the RPC while we're copying these out.
> +        * So, collect a bunch of packets to copy, then release the lock,
> +        * copy them, and reacquire the lock.
> +        */
> +       while (true) {
> +               struct sk_buff *skb;
> +
> +               if (rpc->state =3D=3D RPC_DEAD) {
> +                       error =3D -EINVAL;
> +                       break;
> +               }
> +
> +               skb =3D __skb_dequeue(&rpc->msgin.packets);
> +               if (skb) {
> +                       skbs[n] =3D skb;
> +                       n++;
> +                       if (n < MAX_SKBS)
> +                               continue;
> +               }
> +               if (n =3D=3D 0) {
> +                       atomic_andnot(RPC_PKTS_READY, &rpc->flags);

All networking uses clear_bit() instead...

> +                       break;
> +               }
> +
> +               /* At this point we've collected a batch of packets (or
> +                * run out of packets); copy any available packets out to
> +                * user space.
> +                */
> +               homa_rpc_unlock(rpc);
> +
> +               /* Each iteration of this loop copies out one skb. */
> +               for (i =3D 0; i < n; i++) {
> +                       struct homa_data_hdr *h =3D (struct homa_data_hdr=
 *)
> +                                       skbs[i]->data;
> +                       int pkt_length =3D homa_data_len(skbs[i]);
> +                       int offset =3D ntohl(h->seg.offset);
> +                       int buf_bytes, chunk_size;
> +                       struct iov_iter iter;
> +                       int copied =3D 0;
> +                       char __user *dst;
> +
> +                       /* Each iteration of this loop copies to one
> +                        * user buffer.
> +                        */
> +                       while (copied < pkt_length) {
> +                               chunk_size =3D pkt_length - copied;
> +                               dst =3D homa_pool_get_buffer(rpc, offset =
+ copied,
> +                                                          &buf_bytes);
> +                               if (buf_bytes < chunk_size) {
> +                                       if (buf_bytes =3D=3D 0) {
> +                                               /* skb has data beyond me=
ssage
> +                                                * end?
> +                                                */
> +                                               break;
> +                                       }
> +                                       chunk_size =3D buf_bytes;
> +                               }
> +                               error =3D import_ubuf(READ, dst, chunk_si=
ze,
> +                                                   &iter);
> +                               if (error)
> +                                       goto free_skbs;
> +                               error =3D skb_copy_datagram_iter(skbs[i],
> +                                                              sizeof(*h)=
 +
> +                                                              copied,  &=
iter,
> +                                                              chunk_size=
);
> +                               if (error)
> +                                       goto free_skbs;
> +                               copied +=3D chunk_size;
> +                       }
> +               }
> +
> +free_skbs:
> +               for (i =3D 0; i < n; i++)
> +                       kfree_skb(skbs[i]);

There is a big difference between kfree_skb() and consume_skb()

> +               n =3D 0;

> +               atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> +               homa_rpc_lock(rpc);
> +               atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);

This construct would probably need a helper.

> +               if (error)
> +                       break;
> +       }
> +       return error;
> +}
> +
> +/**
> + * homa_dispatch_pkts() - Top-level function that processes a batch of p=
ackets,
> + * all related to the same RPC.
> + * @skb:       First packet in the batch, linked through skb->next.
> + */
> +void homa_dispatch_pkts(struct sk_buff *skb)
> +{
> +#define MAX_ACKS 10
> +       const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> +       struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> +       u64 id =3D homa_local_id(h->common.sender_id);
> +       int dport =3D ntohs(h->common.dport);
> +
> +       /* Used to collect acks from data packets so we can process them
> +        * all at the end (can't process them inline because that may
> +        * require locking conflicting RPCs). If we run out of space just
> +        * ignore the extra acks; they'll be regenerated later through th=
e
> +        * explicit mechanism.
> +        */
> +       struct homa_ack acks[MAX_ACKS];
> +       struct homa_rpc *rpc =3D NULL;
> +       struct homa_sock *hsk;
> +       struct homa_net *hnet;
> +       struct sk_buff *next;
> +       int num_acks =3D 0;
> +
> +       /* Find the appropriate socket.*/
> +       hnet =3D homa_net_from_skb(skb);
> +       hsk =3D homa_sock_find(hnet, dport);
> +       if (!hsk || (!homa_is_client(id) && !hsk->is_server)) {
> +               if (skb_is_ipv6(skb))
> +                       icmp6_send(skb, ICMPV6_DEST_UNREACH,
> +                                  ICMPV6_PORT_UNREACH, 0, NULL, IP6CB(sk=
b));
> +               else
> +                       icmp_send(skb, ICMP_DEST_UNREACH,
> +                                 ICMP_PORT_UNREACH, 0);
> +               while (skb) {
> +                       next =3D skb->next;
> +                       kfree_skb(skb);
> +                       skb =3D next;
> +               }
> +               if (hsk)
> +                       sock_put(&hsk->sock);
> +               return;
> +       }
> +
> +       /* Each iteration through the following loop processes one packet=
. */
> +       for (; skb; skb =3D next) {
> +               h =3D (struct homa_data_hdr *)skb->data;
> +               next =3D skb->next;
> +
> +               /* Relinquish the RPC lock temporarily if it's needed
> +                * elsewhere.
> +                */
> +               if (rpc) {
> +                       int flags =3D atomic_read(&rpc->flags);
> +
> +                       if (flags & APP_NEEDS_LOCK) {
> +                               homa_rpc_unlock(rpc);
> +
> +                               /* This short spin is needed to ensure th=
at the
> +                                * other thread gets the lock before this=
 thread
> +                                * grabs it again below (the need for thi=
s
> +                                * was confirmed experimentally in 2/2025=
;
> +                                * without it, the handoff fails 20-25% o=
f the
> +                                * time). Furthermore, the call to homa_s=
pin
> +                                * seems to allow the other thread to acq=
uire
> +                                * the lock more quickly.
> +                                */
> +                               homa_spin(100);
> +                               homa_rpc_lock(rpc);
> +                       }
> +               }
> +
> +               /* If we don't already have an RPC, find it, lock it,
> +                * and create a reference on it.
> +                */
> +               if (!rpc) {
> +                       if (!homa_is_client(id)) {
> +                               /* We are the server for this RPC. */
> +                               if (h->common.type =3D=3D DATA) {
> +                                       int created;
> +
> +                                       /* Create a new RPC if one doesn'=
t
> +                                        * already exist.
> +                                        */
> +                                       rpc =3D homa_rpc_alloc_server(hsk=
, &saddr,
> +                                                                   h,
> +                                                                   &crea=
ted);
> +                                       if (IS_ERR(rpc)) {
> +                                               rpc =3D NULL;
> +                                               goto discard;
> +                                       }
> +                               } else {
> +                                       rpc =3D homa_rpc_find_server(hsk,=
 &saddr,
> +                                                                  id);
> +                               }
> +                       } else {
> +                               rpc =3D homa_rpc_find_client(hsk, id);
> +                       }
> +                       if (rpc)
> +                               homa_rpc_hold(rpc);
> +               }
> +               if (unlikely(!rpc)) {
> +                       if (h->common.type !=3D NEED_ACK &&
> +                           h->common.type !=3D ACK &&
> +                           h->common.type !=3D RESEND)
> +                               goto discard;
> +               } else {
> +                       if (h->common.type =3D=3D DATA ||
> +                           h->common.type =3D=3D BUSY)
> +                               rpc->silent_ticks =3D 0;
> +                       rpc->peer->outstanding_resends =3D 0;
> +               }
> +
> +               switch (h->common.type) {
> +               case DATA:
> +                       if (h->ack.client_id) {
> +                               /* Save the ack for processing later, whe=
n we
> +                                * have released the RPC lock.
> +                                */
> +                               if (num_acks < MAX_ACKS) {
> +                                       acks[num_acks] =3D h->ack;
> +                                       num_acks++;
> +                               }
> +                       }
> +                       homa_data_pkt(skb, rpc);
> +                       break;
> +               case RESEND:
> +                       homa_resend_pkt(skb, rpc, hsk);
> +                       break;
> +               case RPC_UNKNOWN:
> +                       homa_rpc_unknown_pkt(skb, rpc);
> +                       break;
> +               case BUSY:
> +                       /* Nothing to do for these packets except reset
> +                        * silent_ticks, which happened above.
> +                        */
> +                       goto discard;
> +               case NEED_ACK:
> +                       homa_need_ack_pkt(skb, hsk, rpc);
> +                       break;
> +               case ACK:
> +                       homa_ack_pkt(skb, hsk, rpc);
> +                       break;
> +                       goto discard;
> +               }
> +               continue;
> +
> +discard:
> +               kfree_skb(skb);
> +       }
> +       if (rpc) {
> +               homa_rpc_put(rpc);
> +               homa_rpc_unlock(rpc);
> +       }
> +
> +       while (num_acks > 0) {
> +               num_acks--;
> +               homa_rpc_acked(hsk, &saddr, &acks[num_acks]);
> +       }
> +
> +       if (hsk->dead_skbs >=3D 2 * hsk->homa->dead_buffs_limit)
> +               /* We get here if other approaches are not keeping up wit=
h
> +                * reaping dead RPCs. See "RPC Reaping Strategy" in
> +                * homa_rpc_reap code for details.
> +                */
> +               homa_rpc_reap(hsk, false);
> +       sock_put(&hsk->sock);
> +}
> +
> +/**
> + * homa_data_pkt() - Handler for incoming DATA packets
> + * @skb:     Incoming packet; size known to be large enough for the head=
er.
> + *           This function now owns the packet.
> + * @rpc:     Information about the RPC corresponding to this packet.
> + *           Must be locked by the caller.
> + */
> +void homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> +
> +       if (rpc->state !=3D RPC_INCOMING && homa_is_client(rpc->id)) {
> +               if (unlikely(rpc->state !=3D RPC_OUTGOING))
> +                       goto discard;
> +               rpc->state =3D RPC_INCOMING;
> +               if (homa_message_in_init(rpc, ntohl(h->message_length)) !=
=3D 0)
> +                       goto discard;
> +       } else if (rpc->state !=3D RPC_INCOMING) {
> +               /* Must be server; note that homa_rpc_alloc_server alread=
y
> +                * initialized msgin and allocated buffers.
> +                */
> +               if (unlikely(rpc->msgin.length >=3D 0))
> +                       goto discard;
> +       }
> +
> +       if (rpc->msgin.num_bpages =3D=3D 0)
> +               /* Drop packets that arrive when we can't allocate buffer
> +                * space. If we keep them around, packet buffer usage can
> +                * exceed available cache space, resulting in poor
> +                * performance.
> +                */
> +               goto discard;
> +
> +       homa_add_packet(rpc, skb);
> +
> +       if (skb_queue_len(&rpc->msgin.packets) !=3D 0 &&
> +           !(atomic_read(&rpc->flags) & RPC_PKTS_READY)) {
> +               atomic_or(RPC_PKTS_READY, &rpc->flags);
> +               homa_rpc_handoff(rpc);
> +       }
> +
> +       return;
> +
> +discard:
> +       kfree_skb(skb);
> +}
> +
> +/**
> + * homa_resend_pkt() - Handler for incoming RESEND packets
> + * @skb:     Incoming packet; size already verified large enough for hea=
der.
> + *           This function now owns the packet.
> + * @rpc:     Information about the RPC corresponding to this packet; mus=
t
> + *           be locked by caller, but may be NULL if there is no RPC mat=
ching
> + *           this packet
> + * @hsk:     Socket on which the packet was received.
> + */
> +void homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
> +                    struct homa_sock *hsk)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_resend_hdr *h =3D (struct homa_resend_hdr *)skb->data=
;
> +       int offset =3D ntohl(h->offset);
> +       int length =3D ntohl(h->length);
> +       int end =3D offset + length;
> +       struct homa_busy_hdr busy;
> +       int tx_end;
> +
> +       if (!rpc) {
> +               homa_xmit_unknown(skb, hsk);
> +               goto done;
> +       }
> +
> +       tx_end =3D homa_rpc_tx_end(rpc);
> +       if (!homa_is_client(rpc->id) && rpc->state !=3D RPC_OUTGOING) {
> +               /* We are the server for this RPC and don't yet have a
> +                * response message, so send BUSY to keep the client
> +                * waiting.
> +                */
> +               homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
> +               goto done;
> +       }
> +
> +       if (length =3D=3D -1)
> +               end =3D tx_end;
> +
> +       homa_resend_data(rpc, offset, (end > tx_end) ? tx_end : end);
> +
> +       if (offset >=3D tx_end)  {
> +               /* We have chosen not to transmit any of the requested da=
ta;
> +                * send BUSY so the receiver knows we are alive.
> +                */
> +               homa_xmit_control(BUSY, &busy, sizeof(busy), rpc);
> +               goto done;
> +       }
> +
> +done:
> +       kfree_skb(skb);
> +}
> +
> +/**
> + * homa_rpc_unknown_pkt() - Handler for incoming RPC_UNKNOWN packets.
> + * @skb:     Incoming packet; size known to be large enough for the head=
er.
> + *           This function now owns the packet.
> + * @rpc:     Information about the RPC corresponding to this packet. Mus=
t
> + *           be locked by caller.
> + */
> +void homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       if (homa_is_client(rpc->id)) {
> +               if (rpc->state =3D=3D RPC_OUTGOING) {
> +                       int tx_end =3D homa_rpc_tx_end(rpc);
> +
> +                       /* It appears that everything we've already trans=
mitted
> +                        * has been lost; retransmit it.
> +                        */
> +                       homa_resend_data(rpc, 0, tx_end);
> +                       goto done;
> +               }
> +       } else {
> +               homa_rpc_end(rpc);
> +       }
> +done:
> +       kfree_skb(skb);
> +}
> +
> +/**
> + * homa_need_ack_pkt() - Handler for incoming NEED_ACK packets
> + * @skb:     Incoming packet; size already verified large enough for hea=
der.
> + *           This function now owns the packet.
> + * @hsk:     Socket on which the packet was received.
> + * @rpc:     The RPC named in the packet header, or NULL if no such
> + *           RPC exists. The RPC has been locked by the caller.
> + */
> +void homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +                      struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_common_hdr *h =3D (struct homa_common_hdr *)skb->data=
;
> +       const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> +       u64 id =3D homa_local_id(h->sender_id);
> +       struct homa_ack_hdr ack;
> +       struct homa_peer *peer;
> +
> +       /* Don't ack if it's not safe for the peer to purge its state
> +        * for this RPC (the RPC still exists and we haven't received
> +        * the entire response), or if we can't find peer info.
> +        */
> +       if (rpc && (rpc->state !=3D RPC_INCOMING ||
> +                   rpc->msgin.bytes_remaining)) {
> +               homa_request_retrans(rpc);
> +               goto done;
> +       } else {
> +               peer =3D homa_peer_get(hsk, &saddr);
> +               if (IS_ERR(peer))
> +                       goto done;
> +       }
> +
> +       /* Send an ACK for this RPC. At the same time, include all of the
> +        * other acks available for the peer. Note: can't use rpc below,
> +        * since it may be NULL.
> +        */
> +       ack.common.type =3D ACK;
> +       ack.common.sport =3D h->dport;
> +       ack.common.dport =3D h->sport;
> +       ack.common.sender_id =3D cpu_to_be64(id);
> +       ack.num_acks =3D htons(homa_peer_get_acks(peer,
> +                                               HOMA_MAX_ACKS_PER_PKT,
> +                                               ack.acks));
> +       __homa_xmit_control(&ack, sizeof(ack), peer, hsk);
> +       homa_peer_release(peer);
> +
> +done:
> +       kfree_skb(skb);


Please double check all your kfree_skb() vs consume_skb()

perf record -a -e skb:kfree_skb  sleep 60
vs
perf record -a -e skb:consume_skb  sleep 60

As a bonus, you can use kfree_skb_reason(skb, some_reason) for future
bug hunting

> +}
> +
> +/**
> + * homa_ack_pkt() - Handler for incoming ACK packets
> + * @skb:     Incoming packet; size already verified large enough for hea=
der.
> + *           This function now owns the packet.
> + * @hsk:     Socket on which the packet was received.
> + * @rpc:     The RPC named in the packet header, or NULL if no such
> + *           RPC exists. The RPC lock will be dead on return.
> + */
> +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +                 struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> +       struct homa_ack_hdr *h =3D (struct homa_ack_hdr *)skb->data;
> +       int i, count;
> +
> +       if (rpc)
> +               homa_rpc_end(rpc);
> +
> +       count =3D ntohs(h->num_acks);
> +       if (count > 0) {
> +               if (rpc) {
> +                       /* Must temporarily release rpc's lock because
> +                        * homa_rpc_acked needs to acquire RPC locks.
> +                        */
> +                       homa_rpc_unlock(rpc);
> +                       for (i =3D 0; i < count; i++)
> +                               homa_rpc_acked(hsk, &saddr, &h->acks[i]);
> +                       homa_rpc_lock(rpc);
> +               } else {
> +                       for (i =3D 0; i < count; i++)
> +                               homa_rpc_acked(hsk, &saddr, &h->acks[i]);
> +               }
> +       }
> +       kfree_skb(skb);
> +}
> +
> +/**
> + * homa_wait_private() - Waits until the response has been received for
> + * a specific RPC or the RPC has failed with an error.
> + * @rpc:          RPC to wait for; an error will be returned if the RPC =
is
> + *                not a client RPC or not private. Must be locked by cal=
ler.
> + * @nonblocking:  Nonzero means return immediately if @rpc not ready.
> + * Return:        0 means that @rpc is ready for attention: either its r=
esponse
> + *                has been received or it has an unrecoverable error suc=
h as
> + *                ETIMEDOUT (in rpc->error). Nonzero means some other er=
ror
> + *                (such as EINTR or EINVAL) occurred before @rpc became =
ready
> + *                for attention; in this case the return value is a nega=
tive
> + *                errno.
> + */
> +int homa_wait_private(struct homa_rpc *rpc, int nonblocking)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_interest interest;
> +       int result;
> +
> +       if (!(atomic_read(&rpc->flags) & RPC_PRIVATE))
> +               return -EINVAL;
> +
> +       /* Each iteration through this loop waits until rpc needs attenti=
on
> +        * in some way (e.g. packets have arrived), then deals with that =
need
> +        * (e.g. copy to user space). It may take many iterations until t=
he
> +        * RPC is ready for the application.
> +        */
> +       while (1) {
> +               result =3D 0;
> +               if (!rpc->error)
> +                       rpc->error =3D homa_copy_to_user(rpc);
> +               if (rpc->error)
> +                       break;
> +               if (rpc->msgin.length >=3D 0 &&
> +                   rpc->msgin.bytes_remaining =3D=3D 0 &&
> +                   skb_queue_len(&rpc->msgin.packets) =3D=3D 0)
> +                       break;
> +
> +               if (nonblocking) {
> +                       result =3D -EAGAIN;
> +                       break;
> +               }
> +
> +               result =3D homa_interest_init_private(&interest, rpc);
> +               if (result !=3D 0)
> +                       break;
> +
> +               homa_rpc_unlock(rpc);
> +               result =3D homa_interest_wait(&interest);
> +
> +               atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> +               homa_rpc_lock(rpc);
> +               atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);

reuse the helper.

> +               homa_interest_unlink_private(&interest);
> +
> +               /* Abort on error, but if the interest actually got ready
> +                * in the meantime the ignore the error (loop back around
> +                * to process the RPC).
> +                */
> +               if (result !=3D 0 && atomic_read(&interest.ready) =3D=3D =
0)
> +                       break;
> +       }
> +
> +       return result;
> +}
> +
> +/**
> + * homa_wait_shared() - Wait for the completion of any non-private
> + * incoming message on a socket.
> + * @hsk:          Socket on which to wait. Must not be locked.
> + * @nonblocking:  Nonzero means return immediately if no RPC is ready.
> + *
> + * Return:    Pointer to an RPC with a complete incoming message or nonz=
ero
> + *            error field, or a negative errno (usually -EINTR). If an R=
PC
> + *            is returned it will be locked and referenced; the caller
> + *            must release the lock and the reference.
> + */
> +struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking=
)
> +       __cond_acquires(rpc->bucket->lock)
> +{
> +       struct homa_interest interest;
> +       struct homa_rpc *rpc;
> +       int result;
> +
> +       INIT_LIST_HEAD(&interest.links);
> +       init_waitqueue_head(&interest.wait_queue);
> +       /* Each iteration through this loop waits until an RPC needs atte=
ntion
> +        * in some way (e.g. packets have arrived), then deals with that =
need
> +        * (e.g. copy to user space). It may take many iterations until a=
n
> +        * RPC is ready for the application.
> +        */
> +       while (1) {
> +               homa_sock_lock(hsk);
> +               if (hsk->shutdown) {
> +                       rpc =3D ERR_PTR(-ESHUTDOWN);
> +                       homa_sock_unlock(hsk);
> +                       goto done;
> +               }
> +               if (!list_empty(&hsk->ready_rpcs)) {
> +                       rpc =3D list_first_entry(&hsk->ready_rpcs,
> +                                              struct homa_rpc,
> +                                              ready_links);
> +                       homa_rpc_hold(rpc);
> +                       list_del_init(&rpc->ready_links);
> +                       if (!list_empty(&hsk->ready_rpcs)) {
> +                               /* There are still more RPCs available, s=
o
> +                                * let Linux know.
> +                                */
> +                               hsk->sock.sk_data_ready(&hsk->sock);
> +                       }
> +                       homa_sock_unlock(hsk);
> +               } else if (nonblocking) {
> +                       rpc =3D ERR_PTR(-EAGAIN);
> +                       homa_sock_unlock(hsk);
> +
> +                       /* This is a good time to cleanup dead RPCS. */
> +                       homa_rpc_reap(hsk, false);
> +                       goto done;
> +               } else {
> +                       homa_interest_init_shared(&interest, hsk);
> +                       homa_sock_unlock(hsk);
> +                       result =3D homa_interest_wait(&interest);
> +
> +                       if (result !=3D 0) {
> +                               int ready;
> +
> +                               /* homa_interest_wait returned an error, =
so we
> +                                * have to do two things. First, unlink t=
he
> +                                * interest from the socket. Second, chec=
k to
> +                                * see if in the meantime the interest re=
ceived
> +                                * a handoff. If so, ignore the error. Ve=
ry
> +                                * important to hold the socket lock whil=
e
> +                                * checking, in order to eliminate races =
with
> +                                * homa_rpc_handoff.
> +                                */
> +                               homa_sock_lock(hsk);
> +                               homa_interest_unlink_shared(&interest);
> +                               ready =3D atomic_read(&interest.ready);
> +                               homa_sock_unlock(hsk);
> +                               if (ready =3D=3D 0) {
> +                                       rpc =3D ERR_PTR(result);
> +                                       goto done;
> +                               }
> +                       }
> +
> +                       rpc =3D interest.rpc;
> +                       if (!rpc) {
> +                               rpc =3D ERR_PTR(-ESHUTDOWN);
> +                               goto done;
> +                       }
> +               }
> +
> +               atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> +               homa_rpc_lock(rpc);
> +               atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);

Reuse the helper here.

> +               if (!rpc->error)
> +                       rpc->error =3D homa_copy_to_user(rpc);
> +               if (rpc->error) {
> +                       if (rpc->state !=3D RPC_DEAD)
> +                               break;
> +               } else if (rpc->msgin.bytes_remaining =3D=3D 0 &&
> +                   skb_queue_len(&rpc->msgin.packets) =3D=3D 0)
> +                       break;
> +               homa_rpc_put(rpc);
> +               homa_rpc_unlock(rpc);
> +       }
> +
> +done:
> +       return rpc;
> +}
> +
> +/**
> + * homa_rpc_handoff() - This function is called when the input message f=
or
> + * an RPC is ready for attention from a user thread. It notifies a waiti=
ng
> + * reader and/or queues the RPC, as appropriate.
> + * @rpc:                RPC to handoff; must be locked.
> + */
> +void homa_rpc_handoff(struct homa_rpc *rpc)
> +       __must_hold(rpc->bucket->lock)
> +{
> +       struct homa_sock *hsk =3D rpc->hsk;
> +       struct homa_interest *interest;
> +
> +       if (atomic_read(&rpc->flags) & RPC_PRIVATE) {
> +               homa_interest_notify_private(rpc);
> +               return;
> +       }
> +
> +       /* Shared RPC; if there is a waiting thread, hand off the RPC;
> +        * otherwise enqueue it.
> +        */
> +       homa_sock_lock(hsk);
> +       if (hsk->shutdown) {
> +               homa_sock_unlock(hsk);
> +               return;
> +       }
> +       if (!list_empty(&hsk->interests)) {
> +               interest =3D list_first_entry(&hsk->interests,
> +                                           struct homa_interest, links);
> +               list_del_init(&interest->links);
> +               interest->rpc =3D rpc;
> +               homa_rpc_hold(rpc);
> +               atomic_set_release(&interest->ready, 1);
> +               wake_up(&interest->wait_queue);
> +       } else if (list_empty(&rpc->ready_links)) {
> +               list_add_tail(&rpc->ready_links, &hsk->ready_rpcs);
> +               hsk->sock.sk_data_ready(&hsk->sock);
> +       }
> +       homa_sock_unlock(hsk);
> +}
> +
> --
> 2.43.0
>

