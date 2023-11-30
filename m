Return-Path: <netdev+bounces-52570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269897FF39D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26A22816E9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8389524BC;
	Thu, 30 Nov 2023 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45F510C2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:34:08 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-BRj_2WmJNDCbE3WyGV9-Ag-1; Thu, 30 Nov 2023 10:34:01 -0500
X-MC-Unique: BRj_2WmJNDCbE3WyGV9-Ag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03118811E86;
	Thu, 30 Nov 2023 15:34:01 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8618492BE7;
	Thu, 30 Nov 2023 15:33:59 +0000 (UTC)
Date: Thu, 30 Nov 2023 16:33:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 8/8] iptfs: impl: add new iptfs xfrm mode impl
Message-ID: <ZWirZo4FrvZOi1Ik@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113035219.920136-9-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-12, 22:52:19 -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
>=20
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>=20
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
>=20
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>=20
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/net/iptfs.h    |   18 +
>  net/xfrm/Makefile      |    1 +
>  net/xfrm/trace_iptfs.h |  224 ++++
>  net/xfrm/xfrm_iptfs.c  | 2696 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2939 insertions(+)
>  create mode 100644 include/net/iptfs.h
>  create mode 100644 net/xfrm/trace_iptfs.h
>  create mode 100644 net/xfrm/xfrm_iptfs.c
>=20
> diff --git a/include/net/iptfs.h b/include/net/iptfs.h
> new file mode 100644
> index 000000000000..d8f2e494f251
> --- /dev/null
> +++ b/include/net/iptfs.h

Is this header needed? It's only included by net/xfrm/xfrm_iptfs.c,
why not put those #defines directly in the file?

> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _NET_IPTFS_H
> +#define _NET_IPTFS_H
> +
> +#include <linux/types.h>
> +#include <linux/ip.h>
> +
> +#define IPTFS_SUBTYPE_BASIC 0
> +#define IPTFS_SUBTYPE_CC 1
> +#define IPTFS_SUBTYPE_LAST IPTFS_SUBTYPE_CC

_LAST is never used.

> +#define IPTFS_CC_FLAGS_ECN_CE 0x1
> +#define IPTFS_CC_FLAGS_PLMTUD 0x2

Not used either.

> +extern void xfrm_iptfs_get_rtt_and_delays(struct ip_iptfs_cc_hdr *cch, u=
32 *rtt,
> +=09=09=09=09=09  u32 *actual_delay, u32 *xmit_delay);

Not implemented in this series, drop this.

