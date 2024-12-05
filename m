Return-Path: <netdev+bounces-149298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C49E50E3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E71628C057
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113FB1D5AAE;
	Thu,  5 Dec 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BqfH0zSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFC1D3194
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389844; cv=none; b=pENbQgWsz5AVXj3v1H2ORum9sSt4KV7UHCyRdl5ACgckUpUfEnbNAQ2pEDaVTw6dznDT66ZjR94Mq/Kb/R47l1VI2m+6tri9ws9juXZQZMFPBDWkageNCbWZkvxNkJOhOS4ExENrFddqaz277ZCy2tObUeDxx7eX7nLecIE13Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389844; c=relaxed/simple;
	bh=2wDmTcIoUQDZayxsczS/aJZzWbxzDoBe7ZouHwLIUww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am1qX7+18wLzsggoIZVG74TuvIjZDaygeWCqjdx/t01i5RnqtpIk5b47xthLil6AHyDJWwiQ2t9TzO6cmrD2w4JXQTwpajH11bcM7o3FU8he8rmXcXnAvraSB32v+VUdHjSXlIm4+OMRiekAJyjGSZ5tlHmmuIqx2tk8G/Nstrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BqfH0zSP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffc016f301so5438111fa.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733389840; x=1733994640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEDFZtRJsKrW8HWUUW4r9JjXy+sq8oo0H0rwdXsRrWM=;
        b=BqfH0zSP61ZHoWdfGSYbW3bUO5BlJE+QfkkZLguivJeHGQurPiIsf6V8rNMl0Ydo70
         Q1EiMfyULtlX6JXUX8rZRFNNu5IuUzmeQUWVHlJwSU13Vf0AKtaC+2ak+J2pOCOiIUjk
         LAbLmQmbY1dtZrDQ+5L9k2hLJwixO+vpTR1iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389840; x=1733994640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEDFZtRJsKrW8HWUUW4r9JjXy+sq8oo0H0rwdXsRrWM=;
        b=JV97dkc5DxU041jTWaQiP8h1wF06e1I50mA+nHPQ7T9dsHXOWeFsTkfA6d1KFdWqBb
         86c4u3gE7KwMpJTQs3yIUUU6tOWL2sUvdrTb4iZWoaLdGVedelIml1nhRovU8YV61WZV
         cTaOe3vq/H7UhLiiJkAIh8IX+ZO34qoTzP4x803J58jZ3UcWRUadwf+Tnb/BDVsMkqwt
         XpHZ+fQ6T4BqHqpSw4tpBGMLykDbmVbR4D2pi4CMX+6dHAoDPjMlHw4aoCjk9pWuN8Ar
         vJkqULXidt+4Ta+h63NoclDZdniVfGWPlIvinSpIZdIsHNhotxp1wcYOAButi2pe15eF
         fsNg==
X-Forwarded-Encrypted: i=1; AJvYcCVvL2HWmDpc/aQSjmf3SyEX6yX3uSsZR8IwObjJersCchc8rjkhac+W1IbhYkcHDahpqbpLHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkUbxB9ZpmOeaeQ1HWK2SpeOvvIlo/6pnaLmBUCsahx+7chLb
	ln+YBpJi0+V5mACcYsViVdEgf1MXYvmqEZ6vxsPCMJxlkT2PhWjfcni1GygHJsq9Gy1Y+ByXD7a
	vJ2qI9vuoSf3BC1L0Z4sfUj+MVaB+XEosOKyd
X-Gm-Gg: ASbGncu+WXAXTMoVCPXuvkJH2wXOFZhioHQk7pSPm5vDx57hA5c5CHt6EAad9T3plqk
	Blf0RDJyJASF3X5zbRhmZYyLBWSvpYiHt
X-Google-Smtp-Source: AGHT+IGn/pgMTjgloLf4j+kXsj9LKNGzVQPY3drSni3xL/nobjt9m9/02l9WnyGBZk/95JUU4qEw7v8MdWTSddMP/L4=
X-Received: by 2002:a05:6512:3194:b0:53d:e41a:c182 with SMTP id
 2adb3069b0e04-53e12a059aamr5418764e87.31.1733389840327; Thu, 05 Dec 2024
 01:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205082831.777868-1-m-malladi@ti.com> <20241205082831.777868-2-m-malladi@ti.com>
