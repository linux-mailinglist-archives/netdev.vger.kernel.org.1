Return-Path: <netdev+bounces-248345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630DD07282
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7525D300E432
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC92DC789;
	Fri,  9 Jan 2026 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j9ngKOmI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B021A9FAF;
	Fri,  9 Jan 2026 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767933850; cv=none; b=YQZlrVYakhO1JRyY7Y86HZo7hIJ5DuQgeqnNgiMwAUEXwcMCPJ6qhliGwdyxIE79hN0BByzAFWc2XziMWU6dib1z6brlOnYm6rgBpnX/gcqzOLzkSGtcMdUEErmCyz6vnCJWVSJwhlEm59TdMtD2RC2rVEc1DmlWfk74V8JT3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767933850; c=relaxed/simple;
	bh=jUZPS+o0cf5a6lm6yhjUJazhcbeGdNFt5H/UIQLHzz4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdedfjgRuNU3PKNYtf1TYQyC+ojshseTd0g7CbePrdtB649B6EHaM5QJgbER1NsyLgVYnoObVoZqOMtm+9KgZBx1oZELEKT1WkZA8jRMtJPpdIqYMKknycylyZdj7ekvg76I3OwXxGvkcHtHfeFWXz620Pc5b7awucRLSowNxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j9ngKOmI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60934oX1027775;
	Thu, 8 Jan 2026 20:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	kkJL6cmuKH3+5Wdxd3RIrkUbDoi08IB/I+LpuwrIuo=; b=j9ngKOmIhTfZu8MAS
	afx6JF8vls19EGqBzyosOYaD79sST6ucqx9dSO3Rx8ntDamg7jsKuM1iwThLHcW3
	J0La+gddq/q6oixMvdATVuYj7leGvH4iqdD+SEoog5Jt7ZkPYyNy0cIKbEh878Pi
	XAluOfbjVLxVL23+3jCaApndIGnjrWYe39Cf7Ff+D7Jc7Gu2Pl8c8RThLS0nard1
	CTCnetP9tkyD5UJah6e+lTzeWItxFS5CHOtfvVMh+kxkk6LmVzFTfnMJipU9PYq0
	XJJPcpVx+iFTUke/L8XUCAxKwkwcNGvghH4eHzS/YzXO/ccPD3cU3SQKvDiVaK1L
	iukfQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bjset05hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 20:43:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 20:44:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 20:44:10 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B1D065B692B;
	Thu,  8 Jan 2026 20:43:52 -0800 (PST)
Date: Fri, 9 Jan 2026 10:13:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 09/10] octeontx2: switch: Flow offload support
Message-ID: <aWCHh6SowlvPU9K3@rkannoth-OptiPlex-7090>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-10-rkannoth@marvell.com>
 <CAH-L+nMLUUxg9=NgonGHveNogAiqf3s_-Qb0TMm8G+tMh4g3WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nMLUUxg9=NgonGHveNogAiqf3s_-Qb0TMm8G+tMh4g3WA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=W581lBWk c=1 sm=1 tr=0 ts=6960878c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q-fNiiVtAAAA:8 a=M5GUcnROAAAA:8 a=jjUEkCmaLyuL5hvVgDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZAGk_4TzlbQ_FBWFZvU_WwfrowksOtiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAyOSBTYWx0ZWRfX4lKjkBYx30Va
 +vNN/eIgVxM8U+80TC7PgaoIR++Ck0Z6Ac/BAgwbWg5b2PaVoSqgr6Kef9uAdNVuTnwEbrUzBfI
 5v/3CHGdwSaKAKlNyIym8Ew5JAFK5xfh6rWb9Fx1B/uvX3uWXAs39K+RLiq/rKr0yilsC6k2VxP
 63rXywXecxXDRh/BOGup6QUhWEoUGP2UGqdMLn0fEYcxl7HcJrMkmuHuPjKLr1IF9e6HOwE/NBx
 Qzq4clFHNjp2/5CwVIBQKbXSTcUC66KETB4O36LrWKYwDftSIR8sAFXoR63zdd6Kd8OsozC1mKa
 9BdIS4F+ZGBIUWARTASvCl3h84/wVuF9MVnQv0Z2eS5XmeXP4USz5fr1gNHxJHmj+HApQQ9KtwK
 +cT+oDPYvjuHUITFaxUEaAo49yNU1aE6oL3tT21zqdyX7QHIedazF4m/pqgG7vTyeSQy0uIth+9
 aVIqHuDwabAO1FhJDQg==
X-Proofpoint-ORIG-GUID: ZAGk_4TzlbQ_FBWFZvU_WwfrowksOtiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

