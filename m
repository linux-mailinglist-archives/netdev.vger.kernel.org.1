Return-Path: <netdev+bounces-104247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E578D90BC13
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665321F23CB6
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99B199E98;
	Mon, 17 Jun 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANwKa/09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDC166313;
	Mon, 17 Jun 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655582; cv=none; b=GC+qKfyg0wpXVPLl6p2Hiede4ONP7VTOTH2psq8VD9uITfiOY+kPQF5EjvmDkJ5l6CmmTiSe18f7bWIeg22kTEO/P6VxEiGv/MmDrajuistYZg/dbnUDWwXpnEX/CnT6w5V1IukeaLQTHIrcNmiC9poDhkix4dzxWVMYSlhyF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655582; c=relaxed/simple;
	bh=N8x5zJ/pB5kq4w04/hbJ0il4gQkhGn2FR96DWw3tXIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCrxINJ5R86LVbDa5fzn/5bEikvLoprh3zoaSuOV8JptLliCizedjx1HrQKeZXpQwyLHoRR4N9BM1CoYpeWOAfNiNLAapjZLMYqSed7xyxlUYF8HIylhAuFnwRH/CTAyRKULPYUrIKyU0Q69nwppQ6BZW4NzakOjfhOZcJ2xOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANwKa/09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C353EC2BD10;
	Mon, 17 Jun 2024 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718655581;
	bh=N8x5zJ/pB5kq4w04/hbJ0il4gQkhGn2FR96DWw3tXIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANwKa/09gm+TnuisqeyJjkxiOJvOkN6qSPU6i2RtE2TuGMr9XEoyqoJhHbAT1WnAm
	 /9e8q7xLyMDD08DR/nf8fzvUv0Mhpri1rySoQLIvPlMVCOqtfPz3dnsQj/Td64PmII
	 7cJxg3JkVEA4boxVtkIvsKIXZhMPzn5uo5BU+k0HO5OIAy0fnlfBCdG+ChE4nRQloT
	 TkQGLHKBdC9uytdtbd2hLsI9YU2Y3VF1IEMYwV31A1gYAfV2Mryhw8UHDDSwzGlR9W
	 0TviJLqCOyQJ3jEpZNpsrieZsL3MztUA3bRUzHgAfZR0oPgZwa5VhiQzXlyvFcT6kd
	 qJPN7FVMlbN2g==
Date: Mon, 17 Jun 2024 21:19:37 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 05/10] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <20240617201937.GB8447@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-6-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:08PM +0530, Geetha sowjanya wrote:
> Current HW, do not support in-built switch which will forward pkts
> between representee and representor. When representor is put under
> a bridge and pkts needs to be sent to representee, then pkts from
> representor are sent on a HW internal loopback channel, which again
> will be punted to ingress pkt parser. Now the rules that this patch
> installs are the MCAM filters/rules which will match against these
> pkts and forward them to representee.
> The rules that this patch installs are for basic
> representor <=> representee path similar to Tun/TAP between VM and
> Host.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Hi Geetha,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index cf13c5f0a3c5..e137bb9383a2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -13,6 +13,252 @@
>  #include "rvu.h"
>  #include "rvu_reg.h"
>  
> +static int rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> +{
> +	int id;
> +
> +	for (id = 0; id < rvu->rep_cnt; id++)
> +		if (rvu->rep2pfvf_map[id] == pcifunc)
> +			return id;
> +	return -ENODEV;
> +}

rvu_rep_get_vlan_id() can return an error,
but it is not checked by callers. Should it be?
If not, perhaps rvu_rep_get_vlan_id can return a u16?

> +
> +static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
> +			       u16 vlan_tci, int *vidx)
> +{
> +	struct nix_vtag_config_rsp rsp = {};
> +	struct nix_vtag_config req = {};
> +	u64 etype = ETH_P_8021Q;
> +	int err;
> +
> +	/* Insert vlan tag */
> +	req.hdr.pcifunc = pcifunc;
> +	req.vtag_size = VTAGSIZE_T4;
> +	req.cfg_type = 0; /* tx vlan cfg */
> +	req.tx.cfg_vtag0 = true;
> +	req.tx.vtag0 = etype << 48 | ntohs(vlan_tci);

This does not seem correct. vlan_tci is host byte-order,
but ntohs expects a big-endian value as it's argument.

Flagged by Sparse.

> +
> +	err = rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
> +	if (err) {
> +		dev_err(rvu->dev, "Tx vlan config failed\n");
> +		return err;
> +	}
> +	*vidx = rsp.vtag0_idx;
> +	return 0;
> +}

...

