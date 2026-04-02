Return-Path: <netdev+bounces-274488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJfDCMZRzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 716AB38842C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25955305A43F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E03D5662;
	Thu,  2 Apr 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jlpj0bFJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55303C3421
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128834; cv=none; b=uOBPtsyKOH4eAr9G/5tW0ATf9dpvRmvQGjigd5mKQtb0FOOAzrZLyGACfid+YzDEGJwvRnZcmzPznNM6sUUDe4BYeKmk4mOrOM+QQxVxAi20CNr/+W+zBQixuqSkItLqYCfXv0xJuXQgWHxef5fBeXcEnhAPAYxKkIPf5G7uOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128834; c=relaxed/simple;
	bh=lvJKlOg3aGuOairpQBLVMhfOeO552k+716kO1lPbqxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdliJZ8NxkopBDICeGPo3JfIsVnh66gsTpRQ/1cAhVhmupl9L6QAQZbh35o2bCEYJgGqMUg+WzwQSL+cvscwehnifLdcVxRUJvowunYz7oKM59yZNOUtt3qitJyXQR38EqTROoQi+4OjKp04n5oxNd4UzVNuxtFMWl2Brjyc8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jlpj0bFJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775128824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yetmLtHqcqQxrBIPLF3ZE110WulySOnqoLnkAuOJXnc=;
	b=Jlpj0bFJFcpYwKRMmb/W4s2rawu7tqtdJuJj1ahnuPOj0pJc0Q7C12ifz/0nDkl7AlnbFZ
	FbgZ+yYi04jSB2VsIMmWEAhHLkW/K8tY+NH2hCEGbtSpFlVNPhhvwVaczCub2gjvIPjszl
	XYbBO+WgGqttymKzUVWlUnrm8cl93LU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-D3mugnLYMC-3fTRLel4tjQ-1; Thu,
 02 Apr 2026 07:20:21 -0400
X-MC-Unique: D3mugnLYMC-3fTRLel4tjQ-1
X-Mimecast-MFC-AGG-ID: D3mugnLYMC-3fTRLel4tjQ_1775128819
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E5CC195608C;
	Thu,  2 Apr 2026 11:20:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5233E1800767;
	Thu,  2 Apr 2026 11:20:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: sbhatta@marvell.com
Cc: pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	lcherian@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	gakula@marvell.com,
	edumazet@google.com,
	sgoutham@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,4/4] octeontx2-pf: cn20k: Use unified Halo context
Date: Thu,  2 Apr 2026 13:20:11 +0200
Message-ID: <20260402112011.216286-1-pabeni@redhat.com>
In-Reply-To: <1774940919-1599-5-git-send-email-sbhatta@marvell.com>
References: <1774940919-1599-5-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274488-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 716AB38842C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Use unified Halo context

This commit replaces the separate aura and pool contexts with the unified
Halo context available in CN20K hardware for managing network device pools
and buffer allocation.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

[ ... ]