[...]
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644
> index 000000000000..65f7acdbe6a8
> --- /dev/null
> +++ b/net/xfrm/xfrm_iptfs.c
[...]
> +struct sk_buff *iptfs_pskb_add_frags(struct sk_buff *tpl,

nit: static? afaict it's not used outside this file.

> +=09=09=09=09     struct skb_frag_walk *walk, u32 off,
> +=09=09=09=09     u32 len, struct skb_seq_state *st,
> +=09=09=09=09     u32 copy_len)
> +{


[...]
> +
> +/**
> + * iptfs_input_ordered() - handle next in order IPTFS payload.
> + *
> + * Process the IPTFS payload in `skb` and consume it afterwards.
> + */
> +static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb=
)
> +{

Can we try to not introduce a worse problem than xfrm_input already
is? 326 lines and 20+ local variables is way too much. And then it
calls another 200+ lines function...

I did try to understand what the main loop does but I got completely
lost the 3 times I tried :/


> +static u32 __reorder_this(struct xfrm_iptfs_data *xtfs, struct sk_buff *=
inskb,
> +=09=09=09  struct list_head *list)
> +

nit: extra blank line

> +{


[...]
> +/**
> + * iptfs_input() - handle receipt of iptfs payload
> + * @x: xfrm state.
> + * @skb: the packet.
> + *
> + * We have an IPTFS payload order it if needed, then process newly in or=
der
> + * packetsA.

typo? "packetsA"


[...]
> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS pa=
yload
> + * (i.e., aggregating or fragmenting as appropriate).
> + * This is set in dst->output for an SA.
> + */
> +static int iptfs_output_collect(struct net *net, struct sock *sk,
> +=09=09=09=09struct sk_buff *skb)
> +{
> +=09struct dst_entry *dst =3D skb_dst(skb);
> +=09struct xfrm_state *x =3D dst->xfrm;
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +=09struct sk_buff *segs, *nskb;
> +=09u32 count, qcount;
> +=09u32 pmtu =3D 0;
> +=09bool ok =3D true;
> +=09bool was_gso;
> +
> +=09/* We have hooked into dst_entry->output which means we have skipped =
the
> +=09 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
> +=09 * when our timer runs we will end up calling xfrm_output directly on
> +=09 * the encapsulated traffic.
> +=09 *
> +=09 * For both cases this is the NF_INET_POST_ROUTING hook which allows
> +=09 * changing the skb->dst entry which then may not be xfrm based anymo=
re
> +=09 * in which case a REROUTED flag is set. and dst_output is called.
> +=09 *
> +=09 * For IPv6 we are also skipping fragmentation handling for local
> +=09 * sockets, which may or may not be good depending on our tunnel DF
> +=09 * setting. Normally with fragmentation supported we want to skip thi=
s
> +=09 * fragmentation.
> +=09 */
> +
> +=09BUG_ON(!xtfs);

Or drop the packet and add a DEBUG_NET_WARN_ON_ONCE? This should never
happen, but why crash the system when we have a way to deal with this
error?

> +
> +=09if (xtfs->cfg.dont_frag)
> +=09=09pmtu =3D iptfs_get_cur_pmtu(x, xtfs, skb);
> +
> +=09/* Break apart GSO skbs. If the queue is nearing full then we want th=
e
> +=09 * accounting and queuing to be based on the individual packets not o=
n the
> +=09 * aggregate GSO buffer.
> +=09 */
> +=09was_gso =3D skb_is_gso(skb);
> +=09if (!was_gso) {
> +=09=09segs =3D skb;
> +=09} else {
> +=09=09segs =3D skb_gso_segment(skb, 0);
> +=09=09if (IS_ERR_OR_NULL(segs)) {
> +=09=09=09XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +=09=09=09kfree_skb(skb);
> +=09=09=09return PTR_ERR(segs);
> +=09=09}
> +=09=09consume_skb(skb);
> +=09=09skb =3D NULL;
> +=09}
> +
> +=09count =3D 0;
> +=09qcount =3D 0;

nit: both of those get incremented through the main loop but never read

> +
> +=09/* We can be running on multiple cores and from the network softirq o=
r
> +=09 * from user context depending on where the packet is coming from.
> +=09 */
> +=09spin_lock_bh(&x->lock);
> +
> +=09skb_list_walk_safe(segs, skb, nskb) {
> +=09=09skb_mark_not_on_list(skb);
> +=09=09count++;
> +
> +=09=09/* Once we drop due to no queue space we continue to drop the
> +=09=09 * rest of the packets from that GRO.
> +=09=09 */
> +=09=09if (!ok) {
> +nospace:
> +=09=09=09trace_iptfs_no_queue_space(skb, xtfs, pmtu, was_gso);
> +=09=09=09XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTNOQSPACE);
> +=09=09=09kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09/* If the user indicated no iptfs fragmenting check before
> +=09=09 * enqueue.
> +=09=09 */
> +=09=09if (xtfs->cfg.dont_frag && iptfs_is_too_big(sk, skb, pmtu)) {
> +=09=09=09trace_iptfs_too_big(skb, xtfs, pmtu, was_gso);
> +=09=09=09kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09/* Enqueue to send in tunnel */
> +

nit: unneeded blank line

> +=09=09ok =3D iptfs_enqueue(xtfs, skb);
> +=09=09if (!ok)
> +=09=09=09goto nospace;
> +
> +=09=09trace_iptfs_enqueue(skb, xtfs, pmtu, was_gso);
> +=09=09qcount++;
> +=09}
> +
> +=09/* Start a delay timer if we don't have one yet */
> +=09if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
> +=09=09/* softirq blocked lest the timer fire and interrupt us */
> +=09=09BUG_ON(!in_interrupt());

Why is that a fatal condition?

> +=09=09hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
> +=09=09=09      IPTFS_HRTIMER_MODE);
> +
> +=09=09xtfs->iptfs_settime =3D ktime_get_raw_fast_ns();
> +=09=09trace_iptfs_timer_start(xtfs, xtfs->init_delay_ns);
> +=09}
> +
> +=09spin_unlock_bh(&x->lock);
> +=09return 0;
> +}
> +

[...]
> +static int iptfs_copy_create_frags(struct sk_buff **skbp,
> +=09=09=09=09   struct xfrm_iptfs_data *xtfs, u32 mtu)
> +{
[...]
> +=09/* prepare the initial fragment with an iptfs header */
> +=09iptfs_output_prepare_skb(skb, 0);
> +
> +=09/* Send all but last fragment. */
> +=09list_for_each_entry_safe(skb, nskb, &sublist, list) {
> +=09=09skb_list_del_init(skb);
> +=09=09xfrm_output(NULL, skb);

Should we stop if xfrm_output fails? Or is it still useful to send the
rest of the iptfs frags if we lose one in the middle?

> +=09}
> +
> +=09return 0;
> +}
> +

[...]
> +static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data=
 *xtfs,
> +=09=09=09   u32 mtu)
> +{
> +=09struct sk_buff *skb =3D *skbp;
> +=09int err;
> +
> +=09/* Classic ESP skips the don't fragment ICMP error if DF is clear on
> +=09 * the inner packet or ignore_df is set. Otherwise it will send an IC=
MP
> +=09 * or local error if the inner packet won't fit it's MTU.
> +=09 *
> +=09 * With IPTFS we do not care about the inner packet DF bit. If the
> +=09 * tunnel is configured to "don't fragment" we error back if things
> +=09 * don't fit in our max packet size. Otherwise we iptfs-fragment as
> +=09 * normal.
> +=09 */
> +
> +=09/* The opportunity for HW offload has ended */
> +=09if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +=09=09err =3D skb_checksum_help(skb);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09/* We've split these up before queuing */
> +=09BUG_ON(skb_is_gso(skb));

Drop and DEBUG_NET_WARN_ON_ONCE?

> +
> +=09trace_iptfs_first_dequeue(skb, mtu, 0, ip_hdr(skb));
> +
> +=09/* Simple case -- it fits. `mtu` accounted for all the overhead
> +=09 * including the basic IPTFS header.
> +=09 */
> +=09if (skb->len <=3D mtu) {
> +=09=09iptfs_output_prepare_skb(skb, 0);
> +=09=09return 0;
> +=09}
> +
> +=09BUG_ON(xtfs->cfg.dont_frag);

and here?

> +=09if (iptfs_first_should_copy(skb, mtu))
> +=09=09return iptfs_copy_create_frags(skbp, xtfs, mtu);

Since we end up copying anyway, drop this (and
iptfs_first_should_copy). You can introduce the optimization later on.


> +=09/* For now we always copy */
> +=09return iptfs_copy_create_frags(skbp, xtfs, mtu);
> +}
> +
> +static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
> +=09=09=09=09=09      struct sk_buff *child)
> +{
> +=09u32 fllen =3D 0;
> +
> +=09BUG_ON(!skb_has_frag_list(child));

Not needed, this was tested just before calling this function.

> +
> +=09/* It might be possible to account for a frag list in addition to pag=
e
> +=09 * fragment if it's a valid state to be in. The page fragments size
> +=09 * should be kept as data_len so only the frag_list size is removed,
> +=09 * this must be done above as well took
> +=09 */
> +=09BUG_ON(skb_shinfo(child)->nr_frags);

Again not worth crashing the system?

> +=09*nextp =3D skb_shinfo(child)->frag_list;
> +=09while (*nextp) {
> +=09=09fllen +=3D (*nextp)->len;
> +=09=09nextp =3D &(*nextp)->next;
> +=09}
> +=09skb_frag_list_init(child);
> +=09BUG_ON(fllen > child->data_len);
> +=09child->len -=3D fllen;
> +=09child->data_len -=3D fllen;
> +
> +=09return nextp;
> +}

