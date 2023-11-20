Return-Path: <netdev+bounces-49383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313C7F1DD1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD6A1F25EDD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECF37174;
	Mon, 20 Nov 2023 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBIpbica"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0737148
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 20:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7DC433C8;
	Mon, 20 Nov 2023 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700511080;
	bh=nxbWzF54j0YEZFFUREyHOIJr7tRCdcgfC139caCW7yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBIpbicaQWPsMy947TRLqJ1WC7OYcSiylLPywTHDBXncnAakhpqHi5ovU2wfxOEq4
	 9vWE7KjJN/AQgg37ZhMyudAnLX5QpF5e7EyRTmv2F1T6zt1aIblMqtp5tbkWT5Vssk
	 X9KLiAlH0G379khgHUUyP2FPaz4913uNW5wB33QDLKQu1g1dQeORt3jQw+tbCPEQv0
	 PHm3Uc7fhILLgXOqPPTUUhmPq0FaQrNBMRF8zDHg4tjk3YDoCPX+xDO1otY3UmQTNP
	 Uy7oZJaZ0dbJwImjXVE+vFTVFWQSo8tKsB0e6DXSlU2WpKzQ+xD8qeIo3vh05Fa+Mj
	 t+5cCp/835n5Q==
Date: Mon, 20 Nov 2023 20:11:15 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com
Subject: Re: [net-next PATCH 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
Message-ID: <20231120201115.GK245676@kernel.org>
References: <20231116101601.3188711-1-sumang@marvell.com>
 <20231116101601.3188711-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116101601.3188711-2-sumang@marvell.com>

On Thu, Nov 16, 2023 at 03:46:00PM +0530, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

...

> +int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
> +					  struct nix_mcast_grp_update_req *req,
> +					  struct nix_mcast_grp_update_rsp *rsp)
> +{
> +	struct nix_mcast_grp_destroy_req dreq = { 0 };
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	struct nix_mcast_grp_elem *elem;
> +	struct nix_mcast_grp *mcast_grp;
> +	int blkaddr, err, npc_blkaddr;
> +	u16 prev_count, new_count;
> +	struct nix_mcast *mcast;
> +	struct nix_hw *nix_hw;
> +	int i, ret;
> +
> +	if (!req->num_mce_entry)
> +		return 0;
> +
> +	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
> +	if (err)
> +		return err;
> +
> +	mcast_grp = &nix_hw->mcast_grp;
> +	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
> +	if (!elem)
> +		return NIX_AF_ERR_INVALID_MCAST_GRP;
> +
> +	/* If any pcifunc matches the group's pcifunc, then we can
> +	 * delete the entire group.
> +	 */
> +	if (req->op == NIX_MCAST_OP_DEL_ENTRY) {
> +		for (i = 0; i < req->num_mce_entry; i++) {
> +			if (elem->pcifunc == req->pcifunc[i]) {
> +				/* Delete group */
> +				dreq.hdr.pcifunc = elem->pcifunc;
> +				dreq.mcast_grp_idx = elem->mcast_grp_idx;
> +				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	mcast = &nix_hw->mcast;
> +	mutex_lock(&mcast->mce_lock);
> +	npc_blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (elem->mcam_index != -1)
> +		npc_enable_mcam_entry(rvu, mcam, npc_blkaddr, elem->mcam_index, false);
> +
> +	prev_count = elem->mcast_mce_list.count;
> +	if (req->op == NIX_MCAST_OP_ADD_ENTRY) {
> +		new_count = prev_count + req->num_mce_entry;
> +		if (prev_count)
> +			nix_free_mce_list(mcast, prev_count, elem->mce_start_index, elem->dir);
> +
> +		elem->mce_start_index = nix_alloc_mce_list(mcast, new_count, elem->dir);
> +
> +		/* It is possible not to get contiguous memory */
> +		if (elem->mce_start_index < 0) {
> +			if (elem->mcam_index != -1) {
> +				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
> +						      elem->mcam_index, true);
> +				mutex_unlock(&mcast->mce_lock);
> +				return NIX_AF_ERR_NON_CONTIG_MCE_LIST;
> +			}
> +		}
> +
> +		ret = nix_add_mce_list_entry(rvu, nix_hw, elem, req);
> +		if (ret) {
> +			nix_free_mce_list(mcast, new_count, elem->mce_start_index, elem->dir);
> +			if (prev_count)
> +				elem->mce_start_index = nix_alloc_mce_list(mcast,
> +									   prev_count,
> +									   elem->dir);
> +
> +			if (elem->mcam_index != -1)
> +				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
> +						      elem->mcam_index, true);
> +
> +			mutex_unlock(&mcast->mce_lock);
> +			return ret;
> +		}
> +	} else {
> +		if (!prev_count || prev_count < req->num_mce_entry) {
> +			if (elem->mcam_index != -1)
> +				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
> +						      elem->mcam_index, true);

Hi Suman,

It looks like a mutex_unlock() is needed here.

As flagged by Smatch.

> +			return NIX_AF_ERR_INVALID_MCAST_DEL_REQ;
> +		}
> +
> +		nix_free_mce_list(mcast, prev_count, elem->mce_start_index, elem->dir);
> +		new_count = prev_count - req->num_mce_entry;
> +		elem->mce_start_index = nix_alloc_mce_list(mcast, new_count, elem->dir);
> +		ret = nix_del_mce_list_entry(rvu, nix_hw, elem, req);
> +		if (ret) {
> +			nix_free_mce_list(mcast, new_count, elem->mce_start_index, elem->dir);
> +			elem->mce_start_index = nix_alloc_mce_list(mcast, prev_count, elem->dir);
> +			if (elem->mcam_index != -1)
> +				npc_enable_mcam_entry(rvu, mcam,
> +						      npc_blkaddr,
> +						      elem->mcam_index,
> +						      true);
> +
> +			mutex_unlock(&mcast->mce_lock);
> +			return ret;
> +		}
> +	}
> +
> +	if (elem->mcam_index == -1) {
> +		mutex_unlock(&mcast->mce_lock);
> +		rsp->mce_start_index = elem->mce_start_index;
> +		return 0;
> +	}
> +
> +	nix_mcast_update_action(rvu, elem);
> +	npc_enable_mcam_entry(rvu, mcam, npc_blkaddr, elem->mcam_index, true);
> +	mutex_unlock(&mcast->mce_lock);
> +	rsp->mce_start_index = elem->mce_start_index;
> +	return 0;
> +}

...