> +static int rvu_rep_install_rx_rule(struct rvu *rvu, u16 pcifunc,
> +				   u16 entry, bool rte)
> +{
> +	struct npc_install_flow_req req = {};
> +	struct npc_install_flow_rsp rsp = {};
> +	struct rvu_pfvf *pfvf;
> +	u16 vlan_tci, rep_id;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	/* To stree the traffic from Representee to Representor */

nit: steer

> +	rep_id = (u16)rvu_rep_get_vlan_id(rvu, pcifunc);

This cast seems unnecessary, or at least inconsistent
with the other call to rvu_rep_get_vlan_id.

> +	if (rte) {
> +		vlan_tci = rep_id | 0x1ull << 8;

ull seems a bit excessive as these are otherwise 16bit values.
And in any case, perhaps BIT(8) can be used here.

> +		req.vf = rvu->rep_pcifunc;
> +		req.op = NIX_RX_ACTIONOP_UCAST;
> +		req.index = rep_id;
> +	} else {
> +		vlan_tci = rep_id;
> +		req.vf = pcifunc;
> +		req.op = NIX_RX_ACTION_DEFAULT;
> +	}
> +
> +	rvu_rep_rx_vlan_cfg(rvu, req.vf);
> +	req.entry = entry;
> +	req.hdr.pcifunc = 0; /* AF is requester */
> +	req.features = BIT_ULL(NPC_OUTER_VID) | BIT_ULL(NPC_VLAN_ETYPE_CTAG);
> +	req.vtag0_valid = true;
> +	req.vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE0;
> +	req.packet.vlan_etype = (__be16)ETH_P_8021Q;
> +	req.mask.vlan_etype = (__be16)ETH_P_8021Q;
> +	req.packet.vlan_tci = (__be16)vlan_tci;
> +	req.mask.vlan_tci = (__be16)0xffff;

0xffff is isomorphic, so this point isn't particularly relevant,
but the 3 casts above that don't look right: these are host-byte
order values, they shouldn't be cast as big-endian..

Also flagged by Sparse.

> +
> +	req.channel = RVU_SWITCH_LBK_CHAN;
> +	req.chan_mask = 0xffff;
> +	req.intf = pfvf->nix_rx_intf;
> +
> +	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
> +}
> +
> +static int rvu_rep_install_tx_rule(struct rvu *rvu, u16 pcifunc, u16 entry,
> +				   bool rte)
> +{
> +	struct npc_install_flow_req req = {};
> +	struct npc_install_flow_rsp rsp = {};
> +	struct rvu_pfvf *pfvf;
> +	int vidx, err;
> +	u16 vlan_tci;
> +	u8 lbkid;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +	vlan_tci = rvu_rep_get_vlan_id(rvu, pcifunc);
> +	if (rte)
> +		vlan_tci |= 0x1ull << 8;

BIT(8) seems appropriate here too.

> +
> +	err = rvu_rep_tx_vlan_cfg(rvu, pcifunc, vlan_tci, &vidx);
> +	if (err)
> +		return err;
> +
> +	lbkid = pfvf->nix_blkaddr == BLKADDR_NIX0 ? 0 : 1;
> +	req.hdr.pcifunc = 0; /* AF is requester */
> +	if (rte) {
> +		req.vf = pcifunc;
> +	} else {
> +		req.vf = rvu->rep_pcifunc;
> +		req.packet.sq_id = vlan_tci;
> +		req.mask.sq_id = 0xffff;
> +	}
> +
> +	req.entry = entry;
> +	req.intf = pfvf->nix_tx_intf;
> +	req.op = NIX_TX_ACTIONOP_UCAST_CHAN;
> +	req.index = (lbkid << 8) | RVU_SWITCH_LBK_CHAN;
> +	req.set_cntr = 1;
> +	req.vtag0_def = vidx;
> +	req.vtag0_op = 1;
> +	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
> +}

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 3cb8dc820fdd..e276a354d9e4 100644

...

> @@ -230,7 +248,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>  	return err;
>  }
>  
> -static int rvu_rep_rsrc_free(struct otx2_nic *priv)
> +static void rvu_rep_rsrc_free(struct otx2_nic *priv)
>  {
>  	struct otx2_qset *qset = &priv->qset;
>  	int wrk;
> @@ -241,13 +259,12 @@ static int rvu_rep_rsrc_free(struct otx2_nic *priv)
>  
>  	otx2_free_hw_resources(priv);
>  	otx2_free_queue_mem(qset);
> -	return 0;
>  }
>  
>  static int rvu_rep_rsrc_init(struct otx2_nic *priv)
>  {
>  	struct otx2_qset *qset = &priv->qset;
> -	int err = 0;
> +	int err;
>  
>  	err = otx2_alloc_queue_mem(priv);
>  	if (err)

The last two hunks don't seem strictly related to the rest of this patch.
Perhaps they belong squashed into earlier patches of this series?