> @@ -516,85 +507,8 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
>
>  	return 0;
>  }
> -
> -static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
> -			      int pool_id, int numptrs)
> -{
> -	struct npa_cn20k_aq_enq_req *aq;
> -	struct otx2_pool *pool;
> -	u8 bpid_idx;
> -	int err;
> -
> -	pool = &pfvf->qset.pool[pool_id];
> -
> -	/* Allocate memory for HW to update Aura count.
> -	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> -	 */
> -	if (!pool->fc_addr) {
> -		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> -		if (err)
> -			return err;
> -	}
> -
> -	/* Initialize this aura's context via AF */
> -	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> -	if (!aq) {
> -		/* Shared mbox memory buffer is full, flush it and retry */
> -		err = otx2_sync_mbox_msg(&pfvf->mbox);
> -		if (err)
> -			return err;
> -		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> -		if (!aq)
> -			return -ENOMEM;
> -	}
> -
> -	aq->aura_id = aura_id;
> -
> -	/* Will be filled by AF with correct pool context address */
> -	aq->aura.pool_addr = pool_id;
> -	aq->aura.pool_caching = 1;
> -	aq->aura.shift = ilog2(numptrs) - 8;
> -	aq->aura.count = numptrs;
> -	aq->aura.limit = numptrs;
> -	aq->aura.avg_level = 255;
> -	aq->aura.ena = 1;
> -	aq->aura.fc_ena = 1;
> -	aq->aura.fc_addr = pool->fc_addr->iova;
> -	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
>
> -	/* Enable backpressure for RQ aura */
> -	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
> -		aq->aura.bp_ena = 0;
> -		/* If NIX1 LF is attached then specify NIX1_RX.
> -		 *
> -		 * Below NPA_AURA_S[BP_ENA] is set according to the
> -		 * NPA_BPINTF_E enumeration given as:
> -		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
> -		 * NIX0_RX is 0x0 + 0*0x1 = 0
> -		 * NIX1_RX is 0x0 + 1*0x1 = 1
> -		 * But in HRM it is given that
> -		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
> -		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
> -		 * enumerated by NPA_BPINTF_E."
> -		 */
> -		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
> -			aq->aura.bp_ena = 1;
> -
> -		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
> -		aq->aura.bpid = pfvf->bpid[bpid_idx];
> -
> -		/* Set backpressure level for RQ's Aura */
> -		aq->aura.bp = RQ_BP_LVL_AURA;
> -	}
> -
> -	/* Fill AQ info */
> -	aq->ctype = NPA_AQ_CTYPE_AURA;
> -	aq->op = NPA_AQ_INSTOP_INIT;
> -
> -	return 0;
> -}
> -
> -static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
> +static int cn20k_halo_aq_init(struct otx2_nic *pfvf, u16 pool_id,
>  			      int stack_pages, int numptrs, int buf_size,
>  			      int type)
>  {
> @@ -610,36 +524,57 @@ struct page_pool_params pp_params = { 0 };
>  	if (err)
>  		return err;
>
> +	/* Allocate memory for HW to update Aura count.
> +	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> +	 */
> +	if (!pool->fc_addr) {
> +		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> +		if (err) {
> +			qmem_free(pfvf->dev, pool->stack);
> +			return err;
> +		}
> +	}
> +
>  	pool->rbsize = buf_size;
>
> -	/* Initialize this pool's context via AF */
> +	/* Initialize this aura's context via AF */
>  	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
>  	if (!aq) {
>  		/* Shared mbox memory buffer is full, flush it and retry */
>  		err = otx2_sync_mbox_msg(&pfvf->mbox);
> -		if (err) {
> -			qmem_free(pfvf->dev, pool->stack);
> -			return err;
> -		}
> +		if (err)
> +			goto free_mem;
>  		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
>  		if (!aq) {
> -			qmem_free(pfvf->dev, pool->stack);
> -			return -ENOMEM;
> +			err = -ENOMEM;
> +			goto free_mem;
>  		}
>  	}
>
>  	aq->aura_id = pool_id;
> -	aq->pool.stack_base = pool->stack->iova;
> -	aq->pool.stack_caching = 1;
> -	aq->pool.ena = 1;
> -	aq->pool.buf_size = buf_size / 128;
> -	aq->pool.stack_max_pages = stack_pages;
> -	aq->pool.shift = ilog2(numptrs) - 8;
> -	aq->pool.ptr_start = 0;
> -	aq->pool.ptr_end = ~0ULL;
>
> +	aq->halo.stack_base = pool->stack->iova;
> +	aq->halo.stack_caching = 1;
> +	aq->halo.ena = 1;
> +	aq->halo.buf_size = buf_size / 128;
> +	aq->halo.stack_max_pages = stack_pages;
> +	aq->halo.shift = ilog2(numptrs) - 8;
> +	aq->halo.ptr_start = 0;
> +	aq->halo.ptr_end = ~0ULL;
> +
> +	aq->halo.avg_level = 255;
> +	aq->halo.fc_ena = 1;
> +	aq->halo.fc_addr = pool->fc_addr->iova;
> +	aq->halo.fc_hyst_bits = 0; /* Store count on all updates */
> +
> +	if (pfvf->npa_dpc_valid) {
> +		aq->halo.op_dpc_ena = 1;
> +		aq->halo.op_dpc_set = pfvf->npa_dpc;
> +	}
> +	aq->halo.unified_ctx = 1;
                    ^^^^

Does this code properly configure backpressure for receive queues? The old
cn20k_aura_aq_init configured NPA-level backpressure by setting bp_ena,
bpid, and bp fields in the aura context. This caused the hardware to signal
backpressure to NIX-RX when receive buffers filled to 85% (RQ_BP_LVL_AURA):

    /* Enable backpressure for RQ aura */
    if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
        aq->aura.bp_ena = 0;
        if (pfvf->nix_blkaddr == BLKADDR_NIX1)
            aq->aura.bp_ena = 1;

        bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
        aq->aura.bpid = pfvf->bpid[bpid_idx];

        /* Set backpressure level for RQ's Aura */
        aq->aura.bp = RQ_BP_LVL_AURA;
    }

