Return-Path: <netdev+bounces-103769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F0190968A
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4615B21E5D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522271401B;
	Sat, 15 Jun 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1ReQlZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095B524C;
	Sat, 15 Jun 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436782; cv=none; b=jyOUOtSWq+gaFl74uBaCC0iRwwpyU1kuKgA7RjDhXqhSERwbnK5s1n9ih+/wxHYPZjEl/QRPgGwjB/rSDnUXyqLee9eGyFMWTt60xPDhrg1RKfhH3GGncWcMjgDOw4lThvGNz53JE78BSCSxLNyRZYwoh687bMVTl4gmDtZYBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436782; c=relaxed/simple;
	bh=wgIviLql9xjHQhQaoRPN2xsCGK+9G4KbVXYZmBVurK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyXu/K9PoTzGj59JQnKZmerSsGWIDo7fA6iB/HlZs2ycZyPt5JA/xWs9MvZJlXjSPUoARrogjCx9nS9npUCntkBZRmy+PdDAUnuUIkFyRMMT8/hgPAD4xN/q0fc7CTUPYx5hrpExdCkiaY4+CpzjfujNKvfmjQqARQg200DPqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ReQlZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268FDC116B1;
	Sat, 15 Jun 2024 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718436781;
	bh=wgIviLql9xjHQhQaoRPN2xsCGK+9G4KbVXYZmBVurK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1ReQlZUGPjAAQriVbxXOTkLhtymELA+gVt31Q7ViXw4uqbhYT7LF+xjWLw8Sm17j
	 6p/Q7kijNVAdhdikXbvQtHZMSgemf8BIQJcjLvaqup19NUJvL8PaekpFiRcAF817F6
	 Cycg6cJnxY2fyhUYINrh8dGoKTzJ62jbn3C511CG6ENMahJF5ppBFTYygkfqPLwDBn
	 ZaxcJ1SzaW5TrjWnV1M9Tkl8BYlMYlTr39AGcI3/qhQlbyfcqh6zfvBI0jWmX9Zj+y
	 bBWRyqAk9RZbXCkfhFrtKL6Gmapm7JAkSziXZgtMsxQTvUF3cvD15UMT1Uih+j3BLl
	 IY81STomopRzw==
Date: Sat, 15 Jun 2024 08:32:56 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 03/12] idpf: split &idpf_queue into 4
 strictly-typed queue structures
Message-ID: <20240615073256.GZ8447@kernel.org>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-4-aleksander.lobakin@intel.com>
 <20240601085308.GY491852@kernel.org>
 <b110726e-d496-4975-8089-57a4931da47d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b110726e-d496-4975-8089-57a4931da47d@intel.com>

