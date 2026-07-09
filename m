Return-Path: <netdev+bounces-306149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OK94As5yT2rIgwIAu9opvQ
	(envelope-from <netdev+bounces-306149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBE72F5DB
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DrlW+UXL;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306149-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306149-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A44E315E1BF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE9405C4A;
	Thu,  9 Jul 2026 09:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB5406819
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591013; cv=none; b=dCHCvNSxW18qRv7JzLP3ViySvQq6tKqhNpCZCeZcOKZ3cG3YNRt1DXG2v1pRv3i6tHsHhztC4739z/N8hqV+Sc1WIcw9uCpuaDhKur6e/cixWccCJq6DqiqDZqvS2qE+C3tGsPP+CCZAmATS2UchTKKFbJfdR43cLqSLZTx8wKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591013; c=relaxed/simple;
	bh=LsaJa1Hk5cTRf1WrhMI+mjnx6uNaLrbu4ssH4ZYbCcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogDbEccExwr36LmruvIC3rdgwL5fwIcuuN/xvsTxCYmuN46EhSARsrxgoVGRJd8ltry4aL3u6MnhWxSnC5dMcy/3xclsLDdeIVdnaUQJVr9ri7jEJfZ7zjvY57P291NSkySPOWBOf3BYVNmc1AnG6I9dkeBgWu0nMUxh7HVYG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrlW+UXL; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783591008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WGe1lvmO/LMcL+/x7+LWV1+ybFNtFcj2Yh7l5tol/s=;
	b=DrlW+UXLtdvW2wKdsS8BU40BzIb+dmcwVBjW7gTlil8Mf45wWZUs91G+Cl4Ahg7UtP+lMd
	9Masu5g5q1r2UUS0JSvrqpVXLo3pvTMnjlhlOVRAQ6UR6pE7lKnRubsvHJ/4oP08EmDAxi
	NO2HF5DMJQDvP7jg0uxN5PwTkZtTFf0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-ltxvhWyjN7imgyJmUOAuqg-1; Thu,
 09 Jul 2026 05:56:45 -0400
X-MC-Unique: ltxvhWyjN7imgyJmUOAuqg-1
X-Mimecast-MFC-AGG-ID: ltxvhWyjN7imgyJmUOAuqg_1783591004
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BC9B1955E78;
	Thu,  9 Jul 2026 09:56:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 433003652A;
	Thu,  9 Jul 2026 09:56:41 +0000 (UTC)
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
Subject: Re: [PATCH v2 net-next 8/9] octeontx2: offload host FIB updates to switch via AF mailbox
Date: Thu,  9 Jul 2026 11:56:38 +0200
Message-ID: <20260709095638.117394-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-9-rkannoth@marvell.com>
References: <20260702045026.2914748-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306149-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54EBE72F5DB

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2: offload host FIB updates to switch via AF mailbox

This change wires up an IPv4/IPv6 FIB offload path: the switch PF pushes
fib_entry batches to the RVU AF via a fib_notify mbox, and the AF forwards
them back down to the switch PF via a new af2swdev FIB_CMD.  A pair of
workqueues on both ends batch and post the entries.

Some questions follow inline.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 28ebf0a8d3d6..ae6f145a0db0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1968,7 +1968,7 @@ struct af2swdev_notify_req {
>  		};
>  		struct {
>  			u8 cnt;
> -			struct fib_entry entry[16];
> +			struct fib_entry entry[12];
>  		};

[Critical]
Can this shrink cause an out-of-bounds write in
rvu_sw_l3_offl_rule_push()?  The AF-side handler still accepts up to 16
entries per fib_notify:

    if (req->cnt > 16)
        return -EINVAL;

and the batching guard in sw_l3_offl_work_handler()

    if (lcnt + l3_entry->cnt > 8 && !list_empty(&l3_local_lh))

only splits when the local list is already non-empty, so the first
l3_entry in a batch is always accepted regardless of its cnt.  A single
fib_notify with cnt in [13,16] therefore reaches

    memcpy(dst, entry, sizeof(*entry) * cnt);

writing up to 16 struct fib_entry into req->entry[12], and overflows the
mbox message by 1..4 entries (roughly 60..240 bytes) into adjacent mbox
memory.

Also, req->cnt is a u8 while tot_cnt is int, so any total that batches
past 255 would silently truncate on the assignment

    req->cnt = tot_cnt;

Would it be clearer to either raise entry[] back to 16, cap fib_notify at
12, or clamp/split at the memcpy site with tot_cnt validated against a
u8?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
> index 2b798d5f0644..bd4ec3b20d4a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c

[ ... ]

> +static struct workqueue_struct *sw_l3_offl_wq;
> +
> +struct l3_entry {
> +	struct list_head list;
> +	struct rvu *rvu;
> +	u32 port_id;
> +	int cnt;
> +	struct fib_entry entry[];
> +};
> +
> +static DEFINE_MUTEX(l3_offl_llock);
> +static LIST_HEAD(l3_offl_lh);
> +static bool l3_offl_work_running;
> +
> +static struct workqueue_struct *sw_l3_offl_wq;

[Low]
Is the second declaration of sw_l3_offl_wq intentional?  It appears once
above the struct l3_entry definition and again immediately after, so the
translation unit has two tentative definitions of the same object.

> +static void sw_l3_offl_work_handler(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(l3_offl_work, sw_l3_offl_work_handler);
> +
> +static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
> +{

[ ... ]

> +	dst = &req->entry[0];
> +	while ((l3_entry =
> +		list_first_entry_or_null(lh,
> +					 struct l3_entry, list)) != NULL) {
> +		entry = l3_entry->entry;
> +		cnt = l3_entry->cnt;
> +		sz = sizeof(*entry) * cnt;
> +
> +		memcpy(dst, entry, sz);
> +		tot_cnt += cnt;
> +		dst += cnt;
> +
> +		list_del_init(&l3_entry->list);
> +		kfree(l3_entry);
> +	}
> +	req->flags = FIB_CMD;
> +	req->cnt = tot_cnt;
> +
> +	rc = otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +	if (rc)
> +		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +
> +	mutex_unlock(&rvu->mbox_lock);
> +	return rc ? 0 : -EFAULT;
> +}

[High]
When otx2_mbox_wait_for_zero() returns false (mbox still busy after the
~1ms wait), otx2_mbox_msg_send_up() is skipped but the loop above has
already drained every l3_entry from lh and kfree()d them.

Does this silently drop the batch?  The allocated mbox message is left
dangling in the up-channel, the fib_entry payload has been freed, and
the caller only logs pr_err() without any re-queue, so the switch state
appears to permanently diverge from the host FIB whenever the mbox is
momentarily busy.

> +static atomic64_t req_cnt;
> +static atomic64_t ack_cnt;
> +static atomic64_t req_processed;
> +static LIST_HEAD(l3_local_lh);
> +static int lcnt;
> +
> +static void sw_l3_offl_work_handler(struct work_struct *work)
> +{
> +	struct l3_entry *l3_entry;
> +	struct list_head l3lh;
> +	u64 req, ack, proc;
> +
> +	INIT_LIST_HEAD(&l3lh);
> +
> +	mutex_lock(&l3_offl_llock);
> +	while (1) {
> +		l3_entry = list_first_entry_or_null(&l3_offl_lh, struct l3_entry, list);
> +
> +		if (!l3_entry)
> +			break;
> +
> +		if (lcnt + l3_entry->cnt > 8 && !list_empty(&l3_local_lh)) {
> +			req = atomic64_read(&req_cnt);
> +			atomic64_set(&ack_cnt, req);
> +			atomic64_set(&req_processed, req);
> +			mutex_unlock(&l3_offl_llock);
> +			goto process;
> +		}
> +
> +		lcnt += l3_entry->cnt;
> +
> +		atomic64_inc(&req_cnt);
> +		list_del_init(&l3_entry->list);
> +		list_add_tail(&l3_entry->list, &l3_local_lh);
> +	}
> +	mutex_unlock(&l3_offl_llock);
> +
> +	req = atomic64_read(&req_cnt);
> +	ack = atomic64_read(&ack_cnt);
> +
> +	if (req > ack) {
> +		atomic64_set(&ack_cnt, req);
> +		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
> +				   msecs_to_jiffies(100));
> +		return;
> +	}
> +
> +	proc = atomic64_read(&req_processed);
> +	if (req == proc) {
> +		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
> +				   msecs_to_jiffies(1000));
> +		return;
> +	}
> +
> +	atomic64_set(&req_processed, req);

[Medium]
Do req_cnt, ack_cnt, and req_processed model any real acknowledgement
protocol?  They are only ever written from inside this function and
neither otx2_mbox_wait_for_zero() nor otx2_mbox_msg_send_up() touches
them, so the (req > ack) branch effectively only ever fires on the first
invocation after new entries arrive and then

    atomic64_set(&ack_cnt, req);

immediately equalizes them.  Would this be clearer as a plain "if new
work arrived, re-poll shortly, otherwise poll slowly" without the ack
counters?

[Medium]
Do the two early-return branches leak the entries parked in l3_local_lh?

The while loop above moves items from l3_offl_lh into the module-static
l3_local_lh, and then both

    if (req > ack) { ... return; }
    if (req == proc) { ... return; }

return without splicing l3_local_lh into l3lh for processing.  If
rvu_sw_l3_shutdown() then runs, it only drains l3_offl_lh:

    while (1) {
        entry = list_first_entry_or_null(&l3_offl_lh,
                                         struct l3_entry, list);

so entries parked in l3_local_lh remain allocated.  Would it be safer to
splice l3_local_lh back into l3_offl_lh before returning, or drain both
lists in the shutdown path?

> +
> +process:
> +	lcnt = 0;

[ ... ]

> +int rvu_mbox_handler_fib_notify(struct rvu *rvu,
>  				struct fib_notify_req *req,
>  				struct msg_rsp *rsp)
>  {
> +	struct l3_entry *l3_entry;
> +	int sz;
> +
> +	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
> +		return 0;

[High]
Should this return an error instead of 0 when firmware is not ready?
Returning 0 tells the caller the update was accepted, but nothing is
buffered or resynced later, so any FIB event that arrives during the
pre-ready window is silently dropped.  Because FIB deltas are
edge-triggered, a single missed add/del leaves the offload permanently
divergent from the host FIB with no user-visible signal.

> +
> +	if (req->cnt > 16)
> +		return -EINVAL;
> +
> +	sz = req->cnt * sizeof(struct fib_entry);
> +
> +	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
> +	if (!l3_entry)
> +		return -ENOMEM;
> +
> +	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
> +	l3_entry->rvu = rvu;
> +	l3_entry->cnt = req->cnt;
> +	INIT_LIST_HEAD(&l3_entry->list);
> +	memcpy(l3_entry->entry, req->entry, sz);
> +
> +	mutex_lock(&l3_offl_llock);
> +	list_add_tail(&l3_entry->list, &l3_offl_lh);
> +	mutex_unlock(&l3_offl_llock);
> +
> +	if (!l3_offl_work_running) {
> +		sw_l3_offl_wq = alloc_workqueue("sw_af_fib_wq", 0, 0);
> +		l3_offl_work_running = true;
> +		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
> +				   msecs_to_jiffies(1000));
> +	}
> +
>  	return 0;
>  }

[High]
Is the return value of alloc_workqueue() handled anywhere?  Under memory
pressure it can return NULL and queue_delayed_work() will then
dereference a NULL pool.  Additionally l3_offl_work_running is set to
true unconditionally, so on the next invocation the branch is skipped
and every future fib_notify piles a new l3_entry onto l3_offl_lh with
no worker to drain it.

[High]
Is this check-then-set race-safe?  It runs outside l3_offl_llock, and
mbox handlers can dispatch from separate PF worker contexts.  Two
concurrent invocations can both observe l3_offl_work_running == false,
both call alloc_workqueue(), and one of the pointers is then overwritten
into sw_l3_offl_wq while the other workqueue leaks along with any
delayed work already queued on it.

Related: rvu_sw_l3_shutdown() destroys sw_l3_offl_wq but does not clear
sw_l3_offl_wq to NULL or reset l3_offl_work_running:

> +void rvu_sw_l3_shutdown(void)
> +{
> +	struct l3_entry *entry;
> +	LIST_HEAD(tlist);
> +
> +	if (!sw_l3_offl_wq)
> +		return;
> +
> +	cancel_delayed_work_sync(&l3_offl_work);
> +	destroy_workqueue(sw_l3_offl_wq);
> +
> +	mutex_lock(&l3_offl_llock);
> +	while (1) {
> +		entry = list_first_entry_or_null(&l3_offl_lh,
> +						 struct l3_entry, list);
> +		if (!entry)
> +			break;
> +
> +		list_del_init(&entry->list);
> +		kfree(entry);
> +	}
> +	mutex_unlock(&l3_offl_llock);
> +}

After shutdown, if rvu_mbox_handler_fib_notify() runs again it sees
l3_offl_work_running still true and calls queue_delayed_work() on the
destroyed workqueue.  Would it help to move the workqueue lifetime to
subsystem init/deinit (like rvu_sw_l2) and always clear both pieces of
state here?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
> index 12ddf8119372..54b854aa7ffa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c

[ ... ]

> +static void sw_fib_work_handler(struct work_struct *work)
> +{
> +	struct sw_fib_list_entry *lentry;
> +	LIST_HEAD(tlist);
> +
> +	spin_lock_bh(&sw_fib_llock);
> +	list_splice_init(&sw_fib_lh, &tlist);
> +	spin_unlock_bh(&sw_fib_llock);
> +
> +	while ((lentry =
> +		list_first_entry_or_null(&tlist,
> +					 struct sw_fib_list_entry, lh)) != NULL) {
> +		list_del_init(&lentry->lh);
> +		sw_fib_notify(lentry->pf, lentry->cnt, lentry->entry);
> +		kfree(lentry->entry);
> +		kfree(lentry);
> +	}

[High]
Should the return value of sw_fib_notify() be checked?  It can fail via
cnt > 16 returning -EINVAL, mbox alloc returning -ENOMEM, or
otx2_sync_mbox_msg() transport failure, and all three paths simply drop
the FIB delta with no retry and no diagnostic.  Because FIB updates are
edge-triggered, a single lost message leaves the switch state
permanently out of sync.

> +
> +	spin_lock_bh(&sw_fib_llock);
> +	if (!list_empty(&sw_fib_lh))
> +		queue_delayed_work(sw_fib_wq, &sw_fib_work,
> +				   msecs_to_jiffies(10));
> +	spin_unlock_bh(&sw_fib_llock);
> +}
> +
> +int sw_fib_add_to_list(struct net_device *dev,
> +		       struct fib_entry *entry, int cnt)
> +{
> +	struct otx2_nic *pf = netdev_priv(dev);
> +	struct sw_fib_list_entry *lentry;
> +
> +	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
> +	if (!lentry)
> +		return -ENOMEM;

[High]
Does this leak the caller's entry on ENOMEM?  Every call site in this
patch (sw_nb_v4_netdev_event, sw_nb_v4_inetaddr_event,
sw_nb_v4_fib_event x2, sw_nb_net_v4_neigh_update, sw_nb_v6_netdev_event,
sw_nb_v6_fib_event, sw_nb_net_v6_neigh_update, sw_nb_v6_inetaddr_event)
hands ownership of the entry to this function and drops the reference:

    -   kfree(entry);
    +   sw_fib_add_to_list(pf_dev, entry, 1);

The return value is ignored in every caller, so on GFP_ATOMIC failure
the fib_entry buffer is stranded.  Would it make sense to kfree(entry)
on the error path (or take ownership only after the lentry allocation
succeeds)?

[Medium]
Is there a cnt upper bound?  sw_fib_notify() rejects cnt > 16 but
sw_fib_add_to_list() does not, and sw_nb_v4_fib_event() computes

    cnt = iter - entries;

bounded by fi->fib_nhs.  For multipath configurations with more than 16
next-hops the entry is happily queued and then silently discarded inside
the worker.  Should the notifier either split the batch or refuse early
so the sender can adjust?

> +
> +	lentry->pf = pf;
> +	lentry->cnt = cnt;
> +	lentry->entry = entry;
> +	INIT_LIST_HEAD(&lentry->lh);
> +
> +	spin_lock(&sw_fib_llock);
> +	list_add_tail(&lentry->lh, &sw_fib_lh);
> +	queue_delayed_work(sw_fib_wq, &sw_fib_work,
> +			   msecs_to_jiffies(10));
> +	spin_unlock(&sw_fib_llock);
> +
> +	return 0;
> +}

[High]
Is sw_fib_llock protected against softirq reentry here?  This function
uses plain spin_lock()/spin_unlock() but sw_fib_work_handler() and
sw_fib_deinit() both acquire the same lock with spin_lock_bh().

sw_nb_net_v4_neigh_update() and sw_nb_net_v6_neigh_update() are called
from the netevent chain, which the neighbour subsystem can invoke in
softirq context (e.g., from __neigh_update() paths driven by RX
processing).  If CPU X is holding sw_fib_llock via spin_lock() in
process context and a softirq on the same CPU reaches
sw_fib_add_to_list() as well, the softirq spins waiting on a lock that
only its preempted process context can release.

Would spin_lock_bh() be more appropriate here?

[ ... ]

> +void sw_fib_deinit(void)
>  {
> +	struct sw_fib_list_entry *lentry;
> +	LIST_HEAD(tlist);
> +
> +	cancel_delayed_work_sync(&sw_fib_work);
> +	destroy_workqueue(sw_fib_wq);
> +
> +	spin_lock_bh(&sw_fib_llock);
> +	list_splice_init(&sw_fib_lh, &tlist);
> +	spin_unlock_bh(&sw_fib_llock);
> +
> +	while ((lentry =
> +		list_first_entry_or_null(&tlist,
> +					 struct sw_fib_list_entry, lh)) != NULL) {
> +		list_del_init(&lentry->lh);
> +		kfree(lentry->entry);
> +		kfree(lentry);
> +	}
>  }

[High]
Is there anything in this module that prevents sw_fib_add_to_list() from
being called during or after sw_fib_deinit()?  The current caller order
in sw_nb_unregister() unregisters notifiers first, but sw_fib.c has no
self-contained shutdown flag or nulling of sw_fib_wq.  A stray notifier
callback that reaches sw_fib_add_to_list() after destroy_workqueue()
would call queue_delayed_work() on a freed workqueue pointer.  Would
setting sw_fib_wq to NULL under the lock and checking it in
sw_fib_add_to_list() be robust against future ordering changes?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> index 99b8b9fdfe8a..61f0ed26adfd 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> @@ -301,11 +305,9 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
>  	if (idev)
>  		sw_nb_v4_netdev_event(unused, event, ptr);
>  
> -#if IS_ENABLED(CONFIG_IPV6)
>  	i6dev = __in6_dev_get(dev);
>  	if (i6dev)
>  		sw_nb_v6_netdev_event(unused, event, ptr);
> -#endif
>  
>  	return NOTIFY_DONE;
>  }

