Return-Path: <netdev+bounces-117171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B878394CF5D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DBCB221A1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813D19307B;
	Fri,  9 Aug 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ut9lLmDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBE192B9F
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202975; cv=none; b=KHvfrh9AghwNTdXxOl7lDQ/Cv/3bddCf1zuKijkEfXgWt+K55Vldciq1j6w0DB0ZqCpC+zAJnsYkjRydp7ll7tRPiWM0oNYsW62ba2tECt6YNBIcT+7BBh+B8bUi3lA9S03Pj88TdFkMwuSF23SbT65iaMW3kR3RQrltZZvyrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202975; c=relaxed/simple;
	bh=N4x/MW+1MbJ2CsPvB12wNbUcQ16SVzeNCviIE8c8oTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip2WFMjpcRc3a7yJEUjC/yLz4vyN5DHtudDu7jsNjwixkfnfUaDtlDBotuYqJl9Sgu7CSC1BEEi/7DgqgT8KWix9962Vq1GLecunlpDXQ1oITTUL+8F8YEPrcSwwY0KNXd4Edg0sCsNgPA0zC8XxukTCtNM6iOr17dTfvgMhH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ut9lLmDn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so4941470a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723202971; x=1723807771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyS6K4gg9HTe5Apzm+4uDAa2h0cC4rqNExbinIXb3Cw=;
        b=Ut9lLmDnniC8rBtjoDPPHBbx9rZHBPmIap/z5ljhYu6V3VfOO7VSld2IbpC+s+/Q2Z
         Mf8M3G9ehd7tuk69MREZ58KlrlQ/cQSDOfDEEp66catjV0N9StsnlCyE4cTDzf+aJ12v
         K6dxXggMquj6TngJdWGgHJ6c4o2FrGV2mEMwj8msPnVpMETpfl4e+R7/gcF8X2nAR/jf
         fGzDjPei/zSzSPN/wepDbxmlrTGBOyEgRU7OZFEhB2YPpsu4pw6H/6gvv5MuIarJaQA+
         Hgsusn+1JVLOXks8BAw58DiqNdtSsTZqT2I5sAdsLnMhWCATiiSmwFr97vApVLl5Hv/i
         JIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202971; x=1723807771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyS6K4gg9HTe5Apzm+4uDAa2h0cC4rqNExbinIXb3Cw=;
        b=P2ItK7eTd/VIBosKhJd+fHfC/mPWAXnoTrUqGZG4VoQ3R/aUTPnujlGOIrtXyQ6ce5
         /ox3Ow8Zji1LD+qsaWuhug03Jpkzk29adP+FiZCSTJAIu+lZlyvIgcrn7yUtkhx+QOB3
         3nKyeQHm8c2xCy7v2f+WUnuYDAlVNdNWrRD1F4g4/rdjYJVzvvx+yciWFUnAy4GHhs35
         p6EwzB7u11HRbV/Kwva4/tJn3YYY6V3DV0uJuJYBMWQz9MpPGQ6rV9rrzKHPIlHp+oxt
         7gO33id0Xg2cZBuZ08AfahknGMaF5ek9B7OgG61c4nYwTtkno7ZV7fOLObXcLhfdj+Jz
         gZUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjwym13G59uaGtjgFzkDoshUmztKw1y2Axzx4ywSWYYrses01Boa2VWjdn/MIbzd9a77lgxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HKVGWs1qm0ZpJhc9naZU1JU7XJC2e9B1xZCggvTKa3DbIi5C
	IoEVNvvs3otUGUCLFj5OQWJCjOgXxTi3Yz9rVZ5/4QePcOBR65G+spmNKtPKr6Y=
X-Google-Smtp-Source: AGHT+IE4MESI99k4uHvNYEgvbB7E/q0JR392WxjNZLGQw46/tGqviav3YF+LFlhnElXoYNLuPmKJqQ==
X-Received: by 2002:a17:907:1c08:b0:a77:ce4c:8c9c with SMTP id a640c23a62f3a-a8091ef3797mr449201266b.8.1723202971204;
        Fri, 09 Aug 2024 04:29:31 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83eccsm829222166b.184.2024.08.09.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:29:30 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:29:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v3 1/8] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZrX9mbsJD8VLEOs6@nanopsycho.orion>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion>
 <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
 <ZrX0znOhHFzafIuB@nanopsycho.orion>
 <ZrX33DvUqXGB2ork@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX33DvUqXGB2ork@mev-dev.igk.intel.com>

