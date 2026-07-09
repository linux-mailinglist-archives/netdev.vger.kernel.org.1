Return-Path: <netdev+bounces-306148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ubXAEMJxT2pkgwIAu9opvQ
	(envelope-from <netdev+bounces-306148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18E72F478
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:02:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=D5vvyizJ;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306148-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306148-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B1730D3403
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7C405C3B;
	Thu,  9 Jul 2026 09:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1A404891
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591004; cv=none; b=A4+kRNRSoVOp9TmeRLMKYDUBHRqiSHlA5MoS4AvP/x44Z6X/3KTFvw1Vqz8tY168C09qIc+3CO8sPL4u53Iy4lA6y0tnyGEMK78p/JrnhX1xdem2HR3tQs4His0fxInCOxbQ0QJhMukONoQI+3MDwhbWHU+Dza0kCetX4NA6Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591004; c=relaxed/simple;
	bh=5WcIL3cSWUpEZDU38DoQZvGGTr/bqktkg71hqCML7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JovZMOVP6DKWo1BMS2PUpnepUrMdSRQWv/xVs80PPUBiSDS/8b/L2nrC2RIazq1yscfuX54/Gx5wSWRAYtoGGKY54/5tnA8FMvSrMVCYgyzDCTpkRaXNDQBW5IOSOQ+wzKZlgR4aJMa3vT4Oi2O2Y5alXHp8aqDULNA92NzFEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5vvyizJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783591001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEcwmO2/t6yqPq3tkOqxY2nILck2Co7QdnedvxZZKy0=;
	b=D5vvyizJINqcaDKhPXXheGZEnMRqe9KkZPr6N7PAfgWc5O3Km+3OulObiqsiankrbogE2D
	cbeJC1FuXsIpbqOsEMu2iJDhWWYuttLr3OQyZNoBAW1HzBfmfdlNBHMkENSkRLE3W8hUDw
	8v2O4JJTA8tLqb+FceiP2rAOJqj3DfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-GiVM470nOomFAa5XCbdqyA-1; Thu,
 09 Jul 2026 05:56:40 -0400
X-MC-Unique: GiVM470nOomFAa5XCbdqyA-1
X-Mimecast-MFC-AGG-ID: GiVM470nOomFAa5XCbdqyA_1783590998
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0B161955F41;
	Thu,  9 Jul 2026 09:56:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B86513652A;
	Thu,  9 Jul 2026 09:56:35 +0000 (UTC)
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
Subject: Re: [PATCH v2 net-next 7/9] octeontx2: plumb bridge FDB updates through AF and switchdev
Date: Thu,  9 Jul 2026 11:56:31 +0200
Message-ID: <20260709095633.117381-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-8-rkannoth@marvell.com>
References: <20260702045026.2914748-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,info.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F18E72F478

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2: plumb bridge FDB updates through AF and switchdev

This patch wires switchdev FDB add/delete notifications on the PF into
mailbox fdb_notify messages toward the AF, adds an AF worker to push L2
rules to the switchdev firmware, and introduces a new AF-to-PF/VF
MBOX_MSG_AF2PF_FDB_REFRESH message that ends up calling
call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE, ...) on the target.

A few questions inline below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 6e10a58a0421..0f751555338e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

