Return-Path: <netdev+bounces-218293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB837B3BCCE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9432A56060A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA4314B96;
	Fri, 29 Aug 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDVHuyTO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01919347B4
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475435; cv=none; b=GvIUv5OgqbbQ3o1Xzr7cDao4PxZB/TQIZ81dUte+ukXAOqMd/iwuHbKOXTaF7GiIjbzVZCnZpc1b1Ve/jmj0lldn1KzR2dkewP72K7ixWG1j+f7udYnO6mHPlQEi/wr9BriF6LLqoA2fra6jJ38D0zYM+sVVw8v4tZTcl/8KLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475435; c=relaxed/simple;
	bh=yWbnQFk1J7FcyzizocJvYC0znkhpHyVXPbqalZ2aC/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCFebAuMiJXsGn4RUH+QseyRSgRMe51MmUQ6AoPzbtmVU1yhposKPB3ua/Cw5LQxjF6ZI4FQ0KAmuWzSTp1Odd7L1AiEdXQHY9ZztIksru9w1Y3t+rT0+Iy2vLFbJYz08mxsgZe2Cg4RG/1Fx8ix/t9PhIqPjDCLDgHzXV0+Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDVHuyTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756475432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV0VetiIkZg6OKtzkxyKWCKROkMG8CWw91TX1g10wz4=;
	b=JDVHuyTOFZ5tM8qVqyMsK48IHqcGGMnwuCCYcJNvQvDtSHbjn7AetSi4Vu5Uv6u1St2UtA
	kq4xqXF5CtXI4RJhqtTEI9OY9alQ9ATPpFlLVBYoG5b2IA+5kD/VttCK5OGkf+TfPN0U/0
	+5NvQQdQSlQx/n2E/ZEAcDp4LlVnIhM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-lC16z0RlMqKNZmJgJPuKTg-1; Fri, 29 Aug 2025 09:50:31 -0400
X-MC-Unique: lC16z0RlMqKNZmJgJPuKTg-1
X-Mimecast-MFC-AGG-ID: lC16z0RlMqKNZmJgJPuKTg_1756475431
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-30ccebce606so719969fac.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 06:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756475430; x=1757080230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV0VetiIkZg6OKtzkxyKWCKROkMG8CWw91TX1g10wz4=;
        b=imVIVCO4Ilebc5Fg9CDGbYjNu5bIArHceWIW4ptxO6nhccEYo52tVHKrtE8pQknQiZ
         ftdhguweqXnRY5TL1qU3HdCnqlULKZD/sRps41GAqkmVeQSdTNccnlRy2JHF9pE0PNIM
         QCzG+b+zPdeDBZNhvH/sH+WrwmhZli/fcsVfNnsdfgtXh77jMTjQT61UjzmfMJ4A2pps
         st86+HZBrNpHQ+Iy6Tn8nSp8m8iaazn0Tm1KCMx7YPuNZHgzWphD3g8vIlEJM/wFp1rN
         HP9BJXQItVKboFyF72LzO0GdHIDv0TsO0G9nOWFCDLeVNuvGwuNrlW7H3kuBFxinJaNl
         8yYw==
X-Forwarded-Encrypted: i=1; AJvYcCWDn0ioMb5FnXBWiHyY/ap7dZCfewVIMCyD6XK/MgBbQv2RdQJ6QC5+R+2r2fO1F0GXU+jq2iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbin38+fDyotN8KJY+3/7e9Ydjc0tsTFAVFDkQ26e0SI4fnHvh
	Dqgk1zdHWzUqpS2ahX0GoXzxRsr138FGIGBryK/XK140i7iWv4lxy1q0kCQ1UJIG5CmXM+YCDAL
	BU0BpV0cuSjTfiEnDkWE3aEvw3deEuzACUi/ELNXQ4Iuw6lqG+eKRDkQrUgJxDZNQvqlmTK2qZn
	RGIhttEA3I4r8o9pD2E6CMx4rvDIMczwbEGSE9sZCQ
X-Gm-Gg: ASbGncvvWXrBhPIfyS93vx8RwQElTciB9WMBUEMITfhaX5KRa5AxljrSyOJ/iwxcnlX
	FJ+VzovQoF/ID6mENGXzWtRRmwwbQjTAiAZmRGN1raSTrfow9sEOP3QmzWZ3LS8s69cvotnI+kR
	SKbF+gbyYdjjcXppiuL7vS
