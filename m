Return-Path: <netdev+bounces-200578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA86AE625D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6B33BED17
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19425DB13;
	Tue, 24 Jun 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W0YUC6tw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C774239E99
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760806; cv=none; b=qNFoT0Zusz10SiBt8xI3KTU72BwbSTQlSufKh2/GO1h+Ipc9wOhTY9nsdKHE/9ZlSr3VMxYR85ONiN5z4qGRtkaJWqcDO+HX22PeDEXSshVvYxx81kSbBVtYsTXVM8IZ86UjyrHevNc7QG9qQJWXm9frv3Y8HXPr+ntp5XPIq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760806; c=relaxed/simple;
	bh=6Bp/6cm8MhzSVpYk6D6PVkVw+2dJGDrjh5ngCZHuG34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdmFZPlqadsjHPA/tw1lImuiKVba531dZxgM9VEgs5jofL53U9FOj2Zg0fDOs9kQEZf0PA16lPBHJlk7KjGoDpHtorU/whhqdqL11roU09jH/yLiefGtnRpACUw5P4emvSZIqAb5AdYlEvCvc4WoyqLSOUzFcUnY8mlGF2bDenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W0YUC6tw; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so1359456137.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750760803; x=1751365603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUGYmcGuiu9DMqw7r45OxseuO7PRr7DQlMJQ1F3MlGc=;
        b=W0YUC6tw5vzeO4arGKQ/Kc9Ic2v+12AItZLYC78UD96DjpPohHIAL2rwOgQ609mWGY
         tVoYm3e9z60EWgJnx04KJVP+lhFNGVBlxOv/+5yyWRsEi/tgsVb+S2Fxl6QQI9mCKGk+
         kaMhd2jPu+UYBPCYtm/LHQoP9JtqaEoSPhzCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760803; x=1751365603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUGYmcGuiu9DMqw7r45OxseuO7PRr7DQlMJQ1F3MlGc=;
        b=HMok6/KLoKJOJHA5z4qNzIxEvE8DeCt4YA5/36flooqFvrsqT7DJKrCKiaKy6bzCLX
         U32CNAkPhQXl4FaZvpzHp6lYQg7erv/n+qxjEq6uWDhx70x6VlMUOhTL5UCB078QKV+4
         C9qOJuywB/R0GX4so1MCOTLzlPiS/yelN6o7SPg/WShrJnsRcLQ0BtBz3RDilEG5IXEg
         FtQCHCninE6gdAwz7mzVtfcTGSTCC0Rp5/QQyis+dxA3t2Tc77GoYQitW+wrOXlfBvaF
         rWiQDHD4Vh+hLxUm9bOc8G/ADDIz/TVYY/kFD2KhvAwkdCKMcl2m/wWLcf5JEHxwSeZd
         cSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaMXnuAw337LKf/8sBCctuYv0yYH3/qI8Qc/x+4ZOEZrD02QvgJu6kccG7FMW1e80PWj5sQhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4Z+vbG9W7b0DMxmF8+eTGe6oP3htVh8W6dJ3KS4ykXUrvBel
	X6OM6zsw9zkqA5lpSF5ipZo4qF6EeZ7WgfF3hsrB2mMtJtxoqmBapZzo2R4RH2WB7+P3ArBfleF
	ObL2SXy1nDi7ADqNiWlPkqU9OIqdLcBvOJn7tV1Ws
X-Gm-Gg: ASbGnctUdjZJLKpqo7zbrOs7MWZIR6r6H5sjXhgnlLGPVvyXnTYoxKfFC4DnrscN15n
	8ThrY3w1q0c5Lv8pBdYuN4mozglytV5nhZ33XBhZyuEU37MSVYB8YIY2/EaZGskuiamrRI0Opod
	qG5sdo2Q0CcBgGZCK10uMtzaS/PJZXETxjJBHrdkfRBHFVADvjTrPojrg=
X-Google-Smtp-Source: AGHT+IFDoq2JMkQmux1kLtn4xAmMZnPEQ40DKhMbLaDSsp5DTIl0fl4BnTHk/ttrRhXSx8YnqrulkoTlhpBRokBS2HE=
X-Received: by 2002:a05:6102:3ed4:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-4e9c2b08484mr9816596137.2.1750760803270; Tue, 24 Jun 2025
 03:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-5-vikas.gupta@broadcom.com> <4bf20b00-19bd-48f3-9d0c-3c8bde56ec47@linux.dev>
