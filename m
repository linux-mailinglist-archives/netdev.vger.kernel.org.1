Return-Path: <netdev+bounces-293667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG2YAtJXHWpLZQkAu9opvQ
	(envelope-from <netdev+bounces-293667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A361CEEC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2DBD30C6419
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1938AC75;
	Mon,  1 Jun 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8ExiIDz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DD3932D3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307325; cv=none; b=IAdk1pn6y8PILFPPi323C+NG0RofHSmm79sdSAvAtL+8INfMzxSUjKMDgfGhctNtLf0JTBGXQUy7l0uqHdybrcM1DXD0w8XDxwQxj+dZWS55NiZ9YGx512IwLuXt5iFTb2MdL/hKICiH4tMjBcTxt/PpyEzeEErI2WoP3UaO7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307325; c=relaxed/simple;
	bh=wIVIVJXpo0LorNkaJXrhF0UwE0F6yeHaxMYKasU95dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwoxFlkl/utvpqRERX08uSI16InM1sUiXGwtdNTKxlWNS3gIUMLv6yclxx2FmR4zu+SaKbBLO4BtbwGLp3u9DLN4ycCZiTCBZrTUvuYEBo9iywuQjnGqofR78VT8SfM0m7OJf+KcwKNS4ypc5gXNcIQBwuw6hAVRGQmWZ90RtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8ExiIDz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780307318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebGeSHqfZvmYpdqfOWfo0+VT4JiCMTuJ8hHhjI0YJFI=;
	b=B8ExiIDz+qNgH3VRiQKHj9Id/rUj6J5dlzUgDeB9S0z3LJUXTayp0MI8n49VhC58pHKk+0
	yIh19MaJFWTfB07plZ9I27Eupu+oo73BJzAFA6hX3RsI/gvgWVgp0BcfZh8R7sfhKialQk
	ZuL5bPWFPs6Rz/XYidXkAMHtvnw7TC4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-gSukj-xHOxeVWeYQjvjnEw-1; Mon,
 01 Jun 2026 05:48:35 -0400
X-MC-Unique: gSukj-xHOxeVWeYQjvjnEw-1
X-Mimecast-MFC-AGG-ID: gSukj-xHOxeVWeYQjvjnEw_1780307313
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FE611800614;
	Mon,  1 Jun 2026 09:48:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C873A1681;
	Mon,  1 Jun 2026 09:48:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: sbhatta@marvell.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lcherian@marvell.com
Subject: Re: [net-next PATCH v6 3/5] octeontx2-af: npa: cn20k: Add DPC support
Date: Mon,  1 Jun 2026 11:48:22 +0200
Message-ID: <20260601094823.128414-1-pabeni@redhat.com>
In-Reply-To: <1779792447-5593-4-git-send-email-sbhatta@marvell.com>
References: <1779792447-5593-4-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293667-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 726A361CEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: npa: cn20k: Add DPC support

This adds NPA_CN20K_DPC_ALLOC/FREE mbox handlers so each PF/VF can request
one of 32 shared diagnostic and performance counters with a configuration
written to NPA_AF_DPCX_CFG, with LF-to-counter mappings tracked in
NPA_AF_DPC_PERMITX. Counter mappings owned by a pcifunc are released on LF
free and teardown.

A few questions below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> index fe8f926c8b75..7c9cd28de3ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

[ ... ]

> +static int npa_cn20k_dpc_alloc(struct rvu *rvu,
> +			       struct npa_cn20k_dpc_alloc_req *req,
> +			       struct npa_cn20k_dpc_alloc_rsp *rsp)
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
> +	mutex_lock(&rvu->rsrc_lock);
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);