X-Received: by 2002:a05:6871:5005:b0:315:8e99:1ce6 with SMTP id 586e51a60fabf-315bfb1adb4mr325909fac.8.1756475429935;
        Fri, 29 Aug 2025 06:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBzOcyCosA1TMLZwj0/Z9Kqygb0T0L6g/fPksz6fCLVlX5p6IH1ebXqx0gMKGPOOe1s+6vva2fmraCZmI0IKg=
X-Received: by 2002:a05:6871:5005:b0:315:8e99:1ce6 with SMTP id
 586e51a60fabf-315bfb1adb4mr325901fac.8.1756475429502; Fri, 29 Aug 2025
 06:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-jk-fix-i40e-ice-pxe-9k-mtu-v3-1-14341728e572@intel.com>
In-Reply-To: <20250827-jk-fix-i40e-ice-pxe-9k-mtu-v3-1-14341728e572@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 29 Aug 2025 15:50:18 +0200
X-Gm-Features: Ac12FXw6MbSN3H0zo4lHXjtWmj4bb6-ESWHDsvmVqvdLLGY_eJT2xAz1GWdnNWE
Message-ID: <CADEbmW2eDnADv78cwWRAVMuq_JrgPACbfTf_Yc_oA-Xiuv+x_w@mail.gmail.com>
Subject: Re: [PATCH iwl-net v3] i40e: fix Jumbo Frame support after iPXE boot
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
	Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:18=E2=80=AFPM Jacob Keller <jacob.e.keller@intel=