On 2026-01-08 at 21:37:44, Kalesh Anakkur Purayil (kalesh-anakkur.purayil@broadcom.com) wrote:
> On Wed, Jan 7, 2026 at 7:23 PM Ratheesh Kannoth <rkannoth@marvell.com> wrote:
> >
> > +               return 0;
> > +       }
> > +       mutex_unlock(&sw_fl_stats_lock);
> > +
> > +       snode = kcalloc(1, sizeof(*snode), GFP_KERNEL);
> Why not kzalloc() instead of kcalloc with size 1?
All fields are assigned with values. why to initialize to zero ?

> > +       if (!snode)
> > +
> > +       return 0;
> > +}
> > +
> > +int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt)
> > +{
> > +       struct npc_mcam_get_mul_stats_req *req = NULL;
> > +       struct npc_mcam_get_mul_stats_rsp *rsp = NULL;
> there is no need to initialize these two variables
This is initialized so that (after fail lablel) free() does not act
on garbage value.

> > +       int tot = 0;
> > +       u16 i2idx_map[256];
> follow RCT order
ACK.

> > +       int rc = 0;
> > +       u64 pkts;
> > +       int idx;
> > +
> > +       cnt = min(cnt, 64);
> > +
> > +       for (int i = 0; i < cnt; i++) {
> I think you can move the declaration of i at the beginning of the
> function. it is repeated in the for loops below as well
I think, better to keep the scope local. Does kernel coding guidlines
mandate it ?

> > +               tot++;
> > +               if (fl[i].uni_di)
> > +                       continue;
> > +
> > +               tot++;
> > +       }
> > +
> > +       req = kcalloc(1, sizeof(*req), GFP_KERNEL);
> I think you can use kzalloc kere
ACK.

> > +       if (!req) {
> > +               rc = -ENOMEM;
> You can return directly here
ACK.
> > +               goto fail;
> > +       }
> > +
> > +       rsp = kcalloc(1, sizeof(*rsp), GFP_KERNEL);
> > +       if (!rsp) {
> > +               rc = -ENOMEM;
> > +               goto fail;
> better do individual cleanup by adding a label and use goto free_req
free: lablel is enough , right ?
> > +       }
> > +
> > +       req->cnt = tot;
> > +       idx = 0;
> > +       for (int i = 0; i < tot; idx++) {
> > +               i2idx_map[i] = idx;
> > +               req->entry[i++] = fl[idx].mcam_idx[0];
> > +               if (fl[idx].uni_di)
> > +                       continue;
> > +
> > +               i2idx_map[i] = idx;
> > +               req->entry[i++] = fl[idx].mcam_idx[1];
> > +       }
> > +
> > +       if (rvu_mbox_handler_npc_mcam_mul_stats(rvu, req, rsp)) {
> > +               dev_err(rvu->dev, "Error to get multiple stats\n");
> > +               rc = -EFAULT;
> You can add a new label and use goto free_resp
same comment as above.

>
> > +               goto fail;
> > +       }
> > +
> > +
> > +fail:
> > +       kfree(req);
> > +       kfree(rsp);
> > +       return rc;
> > +}
> > +
> > +       fl_entry->features = req->features;
> > +
> > +       mutex_lock(&fl_offl_llock);
> > +       list_add_tail(&fl_entry->list, &fl_offl_lh);
> > +       mutex_unlock(&fl_offl_llock);
> > +
> > +       if (!fl_offl_work_running) {
> > +               sw_fl_offl_wq = alloc_workqueue("sw_af_fl_wq", 0, 0);
> > +               if (!sw_fl_offl_wq)
> free fl_entry here? also, do you want to move list_add_tail() after
> this if() condition?
ACK.

> > +                       return -ENOMEM;
> > +
> >                   void *type_data)
> >  {
> > +       struct otx2_nic *nic = netdev_priv(netdev);
> > +
> >         switch (type) {
> >         case TC_SETUP_BLOCK:
> > +               if (netif_is_ovs_port(netdev)) {
> > +                       return flow_block_cb_setup_simple(type_data,
> > +                                                         &otx2_block_cb_list,
> > +                                                         sw_fl_setup_ft_block_ingress_cb,
> > +                                                         nic, nic, true);
> > +               }
> braces are not required here
ACK.

> > +
> >                 return otx2_setup_tc_block(netdev, type_data);
> > +}
> > +
> > +static int sw_fl_parse_actions(struct otx2_nic *nic,
> > +                              struct flow_action *flow_action,
> > +                              struct flow_cls_offload *f,
> > +                              struct fl_tuple *tuple, u64 *op)
> > +{
> > +       struct flow_action_entry *act;
> > +       struct otx2_nic *out_nic;
> > +       int err;
> > +       int used = 0;
> RCT order here
ACK.

> > +       int i;
> > +                       return rc;
> > +       }
> > +
> > +       sw_fl_add_to_list(nic, &tuple, f->cookie, true);
> > +       return 0;
> > +}
> > +
> > +static int sw_fl_del(struct otx2_nic *nic, struct flow_cls_offload *f)
> function prototype can be changed to void?
ACK.

> > +{