[High]
Does this drop the guard on the wrong caller?  The other callers of the
v6 helpers in this file (register/unregister, sw_nb_v6_fib_event,
sw_nb_v6_inetaddr_event dispatch, netevent v6 dispatch) still sit under
their own IS_ENABLED(CONFIG_IPV6) blocks, and drivers/net/ethernet/
marvell/octeontx2/nic/Makefile only compiles sw_nb_v6.o under

    ifdef CONFIG_IPV6

so sw_nb_v6.c's body is wrapped in the same #if.  On
CONFIG_OCTEONTX_SWITCH=y with CONFIG_IPV6=n, Kconfig does not select or
depend on IPV6, so the reference to sw_nb_v6_netdev_event() would remain
in the object file with no definition to link against.  Should this
guard be restored, or should sw_nb_v6.h grow a static inline stub for
!CONFIG_IPV6?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> index 947dafe586a0..8fd02edaa90e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> @@ -134,7 +134,7 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
>  	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
>  		   __func__, entry->dst, entry->mac, dev->name);
>  
> -	kfree(entry);
> +	sw_fib_add_to_list(pf_dev, entry, 1);
>  	return NOTIFY_DONE;
>  }

[High]
Not introduced by this patch, but the switch to sw_fib_add_to_list()
lengthens the exposure of a pre-existing kcalloc(GFP_ATOMIC) that is
never NULL-checked:

    entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
    entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);

Previously a NULL entry crashed here at the immediate dereference;
now the pointer also gets stored in a work item.  The same pattern
exists in sw_nb_net_v4_neigh_update(), sw_nb_v6_netdev_event()
(GFP_KERNEL), sw_nb_net_v6_neigh_update(), and
sw_nb_v6_inetaddr_event().  Could the NULL checks be added while
touching these paths?
-- 
This is an AI-generated review.