[...]
> +static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_hea=
d *list)
> +{
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +=09u32 payload_mtu =3D xtfs->payload_mtu;
> +=09struct sk_buff *skb, *skb2, **nextp;
> +=09struct skb_shared_info *shi, *shi2;
> +
> +=09/* For now we are just outputting packets as fast as we can, so if we
> +=09 * are fragmenting we will do so until the last inner packet has been
> +=09 * consumed.
> +=09 *
> +=09 * When we are fragmenting we need to output all outer packets that
> +=09 * contain the fragments of a single inner packet, consecutively (ESP
> +=09 * seq-wise). So we need a lock to keep another CPU from sending the
> +=09 * next batch of packets (it's `list`) and trying to output those, wh=
ile
> +=09 * we output our `list` resuling with interleaved non-spec-client inn=
er
> +=09 * packet streams. Thus we need to lock the IPTFS output on a per SA
> +=09 * basis while we process this list.
> +=09 */

This talks about a lock but I don't see one. What am I missing?

> +
> +=09/* NOTE: for the future, for timed packet sends, if our queue is not
> +=09 * growing longer (i.e., we are keeping up) and a packet we are about=
 to
> +=09 * fragment will not fragment in then next outer packet, we might con=
sider
> +=09 * holding on to it to send whole in the next slot. The question then=
 is
> +=09 * does this introduce a continuous delay in the inner packet stream
> +=09 * with certain packet rates and sizes?
> +=09 */
> +
> +=09/* and send them on their way */
> +
> +=09while ((skb =3D __skb_dequeue(list))) {
> +=09=09struct xfrm_dst *xdst =3D (struct xfrm_dst *)skb_dst(skb);
> +=09=09u32 mtu =3D __iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
> +=09=09bool share_ok =3D true;
> +=09=09int remaining;
> +
> +=09=09/* protocol comes to us cleared sometimes */
> +=09=09skb->protocol =3D x->outer_mode.family =3D=3D AF_INET ?
> +=09=09=09=09=09htons(ETH_P_IP) :
> +=09=09=09=09=09htons(ETH_P_IPV6);
> +
> +=09=09if (payload_mtu && payload_mtu < mtu)
> +=09=09=09mtu =3D payload_mtu;

Isn't that iptfs_get_cur_pmtu?


[...]
> +static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
> +{
> +=09struct sk_buff_head list;
> +=09struct xfrm_iptfs_data *xtfs;
> +=09struct xfrm_state *x;
> +=09time64_t settime;
> +=09size_t osize;
> +
> +=09xtfs =3D container_of(me, typeof(*xtfs), iptfs_timer);
> +=09x =3D xtfs->x;
> +
> +=09/* Process all the queued packets
> +=09 *
> +=09 * softirq execution order: timer > tasklet > hrtimer
> +=09 *
> +=09 * Network rx will have run before us giving one last chance to queue
> +=09 * ingress packets for us to process and transmit.
> +=09 */
> +
> +=09spin_lock(&x->lock);
> +=09__skb_queue_head_init(&list);
> +=09skb_queue_splice_init(&xtfs->queue, &list);
> +=09osize =3D xtfs->queue_size;

Unused variable?

[...]
> +static int iptfs_user_init(struct net *net, struct xfrm_state *x,
> +=09=09=09   struct nlattr **attrs)
> +{
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +=09struct xfrm_iptfs_config *xc;
> +
> +=09if (x->props.mode !=3D XFRM_MODE_IPTFS)
> +=09=09return -EINVAL;

Is that necessary? This only gets called via ->user_init for this
mode.

> +=09xc =3D &xtfs->cfg;
> +=09xc->reorder_win_size =3D net->xfrm.sysctl_iptfs_rewin;
> +=09xc->max_queue_size =3D net->xfrm.sysctl_iptfs_maxqsize;
> +=09xc->init_delay_us =3D net->xfrm.sysctl_iptfs_idelay;
> +=09xc->drop_time_us =3D net->xfrm.sysctl_iptfs_drptime;
> +
> +=09if (attrs[XFRMA_IPTFS_DONT_FRAG])
> +=09=09xc->dont_frag =3D true;
> +=09if (attrs[XFRMA_IPTFS_REORD_WIN])
> +=09=09xc->reorder_win_size =3D
> +=09=09=09nla_get_u16(attrs[XFRMA_IPTFS_REORD_WIN]);
> +=09/* saved array is for saving 1..N seq nums from wantseq */
> +=09if (xc->reorder_win_size)
> +=09=09xtfs->w_saved =3D kcalloc(xc->reorder_win_size,
> +=09=09=09=09=09sizeof(*xtfs->w_saved), GFP_KERNEL);

We probably need a reasonable bound on reorder_win_size so that we
don't try to allocate crazy amounts of memory here.

> +=09if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
> +=09=09xc->pkt_size =3D nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
> +=09=09if (!xc->pkt_size)
> +=09=09=09xtfs->payload_mtu =3D 0;

That's already set to 0 via kzalloc, right? So passing 0 as
XFRMA_IPTFS_PKT_SIZE is equivalent to not providing it?

> +=09=09else if (xc->pkt_size > x->props.header_len)
> +=09=09=09xtfs->payload_mtu =3D xc->pkt_size - x->props.header_len;
> +=09=09else
> +=09=09=09return -EINVAL;

This could probably use an extack to explain why the value was rejected.

> +=09}
> +=09if (attrs[XFRMA_IPTFS_MAX_QSIZE])
> +=09=09xc->max_queue_size =3D nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
> +=09if (attrs[XFRMA_IPTFS_DROP_TIME])
> +=09=09xc->drop_time_us =3D nla_get_u32(attrs[XFRMA_IPTFS_DROP_TIME]);
> +=09if (attrs[XFRMA_IPTFS_INIT_DELAY])
> +=09=09xc->init_delay_us =3D nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]);
> +
> +=09xtfs->ecn_queue_size =3D (u64)xc->max_queue_size * 95 / 100;
> +=09xtfs->drop_time_ns =3D xc->drop_time_us * NSECS_IN_USEC;
> +=09xtfs->init_delay_ns =3D xc->init_delay_us * NSECS_IN_USEC;

Can't we get rid of the _us version? Why store both in kernel memory?


[...]
> +static void iptfs_delete_state(struct xfrm_state *x)
> +{
> +=09struct xfrm_iptfs_data *xtfs =3D x->mode_data;
> +
> +=09if (IS_ERR_OR_NULL(xtfs))

Can mode_data ever be an error pointer?

> +=09=09return;
> +
> +=09spin_lock(&xtfs->drop_lock);
> +=09hrtimer_cancel(&xtfs->iptfs_timer);
> +=09hrtimer_cancel(&xtfs->drop_timer);
> +=09spin_unlock(&xtfs->drop_lock);
> +
> +=09kfree_sensitive(xtfs->w_saved);
> +=09kfree_sensitive(xtfs);
> +}
> +
> +static const struct xfrm_mode_cbs iptfs_mode_cbs =3D {
> +=09.owner =3D THIS_MODULE,
> +=09.create_state =3D iptfs_create_state,
> +=09.delete_state =3D iptfs_delete_state,
> +=09.user_init =3D iptfs_user_init,
> +=09.copy_to_user =3D iptfs_copy_to_user,
> +=09.get_inner_mtu =3D iptfs_get_inner_mtu,
> +=09.input =3D iptfs_input,
> +=09.output =3D iptfs_output_collect,
> +=09.prepare_output =3D iptfs_prepare_output,
> +};
> +
> +static int __init xfrm_iptfs_init(void)
> +{
> +=09int err;
> +
> +=09pr_info("xfrm_iptfs: IPsec IP-TFS tunnel mode module\n");
> +
> +=09err =3D xfrm_register_mode_cbs(XFRM_MODE_IPTFS, &iptfs_mode_cbs);
> +=09if (err < 0)
> +=09=09pr_info("%s: can't register IP-TFS\n", __func__);
> +
> +=09return err;
> +}
> +
> +static void __exit xfrm_iptfs_fini(void)
> +{
> +=09xfrm_unregister_mode_cbs(XFRM_MODE_IPTFS);
> +}

If the module is unloaded, existing xfrm states will be left but
silently broken?

--=20
Sabrina


