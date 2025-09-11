Return-Path: <netdev+bounces-222207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C53B53894
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08861884A04
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2A34DCFD;
	Thu, 11 Sep 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4l27n6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32B1990D9
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606540; cv=none; b=UwT5e5zVL7G46C8VKcI2c6W3+IAjL77JAtqbscZUfd+REZmhL2V4Gg1Qp7wACyIZFrY9y48oVDEcTZ4wi7WZVQ3iaddZwDXe3vJjqyJpuK64KEPpnoO66MJciIrUoTrDtFvHrzHLSnc+geKVkoceNw1GM0XNzMRFQVEBISZ/nKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606540; c=relaxed/simple;
	bh=1xqpj+FdsyxHJS6BYJpGv3Ws0mr/vScYfDW9MCKg8qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWx6xFAN6QFauofG9BngvoHB7PvmRVjBQfYyrMMxolZVEVtBwHoUaU5xc7kPb2zPzRsBZwGAFiX4Jc0hgfz5EvJ+zz3AwrxryptWPQW9bVg5pXAmigpPDfx+M+FqhWybNlpNwA7z4sACe84I+QhDXix6uTesGNKDv0uiVcIHo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4l27n6w; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso8004e87.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757606536; x=1758211336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMqB4mz4Euh7GFhJjEw2J/VENmZNZDippTR7BssmvZQ=;
        b=L4l27n6wa0LuPwveUaRWDiWoi6YyyN0PnHYnFnFceuRjj3GtkYMOt/mY7GSbJ/k+UX
         u5/Hfc7eIa68rT9Xxaf3K6BzkPs898p2HqdaRgabkqGg8TlOQEDgZou9U5ffqSTkUacs
         wtsj6+DBcVErfj+VkkUBG8zsgowhpfVy7ngYqE0K2XnAKNeJB+mTJvF9Uz7waaW7Pk/t
         RS30ntIhzXYImfJB8iUrJM49UEJ4/Fr8ZxUX3kqRCloIAJgxRkSfCdW8W9I8UkD3280V
         kGRNL5HKhPp1TNMpAPNn2MT9O3WGY2PkOTKOzseKhz0LSi16ArIl2bcMEJ19xkiLYAjC
         UbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606536; x=1758211336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMqB4mz4Euh7GFhJjEw2J/VENmZNZDippTR7BssmvZQ=;
        b=GrZCaUcKSdo6iXdtGE28gVRE5lpUnbYd0J48TcQul0tV/ZHGYKo/pZvHUXNYg05mxb
         cTb1U16buJTIU+4yUa5mZ/DBAqfFcIrI2qFZD6f9kokf+KBevp+3PjjMhM/5XdqwSCRw
         Vhgs5urDYjG19kWFSrzIdkF/4dD6WrZraK8+EK7XsIirErJDPsfPITq9SUsjWAdY2Cve
         L5CDEOuOS9xsOzB5m76kakCVTu3KPzjBcnin5nRylT+RPeIoQsKwD66mkykMqX/Tf+m+
         QdyiKKNP5ArFkNR9G+sYEm6AX/26wlQXkDWF+wv+qTdHEnbCeWga2jq87dOQ93RMMj/l
         jaJA==
X-Forwarded-Encrypted: i=1; AJvYcCVbB+AEF/flrF5r9gx4BCaBjlrYypmaMAD0Lu00iEROZ2GCgiTEW066BJO0pJHJFNr7ZYKr53Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFdaeYFeEF3ebJ0I6JYFrproE7hIOp+EVG9eawIdm8F40Cbkr
	8n9b2x5kUAD0zLbkvqtAwOQolT5gCmMUhoCuJ1p5yrpm3azrtmoJGCJ7IAl8cLmrDTSoU39X+2e
	D47SmF4GpZ6KAT5LbOs5+K+NXzOloNl7FODdvATJk+337g5+H5oA3TzVQIFk=
