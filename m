Return-Path: <netdev+bounces-306150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IvTpCl95T2rUhgIAu9opvQ
	(envelope-from <netdev+bounces-306150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA672FABD
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:35:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AEdjLpZS;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306150-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306150-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4040B30578BB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E54071EB;
	Thu,  9 Jul 2026 09:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC5404BF6
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591017; cv=none; b=fADppCgjcDqDGUpO1KQGp40dxGfoOAff/etdCfccBq+wlOnAYkixOr18H2zzOHatxE1IkJRUodNkkTu/nEHpQPzQxzhsYucKNB+Agrpmp6bKfDiOG/QXocLh5964BU4WCZmwu9f0IhAeiMupiem0EtI8oAQT5vs96ueWnN+/VAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591017; c=relaxed/simple;
	bh=GT0uU4SqgMzUAF/7wrdc5elOWIzthqgElWzHpDpmwxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxAF9suFS2cuaBZ3E9gfLKEB7yNlceqwBFIAdkS+8/8JuQh+eB6EkzmQh4ILSjGjfcinGh4BmwyzOYqun5mVpg1z37bl25R3+pPEP7RmUmFd+0sVGQmDxhhOjfjevAeotK9OiKTauBTk6rDBOY3vUDtqWM+CWQHZgHOHFtu/dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEdjLpZS; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783591014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF+YMk/6dDAHkHRJOJJJlwc95oCBbTWD9fwxKhsLSpY=;
	b=AEdjLpZSX3cHqW5/cgtiEA0nWGCVVXD0QXZfkqPKxw9qnjwb78g4eJOhnmIdV8orvBkkTL
	sk0Z5FR0zwblwv9ifduI0UY26SnzODzG9vBAPRlf6ufY5DOEP7pnhpuUR9eQvDsRebZtj5
	mpc23sT84GOb9R/xY8yIXCRX73V7vBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-_FPO57n8NtGZHVn5zCrILA-1; Thu,
 09 Jul 2026 05:56:51 -0400
X-MC-Unique: _FPO57n8NtGZHVn5zCrILA-1
X-Mimecast-MFC-AGG-ID: _FPO57n8NtGZHVn5zCrILA_1783591010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C8F21800655;
	Thu,  9 Jul 2026 09:56:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DE531955D71;
	Thu,  9 Jul 2026 09:56:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v2 net-next 9/9] octeontx2: add TC flow offload path for switch flows
Date: Thu,  9 Jul 2026 11:56:44 +0200
Message-ID: <20260709095644.117406-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-10-rkannoth@marvell.com>
References: <20260702045026.2914748-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AAA672FABD

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
    octeontx2: add TC flow offload path for switch flows

This patch registers a TC flow offload path that translates flower rules
into fl_tuple state, resolves ingress/egress pcifunc via FIB, and forwards
the results to the AF over the PF mailbox.  A few observations follow
inline.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> @@ -7,14 +7,14 @@
>  u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
>  {
> -	u32 port_id;
> +	u16 port_id;
>  	u16 rep_id;
>  
>  	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);

[High]
Is the change from u32 to u16 here intentional?  The next line builds
a value that spans bits 0..31:

	port_id = FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
		  FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);

Storing that back into a u16 port_id drops the rep_id (bits 16..31)
before the return, so callers that stash the result as u32 (l2_entry,
l3_entry, fl_entry->port_id) always see zero in the upper half.  Would
that not defeat rep_id-based port disambiguation once rep_id != 0?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> @@ -4,12 +4,257 @@
> +static struct workqueue_struct *sw_fl_offl_wq;
> +
> +struct fl_entry {
[ ... ]
> +};
> +
> +static DEFINE_MUTEX(fl_offl_llock);
> +static LIST_HEAD(fl_offl_lh);
> +static bool fl_offl_work_running;
> +
> +static struct workqueue_struct *sw_fl_offl_wq;

[Low]
sw_fl_offl_wq is declared twice as a static in the same translation
unit.  Both declarations resolve to the same tentative definition, but
was the duplication intentional?

> +int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt)
> +{
> +	struct npc_mcam_get_mul_stats_req *req = NULL;
> +	struct npc_mcam_get_mul_stats_rsp *rsp = NULL;
> +	int tot = 0;
> +	u16 i2idx_map[256];
> +	int rc = 0;
> +	u64 pkts;
> +	int idx;
> +
> +	if (cnt > 256)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < cnt; i++) {
> +		tot++;
> +		if (fl[i].uni_di)
> +			continue;
> +
> +		tot++;
> +	}

[Critical]
Can this overflow the fixed-size arrays sized by cnt?  The guard only
bounds cnt at 256, but tot can grow up to 2 * cnt = 512 when every
entry has uni_di == 0.  Three arrays are then indexed by tot:

	u16 i2idx_map[256];             /* stack */
	req->entry[256];                /* struct npc_mcam_get_mul_stats_req */
	rsp->stat[256];                 /* struct npc_mcam_get_mul_stats_rsp */

