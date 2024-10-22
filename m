Return-Path: <netdev+bounces-137967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDF9AB485
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC0F285B80
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309611BC091;
	Tue, 22 Oct 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DZulDOC6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8C256D
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616281; cv=none; b=W8kWRzCxRnDWcB1j+gTD+0M0a0fEbpNz9RdjODv2Azn5kleJiAxrbgGVAN4PdpV9pPq1YWb3z2mx3TjOkMCogFYboO9fjqMHc7fBuk3QPhoOuL+D4bu+qTckEfG/AKMakBs7GQkNDOn0il6x1t6Y/5oGLCrtxb4M8Q48x18+Scc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616281; c=relaxed/simple;
	bh=8YB+hUKC9Y0MPMTjory6QE+isVZGl6R55RoG43/6Q1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtbFSNlWw3zlc1ale/BQ5DK69Qz5/WqPmTWulJMY8IrLfxbTMPmpt4G5uWdNPBYEQPsg+r8Atm0RW+0JF3zL8S7JisEolnPyJ5kFeCdwFKwhX8rJdB9zgNrDTKeTLC4JctVSFs75Q1HimyyfTP0NuoSdkoUn9Q/ukvU4Wfkd+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DZulDOC6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f7606199so6549489e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729616277; x=1730221077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gndi7aJfGW/Q6n+YiP+90XGrqeR1zvtY3UWJ015Rluk=;
        b=DZulDOC6nwBLXua2rNLQvY9XSYK+aCsyuTK88CnMwjG38TwKOZ8Xeg+aWR7ZkiBB0Z
         U08frYZ664E2HXliWNQuHMmyrpe6l1EqETOj+Apvq0za+86JNhYLNYaWwayEw3ka/wd2
         Gwn0+wPahKwUDOK+cS9depTDDQflM3uFEZ/Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616277; x=1730221077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gndi7aJfGW/Q6n+YiP+90XGrqeR1zvtY3UWJ015Rluk=;
        b=hSPnuK5I06Q6giV1+vdXOzFAixqu8zW18P4zjVOBVaR+U73FoM7cFDFU5mTsftfJgO
         Xkj0b8DD39MWDiTFUCnPN/qCvtPvu9yx+tIgdMn3sEHIuRMPzsULiVuiHK6I3Cf6K+pQ
         zBF4C1+sn5agTyTC4W2/cMy6yduMoz++IQ1WTqCLEUFvJFBPFPxFI5eMnQmi2r0vMMTh
         O2CDDy/IvcmM+wfZWEAlFqlveZe25nMcxYc+HttSVVhMLN8A/oPkCCSghgpyhkICWd9N
         jYq+O6MdtxnPCE9ysM11lz4L5cZOnHkoqBRciTDIpemdVLJpWUFFXLOC/FBSRiwpxCnP
         tTyA==
X-Gm-Message-State: AOJu0YwMcUEl6iy9ho/+LUffQTW7GRuFMvUGIk+sFN4nnAuoPhf9tN6r
	snVbqIOdOZoQeNmfhaL3Fun9bIWyNQF0DyxdNCIn1RVFmCdSXDshRsOIblttwUZtaVozlO/2rgw
	xGl5KJjkvRnxcqE5r2r9aYStJgKOcS+xCDd1p
X-Google-Smtp-Source: AGHT+IHhwUFWkp/15ER2rQlev/FJMi9P9C1uEUKU0FrpPb1laVi/4A+vCDATbwCWteHzFDlFC+Vf/wzLq12Iyjgue8k=
X-Received: by 2002:a05:6512:3996:b0:539:e58a:9704 with SMTP id
 2adb3069b0e04-53b12c04287mr2334953e87.33.1729616276860; Tue, 22 Oct 2024
 09:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022041707.27402-1-neescoba@cisco.com> <20241022041707.27402-5-neescoba@cisco.com>
In-Reply-To: <20241022041707.27402-5-neescoba@cisco.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 22 Oct 2024 22:27:45 +0530
Message-ID: <CAH-L+nPLFBVAHA2f5qw942mmiFoNwu9ZWvHHzN8C6a9p1hnkYw@mail.gmail.com>
Subject: Re: [Patch net-next 4/5] enic: Allocate arrays in enic struct based
 on VIC config
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cea13a062513ab95"

--000000000000cea13a062513ab95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:49=E2=80=AFAM Nelson Escobar <neescoba@cisco.com>=
 wrote:
