Return-Path: <netdev+bounces-82809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6BD88FD70
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB71C23E72
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E27D3E6;
	Thu, 28 Mar 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKVy1+y8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5E7BB1F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623191; cv=none; b=NxqkLH5hxBjOkRFlcsUuJ2BuAqIzO/ydrVTOpSdeyv7P7xvWuKBT9WQ4pvQMlMihnbg6TWJrcHNZowm8bvprDGPrL2bTeU03jcT50UocfQv8ypf9uXR/ulVWi4Y1XPcO1kcd5uJ7NIxuWlU8/GWCLkaVynQu0x0gL1zTnWv5JMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623191; c=relaxed/simple;
	bh=seXF02s6oM8tX3o5V5mRtz+WUDr9NquudAR2I5f5iEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKEkWckmHi8jWrF/k7HNGM0qNq84bIjXGDh3nDU8EgtKPVZeeIxlNn886FPY20s6cjgckCcTB6VHvmXkfEEMgRrjv7/q4kWIUHFg+lz99LvKmjdv7q8FX4NMGkFcldOQL/Xs9QCHUTarMKqhwOHmefLJGVkqWivbMvoPzVZSWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKVy1+y8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29df3333d30so625416a91.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711623189; x=1712227989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfCJkz0NV4LNlg16H4z9u4Tyaak9D9MaxCwxDTUgm50=;
        b=mKVy1+y8BFeLgQQYu2f7l6g+6wTAwxO9TFyR9Z4GrQ7xvLhCvXBBcJtdf09KpWkwN1
         Xz9NSr2uZ0BamGkVC50QlPB0DrhzhVe7MeyCDErni6gaztG/hHUvk0y2DaNjjtnWN+ke
         u0E6tdv+hMh1GsmWb38gN2bG+pdTEAy+JQHHtv1Z7WEuJa72/rtg3dXshbIjz7DjrJMW
         GLU5mcDbKp9oW73lxwgLdQDqt5ZLaDWD8wqeIYG7/PBaHxUe+G1djywTDPaFbgxFlnx0
         ZqCuxDRmciyHi7BiT9dlxVly7mnhAs6Oxl1QwYFUjOaW6b9EofNKui0IyGaj5ETy4Me/
         eSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711623189; x=1712227989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfCJkz0NV4LNlg16H4z9u4Tyaak9D9MaxCwxDTUgm50=;
        b=mXLqCkSO4obe6WwEEq5uR1bt/ImF09DvA5/uDpi520KwgmUyNBwlgzRfiuHR85S2Oe
         YzFyCohNRDWUiHhFUYGg4/tgZOPvr8mdz9ttbLGvZzeCdcZtOiA2nQAxqHoM75ryfuv4
         CXSTyvGN5IqdvjND4KbmLuMQEAxrWoEFo0moQI7Z9PFys1Px26P6ExnU8NggW5k6G/5E
         bCFzmkJXHDpE5DnHNL3tVIxOtzhkUzH0l0mJasVMlsNyai9XwyR4puhOt9xAO8Oveb/1
         lHubZVEa8WAxiXrGzjWYVsvP2jAl0+L0zNsHsKpuxX4l/zFTL/2vPdBjXhuwjm6rTvog
         ANZg==
X-Forwarded-Encrypted: i=1; AJvYcCUJT7h1KIiTNJprQp5dKxcnyU77Idxph3twsd56adf+LhpvlgjhOSTM561nM9Q3a5tsqaMz9fv5LXnd6K956Orn/E10T410
X-Gm-Message-State: AOJu0Yx/08yecVHMoXPMp0P74P6xKnk+LTEs4wbR6Y5DGSY8XZpZtC07
	zSfLgloMoJWlb2tz4d0RqZiE6nK0wqa8lpgFlPo6If+AzCpLhwE69IV3qY3l8fo2x6fRlLfXnsc
	ClApHpLZN0mXermac7ROmYJxwriQ+/8G3Ek6Q6A==
X-Google-Smtp-Source: AGHT+IFwWldsBeFdr8zFcP7EfGeTcGYDRszNZfDGOHJg+M5jsArJUn7O5UUnsjadRgVeOth6d3KqOOFBQ3KRxhqIfek=
X-Received: by 2002:a17:90a:6985:b0:29d:fe34:fa16 with SMTP id
 s5-20020a17090a698500b0029dfe34fa16mr2366601pjj.21.1711623188963; Thu, 28 Mar
 2024 03:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328093405.336378-14-karol.kolacinski@intel.com> <20240328093405.336378-17-karol.kolacinski@intel.com>
