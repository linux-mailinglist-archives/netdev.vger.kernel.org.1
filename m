Return-Path: <netdev+bounces-117573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953294E5BF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F302813E4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB4139CFE;
	Mon, 12 Aug 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awR0zDrv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4133C7
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436763; cv=none; b=s7W2rFTDbpFjYtuIA9vzoMv/gpDUMgkErFmfbdNERbYOVbfWAcBP6/7NDPyfI+edeLd2G4lXijfOsw9Y0htFqp0SZnuIvqDoT0G+x+2I2qMcbrO8qTNNI4d5lsJWFhek75UXrTOdoo7o/Iw1X2LE+S97zgEZHcz9oVULDTF/2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436763; c=relaxed/simple;
	bh=QUUBTfC2rLMlX5oL662VRyGueELMcp7FamWsBc8dT9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euPnWdj4d8xVJIANv/uBvrIxELbAIjtbUalJjfUbaKVcWcH7RtaMkmmVa8V5NF7SkZ6acc4Hn0MLHbCKmPnsBpShCwNRL0VVgRgCF7jfWukTCsEYrpNmBCl3K09uPKhBfZrVy6SB60u6hUkoNCx2l5KBp1AdPu3avpKXWTjjsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awR0zDrv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723436762; x=1754972762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUUBTfC2rLMlX5oL662VRyGueELMcp7FamWsBc8dT9o=;
  b=awR0zDrvHLy8Go30cKW4qye6RmrTgKCoHCzg3tV33FGegfqUw5FA3cIv
   X3akcSWpnisqVUYgpYVugZ+0trNJ2gjxdCGGlu0bEktiIugGWNC7+/54E
   CSSOTxmsjsVFM+K4xdl+MgqvTAi6hVQbML5jTUw4uSSh8OPmJpQQfleE5
   cQbjhgXuxaWDTbtcsaqa3Ea2tGepLiA/NCftpLmd3djXtj/El8UNIwdTF
   BoqCvt3clPOsps+7lxQgNgpuOKn0q7orY2wjauf9bhc4OGI9HIoKJ1Wcl
   y+nsBpyOkXg2jdqBw2LcRBF8SA4DNAwitMQmrBQohUOJVgq3WN2hS0/we
   g==;
X-CSE-ConnectionGUID: 5gPWWsstQdK8S5qOAmmF3g==
X-CSE-MsgGUID: zUGurMYBRzWnO6Gz6uFfxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21669282"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21669282"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 21:25:58 -0700
X-CSE-ConnectionGUID: 5wOQy+EjQhm2wXmCxFMCwg==
X-CSE-MsgGUID: Tv6SiUrLSnSThm53bFnc5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58034622"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 21:25:54 -0700
Date: Mon, 12 Aug 2024 06:24:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Piotr Raczynski <piotr.raczynski@intel.com>,
	jiri@nvidia.com, shayd@nvidia.com, wojciech.drewek@intel.com,
	horms@kernel.org, sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com, kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com, pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <ZrmObGTwIw4cDJ7v@mev-dev.igk.intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-4-anthony.l.nguyen@intel.com>
 <ZrX6jM6yedDNYfNv@nanopsycho.orion>
 <ZrYB2kEieNCIuof1@mev-dev.igk.intel.com>
 <ZrcNvu6cXqQ-ybZu@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrcNvu6cXqQ-ybZu@nanopsycho.orion>

On Sat, Aug 10, 2024 at 08:50:38AM +0200, Jiri Pirko wrote:
> Fri, Aug 09, 2024 at 01:47:38PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Fri, Aug 09, 2024 at 01:16:28PM +0200, Jiri Pirko wrote:
> >> Thu, Aug 08, 2024 at 07:30:49PM CEST, anthony.l.nguyen@intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >
> >> 
> >> [...]
> >> 
> >> >+static int
> >> >+ice_devlink_port_new_check_attr(struct ice_pf *pf,
> >> >+				const struct devlink_port_new_attrs *new_attr,
> >> >+				struct netlink_ext_ack *extack)
> >> >+{
> >> >+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
> >> >+		return -EOPNOTSUPP;
> >> >+	}
> >> >+
> >> >+	if (new_attr->controller_valid) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
> >> >+		return -EOPNOTSUPP;
> >> >+	}
> >> >+
> >> >+	if (new_attr->port_index_valid) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");
> >> 
> >> Nope, it is actually valid, but your driver does not support that.
> >> Please fix the message.
> >>
> >
> >Ok
> >
> >> 
> >> >+		return -EOPNOTSUPP;
> >> >+	}
> >> >+
> >> >+	if (new_attr->pfnum != pf->hw.bus.func) {
> >> 
> >> hw.bus.func, hmm. How about if you pass-through the PF to VM, can't the
> >> func be anything? Will this still make sense? I don't think so. If you
> >> get the PF number like this in the rest of the driver, you need to fix
> >> this.
> >>
> >
> >I can change it to our internal value. I wonder if it will be better. If
> >I understand correctly, now:
> >PF0 - xx.xx.0; PF1 - xx.xx.1
> >
> >I am doing pass-through PF1
> >PF0 (on host) - xx.xx.0
> >
> >PF1 (on VM) - xx.xx.0 (there is one PF on VM, so for me it is more
> >intuitive to have func 0)
> >
> >after I change:
> >PF0 - xx.xx.0; PF1 - xx.xx.1
> >
> >pass-through PF1
> >PF0 (on host) - xx.xx.0
> >
> >PF1 (on VM) - xx.xx.0, but user will have to use 1 as pf num
> >
> >Correct me if I am wrong.
> 
> Did you try this? I mean, you can check that easily with vng:
> vng --qemu-opts="-device vfio-pci,host=5e:01.0,addr=01.04"
> 
> Then in the VM you see:
> 0000:00:01.4
> 
> Then, by your code, the pf number is 4, isn't it?
> 
> What am I missing?

I didn't know about addr parameter. I will change it to always have the
same number so.

> 
> 
> 
> >
> >> 
> >> 
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
> >> >+		return -EINVAL;
> >> >+	}
> >> >+
> >> >+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
> >> >+		return -EOPNOTSUPP;
> >> >+	}
> >> >+
> >> >+	return 0;
> >> >+}
> >> 
> >> [...]
> >> 
> >> 
> >> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
> >> >+{
> >> >+	struct devlink_port_attrs attrs = {};
> >> >+	struct devlink_port *devlink_port;
> >> >+	struct devlink *devlink;
> >> >+	struct ice_vsi *vsi;
> >> >+	struct ice_pf *pf;
> >> >+
> >> >+	vsi = dyn_port->vsi;
> >> >+	pf = dyn_port->pf;
> >> >+
> >> >+	devlink_port = &dyn_port->devlink_port;
> >> >+
> >> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
> >> >+	attrs.pci_sf.pf = pf->hw.bus.func;
> >> 
> >> Same here.
> >> 
> >> 
> >> >+	attrs.pci_sf.sf = dyn_port->sfnum;
> >> >+
> >> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >> >+	devlink = priv_to_devlink(pf);
> >> >+
> >> >+	return devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> >> >+					   &ice_devlink_port_sf_ops);
> >> >+}
> >> >+
> >> 
> >> [...]

