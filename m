Return-Path: <netdev+bounces-117156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A294CEF4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007D41C211ED
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D241922CB;
	Fri,  9 Aug 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gmPiavFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2815ECE2
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200726; cv=none; b=sfeJ2y3aIWBd0QXIG7j37PgtHNwz7e2ux9Sh5+8/v9ETovJ3a2NrRfsFO9KIi6iVT9G85hD1WqQL85vuFjzcrI8IkhngNcUP4Ob8QOjrlJDVARh4RBRSvE6hvw+38meSeMXAgkSBOogvq+CHt1oYsIMXami43igpvSCRwCNq2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200726; c=relaxed/simple;
	bh=I0nPBPAjVC52kgirtIRM5M3/OzAepwjSjuInOAa/yYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWgUfAJ+Di8xukhqnn+a85qFzKHbLottKnum7xwgV6L4TnQ5JH1HJRE/zzhbd8t4IMRun6is5/qu5ZZbJXIwwTkLGpQWYFQ73VSjcYyuC5jJAbdwLMHbutAb+IQjsi94A2Btnw4pdDtXQdzaQOa3nbJGCNxr+HmdIIEaTKECHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gmPiavFI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso20887111fa.2
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723200721; x=1723805521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTgmTKZ4H9V3mCycartQDNFcC4ZnqwSMFSBOFb0czr4=;
        b=gmPiavFIBUBOL63QA7TzXA/+DWKT3asVnNQbb2xCXGmLR18l8GuWUQ9REmsmOB2iIy
         Xh/9ittfRMHs3bCP9m5Tk2maP+ztlHEYIq4oT8dJNyspwicWhJabKVbGjBBVCfKkvUuS
         Wu5hig/iik63h+vyHjhgE6GUGN5nSJJ6fsOCpfmiXi8Nx7eNF4qPnFIPSxX4u1+dA75n
         8/c0FNXr76R9J/tnXapK/NA4gZh2cLOVqOnD7BVNKTXscx7VnjqgqXUS8vNo3tBbfRET
         jBHDjZI/SnprI5VyTwvWvc4Je2kxYzPvVWl3+VIg5fy68w2FVCw367mF2oCX0ijfQ21W
         Hvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723200721; x=1723805521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTgmTKZ4H9V3mCycartQDNFcC4ZnqwSMFSBOFb0czr4=;
        b=BGCMbOZOfcjXqP0keEECYWvzkrTyFIC9vc7mJvSSW6tocvdZBnoROtubHGPJn+YkCm
         UzapBd2CJ1PJt8i8GGdwnR9kXUZaGMUR/GwgKbu0grgesg58k9nlcRT9Oh9eCOlS3eyU
         3hqTpik+59sjM+nrvSbZ3z5RyOWL8hBLJx6jkm1n3uu/TGsTMBhnt9bBV34cbTfE7d50
         WOLcntYYUqhORMr6ECstDHS0pusGfxeWD1JncE6KctXMAFM2ObC0MpN5uH6pO4kJGIis
         Ga0b1mMynLhJwrN0KgbQ73gl7aUhAW3m3m/A83RrVrAhKsxlALD+iiu/Ugrm2bVbu0L7
         puLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+pxR8HcxzXPKT0hr7NjVbjvWvIKnO9J3AYjcVBCnDeZK1zAJiPp0qTqsPj5WNw6YLtxYahPR55zrEV3hof94L1zLAZkNu
X-Gm-Message-State: AOJu0YzYWdtl1ULsOfdXjBa1wQoZbM4EwPsAQ8PB70ywvo2e+jZ9QcES
	ovr6Pt2iOLpacY6JlAoEfOOa04Qi6g+ErmPNEALA4e8k2ysYoA2ptTDPAj0gfkJAX+89hie/Yy6
	7
X-Google-Smtp-Source: AGHT+IGunqE4/d7MOq1p34WRYbFJhymcmxwgUqpVn+Yz5KYTfqG/SGwi3RJgpp76MhN0IuC9McaK8Q==
X-Received: by 2002:a2e:9906:0:b0:2ef:2e0e:c888 with SMTP id 38308e7fff4ca-2f1a6d6b775mr8454391fa.48.1723200720346;
        Fri, 09 Aug 2024 03:52:00 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cbfaesm116279405e9.42.2024.08.09.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 03:51:59 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:51:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v3 1/8] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZrX0znOhHFzafIuB@nanopsycho.orion>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion>
 <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>