In-Reply-To: <20240328093405.336378-17-karol.kolacinski@intel.com>
From: geethasowjanya <geethasowjanya.kornu@gmail.com>
Date: Thu, 28 Mar 2024 16:22:57 +0530
Message-ID: <CAJFAVwokuo-x51LzEZQKCd-MQAQFeV-Gctqq97LPYnM9SKgGKQ@mail.gmail.com>
Subject: Re: [PATCH v2 iwl-next 03/12] ice: Implement Tx interrupt enablement functions
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com, 
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:04=E2=80=AFPM Karol Kolacinski
<karol.kolacinski@intel.com> wrote:
>
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>
> Introduce functions enabling/disabling Tx TS interrupts
> for the E822 and ETH56G PHYs
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 63 ++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  4 +-
>  3 files changed, 63 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 8150f949dfd3..3019988a43c8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1457,42 +1457,43 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 po=
rt, bool linkup)
>   * @ena: bool value to enable or disable interrupt
>   * @threshold: Minimum number of packets at which intr is triggered
>   *
> - * Utility function to enable or disable Tx timestamp interrupt and thre=
shold
> + * Utility function to configure all the PHY interrupt settings, includi=
ng
> + * whether the PHY interrupt is enabled, and what threshold to use. Also
> + * configures The E82X timestamp owner to react to interrupts from all P=
HYs.
>   */
>  static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 th=
reshold)
>  {
> +       struct device *dev =3D ice_pf_to_dev(pf);
>         struct ice_hw *hw =3D &pf->hw;
> -       int err =3D 0;
> -       int quad;
> -       u32 val;
>
>         ice_ptp_reset_ts_memory(hw);
>
> -       for (quad =3D 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); qua=
d++) {
> -               err =3D ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL=
_CFG,
> -                                            &val);
> -               if (err)
> -                       break;
> -
> -               if (ena) {
> -                       val |=3D Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> -                       val &=3D ~Q_REG_TX_MEM_GBL_CFG_INTR_THR_M;
> -                       val |=3D FIELD_PREP(Q_REG_TX_MEM_GBL_CFG_INTR_THR=
_M,
> -                                         threshold);
> -               } else {
> -                       val &=3D ~Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> +       switch (hw->ptp.phy_model) {
> +       case ICE_PHY_E82X: {
> +               int quad;
> +
> +               for (quad =3D 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lpor=
ts);
> +                    quad++) {
> +                       int err;
> +
> +                       err =3D ice_phy_cfg_intr_e82x(hw, quad, ena, thre=
shold);
> +                       if (err) {
> +                               dev_err(dev, "Failed to configure PHY int=
errupt for quad %d, err %d\n",
> +                                       quad, err);
> +                               return err;
> +                       }
>                 }
>
> -               err =3D ice_write_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GB=
L_CFG,
> -                                             val);
> -               if (err)
> -                       break;
> +               return 0;
> +       }
> +       case ICE_PHY_E810:
> +               return 0;
> +       case ICE_PHY_UNSUP:
> +       default:
> +               dev_warn(dev, "%s: Unexpected PHY model %d\n", __func__,
> +                        hw->ptp.phy_model);
> +               return -EOPNOTSUPP;
>         }
> -
> -       if (err)
> -               dev_err(ice_pf_to_dev(pf), "PTP failed in intr ena, err %=
d\n",
> -                       err);
> -       return err;
>  }
>
>  /**
> @@ -3010,12 +3011,10 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
>         /* Release the global hardware lock */
>         ice_ptp_unlock(hw);
>
> -       if (!ice_is_e810(hw)) {
> -               /* Enable quad interrupts */
> -               err =3D ice_ptp_cfg_phy_interrupt(pf, true, 1);
> -               if (err)
> -                       goto err_exit;
> -       }
> +       /* Configure PHY interrupt settings */
> +       err =3D ice_ptp_cfg_phy_interrupt(pf, true, 1);
> +       if (err)
> +               goto err_exit;
>
>         /* Ensure we have a clock device */
>         err =3D ice_ptp_create_clock(pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/et=
hernet/intel/ice/ice_ptp_hw.c
> index c892b966c3b8..12f04ad263c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2715,6 +2715,37 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw=
, u8 quad, u64 *tstamp_ready)
>         return 0;
>  }
>
> +/**
> + * ice_phy_cfg_intr_e82x - Configure TX timestamp interrupt
> + * @hw: pointer to the HW struct
> + * @quad: the timestamp quad
> + * @ena: enable or disable interrupt
> + * @threshold: interrupt threshold
> + *
> + * Configure TX timestamp interrupt for the specified quad
> + */
> +
> +int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 thres=
hold)
> +{
> +       int err;
> +       u32 val;

Reverse Christmas trees.
> +
> +       err =3D ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, &v=
al);
> +       if (err)
> +               return err;
> +
> +       val &=3D ~Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> +       if (ena) {
> +               val |=3D Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> +               val &=3D ~Q_REG_TX_MEM_GBL_CFG_INTR_THR_M;
> +               val |=3D FIELD_PREP(Q_REG_TX_MEM_GBL_CFG_INTR_THR_M, thre=
shold);
> +       }
> +
> +       err =3D ice_write_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, v=
al);
> +
> +       return err;
> +}
> +
>  /**
>   * ice_ptp_init_phy_e82x - initialize PHY parameters
>   * @ptp: pointer to the PTP HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/et=
hernet/intel/ice/ice_ptp_hw.h
> index 6246de3bacf3..5645b20a9f87 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -265,6 +265,7 @@ int ice_stop_phy_timer_e82x(struct ice_hw *hw, u8 por=
t, bool soft_reset);
>  int ice_start_phy_timer_e82x(struct ice_hw *hw, u8 port);
>  int ice_phy_cfg_tx_offset_e82x(struct ice_hw *hw, u8 port);
>  int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port);
> +int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 thres=
hold);
>
>  /* E810 family functions */
>  int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
> @@ -342,11 +343,8 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw =
*hw, u8 pin_id,
>  #define Q_REG_TX_MEM_GBL_CFG           0xC08
>  #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_S       0
>  #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_M       BIT(0)
> -#define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_S 1
>  #define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_M ICE_M(0xFF, 1)
> -#define Q_REG_TX_MEM_GBL_CFG_INTR_THR_S        9
>  #define Q_REG_TX_MEM_GBL_CFG_INTR_THR_M ICE_M(0x3F, 9)
> -#define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_S        15
>  #define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M        BIT(15)
>
>  /* Tx Timestamp data registers */
> --
> 2.43.0
>
>