Fri, Aug 09, 2024 at 01:05:00PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Fri, Aug 09, 2024 at 12:51:58PM +0200, Jiri Pirko wrote:
>> Fri, Aug 09, 2024 at 07:13:34AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>> >> Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >> >Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>> >> >range.
>> >> >
>> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >> >---
>> >> > .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>> >> > drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>> >> > drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>> >> > 3 files changed, 76 insertions(+), 2 deletions(-)
>> >> >
>> >> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >> >index 29a5f822cb8b..bdc22ea13e0f 100644
>> >> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >> >@@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>> >> > 	return 0;
>> >> > }
>> >> > 
>> >> >+static int
>> >> >+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>> >> >+				 union devlink_param_value val,
>> >> >+				 struct netlink_ext_ack *extack)
>> >> >+{
>> >> >+	if (val.vu16 > ICE_MAX_MSIX) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>> >> 
>> >> No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>> >> That is the name of the param.
>> >> 
>> >
>> >Ok, will change both, thanks.
>> >
>> >> 
>> >> 
>> >> >+		return -EINVAL;
>> >> >+	}
>> >> >+
>> >> >+	return 0;
>> >> >+}
>> >> >+
>> >> >+static int
>> >> >+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
>> >> >+				 union devlink_param_value val,
>> >> >+				 struct netlink_ext_ack *extack)
>> >> >+{
>> >> >+	if (val.vu16 <= ICE_MIN_MSIX) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "PF min MSI-X is too low");
>> >> 
>> >> Same comment as for max goes here.
>> >> 
>> >> 
>> >> >+		return -EINVAL;
>> >> >+	}
>> >> >+
>> >> >+	return 0;
>> >> >+}
>> >> >+
>> >> > enum ice_param_id {
>> >> > 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> >> > 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>> >> >@@ -1535,6 +1561,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
>> >> > 			      ice_devlink_enable_iw_validate),
>> >> > };
>> >> > 
>> >> >+static const struct devlink_param ice_dvl_msix_params[] = {
>> >> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
>> >> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>> >> >+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
>> >> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
>> >> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>> >> >+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
>> >> >+};
>> >> >+
>> >> > static const struct devlink_param ice_dvl_sched_params[] = {
>> >> > 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>> >> > 			     "tx_scheduling_layers",
>> >> >@@ -1637,6 +1672,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
>> >> > int ice_devlink_register_params(struct ice_pf *pf)
>> >> > {
>> >> > 	struct devlink *devlink = priv_to_devlink(pf);
>> >> >+	union devlink_param_value value;
>> >> > 	struct ice_hw *hw = &pf->hw;
>> >> > 	int status;
>> >> > 
>> >> >@@ -1645,11 +1681,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
>> >> > 	if (status)
>> >> > 		return status;
>> >> > 
>> >> >+	status = devl_params_register(devlink, ice_dvl_msix_params,
>> >> >+				      ARRAY_SIZE(ice_dvl_msix_params));
>> >> >+	if (status)
>> >> >+		return status;
>> >> >+
>> >> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>> >> > 		status = devl_params_register(devlink, ice_dvl_sched_params,
>> >> > 					      ARRAY_SIZE(ice_dvl_sched_params));
>> >> >+	if (status)
>> >> >+		return status;
>> >> > 
>> >> >-	return status;
>> >> >+	value.vu16 = pf->msix.max;
>> >> >+	devl_param_driverinit_value_set(devlink,
>> >> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>> >> >+					value);
>> >> >+	value.vu16 = pf->msix.min;
>> >> >+	devl_param_driverinit_value_set(devlink,
>> >> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>> >> >+					value);
>> >> >+
>> >> >+	return 0;
>> >> > }
>> >> > 
>> >> > void ice_devlink_unregister_params(struct ice_pf *pf)
>> >> >@@ -1659,6 +1711,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
>> >> > 
>> >> > 	devl_params_unregister(devlink, ice_dvl_rdma_params,
>> >> > 			       ARRAY_SIZE(ice_dvl_rdma_params));
>> >> >+	devl_params_unregister(devlink, ice_dvl_msix_params,
>> >> >+			       ARRAY_SIZE(ice_dvl_msix_params));
>> >> > 
>> >> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>> >> > 		devl_params_unregister(devlink, ice_dvl_sched_params,
>> >> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> >> >index d6f80da30dec..a67456057c77 100644
>> >> >--- a/drivers/net/ethernet/intel/ice/ice.h
>> >> >+++ b/drivers/net/ethernet/intel/ice/ice.h
>> >> >@@ -95,6 +95,7 @@
>> >> > #define ICE_MIN_LAN_TXRX_MSIX	1
>> >> > #define ICE_MIN_LAN_OICR_MSIX	1
>> >> > #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>> >> >+#define ICE_MAX_MSIX		256
>> >> > #define ICE_FDIR_MSIX		2
>> >> > #define ICE_RDMA_NUM_AEQ_MSIX	4
>> >> > #define ICE_MIN_RDMA_MSIX	2
>> >> >@@ -545,6 +546,12 @@ struct ice_agg_node {
>> >> > 	u8 valid;
>> >> > };
>> >> > 
>> >> >+struct ice_pf_msix {
>> >> >+	u16 cur;
>> >> >+	u16 min;
>> >> >+	u16 max;
>> >> >+};
>> >> >+
>> >> > struct ice_pf {
>> >> > 	struct pci_dev *pdev;
>> >> > 	struct ice_adapter *adapter;
>> >> >@@ -615,6 +622,7 @@ struct ice_pf {
>> >> > 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
>> >> > 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
>> >> > 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>> >> >+	struct ice_pf_msix msix;
>> >> > 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
>> >> > 	u16 num_lan_tx;		/* num LAN Tx queues setup */
>> >> > 	u16 num_lan_rx;		/* num LAN Rx queues setup */
>> >> >diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
>> >> >index ad82ff7d1995..4e559fd6e49f 100644
>> >> >--- a/drivers/net/ethernet/intel/ice/ice_irq.c
>> >> >+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
>> >> >@@ -252,7 +252,19 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
>> >> > int ice_init_interrupt_scheme(struct ice_pf *pf)
>> >> > {
>> >> > 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>> >> >-	int vectors, max_vectors;
>> >> >+	union devlink_param_value value;
>> >> >+	int vectors, max_vectors, err;
>> >> >+
>> >> >+	/* load default PF MSI-X range */
>> >> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>> >> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
>> >> >+					      &value);
>> >> 
>> >> If err is not 0, you have a bug in the driver. Perhaps it a about the
>> >> time to make this return void and add some WARN_ONs inside the function?
>> >> 
>> >
>> >err is not 0 when this param isn't found (not registered yet). It is a
>> >case when driver is probing, I want to have here default values and
>> >register it later. Instead of checking if it is probe context or reload
>> >context I am checking if param already exists. The param doesn't exist in
>> >probe, but exists in reload.
>> 
>> No, you have to make sure that you are using these values after they are
>> set. Please fix.
>> 
>
>I am not using value if this function returns error. If function returns
>error default values are set. The function
>devl_param_driverinit_value_get() is already checking if parameter
>exists. Why do you want me to check it before calling this function? Do
>you mean that calling it with not registered parameters is a problem? I
>don't see why it can be a problem.

If you call this for non-existing parameter, your driver flow is wrong.
That's my point.


>
>> 
>> >
>> >> 
>> >> >+	pf->msix.min = err ? ICE_MIN_MSIX : value.vu16;
>> >> >+
>> >> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>> >> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
>> >> >+					      &value);
>> >> >+	pf->msix.max = err ? total_vectors / 2 : value.vu16;
>> >> > 
>> >> > 	vectors = ice_ena_msix_range(pf);
>> >> > 
>> >> >-- 
>> >> >2.42.0
>> >> >

