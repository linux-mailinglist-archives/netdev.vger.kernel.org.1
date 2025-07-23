Return-Path: <netdev+bounces-209199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D61B0E9CB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D5F3A40A3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F51C84C7;
	Wed, 23 Jul 2025 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEBi6hqY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D3151991
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246119; cv=none; b=CygvpV0BP2c9s4YBcT67WgIlGBEG59IEsIflK7z7mpUww9ylbxmH7YXNgk0RxDi3BU14+NtFW3fmecxZAiTNjoI/lNhPwEL91WOx6ktMQ+0GAAMhU/irEHNOKuyL3RcHgUOWdLK1/dV2nsyyRqSBKJrU1SegNo+kyF0gWQa4r/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246119; c=relaxed/simple;
	bh=qNjmRPPIJN5Zjpha05dmWoSkyDjdBWOVgWeDdaqiQpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy3NRRpo8UaLojTGHgRnFjW2MNXtwTOXxIdfOMAVoYZEPZbvggC8omTbGwbqILRA1oy3A5VhRwYPo4tKI+xiQbzVSjQCys6SyKYRu74Wn0qL4ZHYra+CsEz0qXMsTaoF3hRIzuALQwre7Evw382xHbCdH9iPvVgX5rf4xzruLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEBi6hqY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753246118; x=1784782118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNjmRPPIJN5Zjpha05dmWoSkyDjdBWOVgWeDdaqiQpY=;
  b=FEBi6hqYqDU/qSwL4N+31umbaH3++EJOWNhxlkh/GwSr1WHncy7bgkRB
   RdxjC/+LX/WQzJSSjAp2tQnvhOAkvU60JHXcsblZ06IPaAjuH6sl+qthR
   aCWJq7TlQSCVxkEqfTP4UKSqhty0CZPV7Gt78sLlOttLhG2IWVMoqZlo7
   Ks23Pqmy/MDEfDujTFee1olI+DC9qN3EwsQTNZrwlGbgKjpaNLeGiSOqP
   SXusNNAsADVhIuTjp8mfiGXKRV91pQAJbfHCH+s2lc9idZR46yxqlxYyu
   osbc/sWhxL1cBwrLikzB35Nm8h3c+H+2aywzBhaiDviFywS1mLKjDiFS/
   g==;
X-CSE-ConnectionGUID: Alc+jd6DTPGEXXyhOAOrFg==
X-CSE-MsgGUID: oSrNSBepQlersAZnSK1L/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54613674"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="54613674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 21:48:36 -0700
X-CSE-ConnectionGUID: sNJc5pEmTV238Zug66iE+w==
X-CSE-MsgGUID: 5xsNh3H2RwSNGd3ttfay0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164973226"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 21:48:34 -0700
Date: Wed, 23 Jul 2025 06:47:25 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com
Subject: Re: [PATCH iwl-next v1 09/15] ice: drop driver specific structure
 from fwlog code
Message-ID: <aIBpMBCIab9WMUvp@mev-dev.igk.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <20250722104600.10141-10-michal.swiatkowski@linux.intel.com>
 <20250722145428.GM2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722145428.GM2459@horms.kernel.org>

On Tue, Jul 22, 2025 at 03:54:28PM +0100, Simon Horman wrote:
> On Tue, Jul 22, 2025 at 12:45:54PM +0200, Michal Swiatkowski wrote:
> > In debugfs pass ice_fwlog structure instead of ice_pf.
> > 
> > The debgufs dirs specific for fwlog can be stored in fwlog structure.
> > 
> > Add debugfs entry point to fwlog api.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> 
> ...
> 
> > @@ -580,9 +569,10 @@ static const struct file_operations ice_debugfs_data_fops = {
> >  
> >  /**
> >   * ice_debugfs_fwlog_init - setup the debugfs directory
> > - * @pf: the ice that is starting up
> > + * @fwlog: pointer to the fwlog structure
> > + * @root: debugfs root entry on which fwlog director will be registered
> >   */
> > -void ice_debugfs_fwlog_init(struct ice_pf *pf)
> > +void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root)
> >  {
> >  	struct dentry *fw_modules_dir;
> >  	struct dentry **fw_modules;
> > @@ -598,41 +588,39 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
> >  
> >  	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
> >  						      pf->ice_debugfs_pf);
> 
> pf no longer exists in this context.
> 

Right, sorry, I missed that. I will build check each commit before
sending v2.

Thanks

> > -	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
> > +	if (IS_ERR(fwlog->debugfs))
> >  		goto err_create_module_files;
> >  
> > -	fw_modules_dir = debugfs_create_dir("modules",
> > -					    pf->ice_debugfs_pf_fwlog);
> > +	fw_modules_dir = debugfs_create_dir("modules", fwlog->debugfs);
> >  	if (IS_ERR(fw_modules_dir))
> >  		goto err_create_module_files;
> 
> ...

