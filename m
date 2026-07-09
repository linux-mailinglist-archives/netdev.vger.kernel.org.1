Return-Path: <netdev+bounces-306146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /dZPFMRwT2oPgwIAu9opvQ
	(envelope-from <netdev+bounces-306146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DDB72F391
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a1KPI0sQ;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306146-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306146-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED0C53061A43
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB3403EAE;
	Thu,  9 Jul 2026 09:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3D4048BD
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590995; cv=none; b=XxqLXc6QObHZvOlsu1FuxuoneJ5wUKYEdN6vsR9SS8Z8GZ7ViX1eCvhblVugnU0hFCyy7l/RaPd435gGjdpfzjTkxBbpYrixL87XstJI5iThGBP8zG+LiRlvRXTWdnsQlQ31cvrT9YmNaVX8aogiojaCItOs6sPEgoiUEd3ftVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590995; c=relaxed/simple;
	bh=FAPJieQbV7XaZSTa0S2ba0GGEQcNznhHuYs8YLgiQBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3yBTzvgNChLfs5PhEqNdyZaEYkzzIPLXZvpjUXBa40n/KnofnbroRLVfvaqNGCCGEXKukixD4LdLmfAmgtfMDibnn6RVc3nihDPtG/UF6uTDfGYvz11ZmUzzZMGY+HKj5kYLHKH4p651BjYTlmTeDcAni686YbtU7E5pl16OeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1KPI0sQ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783590991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtfAOtSy6NfFWkSnNRdeO3M23l9EHqBnB7KmtwOSs88=;
	b=a1KPI0sQ7AYtR4c1vvZmvJWWgDcmVMBXwZVmr2dGJKpC18El+xEm8R962BldJUy7sj8zq9
	xq5Gqwb9tUtcPje5XL5rS2o+0hCwyeasrvIh5U1SIBzmerqJ4nC62xl8iHsCPkMej4MYRU
	A50yN1ghHrLShrDCG/Mip3bV0BeXR0s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-CHl1pTEvOD6NwMBHojxUVQ-1; Thu,
 09 Jul 2026 05:56:26 -0400
X-MC-Unique: CHl1pTEvOD6NwMBHojxUVQ-1
X-Mimecast-MFC-AGG-ID: CHl1pTEvOD6NwMBHojxUVQ_1783590985
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 037E81955F7C;
	Thu,  9 Jul 2026 09:56:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39EF5180035F;
	Thu,  9 Jul 2026 09:56:21 +0000 (UTC)
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
Subject: Re: [PATCH v2 net-next 5/9] octeontx2-af: PAN switch TL1 scheduling and NPC channel control
Date: Thu,  9 Jul 2026 11:56:20 +0200
Message-ID: <20260709095620.117353-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-6-rkannoth@marvell.com>
References: <20260702045026.2914748-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306146-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5DDB72F391

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: PAN switch TL1 scheduling and NPC channel control

This change adds NIX_TXSCH_ALLOC_FLAG_PAN so nix_txsch_alloc can request
more than one aggregate-level (TL1) index for PAN/switch mode, adds
TXSCHQ_FREE_PAN_TL1 to permit freeing those indices via
nix_txschq_free_one, and adds a set_chanmask field to
npc_install_flow_req. It also widens the NIX LF SQ bitmap allocation
and extends struct sg_list.

A few questions inline below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 7ac26629d9af..28ebf0a8d3d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1157,6 +1157,8 @@ struct nix_txsch_alloc_req {
>  	/* Scheduler queue count request at each level */
>  	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
>  	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
> +#define NIX_TXSCH_ALLOC_FLAG_PAN BIT_ULL(0)
> +	u64 flags;
>  };
>  
>  struct nix_txsch_alloc_rsp {
> @@ -1175,6 +1177,7 @@ struct nix_txsch_alloc_rsp {
>  struct nix_txsch_free_req {
>  	struct mbox_msghdr hdr;
>  #define TXSCHQ_FREE_ALL BIT_ULL(0)
> +#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
>  	u16 flags;
>  	/* Scheduler queue level to be freed */
>  	u16 schq_lvl;

[Critical]
Should these two new flags be gated on the requester being the AF via
is_pffunc_af(req->hdr.pcifunc)?

Before this change, the aggregate level (TL1) was intentionally opaque
to non-AF callers: nix_txschq_free_one() short-circuited with
if (lvl >= hw->cap.nix_tx_aggr_lvl) return 0; and nix_txsch_alloc()
forced a single TL queue tied to the caller's mapped Tx link.

With the new flags there does not appear to be any is_pffunc_af() check
on the alloc or free paths, so any PF/VF can pass NIX_TXSCH_ALLOC_FLAG_PAN
to bypass the Tx-link mapping and touch TL1 slots that belong to
other links or other pcifuncs, or pass TXSCHQ_FREE_PAN_TL1 to free a
TL1 index. The existing comment in nix_txschq_free() says:

    /* Do not clear pcifunc in txsch->pfvf_map[schq] because VF might
     * be using this TL1 queue
     */

so if a PF frees a TL1 that a VF is still transmitting through, after
rvu_free_rsrc(&txsch->schq, schq) and
pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE) that hardware slot is
reallocatable while the VF still uses it. Is that intended?

> @@ -2105,6 +2108,7 @@ struct npc_install_flow_req {
>  	u8 hw_prio;
>  	u8  req_kw_type; /* Key type to be written */
>  	u8 alloc_entry;	/* only for cn20k */
> +	u8 set_chanmask;

[Medium]
The commit message says:

    For NPC install flow, add set_chanmask so callers can keep a
    non-default chan_mask when the requester is not the AF; without
    it, chan_mask was always forced to 0xFFF for non-AF functions.

Where is set_chanmask consumed? A grep across the tree finds only this
struct field definition and no reader; the existing non-AF override in
rvu_npc_fs.c is unchanged:

    if (!is_pffunc_af(req->hdr.pcifunc))
            req->chan_mask = rvu_get_cpt_chan_mask(rvu);

Should the corresponding "keep chan_mask" hunk that consults
set_chanmask be part of this commit, or was it meant for a follow-up?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index d2734f6d6d92..35c91cdc50b9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -2138,11 +2138,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
>  	if (!req_schq)
>  		return 0;
>  
> -	link = nix_get_tx_link(rvu, pcifunc);
> +	if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
> +		link = hw->cgx_links + hw->lbk_links + 1;
> +	else
> +		link = nix_get_tx_link(rvu, pcifunc);
>  
>  	/* For traffic aggregating scheduler level, one queue is enough */
>  	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> -		if (req_schq != 1)
> +		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
>  			return NIX_AF_ERR_TLX_ALLOC_FAIL;
>  		return 0;
>  	}

[Critical]
Can this branch let a caller-controlled count reach the alloc loop
without a MAX_TXSCHQ_PER_FUNC ceiling?

For non-PAN, aggregate-level requests were previously rejected unless
req_schq == 1. With NIX_TXSCH_ALLOC_FLAG_PAN, the check is skipped and
this function returns 0 before the general guard further down:

    if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
        req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
            return NIX_AF_ERR_TLX_ALLOC_FAIL;

rvu_mbox_handler_nix_txsch_alloc() later copies the request into rsp
and iterates:

    for (idx = 0; idx < req->schq_contig[lvl]; idx++) {
            schq = rsp->schq_contig_list[lvl][idx];
            ...
            pfvf_map[schq] = TXSCH_MAP(pcifunc, 0);
            nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
            nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
            nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
    }

rsp->schq_contig_list[lvl] and rsp->schq_list[lvl] are each
MAX_TXSCHQ_PER_FUNC entries. If req->schq_contig[lvl] exceeds
MAX_TXSCHQ_PER_FUNC, idx runs past the array, schq is read from
adjacent memory, and pfvf_map[schq] = TXSCH_MAP(pcifunc, 0) writes at
an attacker-controlled offset. Should the PAN branch keep the
MAX_TXSCHQ_PER_FUNC bound?

[High]
The PAN link index is computed as:

    link = hw->cgx_links + hw->lbk_links + 1;

and the caller then does end = link + 1. For the TL1 level,
txsch->schq.max is programmed from NIX_AF_TL1_CONST in
nix_setup_txschq():

    txsch->schq.max = cfg & 0xFFFF;

Is there anything guaranteeing that hw->cgx_links + hw->lbk_links + 2
is less than txsch->schq.max for TL1? The non-PAN path is bounded
because nix_get_tx_link() only returns values in the range
[0, cgx_links + lbk_links]. The new path adds one beyond that with no
ceiling check, so set_bit(schq, txsch->schq.bmap) below and later
NIX_AF_TL1X_CIR(schq) register writes could target undefined TL1
indices on silicon where TL1 count is small.

> @@ -2179,11 +2182,41 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc = rsp->hdr.pcifunc;
>  	int idx, schq;
> +	bool alloc;
>  
>  	/* For traffic aggregating levels, queue alloc is based
>  	 * on transmit link to which PF_FUNC is mapped to.
>  	 */
>  	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> +		if (start != end) {
> +			idx = 0;
> +			alloc = false;
> +			for (schq = start; schq <= end; schq++, idx++) {
> +				if (test_bit(schq, txsch->schq.bmap))
> +					continue;
> +
> +				set_bit(schq, txsch->schq.bmap);
> +
> +				/* A single TL queue is allocated each time */
> +				if (rsp->schq_contig[lvl]) {
> +					alloc = true;
> +					rsp->schq_contig_list[lvl][idx] = schq;
> +					continue;
> +				}
> +
> +				if (rsp->schq[lvl]) {
> +					alloc = true;
> +					rsp->schq_list[lvl][idx] = schq;
> +					continue;
> +				}
> +			}
> +
> +			if (!alloc)
> +				dev_err(rvu->dev,
> +					"Could not allocate schq at lvl=%u start=%u end=%u\n",
> +					lvl, start, end);
> +			return;
> +		}

[Critical]
A few concerns on this new block.

First, idx advances unconditionally in the for-clause even when the
continue-on-busy path is taken. Consider start=L, end=L+1 where slot
L is already set in the bitmap and req->schq_contig[lvl] == 1:

    iter 1: schq=L busy       -> continue (idx becomes 1)
    iter 2: schq=L+1 free     -> set_bit(L+1); rsp->schq_contig_list[lvl][1] = L+1

rsp->schq_contig_list[lvl][0] stays as 0. The caller then loops
idx = 0 .. req->schq_contig[lvl] - 1 in rvu_mbox_handler_nix_txsch_alloc()
and picks up schq = rsp->schq_contig_list[lvl][0] = 0. That triggers
pfvf_map[0] = TXSCH_MAP(pcifunc, 0) if NIX_TXSCHQ_CFG_DONE is not set,
and nix_reset_tx_linkcfg/shaping/schedule(rvu, blkaddr, lvl, 0),
disturbing TL1[0]. Can this hijack TL1[0] from its real owner?

Second, this loop calls set_bit(schq, txsch->schq.bmap) once for each
free slot in [start, end], but never decrements
rsp->schq_contig[lvl]/rsp->schq[lvl] or otherwise reports how many
were placed into the response list. With req->schq_contig[lvl] == 1
and both slots free, both bits get set, but only one is reported back.
The bit for the extra slot then has no matching entry in pfvf_map, and
nix_txschq_free_one() gates on:

    if (TXSCH_MAP_FUNC(pfvf_map[schq]) != pcifunc) {
            rc = NIX_AF_ERR_TLX_INVALID;
            goto err;
    }

so the client cannot free it. Is the resulting bitmap leak intended?

Third, on the "no slot free" path, alloc stays false, dev_err() is
logged, and the function returns without clearing rsp->schq_contig[lvl]
or rsp->schq[lvl]. The mbox handler returns success, so consumers see
non-zero counts and then read rsp->schq_contig_list[lvl][0] == 0
(zero-initialized rsp) as a valid schq. Should this path signal
failure back to the caller?

> +		/* A single TL queue is allocated */
>  		if (rsp->schq_contig[lvl]) {
>  			rsp->schq_contig[lvl] = 1;

[ ... ]

> @@ -2300,11 +2333,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
>  		rsp->schq[lvl] = req->schq[lvl];
>  		rsp->schq_contig[lvl] = req->schq_contig[lvl];
>  
> -		link = nix_get_tx_link(rvu, pcifunc);
> +		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
> +			link = hw->cgx_links + hw->lbk_links + 1;
> +		else
> +			link = nix_get_tx_link(rvu, pcifunc);
>  
>  		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
>  			start = link;
> -			end = link;
> +			end = link + !!(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN);
>  		} else if (hw->cap.nix_fixed_txschq_mapping) {
>  			nix_get_txschq_range(rvu, pcifunc, link, &start, &end);
>  		} else {

[High]
The commit message states:

    Add TXSCHQ_FREE_PAN_TL1 so TL1 entries in that path can be freed
    via nix_txsch_free where they were previously skipped.

Is nix_txsch_free() actually updated by this patch? Only
nix_txschq_free_one() gets a new gate. The bulk path nix_txschq_free()
still has if (lvl >= hw->cap.nix_tx_aggr_lvl) continue; in both its
scan and free loops, so aggregate-level bits set by the new
nix_txsch_alloc() block above are never cleared by that path, whether
it is reached via TXSCHQ_FREE_ALL or via nix_lf_teardown() on LF close
or FLR. Was a matching hunk in nix_txschq_free() intended?

> @@ -2669,7 +2705,9 @@ static int nix_txschq_free_one(struct rvu *rvu,
>  	schq = req->schq;
>  	txsch = &nix_hw->txsch[lvl];
>  
> -	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
> +	if ((lvl >= hw->cap.nix_tx_aggr_lvl &&
> +	     !(req->flags & TXSCHQ_FREE_PAN_TL1)) ||
> +	    schq >= txsch->schq.max)
>  		return 0;
>  
>  	pfvf_map = txsch->pfvf_map;
-- 
This is an AI-generated review.