X-Gm-Gg: ASbGncu5vQuYKPFdfv1VTl+YDmgFovvUqdBeNbb530SbcspHjAOzpIqy4nTj9DQH0Ca
	Phx5LR2k8tXrzhNRWAgMvD9/Yv2OHypY8wffqOrxeR4ujj49g9m3JJ4d27MTmUKFHhUAcJL45Xw
	vThFJ0xMFNYZYSi1oQft9GrJhtUuckhu5u72P0YuA/wQEYzyg9P6a04M6PCCUpl1J0wKo3ospL2
	s0X+CiFOHxiDpmck699x4AtsvN//dR0OPppwrl9S7wbDtuT6QtDv/E=
X-Google-Smtp-Source: AGHT+IF/5OpRLIv2JlGhtXm0B6Xkw8h4dsVnoLbbYTL/tED084o3PoOeFvAfTMTmTCh2k8jdXH1xWhs9x2Nl83gCu7A=
X-Received: by 2002:a05:6512:1407:b0:55f:6c1e:4191 with SMTP id
 2adb3069b0e04-56af1d86c54mr745926e87.4.1757606534942; Thu, 11 Sep 2025
 09:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105321.5750-1-anton.nadezhdin@intel.com> <20250902105321.5750-2-anton.nadezhdin@intel.com>
In-Reply-To: <20250902105321.5750-2-anton.nadezhdin@intel.com>
From: Naman Gulati <namangulati@google.com>
Date: Thu, 11 Sep 2025 09:02:03 -0700
X-Gm-Features: AS18NWCB_FbdGqlYPfE8yzRjV0t1DYDiURP9Qy93aY2gOYksgbZGzVjPtheC1qM
Message-ID: <CAMP57yVGEJaOwmgQd2f2XJKBXLLN_dWk2HkqAgDz8c1fGpUQOQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next 1/2] idpf: add direct access to discipline the
 main timer
To: Anton Nadezhdin <anton.nadezhdin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, richardcochran@gmail.com, 
	Milena Olech <milena.olech@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ran all of the PHC set/adj/adjfine operations. Not able to validate
the hardware correctness, but exercised the full datapaths.

Tested-by: Naman Gulati <namangulati@google.com>

