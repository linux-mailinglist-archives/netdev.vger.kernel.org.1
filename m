Return-Path: <netdev+bounces-241251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12203C82031
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2804A4E55AC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270A3148AF;
	Mon, 24 Nov 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="INEUIqBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CB2BEC41
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007494; cv=none; b=uUbXEfNZxxW6wuyJxYi5cVh7+7hIgF2KyBWW2iXVIGEo/0/EOIAZGE1YF51LATCF3Bsz69O22CytxywFD0KltuQSfHIKGcEoxQrID6idt1JilkRxYnAXbCXyII+Nf/TZAIIpv+Gwx2vsPTeq6L4HnXNZmeCx3ARXHz0V7I7KLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007494; c=relaxed/simple;
	bh=iIBFwL6PfpvfEpvFndAzrfdSPWaDQaqCfyrVyFQWJxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km+l/MEcCrqBV2PboHPhi3bZLPRhxsMtOE9EvccbCKoD+9gckNHnoV7L2KUE9d0FTYGfwD3Q93mpPVzLk37XUhcUaYGO5Qykl4VoAUgytJJfIVxNuC9mp+jc+KPEDM0oGjybdglYROXqKTa3JKfM4Nims4l1ct8ioQs5ngCfYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=INEUIqBS; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so3891672b3a.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007492; x=1764612292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDM6hY/nONRKZ3tTLMjrYWOohw7SLHqzFEdnOJ0gAI0=;
        b=i09bQ293RaqqdEZCIeBx7yLJcYBk9Ztxi4TtQw4kETCUQCwyzHLuIvDAm2da3hePfr
         QIm8tcPezTm5D+P7sOVIvQHWliKZ82DFJpwBQnzeWdIU2QVXPNNWZAvoGnN6jhZqF3iW
         YTXz9Lsfz939isGHBXCqniRBvS0SxBgtc2s4oKVuCrzl0DccivIg1K9xe8B7ExKTuYm2
         /KCw7S04adRZsrief9ftnEiyhvgFu0yGUjgGDgygT5JRbK7hEHRTx9P9Dk/5vFElG96Z
         FWuwnWeMcF/bxNWd0E+nwVJS2LCxplcRZ/Vv2m2n26Uw/UXM7Sbff2ZBaVTaYq50pIHF
         f2bw==
X-Forwarded-Encrypted: i=1; AJvYcCVMFj3tfdUA1LVq8+WegUAP+cH+CFtHcu0ylLcipC99irfWbnEau5wLeJp4LlQrU3Lj2ixgkRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/4zmscdtCRCDPCvsX2Bia/aOd7Vt+wkl3WoLsK8jx6A7/0M7
	2sGoKBUe0BMZwUiFddU/SYlbYniEKCiCIfCC8twEbVJhLlOstLEWRYotJSpatEvCZcY6Xrn8xzJ
	DsOr0t6UbsPRrchk+7J9bvQZQUzT+cw+ue5t3Y2h8fSDs0rUAcYNziti/3unpANK1glquEUeb2c
	b5UhZLx1KgHLmhm0FiSlSz+au2Pw+EXaesWPM8IthSXxC+L4iORcK9z5cdcJe2SR2PHoU7MbxNO
	j3toGtrpMM8t07x7Yii
X-Gm-Gg: ASbGncu/Ah7Dltq3zYotBynsPEAEmq1LtP2N3SU4j+3h1mX1M140lSvMkbGp2ndannV
	Br2+5ppbWmBuZpLk9mkaRHcF7Lyz/rJypNpFed92mUfY6790vNFBOJlLcGlAeEqpadyzyxniMUK
	LXx2KQ77EQIDMcznMx7oolK6ddtDVi6swpqcx2x6Sg/LvCvXablZKXJBrCRBv9CqI8PQqW61UKz
	MX7YanPcuTwYlpyx0TW88B6UrkQhKLjNZ4oYvlpW7+02XSPS4eKm8CfI1yznBXJQNG6Ecb95Q7I
	oQyGYfYo2WKAtvvkC981p3HDGxBe4HLSMyn7NY3myrCVOo1LEYZGLZWnYgBQBNaMADNApC6rCOH
	k3BU/ZqxnCCgIglnYa1T44oXM0fl0dtkqdNadJymwBhnoSdLwUI5BS6v5nyVKOYtOjoKmY0+FU5
	nl8DtYXYYvSUFt5AF0aFCb2fMy8ONafm0K61wyHG/vn6Y2ghmA