> +	req->cnt = tot;
> +	idx = 0;
> +	for (int i = 0; i < tot; idx++) {
> +		i2idx_map[i] = idx;
> +		req->entry[i++] = fl[idx].mcam_idx[0];
> +		if (fl[idx].uni_di)
> +			continue;
> +
> +		i2idx_map[i] = idx;
> +		req->entry[i++] = fl[idx].mcam_idx[1];
> +	}

[Critical]
With cnt = 256 and all uni_di = 0, would this loop write i2idx_map[0..511]
and req->entry[0..511], corrupting the kernel stack and the adjacent heap
region?  The subsequent read loop then reads rsp->stat[i++] beyond its
256-slot array too.  rvu_mbox_handler_npc_mcam_mul_stats() rejects
req->cnt > 256 later, but the OOB writes happen before that check.
Should the bound be cnt <= 128 (so tot <= 256), or should tot itself be
capped?

[Critical]
Separately, is cnt validated against the wire format?  struct
swdev2af_notify_req embeds struct fl_info fl[64], and
rvu_mbox_handler_swdev2af_notify() forwards req->cnt to this helper
without checking it.  For any 64 < cnt <= 256 the loops here read
fl[64..cnt-1] out of the mailbox payload into adjacent memory, then
propagate those bytes into req->entry[] and back through the mailbox.
Should the guard be cnt < 0 || cnt > ARRAY_SIZE(fl) rather than
cnt > 256 (cnt is a signed int, so negative values also slip through
today)?

> +int rvu_mbox_handler_fl_notify(struct rvu *rvu,
> +			       struct fl_notify_req *req,
> +			       struct msg_rsp *rsp)
>  {
> +	struct fl_entry *fl_entry;
[ ... ]
> +	mutex_lock(&fl_offl_llock);
> +	list_add_tail(&fl_entry->list, &fl_offl_lh);
> +
> +	if (!fl_offl_work_running) {
> +		sw_fl_offl_wq = alloc_workqueue("sw_af_fl_wq", 0, 0);
> +		if (sw_fl_offl_wq)
> +			fl_offl_work_running = true;
> +	}
> +	mutex_unlock(&fl_offl_llock);
> +	queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies(10));
> +
>  	return 0;
>  }

[High]
On the very first invocation, if alloc_workqueue() returns NULL (for
example under memory pressure), fl_offl_work_running stays false and
sw_fl_offl_wq stays NULL, and queue_delayed_work(NULL, ...) is then
dispatched unconditionally after the mutex is dropped.  Does that not
NULL-deref inside __queue_delayed_work()?  Also, fl_entry has already
been list_add_tail'd, so if this path returns early there is nothing to
drain the list, and rvu_sw_fl_shutdown() early-returns on
!sw_fl_offl_wq, so the queued entry looks like it would leak.

> +void rvu_sw_fl_shutdown(void)
> +{
> +	struct sw_fl_stats_node *snode, *tmp;
> +	struct fl_entry *entry;
> +	LIST_HEAD(tlist);
> +
> +	if (!sw_fl_offl_wq)
> +		return;
> +
> +	cancel_delayed_work_sync(&fl_offl_work);
> +	destroy_workqueue(sw_fl_offl_wq);
[ ... ]
> +	mutex_lock(&sw_fl_stats_lock);
> +	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
> +		list_del_init(&snode->list);
> +		kfree(snode);
> +	}
> +	mutex_unlock(&sw_fl_stats_lock);
> +}

[High]
After destroy_workqueue(), sw_fl_offl_wq is not set to NULL and
fl_offl_work_running is not reset.  If a concurrent (or later)
rvu_mbox_handler_fl_notify() runs, it observes fl_offl_work_running ==
true, skips reallocation, and calls queue_delayed_work(sw_fl_offl_wq,
...) on a freed workqueue.  Is that intentional, or should shutdown
clear both under fl_offl_llock so subsequent handlers either reallocate
or bail out?