> @@ -2579,6 +2580,7 @@ static void __rvu_mbox_up_handler(struct rvu_work *mwork, int type)
>  
>  		switch (msg->id) {
>  		case MBOX_MSG_CGX_LINK_EVENT:
> +		case MBOX_MSG_AF2PF_FDB_REFRESH:
>  			break;
>  		default:
>  			if (msg->rc)

[Medium]
Adding MBOX_MSG_AF2PF_FDB_REFRESH to the same case as MBOX_MSG_CGX_LINK_EVENT
suppresses the msg->rc check.  If the PF returns a non-zero rc for
AF2PF_FDB_REFRESH (for example MBOX_MSG_INVALID, see the next comment about
PF-side dispatch), is the intent to silently swallow it here or would it
be preferable to log it like every other message?

> @@ -3821,6 +3823,8 @@ static void rvu_remove(struct pci_dev *pdev)
>  {
>  	struct rvu *rvu = pci_get_drvdata(pdev);
>  
> +	rvu_sw_shutdown();
> +
>  	rvu_dbg_exit(rvu);
>  	rvu_unregister_dl(rvu);
>  	rvu_unregister_interrupts(rvu);

[High]
rvu_sw_shutdown() runs at the top of rvu_remove(), well before
rvu_mbox_destroy(&rvu->afpf_wq_info).  While rvu_sw_l2_shutdown() does
cancel_work_sync() and destroy_workqueue() on both workqueues, it never
clears RVU_SWITCH_FLAG_FW_READY, never nulls the file-static
rvu_sw_l2_offl_wq / fdb_refresh_wq pointers, and does not stop new mbox
handlers from producing.

Can this race happen?

  CPU0 (rvu_remove)                  CPU1 (afpf mbox worker)
    rvu_sw_l2_shutdown()
      cancel_work_sync(&fdb_...)
      destroy_workqueue(fdb_refresh_wq)  /* wq freed */
                                       rvu_mbox_handler_fdb_notify()
                                         if (flags & FW_READY) /* still set */
                                         queue_work(rvu_sw_l2_offl_wq, ...);
                                                     /* UAF on freed wq */

Should the shutdown order be inverted (tear down mbox producers first, or
clear FW_READY under a lock that mbox handlers observe, then flush and
destroy the workqueues, then null the pointers)?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> index 28f8281e9219..6fc13aeff45f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c

[ ... ]

> @@ -26,5 +28,22 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
>  				     struct swdev2af_notify_req *req,
>  				     struct msg_rsp *rsp)
>  {
> -	return 0;
> +	int rc = 0;
> +
> +	switch (req->msg_type) {
> +	case SWDEV2AF_MSG_TYPE_FW_STATUS:
> +		rc = rvu_sw_l2_init_offl_wq(rvu, req->pcifunc, req->fw_up);
> +		break;
> +
> +	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
> +		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
> +		break;
> +	}
> +
> +	return rc;
> +}

[High]
Is there a reason this handler accepts SWDEV2AF messages from any pcifunc?
There is no is_cgx_config_permitted() style check that the sender is the
trusted switch-firmware PF.

The FW_STATUS path stores the caller-supplied req->pcifunc into
rvu->rswitch.pcifunc, and the REFRESH_FDB path forwards a caller-controlled
(pcifunc, mac) tuple to any PF via AF2PF_FDB_REFRESH — which ends up
invoking call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE, ...) on the
target PF's netdev.

In an SR-IOV deployment, does this allow any VF to inject arbitrary
MAC->port entries into another tenant's bridge, or hijack the switch-firmware
identity by sending FW_STATUS(fw_up=true) with its own pcifunc?

[Medium]
The switch has no default: arm.  SWDEV2AF_MSG_TYPE_REFRESH_FL is already
defined as BIT_ULL(2) but has no case here, so REFRESH_FL messages return
rc = 0 with no side effect and no diagnostic.  Would returning
-EOPNOTSUPP / -EINVAL for unknown msg_type values make version-mismatch
issues visible?

[Low]
Also, since the SWDEV2AF_MSG_TYPE_* values are BIT_ULL(0), BIT_ULL(1),
BIT_ULL(2), the switch-equality only matches when exactly one bit is set.
Is msg_type intended to be a bitmask (in which case case labels won't
combine) or a plain enum (in which case using BIT_ULL() as the values is
misleading)?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
> index 5f805bfa81ed..bd0fe13b1fc9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c

[ ... ]

> +/* Work queue for switchdev message handling. There is only
> + * on switch HW per SoC, so one instance of each type of
> + * workqueue is enough.
> + */
> +static struct rvu_sw_l2_work l2_offl_work;
> +static struct workqueue_struct *rvu_sw_l2_offl_wq;

[Low]
Nit: "There is only on switch HW" is missing the word "one".

[ ... ]

