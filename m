Return-Path: <netdev+bounces-223610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7CB59B06
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3BD1880A07
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7320DD42;
	Tue, 16 Sep 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABAuFL4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1E43147;
	Tue, 16 Sep 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034502; cv=none; b=dD1TmoyCGWG3q2goLaE1astu8scJmCvy3BvPPJIY2+vNUqrAMwO64lNuSHQj/pHxLJxwpgYvPM/wUCaq/9mX8duxFt62ntsoPNCzSAhMbDDt/ZJNE7aynK3dxjeambu2sIMVMLSJRJ6lJVQ9FuTa6mThz+/Dax3DFl7GcUIXXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034502; c=relaxed/simple;
	bh=DUMnhP3cZuk8gcAnDo/SGtQVimDnEe99wMrbQBW2Yyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odgl3zhtVhAlKtigu3f+1Aa/YwdUo1aJDcmHXdKmuaS8OWQKyd2bs6kpX5cCE9brLq+HkdOwE32QrsvswbO5qp89X38HZbgfhga0CdHbzI4o+/VMqScuve3NFV5ezifTmMI5HsaBFPcKgY64xekECdqE39a++/qV11/RAmwK25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABAuFL4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07669C4CEEB;
	Tue, 16 Sep 2025 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034501;
	bh=DUMnhP3cZuk8gcAnDo/SGtQVimDnEe99wMrbQBW2Yyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABAuFL4iXSsJZkjLwzgXKpIlYFNUqnKqUjcRpOPiCxZi3TnU0nvZNP3V4mTGQ0F4L
	 jbal0NlhgdJu+ChOQg/YMACVUGxUwx8oueZIEqmYS3an3lvpT7N4cQPj71+0oV8WQZ
	 oFiusvf1TmHGciCqVKAfSwB74gmhaQuvhBE0CQf74Q4tG7O6WYIQ+CZUc9XA/nchaM
	 fvo8iDCVyVqt/dJnPEygKRLtEKKX2qBDbObl/ipnKkSEZ1jA3Mv+8JzDvy1SSBpMkT
	 4kaawzpzsKTNi3path/QT2YNDrhhXlMRHvbDGLKqm49wnGH2DQwROdpyO5TaGuCmjN
	 CbvGuPo/ApxrA==
Date: Tue, 16 Sep 2025 15:54:57 +0100
From: Simon Horman <horms@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 03/10] bng_en: Add initial support for CP and NQ
 rings
Message-ID: <20250916145457.GH224143@horms.kernel.org>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-4-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911193505.24068-4-bhargava.marreddy@broadcom.com>

On Fri, Sep 12, 2025 at 01:04:58AM +0530, Bhargava Marreddy wrote:
> Allocate CP and NQ related data structures and add support to
> associate NQ and CQ rings. Also, add the association of NQ, NAPI,
> and interrupts.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>

...

> +static int bnge_alloc_nq_tree(struct bnge_net *bn)
> +{
> +	int i, j, ulp_msix, rc = -ENOMEM;
> +	struct bnge_dev *bd = bn->bd;
> +	int tcs = 1;
> +
> +	ulp_msix = bnge_aux_get_msix(bd);
> +	for (i = 0, j = 0; i < bd->nq_nr_rings; i++) {
> +		bool sh = !!(bd->flags & BNGE_EN_SHARED_CHNL);
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr;
> +		struct bnge_cp_ring_info *cpr;
> +		struct bnge_ring_struct *ring;
> +		int cp_count = 0, k;
> +		int rx = 0, tx = 0;
> +
> +		nqr = &bnapi->nq_ring;
> +		nqr->bnapi = bnapi;
> +		ring = &nqr->ring_struct;
> +
> +		rc = bnge_alloc_ring(bd, &ring->ring_mem);
> +		if (rc)
> +			goto err_free_nq_tree;
> +
> +		ring->map_idx = ulp_msix + i;
> +
> +		if (i < bd->rx_nr_rings) {
> +			cp_count++;
> +			rx = 1;
> +		}
> +
> +		if ((sh && i < bd->tx_nr_rings) ||
> +		    (!sh && i >= bd->rx_nr_rings)) {
> +			cp_count += tcs;
> +			tx = 1;
> +		}
> +
> +		nqr->cp_ring_arr = kcalloc(cp_count, sizeof(*cpr),
> +					   GFP_KERNEL);
> +		if (!nqr->cp_ring_arr)

I think that rc should be set to a negative return value, say -ENOMEM,
here. The function returns rc. And as is, rc is 0 at this point.

Flagged by Smatch.

> +			goto err_free_nq_tree;
> +
> +		nqr->cp_ring_count = cp_count;
> +
> +		for (k = 0; k < cp_count; k++) {
> +			cpr = &nqr->cp_ring_arr[k];
> +			rc = alloc_one_cp_ring(bn, cpr);
> +			if (rc)
> +				goto err_free_nq_tree;
> +
> +			cpr->bnapi = bnapi;
> +			cpr->cp_idx = k;
> +			if (!k && rx) {
> +				bn->rx_ring[i].rx_cpr = cpr;
> +				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_RX;
> +			} else {
> +				int n, tc = k - rx;
> +
> +				n = BNGE_TC_TO_RING_BASE(bd, tc) + j;
> +				bn->tx_ring[n].tx_cpr = cpr;
> +				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_TX;
> +			}
> +		}
> +		if (tx)
> +			j++;
> +	}
> +	return 0;
> +
> +err_free_nq_tree:
> +	bnge_free_nq_tree(bn);
> +	return rc;
> +}
> +
>  static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
>  {
>  	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;

