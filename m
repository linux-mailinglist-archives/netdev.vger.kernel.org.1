Return-Path: <netdev+bounces-127845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775BB976DD5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A651F21CAB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF41B4C21;
	Thu, 12 Sep 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="isQWtx2v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2144C8F;
	Thu, 12 Sep 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155257; cv=none; b=MXB6vn3JTe9yMS8yf/6FXTeJh5XaME2CJIzg9WDgz4SOJ9GRF1YWD+G7qNBOZV0zKDo4F33mJ1F4VyVx3RpSV2JmqQZmubbW2Sn98IB/lo9KAgx/3OURXuUobnNS6upfmwovrKEUBkemxhuNdD+dh7AQptBx3lzBHaq5FjGCFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155257; c=relaxed/simple;
	bh=uC8bINOlTOIfY7GDaZsn94TvEUHWGpXD3w8N+5Y0huU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjpWkg3UB0x4PlFPcSNrtufZGZsZBUXxTvwNVsdT1hEaxgwNPBgGIUOKmGxMwKdJJsLac1CP4yNSCFHs4Xzt+7cdlCft57oFVR/thofF652WPsJV8qibrMRVbv+zFe9tt1wBTwL+YYuC0ifJxFovrbawlU7dBAzkezVt4bttg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=isQWtx2v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCIpB8032620;
	Thu, 12 Sep 2024 08:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aq9fT8NgBiKDh5qR5sIBRFC0C
	YrCUgRB2Bx0fhZFcEU=; b=isQWtx2vxS8omwYzab16Sz6wvJ/NfmPBl7ah9l+HD
	oTh3vHEc+WRcUE3I8H3bjqS/w/ZY+wZ41SJveVvnCTZyX+avrdnjhUv0HRZ4hFwt
	rNpayGHs9VApGoLW98uk0S7qGmxS/r1qFUBGImaHaUDzVugkQFblmkxy/g+9b9XS
	e7z7dcUZWed3i6RpTzv31Fn5gYQk3ZmD8gdLgH+9pmczgwWfmXvD5PezZ/5uei8a
	EY5LoyRGsWk6D35jUjaNzXhq6/PCNbsqHb5PsArSLZiKYi4JO0ABeRHHh/ikW7mA
	a5+FV8lbTnprDXwHcsrqxjI2+s/NIG/NITrdifvneX8Bw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8ptrbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:33:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 08:33:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Sep 2024 08:33:57 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 3CAF85E6867;
	Thu, 12 Sep 2024 08:33:53 -0700 (PDT)
Date: Thu, 12 Sep 2024 21:03:53 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20240912153353.GA685543@hyd1403.caveonetworks.com>
References: <20240911143303.160124-1-lcherian@marvell.com>
 <20240911143303.160124-2-lcherian@marvell.com>
 <ceb00673-8151-49b0-b36b-75b5dc402041@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ceb00673-8151-49b0-b36b-75b5dc402041@linux.dev>
X-Proofpoint-ORIG-GUID: iFya_YZ93LmftEedqqIijkJdRKfTLSZm
X-Proofpoint-GUID: iFya_YZ93LmftEedqqIijkJdRKfTLSZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Vadim,

