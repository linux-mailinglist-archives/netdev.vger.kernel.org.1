Return-Path: <netdev+bounces-71253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D0852D4C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2ED1C256E2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628292BB0D;
	Tue, 13 Feb 2024 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN8cGKVB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64E2C689
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818342; cv=none; b=TGJha4ccuPo/pKKgmYzvfEw/RYEFytopLD6p2JpeUyXqxNONb8W1rnnyOP6aLR3HImJosBc9oQAp7H08TU92uFSSNlUt22jK6HmQSfEML8Tyk+bq6Z2TTyhNejTzINYaCh9orQeTr3PIa0j4m311vIxbhB2QK5noaaUMmXKVaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818342; c=relaxed/simple;
	bh=WrcT7WnwPFPnDCbiJJwnFRYzs+oaPxea3SP4VKTVrZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN+7radoPZePW9cIKoOfWXcDbpU102kZuF0jmu6T9UkNv+bZGQlDM+9viFxDTG7288J+clOc0GwX0V5+AzAQo/GOy9qfRvVmX5TORzeBVCWAjKzh7MVSn/f/bSohnPZSpqR9XH3sIDSu8hkOzjivaEyqTGSHwYwJe9hDb49PZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN8cGKVB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707818340; x=1739354340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WrcT7WnwPFPnDCbiJJwnFRYzs+oaPxea3SP4VKTVrZo=;
  b=bN8cGKVBzMjoZr9tMpWs1nEPIBrLCPqZHafcEClMIY1J7cMo0HP8ov0f
   ETXgxi63rNp+fpcYNs5/VEsERkp57ZEQkPA7dkwHT3uSKOmnvA6NFQhls
   jpMZcG1FWyhB0gEZEcsicgZNBs5RxrVeUV8n4x3QHmwYgIOK+l2UJ0pGA
   ZhthUhqzZl3n3Gr56FcFq4fYvkvoaUS6TOsIRHxRBPgpb8TkJUFB9W1Hq
   NTM1bcJf1LjEc96+CZoLfTBNUIQYhPNlWgInSvgeNEjsTNuf83ykaKiQE
   dVNQ7PO0+F38Z3PW/nNmjhEsUqL1IsDJHGXPuLAJbTeuv8RHtyNAIms+2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1957735"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1957735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="3196731"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:58:58 -0800
Date: Tue, 13 Feb 2024 10:58:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [iwl-next v1 6/7] ice: enable_rdma devlink param
Message-ID: <Zcs9XeZmd2E1IHKs@mev-dev>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>
 <ZcsxRRrVvnhjLxn3@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcsxRRrVvnhjLxn3@nanopsycho>

On Tue, Feb 13, 2024 at 10:07:17AM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 08:35:08AM CET, michal.swiatkowski@linux.intel.com wrote:
> >Implement enable_rdma devlink parameter to allow user to turn RDMA
> >feature on and off.
> >
> >It is useful when there is no enough interrupts and user doesn't need
> >RDMA feature.
> >
> >Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_devlink.c | 32 ++++++++++++++++++--
> > drivers/net/ethernet/intel/ice/ice_lib.c     |  8 ++++-
> > drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++------
> > 3 files changed, 45 insertions(+), 13 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >index b82ff9556a4b..4f048268db72 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >@@ -1675,6 +1675,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> > 	return 0;
> > }
> > 
> >+static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
> >+					    union devlink_param_value val,
> >+					    struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_pf *pf = devlink_priv(devlink);
> >+	bool new_state = val.vbool;
> >+
> >+	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
> >+		return -EOPNOTSUPP;
> >+
> >+	return 0;
> >+}
> >+
> > static const struct devlink_param ice_devlink_params[] = {
> > 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > 			      ice_devlink_enable_roce_get,
> >@@ -1700,6 +1713,8 @@ static const struct devlink_param ice_devlink_params[] = {
> > 			      ice_devlink_msix_min_pf_get,
> > 			      ice_devlink_msix_min_pf_set,
> > 			      ice_devlink_msix_min_pf_validate),
> >+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> >+			      NULL, NULL, ice_devlink_enable_rdma_validate),
> > };
> > 
> > static void ice_devlink_free(void *devlink_ptr)
> >@@ -1776,9 +1791,22 @@ ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
> > int ice_devlink_register_params(struct ice_pf *pf)
> > {
> > 	struct devlink *devlink = priv_to_devlink(pf);
> >+	union devlink_param_value value;
> >+	int err;
> >+
> >+	err = devlink_params_register(devlink, ice_devlink_params,
> 
> Interesting, can't you just take the lock before this and call
> devl_params_register()?
> 
I mess up a locking here and also in subfunction patchset. I will follow
you suggestion and take lock for whole init/cleanup. Thanks.

> Moreover, could you please fix your init/cleanup paths for hold devlink
> instance lock the whole time?
> 
You right, I will prepare patch for it.

> 
> pw-bot: cr
> 
> 
> >+				      ARRAY_SIZE(ice_devlink_params));
> >+	if (err)
> >+		return err;
> > 
> >-	return devlink_params_register(devlink, ice_devlink_params,
> >-				       ARRAY_SIZE(ice_devlink_params));
> >+	devl_lock(devlink);
> >+	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >+	devl_param_driverinit_value_set(devlink,
> >+					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
> >+					value);
> >+	devl_unlock(devlink);
> >+
> >+	return 0;
> > }
> > 
> > void ice_devlink_unregister_params(struct ice_pf *pf)
> >diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> >index a30d2d2b51c1..4d5c3d699044 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_lib.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> >@@ -829,7 +829,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
> >  */
> > bool ice_is_rdma_ena(struct ice_pf *pf)
> > {
> >-	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >+	union devlink_param_value value;
> >+	int err;
> >+
> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
> >+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
> >+					      &value);
> >+	return err ? false : value.vbool;
> > }
> > 
> > /**
> >diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> >index 824732f16112..4dd59d888ec7 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_main.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_main.c
> >@@ -5177,23 +5177,21 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> > 	if (err)
> > 		goto err_init;
> > 
> >+	err = ice_init_devlink(pf);
> >+	if (err)
> >+		goto err_init_devlink;
> >+
> > 	devl_lock(priv_to_devlink(pf));
> > 	err = ice_load(pf);
> > 	devl_unlock(priv_to_devlink(pf));
> > 	if (err)
> > 		goto err_load;
> > 
> >-	err = ice_init_devlink(pf);
> >-	if (err)
> >-		goto err_init_devlink;
> >-
> > 	return 0;
> > 
> >-err_init_devlink:
> >-	devl_lock(priv_to_devlink(pf));
> >-	ice_unload(pf);
> >-	devl_unlock(priv_to_devlink(pf));
> > err_load:
> >+	ice_deinit_devlink(pf);
> >+err_init_devlink:
> > 	ice_deinit(pf);
> > err_init:
> > 	pci_disable_device(pdev);
> >@@ -5290,12 +5288,12 @@ static void ice_remove(struct pci_dev *pdev)
> > 	if (!ice_is_safe_mode(pf))
> > 		ice_remove_arfs(pf);
> > 
> >-	ice_deinit_devlink(pf);
> >-
> > 	devl_lock(priv_to_devlink(pf));
> > 	ice_unload(pf);
> > 	devl_unlock(priv_to_devlink(pf));
> > 
> >+	ice_deinit_devlink(pf);
> >+
> > 	ice_deinit(pf);
> > 	ice_vsi_release_all(pf);
> > 
> >-- 
> >2.42.0
> >
> >