X-Google-Smtp-Source: AGHT+IHb/5v6U9dRRpsVQzp8DeMzRoO11TRZfGMDX1Bv0ERknS8olRX1E1Z3ZSz7P74/qmNO7qPlY9agOaaO
X-Received: by 2002:a05:7022:3711:b0:119:e56b:98ba with SMTP id a92af1059eb24-11c9d8617e4mr7118635c88.33.1764007491327;
        Mon, 24 Nov 2025 10:04:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11c93cce800sm1673691c88.0.2025.11.24.10.04.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2025 10:04:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b993eb2701bso4353922a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764007489; x=1764612289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDM6hY/nONRKZ3tTLMjrYWOohw7SLHqzFEdnOJ0gAI0=;
        b=INEUIqBSwYNCWVcDYTEEUOF4dqcoTFnIRupkSNSCBIoZ4Qm03t9O/wv4KPn4Yo4dEG
         XW75OGwxcv0HNrTPFtNSC86tUBkPEfatgDA3JtXa40TQbuhkOrHSFpVMwLzyxHevK/n/
         wXPyLnRJ6pK12n/5VzMaIfkxmXgVFRTVk2RoY=
X-Forwarded-Encrypted: i=1; AJvYcCWiWDfW56ARDO289N7zq50Rmgd4fR8FH10W/1R2uWSzjQ8upMJVXsPg57wyrXCtAR70jUIRVxU=@vger.kernel.org
X-Received: by 2002:a05:7301:e25:b0:2a4:5657:3f8b with SMTP id 5a478bee46e88-2a94174db20mr13573eec.22.1764007489108;
        Mon, 24 Nov 2025 10:04:49 -0800 (PST)
X-Received: by 2002:a05:7301:e25:b0:2a4:5657:3f8b with SMTP id
 5a478bee46e88-2a94174db20mr13525eec.22.1764007488378; Mon, 24 Nov 2025
 10:04:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-2-bhargava.marreddy@broadcom.com> <75684350-48e9-4438-ae42-431d7eb2a5f2@oracle.com>
In-Reply-To: <75684350-48e9-4438-ae42-431d7eb2a5f2@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 24 Nov 2025 23:34:34 +0530
X-Gm-Features: AWmQ_bmR6v55euxYvFKjI7sDENpTsiPBGb_LkYl_eXASnq7Syoqg1Ia0G2UxlUk
Message-ID: <CANXQDtZbLhdwEtN+kKg1OVLV+uy-gsNfX+rU4MR77QPuO6_y9A@mail.gmail.com>
Subject: Re: [External] : [v2, net-next 01/12] bng_en: Query PHY and report
 link status
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cf652006445aff92"

