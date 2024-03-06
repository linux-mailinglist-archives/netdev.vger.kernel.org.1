Return-Path: <netdev+bounces-77942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC7873858
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAB1F2526C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3BC1332B1;
	Wed,  6 Mar 2024 14:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E01332AC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733872; cv=none; b=RK29p9svSz4TmiELg1Yh2LDPcHBgCUSuRD83hWBvBVdR8urj78Fgd0eteVWPPuyzIKtPS4acq7NIFYXdQFnHxyhbPqW5YW/0ZUuJBBmuvPLHl/FZZY6HFRwquHI/AhhI8afpRuhXLtftcQpocyRQGXj+PEo2U0Zwnn8+idJcs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733872; c=relaxed/simple;
	bh=ZvUYGtQR2j60tcaM5IbbkrfhiaMBvEMfbAoBR6fmpV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IkKCitHIhstV4LzQc4dn9PALFNb/1nkSYRBzkeJjG763yqJksXFACsX7D5lParU4sG1MvF/hVlcZWT1rczFxlSCwsx5UDYb1mn7eoBTN/cfvv1pOozRu0J0KGjGSlFZicaMWsYu3ICLDQCiwfuLSAxRKNNewHfzfYHCF/1bw1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Di-m57SsMnGEjSIoD2570Q-1; Wed, 06 Mar 2024 08:57:55 -0500
X-MC-Unique: Di-m57SsMnGEjSIoD2570Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3D711800AC4;
	Wed,  6 Mar 2024 13:57:54 +0000 (UTC)
Received: from hog (unknown [10.39.194.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 888B737F6;
	Wed,  6 Mar 2024 13:57:53 +0000 (UTC)
Date: Wed, 6 Mar 2024 14:57:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>, devel@linux-ipsec.org
Subject: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode impl
Message-ID: <Zeh2YFt4AWF7oNzE@hog>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240219085735.1220113-9-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-19, 03:57:35 -0500, Christian Hopps wrote:
>  net/xfrm/Makefile      |    1 +
>  net/xfrm/trace_iptfs.h |  218 ++++
>  net/xfrm/xfrm_iptfs.c  | 2762 ++++++++++++++++++++++++++++++++++++++++

This should probably be split into a few patches (maybe user config,
output, reordering, input, tracepoints) to help reviewers and keep the
answers to a more reasonable length. I dropped some of the feedback I
had because this email was getting ridiculous.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644

[...]
> +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 len,
> +=09=09=09=09       bool l3resv)
> +{
> +=09struct sk_buff *skb;
> +=09u32 resv;
> +
> +=09if (!l3resv) {
> +=09=09resv =3D XFRM_IPTFS_MIN_L2HEADROOM;
> +=09} else {
> +=09=09resv =3D skb_headroom(tpl);
> +=09=09if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
> +=09=09=09resv =3D XFRM_IPTFS_MIN_L3HEADROOM;
> +=09}
> +
> +=09skb =3D alloc_skb(len + resv, GFP_ATOMIC);
> +=09if (!skb) {
> +=09=09XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMINERROR);

Confusing, as iptfs_alloc_skb can be called from the output path as well.

> +=09=09return NULL;
> +=09}
> +
> +=09skb_reserve(skb, resv);
> +
> +=09/* Code from __copy_skb_header() -- we do not want any of the
> +=09 * tpl->headers copied over, so we aren't using `skb_copy_header()`.
> +=09 */

This is a bit of a bad sign for the implementation. It also worries
me, as this may not be updated when changes are made to
__copy_skb_header().

> +=09skb->tstamp =3D tpl->tstamp;
> +=09skb->dev =3D tpl->dev;
> +=09memcpy(skb->cb, tpl->cb, sizeof(skb->cb));
> +=09skb_dst_copy(skb, tpl);
> +=09__skb_ext_copy(skb, tpl);
> +=09__nf_copy(skb, tpl, false);
> +
> +=09return skb;
> +}