In-Reply-To: <4bf20b00-19bd-48f3-9d0c-3c8bde56ec47@linux.dev>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 24 Jun 2025 15:56:30 +0530
X-Gm-Features: Ac12FXzmShGJ2xbIJTtAYvQqO75cNlWv8l6bU6gnU6zXf4ZXgNVv42zsqsey8EI
Message-ID: <CAHLZf_u2e7Cm8-hkAy-bfcQ6QThwanYAFuRemi-FcNgh+rVprg@mail.gmail.com>
Subject: Re: [net-next, 04/10] bng_en: Add initial interaction with firmware
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, 
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cbfd8f06384ec3e0"

--000000000000cbfd8f06384ec3e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:23=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/06/2025 15:47, Vikas Gupta wrote:
> > Query firmware with the help of basic firmware commands and
> > cache the capabilities. With the help of basic commands
> > start the initialization process of the driver with the
> > firmware.
> > Since basic information is available from the firmware,
> > add that information to the devlink info get command.
> >
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
> >   drivers/net/ethernet/broadcom/bnge/bnge.h     |  54 +++++
> >   .../net/ethernet/broadcom/bnge/bnge_core.c    |  67 ++++++
> >   .../net/ethernet/broadcom/bnge/bnge_devlink.c | 120 ++++++++++
> >   .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 213 +++++++++++++++++=
+
> >   .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  16 ++
> >   6 files changed, 472 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/=
ethernet/broadcom/bnge/Makefile
> > index b296d7de56ce..b8dbbc2d5972 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/Makefile
> > +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> > @@ -4,4 +4,5 @@ obj-$(CONFIG_BNGE) +=3D bng_en.o
> >
> >   bng_en-y :=3D bnge_core.o \
> >           bnge_devlink.o \
> > -         bnge_hwrm.o
> > +         bnge_hwrm.o \
> > +         bnge_hwrm_lib.o
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/et=
hernet/broadcom/bnge/bnge.h
> > index 8f2a562d9ae2..60af0517c45e 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> > @@ -7,6 +7,13 @@
> >   #define DRV_NAME    "bng_en"
> >   #define DRV_SUMMARY "Broadcom 800G Ethernet Linux Driver"
> >
> > +#include <linux/etherdevice.h>
> > +#include "../bnxt/bnxt_hsi.h"
> > +
> > +#define DRV_VER_MAJ  1
> > +#define DRV_VER_MIN  15
> > +#define DRV_VER_UPD  1
> > +
> >   extern char bnge_driver_name[];
> >
> >   enum board_idx {
> > @@ -15,6 +22,36 @@ enum board_idx {
> >
> >   #define INVALID_HW_RING_ID      ((u16)-1)
> >
> > +enum {
> > +     BNGE_FW_CAP_SHORT_CMD                           =3D BIT_ULL(0),
> > +     BNGE_FW_CAP_LLDP_AGENT                          =3D BIT_ULL(1),
> > +     BNGE_FW_CAP_DCBX_AGENT                          =3D BIT_ULL(2),
> > +     BNGE_FW_CAP_IF_CHANGE                           =3D BIT_ULL(3),
> > +     BNGE_FW_CAP_KONG_MB_CHNL                        =3D BIT_ULL(4),
> > +     BNGE_FW_CAP_ERROR_RECOVERY                      =3D BIT_ULL(5),
> > +     BNGE_FW_CAP_PKG_VER                             =3D BIT_ULL(6),
> > +     BNGE_FW_CAP_CFA_ADV_FLOW                        =3D BIT_ULL(7),
> > +     BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V2             =3D BIT_ULL(8),
> > +     BNGE_FW_CAP_PCIE_STATS_SUPPORTED                =3D BIT_ULL(9),
> > +     BNGE_FW_CAP_EXT_STATS_SUPPORTED                 =3D BIT_ULL(10),
> > +     BNGE_FW_CAP_ERR_RECOVER_RELOAD                  =3D BIT_ULL(11),
> > +     BNGE_FW_CAP_HOT_RESET                           =3D BIT_ULL(12),
> > +     BNGE_FW_CAP_RX_ALL_PKT_TS                       =3D BIT_ULL(13),
> > +     BNGE_FW_CAP_VLAN_RX_STRIP                       =3D BIT_ULL(14),
> > +     BNGE_FW_CAP_VLAN_TX_INSERT                      =3D BIT_ULL(15),
> > +     BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED              =3D BIT_ULL(16),
> > +     BNGE_FW_CAP_LIVEPATCH                           =3D BIT_ULL(17),
> > +     BNGE_FW_CAP_HOT_RESET_IF                        =3D BIT_ULL(18),
> > +     BNGE_FW_CAP_RING_MONITOR                        =3D BIT_ULL(19),
> > +     BNGE_FW_CAP_DBG_QCAPS                           =3D BIT_ULL(20),
> > +     BNGE_FW_CAP_THRESHOLD_TEMP_SUPPORTED            =3D BIT_ULL(21),
> > +     BNGE_FW_CAP_DFLT_VLAN_TPID_PCP                  =3D BIT_ULL(22),
> > +     BNGE_FW_CAP_VNIC_TUNNEL_TPA                     =3D BIT_ULL(23),
> > +     BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO          =3D BIT_ULL(24),
> > +     BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V3             =3D BIT_ULL(25),
> > +     BNGE_FW_CAP_VNIC_RE_FLUSH                       =3D BIT_ULL(26),
> > +};
> > +
> >   struct bnge_dev {
> >       struct device   *dev;
> >       struct pci_dev  *pdev;
> > @@ -25,6 +62,9 @@ struct bnge_dev {
> >
> >       void __iomem    *bar0;
> >
> > +     u16             chip_num;
> > +     u8              chip_rev;
> > +
> >       /* HWRM members */
> >       u16                     hwrm_cmd_seq;
> >       u16                     hwrm_cmd_kong_seq;
> > @@ -35,6 +75,20 @@ struct bnge_dev {
> >       unsigned int            hwrm_cmd_timeout;
> >       unsigned int            hwrm_cmd_max_timeout;
> >       struct mutex            hwrm_cmd_lock;  /* serialize hwrm message=
s */
> > +
> > +     struct hwrm_ver_get_output      ver_resp;
> > +#define FW_VER_STR_LEN               32
> > +     char                    fw_ver_str[FW_VER_STR_LEN];
> > +     char                    hwrm_ver_supp[FW_VER_STR_LEN];
> > +     char                    nvm_cfg_ver[FW_VER_STR_LEN];
> > +     u64                     fw_ver_code;
> > +#define BNGE_FW_VER_CODE(maj, min, bld, rsv)                 \
> > +     ((u64)(maj) << 48 | (u64)(min) << 32 | (u64)(bld) << 16 | (rsv))
> > +
> > +     unsigned long           state;
> > +#define BNGE_STATE_DRV_REGISTERED      0
> > +
> > +     u64                     fw_cap;
> >   };
> >
> >   #endif /* _BNGE_H_ */
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_core.c
> > index 1a46c7663012..5e23eb14f60e 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> > @@ -8,6 +8,8 @@
> >
> >   #include "bnge.h"
> >   #include "bnge_devlink.h"
> > +#include "bnge_hwrm.h"
> > +#include "bnge_hwrm_lib.h"
> >
> >   MODULE_LICENSE("GPL");
> >   MODULE_DESCRIPTION(DRV_SUMMARY);
> > @@ -37,6 +39,51 @@ static void bnge_print_device_info(struct pci_dev *p=
dev, enum board_idx idx)
> >       pcie_print_link_status(pdev);
> >   }
> >
> > +static void bnge_nvm_cfg_ver_get(struct bnge_dev *bd)
> > +{
> > +     struct hwrm_nvm_get_dev_info_output nvm_info;
> > +
> > +     if (!bnge_hwrm_nvm_dev_info(bd, &nvm_info))
> > +             snprintf(bd->nvm_cfg_ver, FW_VER_STR_LEN, "%d.%d.%d",
> > +                      nvm_info.nvm_cfg_ver_maj, nvm_info.nvm_cfg_ver_m=
in,
> > +                      nvm_info.nvm_cfg_ver_upd);
> > +}
> > +
> > +static void bnge_fw_unregister_dev(struct bnge_dev *bd)
> > +{
> > +     bnge_hwrm_func_drv_unrgtr(bd);
> > +}
> > +
> > +static int bnge_fw_register_dev(struct bnge_dev *bd)
> > +{
> > +     int rc;
> > +
> > +     bd->fw_cap =3D 0;
> > +     rc =3D bnge_hwrm_ver_get(bd);
> > +     if (rc) {
> > +             dev_err(bd->dev, "Get Version command failed rc: %d\n", r=
c);
> > +             return rc;
> > +     }
> > +
> > +     bnge_nvm_cfg_ver_get(bd);
> > +
> > +     rc =3D bnge_hwrm_func_reset(bd);
> > +     if (rc) {
> > +             dev_err(bd->dev, "Failed to reset function rc: %d\n", rc)=
;
> > +             return rc;
> > +     }
> > +
> > +     bnge_hwrm_fw_set_time(bd);
> > +
> > +     rc =3D  bnge_hwrm_func_drv_rgtr(bd);
> > +     if (rc) {
> > +             dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n",=
 rc);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static void bnge_pci_disable(struct pci_dev *pdev)
> >   {
> >       pci_release_regions(pdev);
> > @@ -136,10 +183,26 @@ static int bnge_probe_one(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
> >               goto err_devl_unreg;
> >       }
> >
> > +     rc =3D bnge_init_hwrm_resources(bd);
> > +     if (rc)
> > +             goto err_bar_unmap;
> > +
> > +     rc =3D bnge_fw_register_dev(bd);
> > +     if (rc) {
> > +             dev_err(&pdev->dev, "Failed to register with firmware rc =
=3D %d\n", rc);
> > +             goto err_hwrm_cleanup;
> > +     }
> > +
> >       pci_save_state(pdev);
> >
> >       return 0;
> >
> > +err_hwrm_cleanup:
> > +     bnge_cleanup_hwrm_resources(bd);
> > +
> > +err_bar_unmap:
> > +     bnge_unmap_bars(pdev);
> > +
> >   err_devl_unreg:
> >       bnge_devlink_unregister(bd);
> >       bnge_devlink_free(bd);
> > @@ -153,6 +216,10 @@ static void bnge_remove_one(struct pci_dev *pdev)
> >   {
> >       struct bnge_dev *bd =3D pci_get_drvdata(pdev);
> >
> > +     bnge_fw_unregister_dev(bd);
> > +
> > +     bnge_cleanup_hwrm_resources(bd);
> > +
> >       bnge_unmap_bars(pdev);
> >
> >       bnge_devlink_unregister(bd);
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/driver=
s/net/ethernet/broadcom/bnge/bnge_devlink.c
> > index d406338da130..f987d35beea2 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> > @@ -8,6 +8,7 @@
> >
> >   #include "bnge.h"
> >   #include "bnge_devlink.h"
> > +#include "bnge_hwrm_lib.h"
> >
> >   static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_=
req *req,
> >                           enum bnge_dl_version_type type, const char *k=
ey,
> > @@ -16,6 +17,10 @@ static int bnge_dl_info_put(struct bnge_dev *bd, str=
uct devlink_info_req *req,
> >       if (!strlen(buf))
> >               return 0;
> >
> > +     if (!strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_NCSI) ||
> > +         !strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_ROCE))
> > +             return 0;
> > +
> >       switch (type) {
> >       case BNGE_VERSION_FIXED:
> >               return devlink_info_version_fixed_put(req, key, buf);
> > @@ -63,11 +68,20 @@ static void bnge_vpd_read_info(struct bnge_dev *bd)
> >       kfree(vpd_data);
> >   }
> >
> > +#define HWRM_FW_VER_STR_LEN  16
> > +
> >   static int bnge_devlink_info_get(struct devlink *devlink,
> >                                struct devlink_info_req *req,
> >                                struct netlink_ext_ack *extack)
> >   {
> > +     struct hwrm_nvm_get_dev_info_output nvm_dev_info;
> >       struct bnge_dev *bd =3D devlink_priv(devlink);
> > +     struct hwrm_ver_get_output *ver_resp;
> > +     char mgmt_ver[FW_VER_STR_LEN];
> > +     char roce_ver[FW_VER_STR_LEN];
> > +     char ncsi_ver[FW_VER_STR_LEN];
> > +     char buf[32];
> > +
> >       int rc;
> >
> >       if (bd->dsn) {
> > @@ -95,6 +109,112 @@ static int bnge_devlink_info_get(struct devlink *d=
evlink,
> >                             DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
> >                             bd->board_partno);
> >
> > +     /* More information from HWRM ver get command */
> > +     sprintf(buf, "%X", bd->chip_num);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_ASIC_ID, buf);
> > +     if (rc)
> > +             return rc;
> > +
> > +     ver_resp =3D &bd->ver_resp;
> > +     sprintf(buf, "%c%d", 'A' + ver_resp->chip_rev, ver_resp->chip_met=
al);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_ASIC_REV, buf)=
;
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_PSID,
> > +                           bd->nvm_cfg_ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     buf[0] =3D 0;
> > +     strncat(buf, ver_resp->active_pkg_name, HWRM_FW_VER_STR_LEN);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW, buf);
> > +     if (rc)
> > +             return rc;
> > +
> > +     if (ver_resp->flags & VER_GET_RESP_FLAGS_EXT_VER_AVAIL) {
> > +             snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->hwrm_fw_major, ver_resp->hwrm_fw_minor=
,
> > +                      ver_resp->hwrm_fw_build, ver_resp->hwrm_fw_patch=
);
> > +
> > +             snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->mgmt_fw_major, ver_resp->mgmt_fw_minor=
,
> > +                      ver_resp->mgmt_fw_build, ver_resp->mgmt_fw_patch=
);
> > +
> > +             snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->roce_fw_major, ver_resp->roce_fw_minor=
,
> > +                      ver_resp->roce_fw_build, ver_resp->roce_fw_patch=
);
> > +     } else {
> > +             snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->hwrm_fw_maj_8b, ver_resp->hwrm_fw_min_=
8b,
> > +                      ver_resp->hwrm_fw_bld_8b, ver_resp->hwrm_fw_rsvd=
_8b);
> > +
> > +             snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->mgmt_fw_maj_8b, ver_resp->mgmt_fw_min_=
8b,
> > +                      ver_resp->mgmt_fw_bld_8b, ver_resp->mgmt_fw_rsvd=
_8b);
> > +
> > +             snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +                      ver_resp->roce_fw_maj_8b, ver_resp->roce_fw_min_=
8b,
> > +                      ver_resp->roce_fw_bld_8b, ver_resp->roce_fw_rsvd=
_8b);
> > +     }
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, mgmt_=
ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
> > +                           bd->hwrm_ver_supp);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_NCSI, ncsi_=
ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_ROCE, roce_=
ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bnge_hwrm_nvm_dev_info(bd, &nvm_dev_info);
> > +     if (!(nvm_dev_info.flags & NVM_GET_DEV_INFO_RESP_FLAGS_FW_VER_VAL=
ID))
> > +             return 0;
> > +
> > +     buf[0] =3D 0;
> > +     strncat(buf, nvm_dev_info.pkg_name, HWRM_FW_VER_STR_LEN);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW, buf);
> > +     if (rc)
> > +             return rc;
> > +
> > +     snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +              nvm_dev_info.hwrm_fw_major, nvm_dev_info.hwrm_fw_minor,
> > +              nvm_dev_info.hwrm_fw_build, nvm_dev_info.hwrm_fw_patch);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, mgmt_=
ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +              nvm_dev_info.mgmt_fw_major, nvm_dev_info.mgmt_fw_minor,
> > +              nvm_dev_info.mgmt_fw_build, nvm_dev_info.mgmt_fw_patch);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_NCSI, ncsi_=
ver);
> > +     if (rc)
> > +             return rc;
> > +
> > +     snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +              nvm_dev_info.roce_fw_major, nvm_dev_info.roce_fw_minor,
> > +              nvm_dev_info.roce_fw_build, nvm_dev_info.roce_fw_patch);
> > +     rc =3D bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
> > +                           DEVLINK_INFO_VERSION_GENERIC_FW_ROCE, roce_=
ver);
> > +
> >       return rc;
> >   }
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drive=
rs/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > new file mode 100644
> > index 000000000000..567376a407df
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2025 Broadcom.
> > +
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/pci.h>
> > +
> > +#include "bnge.h"
> > +#include "../bnxt/bnxt_hsi.h"
> > +#include "bnge_hwrm.h"
> > +#include "bnge_hwrm_lib.h"
> > +
> > +int bnge_hwrm_ver_get(struct bnge_dev *bd)
> > +{
> > +     u32 dev_caps_cfg, hwrm_ver, hwrm_spec_code;
> > +     u16 fw_maj, fw_min, fw_bld, fw_rsv;
> > +     struct hwrm_ver_get_output *resp;
> > +     struct hwrm_ver_get_input *req;
> > +     int rc;
> > +
> > +     rc =3D hwrm_req_init(bd, req, HWRM_VER_GET);
> > +     if (rc)
> > +             return rc;
> > +
> > +     hwrm_req_flags(bd, req, BNGE_HWRM_FULL_WAIT);
> > +     bd->hwrm_max_req_len =3D HWRM_MAX_REQ_LEN;
> > +     req->hwrm_intf_maj =3D HWRM_VERSION_MAJOR;
> > +     req->hwrm_intf_min =3D HWRM_VERSION_MINOR;
> > +     req->hwrm_intf_upd =3D HWRM_VERSION_UPDATE;
> > +
> > +     resp =3D hwrm_req_hold(bd, req);
> > +     rc =3D hwrm_req_send(bd, req);
> > +     if (rc)
> > +             goto hwrm_ver_get_exit;
> > +
> > +     memcpy(&bd->ver_resp, resp, sizeof(struct hwrm_ver_get_output));
> > +
> > +     hwrm_spec_code =3D resp->hwrm_intf_maj_8b << 16 |
> > +                      resp->hwrm_intf_min_8b << 8 |
> > +                      resp->hwrm_intf_upd_8b;
> > +     hwrm_ver =3D HWRM_VERSION_MAJOR << 16 | HWRM_VERSION_MINOR << 8 |
> > +                     HWRM_VERSION_UPDATE;
> > +
> > +     if (hwrm_spec_code > hwrm_ver)
> > +             snprintf(bd->hwrm_ver_supp, FW_VER_STR_LEN, "%d.%d.%d",
> > +                      HWRM_VERSION_MAJOR, HWRM_VERSION_MINOR,
> > +                      HWRM_VERSION_UPDATE);
> > +     else
> > +             snprintf(bd->hwrm_ver_supp, FW_VER_STR_LEN, "%d.%d.%d",
> > +                      resp->hwrm_intf_maj_8b, resp->hwrm_intf_min_8b,
> > +                      resp->hwrm_intf_upd_8b);
> > +
> > +     fw_maj =3D le16_to_cpu(resp->hwrm_fw_major);
> > +     fw_min =3D le16_to_cpu(resp->hwrm_fw_minor);
> > +     fw_bld =3D le16_to_cpu(resp->hwrm_fw_build);
> > +     fw_rsv =3D le16_to_cpu(resp->hwrm_fw_patch);
> > +
> > +     bd->fw_ver_code =3D BNGE_FW_VER_CODE(fw_maj, fw_min, fw_bld, fw_r=
sv);
> > +     snprintf(bd->fw_ver_str, FW_VER_STR_LEN, "%d.%d.%d.%d",
> > +              fw_maj, fw_min, fw_bld, fw_rsv);
> > +
> > +     if (strlen(resp->active_pkg_name)) {
> > +             int fw_ver_len =3D strlen(bd->fw_ver_str);
> > +
> > +             snprintf(bd->fw_ver_str + fw_ver_len,
> > +                      FW_VER_STR_LEN - fw_ver_len - 1, "/pkg %s",
> > +                      resp->active_pkg_name);
> > +             bd->fw_cap |=3D BNGE_FW_CAP_PKG_VER;
> > +     }
> > +
> > +     bd->hwrm_cmd_timeout =3D le16_to_cpu(resp->def_req_timeout);
> > +     if (!bd->hwrm_cmd_timeout)
> > +             bd->hwrm_cmd_timeout =3D DFLT_HWRM_CMD_TIMEOUT;
> > +     bd->hwrm_cmd_max_timeout =3D le16_to_cpu(resp->max_req_timeout) *=
 1000;
> > +     if (!bd->hwrm_cmd_max_timeout)
> > +             bd->hwrm_cmd_max_timeout =3D HWRM_CMD_MAX_TIMEOUT;
> > +     else if (bd->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT)
> > +                     dev_warn(bd->dev, "Default HWRM commands max time=
out increased to %d seconds\n",
> > +                              bd->hwrm_cmd_max_timeout / 1000);
> > +
> > +     bd->hwrm_max_req_len =3D le16_to_cpu(resp->max_req_win_len);
> > +     bd->hwrm_max_ext_req_len =3D le16_to_cpu(resp->max_ext_req_len);
> > +
> > +     if (bd->hwrm_max_ext_req_len < HWRM_MAX_REQ_LEN)
> > +             bd->hwrm_max_ext_req_len =3D HWRM_MAX_REQ_LEN;
> > +
> > +     bd->chip_num =3D le16_to_cpu(resp->chip_num);
> > +     bd->chip_rev =3D resp->chip_rev;
> > +
> > +     dev_caps_cfg =3D le32_to_cpu(resp->dev_caps_cfg);
> > +     if ((dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_SUPPORTED=
) &&
> > +         (dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_REQUIRED)=
)
> > +             bd->fw_cap |=3D BNGE_FW_CAP_SHORT_CMD;
> > +
> > +     if (dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_KONG_MB_CHNL_SUPPORT=
ED)
> > +             bd->fw_cap |=3D BNGE_FW_CAP_KONG_MB_CHNL;
> > +
> > +     if (dev_caps_cfg &
> > +         VER_GET_RESP_DEV_CAPS_CFG_CFA_ADV_FLOW_MGNT_SUPPORTED)
> > +             bd->fw_cap |=3D BNGE_FW_CAP_CFA_ADV_FLOW;
> > +
> > +hwrm_ver_get_exit:
> > +     hwrm_req_drop(bd, req);
> > +     return rc;
> > +}
> > +
> > +int
> > +bnge_hwrm_nvm_dev_info(struct bnge_dev *bd,
> > +                    struct hwrm_nvm_get_dev_info_output *nvm_info)
> > +{
> > +     struct hwrm_nvm_get_dev_info_output *resp;
> > +     struct hwrm_nvm_get_dev_info_input *req;
> > +     int rc;
> > +
> > +     rc =3D hwrm_req_init(bd, req, HWRM_NVM_GET_DEV_INFO);
> > +     if (rc)
> > +             return rc;
> > +
> > +     resp =3D hwrm_req_hold(bd, req);
> > +     rc =3D hwrm_req_send(bd, req);
> > +     if (!rc)
> > +             memcpy(nvm_info, resp, sizeof(*resp));
> > +     hwrm_req_drop(bd, req);
> > +     return rc;
> > +}
> > +
> > +int bnge_hwrm_func_reset(struct bnge_dev *bd)
> > +{
> > +     struct hwrm_func_reset_input *req;
> > +     int rc;
> > +
> > +     rc =3D hwrm_req_init(bd, req, HWRM_FUNC_RESET);
> > +     if (rc)
> > +             return rc;
> > +
> > +     req->enables =3D 0;
> > +     hwrm_req_timeout(bd, req, HWRM_RESET_TIMEOUT);
> > +     return hwrm_req_send(bd, req);
> > +}
> > +
> > +int bnge_hwrm_fw_set_time(struct bnge_dev *bd)
> > +{
> > +     struct hwrm_fw_set_time_input *req;
> > +     struct tm tm;
> > +     time64_t now =3D ktime_get_real_seconds();
> > +     int rc;
>
> Reverse xmass tree, please. Not quite sure you need this 'now'
> variable at all. You can use ktime_get_real_seconds() directly
> in time64_to_tm() - there are examples of such code in the kernel.

 Will fix it in v2.

>
> > +
> > +     time64_to_tm(now, 0, &tm);
> > +     rc =3D hwrm_req_init(bd, req, HWRM_FW_SET_TIME);
> > +     if (rc)
> > +             return rc;
> > +
> > +     req->year =3D cpu_to_le16(1900 + tm.tm_year);
> > +     req->month =3D 1 + tm.tm_mon;
> > +     req->day =3D tm.tm_mday;
> > +     req->hour =3D tm.tm_hour;
> > +     req->minute =3D tm.tm_min;
> > +     req->second =3D tm.tm_sec;
> > +     return hwrm_req_send(bd, req);
> > +}
>
> This whole function looks like copy-paste from bnxt, did you consider
> merging these parts?

