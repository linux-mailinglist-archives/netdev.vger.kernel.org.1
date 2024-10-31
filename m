Return-Path: <netdev+bounces-140820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601789B85B4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BA71C21250
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697A41B5ED4;
	Thu, 31 Oct 2024 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGhwAEre"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3014A4F9
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411340; cv=none; b=Jac/zsuhVPRbZHAcqVi4TMji4mpzQZlNzL5fiTN6abdVvBYH9TDDkVEuJ2Qp//m7CPsjxHvM3paep/DtcnDw3xU16G3qqG/CvUzjh7NHfCdIny5pNrNnH7KoSQvLK6ZRsU2P2/JnrvnNSw2gKlNOHmeK86V+sHt7STD+R58KqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411340; c=relaxed/simple;
	bh=0DtoonJ7C40YpHKi4vLJK/l3USj/GDD4hQheC8VgAeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyowQGOcNVJpm3kY31F3+Z52jHCm9XTTrzA5V6qiL8mqhZk3tW0A3FApDq7LM9niF3GWgt6aKY7D+bRo8x+LZbA7w0l7MnCp+EUyuTABzC6Y64gJvlr/E6CbzAbZYzmGT8ebQzElUBNd3xiNTT6GQjl8S/oIEwmLOpos2NDpa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGhwAEre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730411332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnBFpiuE+xMACzNViBoA7DL7OvaYYVkZTvE8TFeaOKU=;
	b=KGhwAErelJDS26zNOihH3plxIAZmYsYeVSNuTOKdN3YuZzdodIwXnwmevEBgiv7JhndciZ
	GrWVh3fsa/6N0WGm/mNQzm0DpFHCwRlcpIqdAHTvO+/dSfWUm/fTGN3IOrkX6JWzCmUx5t
	QwQJrxr0TPZSmDseJHa4k5hIgvo8Mhs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-EEIW9EGNOMicVmHkBo8nEA-1; Thu, 31 Oct 2024 17:48:51 -0400
X-MC-Unique: EEIW9EGNOMicVmHkBo8nEA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb61688d1bso103709eaf.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411330; x=1731016130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnBFpiuE+xMACzNViBoA7DL7OvaYYVkZTvE8TFeaOKU=;
        b=X9FDNYqrYKaCBzW9IbnrvOQ4731myP0sBgGUfZoKYYweAje18esozRRdgsaNwUKrUo
         IZ+3ROTS5eYN61R6341lnTpVEIWUcztyc1lQf7PN1Q5peZ1EKUKYQ0gODJ2DI4b/Iage
         DDp26RxCaGN/UNTrH7XjtTHqDVVdQLbvEWFpV+8fJAofRt6INPxZ6jUvaBPV8bXdOv1H
         pXIOWosZ4dDD0UiwfECIgqA4mjzsam7gRxKvLxgewnPA39DHFxi1un5K/iL9BAicHA4C
         dAdUIMQjIzZhnvE3Lbnl58Myv9nPcu+GtEetWSARrOzQvPeAdz5535kBZe/ZN8HrhlXR
         uyog==
X-Forwarded-Encrypted: i=1; AJvYcCUCPEEknkMH/2DScF+6SXPSS0SmgdQo0BHL/Sz1J+9OTIwZQ6i1sGcf0ytBxYBjBsxrfRGgx2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQLz0VcoYxLVtG6eNgT0Wp0XgAnM25YcskDACFeNO/GJnoTwI
	x1U9PLCkwxBMmp2NbKaIHLlciwJrM7ZZuLqNIcRXo/V9Qd+7LqpAVKuj7e3UtP/rHRPRvPe5qEU
	hemvPw10jXvgERV9nj83iEO9zrBxlAgpgLj8nwVFm8yP/wf13Z5qRsc88+XfXfzhv95xFadi0rc
	s7SeCflow/oTdngxl13U1jZSoBPnrwLTzkD4m7wsw=
X-Received: by 2002:a05:6871:5226:b0:27b:9f8b:7e4b with SMTP id 586e51a60fabf-29051f4304bmr4669733fac.13.1730411329717;
        Thu, 31 Oct 2024 14:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQMU+JXiAo/tPhQ8g+QyzcfseYiR9aafOlkUX+CWChkWtHOtd/ddi8z3QPpGonNRYw/rBQFfdmFbMw7s+KGDs=
X-Received: by 2002:a05:6871:5226:b0:27b:9f8b:7e4b with SMTP id
 586e51a60fabf-29051f4304bmr4669719fac.13.1730411329350; Thu, 31 Oct 2024
 14:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com> <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 31 Oct 2024 22:48:37 +0100
