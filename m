Return-Path: <netdev+bounces-96339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2498C5444
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA73D1F2333C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041286EB4D;
	Tue, 14 May 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZHlwbxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFC60BB6;
	Tue, 14 May 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687096; cv=none; b=tedTU+vAcbCTHgyZSBgksYbPTMmO/9Y8pi5cT7RqKwrhHH5LMwkb/tbH7Nvcr4rnM1iuGtAFF0h8pJU1ynIS/fRUbROvxF/aT2q+w/8xkFqHrLu0h0ZKqMINcFA0P3JPyCi3cUb5atR/wHd3P38wKVT0ygF+IQgUDd3W9bi+lDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687096; c=relaxed/simple;
	bh=zMwTH5JexUfVSxwzoMsVvb2Y56k+vwlD+UGM3nXS0GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmKoWFy2rpLShNPzL102RXR6kylBliUQPITGxkvDZC/NxZ7c1+SvIE6EBdEsSInqlxwH4PsBQ8NxchDh2BiNCfbkStTUd6h0KErfjYYvqPDEZ19q+XnktrQLIQZafrCc6dNy62mEmpY7xdCxjw+sIOEo9uaJJdbY8+iWmroBrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZHlwbxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC4DC32786;
	Tue, 14 May 2024 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715687096;
	bh=zMwTH5JexUfVSxwzoMsVvb2Y56k+vwlD+UGM3nXS0GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZHlwbxq5sUzTky2XhQkheoVyp6udbq4XNVTrh4Ss6Ljp4Kp64s5uVAv7yMlE6LEB
	 q3t5QBwPk4gcPHDEv8t9AKWSUtFzWN9WF9aZjgdNCzNspew6f5lrw+MZyrFF1j4nxl
	 3MPsg1eMjyN5hxRTegflL1H3IcBWlJVLLJi+ICAqr88gWWKUqi64PCjto/49YFnADz
	 dY0u+HksRhWURAWEXXEej2xnvqWfnpzOSUQ6CNz4VNtOv/Ec3/x8SlmhxT9ZO7AJv+
	 I4toNDaypJIcG7JxyKKfGebnzaksU0st8uFFM10nEA24zXwPZT4OCAAtNA4qZNEri3
	 75cE3+Tdmpo8g==
Date: Tue, 14 May 2024 12:44:51 +0100
From: Simon Horman <horms@kernel.org>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] octeontx2-af: Add debugfs support to dump NIX TM topology
Message-ID: <20240514114451.GF2787@kernel.org>
References: <20240514095434.31445-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514095434.31445-1-agaur@marvell.com>

On Tue, May 14, 2024 at 03:24:34PM +0530, Anshumali Gaur wrote:
> This patch adds support to dump NIX transmit queue topology.
> There are multiple levels of scheduling/shaping supported by
> NIX and a packet traverses through multiple levels before sending
> the packet out. At each level, there are set of scheduling/shaping
> rules applied to a packet flow.
> 
> Each packet traverses through multiple levels
> SQ->SMQ->Tl4->Tl3->TL2->Tl1 and these levels are mapped in a parent-child
> relationship.
> 
> This patch dumps the debug information related to all TM Levels in
> the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_tree
> $ cat /sys/kernel/debug/octeontx2/nix/tm_tree
> 
> A more desriptive set of registers at each level can be dumped
> in the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_topo
> $ cat /sys/kernel/debug/octeontx2/nix/tm_topo
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

## Form letter - net-next-closed

(Adapted from text by Jakub)

The merge window for v6.10 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after May 27th.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

## End form letter

Also, as this patch seems to be for net-next, please include that in the
subject.

	[PATCH net-next] ...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

...

> +/*dumps given tm_tree registers*/
> +static int rvu_dbg_nix_tm_tree_display(struct seq_file *m, void *unused)
> +{
> +	int qidx, nixlf, rc, id, max_id = 0;
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct nix_aq_enq_req aq_req;
> +	struct nix_aq_enq_rsp rsp;
> +	struct rvu_pfvf *pfvf;
> +	u16 pcifunc;
> +
> +	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
> +	id = rvu->rvu_dbg.nix_tm_ctx.id;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
> +		return -EINVAL;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +	max_id = pfvf->sq_ctx->qsize;
> +
> +	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
> +	aq_req.hdr.pcifunc = pcifunc;
> +	aq_req.ctype = NIX_AQ_CTYPE_SQ;
> +	aq_req.op = NIX_AQ_INSTOP_READ;
> +	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
> +	for (qidx = id; qidx < max_id; qidx++) {
> +		aq_req.qidx = qidx;
> +		rc = rvu_mbox_handler_nix_aq_enq(rvu, &aq_req, &rsp);
> +
> +			/* Skip SQ's if not initialized */
> +			if (!test_bit(qidx, pfvf->sq_bmap))
> +				continue;

nit: The indentation of the lines immediately above is not
     consistent with the code around it.

     Flagged by Smatch.

> +
> +		if (rc) {
> +			seq_printf(m, "Failed to read SQ(%d) context\n",
> +				   aq_req.qidx);
> +			continue;
> +		}
> +		print_tm_tree(m, &rsp, aq_req.qidx);
> +	}
> +	return 0;
> +}

...

> +/*dumps given tm_topo registers*/
> +static int rvu_dbg_nix_tm_topo_display(struct seq_file *m, void *unused)
> +{
> +	struct nix_hw *nix_hw = m->private;
> +	struct rvu *rvu = nix_hw->rvu;
> +	struct nix_aq_enq_req aq_req;
> +	struct nix_txsch *txsch;
> +	int nixlf, lvl, schq;
> +	u16 pcifunc;
> +
> +	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
> +
> +	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
> +		return -EINVAL;
> +
> +	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
> +	aq_req.hdr.pcifunc = pcifunc;
> +	aq_req.ctype = NIX_AQ_CTYPE_SQ;
> +	aq_req.op = NIX_AQ_INSTOP_READ;
> +	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
> +
> +	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		txsch = &nix_hw->txsch[lvl];
> +			for (schq = 0; schq < txsch->schq.max; schq++) {
> +				if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) == pcifunc)
> +					print_tm_topo(m, schq, lvl);

Here too.

> +		}
> +	}
> +	return 0;
> +}

-- 
pw-bot: changes-requested