[Critical]
Can this self-deadlock?  rvu_get_lf() in rvu.c does:

	int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot)
	{
		...
		mutex_lock(&rvu->rsrc_lock);
		for (lf = 0; lf < block->lf.max; lf++) {
		...

and rvu->rsrc_lock is a plain non-recursive struct mutex.  The sibling
npa_cn20k_dpc_free() calls rvu_get_lf() before taking rsrc_lock, which
appears to be the intended order.  Should the rvu_get_lf() call here move
above the mutex_lock() too?

> +	if (lf < 0) {
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +	}
> +
> +	/* allocate a new counter */
> +	cntr = rvu_alloc_rsrc(&rvu->npa_dpc);
> +	if (cntr < 0) {
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return cntr;

[Low]
Other failure paths in this file return NPA_AF_ERR_* values
(NPA_AF_ERR_AF_LF_INVALID, NPA_AF_ERR_PARAM, ...), but on bitmap
exhaustion this returns the raw -ENOSPC/-EINVAL from rvu_alloc_rsrc().
Should this be normalised to an NPA_AF_ERR_* code for consistency with the
rest of the AF mbox surface?

[Medium]
Is there a reason a single pcifunc cannot consume all 32 DPC counters?
rvu_alloc_rsrc(&rvu->npa_dpc) is called with no per-pcifunc accounting or
quota, ownership is only encoded in the NPA_AF_DPC_PERMITX register.  Any
PF/VF that loops NPA_CN20K_DPC_ALLOC can drain the pool and starve every
other LF.  Other shared AF resources (MCAM counters, nix_ipolicer
profilers) keep a per-pcifunc count for exactly this reason.  Would a
similar per-pcifunc cap be appropriate here?

> +	}
> +
> +	rsp->cntr_id = cntr;
> +
> +	/* Consumers can configure to count ALLOC/FREE requests only */
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPCX_CFG(cntr), req->dpc_conf);

[High]
The comment says consumers can configure to count ALLOC/FREE requests
only, but req->dpc_conf is a u16 supplied by an arbitrary PF/VF (including
guest VFs through the AF mbox path) and is written verbatim into the CSR
with no validation or masking.  Should the AF mask req->dpc_conf to the
documented event-select bits, or reject illegal values with
NPA_AF_ERR_PARAM, rather than forwarding an opaque value to the register?

> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
> +
> +	ridx = 2 * cntr + ridx;

[Medium]
What bounds lf to [0, 127] here?  block->lf.max for NPA comes from a
12-bit HW field, and rvu_get_lf() can return any LF up to that maximum.
For lf >= 128:

	lfmask = BIT_ULL(lf - 64);

becomes a shift count >= 64 on a u64, which is undefined in C, and:

	ridx = 2 * cntr + (lf >> 6);

walks past the documented NPA_AF_DPC_PERMITX array, doing AF MMIO against
whatever register sits at the computed offset.  The same arithmetic
appears in npa_cn20k_dpc_free(), so a misbehaving caller could end up
clearing permission bits and freeing a counter slot that belongs to
another LF.  Should there be a guard like
if (lf >= 2 * NPA_DPC_LFS_PER_REG) return NPA_AF_ERR_PARAM; in both
paths?

> +	/* Give permission for LF access */
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	val |= lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	mutex_unlock(&rvu->rsrc_lock);
> +
> +	return 0;
> +}

[ ... ]

> +static int npa_cn20k_dpc_free(struct rvu *rvu,
> +			      struct npa_cn20k_dpc_free_req *req)
> +{

[ ... ]

> +	/* Revert permission */
> +	val &= ~lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	/* Free this counter */
> +	rvu_free_rsrc(&rvu->npa_dpc, req->cntr_id);

[Medium]
On free, the LF bit in NPA_AF_DPC_PERMITX is cleared and the bitmap slot
is returned, but NPA_AF_DPCX_CFG(cntr) and the counter value itself are
left as-is.  When the slot is later reallocated, the previous owner's
configuration and accumulated count remain in HW until the new owner's
write to dpc_conf takes effect, and the first reads of the counter return
the prior accumulation.

The commit message says:

    Also ensure all the LF to DPC counter mappings are cleared
    at the time of LF free/teardown.

Should the free path also zero NPA_AF_DPCX_CFG(cntr) and the counter so a
recycled slot starts clean?  And should rvu_npa_freemem() quiesce any
still-armed counters before the bitmap is freed?

> +
> +	mutex_unlock(&rvu->rsrc_lock);
> +
> +	return 0;
> +}
-- 
This is an AI-generated review.


