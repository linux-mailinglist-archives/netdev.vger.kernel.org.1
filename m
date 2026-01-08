Return-Path: <netdev+bounces-248146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EDD04C15
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61E53575649
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEAC24EF8C;
	Thu,  8 Jan 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q1juBUWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629A19E97F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888484; cv=none; b=UO+0pnbXRG3JdCfDX0bZ0FOrqy6j3tmq/CfWen7JZ7RSLHsZYLixJnMpGLIxODeEk8rmaKP1jgPcvYQ22UqAww3tCSnkEevua2NcIgaqZlM2Tuh1ML7bN4nFXzTICy+h0AJWvRDqnEL0Hr/RE+asqkzBCGvlCvQQVbyOfuW3kHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888484; c=relaxed/simple;
	bh=LcK8oxgqaeNoVfEfihgcaI1zbz8G4PiwtTPO9XcKRLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mj6O5atIb/G1sSLPEEVp2k8tAaM+vVIC7aM57MHPN7KCwFQvARXoKzYZgr/4KN6DBvxw0XgkomgZFqXYC1QTbbZ3nQzHnFyJIHXt60l4lb7zgJrl5w+0mJRntNG0YcWw2af2T6heos/FyuqxWC8iRSuAvEdb7KTKjUJtnzb9eJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q1juBUWZ; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-5ed065f1007so1313982137.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888481; x=1768493281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJrl9bE4LPbkH8ZTmXqfPkYx9senBnV/Y9rXC1bJQno=;
        b=nyicahTQw1dI2WayP6+8rlI5Er5c8Lxs+2eFeYoFyyYgy1Kqll1YCLjIeaYuqxA0sQ
         XCylgYpjq1gEc+CMOg0YNjV5lj83RL2E44xBiuPWLFXNlGhlipefiRDpcEg6C3aaPlJc
         pbeTj/dWehsYiIZJ8pR3wGOxhYX3/MVYoi4KOngvn8TXd1AYkWbFNOwENKg9/wxSnxVt
         qlYAZo/YfAEwX+uV40MG3OpXDHo8xTZNDHhTUC3R+yYxQ4VdJyBV4bNVeOYAjAowXQ8G
         EvrPSW/BBv/kq/PYM6AY/N/CYqGqCMuFl1Xxara2PbDAiUnnrXm5l4vzBCVkCOKJQ7gj
         8e1w==
X-Gm-Message-State: AOJu0YxXI6w5/PHdCfqJat94I06IX1+bYPbqXE54r8IeFNNoy/ArBe9W
	cbZDfvoQuJkQBRWu67qvUdxP385O2SA/v8g8ZGq1+wcynPFyQ6JPTuA29kyqAMg/ANjcj7tlyB8
	a/msl6eCjZz+3cm/rmHZnihlcGxFgrJWtzShajpr7W04Olfp/n3+VOR5uWQyn81XPvQLh5e33nu
	yrsL338JFD9XLgXXrFLtWvbsbnPO0LeNRp/p6kNXWN3e9affiaQpaeXn6MR5uG6hjJb6IsdRbKM
	CYPJkT+y1EwtcKnPwJ9P9vG
X-Gm-Gg: AY/fxX4EJBKmBV34Ri3gbC0Ne5wZs+6J/G+Noo/0TFcFMCmk3OPVpcyE506tNfaQ6zB
	Skjf9WfGSfWxfx/zSBAJuUuGvCH3g17UBppMbxcuU0MtRV1lBnEQIqM8og4vI7G4eltBloGs/ba
	2SexiQvhb+xuholZb01SidDvv86zFLrtrGwvIseVbTLuOPkBeoo0ooVeaL32G0GcKrwxgmK+i+N
	JzODV8X3mSlBrGRFYdmJ09TD+4QXC50+UMqXemkodCC1TlyE82bK9/IRFOMjPEVZUKXue8b275M
	FIK4fMR8hv3069d8ZXizkFnH4qtixxfB3e5MDlw9pK2kvshn71B+SBP4qCjERkcFCm1GNQj6dHi
	9Jxd4s/wCEw1i1XwrnXJfsZkwKim1Ax7ADiMaed+qb3GyNIvV9wUsHWvQEPsJo7x+LdMrmwMOov
	QM3YT4dx08fv2v5FtJMMYCPFJ2ituE6dSN+hzbjZ25d094jzdVg5wHyKg=
X-Google-Smtp-Source: AGHT+IE7wmEQB1wePdwk+1zvtuYNcGCYSf9umBYAscEv89THSidThl2tDfyiWXb1CZtmAkjSZ8fhG8/a/8Ds
X-Received: by 2002:a05:6102:509f:b0:5e1:866c:4f7c with SMTP id ada2fe7eead31-5ecbae54407mr2630133137.39.1767888479464;
        Thu, 08 Jan 2026 08:07:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077154339sm9991676d6.26.2026.01.08.08.07.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 08:07:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ea5074935so3910355a91.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767888478; x=1768493278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJrl9bE4LPbkH8ZTmXqfPkYx9senBnV/Y9rXC1bJQno=;
        b=Q1juBUWZfdeerg/4lyFM3T9eEEBnKadUC8uBS8VkDA0NdwQ7pZg9+o3KfBV5fW3NXw
         GEV80NNuHNORlcTARhHZxLnbiT0C9KtqaaVyjAEZI00KSuk5FGyT0Z7qQspkM7Qmymcg
         dOhVqo0QzA0s+mp5TU2C2sTT6ME32MrBNx2AI=