Both the bnxt and bnge drivers follow the same protocol to send the
requests to  the firmware,
so some functions may appear similar. However, we do not plan to share
the code, as certain
 fundamental data structures will differ.

>
>
> > +
> > +int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
> > +{
> > +     struct hwrm_func_drv_rgtr_output *resp;
> > +     struct hwrm_func_drv_rgtr_input *req;
> > +     u32 flags;
> > +     int rc;
> > +
> > +     rc =3D hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
> > +     if (rc)
> > +             return rc;
> > +
> > +     req->enables =3D cpu_to_le32(FUNC_DRV_RGTR_REQ_ENABLES_OS_TYPE |
> > +                                FUNC_DRV_RGTR_REQ_ENABLES_VER |
> > +                                FUNC_DRV_RGTR_REQ_ENABLES_ASYNC_EVENT_=
FWD);
> > +
> > +     req->os_type =3D cpu_to_le16(FUNC_DRV_RGTR_REQ_OS_TYPE_LINUX);
> > +     flags =3D FUNC_DRV_RGTR_REQ_FLAGS_16BIT_VER_MODE;
> > +
> > +     req->flags =3D cpu_to_le32(flags);
> > +     req->ver_maj_8b =3D DRV_VER_MAJ;
> > +     req->ver_min_8b =3D DRV_VER_MIN;
> > +     req->ver_upd_8b =3D DRV_VER_UPD;
> > +     req->ver_maj =3D cpu_to_le16(DRV_VER_MAJ);
> > +     req->ver_min =3D cpu_to_le16(DRV_VER_MIN);
> > +     req->ver_upd =3D cpu_to_le16(DRV_VER_UPD);
> > +
> > +     resp =3D hwrm_req_hold(bd, req);
> > +     rc =3D hwrm_req_send(bd, req);
> > +     if (!rc) {
> > +             set_bit(BNGE_STATE_DRV_REGISTERED, &bd->state);
> > +             if (resp->flags &
> > +                 cpu_to_le32(FUNC_DRV_RGTR_RESP_FLAGS_IF_CHANGE_SUPPOR=
TED))
> > +                     bd->fw_cap |=3D BNGE_FW_CAP_IF_CHANGE;
> > +     }
> > +     hwrm_req_drop(bd, req);
> > +     return rc;
> > +}
> > +
> > +int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd)
> > +{
> > +     struct hwrm_func_drv_unrgtr_input *req;
> > +     int rc;
> > +
> > +     if (!test_and_clear_bit(BNGE_STATE_DRV_REGISTERED, &bd->state))
> > +             return 0;
> > +
> > +     rc =3D hwrm_req_init(bd, req, HWRM_FUNC_DRV_UNRGTR);
> > +     if (rc)
> > +             return rc;
> > +     return hwrm_req_send(bd, req);
> > +}
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drive=
rs/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
> > new file mode 100644
> > index 000000000000..9308d4fe64d2
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_HWRM_LIB_H_
> > +#define _BNGE_HWRM_LIB_H_
> > +
> > +int bnge_hwrm_ver_get(struct bnge_dev *bd);
> > +int bnge_hwrm_func_reset(struct bnge_dev *bd);
> > +int bnge_hwrm_fw_set_time(struct bnge_dev *bd);
> > +int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd);
> > +int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd);
> > +int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd);
> > +int bnge_hwrm_nvm_dev_info(struct bnge_dev *bd,
> > +                        struct hwrm_nvm_get_dev_info_output *nvm_dev_i=
nfo);
> > +
> > +#endif /* _BNGE_HWRM_LIB_H_ */
>

