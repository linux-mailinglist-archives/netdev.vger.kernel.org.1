Return-Path: <netdev+bounces-71333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBA85300B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FF51C2137C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDB383B9;
	Tue, 13 Feb 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaC38GgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEF2BB16
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825771; cv=none; b=NnHWzrE+9AKXRADlGy411CzZ+tl7pJgeZbRVSpg/k9Dr/ovMUKqmfbExF778DHdeAdqI0HuMbWFQrD5Uu/E6K6LwvBciU2kdF6355qqGZ83mm3YU/YWXyMN+EpYT+wVNGkg2sp0mXmDpUeO52GZqM/GggUoju7DR7U5jFJZJ7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825771; c=relaxed/simple;
	bh=OUzefAcMM3IqLhQ3ByMvL3q6m2sF0IMucLfnm11UtJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjnR7ofmdd+Eidm7CzKCLFKBBl1LD1lACAArAjpqN+IY6M1SAOwLYEQESe6MmrX7nYfpHDhlcjjpD0l20WAhJRWcTm3YwWu03RR+TFFXHbQEBZ+Xf12Kd4yZGhrwxElSkig55pyx2fLXyvcQfe8iktWFiwsBVhF4F2pL+961BuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaC38GgJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707825770; x=1739361770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUzefAcMM3IqLhQ3ByMvL3q6m2sF0IMucLfnm11UtJ4=;
  b=MaC38GgJIZ+o8ZlCuikz5ZWDccnV0uA73BYHCMAoVsznjB71ZkVc4on1
   qbHgUo1+FfOqMGmLt3z+xjTMVH/dB0Ek1qIocBwic97YlRldynIFZEoBP
   JrmjfJ9CGSzOWkKTHpP9taMfJwDF0ZVxFuDv2hgybLY+SrWi7it9YwM36
   XLigtb4XTDTa76fVhfY2X/V1raPgZknzwpW+KBmr+fAZnExwUZ1n6Aekq
   CWUb/OdgmYuPsWcjJsEje0cE2WefmgGVhElDVFT1jI8GXJ3yDVhGxkMoR
   29rMuRQB7SrX1E4bNGYimP7upzUqoDpYQJb6zHXgDZdakRmloqSZG6vPp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1949049"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1949049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:02:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911775824"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911775824"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:02:46 -0800
Date: Tue, 13 Feb 2024 13:02:43 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
	michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
	pio.raczynski@gmail.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, wojciech.drewek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 04/15] ice: add basic devlink
 subfunctions support
Message-ID: <ZctaY7AfjS/N2J9X@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-5-michal.swiatkowski@linux.intel.com>
 <ZcsueJ1tr-GdseIt@nanopsycho>
 <Zcs442A/+nuLJw6j@mev-dev>
 <ZctSGPf6v0QlfMUu@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctSGPf6v0QlfMUu@nanopsycho>