[Medium]
Also, the early return on !sw_fl_offl_wq skips the cleanup of
sw_fl_stats_lh below.  Nodes on that list are allocated by
rvu_sw_fl_stats_sync2db_one_entry() independently of whether the
offload workqueue ever came up, so on a shutdown where the workqueue
was never allocated they leak.  Would moving the stats-list cleanup
above the early return match the allocation lifetime?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> @@ -4,13 +4,578 @@
[ ... ]
> +static int sw_fl_parse_actions(struct otx2_nic *nic,
[ ... ]
> +		case FLOW_ACTION_CT:
> +			trace_sw_act_dump(__func__, __LINE__, act->id);
> +			err = nf_flow_table_offload_add_cb(act->ct.flow_table,
> +							   sw_fl_setup_ft_block_ingress_cb,
> +							   nic);
> +			if (err != -EEXIST && err) {
> +				netdev_err(nic->netdev,
> +					   "%s:%d Error to offload flow, err=%d\n",
> +					   __func__, __LINE__, err);
> +				break;
> +			}
> +
> +			*op |= BIT_ULL(FLOW_ACTION_CT);
> +			break;

[Medium]
On a CT offload error that is not -EEXIST, the code only prints and
breaks out of the switch without setting the CT bit and without
returning the error.  Processing continues; if any later action sets
*op (for example FLOW_ACTION_REDIRECT), sw_fl_add() sees a non-zero op
that lacks the CT bit, skips the CT early-return, and offloads the
rule as a plain REDIRECT.  Should the error be returned to the caller
so the block callback surfaces it, rather than silently converting a
CT rule into a non-CT one?

> +static int sw_fl_stats(struct otx2_nic *nic, struct flow_cls_offload *f)
> +{
> +	struct fl_get_stats_req *req;
> +	struct fl_get_stats_rsp *rsp;
[ ... ]
> +	rc = otx2_sync_mbox_msg(&nic->mbox);
> +	if (rc)
> +		goto fail;
> +
> +	rsp = (struct fl_get_stats_rsp *)otx2_mbox_get_rsp
> +		(&nic->mbox.mbox, 0, &req->hdr);
> +	pkts_diff = rsp->pkts_diff;

[High]
Is an IS_ERR(rsp) check missing here?  otx2_mbox_get_rsp() returns
ERR_PTR(-ENODEV) on failure, and every other caller in this driver
(cn10k.c, cn10k_macsec.c, otx2_common.c, otx2_tc.c, ...) uses
IS_ERR(rsp) before dereferencing.  Without the check, an error return
here is dereferenced as a valid pointer.

> +static bool init_done;
> +
> +int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
> +				    void *type_data, void *cb_priv)
> +{
> +	struct flow_cls_offload *cls = type_data;
> +	struct otx2_nic *nic = cb_priv;
> +
> +	if (!init_done)
> +		return 0;
[ ... ]
> +}
> +
>  int sw_fl_init(void)
>  {
> +	INIT_WORK(&sw_fl_work, sw_fl_wq_handler);
> +	sw_fl_wq = alloc_workqueue("sw_fl_wq", 0, 0);
> +	if (!sw_fl_wq)
> +		return -ENOMEM;
> +
> +	init_done = true;
>  	return 0;
>  }
>  
>  void sw_fl_deinit(void)
>  {
[ ... ]
> +	cancel_work_sync(&sw_fl_work);
> +	destroy_workqueue(sw_fl_wq);
[ ... ]
>  }

[Medium]
init_done and sw_fl_wq are used together as an ad-hoc gate: the
callback reads init_done as a plain load and then paths off that read
call queue_work(sw_fl_wq, ...).  Since the two stores are plain writes
in sw_fl_init(), can a weakly ordered CPU see init_done == true while
still seeing sw_fl_wq as NULL?  A smp_store_release() / smp_load_acquire()
pair, or moving the flag/wq under a real lock, would remove the
ordering hole.

[High]
Also, sw_fl_deinit() destroys sw_fl_wq without clearing init_done or
NULLing sw_fl_wq.  Since the callback is registered via
nf_flow_table_offload_add_cb() and TC block infrastructure, callbacks
that arrive after deinit will still see init_done == true and can
queue_work() on a freed workqueue.  Is there a missing callback
unregistration step here?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
> @@ -0,0 +1,82 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rvu

[Medium]
The trace system name rvu is already owned by
drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h, which files the
core AF-PF mailbox protocol events (otx2_msg_alloc / otx2_msg_send /
otx2_msg_process) under /sys/kernel/tracing/events/rvu/.  Adding a
second CREATE_TRACE_POINTS site in nic/switch/sw_trace.c under the
same system name mixes these driver-private debug events with the
pre-existing protocol events in user-visible tracefs.  Would a
distinct name (rvu_sw, octeontx2_sw, ...) avoid the collision?

> +TRACE_EVENT(sw_fl_dump,
> +	    TP_PROTO(const char *fname, int line, struct fl_tuple *ftuple),
[ ... ]
> +	    TP_printk("[%s:%d] %pM %pI4:%u to %pM %pI4:%u eth_type=%#x proto=%u uni=%u in=%#x out=%#x",
> +		      __get_str(f), __entry->l, __entry->smac, &__entry->sip, __entry->sport,
[ ... ]
> +);
> +
> +TRACE_EVENT(sw_act_dump,
> +	    TP_PROTO(const char *fname, int line, u32 act),
[ ... ]
> +	    TP_printk("[%s:%d] %u",
> +		      __get_str(fname), __entry->line, __entry->act)
> +);

[Low]
These tracepoints capture __func__ and __LINE__ from the call site and
render them in TP_printk.  Since tracepoint output is treated as
stable ABI (see Documentation/trace/tracepoints.rst), any future
refactor in sw_fl.c will silently change the visible trace output.
Since the events are also EXPORT_TRACEPOINT_SYMBOL'd despite only being
used from this driver, would netdev_dbg / dynamic-debug fit the intent
better than TRACE_EVENT here?
-- 
This is an AI-generated review.