The new cn20k_halo_aq_init does not set the equivalent Halo context fields
(bp_ena_0, bpid_0, bp_0). Looking at struct npa_cn20k_halo_s in the AF
headers, these fields exist in the Halo context.

The AF side rvu_npa_aq_enq_inst() does not auto-configure backpressure
during INIT operations. The AF teardown code rvu_npa_halo_hwctx_disable()
explicitly clears bp_ena_0 through bp_ena_7, confirming these fields are
expected to be set during initialization.

Without NPA-level backpressure configuration, wouldn't CN20K devices fail
to trigger backpressure when aura buffers fill up, leading to packet drops
under heavy traffic load?

>
>  	/* Fill AQ info */
> -	aq->ctype = NPA_AQ_CTYPE_POOL;
> +	aq->ctype = NPA_AQ_CTYPE_HALO;
>  	aq->op = NPA_AQ_INSTOP_INIT;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1651,6 +1651,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
>  	if (!is_otx2_lbkvf(pf->pdev))
>  		otx2_nix_config_bp(pf, true);
>
> +	if (is_cn20k(pf->pdev))
> +		cn20k_npa_alloc_dpc(pf);
> +
>  	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
>  	err = otx2_rq_aura_pool_init(pf);
>  	if (err) {
> @@ -1726,6 +1729,8 @@
>  	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_AURA, true);
>  	otx2_aura_pool_free(pf);
>  err_free_nix_lf:
> +	if (pf->npa_dpc_valid)
> +		cn20k_npa_free_dpc(pf);

Is there a potential double-free of the NPA DPC counter via the
rvu_rep_rsrc_init error path?

cn20k_npa_free_dpc() does not clear nic->npa_dpc_valid after successfully
freeing the DPC counter. If otx2_init_hw_resources() fails after
cn20k_npa_alloc_dpc() succeeds (e.g., otx2_rq_aura_pool_init() returns an
error), the error cleanup at err_free_nix_lf calls cn20k_npa_free_dpc(pf)
which frees the counter but leaves npa_dpc_valid=true.

The caller rvu_rep_rsrc_init() then calls otx2_free_hw_resources(priv) at
its err_free_rsrc label:

rvu_rep_rsrc_init()
    otx2_init_hw_resources(priv)
        cn20k_npa_alloc_dpc(pf) [succeeds]
        otx2_rq_aura_pool_init(pf) [fails]
        goto err_free_nix_lf
        cn20k_npa_free_dpc(pf) [frees counter, npa_dpc_valid still true]
    goto err_free_rsrc
    otx2_free_hw_resources(priv)
        cn20k_npa_free_dpc(pf) [frees same counter again]

Looking at cn20k_npa_free_dpc() in cn20k.c:

int cn20k_npa_free_dpc(struct otx2_nic *nic)
{
    struct npa_cn20k_dpc_free_req *req;
    int err;

    if (!nic->npa_dpc_valid)
        return 0;

    mutex_lock(&nic->mbox.lock);

    req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
    if (!req) {
        mutex_unlock(&nic->mbox.lock);
        return -ENOMEM;
    }

    req->cntr_id = nic->npa_dpc;

    err = otx2_sync_mbox_msg(&nic->mbox);

    mutex_unlock(&nic->mbox.lock);

    return err;
}

Since npa_dpc_valid is still true, the second call passes the guard check
and sends another mbox message to free the same counter ID. Shouldn't
cn20k_npa_free_dpc() clear nic->npa_dpc_valid after the successful
otx2_sync_mbox_msg() call to prevent this double-free?

>  	mutex_lock(&mbox->lock);
>  	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
>  	if (free_req) {

[ ... ]