On Tue, Feb 13, 2024 at 12:27:20PM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 10:39:47AM CET, michal.swiatkowski@linux.intel.com wrote:
> >On Tue, Feb 13, 2024 at 09:55:20AM +0100, Jiri Pirko wrote:
> >> Tue, Feb 13, 2024 at 08:27:13AM CET, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> [...]
> 
> 
> >
> >> 
> >> >+}
> >> >+
> >> >+/**
> >> >+ * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
> >> >+ * @dyn_port: dynamic port instance to deallocate
> >> >+ *
> >> >+ * Free resources associated with a dynamically added devlink port. Will
> >> >+ * deactivate the port if its currently active.
> >> >+ */
> >> >+static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
> >> >+{
> >> >+	struct devlink_port *devlink_port = &dyn_port->devlink_port;
> >> >+	struct ice_pf *pf = dyn_port->pf;
> >> >+
> >> >+	if (dyn_port->active)
> >> >+		ice_deactivate_dynamic_port(dyn_port);
> >> >+
> >> >+	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF)
> >> 
> >> I don't understand how this check could be false. Remove it.
> >>
> >Yeah, will remove
> >
> >> 
> >> >+		xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
> >> >+
> >> >+	devl_port_unregister(devlink_port);
> >> >+	ice_vsi_free(dyn_port->vsi);
> >> >+	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
> >> >+	kfree(dyn_port);
> >> >+}
> >> >+
> >> >+/**
> >> >+ * ice_dealloc_all_dynamic_ports - Deallocate all dynamic devlink ports
> >> >+ * @pf: pointer to the pf structure
> >> >+ */
> >> >+void ice_dealloc_all_dynamic_ports(struct ice_pf *pf)
> >> >+{
> >> >+	struct devlink *devlink = priv_to_devlink(pf);
> >> >+	struct ice_dynamic_port *dyn_port;
> >> >+	unsigned long index;
> >> >+
> >> >+	devl_lock(devlink);
> >> >+	xa_for_each(&pf->dyn_ports, index, dyn_port)
> >> >+		ice_dealloc_dynamic_port(dyn_port);
> >> >+	devl_unlock(devlink);
> >> 
> >> Hmm, I would assume that the called should already hold the devlink
> >> instance lock when doing remove. What is stopping user from issuing
> >> port_new command here, after devl_unlock()?
> >>
> >It is only called from remove path, but I can move it upper.
> 
> I know it is called on remove path. Again, what is stopping user from
> issuing port_new after ice_dealloc_all_dynamic_ports() is called?
> 
> [...]
> 
What is a problem here? Calling port_new from user perspective will have
devlink lock, right? Do you mean that devlink lock should be taken for
whole cleanup, so from the start to the moment when devlink is
unregister? I wrote that, I will do that in next version (moving it
upper).

> 
> >> 
> >> >+	struct device *dev = ice_pf_to_dev(pf);
> >> >+	int err;
> >> >+
> >> >+	dev_dbg(dev, "%s flavour:%d index:%d pfnum:%d\n", __func__,
> >> >+		new_attr->flavour, new_attr->port_index, new_attr->pfnum);
> >> 
> >> How this message could ever help anyone?
> >>
> >Probably only developer of the code :p, will remove it
> 
> How exactly?
>
I meant this code developer, it probably was used to check if number and
indexes are correct, but now it should be removed. Like, leftover after
developing, sorry.

> [...]
> 
> 
> >> >+static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
> >> >+{
> >> >+	struct net_device *netdev;
> >> >+	struct ice_vsi *vsi = dyn_port->vsi;
> >> >+	struct ice_netdev_priv *np;
> >> >+	int err;
> >> >+
> >> >+	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
> >> >+				    vsi->alloc_rxq);
> >> >+	if (!netdev)
> >> >+		return -ENOMEM;
> >> >+
> >> >+	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
> >> >+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
> >> >+	vsi->netdev = netdev;
> >> >+	np = netdev_priv(netdev);
> >> >+	np->vsi = vsi;
> >> >+
> >> >+	ice_set_netdev_features(netdev);
> >> >+
> >> >+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> >> >+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
> >> >+			       NETDEV_XDP_ACT_RX_SG;
> >> >+
> >> >+	eth_hw_addr_set(netdev, dyn_port->hw_addr);
> >> >+	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
> >> >+	netdev->netdev_ops = &ice_sf_netdev_ops;
> >> >+	SET_NETDEV_DEVLINK_PORT(netdev, &dyn_port->devlink_port);
> >> >+
> >> >+	err = register_netdev(netdev);
> >> 
> >> It the the actual subfunction or eswitch port representor of the
> >> subfunction. Looks like the port representor. In that case. It should be
> >> created no matter if the subfunction is activated, when it it created.
> >> 
> >> If this is the actual subfunction netdev, you should not link it to
> >> devlink port here.
> >>
> >This is the actual subfunction netdev. Where in this case it should be
> >linked?
> 
> To the SF auxdev, obviously.
> 
> Here, you should have eswitch port representor netdev.
> 
Oh, ok, thanks, will link it correctly in next version.