In-Reply-To: <20241205082831.777868-2-m-malladi@ti.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 5 Dec 2024 14:40:28 +0530
Message-ID: <CAH-L+nMBYWVwbLoeMpe+PYw27KPKaKAH+hNFRaNTtYrBJ6yRHw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: ti: icssg-prueth: Fix firmware load sequence.
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, jan.kiszka@siemens.com, Roger Quadros <rogerq@kernel.org>, 
	javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com, 
	jacob.e.keller@intel.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b8f52006288245b0"

--000000000000b8f52006288245b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:59=E2=80=AFPM Meghana Malladi <m-malladi@ti.com> w=
rote:
>
> From: MD Danish Anwar <danishanwar@ti.com>
>
> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
> and SLICE1. Currently whenever any ICSSG interface comes up we load the
> respective firmwares to PRU cores and whenever interface goes down, we
> stop the resective cores. Due to this, when SLICE0 goes down while
> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
> stopped. This results in clock jump for SLICE1 interface as the timesync
> related operations are no longer running.
>
> As there are interdependencies between SLICE0 and SLICE1 firmwares,
> fix this by running both PRU0 and PRU1 firmwares as long as at least 1
> ICSSG interface is up. Add new flag in prueth struct to check if all
> firmwares are running.
>
> Use emacs_initialized as reference count to load the firmwares for the
> first and last interface up/down. Moving init_emac_mode and fw_offload_mo=
de
> API outside of icssg_config to icssg_common_start API as they need
> to be called only once per firmware boot.
>
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>
> Hi all,
>
> This patch is based on net-next tagged next-20241128.
> v2:https://lore.kernel.org/all/20241128122931.2494446-2-m-malladi@ti.com/
>
> * Changes since v2 (v3-v2):
> - error handling in caller function of prueth_emac_common_start()
> - Use prus_running flag check before stopping the firmwares
> Both suggested by Roger Quadros <rogerq@kernel.org>
>
>  drivers/net/ethernet/ti/icssg/icssg_config.c |  45 ++++--
>  drivers/net/ethernet/ti/icssg/icssg_config.h |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 157 ++++++++++++-------
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   5 +
>  4 files changed, 140 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/e=
thernet/ti/icssg/icssg_config.c
> index 5d2491c2943a..342150756cf7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -397,7 +397,7 @@ static int prueth_emac_buffer_setup(struct prueth_ema=
c *emac)
>         return 0;
>  }
>
> -static void icssg_init_emac_mode(struct prueth *prueth)
> +void icssg_init_emac_mode(struct prueth *prueth)
>  {
>         /* When the device is configured as a bridge and it is being brou=
ght
>          * back to the emac mode, the host mac address has to be set as 0=
.
> @@ -406,9 +406,6 @@ static void icssg_init_emac_mode(struct prueth *pruet=
h)
>         int i;
>         u8 mac[ETH_ALEN] =3D { 0 };
>
> -       if (prueth->emacs_initialized)
> -               return;
> -
>         /* Set VLAN TABLE address base */
>         regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSE=
T_MASK,
>                            addr <<  SMEM_VLAN_OFFSET);
> @@ -423,15 +420,13 @@ static void icssg_init_emac_mode(struct prueth *pru=
eth)
>         /* Clear host MAC address */
>         icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>  }
> +EXPORT_SYMBOL_GPL(icssg_init_emac_mode);
>
> -static void icssg_init_fw_offload_mode(struct prueth *prueth)
> +void icssg_init_fw_offload_mode(struct prueth *prueth)
>  {
>         u32 addr =3D prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TA=
BLE_OFFSET;
>         int i;
>
> -       if (prueth->emacs_initialized)
> -               return;
> -
>         /* Set VLAN TABLE address base */
>         regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSE=
T_MASK,
>                            addr <<  SMEM_VLAN_OFFSET);
> @@ -448,6 +443,7 @@ static void icssg_init_fw_offload_mode(struct prueth =
*prueth)
>                 icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw=
_bridge_dev->dev_addr);
>         icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
>  }
> +EXPORT_SYMBOL_GPL(icssg_init_fw_offload_mode);
>
>  int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int sl=
ice)
>  {
> @@ -455,11 +451,6 @@ int icssg_config(struct prueth *prueth, struct pruet=
h_emac *emac, int slice)
>         struct icssg_flow_cfg __iomem *flow_cfg;
>         int ret;
>
> -       if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> -               icssg_init_fw_offload_mode(prueth);
> -       else
> -               icssg_init_emac_mode(prueth);
> -
>         memset_io(config, 0, TAS_GATE_MASK_LIST0);
>         icssg_miig_queues_init(prueth, slice);
>
> @@ -786,3 +777,31 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u=
8 port)
>                 writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_D=
EFAULT_VLAN_OFFSET);
>  }
>  EXPORT_SYMBOL_GPL(icssg_set_pvid);
> +
> +int emac_fdb_flow_id_updated(struct prueth_emac *emac)
> +{
> +       struct mgmt_cmd_rsp fdb_cmd_rsp =3D { 0 };
> +       int slice =3D prueth_emac_slice(emac);
> +       struct mgmt_cmd fdb_cmd =3D { 0 };
> +       int ret =3D 0;
[Kalesh] There is no need to initialize "ret" here
> +
> +       fdb_cmd.header =3D ICSSG_FW_MGMT_CMD_HEADER;
> +       fdb_cmd.type   =3D ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
> +       fdb_cmd.seqnum =3D ++(emac->prueth->icssg_hwcmdseq);
> +       fdb_cmd.param  =3D 0;
> +
> +       fdb_cmd.param |=3D (slice << 4);
> +       fdb_cmd.cmd_args[0] =3D 0;
> +
> +       ret =3D icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
> +
[Kalesh] There is no need of an new line here
> +       if (ret)
> +               return ret;
> +
> +       WARN_ON(fdb_cmd.seqnum !=3D fdb_cmd_rsp.seqnum);
> +       if (fdb_cmd_rsp.status =3D=3D 1)
> +               return 0;
> +
> +       return -EINVAL;
[Kalesh] Maybe you can simplify this as:
return fdb_cmd_rsp.status =3D=3D 1 ? 0 : -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(emac_fdb_flow_id_updated);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/e=
thernet/ti/icssg/icssg_config.h
> index 92c2deaa3068..c884e9fa099e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -55,6 +55,7 @@ struct icssg_rxq_ctx {
>  #define ICSSG_FW_MGMT_FDB_CMD_TYPE     0x03
>  #define ICSSG_FW_MGMT_CMD_TYPE         0x04
>  #define ICSSG_FW_MGMT_PKT              0x80000000
> +#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW     0x05
>
>  struct icssg_r30_cmd {
>         u32 cmd[4];
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index c568c84a032b..2e22e793b01a 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -164,11 +164,11 @@ static struct icssg_firmwares icssg_emac_firmwares[=
] =3D {
>         }
>  };
>
> -static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *=
emac)
> +static int prueth_emac_start(struct prueth *prueth, int slice)
>  {
>         struct icssg_firmwares *firmwares;
>         struct device *dev =3D prueth->dev;
> -       int slice, ret;
> +       int ret;
>
>         if (prueth->is_switch_mode)
>                 firmwares =3D icssg_switch_firmwares;
> @@ -177,16 +177,6 @@ static int prueth_emac_start(struct prueth *prueth, =
struct prueth_emac *emac)
>         else
>                 firmwares =3D icssg_emac_firmwares;
>
> -       slice =3D prueth_emac_slice(emac);
> -       if (slice < 0) {
> -               netdev_err(emac->ndev, "invalid port\n");
> -               return -EINVAL;
> -       }
> -
> -       ret =3D icssg_config(prueth, emac, slice);
> -       if (ret)
> -               return ret;
> -
>         ret =3D rproc_set_firmware(prueth->pru[slice], firmwares[slice].p=
ru);
>         ret =3D rproc_boot(prueth->pru[slice]);
>         if (ret) {
> @@ -208,7 +198,6 @@ static int prueth_emac_start(struct prueth *prueth, s=
truct prueth_emac *emac)
>                 goto halt_rtu;
>         }
>
> -       emac->fw_running =3D 1;
>         return 0;
>
>  halt_rtu:
> @@ -220,6 +209,80 @@ static int prueth_emac_start(struct prueth *prueth, =
struct prueth_emac *emac)
>         return ret;
>  }
>
> +static int prueth_emac_common_start(struct prueth *prueth)
> +{
> +       struct prueth_emac *emac;
> +       int ret =3D 0;
> +       int slice;
> +
> +       if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
> +               return -EINVAL;
> +
> +       /* clear SMEM and MSMC settings for all slices */
> +       memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
> +       memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUET=
H_NUM_MACS);
> +
> +       icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
> +       icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
> +
> +       if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +               icssg_init_fw_offload_mode(prueth);
> +       else
> +               icssg_init_emac_mode(prueth);
> +
> +       for (slice =3D 0; slice < PRUETH_NUM_MACS; slice++) {
> +               emac =3D prueth->emac[slice];
> +               if (emac) {
> +                       ret |=3D icssg_config(prueth, emac, slice);
> +                       if (ret)
> +                               return ret;
> +               }
> +               ret |=3D prueth_emac_start(prueth, slice);
> +       }
> +       if (!ret)
> +               prueth->prus_running =3D 1;
> +       else
> +               return ret;
[Kalesh] This will read better if you change the condition check like:
if (ret)
    return ret;
prueth->prus_running =3D 1;
> +
> +       emac =3D prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
> +              prueth->emac[ICSS_SLICE1];
> +       ret =3D icss_iep_init(emac->iep, &prueth_iep_clockops,
> +                           emac, IEP_DEFAULT_CYCLE_TIME_NS);
> +       if (ret) {
> +               dev_err(prueth->dev, "Failed to initialize IEP module\n")=
;
> +               return ret;
> +       }
> +
> +       return 0;
[Kalesh] You can "return ret" here and remove the return from above if
condition.
> +}
> +
> +static int prueth_emac_common_stop(struct prueth *prueth)
> +{
> +       struct prueth_emac *emac;
> +       int slice;
> +
> +       if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
> +               return -EINVAL;
> +
> +       icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
> +       icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
> +
> +       for (slice =3D 0; slice < PRUETH_NUM_MACS; slice++) {
> +               if (prueth->prus_running) {
> +                       rproc_shutdown(prueth->txpru[slice]);
> +                       rproc_shutdown(prueth->rtu[slice]);
> +                       rproc_shutdown(prueth->pru[slice]);
> +               }
> +       }
> +       prueth->prus_running =3D 0;
> +
> +       emac =3D prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
> +              prueth->emac[ICSS_SLICE1];
> +       icss_iep_exit(emac->iep);
> +
> +       return 0;
> +}
> +
>  /* called back by PHY layer if there is change in link state of hw port*=
/
>  static void emac_adjust_link(struct net_device *ndev)
>  {
> @@ -369,12 +432,13 @@ static void prueth_iep_settime(void *clockops_data,=
 u64 ns)
>  {
>         struct icssg_setclock_desc __iomem *sc_descp;
>         struct prueth_emac *emac =3D clockops_data;
> +       struct prueth *prueth =3D emac->prueth;
>         struct icssg_setclock_desc sc_desc;
>         u64 cyclecount;
>         u32 cycletime;
>         int timeout;
>
> -       if (!emac->fw_running)
> +       if (!prueth->prus_running)
>                 return;
>
>         sc_descp =3D emac->prueth->shram.va + TIMESYNC_FW_WC_SETCLOCK_DES=
C_OFFSET;
> @@ -543,23 +607,17 @@ static int emac_ndo_open(struct net_device *ndev)
>  {
>         struct prueth_emac *emac =3D netdev_priv(ndev);
>         int ret, i, num_data_chn =3D emac->tx_ch_num;
> +       struct icssg_flow_cfg __iomem *flow_cfg;
>         struct prueth *prueth =3D emac->prueth;
>         int slice =3D prueth_emac_slice(emac);
>         struct device *dev =3D prueth->dev;
>         int max_rx_flows;
>         int rx_flow;
>
> -       /* clear SMEM and MSMC settings for all slices */
> -       if (!prueth->emacs_initialized) {
> -               memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
> -               memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1=
 * PRUETH_NUM_MACS);