X-Received: by 2002:a17:90b:4014:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-34f68cefc0fmr4365227a91.34.1767888477768;
        Thu, 08 Jan 2026 08:07:57 -0800 (PST)
X-Received: by 2002:a17:90b:4014:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-34f68cefc0fmr4365204a91.34.1767888477157; Thu, 08 Jan 2026
 08:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107132408.3904352-1-rkannoth@marvell.com> <20260107132408.3904352-10-rkannoth@marvell.com>
In-Reply-To: <20260107132408.3904352-10-rkannoth@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 8 Jan 2026 21:37:44 +0530
X-Gm-Features: AQt7F2o8xtGJoapWwgGebHsv8mhdhnGzjepO_tlLiesKuWGcDz4_uhgcGblLgpQ
Message-ID: <CAH-L+nMLUUxg9=NgonGHveNogAiqf3s_-Qb0TMm8G+tMh4g3WA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/10] octeontx2: switch: Flow offload support
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrew+netdev@lunn.ch, sgoutham@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3b8ce0647e29cc0"

--000000000000c3b8ce0647e29cc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:23=E2=80=AFPM Ratheesh Kannoth <rkannoth@marvell.c=
om> wrote:
>
> OVS/NFT pushed HW acceleration rules to pf driver thru .ndo_tc().
> Switchdev HW flow table is filled with this information.
> Once populated, flow will be accelerated.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../marvell/octeontx2/af/switch/rvu_sw.c      |   4 +
>  .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 278 ++++++++++
>  .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  17 +-
>  .../marvell/octeontx2/nic/switch/sw_fl.c      | 520 ++++++++++++++++++
>  .../marvell/octeontx2/nic/switch/sw_fl.h      |   2 +
>  .../marvell/octeontx2/nic/switch/sw_nb.c      |   1 -
>  7 files changed, 822 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/=
drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> index fe91b0a6baf5..10aed0ca5934 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> @@ -37,6 +37,10 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
>         case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
>                 rc =3D rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, re=
q->mac);
>                 break;
> +
> +       case SWDEV2AF_MSG_TYPE_REFRESH_FL:
> +               rc =3D rvu_sw_fl_stats_sync2db(rvu, req->fl, req->cnt);
> +               break;
>         }
>
>         return rc;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c=
 b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> index 1f8b82a84a5d..3cca0672d9cf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