Fri, Aug 09, 2024 at 07:13:34AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>> Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>> >range.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>> > drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>> > drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>> > 3 files changed, 76 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >index 29a5f822cb8b..bdc22ea13e0f 100644
>> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >@@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>> > 	return 0;
>> > }
>> > 
>> >+static int
>> >+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>> >+				 union devlink_param_value val,
>> >+				 struct netlink_ext_ack *extack)
>> >+{
>> >+	if (val.vu16 > ICE_MAX_MSIX) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>> 
>> No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>> That is the name of the param.
>> 
>
>Ok, will change both, thanks.
>
>> 
>> 
>> >+		return -EINVAL;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> >+
>> >+static int
>> >+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
>> >+				 union devlink_param_value val,
>> >+				 struct netlink_ext_ack *extack)
>> >+{
>> >+	if (val.vu16 <= ICE_MIN_MSIX) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "PF min MSI-X is too low");
>> 
>> Same comment as for max goes here.
>> 
>> 
>> >+		return -EINVAL;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> >+
>> > enum ice_param_id {
>> > 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> > 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>> >@@ -1535,6 +1561,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
>> > 			      ice_devlink_enable_iw_validate),
>> > };
>> > 
>> >+static const struct devlink_param ice_dvl_msix_params[] = {
>> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
>> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>> >+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
>> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
>> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>> >+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
>> >+};
>> >+
>> > static const struct devlink_param ice_dvl_sched_params[] = {
>> > 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>> > 			     "tx_scheduling_layers",
>> >@@ -1637,6 +1672,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
>> > int ice_devlink_register_params(struct ice_pf *pf)
>> > {
>> > 	struct devlink *devlink = priv_to_devlink(pf);
>> >+	union devlink_param_value value;
>> > 	struct ice_hw *hw = &pf->hw;
>> > 	int status;
>> > 
>> >@@ -1645,11 +1681,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
>> > 	if (status)
>> > 		return status;
>> > 
>> >+	status = devl_params_register(devlink, ice_dvl_msix_params,
>> >+				      ARRAY_SIZE(ice_dvl_msix_params));
>> >+	if (status)
>> >+		return status;
>> >+
>> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>> > 		status = devl_params_register(devlink, ice_dvl_sched_params,
>> > 					      ARRAY_SIZE(ice_dvl_sched_params));
>> >+	if (status)
>> >+		return status;
>> > 
>> >-	return status;
>> >+	value.vu16 = pf->msix.max;
>> >+	devl_param_driverinit_value_set(devlink,
>> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>> >+					value);
>> >+	value.vu16 = pf->msix.min;
>> >+	devl_param_driverinit_value_set(devlink,
>> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>> >+					value);
>> >+
>> >+	return 0;
>> > }
>> > 
>> > void ice_devlink_unregister_params(struct ice_pf *pf)
>> >@@ -1659,6 +1711,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
>> > 
>> > 	devl_params_unregister(devlink, ice_dvl_rdma_params,
>> > 			       ARRAY_SIZE(ice_dvl_rdma_params));
>> >+	devl_params_unregister(devlink, ice_dvl_msix_params,
>> >+			       ARRAY_SIZE(ice_dvl_msix_params));
>> > 
>> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>> > 		devl_params_unregister(devlink, ice_dvl_sched_params,
>> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> >index d6f80da30dec..a67456057c77 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice.h
>> >+++ b/drivers/net/ethernet/intel/ice/ice.h
>> >@@ -95,6 +95,7 @@
>> > #define ICE_MIN_LAN_TXRX_MSIX	1
>> > #define ICE_MIN_LAN_OICR_MSIX	1
>> > #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>> >+#define ICE_MAX_MSIX		256
>> > #define ICE_FDIR_MSIX		2
>> > #define ICE_RDMA_NUM_AEQ_MSIX	4
>> > #define ICE_MIN_RDMA_MSIX	2
>> >@@ -545,6 +546,12 @@ struct ice_agg_node {
>> > 	u8 valid;
>> > };
>> > 
>> >+struct ice_pf_msix {
>> >+	u16 cur;
>> >+	u16 min;
>> >+	u16 max;
>> >+};
>> >+
>> > struct ice_pf {
>> > 	struct pci_dev *pdev;
>> > 	struct ice_adapter *adapter;
>> >@@ -615,6 +622,7 @@ struct ice_pf {
>> > 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
>> > 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
>> > 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>> >+	struct ice_pf_msix msix;
>> > 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
>> > 	u16 num_lan_tx;		/* num LAN Tx queues setup */
>> > 	u16 num_lan_rx;		/* num LAN Rx queues setup */
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
>> >index ad82ff7d1995..4e559fd6e49f 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_irq.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
>> >@@ -252,7 +252,19 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
>> > int ice_init_interrupt_scheme(struct ice_pf *pf)
>> > {
>> > 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>> >-	int vectors, max_vectors;
>> >+	union devlink_param_value value;
>> >+	int vectors, max_vectors, err;
>> >+
>> >+	/* load default PF MSI-X range */
>> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>> >+					      &value);
>> 
>> If err is not 0, you have a bug in the driver. Perhaps it a about the
>> time to make this return void and add some WARN_ONs inside the function?
>> 
>
>err is not 0 when this param isn't found (not registered yet). It is a
>case when driver is probing, I want to have here default values and
>register it later. Instead of checking if it is probe context or reload
>context I am checking if param already exists. The param doesn't exist in
>probe, but exists in reload.

No, you have to make sure that you are using these values after they are
set. Please fix.


>
>> 
>> >+	pf->msix.min = err ? ICE_MIN_MSIX : value.vu16;
>> >+
>> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>> >+					      &value);
>> >+	pf->msix.max = err ? total_vectors / 2 : value.vu16;
>> > 
>> > 	vectors = ice_ena_msix_range(pf);
>> > 
>> >-- 
>> >2.42.0
>> >