On 2024-09-11 at 21:26:03, Vadim Fedorenko (vadim.fedorenko@linux.dev) wrote:
> On 11/09/2024 15:33, Linu Cherian wrote:
> > Add devlink knobs to enable/disable counters on NPC
> > default rule entries.
> > 
> > Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> > for better code reuse, which assumes necessary locks are taken at
> > higher level.
> > 
> > Sample command to enable default rule counters:
> > devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> > 
> > Sample command to read the counter:
> > cat /sys/kernel/debug/cn10k/npc/mcam_rules
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> >   .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
> >   .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
> >   .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 132 ++++++++++++++++--
> >   .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
> >   4 files changed, 171 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > index 43b1d83686d1..fb4b88e94649 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > @@ -526,6 +526,7 @@ struct rvu {
> >   	struct mutex		alias_lock; /* Serialize bar2 alias access */
> >   	int			vfs; /* Number of VFs attached to RVU */
> >   	u16			vf_devid; /* VF devices id */
> > +	bool			def_rule_cntr_en;
> >   	int			nix_blkaddr[MAX_NIX_BLKS];
> >   	/* Mbox */
> > @@ -961,7 +962,11 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
> >   void rvu_npc_enable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
> >   void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
> >   				    int group, int alg_idx, int mcam_index);
> > -
> > +void __rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
> > +					 struct rvu_npc_mcam_rule *rule);
> > +void __rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
> > +				    struct rvu_npc_mcam_rule *rule,
> > +				    struct npc_install_flow_rsp *rsp);
> >   void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
> >   				       int blkaddr, int *alloc_cnt,
> >   				       int *enable_cnt);
> > @@ -986,6 +991,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
> >   void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
> >   			 int blkaddr, u16 src, struct mcam_entry *entry,
> >   			 u8 *intf, u8 *ena);
> > +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
> >   bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
> >   bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
> >   u32  rvu_cgx_get_fifolen(struct rvu *rvu);
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > index 7498ab429963..9c26e19a860b 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > @@ -1238,6 +1238,7 @@ enum rvu_af_dl_param_id {
> >   	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
> >   	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
> >   	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
> > +	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
> >   	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
> >   };
> > @@ -1358,6 +1359,32 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
> >   	return 0;
> >   }
> > +static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 id,
> > +					   struct devlink_param_gset_ctx *ctx)
> > +{
> > +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> > +	struct rvu *rvu = rvu_dl->rvu;
> > +
> > +	ctx->val.vbool = rvu->def_rule_cntr_en;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 id,
> > +					   struct devlink_param_gset_ctx *ctx,
> > +					   struct netlink_ext_ack *extack)
> > +{
> > +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> > +	struct rvu *rvu = rvu_dl->rvu;
> > +	int err;
> > +
> > +	err = npc_config_cntr_default_entries(rvu, ctx->val.vbool);
> > +	if (!err)
> > +		rvu->def_rule_cntr_en = ctx->val.vbool;
> > +
> > +	return err;
> > +}
> > +
> >   static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
> >   				   struct devlink_param_gset_ctx *ctx)
> >   {
> > @@ -1444,6 +1471,11 @@ static const struct devlink_param rvu_af_dl_params[] = {
> >   			     rvu_af_dl_npc_mcam_high_zone_percent_get,
> >   			     rvu_af_dl_npc_mcam_high_zone_percent_set,
> >   			     rvu_af_dl_npc_mcam_high_zone_percent_validate),
> > +	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
> > +			     "npc_def_rule_cntr", DEVLINK_PARAM_TYPE_BOOL,
> > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > +			     rvu_af_dl_npc_def_rule_cntr_get,
> > +			     rvu_af_dl_npc_def_rule_cntr_set, NULL),
> >   	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
> >   			     "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
> >   			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > index 97722ce8c4cb..a766870520b3 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > @@ -2691,6 +2691,51 @@ void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx)
> >   	npc_mcam_set_bit(mcam, entry_idx);
> >   }
> > +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
> > +{
> > +	struct npc_install_flow_rsp rsp = { 0 };
> > +	struct npc_mcam *mcam = &rvu->hw->mcam;
> > +	struct rvu_npc_mcam_rule *rule;
> > +	int blkaddr;
> > +
> > +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> > +	if (blkaddr < 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&mcam->lock);
> > +	list_for_each_entry(rule, &mcam->mcam_rules, list) {
> > +		if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entry))
> > +			continue;
> > +		if (!rule->default_rule)
> > +			continue;
> > +		if (enable && !rule->has_cntr) { /* Alloc and map new counter */
> > +			__rvu_mcam_add_counter_to_rule(rvu, rule->owner,
> > +						       rule, &rsp);
> > +			if (rsp.counter < 0) {
> > +				dev_err(rvu->dev, "%s: Err to allocate cntr for default rule (err=%d)\n",
> > +					__func__, rsp.counter);
> > +				break;
> > +			}
> > +			npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
> > +						    rule->entry, rsp.counter);
> > +		}
> > +
> > +		if (enable && rule->has_cntr) /* Reset counter before use */ {
> > +			rvu_write64(rvu, blkaddr,
> > +				    NPC_AF_MATCH_STATX(rule->cntr), 0x0);
> > +			continue;
> > +		}
> > +
> > +		if (!enable && rule->has_cntr) /* Free and unmap counter */ {
> > +			__rvu_mcam_remove_counter_from_rule(rvu, rule->owner,
> > +							    rule);
> > +		}
> > +	}
> > +	mutex_unlock(&mcam->lock);
> > +
> > +	return 0;
> > +}
> > +
> >   int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
> >   					  struct npc_mcam_alloc_entry_req *req,
> >   					  struct npc_mcam_alloc_entry_rsp *rsp)
> > @@ -2975,9 +3020,9 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
> >   	return rc;
> >   }
> > -int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> > -			struct npc_mcam_alloc_counter_req *req,
> > -			struct npc_mcam_alloc_counter_rsp *rsp)
> > +static int __npc_mcam_alloc_counter(struct rvu *rvu,
> > +				    struct npc_mcam_alloc_counter_req *req,
> > +				    struct npc_mcam_alloc_counter_rsp *rsp)
> >   {
> >   	struct npc_mcam *mcam = &rvu->hw->mcam;
> >   	u16 pcifunc = req->hdr.pcifunc;
> > @@ -2998,7 +3043,6 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> >   	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
> >   		return NPC_MCAM_INVALID_REQ;
> > -	mutex_lock(&mcam->lock);
> >   	/* Check if unused counters are available or not */
> >   	if (!rvu_rsrc_free_count(&mcam->counters)) {
> > @@ -3035,12 +3079,27 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> >   		}
> >   	}
> > -	mutex_unlock(&mcam->lock);
> 
> There is mutex_unlock() left in this function in error path of
> rvu_rsrc_free_count(&mcam->counters)