> @@ -4,12 +4,260 @@
>   * Copyright (C) 2026 Marvell.
>   *
>   */
> +
> +#include <linux/bitfield.h>
>  #include "rvu.h"
> +#include "rvu_sw.h"
> +#include "rvu_sw_fl.h"
> +
> +#define M(_name, _id, _fn_name, _req_type, _rsp_type)                  \
> +static struct _req_type __maybe_unused                                 \
> +*otx2_mbox_alloc_msg_ ## _fn_name(struct rvu *rvu, int devid)          \
> +{                                                                      \
> +       struct _req_type *req;                                          \
> +                                                                       \
> +       req =3D (struct _req_type *)otx2_mbox_alloc_msg_rsp(             =
 \
> +               &rvu->afpf_wq_info.mbox_up, devid, sizeof(struct _req_typ=
e), \
> +               sizeof(struct _rsp_type));                              \
> +       if (!req)                                                       \
> +               return NULL;                                            \
> +       req->hdr.sig =3D OTX2_MBOX_REQ_SIG;                              =
 \
> +       req->hdr.id =3D _id;                                             =
 \
> +       return req;                                                     \
> +}
> +
> +MBOX_UP_AF2SWDEV_MESSAGES
> +#undef M
> +
> +static struct workqueue_struct *sw_fl_offl_wq;
> +
> +struct fl_entry {
> +       struct list_head list;
> +       struct rvu *rvu;
> +       u32 port_id;
> +       unsigned long cookie;
> +       struct fl_tuple tuple;
> +       u64 flags;
> +       u64 features;
> +};
> +
> +static DEFINE_MUTEX(fl_offl_llock);
> +static LIST_HEAD(fl_offl_lh);
> +static bool fl_offl_work_running;
> +
> +static struct workqueue_struct *sw_fl_offl_wq;
> +static void sw_fl_offl_work_handler(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(fl_offl_work, sw_fl_offl_work_handler);
> +
> +struct sw_fl_stats_node {
> +       struct list_head list;
> +       unsigned long cookie;
> +       u16 mcam_idx[2];
> +       u64 opkts, npkts;
> +       bool uni_di;
> +};
> +
> +static LIST_HEAD(sw_fl_stats_lh);
> +static DEFINE_MUTEX(sw_fl_stats_lock);
> +
> +static int
> +rvu_sw_fl_stats_sync2db_one_entry(unsigned long cookie, u8 disabled,
> +                                 u16 mcam_idx[2], bool uni_di, u64 pkts)
> +{
> +       struct sw_fl_stats_node *snode, *tmp;
> +
> +       mutex_lock(&sw_fl_stats_lock);
> +       list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
> +               if (snode->cookie !=3D cookie)
> +                       continue;
> +
> +               if (disabled) {
> +                       list_del_init(&snode->list);
> +                       mutex_unlock(&sw_fl_stats_lock);
> +                       kfree(snode);
> +                       return 0;
> +               }
> +
> +               if (snode->uni_di !=3D uni_di) {
> +                       snode->uni_di =3D uni_di;
> +                       snode->mcam_idx[1] =3D mcam_idx[1];
> +               }
> +
> +               if (snode->opkts =3D=3D pkts) {
> +                       mutex_unlock(&sw_fl_stats_lock);
> +                       return 0;
> +               }
> +
> +               snode->npkts =3D pkts;
> +               mutex_unlock(&sw_fl_stats_lock);
> +               return 0;
> +       }
> +       mutex_unlock(&sw_fl_stats_lock);
> +
> +       snode =3D kcalloc(1, sizeof(*snode), GFP_KERNEL);
Why not kzalloc() instead of kcalloc with size 1?
> +       if (!snode)
> +               return -ENOMEM;
> +
> +       snode->cookie =3D cookie;
> +       snode->mcam_idx[0] =3D mcam_idx[0];
> +       if (!uni_di)
> +               snode->mcam_idx[1] =3D mcam_idx[1];
> +
> +       snode->npkts =3D pkts;
> +       snode->uni_di =3D uni_di;
> +       INIT_LIST_HEAD(&snode->list);
> +
> +       mutex_lock(&sw_fl_stats_lock);
> +       list_add_tail(&snode->list, &sw_fl_stats_lh);
> +       mutex_unlock(&sw_fl_stats_lock);
> +
> +       return 0;
> +}
> +
> +int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt=
)
> +{
> +       struct npc_mcam_get_mul_stats_req *req =3D NULL;
> +       struct npc_mcam_get_mul_stats_rsp *rsp =3D NULL;
there is no need to initialize these two variables
> +       int tot =3D 0;
> +       u16 i2idx_map[256];
follow RCT order
> +       int rc =3D 0;
> +       u64 pkts;
> +       int idx;
> +
> +       cnt =3D min(cnt, 64);
> +
> +       for (int i =3D 0; i < cnt; i++) {
I think you can move the declaration of i at the beginning of the
function. it is repeated in the for loops below as well
> +               tot++;
> +               if (fl[i].uni_di)
> +                       continue;
> +
> +               tot++;
> +       }
> +
> +       req =3D kcalloc(1, sizeof(*req), GFP_KERNEL);
I think you can use kzalloc kere
> +       if (!req) {
> +               rc =3D -ENOMEM;
You can return directly here
> +               goto fail;
> +       }
> +
> +       rsp =3D kcalloc(1, sizeof(*rsp), GFP_KERNEL);
> +       if (!rsp) {
> +               rc =3D -ENOMEM;
> +               goto fail;
better do individual cleanup by adding a label and use goto free_req
> +       }
> +
> +       req->cnt =3D tot;
> +       idx =3D 0;
> +       for (int i =3D 0; i < tot; idx++) {
> +               i2idx_map[i] =3D idx;
> +               req->entry[i++] =3D fl[idx].mcam_idx[0];
> +               if (fl[idx].uni_di)
> +                       continue;
> +
> +               i2idx_map[i] =3D idx;
> +               req->entry[i++] =3D fl[idx].mcam_idx[1];
> +       }
> +
> +       if (rvu_mbox_handler_npc_mcam_mul_stats(rvu, req, rsp)) {
> +               dev_err(rvu->dev, "Error to get multiple stats\n");
> +               rc =3D -EFAULT;
You can add a new label and use goto free_resp

> +               goto fail;
> +       }
> +
> +       for (int i =3D 0; i < tot;) {
> +               idx =3D i2idx_map[i];
> +               pkts =3D  rsp->stat[i++];
> +
> +               if (!fl[idx].uni_di)
> +                       pkts +=3D rsp->stat[i++];
> +
> +               rc |=3D rvu_sw_fl_stats_sync2db_one_entry(fl[idx].cookie,=
 fl[idx].dis,
> +                                                       fl[idx].mcam_idx,
> +                                                       fl[idx].uni_di, p=
kts);
> +       }
> +
> +fail:
> +       kfree(req);
> +       kfree(rsp);
> +       return rc;
> +}
> +
> +static void sw_fl_offl_dump(struct fl_entry *fl_entry)
> +{
> +       struct fl_tuple *tuple =3D &fl_entry->tuple;
> +
> +       pr_debug("%pI4 to %pI4\n", &tuple->ip4src, &tuple->ip4dst);
> +}
> +
> +static int rvu_sw_fl_offl_rule_push(struct fl_entry *fl_entry)
> +{
> +       struct af2swdev_notify_req *req;
> +       struct rvu *rvu;
> +       int swdev_pf;
> +
> +       rvu =3D fl_entry->rvu;
> +       swdev_pf =3D rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
> +
> +       mutex_lock(&rvu->mbox_lock);
> +       req =3D otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
> +       if (!req) {
> +               mutex_unlock(&rvu->mbox_lock);
> +               return -ENOMEM;
> +       }
> +
> +       req->tuple =3D fl_entry->tuple;
> +       req->flags =3D fl_entry->flags;
> +       req->cookie =3D fl_entry->cookie;
> +       req->features =3D fl_entry->features;
> +
> +       sw_fl_offl_dump(fl_entry);
> +
> +       otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +       otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +
> +       mutex_unlock(&rvu->mbox_lock);
> +       return 0;
> +}
> +
> +static void sw_fl_offl_work_handler(struct work_struct *work)
> +{
> +       struct fl_entry *fl_entry;
> +
> +       mutex_lock(&fl_offl_llock);
> +       fl_entry =3D list_first_entry_or_null(&fl_offl_lh, struct fl_entr=
y, list);
> +       if (!fl_entry) {
> +               mutex_unlock(&fl_offl_llock);
> +               return;
> +       }
> +
> +       list_del_init(&fl_entry->list);
> +       mutex_unlock(&fl_offl_llock);
> +
> +       rvu_sw_fl_offl_rule_push(fl_entry);
> +       kfree(fl_entry);
> +
> +       mutex_lock(&fl_offl_llock);
> +       if (!list_empty(&fl_offl_lh))
> +               queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to=
_jiffies(10));
> +       mutex_unlock(&fl_offl_llock);
> +}
>
>  int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
>                                   struct fl_get_stats_req *req,
>                                   struct fl_get_stats_rsp *rsp)
>  {
> +       struct sw_fl_stats_node *snode, *tmp;
> +
> +       mutex_lock(&sw_fl_stats_lock);
> +       list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
> +               if (snode->cookie !=3D req->cookie)
> +                       continue;
> +
> +               rsp->pkts_diff =3D snode->npkts - snode->opkts;
> +               snode->opkts =3D snode->npkts;
> +               break;
> +       }
> +       mutex_unlock(&sw_fl_stats_lock);
>         return 0;
>  }
>
> @@ -17,5 +265,35 @@ int rvu_mbox_handler_fl_notify(struct rvu *rvu,
>                                struct fl_notify_req *req,
>                                struct msg_rsp *rsp)
>  {
> +       struct fl_entry *fl_entry;
> +
> +       if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
> +               return 0;
> +
> +       fl_entry =3D kcalloc(1, sizeof(*fl_entry), GFP_KERNEL);
> +       if (!fl_entry)
> +               return -ENOMEM;
> +
> +       fl_entry->port_id =3D rvu_sw_port_id(rvu, req->hdr.pcifunc);
> +       fl_entry->rvu =3D rvu;
> +       INIT_LIST_HEAD(&fl_entry->list);
> +       fl_entry->tuple =3D req->tuple;
> +       fl_entry->cookie =3D req->cookie;
> +       fl_entry->flags =3D req->flags;
> +       fl_entry->features =3D req->features;
> +
> +       mutex_lock(&fl_offl_llock);
> +       list_add_tail(&fl_entry->list, &fl_offl_lh);
> +       mutex_unlock(&fl_offl_llock);
> +
> +       if (!fl_offl_work_running) {
> +               sw_fl_offl_wq =3D alloc_workqueue("sw_af_fl_wq", 0, 0);
> +               if (!sw_fl_offl_wq)
free fl_entry here? also, do you want to move list_add_tail() after
this if() condition?
> +                       return -ENOMEM;
> +
> +               fl_offl_work_running =3D true;
> +       }
> +       queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies=
(10));
> +
>         return 0;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h=
 b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
