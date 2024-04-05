Return-Path: <netdev+bounces-85054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4A899284
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A441C21620
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDECC393;
	Fri,  5 Apr 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwHgrJWh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116A36F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276100; cv=none; b=TDQg1NZMJQLJWOyZlH4mwhWBfOY90M6nFMG/dBtuK+b8oXTjDHQR+U144c5prFNBKXzgX66lD03XQ1sfb09gTL+Nw1hm57/634P4NLgjWYUaB8b4a/uQFofbsJRKEzgGn6/2rssxiDz87bn61ExP+uhdbwnZiR8zuohUmPIg+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276100; c=relaxed/simple;
	bh=lhXrrKk3jui/IPf1Wm9PfMRztmR64UbYlM8a8dUK8O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2Qq8UyADAUXvLWxLs5uwJA0VMjXgeq1+/i0IglpidA9ghJxj8OReN/EqfjyK5pgQlLuk9na7+Vyn2hvP20TF8DMfpOaAyF9N4AHy44HFCrqhBsbD3o3aTejvEc6H+Am0YaoXmoAWptWh+V5323E5MbZsWX1xEuXEAQ0vo8+I04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwHgrJWh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712276098; x=1743812098;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lhXrrKk3jui/IPf1Wm9PfMRztmR64UbYlM8a8dUK8O8=;
  b=RwHgrJWhZNBMfj9pFm6kpn3mAfNl8NP0Y57dXQ87/yOAqNCYXic7rYiL
   b+XkU6MNVOyreH//8KEgFAaajWSBRXx9GYke+amYUio61wG8dUQ5WfgdG
   inaCBypDYUq1+XMUTw3T8tpUPVH/SXXSDKGOaC1LawI2MDsJ9I1YuxTgW
   Z4eYDngMLwWSifY7+kA0m94dr4gGPn7lpxYb/+n4HFfCyFfwPajABEcYy
   6OrfeJqBQHBs6RSsEnt/aQn9LXHZr/Fdc1gPkJ2VWZzQ9H4IbSkgsc4jo
   rJYgqvYZ6o77XCInNKGyXyKPx0M/7OkOfDpUmIp8/rl8UyX7Csg3M8Ur0
   Q==;
X-CSE-ConnectionGUID: sAZlF/cfQ0W89fHbgaluuA==
X-CSE-MsgGUID: 92c7iiMaTiq0Xo9ybscbSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7437167"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7437167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 17:14:58 -0700
X-CSE-ConnectionGUID: bX4iwGqcTh2NWHL0xPOMMQ==
X-CSE-MsgGUID: s90ctnXpSm+GRPJlvGhiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23449022"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.241.228.254])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 17:14:58 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Jan Glaza
 <jan.glaza@intel.com>, Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 3/5] ixgbe: Add link
 management support for E610 device
In-Reply-To: <20240327155422.25424-4-piotr.kwapulinski@intel.com>
References: <20240327155422.25424-1-piotr.kwapulinski@intel.com>
 <20240327155422.25424-4-piotr.kwapulinski@intel.com>
Date: Thu, 04 Apr 2024 17:14:57 -0700
Message-ID: <87r0fkbr7i.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Piotr Kwapulinski <piotr.kwapulinski@intel.com> writes:

> Add low level link management support for E610 device. Link management
> operations are handled via the Admin Command Interface. Add the following
> link management operations:
> - get link capabilities
> - set up link
> - get media type
> - get link status, link status events
> - link power management
>
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---

[...]

> +/**
> + * ixgbe_update_link_info - update status of the HW network link
> + * @hw: pointer to the HW struct
> + *
> + * Update the status of the HW network link.
> + *
> + * Return: the exit code of the operation.
> + */
> +int ixgbe_update_link_info(struct ixgbe_hw *hw)
> +{
> +	struct ixgbe_link_status *li;
> +	int err;
> +
> +	if (!hw)
> +		return -EINVAL;
> +
> +	li = &hw->link.link_info;
> +
> +	err = ixgbe_aci_get_link_info(hw, true, NULL);
> +	if (err)
> +		return err;
> +
> +	if (li->link_info & IXGBE_ACI_MEDIA_AVAILABLE) {
> +		struct ixgbe_aci_cmd_get_phy_caps_data __free(kfree) *pcaps;
> +
> +		pcaps =	kzalloc(sizeof(*pcaps), GFP_KERNEL);
> +		if (!pcaps)
> +			return -ENOMEM;
> +

Seems that 'pcaps' is leaking here.

> +		err = ixgbe_aci_get_phy_caps(hw, false,
> +					     IXGBE_ACI_REPORT_TOPO_CAP_MEDIA,
> +					     pcaps);
> +
> +		if (!err)
> +			memcpy(li->module_type, &pcaps->module_type,
> +			       sizeof(li->module_type));
> +	}
> +
> +	return err;
> +}
> +
[...]

> +/**
> + * ixgbe_get_media_type_e610 - Gets media type
> + * @hw: pointer to the HW struct
> + *
> + * In order to get the media type, the function gets PHY
> + * capabilities and later on use them to identify the PHY type
> + * checking phy_type_high and phy_type_low.
> + *
> + * Return: the type of media in form of ixgbe_media_type enum
> + * or ixgbe_media_type_unknown in case of an error.
> + */
> +enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
> +{
> +	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
> +	int rc;
> +
> +	rc = ixgbe_update_link_info(hw);
> +	if (rc)
> +		return ixgbe_media_type_unknown;
> +
> +	/* If there is no link but PHY (dongle) is available SW should use
> +	 * Get PHY Caps admin command instead of Get Link Status, find most
> +	 * significant bit that is set in PHY types reported by the command
> +	 * and use it to discover media type.
> +	 */
> +	if (!(hw->link.link_info.link_info & IXGBE_ACI_LINK_UP) &&
> +	    (hw->link.link_info.link_info & IXGBE_ACI_MEDIA_AVAILABLE)) {
> +		u64 phy_mask;
> +		u8 i;
> +
> +		/* Get PHY Capabilities */
> +		rc = ixgbe_aci_get_phy_caps(hw, false,
> +					    IXGBE_ACI_REPORT_TOPO_CAP_MEDIA,
> +					    &pcaps);
> +		if (rc)
> +			return ixgbe_media_type_unknown;
> +
> +		/* Check if there is some bit set in phy_type_high */
> +		for (i = 64; i > 0; i--) {
> +			phy_mask = (u64)((u64)1 << (i - 1));
> +			if ((pcaps.phy_type_high & phy_mask) != 0) {
> +				/* If any bit is set treat it as PHY type */
> +				hw->link.link_info.phy_type_high = phy_mask;
> +				hw->link.link_info.phy_type_low = 0;
> +				break;
> +			}
> +			phy_mask = 0;
> +		}
> +
> +		/* If nothing found in phy_type_high search in phy_type_low */
> +		if (phy_mask == 0) {
> +			for (i = 64; i > 0; i--) {
> +				phy_mask = (u64)((u64)1 << (i - 1));
> +				if ((pcaps.phy_type_low & phy_mask) != 0) {
> +					/* Treat as PHY type is any bit set */
> +					hw->link.link_info.phy_type_high = 0;
> +					hw->link.link_info.phy_type_low = phy_mask;
> +					break;
> +				}
> +			}
> +		}

These two look like they are doing something very similar to fls64().
Could that work?

> +
> +		/* Based on search above try to discover media type */
> +		hw->phy.media_type = ixgbe_get_media_type_from_phy_type(hw);
> +	}
> +
> +	return hw->phy.media_type;
> +}
> +


-- 
Vinicius

