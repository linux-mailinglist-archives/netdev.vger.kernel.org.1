Return-Path: <netdev+bounces-269984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP9mCWl+vWnH+QIAu9opvQ
	(envelope-from <netdev+bounces-269984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:05:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE62DE3BA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6A431C903C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67B03D5243;
	Fri, 20 Mar 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSH3SzfZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04C3D3007;
	Fri, 20 Mar 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025436; cv=none; b=A5THuRq8A9o2dDQwpSG6uitj32oN2d5XHfiUHLDeRYqIJjI7f9oFZJN4Vg5zh27G+jb/iT/RaroYLZupOswJgBdAT5BTvkQXzSMbrA+Kt5bTJzt3hRqcJbXQb8/l4Oeqp27y73dUVIvnzbalQXOqu2xG2EO3dO9AIsOLvGwCUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025436; c=relaxed/simple;
	bh=hkB0rW6uO8fRpL0lz3lECVf9wXLltyxhKz/ZlxNgD2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKaVPke/hGCUzKu1FxshiUwnwsJjtq1D5OhUcJvDazqtuuyAJEfsZ6fZgJSiQ1yzMQnp7WB2ldGypRrX2SJ47BITvoMMLqVRV9YtcvbHMFBexBPyvL7/EWk7WgDJjTRcUCz2y0UFqjTIkgpLMeIqjkXMf8eysZju8rgtFhGvrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSH3SzfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B32C4CEF7;
	Fri, 20 Mar 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025436;
	bh=hkB0rW6uO8fRpL0lz3lECVf9wXLltyxhKz/ZlxNgD2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSH3SzfZE9tQvUCnamri5gPTOfy95Cl9wINl1A0juKTDJGq9iztiq9AdCR56T+IoF
	 Ne360SVEButt+YnkzgOTrfALTU0cNCbll7pF4AvbOdl/P9yTzyoIsTRByb3PPZ5L9a
	 TSiTh3paEsu31vluAcsvGP9WT4EaJIupTAU6TXtC67TGmksy4ShQjuOcnw7KaTG2F0
	 u1z9wG2HZqpl6Rsd36AhEiKQscmtXgkGvAi2PTYik+O6ZsoN2DKRKAM4q6YNUnT9Xy
	 JhQKWbMRE2vJFP7QYaOYHXQDbfMuovZJXBcWEJKDoYDPxIjV42FETG8kIPsW/2Jvn7
	 Tmc2PFcdD/VWw==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	lcherian@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [net-next PATCH v2 2/4] octeontx2-af: npa: cn20k: Add DPC support
Date: Fri, 20 Mar 2026 16:50:17 +0000
Message-ID: <20260320165017.96244-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1773920826-16985-3-git-send-email-sbhatta@marvell.com>
References: <1773920826-16985-3-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 7CBE62DE3BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npa: cn20k: Add DPC support

CN20k introduces 32 diagnostic and performance counters that are shared
across all NPA LFs. This patch adds new mbox messages npa_dpc_alloc/free
to allocate and map counters to LFs, and ensures LF to DPC counter
mappings are cleared at LF free/teardown.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> index c963f43dc7b0..1def2504872f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

[ ... ]

> @@ -46,3 +48,117 @@ int rvu_npa_halo_hwctx_disable(struct npa_aq_enq_req *req)
>
>  	return 0;
>  }
> +
> +int npa_cn20k_dpc_alloc(struct rvu *rvu, struct npa_cn20k_dpc_alloc_req *req,
> +			struct npa_cn20k_dpc_alloc_rsp *rsp)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	int cntr, lf, blkaddr, ridx;
> +	struct rvu_block *block;
> +	struct rvu_pfvf *pfvf;
> +	u64 val, lfmask;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
> +	if (!pfvf->npalf || blkaddr < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);
> +	if (lf < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	/* allocate a new counter */
> +	cntr = rvu_alloc_rsrc(&rvu->npa_dpc);
                ^^^^

Are rvu_alloc_rsrc() and rvu_free_rsrc() calls synchronized here?

These functions use non-atomic find_first_zero_bit() + __set_bit() and
__clear_bit() operations on the bitmap. Looking at other callers like
rvu_mbox_handler_attach_resources() in rvu.c:

int rvu_mbox_handler_attach_resources(struct rvu *rvu,
                                      struct rsrc_attach *attach,
                                      struct msg_rsp *rsp)
{
    ...
    mutex_lock(&rvu->rsrc_lock);

    for (q_cnt = 0; q_cnt < attach->npa_msixoff; q_cnt++) {
        msix = rvu_alloc_rsrc(&pfvf->msix);
        ...
    }
    mutex_unlock(&rvu->rsrc_lock);
    ...
}

Similarly, rvu_mbox_handler_nix_bandprof_alloc() and
rvu_mbox_handler_mcs_alloc_resources() also acquire rvu->rsrc_lock
before calling rvu_alloc_rsrc(). rvu_mbox_handler_npc_mcam_alloc_counter()
uses mcam->lock.

Since npa_cn20k_dpc_alloc() can be invoked by the mbox handler
rvu_mbox_handler_npa_cn20k_dpc_alloc() concurrently from different
PF/VF workqueue items in __rvu_mbox_handler(), two threads could race:

Thread 1                                 Thread 2
npa_cn20k_dpc_alloc()                    npa_cn20k_dpc_alloc()
  find_first_zero_bit(npa_dpc) = 0         find_first_zero_bit(npa_dpc) = 0
  __set_bit(0, npa_dpc)                    __set_bit(0, npa_dpc)
  return cntr = 0                          return cntr = 0

Both threads get counter 0, leading to duplicate allocation. The same
race exists in npa_cn20k_dpc_free() with rvu_free_rsrc().

Should these calls be protected with mutex_lock(&rvu->rsrc_lock) similar
to other resource allocation paths?

> +	if (cntr < 0)
> +		return cntr;
> +	rsp->cntr_id = cntr;
> +
> +	/* DPC counter config */
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPCX_CFG(cntr), req->dpc_conf);
> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
> +
> +	ridx = 2 * cntr + ridx;
> +	/* Give permission for LF access */
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	val |= lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	return 0;
> +}
> +
> +int rvu_mbox_handler_npa_cn20k_dpc_alloc(struct rvu *rvu,
> +					 struct npa_cn20k_dpc_alloc_req *req,
> +					 struct npa_cn20k_dpc_alloc_rsp *rsp)
> +{
> +	return npa_cn20k_dpc_alloc(rvu, req, rsp);
> +}
> +
> +int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	int cntr, lf, blkaddr, ridx;
> +	struct rvu_block *block;
> +	struct rvu_pfvf *pfvf;
> +	u64 val, lfmask;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
> +	if (!pfvf->npalf || blkaddr < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);
> +	if (lf < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	if (req->cntr_id >= NPA_DPC_MAX)
> +		return NPA_AF_ERR_PARAM;
> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
> +	cntr = req->cntr_id;
> +
> +	ridx = 2 * cntr + ridx;
> +
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	/* Check if the counter is allotted to this LF */
> +	if (!(val & lfmask))
> +		return 0;
> +
> +	/* Revert permission */
> +	val &= ~lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	/* Free this counter */
> +	rvu_free_rsrc(&rvu->npa_dpc, req->cntr_id);
> +
> +	return 0;
> +}

[ ... ]