> +static int rvu_sw_l2_fdb_refresh(struct rvu *rvu, u16 pcifunc, u8 *mac)
> +{
> +	struct af2pf_fdb_refresh_req *req;
> +	int pf, vidx;
> +
> +	pf = rvu_get_pf(rvu->pdev, pcifunc);
> +
> +	mutex_lock(&rvu->mbox_lock);
> +
> +	if (pf) {
> +		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);
> +		if (!req) {
> +			mutex_unlock(&rvu->mbox_lock);
> +			return -ENOMEM;
> +		}
> +
> +		req->hdr.pcifunc = pcifunc;
> +		ether_addr_copy(req->mac, mac);
> +		req->pcifunc = pcifunc;
> +
> +		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
> +		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
> +	} else {
> +		vidx = pcifunc - 1;
> +
> +		req = (struct af2pf_fdb_refresh_req *)
> +			otx2_mbox_alloc_msg_rsp(&rvu->afvf_wq_info.mbox_up, vidx,
> +						sizeof(*req), sizeof(struct msg_rsp));

[Critical]
Where is the bounds check on pcifunc / vidx?  pcifunc originates from
req->pcifunc of the peer-sent swdev2af_notify_req and reaches here verbatim
via rvu_sw_l2_fdb_list_entry_add() -> l2_entry->port_id.

In the else branch, when rvu_get_pf(rvu->pdev, pcifunc) == 0:

    vidx = pcifunc - 1;
    otx2_mbox_alloc_msg_rsp(&rvu->afvf_wq_info.mbox_up, vidx, ...);

If a peer sends REFRESH_FDB with pcifunc == 0, vidx becomes -1 and
otx2_mbox_alloc_msg_rsp() does:

    struct otx2_mbox_dev *mdev = &mbox->dev[devid];
    spin_lock(&mdev->mbox_lock);

which is an out-of-bounds access on mbox->dev[-1] followed by
otx2_mbox_wait_for_zero() / otx2_mbox_msg_send_up() dereferencing the
same address.

Similarly in the if branch, pf is used as devid for
rvu->afpf_wq_info.mbox_up without checking pf < afpf_wq_info.mbox_up.ndevs.

Would something like is_pf_func_valid() or an explicit ndevs range check
before dispatching the message be needed here?

[ ... ]

> +static bool fw_is_up;
> +
> +int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
> +{
> +	struct rvu_switch *rswitch;
> +
> +	rswitch = &rvu->rswitch;
> +
> +	if (fw_up && !fw_is_up) {
> +		/* Switch HW sends an MBOX message to Host once it is ready */
> +		rswitch->pcifunc = pcifunc;
> +		fw_is_up = true;
> +
> +		l2_offl_work.rvu = rvu;
> +		INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
> +		rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
> +		if (!rvu_sw_l2_offl_wq) {
> +			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		fdb_refresh_work.rvu = rvu;
> +		INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
> +		fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresg_wq", 0, 0);
> +		if (!fdb_refresh_wq) {
> +			dev_err(rvu->dev, "fdb refresh workqueue allocation failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
> +		return 0;
> +	}
> +
> +	rswitch->flags &= ~RVU_SWITCH_FLAG_FW_READY;
> +	flush_work(&l2_offl_work.work);
> +	rswitch->pcifunc = -1;
> +	return 0;
> +}

[High]
Where does fw_is_up ever get reset back to false?  It is never cleared —
not on fw_up=false, not on rvu_sw_l2_shutdown(), not on the -ENOMEM
paths above.

Consequences:

    1. A firmware bounce (up -> down -> up) enters the second fw_up=true
       message with fw_is_up already true.  The guard fails, and the
       else tail runs instead — actively clearing FW_READY,
       flush_work()ing, and setting rswitch->pcifunc = -1.

    2. Any fw_up=false event after init permanently disables offload,
       since fw_up=true never re-enters the allocation branch.

    3. rswitch->pcifunc is u16 and is assigned -1, which becomes 0xFFFF,
       then flows back into rvu_get_pf() as a bogus PF index used as
       an mbox devid.

Should fw_is_up be cleared on fw_up=false and on shutdown?

[High]
On the second alloc_workqueue failing while the first has succeeded,
this returns -ENOMEM without destroying rvu_sw_l2_offl_wq.  Because
fw_is_up was set to true a few lines earlier, no subsequent FW_STATUS
message can retry the init.  Additionally, rvu_sw_l2_shutdown() begins
with:

    if (!fdb_refresh_wq)
        return;

so if the driver ends up in this partial-init state, shutdown does
nothing and rvu_sw_l2_offl_wq (with a live worker kthread) leaks for
the module lifetime.

Could the error path destroy_workqueue(rvu_sw_l2_offl_wq), NULL the
pointer, and clear fw_is_up before returning?

[Medium]
The tail unconditionally runs:

    flush_work(&l2_offl_work.work);

but INIT_WORK(&l2_offl_work.work, ...) only runs inside the if (fw_up &&
!fw_is_up) branch.  If the very first swdev2af message received is
FW_STATUS(fw_up=false) — or any message that misses the init branch —
the work_struct is still BSS-zero-initialized when flush_work runs.
__flush_work() does WARN_ON(!work->func).  Is that intended?

[Low]
Also, is the workqueue name "swdev_fdb_refresg_wq" a typo of "refresh"?
The name shows up in /proc/ and worker thread names.

[ ... ]

> +int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac)
> +{
> +	struct l2_entry *l2_entry;
> +
> +	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
> +	if (!l2_entry)
> +		return -ENOMEM;
> +
> +	l2_entry->port_id = pcifunc;
> +	ether_addr_copy(l2_entry->mac, mac);
> +
> +	mutex_lock(&fdb_refresh_list_lock);
> +	list_add_tail(&l2_entry->list, &fdb_refresh_lh);
> +	mutex_unlock(&fdb_refresh_list_lock);
> +
> +	queue_work(fdb_refresh_wq, &fdb_refresh_work.work);
> +	return 0;
> +}

[High]
This handler is reachable directly from rvu_mbox_handler_swdev2af_notify()
via SWDEV2AF_MSG_TYPE_REFRESH_FDB, and it does not check
RVU_SWITCH_FLAG_FW_READY or that fdb_refresh_wq is non-NULL (the sibling
rvu_mbox_handler_fdb_notify() below does check FW_READY).

If a peer sends REFRESH_FDB before any FW_STATUS(fw_up=true), fdb_refresh_wq
is still NULL and queue_work(NULL, ...) reaches __queue_work() which
dereferences wq->flags.  Is the mbox ordering guaranteed by some external
mechanism, or should this path also gate on FW_READY / a non-NULL wq?

[Medium]
This function allocates and appends unconditionally on every incoming
REFRESH_FDB message, with no cap on list length or per-caller quota.
Combined with the identical pattern in rvu_mbox_handler_fdb_notify()
below, can a peer that sends messages faster than the workqueue drains
them drive unbounded kernel memory allocation until OOM?  The workqueue
handler processes only 16 entries per invocation before re-queueing under
a mutex + mbox send + wait.

[ ... ]

>  int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
>  				struct fdb_notify_req *req,
>  				struct msg_rsp *rsp)
>  {
> +	struct l2_entry *l2_entry;
> +
> +	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
> +		return 0;
> +
> +	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
> +	if (!l2_entry)
> +		return -ENOMEM;
> +
> +	l2_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
> +	ether_addr_copy(l2_entry->mac, req->mac);
> +	l2_entry->flags = req->flags;
> +
> +	mutex_lock(&l2_offl_list_lock);
> +	list_add_tail(&l2_entry->list, &l2_offl_lh);
> +	mutex_unlock(&l2_offl_list_lock);
> +
> +	queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
> +
>  	return 0;
>  }

[High]
Is the RVU_SWITCH_FLAG_FW_READY check safe against concurrent teardown?
The flag is read here, several statements happen (kcalloc, list mutex
acquire/release), and then queue_work() runs.  Between the check and
queue_work(), another thread running rvu_sw_l2_init_offl_wq(fw_up=false)
or rvu_sw_shutdown() can clear the flag and destroy rvu_sw_l2_offl_wq,
leaving queue_work() to touch a freed workqueue.

An ad-hoc flag check without a covering lock (or RCU with
synchronize_rcu() before destroy_workqueue()) does not provide
synchronization.  How is this expected to work?

> +void rvu_sw_l2_shutdown(void)
> +{
> +	struct l2_entry *entry;
> +	LIST_HEAD(tlist);
> +
> +	if (!fdb_refresh_wq)
> +		return;
> +
> +	cancel_work_sync(&fdb_refresh_work.work);
> +	destroy_workqueue(fdb_refresh_wq);
> +
> +	mutex_lock(&fdb_refresh_list_lock);
> +	while (1) {
> +		entry = list_first_entry_or_null(&fdb_refresh_lh,
> +						 struct l2_entry, list);
> +		if (!entry)
> +			break;
> +
> +		list_del_init(&entry->list);
> +		kfree(entry);
> +	}
> +	mutex_unlock(&fdb_refresh_list_lock);
> +
> +	cancel_work_sync(&l2_offl_work.work);
> +	destroy_workqueue(rvu_sw_l2_offl_wq);

[High]
cancel_work_sync() only cancels currently-pending work; it does not stop
new invocations.  Because RVU_SWITCH_FLAG_FW_READY is not cleared here,
rvu_mbox_handler_fdb_notify() can still pass its FW_READY check and call
queue_work(rvu_sw_l2_offl_wq, ...) after this destroy_workqueue().  Also,
rvu_sw_l2_fdb_list_entry_add() has no FW_READY guard at all.

Should the FW_READY flag be cleared (and the mbox handlers taught to see
that) before cancel_work_sync + destroy_workqueue, and should the two
global workqueue pointers be nulled at the end so the shutdown guard
"if (!fdb_refresh_wq) return;" actually distinguishes torn-down from
initialized?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index b022f52c6845..4540ffacdddc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c

[ ... ]

> @@ -141,6 +142,22 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
>  		err = otx2_mbox_up_handler_cgx_link_event(
>  				vf, (struct cgx_link_info_msg *)req, rsp);
>  		return err;
> +
> +	case MBOX_MSG_AF2PF_FDB_REFRESH:
> +		rsp = (struct msg_rsp *)otx2_mbox_alloc_msg(&vf->mbox.mbox_up, 0,
> +							    sizeof(struct msg_rsp));
> +		if (!rsp)
> +			return -ENOMEM;
> +
> +		rsp->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
> +		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
> +		rsp->hdr.pcifunc = req->pcifunc;
> +		rsp->hdr.rc = 0;
> +		err = otx2_mbox_up_handler_af2pf_fdb_refresh(vf,
> +							     (struct af2pf_fdb_refresh_req *)req,
> +							     rsp);
> +		return err;
> +

[High]
The AF-to-PF path is wired only in otx2_vf.c.  Is the PF-side dispatcher
(otx2_process_mbox_msg_up() in nic/otx2_pf.c) updated in a companion patch?
Grepping this tree, otx2_pf.c's switch expands MBOX_UP_CGX_MESSAGES,
MBOX_UP_MCS_MESSAGES and MBOX_UP_REP_MESSAGES, but not
MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES.  When rvu_sw_l2_fdb_refresh() takes
its if (pf) branch and sends AF2PF_FDB_REFRESH over afpf_wq_info.mbox_up,
the receiving PF hits the default: arm and calls
otx2_reply_invalid_msg(), so the SWITCHDEV_FDB_ADD_TO_BRIDGE notifier is
never invoked on PF netdevs.

Since bridges are typically hosted on PF netdevs, this seems to defeat
the "invoke the switchdev notifier so the host bridge can learn the
updated FDB entry" goal from the commit message for the PF case.

[Medium]
Looking at struct af2pf_fdb_refresh_req, there is only pcifunc + mac[6]
— no flags — and otx2_mbox_up_handler_af2pf_fdb_refresh() hardcodes
SWITCHDEV_FDB_ADD_TO_BRIDGE.  The downstream fdb_notify direction carries
FDB_ADD/FDB_DEL bits in req->flags, but the upstream refresh direction
can only add.  If firmware ages an entry out, how does the host bridge
learn to delete it — is a delete-refresh planned, and if so should the
mailbox structure grow a flags field now to avoid an ABI change later?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> index 6842c8d91ffc..327a6efeb526 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c

[ ... ]

> +static DEFINE_SPINLOCK(sw_fdb_llock);
> +static LIST_HEAD(sw_fdb_lh);

[ ... ]

> +static void sw_fdb_wq_handler(struct work_struct *work)
> +{
> +	struct sw_fdb_list_entry *entry;
> +	LIST_HEAD(tlist);
> +
> +	spin_lock(&sw_fdb_llock);
> +	list_splice_init(&sw_fdb_lh, &tlist);
> +	spin_unlock(&sw_fdb_llock);

[ ... ]

> +	spin_lock(&sw_fdb_llock);
> +	if (!list_empty(&sw_fdb_lh))
> +		queue_work(sw_fdb_wq, &sw_fdb_work);
> +	spin_unlock(&sw_fdb_llock);
> +}
> +
> +int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb)
> +{
> +	struct otx2_nic *pf = netdev_priv(dev);
> +	struct sw_fdb_list_entry *entry;
> +
> +	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	ether_addr_copy(entry->mac, mac);
> +	entry->add_fdb = add_fdb;
> +	entry->pf = pf;
> +	dev_hold(dev);
> +
> +	spin_lock(&sw_fdb_llock);
> +	list_add_tail(&entry->list, &sw_fdb_lh);
> +	queue_work(sw_fdb_wq, &sw_fdb_work);
> +	spin_unlock(&sw_fdb_llock);
> +
> +	return 0;
> +}

[High]
Can this deadlock?  sw_fdb_add_to_list() is called from sw_nb_fdb_event()
via call_switchdev_notifiers(), and switchdev_notif_chain is an
ATOMIC_NOTIFIER_HEAD in net/switchdev/switchdev.c, so notifier callbacks
run in the caller's context — including softirq/BH context from bridge
learn paths like br_handle_frame_finish -> br_fdb_update ->
br_switchdev_fdb_notify -> call_switchdev_notifiers.

Meanwhile sw_fdb_wq_handler() runs in process context and takes
spin_lock(&sw_fdb_llock) without disabling BH.

    process ctx (workqueue)          softirq on same CPU
      spin_lock(&sw_fdb_llock)       (bridge learn arrives)
                                       call_switchdev_notifiers()
                                         sw_nb_fdb_event()
                                           sw_fdb_add_to_list()
                                             spin_lock(&sw_fdb_llock)
                                               /* spins forever */

Should this be spin_lock_bh() / spin_unlock_bh() everywhere sw_fdb_llock
is taken?

[ ... ]

>  int sw_fdb_init(void)
>  {
> +	INIT_WORK(&sw_fdb_work, sw_fdb_wq_handler);
> +	sw_fdb_wq = alloc_workqueue("sw_fdb_wq", 0, 0);
> +	if (!sw_fdb_wq)
> +		return -ENOMEM;
> +
>  	return 0;
>  }

[High]
sw_fdb_init() now returns -ENOMEM on alloc_workqueue failure, but
sw_nb_register() (drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c)
calls it as:

    sw_fdb_init();
    sw_fib_init();
    sw_fl_init();

with the return value discarded.  If sw_fdb_wq stays NULL, any subsequent
SWITCHDEV_FDB_ADD/DEL_TO_DEVICE event calls sw_fdb_add_to_list() ->
queue_work(NULL, ...), and later sw_fdb_deinit() calls
destroy_workqueue(NULL), each of which dereferences the NULL wq pointer.
Would it make sense to propagate the error out of sw_nb_register()?

[ ... ]

> +int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
> +					   struct af2pf_fdb_refresh_req *req,
> +					   struct msg_rsp *rsp)
> +{
> +	struct switchdev_notifier_fdb_info item = {0};
> +
> +	item.addr = req->mac;
> +	item.info.dev = pf->netdev;
> +	call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
> +				 item.info.dev, &item.info, NULL);
> +
> +	return 0;
>  }
> +#endif
> +EXPORT_SYMBOL(otx2_mbox_up_handler_af2pf_fdb_refresh);

[Medium]
otx2_mbox_up_handler_af2pf_fdb_refresh() is defined and exported from
sw_fdb.c, which the Makefile links into rvu_nicpf.  otx2_vf.c (which
lives in rvu_nicvf) calls it, creating a hard module dependency: the VF
driver will fail to load without the PF driver present.  Is that
intended?  In VF-passthrough VMs, only rvu_nicvf is loaded.

Also, is EXPORT_SYMBOL (rather than EXPORT_SYMBOL_GPL) intentional for a
driver-internal helper?
-- 
This is an AI-generated review.


