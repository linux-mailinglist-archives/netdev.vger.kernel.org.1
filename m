Return-Path: <netdev+bounces-138554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3D9AE169
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A52E280F1E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6031B3935;
	Thu, 24 Oct 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EJGWuYcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2635166F06;
	Thu, 24 Oct 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763386; cv=none; b=iWgUNUt9fsiAKGLk6IWDpJmdyFMF6IdpZTdpZ+UxjxrccIzdLupovdJ0mwH8DMaQmEi48QTEzE5Ap7lf2Q6kbZJzua8s7WnCQVnw5UUyJiIV/rXkYC+RY1sfXp98eDSrOMWuV6jfF8MApei4X2uTFycrUtQyPo7yxosbWqYXGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763386; c=relaxed/simple;
	bh=FdxVpkwROgfRo4NpkdMOJikI0SI83egZ0IbwA6LonrM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ/TqR7+4tGBQ/ZzjRABdcSg6/hhGQwhuXDjwQDYsFXM9mBtyzNDS8SKtfC7Q6SBEz4rrNIZcvad2fM4hY2eF4Lxk71YVLMxcVAMv3MXDIpTQ74RureWea06PahPxuqyHafNcHTlEjW+FCofQ1notvMKO6cqNbrKHK9YWL4BH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EJGWuYcJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O4aeZP019255;
	Thu, 24 Oct 2024 02:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	AjAsZRNCH1nOdhURKkxwGjCfW4i1UoaL890M+Zr+m4=; b=EJGWuYcJiC9idP44e
	CtiJpmWnsCrJdC9NzQPFIShvbX0VqfOwANsYFkbs7IKtaOMENTVhaj+hKa8oUXaO
	xsmNt9iZ72oXdVs8GBrgVSCTauAE/GN1kCJJ4scSP8PoOjl3MXelpAQsGGjdiEZi
	8qVEuXt0pB3ROMVJ+YmzgzaGNlJMbNV63QvunB7wsrI/1SBUE4Vn0DSUepkJxstk
	bfPJE66eBo6kbonC/hzTD1DE3nsfNC+Evy8LLMnKcBQW5iLRNVxRDh45KbrdJW2Z
	HZGhYqv1rMMEl0cxEQ5PWimN/LYkxM7HJhNCIk7kzlQa5h4i/MXqEwBEGtJNP/MQ
	QI0Yw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42ffbvrje0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 02:49:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 02:49:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 02:49:20 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with ESMTP id 855643F709B;
	Thu, 24 Oct 2024 02:49:16 -0700 (PDT)
Date: Thu, 24 Oct 2024 15:19:15 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <jerinj@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 2/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20241024094915.GA954957@hyd1403.caveonetworks.com>
References: <20241017084244.1654907-1-lcherian@marvell.com>
 <20241017084244.1654907-3-lcherian@marvell.com>
 <CAH-L+nMRhE4c-Q43+LXFq_MNU7qzBdysTP=Smd3GXtbyJQoPBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nMRhE4c-Q43+LXFq_MNU7qzBdysTP=Smd3GXtbyJQoPBQ@mail.gmail.com>
X-Proofpoint-GUID: rYBxsXTECHGO7YvdVUKdg771HLlv4M0t
X-Proofpoint-ORIG-GUID: rYBxsXTECHGO7YvdVUKdg771HLlv4M0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Kalesh,

On 2024-10-18 at 08:39:40, Kalesh Anakkur Purayil (kalesh-anakkur.purayil@broadcom.com) wrote:
> On Thu, Oct 17, 2024 at 2:14 PM Linu Cherian <lcherian@marvell.com> wrote:
> >
> > Add devlink knobs to enable/disable counters on NPC
> > default rule entries.
> >
> > Sample command to enable default rule counters:
> > devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> >
> > Sample command to read the counter:
> > cat /sys/kernel/debug/cn10k/npc/mcam_rules
> >
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changelog from v2:
> > Moved out the refactoring into separate patch.
> >
> >  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
> >  .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++++
> >  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 45 +++++++++++++++++++
> >  3 files changed, 79 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > index d92a5f47a476..e8c6a6fe9bd5 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > @@ -525,6 +525,7 @@ struct rvu {
> >         struct mutex            alias_lock; /* Serialize bar2 alias access */
> >         int                     vfs; /* Number of VFs attached to RVU */
> >         u16                     vf_devid; /* VF devices id */
> > +       bool                    def_rule_cntr_en;
> >         int                     nix_blkaddr[MAX_NIX_BLKS];
> >
> >         /* Mbox */
> > @@ -989,6 +990,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
> >  void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
> >                          int blkaddr, u16 src, struct mcam_entry *entry,
> >                          u8 *intf, u8 *ena);
> > +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
> >  bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
> >  bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
> >  u32  rvu_cgx_get_fifolen(struct rvu *rvu);
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > index 7498ab429963..9c26e19a860b 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > @@ -1238,6 +1238,7 @@ enum rvu_af_dl_param_id {
> >         RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
> >         RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
> >         RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
> > +       RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
> >         RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
> >  };
> >
> > @@ -1358,6 +1359,32 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
> >         return 0;
> >  }
> >
> > +static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 id,
> > +                                          struct devlink_param_gset_ctx *ctx)
> > +{
> > +       struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> > +       struct rvu *rvu = rvu_dl->rvu;
> > +
> > +       ctx->val.vbool = rvu->def_rule_cntr_en;
> > +
> > +       return 0;
> > +}
> > +
> > +static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 id,
> > +                                          struct devlink_param_gset_ctx *ctx,
> > +                                          struct netlink_ext_ack *extack)
> > +{
> > +       struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> > +       struct rvu *rvu = rvu_dl->rvu;
> > +       int err;
> > +
> > +       err = npc_config_cntr_default_entries(rvu, ctx->val.vbool);
> > +       if (!err)
> > +               rvu->def_rule_cntr_en = ctx->val.vbool;
> > +
> > +       return err;
> > +}
> > +
> >  static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
> >                                    struct devlink_param_gset_ctx *ctx)
> >  {
> > @@ -1444,6 +1471,11 @@ static const struct devlink_param rvu_af_dl_params[] = {
> >                              rvu_af_dl_npc_mcam_high_zone_percent_get,
> >                              rvu_af_dl_npc_mcam_high_zone_percent_set,
> >                              rvu_af_dl_npc_mcam_high_zone_percent_validate),
> > +       DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
> > +                            "npc_def_rule_cntr", DEVLINK_PARAM_TYPE_BOOL,
> > +                            BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > +                            rvu_af_dl_npc_def_rule_cntr_get,
> > +                            rvu_af_dl_npc_def_rule_cntr_set, NULL),
> >         DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
> >                              "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
> >                              BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > index c4ef1e83cc46..9e39c3149a4f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > @@ -2691,6 +2691,51 @@ void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx)
> >         npc_mcam_set_bit(mcam, entry_idx);
> >  }
> >
> > +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
> > +{
> > +       struct npc_install_flow_rsp rsp = { 0 };
> > +       struct npc_mcam *mcam = &rvu->hw->mcam;
> [Kalesh] Maintain RCT order for variable declarartion

Not seeing an issue on my vim editor. Could you please recheck if this
is mail client issue ?

Thanks
Linu Cherian.

