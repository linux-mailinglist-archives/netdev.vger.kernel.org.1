Return-Path: <netdev+bounces-95340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B18C1EF2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785F11F2235A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B915ECCB;
	Fri, 10 May 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYnjEFZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B941311B9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325924; cv=none; b=neShPloUcvGzEhFk77N6kAfUDFVdWgwtUCyw2Eg3n+W/CATZXof5ejFO6B4S7rNIv9Nd06Ss485QO1/icL3B0GixFJ17v89Hq81fJcKfopjaBnmMDjG5JjizET+IOhCcXGLvD0pEXgYon8wpfcTwkUN/7byVFm5MXZpnlmHKD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325924; c=relaxed/simple;
	bh=8JsD0R3pbIpzm+oWXnmTscN5nNN6bxalnHmyIHoPqNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrQDlp+7ZgI3p6fitkiPuNqmhZvKQ2lq5Q4eXLQ36d4s2yaIypAfYWMVrXGAIgsFQQyQxlrxBK3oldErd5WTNY+iYI3Z6A7C5B9TiVYCIkxpnud9w7EiZ8QEtJ8QbVGgk/UhjOkDB4FDWyUm0bO9nUh+TUAVapeTkXyrB2ZA9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYnjEFZQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325923; x=1746861923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8JsD0R3pbIpzm+oWXnmTscN5nNN6bxalnHmyIHoPqNw=;
  b=NYnjEFZQNM6ct9JNuxU5y1DyroBEZfZ8JxgPTxAJYYdm9H9xJjMenYLD
   GLEHsMPbIPeD8GmqF9WpKHTgMAgNpcLB2qyz4Eq8zwDtZ2QTIacK/1mCR
   sW/z7o/GT1hKLqK6vKLVPAjxXQ+RdNoZknyWpAryECCux4AI087tRWPN3
   QdxBYtmekRrgZag1ca5yxxKkPh4yDygtX7YEtU/+AtQEwS5wxFMIRekUV
   VVunk1y3lQUcXUz7h/q5SpeGTGGpdbWs5hvbtOAGclh03MHvEETtU5QQW
   6z4tXpDjHQ0acBTr0qGiKBnehUC8JDeoZ1nsiIGfBOzXmPkQHpxGqk9JV
   A==;
X-CSE-ConnectionGUID: Jd1W/A/ITvaH2nYo2c4R+Q==
X-CSE-MsgGUID: +XKapgGcSVmCuWr96e6J4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21888846"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21888846"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:25:22 -0700
X-CSE-ConnectionGUID: L7p5aa59S2+ma1cJnenS5w==
X-CSE-MsgGUID: oovQby8BQ+ybk3mjWpwAow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29462093"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:25:19 -0700
Date: Fri, 10 May 2024 09:24:48 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 00/14] ice: support devlink subfunction
Message-ID: <Zj3LwDMbktRXk0QX@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <ZjyxBcVZNbWioRP0@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjyxBcVZNbWioRP0@nanopsycho.orion>

On Thu, May 09, 2024 at 01:18:29PM +0200, Jiri Pirko wrote:
> Tue, May 07, 2024 at 01:45:01PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >Hi,
> >
> >Currently ice driver does not allow creating more than one networking
> >device per physical function. The only way to have more hardware backed
> >netdev is to use SR-IOV.
> >
> >Following patchset adds support for devlink port API. For each new
> >pcisf type port, driver allocates new VSI, configures all resources
> >needed, including dynamically MSIX vectors, program rules and registers
> >new netdev.
> >
> >This series supports only one Tx/Rx queue pair per subfunction.
> >
> >Example commands:
> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> >devlink port function set pci/0000:31:00.1/1 state active
> >devlink port function del pci/0000:31:00.1/1
> >
> >Make the port representor and eswitch code generic to support
> >subfunction representor type.
> >
> >VSI configuration is slightly different between VF and SF. It needs to
> >be reflected in the code.
> >
> >Most recent previous patchset (not containing port representor for SF
> >support). [1]
> >
> >[1] https://lore.kernel.org/netdev/20240417142028.2171-1-michal.swiatkowski@linux.intel.com/
> >
> 
> 
> I don't understand howcome the patchset is v1, yet there are patches
> that came through multiple iterations alread. Changelog is missing
> completely :/
> 

What is wrong here? There is a link to previous patchset with whole
changlog and links to previous ones. I didn't add changlog here as it is
new patchset (partialy the same as from [1], because of that I added a
link). I can add the changlog from [1] if you want, but for me it can be
missleading.

> 
> >Michal Swiatkowski (7):
> >  ice: treat subfunction VSI the same as PF VSI
> >  ice: create port representor for SF
> >  ice: don't set target VSI for subfunction
> >  ice: check if SF is ready in ethtool ops
> >  ice: netdevice ops for SF representor
> >  ice: support subfunction devlink Tx topology
> >  ice: basic support for VLAN in subfunctions
> >
> >Piotr Raczynski (7):
> >  ice: add new VSI type for subfunctions
> >  ice: export ice ndo_ops functions
> >  ice: add basic devlink subfunctions support
> >  ice: allocate devlink for subfunction
> >  ice: base subfunction aux driver
> >  ice: implement netdev for subfunction
> >  ice: allow to activate and deactivate subfunction
> >
> > drivers/net/ethernet/intel/ice/Makefile       |   2 +
> > .../net/ethernet/intel/ice/devlink/devlink.c  |  48 ++
> > .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 516 ++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  43 ++
> > drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> > drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> > drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 ++-
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> > drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> > drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> > drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> > drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++++--
> > drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 +++++++++++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> > drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> > drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> > .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> > drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> > 26 files changed, 1362 insertions(+), 138 deletions(-)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
> >
> >-- 
> >2.42.0
> >
> >