--000000000000cbfd8f06384ec3e0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
1Z53HzleM75CAMHDl8NYGve9BgWmJRrMksHjn8TcXwOoXQ4QkkBXnMc3Gl+XSbAXXNw1oU96EW5r
k0vJWVnbznBdI0eiFVP+mokagWcF65WhrJr1gzlBAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGHZpa2FzLmd1cHRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUQUO4R8Bg/yLjD8B1Jr9JLitNMlIw
DQYJKoZIhvcNAQELBQADggEBACj8NkM/SQOdFy4b+Kn9Q/IE8KHCkf/qubyurG45FhIIv8eUflaW
ZkYiC3z+qo7iXxFvNJ4irfvMtG+idVVrOEFa56FKvixdXk2mlzsojV7lNPlVtn8X2mry47rVMq0G
AQPU6HuihzH/SrKdypyxv+4QqSGpLs587FN3ydGrrw8J96rBt0qqzFMt65etOx73KyU/LylBqQ+6
oCSF3t69LpmLmIwRkXxtqIrB7m9OjROeMnXWS9+b5krW8rnUbgqiJVvWldgtno3kiKdEwnOwVjY+
gZdPq7+WE2Otw7O0i1ReJKwnmWksFwr/sT4LYfFlJwA0LlYRHmhR+lhz9jj0iXkxggJgMIICXAIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMFhgQqM5emFpsS5wwDQYJ
YIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINrZKoZZCq3W+YWHShn36M0oew8SLXnkpsmR
/XsxdwhOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYyNDEw
MjY0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBAFfcnpy9ahpJrsQnDy9FZ5vYFRRrP9DU7YOedmRthj3D/k2yaVhcBPQCD4sqoWIunydJy97J
timsPXXRcCNI4wcVJsA4DLBETYnGCGp7OjTmvAk13eMGnHup7hIq7k1t3T0pz5vH/C/5nLTbBnMg
pG+C/ZarS0rGmJ/Jp5sZjpiJCPEo9Y/mozHdmrLVNzGMOjEJFMD5MmehKHJPsObjnwRGp5vwrGgk
T07MkeUy5arHNtSioSmXFms9FEPmSX6GOH/rxVbIHvMw+wv3eo0p3np53raB3cVMRAe3tuATZoe0
TkihQF4lCAQahcUgJTEHTlQeF7vsIZlcZsoBEogXas4=
--000000000000cbfd8f06384ec3e0--