On Thu, Jun 13, 2024 at 01:03:00PM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sat, 1 Jun 2024 09:53:08 +0100
> 
> > On Tue, May 28, 2024 at 03:48:37PM +0200, Alexander Lobakin wrote:
> >> Currently, sizeof(struct idpf_queue) is 32 Kb.
> >> This is due to the 12-bit hashtable declaration at the end of the queue.
> >> This HT is needed only for Tx queues when the flow scheduling mode is
> >> enabled. But &idpf_queue is unified for all of the queue types,
> >> provoking excessive memory usage.
> >> The unified structure in general makes the code less effective via
> >> suboptimal fields placement. You can't avoid that unless you make unions
> >> each 2 fields. Even then, different field alignment etc., doesn't allow
> >> you to optimize things to the limit.
> >> Split &idpf_queue into 4 structures corresponding to the queue types:
> >> RQ (Rx queue), SQ (Tx queue), FQ (buffer queue), and CQ (completion
> >> queue). Place only needed fields there and shortcuts handy for hotpath.
> >> Allocate the abovementioned hashtable dynamically and only when needed,
> >> keeping &idpf_tx_queue relatively short (192 bytes, same as Rx). This HT
> >> is used only for OOO completions, which aren't really hotpath anyway.
> >> Note that this change must be done atomically, otherwise it's really
> >> easy to get lost and miss something.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > 
> > ...
> > 
> >> @@ -1158,20 +1325,22 @@ static void idpf_rxq_set_descids(struct idpf_vport *vport, struct idpf_queue *q)
> >>   */
> >>  static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
> >>  {
> >> -	bool flow_sch_en;
> >> -	int err, i;
> >> +	bool split, flow_sch_en;
> >> +	int i;
> >>  
> >>  	vport->txq_grps = kcalloc(vport->num_txq_grp,
> >>  				  sizeof(*vport->txq_grps), GFP_KERNEL);
> >>  	if (!vport->txq_grps)
> >>  		return -ENOMEM;
> >>  
> >> +	split = idpf_is_queue_model_split(vport->txq_model);
> >>  	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
> >>  				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
> >>  
> >>  	for (i = 0; i < vport->num_txq_grp; i++) {
> >>  		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
> >>  		struct idpf_adapter *adapter = vport->adapter;
> >> +		struct idpf_txq_stash *stashes;
> >>  		int j;
> >>  
> >>  		tx_qgrp->vport = vport;
> >> @@ -1180,45 +1349,62 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
> >>  		for (j = 0; j < tx_qgrp->num_txq; j++) {
> >>  			tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
> >>  						   GFP_KERNEL);
> >> -			if (!tx_qgrp->txqs[j]) {
> >> -				err = -ENOMEM;
> >> +			if (!tx_qgrp->txqs[j])
> >>  				goto err_alloc;
> >> -			}
> >> +		}
> >> +
> >> +		if (split && flow_sch_en) {
> >> +			stashes = kcalloc(num_txq, sizeof(*stashes),
> >> +					  GFP_KERNEL);
> > 
> > Hi Alexander,
> > 
> > Here stashes is assigned a memory allocation and
> > then then assigned to tx_qgrp->stashes a few lines below...
> > 
> >> +			if (!stashes)
> >> +				goto err_alloc;
> >> +
> >> +			tx_qgrp->stashes = stashes;
> >>  		}
> >>  
> >>  		for (j = 0; j < tx_qgrp->num_txq; j++) {
> >> -			struct idpf_queue *q = tx_qgrp->txqs[j];
> >> +			struct idpf_tx_queue *q = tx_qgrp->txqs[j];
> >>  
> >>  			q->dev = &adapter->pdev->dev;
> >>  			q->desc_count = vport->txq_desc_count;
> >>  			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
> >>  			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
> >> -			q->vport = vport;
> >> +			q->netdev = vport->netdev;
> >>  			q->txq_grp = tx_qgrp;
> >> -			hash_init(q->sched_buf_hash);
> >>  
> >> -			if (flow_sch_en)
> >> -				set_bit(__IDPF_Q_FLOW_SCH_EN, q->flags);
> >> +			if (!split) {
> >> +				q->clean_budget = vport->compln_clean_budget;
> >> +				idpf_queue_assign(CRC_EN, q,
> >> +						  vport->crc_enable);
> >> +			}
> >> +
> >> +			if (!flow_sch_en)
> >> +				continue;
> >> +
> >> +			if (split) {
> > 
> > ... but here elements of stashes seem to be assigned to q->stash
> > without stashes having being initialised.
> > 
> > Flagged by Smatch
> 
> Hi! Yes, I saw the report, but isn't it a false positive?
> 
> Allocation happens when `split && flow_sch_en`, and here we have
> 
> 			if (!flow_sch_en)
> 				continue;
> 
> 			if (split)
> 				// assign
> 
> IOW the assignment can't happen without the allocation?

Thanks, and sorry for missing the points you highlight above.
I agree that this is a false positive.

> 
> > 
> >> +				q->stash = &stashes[j];
> >> +				hash_init(q->stash->sched_buf_hash);
> >> +			}
> >> +
> >> +			idpf_queue_set(FLOW_SCH_EN, q);
> 
> Thanks,
> Olek
> 