>
> Allocate wq, rq, cq, intr, and napi arrays based on the number of
> resources configured in the VIC.
>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic.h      |  24 ++---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 102 ++++++++++++++++++--
>  2 files changed, 105 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/etherne=
t/cisco/enic/enic.h
> index 1f32413a8f7c..cfb4667953de 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -23,10 +23,8 @@
>
>  #define ENIC_BARS_MAX          6
>
> -#define ENIC_WQ_MAX            8
> -#define ENIC_RQ_MAX            8
> -#define ENIC_CQ_MAX            (ENIC_WQ_MAX + ENIC_RQ_MAX)
> -#define ENIC_INTR_MAX          (ENIC_CQ_MAX + 2)
> +#define ENIC_WQ_MAX            256
> +#define ENIC_RQ_MAX            256
>
>  #define ENIC_WQ_NAPI_BUDGET    256
>
> @@ -184,8 +182,8 @@ struct enic {
>         struct work_struct reset;
>         struct work_struct tx_hang_reset;
>         struct work_struct change_mtu_work;
> -       struct msix_entry msix_entry[ENIC_INTR_MAX];
> -       struct enic_msix_entry msix[ENIC_INTR_MAX];
> +       struct msix_entry *msix_entry;
> +       struct enic_msix_entry *msix;
>         u32 msg_enable;
>         spinlock_t devcmd_lock;
>         u8 mac_addr[ETH_ALEN];
> @@ -204,28 +202,24 @@ struct enic {
>         bool enic_api_busy;
>         struct enic_port_profile *pp;
>
> -       /* work queue cache line section */
> -       ____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
> +       struct enic_wq *wq;
>         unsigned int wq_avail;
>         unsigned int wq_count;
>         u16 loop_enable;
>         u16 loop_tag;
>
> -       /* receive queue cache line section */
> -       ____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
> +       struct enic_rq *rq;
>         unsigned int rq_avail;
>         unsigned int rq_count;
>         struct vxlan_offload vxlan;
> -       struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
> +       struct napi_struct *napi;
>
> -       /* interrupt resource cache line section */
> -       ____cacheline_aligned struct vnic_intr intr[ENIC_INTR_MAX];
> +       struct vnic_intr *intr;
>         unsigned int intr_avail;
>         unsigned int intr_count;
>         u32 __iomem *legacy_pba;                /* memory-mapped */
>
> -       /* completion queue cache line section */
> -       ____cacheline_aligned struct vnic_cq cq[ENIC_CQ_MAX];
> +       struct vnic_cq *cq;
>         unsigned int cq_avail;
>         unsigned int cq_count;
>         struct enic_rfs_flw_tbl rfs_h;
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/et=
hernet/cisco/enic/enic_main.c
> index eb00058b6c68..a5d607be66b7 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -940,7 +940,7 @@ static void enic_get_stats(struct net_device *netdev,
>         net_stats->rx_errors =3D stats->rx.rx_errors;
>         net_stats->multicast =3D stats->rx.rx_multicast_frames_ok;
>
> -       for (i =3D 0; i < ENIC_RQ_MAX; i++) {
> +       for (i =3D 0; i < enic->rq_count; i++) {
>                 struct enic_rq_stats *rqs =3D &enic->rq[i].stats;
>
>                 if (!enic->rq[i].vrq.ctrl)
> @@ -1792,7 +1792,7 @@ static void enic_free_intr(struct enic *enic)
>                 free_irq(enic->pdev->irq, enic);
>                 break;
>         case VNIC_DEV_INTR_MODE_MSIX:
> -               for (i =3D 0; i < ARRAY_SIZE(enic->msix); i++)
> +               for (i =3D 0; i < enic->intr_count; i++)
>                         if (enic->msix[i].requested)
>                                 free_irq(enic->msix_entry[i].vector,
>                                         enic->msix[i].devid);
> @@ -1859,7 +1859,7 @@ static int enic_request_intr(struct enic *enic)
>                 enic->msix[intr].isr =3D enic_isr_msix_notify;
>                 enic->msix[intr].devid =3D enic;
>
> -               for (i =3D 0; i < ARRAY_SIZE(enic->msix); i++)
> +               for (i =3D 0; i < enic->intr_count; i++)
>                         enic->msix[i].requested =3D 0;
>
>                 for (i =3D 0; i < enic->intr_count; i++) {
> @@ -2456,8 +2456,7 @@ static int enic_set_intr_mode(struct enic *enic)
>          * (the last INTR is used for notifications)
>          */
>
> -       BUG_ON(ARRAY_SIZE(enic->msix_entry) < n + m + 2);
> -       for (i =3D 0; i < n + m + 2; i++)
> +       for (i =3D 0; i < enic->intr_avail; i++)
>                 enic->msix_entry[i].entry =3D i;
>
>         /* Use multiple RQs if RSS is enabled
> @@ -2674,6 +2673,89 @@ static const struct netdev_stat_ops enic_netdev_st=
at_ops =3D {
>         .get_base_stats         =3D enic_get_base_stats,
>  };
>
> +static void enic_free_enic_resources(struct enic *enic)
> +{
> +       kfree(enic->wq);
> +       enic->wq =3D NULL;
> +
> +       kfree(enic->rq);
> +       enic->rq =3D NULL;
> +
> +       kfree(enic->cq);
> +       enic->cq =3D NULL;
> +
> +       kfree(enic->napi);
> +       enic->napi =3D NULL;
> +
> +       kfree(enic->msix_entry);
> +       enic->msix_entry =3D NULL;
> +
> +       kfree(enic->msix);
> +       enic->msix =3D NULL;
> +
> +       kfree(enic->intr);
> +       enic->intr =3D NULL;
> +}
> +
> +static int enic_alloc_enic_resources(struct enic *enic)
> +{
> +       int ret;
[Kalesh] There is no need for a local variable here. You can return
-ENOMEM in the error path directly.
> +
> +       enic->wq =3D NULL;
> +       enic->rq =3D NULL;
> +       enic->cq =3D NULL;
> +       enic->napi =3D NULL;
> +       enic->msix_entry =3D NULL;
> +       enic->msix =3D NULL;
> +       enic->intr =3D NULL;
[Kalesh] Looks like the above NULL pointer assignments are redundant.
all those fields will be 0 anyway.
> +
> +       enic->wq =3D kcalloc(enic->wq_avail, sizeof(struct enic_wq), GFP_=
KERNEL);
> +       if (!enic->wq) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->rq =3D kcalloc(enic->rq_avail, sizeof(struct enic_rq), GFP_=
KERNEL);
> +       if (!enic->rq) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->cq =3D kcalloc(enic->cq_avail, sizeof(struct vnic_cq), GFP_=
KERNEL);
> +       if (!enic->cq) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->napi =3D kcalloc(enic->wq_avail + enic->rq_avail,
> +                            sizeof(struct napi_struct), GFP_KERNEL);
> +       if (!enic->napi) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->msix_entry =3D kcalloc(enic->intr_avail, sizeof(struct msix=
_entry),
> +                                  GFP_KERNEL);
> +       if (!enic->msix_entry) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->msix =3D kcalloc(enic->intr_avail, sizeof(struct enic_msix_=
entry),
> +                            GFP_KERNEL);
> +       if (!enic->msix) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +       enic->intr =3D kcalloc(enic->intr_avail, sizeof(struct vnic_intr)=
,
> +                            GFP_KERNEL);
> +       if (!enic->intr) {
> +               ret =3D -ENOMEM;
> +               goto free_queues;
> +       }
> +
> +       return 0;
> +
> +free_queues:
> +       enic_free_enic_resources(enic);
> +       return ret;
> +}
> +
>  static void enic_dev_deinit(struct enic *enic)
>  {
>         unsigned int i;
> @@ -2691,6 +2773,7 @@ static void enic_dev_deinit(struct enic *enic)
>         enic_free_vnic_resources(enic);
>         enic_clear_intr_mode(enic);
>         enic_free_affinity_hint(enic);
> +       enic_free_enic_resources(enic);
>  }
>
>  static void enic_kdump_kernel_config(struct enic *enic)
> @@ -2734,6 +2817,12 @@ static int enic_dev_init(struct enic *enic)
>
>         enic_get_res_counts(enic);
>
> +       err =3D enic_alloc_enic_resources(enic);
> +       if (err) {
> +               dev_err(dev, "Failed to allocate queues, aborting\n");
[Kalesh] You can drop this error log in case you want as memory
allocation failure will be logged by OOM.
> +               return err;
> +       }
> +
>         /* modify resource count if we are in kdump_kernel
>          */
>         enic_kdump_kernel_config(enic);
> @@ -2746,7 +2835,7 @@ static int enic_dev_init(struct enic *enic)
>         if (err) {
>                 dev_err(dev, "Failed to set intr mode based on resource "
>                         "counts and system capabilities, aborting\n");
> -               return err;
> +               goto err_out_free_vnic_resources;
>         }
>
>         /* Allocate and configure vNIC resources
> @@ -2788,6 +2877,7 @@ static int enic_dev_init(struct enic *enic)
>         enic_free_affinity_hint(enic);
>         enic_clear_intr_mode(enic);
>         enic_free_vnic_resources(enic);
> +       enic_free_enic_resources(enic);
>
>         return err;
>  }
> --
> 2.35.2
>
>


--=20
Regards,
Kalesh A P

--000000000000cea13a062513ab95
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIJHSstFd7NfU8K72/nwHkZBoAyeDBrGlpZbKNBcUVWDwMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAyMjE2NTc1N1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDFWtftu4BC
tSUwb63S5HOhof6c/MgWDbf7IXxSFZXyafxSLVe1vCJu5QFQEQge3exoXUj7pfkEpM4+FYFjFu0s
fQPHZCVrlFGMUDebUavHMUwybfH0PmttmXM8kbnqrS21mQivoYfQI91YwbX9H+RN91xT9Fm3uNYR
SsesADZV8ocZC4PDLcdf8M7UTXT6p73K1cUnITj/YWeu/aHqGSjVYfFdNJYvZ4+0EpfH5tQ6Qa6/
EkQ/zSHoI8nqQ9EoHkdi2rZm8tyYtHHnne0ZOs//R734A/2nBRUBbqCdvpWas2nrnjVFdhrYZxZH
9hCICRlgFRj1ATflCFcEfboWKEeM
--000000000000cea13a062513ab95--