> index cf3e5b884f77..aa375413bc14 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
> @@ -8,4 +8,6 @@
>  #ifndef RVU_SW_FL_H
>  #define RVU_SW_FL_H
>
> +int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt=
);
> +
>  #endif
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 26a08d2cfbb1..716764d74e6a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -20,6 +20,7 @@
>  #include "cn10k.h"
>  #include "otx2_common.h"
>  #include "qos.h"
> +#include "switch/sw_fl.h"
>
>  #define CN10K_MAX_BURST_MANTISSA       0x7FFFULL
>  #define CN10K_MAX_BURST_SIZE           8453888ULL
> @@ -1238,7 +1239,6 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>                 mutex_unlock(&nic->mbox.lock);
>         }
>
> -
>  free_mcam_flow:
>         otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
>         otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
> @@ -1595,11 +1595,26 @@ static int otx2_setup_tc_block(struct net_device =
*netdev,
>  int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>                   void *type_data)
>  {
> +       struct otx2_nic *nic =3D netdev_priv(netdev);
> +
>         switch (type) {
>         case TC_SETUP_BLOCK:
> +               if (netif_is_ovs_port(netdev)) {
> +                       return flow_block_cb_setup_simple(type_data,
> +                                                         &otx2_block_cb_=
list,
> +                                                         sw_fl_setup_ft_=
block_ingress_cb,
> +                                                         nic, nic, true)=
;
> +               }
braces are not required here
> +
>                 return otx2_setup_tc_block(netdev, type_data);
>         case TC_SETUP_QDISC_HTB:
>                 return otx2_setup_tc_htb(netdev, type_data);
> +
> +       case TC_SETUP_FT:
> +               return flow_block_cb_setup_simple(type_data,
> +                                                 &otx2_block_cb_list,
> +                                                 sw_fl_setup_ft_block_in=
gress_cb,
> +                                                 nic, nic, true);
>         default:
>                 return -EOPNOTSUPP;
>         }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/=
drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> index 36a2359a0a48..fbb56f9bede9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
> @@ -4,13 +4,533 @@
>   * Copyright (C) 2026 Marvell.
>   *
>   */
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <net/switchdev.h>
> +#include <net/netevent.h>
> +#include <net/arp.h>
> +#include <net/nexthop.h>
> +#include <net/netfilter/nf_flow_table.h>
> +
> +#include "../otx2_reg.h"
> +#include "../otx2_common.h"
> +#include "../otx2_struct.h"
> +#include "../cn10k.h"
> +#include "sw_nb.h"
>  #include "sw_fl.h"
>
> +#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
> +                                   void *type_data, void *cb_priv)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +#else
> +
> +static DEFINE_SPINLOCK(sw_fl_lock);
> +static LIST_HEAD(sw_fl_lh);
> +
> +struct sw_fl_list_entry {
> +       struct list_head list;
> +       u64 flags;
> +       unsigned long cookie;
> +       struct otx2_nic *pf;
> +       struct fl_tuple tuple;
> +};
> +
> +static struct workqueue_struct *sw_fl_wq;
> +static struct work_struct sw_fl_work;
> +
> +static int sw_fl_msg_send(struct otx2_nic *pf,
> +                         struct fl_tuple *tuple,
> +                         u64 flags,
> +                         unsigned long cookie)
> +{
> +       struct fl_notify_req *req;
> +       int rc;
> +
> +       mutex_lock(&pf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_fl_notify(&pf->mbox);
> +       if (!req) {
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       req->tuple =3D *tuple;
> +       req->flags =3D flags;
> +       req->cookie =3D cookie;
> +
> +       rc =3D otx2_sync_mbox_msg(&pf->mbox);
> +out:
> +       mutex_unlock(&pf->mbox.lock);
> +       return rc;
> +}
> +
> +static void sw_fl_wq_handler(struct work_struct *work)
> +{
> +       struct sw_fl_list_entry *entry;
> +       LIST_HEAD(tlist);
> +
> +       spin_lock(&sw_fl_lock);
> +       list_splice_init(&sw_fl_lh, &tlist);
> +       spin_unlock(&sw_fl_lock);
> +
> +       while ((entry =3D
> +               list_first_entry_or_null(&tlist,
> +                                        struct sw_fl_list_entry,
> +                                        list)) !=3D NULL) {
> +               list_del_init(&entry->list);
> +               sw_fl_msg_send(entry->pf, &entry->tuple,
> +                              entry->flags, entry->cookie);
> +               kfree(entry);
> +       }
> +
> +       spin_lock(&sw_fl_lock);
> +       if (!list_empty(&sw_fl_lh))
> +               queue_work(sw_fl_wq, &sw_fl_work);
> +       spin_unlock(&sw_fl_lock);
> +}
> +
> +static int
> +sw_fl_add_to_list(struct otx2_nic *pf, struct fl_tuple *tuple,
> +                 unsigned long cookie, bool add_fl)
> +{
> +       struct sw_fl_list_entry *entry;
> +
> +       entry =3D kcalloc(1, sizeof(*entry), GFP_ATOMIC);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       entry->pf =3D pf;
> +       entry->flags =3D add_fl ? FL_ADD : FL_DEL;
> +       if (add_fl)
> +               entry->tuple =3D *tuple;
> +       entry->cookie =3D cookie;
> +       entry->tuple.uni_di =3D netif_is_ovs_port(pf->netdev);
> +
> +       spin_lock(&sw_fl_lock);
> +       list_add_tail(&entry->list, &sw_fl_lh);
> +       queue_work(sw_fl_wq, &sw_fl_work);
> +       spin_unlock(&sw_fl_lock);
> +
> +       return 0;
> +}
> +
> +static int sw_fl_parse_actions(struct otx2_nic *nic,
> +                              struct flow_action *flow_action,
> +                              struct flow_cls_offload *f,
> +                              struct fl_tuple *tuple, u64 *op)
> +{
> +       struct flow_action_entry *act;
> +       struct otx2_nic *out_nic;
> +       int err;
> +       int used =3D 0;
RCT order here
> +       int i;
> +
> +       if (!flow_action_has_entries(flow_action))
> +               return -EINVAL;
> +
> +       flow_action_for_each(i, act, flow_action) {
> +               WARN_ON(used >=3D MANGLE_ARR_SZ);
> +
> +               switch (act->id) {
> +               case FLOW_ACTION_REDIRECT:
> +                       tuple->in_pf =3D nic->pcifunc;
> +                       out_nic =3D netdev_priv(act->dev);
> +                       tuple->xmit_pf =3D out_nic->pcifunc;
> +                       *op |=3D BIT_ULL(FLOW_ACTION_REDIRECT);
> +                       break;
> +
> +               case FLOW_ACTION_CT:
> +                       err =3D nf_flow_table_offload_add_cb(act->ct.flow=
_table,
> +                                                          sw_fl_setup_ft=
_block_ingress_cb,
> +                                                          nic);
> +                       if (err !=3D -EEXIST && err) {
> +                               pr_err("%s:%d Error to offload flow, err=
=3D%d\n",
> +                                      __func__, __LINE__, err);
> +                               break;
> +                       }
> +
> +                       *op |=3D BIT_ULL(FLOW_ACTION_CT);
> +                       break;
> +
> +               case FLOW_ACTION_MANGLE:
> +                       tuple->mangle[used].type =3D act->mangle.htype;
> +                       tuple->mangle[used].val =3D act->mangle.val;
> +                       tuple->mangle[used].mask =3D act->mangle.mask;
> +                       tuple->mangle[used].offset =3D act->mangle.offset=
;
> +                       tuple->mangle_map[act->mangle.htype] |=3D BIT(use=
d);
> +                       used++;
> +                       break;
> +
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       tuple->mangle_cnt =3D used;
> +
> +       if (!*op) {
> +               pr_debug("%s:%d Op is not valid\n", __func__, __LINE__);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sw_fl_get_route(struct fib_result *res, __be32 addr)
> +{
> +       struct flowi4 fl4;
> +
> +       memset(&fl4, 0, sizeof(fl4));
> +       fl4.daddr =3D addr;
> +       return fib_lookup(&init_net, &fl4, res, 0);
> +}
> +
> +static int sw_fl_get_pcifunc(__be32 dst, u16 *pcifunc, struct fl_tuple *=
ftuple, bool is_in_dev)
> +{
> +       struct fib_nh_common *fib_nhc;
> +       struct net_device *dev, *br;
> +       struct otx2_nic *nic;
> +       struct fib_result res;
> +       struct list_head *lh;
> +       int err;
> +
> +       rcu_read_lock();
> +
> +       err =3D sw_fl_get_route(&res, dst);
> +       if (err) {
> +               pr_err("%s:%d Failed to find route to dst %pI4\n",
> +                      __func__, __LINE__, &dst);
> +               goto done;
> +       }
> +
> +       if (res.fi->fib_type !=3D RTN_UNICAST) {
> +               pr_err("%s:%d Not unicast  route to dst %pi4\n",
> +                      __func__, __LINE__, &dst);
> +               err =3D -EFAULT;
> +               goto done;
> +       }
> +
> +       fib_nhc =3D fib_info_nhc(res.fi, 0);
> +       if (!fib_nhc) {
> +               err =3D -EINVAL;
> +               pr_err("%s:%d Could not get fib_nhc for %pI4\n",
> +                      __func__, __LINE__, &dst);
> +               goto done;
> +       }
> +
> +       if (unlikely(netif_is_bridge_master(fib_nhc->nhc_dev))) {
> +               br =3D fib_nhc->nhc_dev;
> +
> +               if (is_in_dev)
> +                       ftuple->is_indev_br =3D 1;
> +               else
> +                       ftuple->is_xdev_br =3D 1;
> +
> +               lh =3D &br->adj_list.lower;
> +               if (list_empty(lh)) {
> +                       pr_err("%s:%d Unable to find any slave device\n",
> +                              __func__, __LINE__);
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               dev =3D netdev_next_lower_dev_rcu(br, &lh);
> +
> +       } else {
> +               dev =3D fib_nhc->nhc_dev;
> +       }
> +
> +       if (!sw_nb_is_valid_dev(dev)) {
> +               pr_err("%s:%d flow acceleration support is only for caviu=
m devices\n",
> +                      __func__, __LINE__);
> +               err =3D -EOPNOTSUPP;
> +               goto done;
> +       }
> +
> +       nic =3D netdev_priv(dev);
> +       *pcifunc =3D nic->pcifunc;
> +
> +done:
> +       rcu_read_unlock();
> +       return err;
> +}
> +
> +static int sw_fl_parse_flow(struct otx2_nic *nic, struct flow_cls_offloa=
d *f,
> +                           struct fl_tuple *tuple, u64 *features)
> +{
> +       struct flow_rule *rule;
> +       u8 ip_proto =3D 0;
> +
> +       *features =3D 0;
> +
> +       rule =3D flow_cls_offload_flow_rule(f);
> +
> +       if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
> +               struct flow_match_basic match;
> +
> +               flow_rule_match_basic(rule, &match);
> +
> +               /* All EtherTypes can be matched, no hw limitation */
> +
> +               if (match.mask->n_proto) {
> +                       tuple->eth_type =3D match.key->n_proto;
> +                       tuple->m_eth_type =3D match.mask->n_proto;
> +                       *features |=3D BIT_ULL(NPC_ETYPE);
> +               }
> +
> +               if (match.mask->ip_proto &&
> +                   (match.key->ip_proto !=3D IPPROTO_TCP &&
> +                    match.key->ip_proto !=3D IPPROTO_UDP)) {
> +                       netdev_dbg(nic->netdev,
> +                                  "ip_proto=3D%u not supported\n",
> +                                  match.key->ip_proto);
> +               }
> +
> +               if (match.mask->ip_proto)
> +                       ip_proto =3D match.key->ip_proto;
> +
> +               if (ip_proto =3D=3D IPPROTO_UDP) {
> +                       *features |=3D BIT_ULL(NPC_IPPROTO_UDP);
> +               } else if (ip_proto =3D=3D IPPROTO_TCP) {
> +                       *features |=3D BIT_ULL(NPC_IPPROTO_TCP);
> +               } else {
> +                       netdev_dbg(nic->netdev,
> +                                  "ip_proto=3D%u not supported\n",
> +                                  match.key->ip_proto);
> +               }
> +
> +               tuple->proto =3D ip_proto;
> +       }
> +
> +       if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +               struct flow_match_eth_addrs match;
> +
> +               flow_rule_match_eth_addrs(rule, &match);
> +
> +               if (!is_zero_ether_addr(match.key->dst) &&
> +                   is_unicast_ether_addr(match.key->dst)) {
> +                       ether_addr_copy(tuple->dmac,
> +                                       match.key->dst);
> +
> +                       ether_addr_copy(tuple->m_dmac,
> +                                       match.mask->dst);
> +
> +                       *features |=3D BIT_ULL(NPC_DMAC);
> +               }
> +
> +               if (!is_zero_ether_addr(match.key->src) &&
> +                   is_unicast_ether_addr(match.key->src)) {
> +                       ether_addr_copy(tuple->smac,
> +                                       match.key->src);
> +                       ether_addr_copy(tuple->m_smac,
> +                                       match.mask->src);
> +                       *features |=3D BIT_ULL(NPC_SMAC);
> +               }
> +       }
> +
> +       if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
> +               struct flow_match_ipv4_addrs match;
> +
> +               flow_rule_match_ipv4_addrs(rule, &match);
> +
> +               if (match.key->dst) {
> +                       tuple->ip4dst =3D match.key->dst;
> +                       tuple->m_ip4dst =3D match.mask->dst;
> +                       *features |=3D BIT_ULL(NPC_DIP_IPV4);
> +               }
> +
> +               if (match.key->src) {
> +                       tuple->ip4src =3D match.key->src;
> +                       tuple->m_ip4src =3D match.mask->src;
> +                       *features |=3D BIT_ULL(NPC_SIP_IPV4);
> +               }
> +       }
> +
> +       if (!(*features & BIT_ULL(NPC_DMAC))) {
> +               if (!tuple->ip4src || !tuple->ip4dst) {
> +                       pr_err("%s:%d Invalid src=3D%pI4 and dst=3D%pI4 a=
ddresses\n",
> +                              __func__, __LINE__, &tuple->ip4src, &tuple=
->ip4dst);
> +                       return -EINVAL;
> +               }
> +
> +               if ((tuple->ip4src & tuple->m_ip4src) =3D=3D (tuple->ip4d=
st & tuple->m_ip4dst)) {
> +                       pr_err("%s:%d Masked values are same; Invalid src=
=3D%pI4 and dst=3D%pI4 addresses\n",
> +                              __func__, __LINE__, &tuple->ip4src, &tuple=
->ip4dst);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
> +               struct flow_match_ports match;
> +
> +               flow_rule_match_ports(rule, &match);
> +
> +               if (ip_proto =3D=3D IPPROTO_UDP) {
> +                       if (match.key->dst)
> +                               *features |=3D BIT_ULL(NPC_DPORT_UDP);
> +
> +                       if (match.key->src)
> +                               *features |=3D BIT_ULL(NPC_SPORT_UDP);
> +               } else if (ip_proto =3D=3D IPPROTO_TCP) {
> +                       if (match.key->dst)
> +                               *features |=3D BIT_ULL(NPC_DPORT_TCP);
> +
> +                       if (match.key->src)
> +                               *features |=3D BIT_ULL(NPC_SPORT_TCP);
> +               }
> +
> +               if (match.mask->src) {
> +                       tuple->sport =3D match.key->src;
> +                       tuple->m_sport =3D match.mask->src;
> +               }
> +
> +               if (match.mask->dst) {
> +                       tuple->dport =3D match.key->dst;
> +                       tuple->m_dport =3D match.mask->dst;
> +               }
> +       }
> +
> +       if (!(*features & (BIT_ULL(NPC_DMAC) |
> +                          BIT_ULL(NPC_SMAC) |
> +                          BIT_ULL(NPC_DIP_IPV4) |
> +                          BIT_ULL(NPC_SIP_IPV4) |
> +                          BIT_ULL(NPC_DPORT_UDP) |
> +                          BIT_ULL(NPC_SPORT_UDP) |
> +                          BIT_ULL(NPC_DPORT_TCP) |
> +                          BIT_ULL(NPC_SPORT_TCP)))) {
> +               return -EINVAL;
> +       }
> +
> +       tuple->features =3D *features;
> +
> +       return 0;
> +}
> +
> +static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
> +{
> +       struct fl_tuple tuple =3D { 0 };
> +       struct flow_rule *rule;
> +       u64 features =3D 0;
> +       u64 op =3D 0;
> +       int rc;
> +
> +       rule =3D flow_cls_offload_flow_rule(f);
> +
> +       rc =3D sw_fl_parse_actions(nic, &rule->action, f, &tuple, &op);
> +       if (rc)
> +               return rc;
> +
> +       if (op & BIT_ULL(FLOW_ACTION_CT))
> +               return 0;
> +
> +       rc  =3D sw_fl_parse_flow(nic, f, &tuple, &features);
> +       if (rc)
> +               return -EFAULT;
> +
> +       if (!netif_is_ovs_port(nic->netdev)) {
> +               rc =3D sw_fl_get_pcifunc(tuple.ip4src, &tuple.in_pf, &tup=
le, true);
> +               if (rc)
> +                       return rc;
> +
> +               rc =3D sw_fl_get_pcifunc(tuple.ip4dst, &tuple.xmit_pf, &t=
uple, false);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       sw_fl_add_to_list(nic, &tuple, f->cookie, true);
> +       return 0;
> +}
> +
> +static int sw_fl_del(struct otx2_nic *nic, struct flow_cls_offload *f)
function prototype can be changed to void?
> +{
> +       sw_fl_add_to_list(nic, NULL, f->cookie, false);
> +       return 0;
> +}
> +
> +static int sw_fl_stats(struct otx2_nic *nic, struct flow_cls_offload *f)
> +{
> +       struct fl_get_stats_req *req;
> +       struct fl_get_stats_rsp *rsp;
> +       u64 pkts_diff;
> +       int rc =3D 0;
> +
> +       mutex_lock(&nic->mbox.lock);
> +
> +       req =3D otx2_mbox_alloc_msg_fl_get_stats(&nic->mbox);
> +       if (!req) {
> +               pr_err("%s:%d Error happened while mcam alloc req\n", __f=
unc__, __LINE__);
> +               rc =3D -ENOMEM;
> +               goto fail;
> +       }
> +       req->cookie =3D f->cookie;
> +
> +       rc =3D otx2_sync_mbox_msg(&nic->mbox);
> +       if (rc)
> +               goto fail;
> +
> +       rsp =3D (struct fl_get_stats_rsp *)otx2_mbox_get_rsp
> +               (&nic->mbox.mbox, 0, &req->hdr);
> +       if (IS_ERR(rsp)) {
> +               rc =3D PTR_ERR(rsp);
> +               goto fail;
> +       }
> +
> +       pkts_diff =3D rsp->pkts_diff;
> +       mutex_unlock(&nic->mbox.lock);
> +
> +       if (pkts_diff) {
> +               flow_stats_update(&f->stats, 0x0, pkts_diff,
> +                                 0x0, jiffies,
> +                                 FLOW_ACTION_HW_STATS_IMMEDIATE);
> +       }
> +       return 0;
> +fail:
> +       mutex_unlock(&nic->mbox.lock);
> +       return rc;
> +}
> +
> +static bool init_done;
> +
> +int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
> +                                   void *type_data, void *cb_priv)
> +{
> +       struct flow_cls_offload *cls =3D type_data;
> +       struct otx2_nic *nic =3D cb_priv;
> +
> +       if (!init_done)
> +               return 0;
> +
> +       switch (cls->command) {
> +       case FLOW_CLS_REPLACE:
> +               return sw_fl_add(nic, cls);
> +       case FLOW_CLS_DESTROY:
> +               return sw_fl_del(nic, cls);
> +       case FLOW_CLS_STATS:
> +               return sw_fl_stats(nic, cls);
> +       default:
> +               break;
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
>  int sw_fl_init(void)
>  {
> +       INIT_WORK(&sw_fl_work, sw_fl_wq_handler);
> +       sw_fl_wq =3D alloc_workqueue("sw_fl_wq", 0, 0);
> +       if (!sw_fl_wq)
> +               return -ENOMEM;
> +
> +       init_done =3D true;
>         return 0;
>  }
>
>  void sw_fl_deinit(void)
>  {
> +       cancel_work_sync(&sw_fl_work);
> +       destroy_workqueue(sw_fl_wq);
>  }
> +#endif
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/=
drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
> index cd018d770a8a..8dd816eb17d2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
> @@ -9,5 +9,7 @@
>
>  void sw_fl_deinit(void);
>  int sw_fl_init(void);
> +int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
> +                                   void *type_data, void *cb_priv);
>
>  #endif // SW_FL_H
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/=
drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> index 7a0ed52eae95..c316aeac2e81 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> @@ -21,7 +21,6 @@
>  #include "sw_fdb.h"
>  #include "sw_fib.h"
>  #include "sw_fl.h"
> -#include "sw_nb.h"
>
>  static const char *sw_nb_cmd2str[OTX2_CMD_MAX] =3D {
>         [OTX2_DEV_UP]  =3D "OTX2_DEV_UP",
> --
> 2.43.0
>
>


--
Regards,
Kalesh AP

--000000000000c3b8ce0647e29cc0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVgQYJKoZIhvcNAQcCoIIVcjCCFW4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLuMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgNccx3nJrkdEX1+5HXXPkVgAd0O9O
SGU33CXPbAIHhDUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA4MTYwNzU4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAPJ5Ivt3QdLIr7pTgBB2R8Y1AN6t5SKGtIHOAYb7pzrZ5LZZSnEpHQ1y7iCsZuL/d
+IDM0m3OT1WjbOq6Z9hAfUyW+Q9dqErU0XSKGONYPMbzb8ZV4YNKsXjqlLTJtXAtHZOjfmGm+XNK
qkMMAzy5x0nHB4LB/qZKGhguprjbwcoJ3HYDmlg/vaHGqPmOinWeV6Oi3Q7ndBV5zkoaC4dCKyp4
KfHrNaTW72vONzoVhZ9Nuqe4DEnDjBxemIBMEeNhGtuTMIKCM1MEAX6J/AjS2Ykfhoz0UL8fEaNY
5b//Pdv4SP40gQ/2mHqzMHyxaHGqpt5Xh8rkisnD1B455I6Tlg==
--000000000000c3b8ce0647e29cc0--