> -       }
> -
>         /* set h/w MAC as user might have re-configured */
>         ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>
>         icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
> -       icssg_class_default(prueth->miig_rt, slice, 0, false);
>         icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>
>         /* Notify the stack of the actual queue counts. */
> @@ -597,18 +655,23 @@ static int emac_ndo_open(struct net_device *ndev)
>                 goto cleanup_napi;
>         }
>
> -       /* reset and start PRU firmware */
> -       ret =3D prueth_emac_start(prueth, emac);
> -       if (ret)
> -               goto free_rx_irq;
> +       if (!prueth->emacs_initialized) {
> +               ret =3D prueth_emac_common_start(prueth);
> +               if (ret)
> +                       goto stop;
> +       }
>
> -       icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> +       flow_cfg =3D emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_=
FLOW_ID_BASE_OFFSET;
> +       writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
> +       ret =3D emac_fdb_flow_id_updated(emac);
>
> -       if (!prueth->emacs_initialized) {
> -               ret =3D icss_iep_init(emac->iep, &prueth_iep_clockops,
> -                                   emac, IEP_DEFAULT_CYCLE_TIME_NS);
> +       if (ret) {
> +               netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
> +               goto stop;
>         }
>
> +       icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> +
>         ret =3D request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_=
irq,
>                                    IRQF_ONESHOT, dev_name(dev), emac);
>         if (ret)
> @@ -653,8 +716,7 @@ static int emac_ndo_open(struct net_device *ndev)
>  free_tx_ts_irq:
>         free_irq(emac->tx_ts_irq, emac);
>  stop:
> -       prueth_emac_stop(emac);
> -free_rx_irq:
> +       prueth_emac_common_stop(prueth);
>         free_irq(emac->rx_chns.irq[rx_flow], emac);
>  cleanup_napi:
>         prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
> @@ -689,8 +751,6 @@ static int emac_ndo_stop(struct net_device *ndev)
>         if (ndev->phydev)
>                 phy_stop(ndev->phydev);
>
> -       icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
> -
>         if (emac->prueth->is_hsr_offload_mode)
>                 __dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
>         else
> @@ -728,11 +788,9 @@ static int emac_ndo_stop(struct net_device *ndev)
>         /* Destroying the queued work in ndo_stop() */
>         cancel_delayed_work_sync(&emac->stats_work);
>
> -       if (prueth->emacs_initialized =3D=3D 1)
> -               icss_iep_exit(emac->iep);
> -
>         /* stop PRUs */
> -       prueth_emac_stop(emac);
> +       if (prueth->emacs_initialized =3D=3D 1)
> +               prueth_emac_common_stop(prueth);
>
>         free_irq(emac->tx_ts_irq, emac);
>
> @@ -1069,16 +1127,10 @@ static void prueth_emac_restart(struct prueth *pr=
ueth)
>         icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
>
>         /* Stop both pru cores for both PRUeth ports*/
> -       prueth_emac_stop(emac0);
> -       prueth->emacs_initialized--;
> -       prueth_emac_stop(emac1);
> -       prueth->emacs_initialized--;
> +       prueth_emac_common_stop(prueth);
>
>         /* Start both pru cores for both PRUeth ports */
> -       prueth_emac_start(prueth, emac0);
> -       prueth->emacs_initialized++;
> -       prueth_emac_start(prueth, emac1);
> -       prueth->emacs_initialized++;
> +       prueth_emac_common_start(prueth);
>
>         /* Enable forwarding for both PRUeth ports */
>         icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
> @@ -1413,13 +1465,10 @@ static int prueth_probe(struct platform_device *p=
dev)
>                 prueth->pa_stats =3D NULL;
>         }
>
> -       if (eth0_node) {
> +       if (eth0_node || eth1_node) {
>                 ret =3D prueth_get_cores(prueth, ICSS_SLICE0, false);
>                 if (ret)
>                         goto put_cores;
> -       }
> -
> -       if (eth1_node) {
>                 ret =3D prueth_get_cores(prueth, ICSS_SLICE1, false);
>                 if (ret)
>                         goto put_cores;
> @@ -1618,14 +1667,12 @@ static int prueth_probe(struct platform_device *p=
dev)
>         pruss_put(prueth->pruss);
>
>  put_cores:
> -       if (eth1_node) {
> -               prueth_put_cores(prueth, ICSS_SLICE1);
> -               of_node_put(eth1_node);
> -       }
> -
> -       if (eth0_node) {
> +       if (eth0_node || eth1_node) {
>                 prueth_put_cores(prueth, ICSS_SLICE0);
>                 of_node_put(eth0_node);
> +
> +               prueth_put_cores(prueth, ICSS_SLICE1);
> +               of_node_put(eth1_node);
>         }
>
>         return ret;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.h
> index f5c1d473e9f9..b30f2e9a73d8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -257,6 +257,7 @@ struct icssg_firmwares {
>   * @is_switchmode_supported: indicates platform support for switch mode
>   * @switch_id: ID for mapping switch ports to bridge
>   * @default_vlan: Default VLAN for host
> + * @prus_running: flag to indicate if all pru cores are running
>   */
>  struct prueth {
>         struct device *dev;
> @@ -298,6 +299,7 @@ struct prueth {
>         int default_vlan;
>         /** @vtbl_lock: Lock for vtbl in shared memory */
>         spinlock_t vtbl_lock;
> +       bool prus_running;
>  };
>
>  struct emac_tx_ts_response {
> @@ -361,6 +363,8 @@ int icssg_set_port_state(struct prueth_emac *emac,
>                          enum icssg_port_state_cmd state);
>  void icssg_config_set_speed(struct prueth_emac *emac);
>  void icssg_config_half_duplex(struct prueth_emac *emac);
> +void icssg_init_emac_mode(struct prueth *prueth);
> +void icssg_init_fw_offload_mode(struct prueth *prueth);
>
>  /* Buffer queue helpers */
>  int icssg_queue_pop(struct prueth *prueth, u8 queue);
> @@ -377,6 +381,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 v=
id, u8 port_mask,
>                        u8 untag_mask, bool add);
>  u16 icssg_get_pvid(struct prueth_emac *emac);
>  void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
> +int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>  #define prueth_napi_to_tx_chn(pnapi) \
>         container_of(pnapi, struct prueth_tx_chn, napi_tx)
>
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000b8f52006288245b0
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
AQkEMSIEIP6GzIjaL3jVoc9jJyj/l76LeFi09OTSyV3TKFXsKj+fMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIwNTA5MTA0MFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAi4w5fhhbA
qumkYvRk2giPQu3L+PpRSV8Og9DbhkkfSln2COWDdumL9yWnb7iGizndFbAy1q1pmspDYkwfS+OA
SGxz8ehIhu1BYf19E6cVlRAxUa3By2j0qQc0ZaLmhS85PxBGzLgDVhxFgmvf/M7iGCmVJ9D8l95c
bBMYe3kJ1xAXFslz3sbghlSoZ1RSxkFUAjJOY+kppeK7w+Wm/oozEbGPAPb2+NqNQW8fpBLhsHC5
pClqcXsBfaFcXCy4YbZw3WaTeeTRmvuCKzctrue6ydeYHMUqdDe6LCv4MEgfzjQwy2rPTSVsBajN
A6/A5j0QA/tfi4BIFHN2itFDlAkP
--000000000000b8f52006288245b0--

