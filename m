Return-Path: <netdev+bounces-117175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99894CF89
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3DD1C2133E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EF19308A;
	Fri,  9 Aug 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6cuK9/h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8E19580A
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204165; cv=none; b=sPxQVzimQROzCcZln0UJ1v4NdxmTwXkHmfzgWIbK5N3sLEWubqkoEGB1cnBrhG5Td9a5x3eaUnImintZj2egKmfj8HaAaiEQCCBYEx5Pmg4KYzQdNGPnsHeaPWqa0HN7OOqFsJQ/1RE7eYermE+lr85OGwRNAkn1MyBA4Zy8I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204165; c=relaxed/simple;
	bh=xmnS/+bEGa5HNJrRE2AMGKWbjvWnKIl1fBhoIfYsQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr5L51r6C9U1HEmwPnXdAkgl4J4eZo75gJFesAdrCOYNtpUgczwy3X+RaOPX0OHM3XfEi2ytjzigRMKw+URULAk5hs3CQ1oZ9iZw1dyGUWpVhP7978S7iTOCnch7y7Ujgw/q/fQyR1p3CRmTZjKn1OvNJ8+pNwCphgyw+y8Swh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6cuK9/h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204164; x=1754740164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xmnS/+bEGa5HNJrRE2AMGKWbjvWnKIl1fBhoIfYsQJ8=;
  b=R6cuK9/hlL0rZempR+OgGMdbmSNwtX9TdxPWvFDX9yeKpx6JYT216/9J
   IFW/OjX1DU/m4xKObHQVubeYUM7NWhB0E3TJlHktXkch/gtRueTMRd1jm
   sBJCCeIsm+0PyyPlfo7iFxVJZBJc5syDuK4V3i0D8EGS5QHDMCFmiJdIW
   t9GroBsW3cnWZUKLK1h7jrM16zwtCB2DSmYopj7ARg9ruLJt0078DMeTz
   I/gqH2kt1JEJZzuq2/P8idPn2CvKurhSCW9wvcjOfntnka0HUGmE6gOV1
   TxXOaGSjY15Vz0GRpRqdq0QCl7A4kNzwNwkWV4Eq1IBzWbGC+kxeAUsF/
   A==;
X-CSE-ConnectionGUID: mfEfg52jSbOmFcZU/AIPgQ==
X-CSE-MsgGUID: AvNT4NhITsqzsnAw9oV/nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21233580"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21233580"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:23 -0700
X-CSE-ConnectionGUID: yTOpaumrSAKbZjPMiZUeVA==
X-CSE-MsgGUID: icIlzHnaSsWhlEdxun95pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58262790"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:19 -0700
Date: Fri, 9 Aug 2024 13:47:38 +0200
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
Message-ID: <ZrYB2kEieNCIuof1@mev-dev.igk.intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-4-anthony.l.nguyen@intel.com>
 <ZrX6jM6yedDNYfNv@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX6jM6yedDNYfNv@nanopsycho.orion>

On Fri, Aug 09, 2024 at 01:16:28PM +0200, Jiri Pirko wrote:
> Thu, Aug 08, 2024 at 07:30:49PM CEST, anthony.l.nguyen@intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> 
> [...]
> 
> >+static int
> >+ice_devlink_port_new_check_attr(struct ice_pf *pf,
> >+				const struct devlink_port_new_attrs *new_attr,
> >+				struct netlink_ext_ack *extack)
> >+{
> >+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
> >+		return -EOPNOTSUPP;
> >+	}
> >+
> >+	if (new_attr->controller_valid) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
> >+		return -EOPNOTSUPP;
> >+	}
> >+
> >+	if (new_attr->port_index_valid) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");
> 
> Nope, it is actually valid, but your driver does not support that.
> Please fix the message.
>

Ok

> 
> >+		return -EOPNOTSUPP;
> >+	}
> >+
> >+	if (new_attr->pfnum != pf->hw.bus.func) {
> 
> hw.bus.func, hmm. How about if you pass-through the PF to VM, can't the
> func be anything? Will this still make sense? I don't think so. If you
> get the PF number like this in the rest of the driver, you need to fix
> this.
>

I can change it to our internal value. I wonder if it will be better. If
I understand correctly, now:
PF0 - xx.xx.0; PF1 - xx.xx.1

I am doing pass-through PF1
PF0 (on host) - xx.xx.0

PF1 (on VM) - xx.xx.0 (there is one PF on VM, so for me it is more
intuitive to have func 0)

after I change:
PF0 - xx.xx.0; PF1 - xx.xx.1

pass-through PF1
PF0 (on host) - xx.xx.0

PF1 (on VM) - xx.xx.0, but user will have to use 1 as pf num

Correct me if I am wrong.

> 
> 
> >+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
> >+		return -EOPNOTSUPP;
> >+	}
> >+
> >+	return 0;
> >+}
> 
> [...]
> 
> 
> >+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
> >+{
> >+	struct devlink_port_attrs attrs = {};
> >+	struct devlink_port *devlink_port;
> >+	struct devlink *devlink;
> >+	struct ice_vsi *vsi;
> >+	struct ice_pf *pf;
> >+
> >+	vsi = dyn_port->vsi;
> >+	pf = dyn_port->pf;
> >+
> >+	devlink_port = &dyn_port->devlink_port;
> >+
> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
> >+	attrs.pci_sf.pf = pf->hw.bus.func;
> 
> Same here.
> 
> 
> >+	attrs.pci_sf.sf = dyn_port->sfnum;
> >+
> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >+	devlink = priv_to_devlink(pf);
> >+
> >+	return devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> >+					   &ice_devlink_port_sf_ops);
> >+}
> >+
> 
> [...]