Message-ID: <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max and
 min parameter
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com, 
	jacob.e.keller@intel.com, pio.raczynski@gmail.com, konrad.knitter@intel.com, 
	marcin.szycik@intel.com, wojciech.drewek@intel.com, 
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com, 
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:04=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> range.
>
> Add notes about this parameters into ice devlink documentation.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      | 11 +++
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
>  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/net=
working/devlink/ice.rst
> index e3972d03cea0..792e9f8c846a 100644
> --- a/Documentation/networking/devlink/ice.rst
> +++ b/Documentation/networking/devlink/ice.rst
> @@ -69,6 +69,17 @@ Parameters
>
>         To verify that value has been set:
>         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_laye=
rs
> +   * - ``msix_vec_per_pf_max``
> +     - driverinit
> +     - Set the max MSI-X that can be used by the PF, rest can be utilize=
d for
> +       SRIOV. The range is from min value set in msix_vec_per_pf_min to
> +       2k/number of ports.
> +   * - ``msix_vec_per_pf_min``
> +     - driverinit
> +     - Set the min MSI-X that will be used by the PF. This value inform =
how many
> +       MSI-X will be allocated statically. The range is from 2 to value =
set
> +       in msix_vec_per_pf_max.
> +
>  .. list-table:: Driver specific parameters implemented
>      :widths: 5 5 90
>
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/n=
et/ethernet/intel/ice/devlink/devlink.c
> index d1b9ccec5e05..29c1fec4fa93 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1198,6 +1198,25 @@ static int ice_devlink_set_parent(struct devlink_r=
ate *devlink_rate,
>         return status;
>  }
>
> +static void ice_set_min_max_msix(struct ice_pf *pf)
> +{
> +       struct devlink *devlink =3D priv_to_devlink(pf);
> +       union devlink_param_value val;
> +       int err;
> +
> +       err =3D devl_param_driverinit_value_get(devlink,
> +                                             DEVLINK_PARAM_GENERIC_ID_MS=
IX_VEC_PER_PF_MIN,
> +                                             &val);
> +       if (!err)
> +               pf->msix.min =3D val.vu16;
> +
> +       err =3D devl_param_driverinit_value_get(devlink,
> +                                             DEVLINK_PARAM_GENERIC_ID_MS=
IX_VEC_PER_PF_MAX,
> +                                             &val);
> +       if (!err)
> +               pf->msix.max =3D val.vu16;
> +}
> +
>  /**
>   * ice_devlink_reinit_up - do reinit of the given PF
>   * @pf: pointer to the PF struct
> @@ -1207,6 +1226,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>         struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
>         int err;
>
> +       /* load MSI-X values */
> +       ice_set_min_max_msix(pf);
> +
>         err =3D ice_init_hw(&pf->hw);
>         if (err) {
>                 dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", er=
r);
> @@ -1526,6 +1548,37 @@ static int ice_devlink_local_fwd_validate(struct d=
evlink *devlink, u32 id,
>         return 0;
>  }
>
> +static int
> +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> +                                union devlink_param_value val,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct ice_pf *pf =3D devlink_priv(devlink);
> +
> +       if (val.vu16 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> +           val.vu16 < pf->msix.min) {
> +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> +                                union devlink_param_value val,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct ice_pf *pf =3D devlink_priv(devlink);
> +
> +       if (val.vu16 <=3D ICE_MIN_MSIX || val.vu16 > pf->msix.max) {
> +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  enum ice_param_id {
>         ICE_DEVLINK_PARAM_ID_BASE =3D DEVLINK_PARAM_GENERIC_ID_MAX,
>         ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> @@ -1543,6 +1596,15 @@ static const struct devlink_param ice_dvl_rdma_par=
ams[] =3D {
>                               ice_devlink_enable_iw_validate),
>  };
>
> +static const struct devlink_param ice_dvl_msix_params[] =3D {
> +       DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
> +                             BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +                             NULL, NULL, ice_devlink_msix_max_pf_validat=
e),
> +       DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
> +                             BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +                             NULL, NULL, ice_devlink_msix_min_pf_validat=
e),
> +};
> +
>  static const struct devlink_param ice_dvl_sched_params[] =3D {
>         DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>                              "tx_scheduling_layers",
> @@ -1644,6 +1706,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
>  int ice_devlink_register_params(struct ice_pf *pf)
>  {
>         struct devlink *devlink =3D priv_to_devlink(pf);
> +       union devlink_param_value value;
>         struct ice_hw *hw =3D &pf->hw;
>         int status;
>
> @@ -1652,11 +1715,27 @@ int ice_devlink_register_params(struct ice_pf *pf=
)
>         if (status)
>                 return status;
>
> +       status =3D devl_params_register(devlink, ice_dvl_msix_params,
> +                                     ARRAY_SIZE(ice_dvl_msix_params));
> +       if (status)
> +               return status;
> +
>         if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>                 status =3D devl_params_register(devlink, ice_dvl_sched_pa=
rams,
>                                               ARRAY_SIZE(ice_dvl_sched_pa=
rams));
> +       if (status)
> +               return status;
>
> -       return status;
> +       value.vu16 =3D pf->msix.max;
> +       devl_param_driverinit_value_set(devlink,
> +                                       DEVLINK_PARAM_GENERIC_ID_MSIX_VEC=
_PER_PF_MAX,
> +                                       value);
> +       value.vu16 =3D pf->msix.min;
> +       devl_param_driverinit_value_set(devlink,
> +                                       DEVLINK_PARAM_GENERIC_ID_MSIX_VEC=
_PER_PF_MIN,
> +                                       value);
> +
> +       return 0;
>  }


The type of the devlink parameters msix_vec_per_pf_{min,max} is
specified as u32, so you must use value.vu32 everywhere you work with
them, not vu16.

Michal


