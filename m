Return-Path: <netdev+bounces-82087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F188C4B8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02DA1C6153A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0D1327FE;
	Tue, 26 Mar 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR1NPhFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86F1327E9;
	Tue, 26 Mar 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462108; cv=none; b=fXoZcKr4XJiAPFe2YK8nHFVd9Tj+avLJOWCsH5ofHMI9XXpDgSGrdaQJk/S6ViXcUs2CPnMKx3MIZ1dDoBP9n7hi7PyRwKWPeg2CsbCX1mV8qbc67lCEId1h0+CntgwYmGuxDOTYTybJ4DxE6ijlStivvJbJ9RCs8GWW0Bf5Lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462108; c=relaxed/simple;
	bh=bY1OR40TRb21xx/DvbjH3F2E2wkaPuG9wLge9veFPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIY/0fnFcIDkyJnlu9fhfEtSXGaN8vu60Sjfvt/YQgCjD3rDo9dQI4sN2jCSrg/bIHihEsxtC3Cl92zwQG5yaNG0jJe00xxiohfagJjMPF9uw1mAIQUonsmMigMvZPKgAMCgVg2GkvRbaV8qBTP8HBTjDjhPUTZjTTMj86tQipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR1NPhFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0E1C433F1;
	Tue, 26 Mar 2024 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462108;
	bh=bY1OR40TRb21xx/DvbjH3F2E2wkaPuG9wLge9veFPks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR1NPhFRpdtuUaXqRXXkdvd4hCOU9mBW61L8Q2lepr3ZJZjYLSOy/mfVW6j9Qlfq6
	 tOMQvdKea6oVdSoJPevlHiR279WnOwMx00KNq6tSzKxK2v7pNOcXDHZr8EKDpMkf21
	 A1BMmdXaJFA/UmFIL3KPrcgCx4m071hZwDsfKlOJMJIv+zbQc8tYjNu5adTAGUcxmx
	 yXyLVE87wta2LiCKdIx7dcOZ515P6rNtONJcMyezE31SRxSrABImIMN75bjGt3fTwY
	 bWnZocs22Ab7cxoq/TkvN9yzlTWxEBmun4rwrXBc2YmG8rA7bFznlBnUyJRY/47YsN
	 Mwh5WzqAaIqrg==
Date: Tue, 26 Mar 2024 14:08:22 +0000
From: Simon Horman <horms@kernel.org>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, wojciech.drewek@intel.com,
	sumang@marvell.com, jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	jiri@resnulli.us, michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH v6] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <20240326140822.GU403975@kernel.org>
References: <20240321081625.28671-1-ksundara@redhat.com>
 <20240321081625.28671-2-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321081625.28671-2-ksundara@redhat.com>

On Thu, Mar 21, 2024 at 01:46:25PM +0530, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs is currently unsupported via devlink.
> Add the function handlers to set and get the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 66 +++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 +++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..35c7cfc8ce9a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -1576,6 +1576,69 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>  	devlink_port_unregister(&pf->devlink_port);
>  }
>  
> +/**
> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +
> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> +					  u8 *hw_addr, int *hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);

nit: blank line here please.

Flagged by checkpatch.

> +	if (!vf) {

Given the way that container_of works, I don't think vf can be NULL.

Flagged by Smatch.

> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
> +		return -EINVAL;
> +	}
> +	ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +	*hw_addr_len = ETH_ALEN;
> +
> +	return 0;
> +}

...


