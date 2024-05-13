Return-Path: <netdev+bounces-96016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8A8C4000
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCF1F22B1B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54814D298;
	Mon, 13 May 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V269bNYO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E314D293
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600693; cv=none; b=n59O7V0A240vKdXPfQYTpb/GLx0/n0nZJwEdBNLYm89haXRTWcfcgAMMvcsldEQEMQSP5/hVzSgDB2LIQBGpbkhblyA8AFA5WZpnqTsPaABPsZuQ1X3vjVPCQl6FYifkxWPSfwBCU+Eown3rCPltH96XatPBR4rLPaJEJNTpDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600693; c=relaxed/simple;
	bh=nK3+LcnXzXyftikuQXDRPxJYaEKa1l+sJltWiV5/bCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3rlVfmha+dps6EauIQYcoBihd+PMz/c0wUl3F1yPuT7GVpm+S7o8fyHIRgND708rMwVnG0q7VyvQCMpHkr/mOW1ueZzVNAb7YANQBG4NOzgeP4A2ocD+/A2S/d/+d4fd5S5hMunGiFLNSGt3Xxt+YFPpbsnv2x6mlLyLmF43IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V269bNYO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715600691; x=1747136691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nK3+LcnXzXyftikuQXDRPxJYaEKa1l+sJltWiV5/bCM=;
  b=V269bNYO6oEOaPreU18tKWtEX7zXQRWaQMjxIxVUbvPfZHPoEQb3nG8a
   XF8ae/bvjci6W+u/Z+R1GwBU2WrTRyTc6Gx8HYb1qodgktIxD6IrT9kjt
   VH1rsZqRKlRpJiDDSjZ1f3SIXTxKyLnvXZqLBwWoj9nb6XlN/73TuAcT7
   R0FkL+7+4FAEFnX0tERcZgiB7kI5WIzfDkDbIHbj/OmTrLdmni2/1k310
   Wt9Q4TkP/AvSUXKsrXwT+74PvwqkKKpsljmUqK5sPgwehAmENQjrQ/0a2
   OBwTwD+TspXXcM6KPlRQey2ohiUTWmSs9Bv1VFVLS1v4m8RCVbMZRpsqW
   g==;
X-CSE-ConnectionGUID: fofo97L5RgWRHqVWcknYbQ==
X-CSE-MsgGUID: 3fg40C1MREuxBGw5Zc+8kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29020523"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29020523"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:44:51 -0700
X-CSE-ConnectionGUID: TEI0SCc0QwOaAJJtVouqWQ==
X-CSE-MsgGUID: i1kOB4utSNKe5vIesbfTyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30870121"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:44:48 -0700
Date: Mon, 13 May 2024 13:44:14 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 03/15] ice: add basic devlink subfunctions support
Message-ID: <ZkH9DurNJ/OFDvT/@mev-dev>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
 <ZkHztwMeJFU73WQm@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHztwMeJFU73WQm@nanopsycho.orion>

On Mon, May 13, 2024 at 01:04:23PM +0200, Jiri Pirko wrote:
> Mon, May 13, 2024 at 10:37:23AM CEST, michal.swiatkowski@linux.intel.com wrote:
> 
> [...]
> 
> 
> 
> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
> >+{
> >+	struct devlink_port_attrs attrs = {};
> >+	struct devlink_port *devlink_port;
> >+	struct devlink *devlink;
> >+	struct ice_vsi *vsi;
> >+	struct device *dev;
> >+	struct ice_pf *pf;
> >+	int err;
> >+
> >+	vsi = dyn_port->vsi;
> >+	pf = dyn_port->pf;
> >+	dev = ice_pf_to_dev(pf);
> >+
> >+	devlink_port = &dyn_port->devlink_port;
> >+
> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
> >+	attrs.pci_sf.pf = pf->hw.bus.func;
> >+	attrs.pci_sf.sf = dyn_port->sfnum;
> >+
> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >+	devlink = priv_to_devlink(pf);
> >+
> >+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> >+					  &ice_devlink_port_sf_ops);
> >+	if (err) {
> >+		dev_err(dev, "Failed to create devlink port for Subfunction %d",
> >+			vsi->idx);
> 
> Either use extack or avoid this error message entirely. Could you please
> double you don't write dmesg error messages in case you have extack
> available in the rest of this patchset?
> 
> 

Sure, I can avoid, as this is called from port representor creeation
function. I don't want to pass extack there (code is generic for VF and
SF, and VF call doesn't have extack).

We have this pattern in few place in code (using dev_err even extack can
be passed). Is it recommended to pass extact to all functions
which probably want to write some message in case of error (assuming the
call context has the extack)? 

> >+		return err;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> 
> [...]

