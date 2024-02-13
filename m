Return-Path: <netdev+bounces-71328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDD852FDF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA42B23770
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEB38FB9;
	Tue, 13 Feb 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYEwYK5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A5381DF
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825081; cv=none; b=nNToAdRIAPc9PcYsPbWT+NLdRW17HWOjkfVgcsdunQD+hVKUdJ++jeehkaD1qHjfIujF3PtaX5GbqmRHN++tfIW/alvfZwaGzGRxCJlibwF4YvIjIK3FO2/ER84hKgNldIweEAZ/894/eg9L9fHBxkRJXiJmo2xVZhJoX7kuLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825081; c=relaxed/simple;
	bh=uS4M8+vsGmkHQK0cf9nAqcZUWp7CBWnXPvPw6e0tukM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiB1CHt2Z+ltyi8eSaoIQLSGXoUXr3PymQOb6bp0iYOmk8qJZ3zrM4Q5l0B3EJPDbhvfgaDpflGwBjURAMIlMwSNn+iiRKxtwopvwppO2SJ25+KMRiIhnjf7/Z0Z3RLo+Qd3ozt1bOirWHY01yK2TyrqxYMhRt9cujPN/X0TIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYEwYK5Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707825080; x=1739361080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uS4M8+vsGmkHQK0cf9nAqcZUWp7CBWnXPvPw6e0tukM=;
  b=EYEwYK5Q/8OTx7973NW3xJA8X+Sz/0/oE7pRI2bPXBivLNrwGjsF+Owf
   KZA1mM0vK4YjUzXAEDYYXDpMkCA6KK3Qt8eBzId3ijLZTJ9g9qzyLutGq
   PQ8moumkKl1+7joslZPrMpD6ZV6N2ihGU4G7GEh3D2qLgldkHGFRg3KuY
   IMmXop0EayZ1LI5WES2WtuZzmXX2jqPlsMNzJlNohHnhBQvnBeetHxgpy
   AkHKYp7so997u8R5nFHqKIsxkhHRA5vyEsviiaIUZHTZq4fPUKfJ9lrOu
   UaQLzlTYR11Tvh7Z7/IRwdYnMD9tCzRSn6Fy8wS4E49RL8LPQkxaZdJuk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1680943"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1680943"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7507615"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:51:17 -0800
Date: Tue, 13 Feb 2024 12:51:09 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v1 1/7] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZctXrfWiYkopStMt@mev-dev>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-2-michal.swiatkowski@linux.intel.com>
 <ZcswSYA5GqtOb3ll@nanopsycho>
 <Zcs95HiZz5g4QUwt@mev-dev>
 <ZctTL05gEf_7XbhX@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctTL05gEf_7XbhX@nanopsycho>

On Tue, Feb 13, 2024 at 12:31:59PM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 11:01:08AM CET, michal.swiatkowski@linux.intel.com wrote:
> >On Tue, Feb 13, 2024 at 10:03:05AM +0100, Jiri Pirko wrote:
> >> Tue, Feb 13, 2024 at 08:35:03AM CET, michal.swiatkowski@linux.intel.com wrote:
> >> >Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> >> >range.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > drivers/net/ethernet/intel/ice/ice.h         |  8 ++
> >> > drivers/net/ethernet/intel/ice/ice_devlink.c | 82 ++++++++++++++++++++
> >> > drivers/net/ethernet/intel/ice/ice_irq.c     |  6 ++
> >> > 3 files changed, 96 insertions(+)
> >> >
> >> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> >> >index c4127d5f2be3..24085f3c0966 100644
> >> >--- a/drivers/net/ethernet/intel/ice/ice.h
> >> >+++ b/drivers/net/ethernet/intel/ice/ice.h
> >> >@@ -94,6 +94,7 @@
> >> > #define ICE_MIN_LAN_TXRX_MSIX	1
> >> > #define ICE_MIN_LAN_OICR_MSIX	1
> >> > #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
> >> >+#define ICE_MAX_MSIX		256
> >> > #define ICE_FDIR_MSIX		2
> >> > #define ICE_RDMA_NUM_AEQ_MSIX	4
> >> > #define ICE_MIN_RDMA_MSIX	2
> >> >@@ -535,6 +536,12 @@ struct ice_agg_node {
> >> > 	u8 valid;
> >> > };
> >> > 
> >> >+struct ice_pf_msix {
> >> >+	u16 cur;
> >> >+	u16 min;
> >> >+	u16 max;
> >> >+};
> >> >+
> >> > struct ice_pf {
> >> > 	struct pci_dev *pdev;
> >> > 
> >> >@@ -604,6 +611,7 @@ struct ice_pf {
> >> > 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
> >> > 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> >> > 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
> >> >+	struct ice_pf_msix msix;
> >> > 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> >> > 	u16 num_lan_tx;		/* num LAN Tx queues setup */
> >> > 	u16 num_lan_rx;		/* num LAN Rx queues setup */
> >> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> >index cc717175178b..b82ff9556a4b 100644
> >> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> >@@ -1603,6 +1603,78 @@ enum ice_param_id {
> >> > 	ICE_DEVLINK_PARAM_ID_LOOPBACK,
> >> > };
> >> > 
> >> >+static int
> >> >+ice_devlink_msix_max_pf_get(struct devlink *devlink, u32 id,
> >> >+			    struct devlink_param_gset_ctx *ctx)
> >> >+{
> >> >+	struct ice_pf *pf = devlink_priv(devlink);
> >> >+
> >> >+	ctx->val.vu16 = pf->msix.max;
> >> >+
> >> >+	return 0;
> >> >+}
> >> >+
> >> >+static int
> >> >+ice_devlink_msix_max_pf_set(struct devlink *devlink, u32 id,
> >> >+			    struct devlink_param_gset_ctx *ctx)
> >> >+{
> >> >+	struct ice_pf *pf = devlink_priv(devlink);
> >> >+	u16 max = ctx->val.vu16;
> >> >+
> >> >+	pf->msix.max = max;
> >> 
> >> What's permanent about this exactly?
> >> 
> >
> >I want to store the value here after driver reinit. Isn't it enough to
> >use this parameter type? Which one should be used for this purpose?
> 
> Documentation/networking/devlink/devlink-params.rst say:
> 
> .. list-table:: Possible configuration modes
>    :widths: 5 90
> 
>    * - Name
>      - Description
>    * - ``runtime``
>      - set while the driver is running, and takes effect immediately. No
>        reset is required.
>    * - ``driverinit``
>      - applied while the driver initializes. Requires the user to restart
>        the driver using the ``devlink`` reload command.
>    * - ``permanent``
>      - written to the device's non-volatile memory. A hard reset is required
>        for it to take effect.
> 
> 
> [...]
Thanks for pointing it, I changed the idea during developing it (at
first I wanted to store it in NVM) and forgot to change the type.

I will go with driverinit param.


