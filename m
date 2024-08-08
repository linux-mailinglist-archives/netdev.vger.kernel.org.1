Return-Path: <netdev+bounces-116923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F494C18D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588A11F28A5F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90518FDAB;
	Thu,  8 Aug 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fykeXGLc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AEA18FC99
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131281; cv=none; b=WgNZxxp79uOECQ7e20wtDEi7NOxseJFWHfZPToKhrKknm5R5/0z0NXHQz2vyuyOtHlGrCMyInqYDpenkj4DryZ6tV9BydgP3gtgdIpWoRmCFcBpjkWA7aW3QH3oq7/Nb4tJQ6RI7peTplk03E2HaKWRBhp2aa00IeF9ci7h8sUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131281; c=relaxed/simple;
	bh=84RdeZSz4NQlCIpwyeGUuDPMKNfbQVs2otQDqHu/Pig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un+gx2IfABhcId8j13wqSSwS0aNM6C3wgo96EuowOzrNDBgrxXaxCINaYf7xS3uvnSfIKRqIrd7QIBv/CgKTHYR2z3eU9Vaq6NviMu3AeYcZaVFi3GIyInWGxc7tUG5pnAsidXK83CyKhrYYzHKyRwygm5BxxskJxhWnQffi2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fykeXGLc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so146460166b.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723131278; x=1723736078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deR2cTN5hN7kQ/Mmgkv7kVEs+fw9NCwiKQ9xQIlHe+o=;
        b=fykeXGLcZ48LJYl4LDMphH/efqcdnMHHlG5nZQrInmOeaXNRlB/MPRw5VKUozKiz4i
         VQbwPeO/L+s7wjuPnuYJDVknDtmiOK5kQbV8aNlvA/R4ZxpPpAn6U7bi+Vep8/6Ly99I
         4ZDiIrG+waf1rnZZrT3JGTXLstqqsXFvkEfzNCy7ZYHNIQr5IUFcfeq5OrI0gMyvqL5A
         U8ooFEzvnJOdqjVhg3t3OkXjxCT6BoRsW8bxw+CxbZXmPP+DO+efaveGI/+n+Wmcxoa7
         J+iG7ntK/FsFmNINgJxOhaOjoywiwjTa0IofNRR1rSNNo85h9ZiTeuBfLIImVpb43c9D
         bkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131278; x=1723736078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deR2cTN5hN7kQ/Mmgkv7kVEs+fw9NCwiKQ9xQIlHe+o=;
        b=Jt2tatwW0oe5D+tsEiyk6+YNCTKtkB7UDE7HhSvXA/NMu8H1Lg184OzIMnJY2VpnEz
         ZTDTscfaKGICaOscRnPDnlHtoMpdUL80NUWGeh3L+KbjpsIl2riSlNBFwW/c8gLI/O+2
         6caOw1bOT+u3X/YW/DSzOp7FXxQjG7HDisjvd195KmTs/IMyY4d2esUooBui/X9b7k3O
         RgbNff2c8uf3/HD3YTLROkSA650NEzYFW3pb565q7FcCV7vFy4Wi0LUe2F4Lee/u7Mkr
         FQB+l14QGpA65lM4MVm137sJJ6zM2c4pciDLy/l7bxr7yVgTjUZ0nSZjLO8jG5/iAXyd
         e3cA==
X-Forwarded-Encrypted: i=1; AJvYcCXp6HlggpOb/U3Xo1903LLXQ6pIxUSUaiJKKdJzyeIlwXNtdnhlQMEwNKvt8bZrWw4nyibwOyH214KYabxztEX7vWKt9foU
X-Gm-Message-State: AOJu0YycA1XizEZCDObnsljLXo0ooXXq0tz9pwBbPN42MIL7GJzAVACt
	ZLA41duuuAZ5lpnLXl6kIghCezAoujtkoIMtKxzQ/hvcFEWAdJc/5J9flrGFdD8=