Ack. Will fix in v2

> 
> >   	return 0;
> >   }
> > -int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
> > -		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
> > +int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> > +			struct npc_mcam_alloc_counter_req *req,
> > +			struct npc_mcam_alloc_counter_rsp *rsp)
> > +{
> > +	struct npc_mcam *mcam = &rvu->hw->mcam;
> > +	int err;
> > +
> > +	mutex_lock(&mcam->lock);
> > +
> > +	err = __npc_mcam_alloc_counter(rvu, req, rsp);
> > +
> > +	mutex_unlock(&mcam->lock);
> > +	return err;
> > +}
> > +
> > +static int __npc_mcam_free_counter(struct rvu *rvu,
> > +				   struct npc_mcam_oper_counter_req *req,
> > +				   struct msg_rsp *rsp)
> >   {
> >   	struct npc_mcam *mcam = &rvu->hw->mcam;
> >   	u16 index, entry = 0;
> > @@ -3050,7 +3109,6 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
> >   	if (blkaddr < 0)
> >   		return NPC_MCAM_INVALID_REQ;
> > -	mutex_lock(&mcam->lock);
> >   	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
> >   	if (err) {
> >   		mutex_unlock(&mcam->lock);
> 
> And here it's even visible in the chunk..

Ack. Thanks for pointing out, somehow missed the error paths.

> 
> > @@ -3077,10 +3135,66 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
> >   					      index, req->cntr);
> >   	}
> > -	mutex_unlock(&mcam->lock);
> >   	return 0;
> >   }
> 

Linu Cherian.