On Tue, Sep 2, 2025 at 2:03=E2=80=AFAM Anton Nadezhdin
<anton.nadezhdin@intel.com> wrote:
>
> From: Milena Olech <milena.olech@intel.com>
>
> IDPF allows to access the clock through virtchnl messages, or directly,
> through PCI BAR registers. Registers offsets are negotiated with the
> Control Plane during driver initialization process.
> Add support for direct operations to modify the clock.
>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 192 ++++++++++++++----
>  drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  60 +++---
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  31 +--
>  4 files changed, 207 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/eth=
ernet/intel/idpf/idpf_dev.c
> index a4625638cf3f..344975352fad 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> @@ -171,8 +171,8 @@ static void idpf_trigger_reset(struct idpf_adapter *a=
dapter,
>   */
>  static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
>  {
> -       adapter->ptp->cmd.shtime_enable_mask =3D PF_GLTSYN_CMD_SYNC_SHTIM=
E_EN_M;
> -       adapter->ptp->cmd.exec_cmd_mask =3D PF_GLTSYN_CMD_SYNC_EXEC_CMD_M=
;
> +       adapter->ptp->cmd.shtime_enable =3D PF_GLTSYN_CMD_SYNC_SHTIME_EN_=
M;
> +       adapter->ptp->cmd.exec_cmd =3D PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.c
> index 990e78686786..b19dbddf95bf 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -80,14 +80,30 @@ static void idpf_ptp_enable_shtime(struct idpf_adapte=
r *adapter)
>         u32 shtime_enable, exec_cmd;
>
>         /* Get offsets */
> -       shtime_enable =3D adapter->ptp->cmd.shtime_enable_mask;
> -       exec_cmd =3D adapter->ptp->cmd.exec_cmd_mask;
> +       shtime_enable =3D adapter->ptp->cmd.shtime_enable;
> +       exec_cmd =3D adapter->ptp->cmd.exec_cmd;
>
>         /* Set the shtime en and the sync field */
>         writel(shtime_enable, adapter->ptp->dev_clk_regs.cmd_sync);
>         writel(exec_cmd | shtime_enable, adapter->ptp->dev_clk_regs.cmd_s=
ync);
>  }
>
> +/**
> + * idpf_ptp_tmr_cmd - Prepare and trigger a timer sync command
> + * @adapter: Driver specific private structure
> + * @cmd: Command to be executed
> + */
> +static void idpf_ptp_tmr_cmd(struct idpf_adapter *adapter, u32 cmd)
> +{
> +       struct idpf_ptp *ptp =3D adapter->ptp;
> +       u32 exec_cmd =3D ptp->cmd.exec_cmd;
> +
> +       writel(cmd, ptp->dev_clk_regs.cmd);
> +       writel(cmd, ptp->dev_clk_regs.phy_cmd);
> +       writel(exec_cmd, ptp->dev_clk_regs.cmd_sync);
> +       writel(0, ptp->dev_clk_regs.cmd);
> +}
> +
>  /**
>   * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
>   * @adapter: Driver specific private structure
> @@ -139,7 +155,7 @@ static int idpf_ptp_read_src_clk_reg_mailbox(struct i=
dpf_adapter *adapter,
>         /* Read the system timestamp pre PHC read */
>         ptp_read_system_prets(sts);
>
> -       err =3D idpf_ptp_get_dev_clk_time(adapter, &clk_time);
> +       err =3D idpf_ptp_get_dev_clk_time_mb(adapter, &clk_time);
>         if (err)
>                 return err;
>
> @@ -223,7 +239,7 @@ static int idpf_ptp_get_sync_device_time_mailbox(stru=
ct idpf_adapter *adapter,
>         struct idpf_ptp_dev_timers cross_time;
>         int err;
>
> -       err =3D idpf_ptp_get_cross_time(adapter, &cross_time);
> +       err =3D idpf_ptp_get_cross_time_mb(adapter, &cross_time);
>         if (err)
>                 return err;
>
> @@ -403,6 +419,33 @@ static int idpf_ptp_update_cached_phctime(struct idp=
f_adapter *adapter)
>         return 0;
>  }
>
> +/**
> + * idpf_ptp_set_dev_clk_time_direct- Set the time of the clock directly =
through
> + *                                  BAR registers.
> + * @adapter: Driver specific private structure
> + * @dev_clk_time: Value expressed in nanoseconds to set
> + *
> + * Set the time of the device clock to provided value directly through B=
AR
> + * registers received during PTP capabilities negotiation.
> + */
> +static void idpf_ptp_set_dev_clk_time_direct(struct idpf_adapter *adapte=
r,
> +                                            u64 dev_clk_time)
> +{
> +       struct idpf_ptp *ptp =3D adapter->ptp;
> +       u32 dev_clk_time_l, dev_clk_time_h;
> +
> +       dev_clk_time_l =3D lower_32_bits(dev_clk_time);
> +       dev_clk_time_h =3D upper_32_bits(dev_clk_time);
> +
> +       writel(dev_clk_time_l, ptp->dev_clk_regs.dev_clk_ns_l);
> +       writel(dev_clk_time_h, ptp->dev_clk_regs.dev_clk_ns_h);
> +
> +       writel(dev_clk_time_l, ptp->dev_clk_regs.phy_clk_ns_l);
> +       writel(dev_clk_time_h, ptp->dev_clk_regs.phy_clk_ns_h);
> +
> +       idpf_ptp_tmr_cmd(adapter, ptp->cmd.init_time);
> +}
> +
>  /**
>   * idpf_ptp_settime64 - Set the time of the clock
>   * @info: the driver's PTP info structure
> @@ -422,16 +465,20 @@ static int idpf_ptp_settime64(struct ptp_clock_info=
 *info,
>         u64 ns;
>
>         access =3D adapter->ptp->set_dev_clk_time_access;
> -       if (access !=3D IDPF_PTP_MAILBOX)
> +       if (access =3D=3D IDPF_PTP_NONE)
>                 return -EOPNOTSUPP;
>
>         ns =3D timespec64_to_ns(ts);
>
> -       err =3D idpf_ptp_set_dev_clk_time(adapter, ns);
> -       if (err) {
> -               pci_err(adapter->pdev, "Failed to set the time, err: %pe\=
n",
> -                       ERR_PTR(err));
> -               return err;
> +       if (access =3D=3D IDPF_PTP_MAILBOX) {
> +               err =3D idpf_ptp_set_dev_clk_time_mb(adapter, ns);
> +               if (err) {
> +                       pci_err(adapter->pdev,
> +                               "Failed to set the time: %pe\n", ERR_PTR(=
err));
> +                       return err;
> +               }
> +       } else {
> +               idpf_ptp_set_dev_clk_time_direct(adapter, ns);
>         }
>
>         err =3D idpf_ptp_update_cached_phctime(adapter);
> @@ -464,6 +511,30 @@ static int idpf_ptp_adjtime_nonatomic(struct ptp_clo=
ck_info *info, s64 delta)
>         return idpf_ptp_settime64(info, &now);
>  }
>
> +/**
> + * idpf_ptp_adj_dev_clk_time_direct - Adjust the time of the clock direc=
tly
> + *                                   through BAR registers.
> + * @adapter: Driver specific private structure
> + * @delta: Offset in nanoseconds to adjust the time by
> + *
> + * Adjust the time of the clock directly through BAR registers received =
during
> + * PTP capabilities negotiation.
> + */
> +static void idpf_ptp_adj_dev_clk_time_direct(struct idpf_adapter *adapte=
r,
> +                                            s64 delta)
> +{
> +       struct idpf_ptp *ptp =3D adapter->ptp;
> +       u32 delta_l =3D (s32)delta;
> +
> +       writel(0, ptp->dev_clk_regs.shadj_l);
> +       writel(delta_l, ptp->dev_clk_regs.shadj_h);
> +
> +       writel(0, ptp->dev_clk_regs.phy_shadj_l);
> +       writel(delta_l, ptp->dev_clk_regs.phy_shadj_h);
> +
> +       idpf_ptp_tmr_cmd(adapter, ptp->cmd.adj_time);
> +}
> +
>  /**
>   * idpf_ptp_adjtime - Adjust the time of the clock by the indicated delt=
a
>   * @info: the driver's PTP info structure
> @@ -478,7 +549,7 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *in=
fo, s64 delta)
>         int err;
>
>         access =3D adapter->ptp->adj_dev_clk_time_access;
> -       if (access !=3D IDPF_PTP_MAILBOX)
> +       if (access =3D=3D IDPF_PTP_NONE)
>                 return -EOPNOTSUPP;
>
>         /* Hardware only supports atomic adjustments using signed 32-bit
> @@ -488,11 +559,16 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *=
info, s64 delta)
>         if (delta > S32_MAX || delta < S32_MIN)
>                 return idpf_ptp_adjtime_nonatomic(info, delta);
>
> -       err =3D idpf_ptp_adj_dev_clk_time(adapter, delta);
> -       if (err) {
> -               pci_err(adapter->pdev, "Failed to adjust the clock with d=
elta %lld err: %pe\n",
> -                       delta, ERR_PTR(err));
> -               return err;
> +       if (access =3D=3D IDPF_PTP_MAILBOX) {
> +               err =3D idpf_ptp_adj_dev_clk_time_mb(adapter, delta);
> +               if (err) {
> +                       pci_err(adapter->pdev,
> +                               "Failed to adjust the clock with delta %l=
ld err: %pe\n",
> +                               delta, ERR_PTR(err));
> +                       return err;
> +               }
> +       } else {
> +               idpf_ptp_adj_dev_clk_time_direct(adapter, delta);
>         }
>
>         err =3D idpf_ptp_update_cached_phctime(adapter);
> @@ -503,6 +579,33 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *i=
nfo, s64 delta)
>         return 0;
>  }
>
> +/**
> + * idpf_ptp_adj_dev_clk_fine_direct - Adjust clock increment rate direct=
ly
> + *                                   through BAR registers.
> + * @adapter: Driver specific private structure
> + * @incval: Source timer increment value per clock cycle
> + *
> + * Adjust clock increment rate directly through BAR registers received d=
uring
> + * PTP capabilities negotiation.
> + */
> +static void idpf_ptp_adj_dev_clk_fine_direct(struct idpf_adapter *adapte=
r,
> +                                            u64 incval)
> +{
> +       struct idpf_ptp *ptp =3D adapter->ptp;
> +       u32 incval_l, incval_h;
> +
> +       incval_l =3D lower_32_bits(incval);
> +       incval_h =3D upper_32_bits(incval);
> +
> +       writel(incval_l, ptp->dev_clk_regs.shadj_l);
> +       writel(incval_h, ptp->dev_clk_regs.shadj_h);
> +
> +       writel(incval_l, ptp->dev_clk_regs.phy_shadj_l);
> +       writel(incval_h, ptp->dev_clk_regs.phy_shadj_h);
> +
> +       idpf_ptp_tmr_cmd(adapter, ptp->cmd.init_incval);
> +}
> +
>  /**
>   * idpf_ptp_adjfine - Adjust clock increment rate
>   * @info: the driver's PTP info structure
> @@ -521,16 +624,22 @@ static int idpf_ptp_adjfine(struct ptp_clock_info *=
info, long scaled_ppm)
>         int err;
>
>         access =3D adapter->ptp->adj_dev_clk_time_access;
> -       if (access !=3D IDPF_PTP_MAILBOX)
> +       if (access =3D=3D IDPF_PTP_NONE)
>                 return -EOPNOTSUPP;
>
>         incval =3D adapter->ptp->base_incval;
> -
>         diff =3D adjust_by_scaled_ppm(incval, scaled_ppm);
> -       err =3D idpf_ptp_adj_dev_clk_fine(adapter, diff);
> -       if (err)
> -               pci_err(adapter->pdev, "Failed to adjust clock increment =
rate for scaled ppm %ld %pe\n",
> -                       scaled_ppm, ERR_PTR(err));
> +
> +       if (access =3D=3D IDPF_PTP_MAILBOX) {
> +               err =3D idpf_ptp_adj_dev_clk_fine_mb(adapter, diff);
> +               if (err) {
> +                       pci_err(adapter->pdev,
> +                               "Failed to adjust clock increment rate\n"=
);
> +                       return err;
> +               }
> +       } else {
> +               idpf_ptp_adj_dev_clk_fine_direct(adapter, diff);
> +       }
>
>         return 0;
>  }
> @@ -757,7 +866,7 @@ void idpf_tstamp_task(struct work_struct *work)
>
>         vport =3D container_of(work, struct idpf_vport, tstamp_task);
>
> -       idpf_ptp_get_tx_tstamp(vport);
> +       idpf_ptp_get_tx_tstamp_mb(vport);
>  }
>
>  /**
> @@ -928,6 +1037,7 @@ bool idpf_ptp_get_txq_tstamp_capability(struct idpf_=
tx_queue *txq)
>   */
>  int idpf_ptp_init(struct idpf_adapter *adapter)
>  {
> +       struct idpf_ptp *ptp;
>         struct timespec64 ts;
>         int err;
>
> @@ -940,8 +1050,10 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
>         if (!adapter->ptp)
>                 return -ENOMEM;
>
> +       ptp =3D adapter->ptp;
> +
>         /* add a back pointer to adapter */
> -       adapter->ptp->adapter =3D adapter;
> +       ptp->adapter =3D adapter;
>
>         if (adapter->dev_ops.reg_ops.ptp_reg_init)
>                 adapter->dev_ops.reg_ops.ptp_reg_init(adapter);
> @@ -951,47 +1063,51 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
>                 pci_err(adapter->pdev, "Failed to get PTP caps err %d\n",=
 err);
>                 goto free_ptp;
>         }
> +       /* Do not initialize the PTP if the device clock time cannot be r=
ead. */
> +       if (ptp->get_dev_clk_time_access =3D=3D IDPF_PTP_NONE) {
> +               err =3D -EIO;
> +               goto free_ptp;
> +       }
>
>         err =3D idpf_ptp_create_clock(adapter);
>         if (err)
>                 goto free_ptp;
> -
> -       if (adapter->ptp->get_dev_clk_time_access !=3D IDPF_PTP_NONE)
> -               ptp_schedule_worker(adapter->ptp->clock, 0);
> +       ptp_schedule_worker(ptp->clock, 0);
>
>         /* Write the default increment time value if the clock adjustment=
s
>          * are enabled.
>          */
> -       if (adapter->ptp->adj_dev_clk_time_access !=3D IDPF_PTP_NONE) {
> -               err =3D idpf_ptp_adj_dev_clk_fine(adapter,
> -                                               adapter->ptp->base_incval=
);
> +       if (ptp->adj_dev_clk_time_access =3D=3D IDPF_PTP_MAILBOX) {
> +               err =3D idpf_ptp_adj_dev_clk_fine_mb(adapter, ptp->base_i=
ncval);
>                 if (err)
>                         goto remove_clock;
> +       } else if (ptp->adj_dev_clk_time_access =3D=3D IDPF_PTP_DIRECT) {
> +               idpf_ptp_adj_dev_clk_fine_direct(adapter, ptp->base_incva=
l);
>         }
>
>         /* Write the initial time value if the set time operation is enab=
led */
> -       if (adapter->ptp->set_dev_clk_time_access !=3D IDPF_PTP_NONE) {
> +       if (ptp->set_dev_clk_time_access !=3D IDPF_PTP_NONE) {
>                 ts =3D ktime_to_timespec64(ktime_get_real());
> -               err =3D idpf_ptp_settime64(&adapter->ptp->info, &ts);
> +               err =3D idpf_ptp_settime64(&ptp->info, &ts);
>                 if (err)
>                         goto remove_clock;
>         }
>
> -       spin_lock_init(&adapter->ptp->read_dev_clk_lock);
> +       spin_lock_init(&ptp->read_dev_clk_lock);
>
>         pci_dbg(adapter->pdev, "PTP init successful\n");
>
>         return 0;
>
>  remove_clock:
> -       if (adapter->ptp->get_dev_clk_time_access !=3D IDPF_PTP_NONE)
> -               ptp_cancel_worker_sync(adapter->ptp->clock);
> +       if (ptp->get_dev_clk_time_access !=3D IDPF_PTP_NONE)
> +               ptp_cancel_worker_sync(ptp->clock);
>
> -       ptp_clock_unregister(adapter->ptp->clock);
> -       adapter->ptp->clock =3D NULL;
> +       ptp_clock_unregister(ptp->clock);
> +       ptp->clock =3D NULL;
>
>  free_ptp:
> -       kfree(adapter->ptp);
> +       kfree(ptp);
>         adapter->ptp =3D NULL;
>
>         return err;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.h
> index 785da03e4cf5..26cc616f420c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> @@ -7,13 +7,21 @@
>  #include <linux/ptp_clock_kernel.h>
>
>  /**
> - * struct idpf_ptp_cmd - PTP command masks
> - * @exec_cmd_mask: mask to trigger command execution
> - * @shtime_enable_mask: mask to enable shadow time
> + * struct idpf_ptp_cmd_mask - PTP command masks
> + * @exec_cmd: mask to trigger command execution
> + * @shtime_enable: mask to enable shadow time
> + * @init_time: initialize the device clock timer
> + * @init_incval: initialize increment value
> + * @adj_time: adjust the device clock timer
> + * @read_time: read the device clock timer
>   */
> -struct idpf_ptp_cmd {
> -       u32 exec_cmd_mask;
> -       u32 shtime_enable_mask;
> +struct idpf_ptp_cmd_mask {
> +       u32 exec_cmd;
> +       u32 shtime_enable;
> +       u32 init_time;
> +       u32 init_incval;
> +       u32 adj_time;
> +       u32 read_time;
>  };
>
>  /* struct idpf_ptp_dev_clk_regs - PTP device registers
> @@ -183,7 +191,7 @@ struct idpf_ptp {
>         struct idpf_adapter *adapter;
>         u64 base_incval;
>         u64 max_adj;
> -       struct idpf_ptp_cmd cmd;
> +       struct idpf_ptp_cmd_mask cmd;
>         u64 cached_phc_time;
>         unsigned long cached_phc_jiffies;
>         struct idpf_ptp_dev_clk_regs dev_clk_regs;
> @@ -270,15 +278,15 @@ void idpf_ptp_release(struct idpf_adapter *adapter)=
;
>  int idpf_ptp_get_caps(struct idpf_adapter *adapter);
>  void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
>  bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq);
> -int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
> -                             struct idpf_ptp_dev_timers *dev_clk_time);
> -int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
> -                           struct idpf_ptp_dev_timers *cross_time);
> -int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
> -int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
> -int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
> +int idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
> +                              struct idpf_ptp_dev_timers *cross_time);
> +int idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
> +                                struct idpf_ptp_dev_timers *dev_clk_time=
);
> +int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adapter, u64 time)=
;
> +int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incva=
l);
> +int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter, s64 delta=
);
>  int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
> -int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
> +int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport);
>  int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
>                                 struct kernel_hwtstamp_config *config);
>  u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp);
> @@ -309,33 +317,33 @@ idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_q=
ueue *txq)
>  }
>
>  static inline int
> -idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
> -                         struct idpf_ptp_dev_timers *dev_clk_time)
> +idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
> +                            struct idpf_ptp_dev_timers *dev_clk_time)
>  {
>         return -EOPNOTSUPP;
>  }
>
>  static inline int
> -idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
> -                       struct idpf_ptp_dev_timers *cross_time)
> +idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
> +                          struct idpf_ptp_dev_timers *cross_time)
>  {
>         return -EOPNOTSUPP;
>  }
>
> -static inline int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter=
,
> -                                           u64 time)
> +static inline int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adap=
ter,
> +                                              u64 time)
>  {
>         return -EOPNOTSUPP;
>  }
>
> -static inline int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter=
,
> -                                           u64 incval)
> +static inline int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adap=
ter,
> +                                              u64 incval)
>  {
>         return -EOPNOTSUPP;
>  }
>
> -static inline int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter=
,
> -                                           s64 delta)
> +static inline int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adap=
ter,
> +                                              s64 delta)
>  {
>         return -EOPNOTSUPP;
>  }
> @@ -345,7 +353,7 @@ static inline int idpf_ptp_get_vport_tstamps_caps(str=
uct idpf_vport *vport)
>         return -EOPNOTSUPP;
>  }
>
> -static inline int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
> +static inline int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport)
>  {
>         return -EOPNOTSUPP;
>  }
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/driver=
s/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 61cedb6f2854..f85caba92b17 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> @@ -20,7 +20,10 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>                 .caps =3D cpu_to_le32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TI=
ME |
>                                     VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME=
_MB |
>                                     VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
> +                                   VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
> +                                   VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME=
 |
>                                     VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME=
_MB |
> +                                   VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
>                                     VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
>                                     VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB)
>         };
> @@ -144,7 +147,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>  }
>
>  /**
> - * idpf_ptp_get_dev_clk_time - Send virtchnl get device clk time message
> + * idpf_ptp_get_dev_clk_time_mb - Send virtchnl get device clk time mess=
age
>   * @adapter: Driver specific private structure
>   * @dev_clk_time: Pointer to the device clock structure where the value =
is set
>   *
> @@ -152,8 +155,8 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
> -                             struct idpf_ptp_dev_timers *dev_clk_time)
> +int idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
> +                                struct idpf_ptp_dev_timers *dev_clk_time=
)
>  {
>         struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg;
>         struct idpf_vc_xn_params xn_params =3D {
> @@ -180,7 +183,7 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *ad=
apter,
>  }
>
>  /**
> - * idpf_ptp_get_cross_time - Send virtchnl get cross time message
> + * idpf_ptp_get_cross_time_mb - Send virtchnl get cross time message
>   * @adapter: Driver specific private structure
>   * @cross_time: Pointer to the device clock structure where the value is=
 set
>   *
> @@ -189,8 +192,8 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *ad=
apter,
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
> -                           struct idpf_ptp_dev_timers *cross_time)
> +int idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
> +                              struct idpf_ptp_dev_timers *cross_time)
>  {
>         struct virtchnl2_ptp_get_cross_time cross_time_msg;
>         struct idpf_vc_xn_params xn_params =3D {
> @@ -216,7 +219,7 @@ int idpf_ptp_get_cross_time(struct idpf_adapter *adap=
ter,
>  }
>
>  /**
> - * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
> + * idpf_ptp_set_dev_clk_time_mb - Send virtchnl set device time message
>   * @adapter: Driver specific private structure
>   * @time: New time value
>   *
> @@ -224,7 +227,7 @@ int idpf_ptp_get_cross_time(struct idpf_adapter *adap=
ter,
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
> +int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adapter, u64 time)
>  {
>         struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg =3D {
>                 .dev_time_ns =3D cpu_to_le64(time),
> @@ -249,7 +252,7 @@ int idpf_ptp_set_dev_clk_time(struct idpf_adapter *ad=
apter, u64 time)
>  }
>
>  /**
> - * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time messa=
ge
> + * idpf_ptp_adj_dev_clk_time_mb - Send virtchnl adj device clock time me=
ssage
>   * @adapter: Driver specific private structure
>   * @delta: Offset in nanoseconds to adjust the time by
>   *
> @@ -257,7 +260,7 @@ int idpf_ptp_set_dev_clk_time(struct idpf_adapter *ad=
apter, u64 time)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
> +int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter, s64 delta=
)
>  {
>         struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg =3D {
>                 .delta =3D cpu_to_le64(delta),
> @@ -282,7 +285,7 @@ int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *ad=
apter, s64 delta)
>  }
>
>  /**
> - * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message
> + * idpf_ptp_adj_dev_clk_fine_mb - Send virtchnl adj time message
>   * @adapter: Driver specific private structure
>   * @incval: Source timer increment value per clock cycle
>   *
> @@ -291,7 +294,7 @@ int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *ad=
apter, s64 delta)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
> +int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incva=
l)
>  {
>         struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg =3D {
>                 .incval =3D cpu_to_le64(incval),
> @@ -610,7 +613,7 @@ idpf_ptp_get_tx_tstamp_async_handler(struct idpf_adap=
ter *adapter,
>  }
>
>  /**
> - * idpf_ptp_get_tx_tstamp - Send virtchnl get Tx timestamp latches messa=
ge
> + * idpf_ptp_get_tx_tstamp_mb - Send virtchnl get Tx timestamp latches me=
ssage
>   * @vport: Virtual port structure
>   *
>   * Send virtchnl get Tx tstamp message to read the value of the HW times=
tamp.
> @@ -618,7 +621,7 @@ idpf_ptp_get_tx_tstamp_async_handler(struct idpf_adap=
ter *adapter,
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
> +int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport)
>  {
>         struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_=
msg;
>         struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> --
> 2.42.0
>
>