X-Google-Smtp-Source: AGHT+IGmvRB1EJlB4iKqzT595KKSJ3AT7HSTYqgUCs5wTvQ1rP7yMg8+uON+zirQWeNbJkdPP9aaOw==
X-Received: by 2002:a17:907:d2c5:b0:a77:c95e:9b1c with SMTP id a640c23a62f3a-a8090d7affdmr174071866b.27.1723131277656;
        Thu, 08 Aug 2024 08:34:37 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c6603csm754521466b.97.2024.08.08.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:34:36 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:34:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v3 1/8] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZrTli6UxMkzE31TH@nanopsycho.orion>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>

Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>range.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice.h          |  8 +++
> drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
> 3 files changed, 76 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index 29a5f822cb8b..bdc22ea13e0f 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>@@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>+static int
>+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>+				 union devlink_param_value val,
>+				 struct netlink_ext_ack *extack)
>+{
>+	if (val.vu16 > ICE_MAX_MSIX) {
>+		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");

No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
That is the name of the param.



>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
>+				 union devlink_param_value val,
>+				 struct netlink_ext_ack *extack)
>+{
>+	if (val.vu16 <= ICE_MIN_MSIX) {
>+		NL_SET_ERR_MSG_MOD(extack, "PF min MSI-X is too low");

Same comment as for max goes here.


>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> enum ice_param_id {
> 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>@@ -1535,6 +1561,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
> 			      ice_devlink_enable_iw_validate),
> };
> 
>+static const struct devlink_param ice_dvl_msix_params[] = {
>+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
>+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
>+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
>+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
>+};
>+
> static const struct devlink_param ice_dvl_sched_params[] = {
> 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> 			     "tx_scheduling_layers",
>@@ -1637,6 +1672,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
> int ice_devlink_register_params(struct ice_pf *pf)
> {
> 	struct devlink *devlink = priv_to_devlink(pf);
>+	union devlink_param_value value;
> 	struct ice_hw *hw = &pf->hw;
> 	int status;
> 
>@@ -1645,11 +1681,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
> 	if (status)
> 		return status;
> 
>+	status = devl_params_register(devlink, ice_dvl_msix_params,
>+				      ARRAY_SIZE(ice_dvl_msix_params));
>+	if (status)
>+		return status;
>+
> 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> 		status = devl_params_register(devlink, ice_dvl_sched_params,
> 					      ARRAY_SIZE(ice_dvl_sched_params));
>+	if (status)
>+		return status;
> 
>-	return status;
>+	value.vu16 = pf->msix.max;
>+	devl_param_driverinit_value_set(devlink,
>+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>+					value);
>+	value.vu16 = pf->msix.min;
>+	devl_param_driverinit_value_set(devlink,
>+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>+					value);
>+
>+	return 0;
> }
> 
> void ice_devlink_unregister_params(struct ice_pf *pf)
>@@ -1659,6 +1711,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
> 
> 	devl_params_unregister(devlink, ice_dvl_rdma_params,
> 			       ARRAY_SIZE(ice_dvl_rdma_params));
>+	devl_params_unregister(devlink, ice_dvl_msix_params,
>+			       ARRAY_SIZE(ice_dvl_msix_params));
> 
> 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> 		devl_params_unregister(devlink, ice_dvl_sched_params,
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>index d6f80da30dec..a67456057c77 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -95,6 +95,7 @@
> #define ICE_MIN_LAN_TXRX_MSIX	1
> #define ICE_MIN_LAN_OICR_MSIX	1
> #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>+#define ICE_MAX_MSIX		256
> #define ICE_FDIR_MSIX		2
> #define ICE_RDMA_NUM_AEQ_MSIX	4
> #define ICE_MIN_RDMA_MSIX	2
>@@ -545,6 +546,12 @@ struct ice_agg_node {
> 	u8 valid;
> };
> 
>+struct ice_pf_msix {
>+	u16 cur;
>+	u16 min;
>+	u16 max;
>+};
>+
> struct ice_pf {
> 	struct pci_dev *pdev;
> 	struct ice_adapter *adapter;
>@@ -615,6 +622,7 @@ struct ice_pf {
> 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
> 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>+	struct ice_pf_msix msix;
> 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> 	u16 num_lan_tx;		/* num LAN Tx queues setup */
> 	u16 num_lan_rx;		/* num LAN Rx queues setup */
>diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
>index ad82ff7d1995..4e559fd6e49f 100644
>--- a/drivers/net/ethernet/intel/ice/ice_irq.c
>+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
>@@ -252,7 +252,19 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
> int ice_init_interrupt_scheme(struct ice_pf *pf)
> {
> 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>-	int vectors, max_vectors;
>+	union devlink_param_value value;
>+	int vectors, max_vectors, err;
>+
>+	/* load default PF MSI-X range */
>+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>+					      &value);

If err is not 0, you have a bug in the driver. Perhaps it a about the
time to make this return void and add some WARN_ONs inside the function?


>+	pf->msix.min = err ? ICE_MIN_MSIX : value.vu16;
>+
>+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>+					      &value);
>+	pf->msix.max = err ? total_vectors / 2 : value.vu16;
> 
> 	vectors = ice_ena_msix_range(pf);
> 
>-- 
>2.42.0
>