.com> wrote:
> The i40e hardware has multiple hardware settings which define the Maximum
> Frame Size (MFS) of the physical port. The firmware has an AdminQ command
> (0x0603) to configure the MFS, but the i40e Linux driver never issues thi=
s
> command.
>
> In most cases this is no problem, as the NVM default value has the device
> configured for its maximum value of 9728. Unfortunately, recent versions =
of
> the iPXE intelxl driver now issue the 0x0603 Set Mac Config command,
> modifying the MFS and reducing it from its default value of 9728.
>
> This occurred as part of iPXE commit 6871a7de705b ("[intelxl] Use admin
> queue to set port MAC address and maximum frame size"), a prerequisite
> change for supporting the E800 series hardware in iPXE. Both the E700 and
> E800 firmware support the AdminQ command, and the iPXE code shares much o=
f
> the logic between the two device drivers.
>
> The ice E800 Linux driver already issues the 0x0603 Set Mac Config comman=
d
> early during probe, and is thus unaffected by the iPXE change.
>
> Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
> i40e driver does check the I40E_PRTGL_SAH register, but it only logs a
> warning message if its value is below the 9728 default. This register als=
o
> only covers received packets and not transmitted packets. A warning can
> inform system administrators, but does not correct the issue. No
> interactions from userspace cause the driver to write to PRTGL_SAH or iss=
ue
> the 0x0603 AdminQ command. Only a GLOBR reset will restore the value to i=
ts
> default value. There is no obvious method to trigger a GLOBR reset from
> user space.
>
> To fix this, introduce the i40e_aq_set_mac_config() function, similar to
> the one from the ice driver. Call this during early probe to ensure that
> the device configuration matches driver expectation. Unlike E800, the E70=
0
> firmware also has a bit to control whether the MAC should append CRC data=
.
> It is on by default, but setting a 0 to this bit would disable CRC. The
> i40e implementation must set this bit to ensure CRC will be appended by t=
he
> MAC.
>
> In addition to the AQ command, instead of just checking the I40E_PRTGL_SA=
H
> register, update its value to the 9728 default and write it back. This
> ensures that the hardware is in the expected state, regardless of whether
> the iPXE (or any other early boot driver) has modified this state.
>
> This is a better user experience, as we now fix the issues with larger MT=
U
> instead of merely warning. It also aligns with the way the ice E800 serie=
s
> driver works.
>
> A final note: The Fixes tag provided here is not strictly accurate. The
> issue occurs as a result of an external entity (the iPXE intelxl driver),
> and this is not a regression specifically caused by the mentioned change.
> However, I believe the original change to just warn about PRTGL_SAH being
> too low was an insufficient fix.
>
> Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
> Link: https://github.com/ipxe/ipxe/commit/6871a7de705b6f6a4046f0d19da9bcd=
689c3bc8e
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v3:
> - Don't disable CRC. Otherwise, Tx traffic will not be accepted
>   appropriately.
> - Link to v2: https://lore.kernel.org/r/20250815-jk-fix-i40e-ice-pxe-9k-m=
tu-v2-1-ce857cdc6488@intel.com
>
> Changes in v2:
> - Rewrite commit message with feedback from Paul Menzel.
> - Add missing initialization of cmd via libie_aq_raw().
> - Fix the Kdoc comment for i40e_aq_set_mac_config().
> - Move clarification of the Fixes tag to the commit message.
> - Link to v1: https://lore.kernel.org/r/20250814-jk-fix-i40e-ice-pxe-9k-m=
tu-v1-1-c3926287fb78@intel.com
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h  |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_common.c     | 34 +++++++++++++++++=
++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c       | 17 ++++++++----
>  4 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/=
net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index 76d872b91a38..cc02a85ad42b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1561,6 +1561,7 @@ I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
>  struct i40e_aq_set_mac_config {
>         __le16  max_frame_size;
>         u8      params;
> +#define I40E_AQ_SET_MAC_CONFIG_CRC_EN  BIT(2)
>         u8      tx_timer_priority; /* bitmap */
>         __le16  tx_timer_value;
>         __le16  fc_refresh_threshold;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/n=
et/ethernet/intel/i40e/i40e_prototype.h
> index aef5de53ce3b..26bb7bffe361 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -98,6 +98,8 @@ int i40e_aq_set_mac_loopback(struct i40e_hw *hw,
>                              struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
>                              struct i40e_asq_cmd_details *cmd_details);
> +int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
> +                          struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
>                            struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/=
ethernet/intel/i40e/i40e_common.c
> index 270e7e8cf9cf..59f5c1e810eb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -1189,6 +1189,40 @@ int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failure=
s,
>         return status;
>  }
>
> +/**
> + * i40e_aq_set_mac_config - Configure MAC settings
> + * @hw: pointer to the hw struct
> + * @max_frame_size: Maximum Frame Size to be supported by the port
> + * @cmd_details: pointer to command details structure or NULL
> + *
> + * Set MAC configuration (0x0603). Note that max_frame_size must be grea=
ter
> + * than zero.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
> +                          struct i40e_asq_cmd_details *cmd_details)
> +{
> +       struct i40e_aq_set_mac_config *cmd;
> +       struct libie_aq_desc desc;
> +
> +       cmd =3D libie_aq_raw(&desc);
> +
> +       if (max_frame_size =3D=3D 0)
> +               return -EINVAL;
> +
> +       i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_set_mac_con=
fig);
> +
> +       cmd->max_frame_size =3D cpu_to_le16(max_frame_size);
> +       cmd->params =3D I40E_AQ_SET_MAC_CONFIG_CRC_EN;
> +
> +#define I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD    0x7FFF
> +       cmd->fc_refresh_threshold =3D
> +               cpu_to_le16(I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD);
> +
> +       return i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
> +}
> +
>  /**
>   * i40e_aq_clear_pxe_mode
>   * @hw: pointer to the hw struct
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index b83f823e4917..4796fdd0b966 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16045,13 +16045,18 @@ static int i40e_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>                 dev_dbg(&pf->pdev->dev, "get supported phy types ret =3D =
 %pe last_status =3D  %s\n",
>                         ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_sta=
tus));
>
> -       /* make sure the MFS hasn't been set lower than the default */
>  #define MAX_FRAME_SIZE_DEFAULT 0x2600
> -       val =3D FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
> -                       rd32(&pf->hw, I40E_PRTGL_SAH));
> -       if (val < MAX_FRAME_SIZE_DEFAULT)
> -               dev_warn(&pdev->dev, "MFS for port %x (%d) has been set b=
elow the default (%d)\n",
> -                        pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
> +
> +       err =3D i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT, NULL);
> +       if (err) {
> +               dev_warn(&pdev->dev, "set mac config ret =3D  %pe last_st=
atus =3D  %s\n",

Just a nit:
There are double spaces here after the '=3D' signs for no good reason.
It's not just in this message. There are a few more like that in this file.

> +                        ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_st=
atus));
> +       }
> +
> +       /* Make sure the MFS is set to the expected value */
> +       val =3D rd32(hw, I40E_PRTGL_SAH);
> +       FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val, MAX_FRAME_SIZE_DEFAUL=
T);
> +       wr32(hw, I40E_PRTGL_SAH, val);
>
>         /* Add a filter to drop all Flow control frames from any VSI from=
 being
>          * transmitted. By doing so we stop a malicious VF from sending o=
ut
>
> ---
> base-commit: ceb9515524046252c522b16f38881e8837ec0d91
> change-id: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9
>
> Best regards,
> --
> Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