--000000000000cf652006445aff92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 3:16=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
> > @@ -9,8 +9,10 @@
> >
> >   #include <linux/etherdevice.h>
> >   #include <linux/bnxt/hsi.h>
> > +#include <linux/ethtool.h>
> >   #include "bnge_rmem.h"
> >   #include "bnge_resc.h"
> > +#include "bnge_link.h"
> >
> >   #define DRV_VER_MAJ 1
> >   #define DRV_VER_MIN 15
> > @@ -141,6 +143,17 @@ struct bnge_dev {
> >       struct bnge_ctx_mem_info        *ctx;
> >
> >       u64                     flags;
> > +#define BNGE_PF(bd)          (1)
> > +#define BNGE_VF(bd)          (0)
> > +#define BNGE_NPAR(bd)                (0)
> > +#define BNGE_MH(bd)          (0)
> > +#define BNGE_SINGLE_PF(bd)   (BNGE_PF(bd) && !BNGE_NPAR(bd) && !BNGE_M=
H(bn))
>
> bn is wrong.
>
> > +#define BNGE_SH_PORT_CFG_OK(bd)                      \
> > +     (BNGE_PF(bd) && ((bd)->phy_flags & BNGE_PHY_FL_SHARED_PORT_CFG))
> > +#define BNGE_PHY_CFG_ABLE(bd)                        \
> > +     ((BNGE_SINGLE_PF(bd) ||                 \
> > +       BNGE_SH_PORT_CFG_OK(bd)) &&           \
> > +      (bd)->link_info.phy_state =3D=3D BNGE_PHY_STATE_ENABLED)
> >
> >       struct bnge_hw_resc     hw_resc;
> >
> > @@ -197,6 +210,22 @@ struct bnge_dev {
> >
> >       struct bnge_irq         *irq_tbl;
> >       u16                     irqs_acquired;
> > +
> > +     /* To protect link related settings during link changes and
> > +      * ethtool settings changes.
> > +      */
> > +     struct mutex            link_lock;
> > +     struct bnge_link_info   link_info;
> > +
> > +     /* copied from flags and flags2 in hwrm_port_phy_qcaps_output */
> > +     u32                     phy_flags;
> > +#define BNGE_PHY_FL_SHARED_PORT_CFG  \
> > +     PORT_PHY_QCAPS_RESP_FLAGS_SHARED_PHY_CFG_SUPPORTED
> > +#define BNGE_PHY_FL_NO_FCS           PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
> > +#define BNGE_PHY_FL_SPEEDS2          \
> > +     (PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
> > +
> > +     u32                     msg_enable;
> >   };
> >
> >   static inline bool bnge_is_roce_en(struct bnge_dev *bd)
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drive=
rs/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > index 198f49b40db..b0e941ad18b 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > @@ -14,6 +14,7 @@
> >   #include "bnge_hwrm_lib.h"
> >   #include "bnge_rmem.h"
> >   #include "bnge_resc.h"
> > +#include "bnge_link.h"
> >
> >   int bnge_hwrm_ver_get(struct bnge_dev *bd)
> >   {
> > @@ -981,6 +982,192 @@ void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev =
*bd,
> >       vnic->fw_rss_cos_lb_ctx[ctx_idx] =3D INVALID_HW_RING_ID;
> >   }
> >
> > +int bnge_hwrm_phy_qcaps(struct bnge_dev *bd)
> > +{
> > +     struct bnge_link_info *link_info =3D &bd->link_info;
> > +     struct hwrm_port_phy_qcaps_output *resp;
> > +     struct hwrm_port_phy_qcaps_input *req;
> > +     int rc =3D 0;
> > +
> > +     rc =3D bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCAPS);
> > +     if (rc)
> > +             return rc;
> > +
> > +     resp =3D bnge_hwrm_req_hold(bd, req);
> > +     rc =3D bnge_hwrm_req_send(bd, req);
> > +     if (rc)
> > +             goto hwrm_phy_qcaps_exit;
> > +
> > +     bd->phy_flags =3D resp->flags | (le16_to_cpu(resp->flags2) << 8);
> > +
> > +     if (bnge_phy_qcaps_no_speed(resp)) {
> > +             link_info->phy_state =3D BNGE_PHY_STATE_DISABLED;
> > +             netdev_warn(bd->netdev, "Ethernet link disabled\n");
> > +     } else if (link_info->phy_state =3D=3D BNGE_PHY_STATE_DISABLED) {
> > +             link_info->phy_state =3D BNGE_PHY_STATE_ENABLED;
> > +             netdev_info(bd->netdev, "Ethernet link enabled\n");
> > +             /* Phy re-enabled, reprobe the speeds */
> > +             link_info->support_auto_speeds =3D 0;
> > +             link_info->support_pam4_auto_speeds =3D 0;
> > +             link_info->support_auto_speeds2 =3D 0;
> > +     }
> > +     if (resp->supported_speeds_auto_mode)
> > +             link_info->support_auto_speeds =3D
> > +                     le16_to_cpu(resp->supported_speeds_auto_mode);
> > +     if (resp->supported_pam4_speeds_auto_mode)
> > +             link_info->support_pam4_auto_speeds =3D
> > +                     le16_to_cpu(resp->supported_pam4_speeds_auto_mode=
);
> > +     if (resp->supported_speeds2_auto_mode)
> > +             link_info->support_auto_speeds2 =3D
> > +                     le16_to_cpu(resp->supported_speeds2_auto_mode);
> > +
> > +     bd->port_count =3D resp->port_cnt;
> > +
> > +hwrm_phy_qcaps_exit:
> > +     bnge_hwrm_req_drop(bd, req);
> > +     return rc;
> > +}
> > +
> > +int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause)
> > +{
> > +     struct hwrm_port_phy_cfg_input *req;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int rc;
> > +
> > +     rc =3D bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
> > +     if (rc)
> > +             return rc;
> > +
> > +     if (set_pause)
> > +             bnge_hwrm_set_pause_common(bn, req);
> > +
> > +     bnge_hwrm_set_link_common(bn, req);
> > +
> > +     return bnge_hwrm_req_send(bd, req);
> > +}
> > +
> [snip]
> >
> > +
> > +int bnge_update_phy_setting(struct bnge_net *bn)
> > +{
> > +     struct bnge_ethtool_link_info *elink_info;
> > +     struct bnge_link_info *link_info;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     bool update_pause =3D false;
> > +     bool update_link =3D false;
> > +     int rc;
> > +
> > +     link_info =3D &bd->link_info;
> > +     elink_info =3D &bn->eth_link_info;
> > +     rc =3D bnge_update_link(bn, true);
> > +     if (rc) {
> > +             netdev_err(bd->netdev, "failed to update link (rc: %d)\n"=
,
> > +                        rc);
> > +             return rc;
> > +     }
> > +     if (!BNGE_SINGLE_PF(bd))
> > +             return 0;
> > +
> > +     if ((elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
> > +         (link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=3D
> > +         elink_info->req_flow_ctrl)
> > +             update_pause =3D true;
> > +     if (!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
> > +         link_info->force_pause_setting !=3D elink_info->req_flow_ctrl=
)
> > +             update_pause =3D true;
> > +     if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
> > +             if (BNGE_AUTO_MODE(link_info->auto_mode))
> > +                     update_link =3D true;
> > +             if (bnge_force_speed_updated(bn))
> > +                     update_link =3D true;
> > +             if (elink_info->req_duplex !=3D link_info->duplex_setting=
)
> > +                     update_link =3D true;
> > +     } else {
> > +             if (link_info->auto_mode =3D=3D BNGE_LINK_AUTO_NONE)
> > +                     update_link =3D true;
> > +             if (bnge_auto_speed_updated(bn))
> > +                     update_link =3D true;
> > +     }
> > +
> > +     /* The last close may have shutdown the link, so need to call
> > +      * PHY_CFG to bring it back up.
> > +      */
> > +     if (!BNGE_LINK_IS_UP(bd))
> > +             update_link =3D true;
> > +
> > +     if (update_link)
> > +             rc =3D bnge_hwrm_set_link_setting(bn, update_pause);
> > +     else if (update_pause)
> > +             rc =3D bnge_hwrm_set_pause(bn);
>
> new line help here

Thanks, I'll address this in the next patch.

>
> if
> update_link =3D=3D false
> update_pause =3D=3D false
>
> it will return rc =3D 0 assign by bnge_update_link() correct?

That=E2=80=99s right, neither flag set means no call happens, so rc remains=
 0

>
> > +     if (rc) {
> > +             netdev_err(bd->netdev,
> > +                        "failed to update phy setting (rc: %d)\n", rc)=
;
> > +             return rc;
> > +     }
> > +
> > +     return rc;
> > +}
> > +
> > +void bnge_get_port_module_status(struct bnge_net *bn)
> > +{
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     struct bnge_link_info *link_info =3D &bd->link_info;
> > +     struct hwrm_port_phy_qcfg_output *resp =3D &link_info->phy_qcfg_r=
esp;
> > +     u8 module_status;
> > +
> > +     if (bnge_update_link(bn, true))
> > +             return;
> > +
> > +     module_status =3D link_info->module_status;
> > +     switch (module_status) {
> > +     case PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX:
> > +     case PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN:
> > +     case PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG:
> > +             netdev_warn(bd->netdev,
> > +                         "Unqualified SFP+ module detected on port %d\=
n",
> > +                         bd->pf.port_id);
> > +             netdev_warn(bd->netdev, "Module part number %s\n",
> > +                         resp->phy_vendor_partnumber);
> > +             if (module_status =3D=3D PORT_PHY_QCFG_RESP_MODULE_STATUS=
_DISABLETX)
> > +                     netdev_warn(bd->netdev, "TX is disabled\n");
> > +             if (module_status =3D=3D PORT_PHY_QCFG_RESP_MODULE_STATUS=
_PWRDOWN)
> > +                     netdev_warn(bd->netdev, "SFP+ module is shutdown\=
n");
> > +     }
> > +}
> > +
> > +static bool bnge_support_dropped(u16 advertising, u16 supported)
> > +{
> > +     u16 diff =3D advertising ^ supported;
> > +
> > +     return ((supported | diff) !=3D supported);
> > +}
> > +
> > +bool bnge_support_speed_dropped(struct bnge_net *bn)
> > +{
> > +     struct bnge_ethtool_link_info *elink_info =3D &bn->eth_link_info;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     struct bnge_link_info *link_info =3D &bd->link_info;
> > +
> > +     /* Check if any advertised speeds are no longer supported. The ca=
ller
> > +      * holds the link_lock mutex, so we can modify link_info settings=
.
> > +      */
> > +     if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
> > +             if (bnge_support_dropped(elink_info->advertising,
> > +                                      link_info->support_auto_speeds2)=
) {
> > +                     elink_info->advertising =3D
> > +                             link_info->support_auto_speeds2;
> > +                     return true;
> > +             }
> > +             return false;
> > +     }
> > +     if (bnge_support_dropped(elink_info->advertising,
> > +                              link_info->support_auto_speeds)) {
> > +             elink_info->advertising =3D link_info->support_auto_speed=
s;
> > +             return true;
> > +     }
> > +     if (bnge_support_dropped(elink_info->advertising_pam4,
> > +                              link_info->support_pam4_auto_speeds)) {
> > +             elink_info->advertising_pam4 =3D
> > +                     link_info->support_pam4_auto_speeds;
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +static char *bnge_report_fec(struct bnge_link_info *link_info)
> > +{
> > +     u8 active_fec =3D link_info->active_fec_sig_mode &
> > +                     PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK;
> > +
> > +     switch (active_fec) {
> > +     default:
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE:
> > +             return "None";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE74_ACTIVE:
> > +             return "Clause 74 BaseR";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE91_ACTIVE:
> > +             return "Clause 91 RS(528,514)";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_1XN_ACTIVE:
> > +             return "Clause 91 RS544_1XN";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_IEEE_ACTIVE:
> > +             return "Clause 91 RS(544,514)";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_1XN_ACTIVE:
> > +             return "Clause 91 RS272_1XN";
> > +     case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE:
> > +             return "Clause 91 RS(272,257)";
> > +     }
> > +}
> > +
> > +void bnge_report_link(struct bnge_dev *bd)
> > +{
> > +     if (BNGE_LINK_IS_UP(bd)) {
> > +             const char *signal =3D "";
> > +             const char *flow_ctrl;
> > +             const char *duplex;
> > +             u32 speed;
> > +             u16 fec;
> > +
> > +             netif_carrier_on(bd->netdev);
> > +             speed =3D bnge_fw_to_ethtool_speed(bd->link_info.link_spe=
ed);
> > +             if (speed =3D=3D SPEED_UNKNOWN) {
> > +                     netdev_info(bd->netdev,
> > +                                 "NIC Link is Up, speed unknown\n");
> > +                     return;
> > +             }
> > +             if (bd->link_info.duplex =3D=3D BNGE_LINK_DUPLEX_FULL)
> > +                     duplex =3D "full";
> > +             else
> > +                     duplex =3D "half";
> > +             if (bd->link_info.pause =3D=3D BNGE_LINK_PAUSE_BOTH)
> > +                     flow_ctrl =3D "ON - receive & transmit";
> > +             else if (bd->link_info.pause =3D=3D BNGE_LINK_PAUSE_TX)
> > +                     flow_ctrl =3D "ON - transmit";
> > +             else if (bd->link_info.pause =3D=3D BNGE_LINK_PAUSE_RX)
> > +                     flow_ctrl =3D "ON - receive";
> > +             else
> > +                     flow_ctrl =3D "none";
> > +             if (bd->link_info.phy_qcfg_resp.option_flags &
> > +                 PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN) {
> > +                     u8 sig_mode =3D bd->link_info.active_fec_sig_mode=
 &
> > +                                   PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK=
;
> > +                     switch (sig_mode) {
> > +                     case PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ:
> > +                             signal =3D "(NRZ) ";
> > +                             break;
> > +                     case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
> > +                             signal =3D "(PAM4 56Gbps) ";
> > +                             break;
> > +                     case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
> > +                             signal =3D "(PAM4 112Gbps) ";
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +             }
> > +             netdev_info(bd->netdev, "NIC Link is Up, %u Mbps %s%s dup=
lex, Flow control: %s\n",
> > +                         speed, signal, duplex, flow_ctrl);
> > +             fec =3D bd->link_info.fec_cfg;
> > +             if (!(fec & PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED=
))
> > +                     netdev_info(bd->netdev, "FEC autoneg %s encoding:=
 %s\n",
> > +                                 (fec & BNGE_FEC_AUTONEG) ? "on" : "of=
f",
> > +                                 bnge_report_fec(&bd->link_info));
> > +     } else {
> > +             netif_carrier_off(bd->netdev);
> > +             netdev_err(bd->netdev, "NIC Link is Down\n");
> > +     }
> > +}
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_link.h
> > new file mode 100644
> > index 00000000000..65da27c510b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
> > @@ -0,0 +1,185 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_LINK_H_
> > +#define _BNGE_LINK_H_
> > +
> > +#define BNGE_PHY_AUTO_SPEEDS2_MASK   \
> > +     PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK
> > +#define BNGE_PHY_AUTO_SPEED_MASK     \
> > +     PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED_MASK
> > +#define BNGE_PHY_AUTO_PAM4_SPEED_MASK        \
> > +     PORT_PHY_CFG_REQ_ENABLES_AUTO_PAM4_LINK_SPEED_MASK
> > +#define BNGE_PHY_FLAGS_RESTART_AUTO  \
> > +     PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG
> > +#define BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2     \
> > +     PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2
> > +#define BNGE_PHY_FLAGS_ENA_FORCE_PM4_SPEED   \
>
> typo should be PAM4 ?

It=E2=80=99s intentional, the name is kept short to stay within ~80 chars
where it=E2=80=99s used.

Thanks,
Bhargava Marreddy

>
> > +     PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED
> > +
> > +struct bnge_link_info {
> > +     u8                      phy_type;
> > +     u8                      media_type;
> > +     u8                      transceiver;
> > +     u8                      phy_addr;
> > +     u8                      phy_link_status;
> > +#define BNGE_LINK_LINK               PORT_PHY_QCFG_RESP_LINK_LINK
> > +     u8                      phy_state;
> > +#define BNGE_PHY_STATE_ENABLED               0
> > +#define BNGE_PHY_STATE_DISABLED              1
> > +
> > +     u8                      link_state;
> > +#define BNGE_LINK_STATE_UNKNOWN      0
> > +#define BNGE_LINK_STATE_DOWN 1
> > +#define BNGE_LINK_STATE_UP   2
> > +#define BNGE_LINK_IS_UP(bd)          \
> > +     ((bd)->link_info.link_state =3D=3D BNGE_LINK_STATE_UP)
> > +     u8                      active_lanes;
>
>
> Thanks,
> Alok

--000000000000cf652006445aff92
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDEdhlrajNnIKODQ/phixA8RwTXq01c0bH0gX+3IoB7LjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMjQxODA0NDlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBsxApy
Pag/P4SN23V4pjFpj1F1m3rlupUGUJVueU1Ve9Ueic0wrryUGaXFtgzzbSY1bN7QFeI571DSv2Ir
kQkK7H5HmR8NZPk7VZK6R4J6V1aPBMKBtSxsoSPi/danBJHVlCu3MZab76zXnQOZ2iEH7dGRCPQy
1f9vLTg+4TfdSdER6cyzoxZMrEW7AxsFw5zBpn7pICcY9fuSQTqX19Ey0zOFjZmIIUkTGp4flDdI
wCjkw2ZLg9QSpuM88m9HrXtZ0Gnqu1gA5rtgb7cLe8oOywPRCH9j/0HFFeT9hgLuJqwupDFkO0Ce
tmfBOLCslmGqZDgMo/u3iQaS9sXEvR0p
--000000000000cf652006445aff92--