> +static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag=
)
> +static void skb_prepare_frag_walk(struct sk_buff *skb, u32 initial_offse=
t,
> +static u32 __skb_reset_frag_walk(struct skb_frag_walk *walk, u32 offset)
> +static bool skb_can_add_frags(const struct sk_buff *skb,
> +static int skb_add_frags(struct sk_buff *skb, struct skb_frag_walk *walk=
,

That's a lot of new helpers. Is there no existing API that fits IPTFS's nee=
ds?


> +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void =
*to, int len)

Probably belongs in net/core/skbuff.c (if this is really the right way
to implement iptfs).


[...]
> +static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb=
)
> +{
[...]
> +=09skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
> +
> +=09/* Get the IPTFS header and validate it */
> +
> +=09if (skb_copy_bits_seq(&skbseq, 0, ipth, sizeof(*ipth))) {

Could you use pskb_may_pull here? Like the rest of networking does
when parsing headers from skbs.

> +=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +=09=09goto done;
> +=09}
> +=09data =3D sizeof(*ipth);
> +
> +=09trace_iptfs_egress_recv(skb, xtfs, htons(ipth->block_offset));
> +
> +=09/* Set data past the basic header */
> +=09if (ipth->subtype =3D=3D IPTFS_SUBTYPE_CC) {
> +=09=09/* Copy the rest of the CC header */
> +=09=09remaining =3D sizeof(iptcch) - sizeof(*ipth);
> +=09=09if (skb_copy_bits_seq(&skbseq, data, ipth + 1, remaining)) {
> +=09=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +=09=09=09goto done;
> +=09=09}
> +=09=09data +=3D remaining;
> +=09} else if (ipth->subtype !=3D IPTFS_SUBTYPE_BASIC) {
> +=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
> +=09=09goto done;
> +=09}

[...]
> +=09=09} else {
> +=09=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +=09=09=09goto done;
> +=09=09}
> +
> +=09=09if (unlikely(skbseq.stepped_offset)) {

I don't think users of skb_seq_* should look into the internal state
of the skbseq.


[...]
> +=09=09=09=09/* all pointers could be changed now reset walk */
> +=09=09=09=09skb_abort_seq_read(&skbseq);
> +=09=09=09=09skb_prepare_seq_read(skb, data, tail, &skbseq);

The fact that you have to reset the walk indicates that this is
probably not the right way to implement this.

> +=09=09=09} else if (skb->head_frag &&
> +=09=09=09=09   /* We have the IP header right now */
> +=09=09=09=09   remaining >=3D iphlen) {
> +=09=09=09=09fragwalk =3D &_fragwalk;
> +=09=09=09=09skb_prepare_frag_walk(skb, data, fragwalk);
> +=09=09=09=09defer =3D skb;
> +=09=09=09=09skb =3D NULL;
> +=09=09=09} else {
> +=09=09=09=09/* We couldn't reuse the input skb so allocate a
> +=09=09=09=09 * new one.
> +=09=09=09=09 */
> +=09=09=09=09defer =3D skb;
> +=09=09=09=09skb =3D NULL;
> +=09=09=09}

I still don't get at all how the overall defrag/reassembly process is
implemented. I can tell you're walking the skb looking for IP headers,
and (I suppose) carving out new skbs containing a single packet built
from that header and all the payload that goes with it (and then
saving the last chunk to merge with the next incoming packet), but I
don't understand how.

This chunk looks like it might be optimizations, but I'm not sure. If
this is indeed the case, I'd suggest to remove them. For the initial
submission it would be nice to have a slightly dumber version that
reviewers can fully understand. Then you can add back the
optimizations once the code is merged.



[...]
> +/* ------------------------------- */
> +/* Input (Egress) Re-ordering Code */
> +/* ------------------------------- */

nit: ingress? The whole patch seems to mix up ingress/egress and
send/receive.

[...]
> +static u32 __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
> +=09=09=09=09 struct sk_buff *inskb,
> +=09=09=09=09 struct list_head *freelist, u32 *fcount)
> +{
[...]
> +=09BUG_ON(distance >=3D nslots);

Really not needed. I saw what you wrote about assert philosophy, but
that's not how BUG_ON is used in the kernel. DEBUG_NET_WARN_ON_ONCE
would fit that better for conditions that really should never be
true/false.

> +=09if (xtfs->w_saved[index].skb) {
> +=09=09/* a dup of a future */
> +=09=09list_add_tail(&inskb->list, freelist);

Why not just free it immediately?


> +static u32 __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
> +=09=09=09=09   struct sk_buff *inskb,
> +=09=09=09=09   struct list_head *list,
> +=09=09=09=09   struct list_head *freelist, u32 *fcount)
> +{

[...]
> +=09/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the
> +=09 * missing sequence number.

It would help to show the state of the reorder window (and all the
related state) at the end of this function (and maybe intermediate
states, after the loop and again after the following if block).

I also struggled to parse the formatting of the diagrams (for example,
what [b] and [-] and --- mean).


> +=09 * the final slot at savedlen (index savedlen - 1) is always occupied=
.
> +=09 *
> +=09 * beyond is "beyond array size" not savedlen.
> +=09 *
> +=09 *          +--------- array length (savedlen =3D=3D 2)
> +=09 *          |   +----- array size (nslots - 1 =3D=3D 3)
> +=09 *          |   |   +- window boundary (nslots =3D=3D 4)
> +=09 *          V   V | V
> +=09 *                |
> +=09 *  0   1   2   3 |   slot number
> +=09 * ---  0   1   2 |   array index
> +=09 *     [b] [c] : :|   array
> +=09 *                |
> +=09 * "2" "3" "4" "5"|*6*  seq numbers
> +=09 *
> +=09 * We receive seq number 6
> +=09 * distance =3D=3D 4 [inseq(6) - w_wantseq(2)]
> +=09 * newslot =3D=3D distance
> +=09 * index =3D=3D 3 [distance(4) - 1]
> +=09 * beyond =3D=3D 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +=09 * shifting =3D=3D 1 [min(savedlen(2), beyond(1)]
> +=09 * slot0_skb =3D=3D [b], and should match w_wantseq

A separator between each example (maybe a long line of '*') would be
helpful.

> +=09 *
> +=09 *                +--- window boundary (nslots =3D=3D 4)
> +=09 *  0   1   2   3 | 4   slot number
> +=09 * ---  0   1   2 | 3   array index
> +=09 *     [b] : : : :|     array
> +=09 * "2" "3" "4" "5" *6*  seq numbers
> +=09 *
> +=09 * We receive seq number 6
> +=09 * distance =3D=3D 4 [inseq(6) - w_wantseq(2)]
> +=09 * newslot =3D=3D distance
> +=09 * index =3D=3D 3 [distance(4) - 1]
> +=09 * beyond =3D=3D 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +=09 * shifting =3D=3D 1 [min(savedlen(1), beyond(1)]
> +=09 * slot0_skb =3D=3D [b] and should match w_wantseq
> +=09 *
> +=09 *                +-- window boundary (nslots =3D=3D 4)
> +=09 *  0   1   2   3 | 4   5   6   slot number
> +=09 * ---  0   1   2 | 3   4   5   array index
> +=09 *     [-] [c] : :|             array
> +=09 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
> +=09 *
> +=09 * savedlen =3D 2, beyond =3D 3
> +=09 * iter 1: slot0 =3D=3D NULL, missed++, lastdrop =3D 2 (2+1-1), slot0=
 =3D [-]
> +=09 * iter 2: slot0 =3D=3D NULL, missed++, lastdrop =3D 3 (2+2-1), slot0=
 =3D [c]

I'm not quite sure what "iter 1" and "iter 2" refer to.

> +=09 * 2 < 3, extra =3D 1 (3-2), missed +=3D extra, lastdrop =3D 4 (2+2+1=
-1)
> +=09 *
> +=09 * We receive seq number 8
> +=09 * distance =3D=3D 6 [inseq(8) - w_wantseq(2)]
> +=09 * newslot =3D=3D distance
> +=09 * index =3D=3D 5 [distance(6) - 1]
> +=09 * beyond =3D=3D 3 [newslot(6) - lastslot((nslots(4) - 1))]
> +=09 * shifting =3D=3D 2 [min(savedlen(2), beyond(3)]
> +=09 *
> +=09 * slot0_skb =3D=3D NULL changed from [b] when "savedlen < beyond" is=
 true.
> +=09 */
> +
> +=09/* Now send any packets that are being shifted out of saved, and acco=
unt
> +=09 * for missing packets that are exiting the window as we shift it.
> +=09 */
> +
> +=09/* If savedlen > beyond we are shifting some, else all. */
> +=09shifting =3D min(savedlen, beyond);
> +
> +=09/* slot0 is the buf that just shifted out and into slot0 */
> +=09slot0 =3D NULL;
> +=09s0seq =3D wantseq;
> +=09last_drop_seq =3D s0seq;

Set but never read.

> +=09wnext =3D xtfs->w_saved;
> +=09for (slot =3D 1; slot <=3D shifting; slot++, wnext++) {
> +=09=09/* handle what was in slot0 before we occupy it */
> +=09=09if (!slot0) {
> +=09=09=09last_drop_seq =3D s0seq;
> +=09=09=09missed++;

Set but never read.

> +=09=09} else {
> +=09=09=09list_add_tail(&slot0->list, list);
> +=09=09=09count++;
> +=09=09}
> +=09=09s0seq++;
> +=09=09slot0 =3D wnext->skb;
> +=09=09wnext->skb =3D NULL;
> +=09}

I wonder if this code would become more readable by "wasting" an array
element for slot0 (which can never be set except temporarily while
shifting and reordering packets). This function is more than 50%
comments :/

> +=09/* slot0 is now either NULL (in which case it's what we now are waiti=
ng
> +=09 * for, or a buf in which case we need to handle it like we received =
it;
> +=09 * however, we may be advancing past that buffer as well..
> +=09 */
> +
> +=09/* Handle case where we need to shift more than we had saved, slot0 w=
ill
> +=09 * be NULL iff savedlen is 0, otherwise slot0 will always be
> +=09 * non-NULL b/c we shifted the final element, which is always set if
> +=09 * there is any saved, into slot0.
> +=09 */
> +=09if (savedlen < beyond) {
> +=09=09extra_drops =3D beyond - savedlen;
> +=09=09if (savedlen =3D=3D 0) {
> +=09=09=09BUG_ON(slot0);
> +=09=09=09s0seq +=3D extra_drops;
> +=09=09=09last_drop_seq =3D s0seq - 1;
> +=09=09} else {
> +=09=09=09extra_drops--; /* we aren't dropping what's in slot0 */
> +=09=09=09BUG_ON(!slot0);
> +=09=09=09list_add_tail(&slot0->list, list);
> +=09=09=09/* if extra_drops then we are going past this slot0
> +=09=09=09 * so we can safely advance last_drop_seq
> +=09=09=09 */
> +=09=09=09if (extra_drops)
> +=09=09=09=09last_drop_seq =3D s0seq + extra_drops;
> +=09=09=09s0seq +=3D extra_drops + 1;
> +=09=09=09count++;
> +=09=09}
> +=09=09missed +=3D extra_drops;
> +=09=09slot0 =3D NULL;
> +=09=09/* slot0 has had an empty slot pushed into it */
> +=09}
> +=09(void)last_drop_seq;=09/* we want this for CC code */

Ewww. Please no breadcrumbs.

> +
> +=09/* Remove the entries */

This comment doesn't explain much...

> +=09__vec_shift(xtfs, beyond);
> +
> +=09/* Advance want seq */

and this one even less.

> +=09xtfs->w_wantseq +=3D beyond;
> +
> +=09/* Process drops here when implementing congestion control */

[...]
> +static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +=09struct list_head freelist, list;
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +=09struct sk_buff *next;
> +=09u32 count, fcount;
> +
> +=09/* Fast path for no reorder window. */
> +=09if (xtfs->cfg.reorder_win_size =3D=3D 0) {
> +=09=09iptfs_input_ordered(x, skb);
> +=09=09goto done;
> +=09}
> +
> +=09/* Fetch list of in-order packets from the reordering window as well =
as
> +=09 * a list of buffers we need to now free.
> +=09 */
> +=09INIT_LIST_HEAD(&list);
> +=09INIT_LIST_HEAD(&freelist);
> +=09fcount =3D 0;
> +
> +=09spin_lock(&xtfs->drop_lock);
> +=09count =3D iptfs_input_reorder(xtfs, skb, &list, &freelist, &fcount);

iptfs_input_reorder isn't that long, it would be less messy to just
insert it here.

> +=09spin_unlock(&xtfs->drop_lock);
> +
> +=09if (count) {

Do we really need those counts? I hope list_for_each_entry_safe can
deal just fine with an empty list?

> +=09=09list_for_each_entry_safe(skb, next, &list, list) {
> +=09=09=09skb_list_del_init(skb);
> +=09=09=09(void)iptfs_input_ordered(x, skb);
> +=09=09}
> +=09}
> +
> +=09if (fcount) {
> +=09=09list_for_each_entry_safe(skb, next, &freelist, list) {
> +=09=09=09skb_list_del_init(skb);
> +=09=09=09kfree_skb(skb);

Given that freelist processing is so simple, why not just free
everything directly? It would remove the need to pass more arguments
down to the other functions.

> +=09=09}
> +=09}


[...]
> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS pa=
yload
> + * (i.e., aggregating or fragmenting as appropriate).
> + * This is set in dst->output for an SA.
> + */
> +static int iptfs_output_collect(struct net *net, struct sock *sk,
> +=09=09=09=09struct sk_buff *skb)
> +{
[...]
> +=09} else {
> +=09=09segs =3D skb_gso_segment(skb, 0);
> +=09=09if (IS_ERR_OR_NULL(segs)) {
> +=09=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +=09=09=09kfree_skb(skb);
> +=09=09=09return PTR_ERR(segs);

If skb_gso_segment returned NULL, this will end up returning 0. Is
that correct?



> +static int iptfs_user_init(struct net *net, struct xfrm_state *x,
> +=09=09=09   struct nlattr **attrs,
> +=09=09=09   struct netlink_ext_ack *extack)
> +{
[...]
> +=09if (xc->reorder_win_size)
> +=09=09xtfs->w_saved =3D kcalloc(xc->reorder_win_size,
> +=09=09=09=09=09sizeof(*xtfs->w_saved), GFP_KERNEL);

if (!xtfs->w_saved)
    return -ENOMEM;



> +static int iptfs_create_state(struct xfrm_state *x)
> +{
> +=09struct xfrm_iptfs_data *xtfs;
> +=09int err;
> +
> +=09xtfs =3D kzalloc(sizeof(*xtfs), GFP_KERNEL);
> +=09if (!xtfs)
> +=09=09return -ENOMEM;
> +
> +=09err =3D __iptfs_init_state(x, xtfs);
> +=09if (err)
> +=09=09return err;

kfree(xtfs) here?
iptfs_delete_state can't free it since we haven't set x->mode_data yet
when __iptfs_init_state fails.

> +
> +=09return 0;
> +}
> +
> +static void iptfs_delete_state(struct xfrm_state *x)
> +{
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +=09struct skb_wseq *s, *se;
> +
> +=09if (!xtfs)
> +=09=09return;
> +
> +=09spin_lock_bh(&xtfs->drop_lock);
> +=09hrtimer_cancel(&xtfs->iptfs_timer);
> +=09hrtimer_cancel(&xtfs->drop_timer);
> +=09spin_unlock_bh(&xtfs->drop_lock);

Does this guarantee that xtfs->queue has been flushed? If not, I guess
we need to do it now.

> +
> +=09if (xtfs->ra_newskb)
> +=09=09kfree_skb(xtfs->ra_newskb);
> +
> +=09for (s =3D xtfs->w_saved, se =3D s + xtfs->w_savedlen; s < se; s++)
> +=09=09if (s->skb)
> +=09=09=09kfree_skb(s->skb);

nit: possibly better if hidden in a free_reorder_pending helper (or
some other similar name), implemented alongside all the reorder code.


> +=09kfree_sensitive(xtfs->w_saved);
> +=09kfree_sensitive(xtfs);
> +
> +=09module_put(x->mode_cbs->owner);
> +}

--=20
Sabrina


