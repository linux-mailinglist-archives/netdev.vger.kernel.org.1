Return-Path: <netdev+bounces-183169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A9A8B40B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA03A773D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280822FF20;
	Wed, 16 Apr 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eyx+FCCg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9F218589
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792753; cv=none; b=aU2AaTsNy49YHNKJJ/60BoU6swTgwyOg5x43qetNrWdY3/6ATK20QkTVZlS5rGIhKeNLsr1qJqw6WcTF95jD7V/tC1jqYDt3WP1tubx/sz2GzV2rknOGTTnexdUx87cy5GSO05kH9Mqbb5TMQ/+csnqmkLHhiVHtl+KY6tT/t6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792753; c=relaxed/simple;
	bh=pX+6weCz14O5wsilpAD5fH7Ohv4TXG1wxvEX2Xz6Jy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVdNm86BLV2a01o1jamA2XZiOdPO4QYSa973ZDss0q2nJTlszYWp4IIbDNYMKzwaDp6dcdh3Dq8EbLpXJhjxK64nfTkVhXR0fa3y99WsgFbm8AQ8wPjDgtBdQVcAKLCjtdgfQeTTm4xfsIR+jF7NRKw+/PUUmSHOtju6zk3HJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eyx+FCCg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744792752; x=1776328752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pX+6weCz14O5wsilpAD5fH7Ohv4TXG1wxvEX2Xz6Jy0=;
  b=Eyx+FCCgQ4EVI48+ot9Yyh+m86uoUzFsDawF/0EHSws2MxkJna/TysK0
   y3SYDS+h5PymLORpJy7A9qyf7IGDtjYp81eiL8ugI1+gxOHwt16FPp8HL
   UPM6MrEW6dBaoSQkrPQmsdT9yMB1z+UZZLOup7IdVKDTjX2f/2BjqYCxL
   Qj0YC00KYvNp5z/tfNmokLRHOuLjJ0Fi1vTwXd7fgK8KvcPN7LBjHBazr
   EYrSMOktHYa7NQAfphqZP2CJseay7oIJqtiqfAN/40ZuGekB6llDYmdFH
   NHIpqKBcGTBTKuWLi3DNT6KGj0nxzzs60X3wD0AlzbWPkaI6Ple55dWTK
   w==;
X-CSE-ConnectionGUID: wa3vge1MT7Kp+WLhsN6o7w==
X-CSE-MsgGUID: yHkUTrWqSgif96w0d6vbgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56964222"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="56964222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:39:10 -0700
X-CSE-ConnectionGUID: UlmooonnRjWzijH/ukxW+Q==
X-CSE-MsgGUID: 96hi/cq+QKK9RNtdxa7bBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130334305"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:39:08 -0700
Date: Wed, 16 Apr 2025 10:38:48 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com, larysa.zaremba@intel.com
Subject: Re: [iwl-next v2 0/8] libie: commonize adminq structure
Message-ID: <Z/9smCtvgpqrE6Sb@mev-dev.igk.intel.com>
References: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
 <97602d95-8465-4e74-bbf3-6e70c7e6373f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97602d95-8465-4e74-bbf3-6e70c7e6373f@intel.com>

On Tue, Apr 15, 2025 at 03:59:55PM -0700, Tony Nguyen wrote:
> 
> 
> On 4/10/2025 3:01 AM, Michal Swiatkowski wrote:
> > Hi,
> > 
> > It is a prework to allow reusing some specific Intel code (eq. fwlog).
> > 
> > Move common *_aq_desc structure to libie header and changing
> > it in ice, ixgbe, i40e and iavf.
> > 
> > Only generic adminq commands can be easily moved to common header, as
> > rest is slightly different. Format remains the same. It will be better
> > to correctly move it when it will be needed to commonize other part of
> > the code.
> > 
> > Move *_aq_str() to new libie module (libie_adminq) and use it across
> > drivers. The functions are exactly the same in each driver. Some more
> > adminq helpers/functions can be moved to libie_adminq when needed.
> 
> This doesn't apply anymore after Dave's series [0]. Can you rebase and
> resend?

Sure, I will resend, thanks.

> 
> Thanks,
> Tony
> 
> [0] https://lore.kernel.org/intel-wired-lan/20250407191517.767433-1-david.m.ertman@intel.com/
> 
> > v1 --> v2: [1]
> >   * add short descriptions in kdoc (patch 1, 5)
> >   * handle all error types in switch to allow clean build (patch 3)
> > 
> > [1] https://lore.kernel.org/netdev/20250312062426.2544608-1-michal.swiatkowski@linux.intel.com/
> > 
> > Michal Swiatkowski (8):
> >    ice, libie: move generic adminq descriptors to lib
> >    ixgbe: use libie adminq descriptors
> >    i40e: use libie adminq descriptors
> >    iavf: use libie adminq descriptors
> >    libie: add adminq helper for converting err to str
> >    ice: use libie_aq_str
> >    iavf: use libie_aq_str
> >    i40e: use libie_aq_str
> > 
> >   drivers/net/ethernet/intel/Kconfig            |   3 +
> >   drivers/net/ethernet/intel/libie/Kconfig      |   6 +
> >   drivers/net/ethernet/intel/libie/Makefile     |   4 +
> >   drivers/net/ethernet/intel/i40e/i40e_adminq.h |  12 +-
> >   .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 155 +---
> >   .../net/ethernet/intel/i40e/i40e_prototype.h  |  15 +-
> >   drivers/net/ethernet/intel/i40e/i40e_type.h   |   6 +-
> >   drivers/net/ethernet/intel/iavf/iavf_adminq.h |  12 +-
> >   .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |  83 +-
> >   .../net/ethernet/intel/iavf/iavf_prototype.h  |   3 +-
> >   drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 +-
> >   drivers/net/ethernet/intel/ice/ice.h          |   1 -
> >   .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 269 +------
> >   drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
> >   drivers/net/ethernet/intel/ice/ice_controlq.h |   8 +-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +-
> >   .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 226 +-----
> >   include/linux/net/intel/libie/adminq.h        | 306 ++++++++
> >   drivers/net/ethernet/intel/i40e/i40e_adminq.c |  68 +-
> >   drivers/net/ethernet/intel/i40e/i40e_client.c |   7 +-
> >   drivers/net/ethernet/intel/i40e/i40e_common.c | 730 ++++++++----------
> >   drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  10 +-
> >   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   8 +-
> >   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  46 +-
> >   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  36 +-
> >   drivers/net/ethernet/intel/i40e/i40e_main.c   | 240 +++---
> >   drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  18 +-
> >   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +-
> >   drivers/net/ethernet/intel/iavf/iavf_adminq.c |  62 +-
> >   drivers/net/ethernet/intel/iavf/iavf_common.c | 110 +--
> >   drivers/net/ethernet/intel/iavf/iavf_main.c   |   5 +-
> >   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
> >   .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
> >   .../net/ethernet/intel/ice/devlink/health.c   |   6 +-
> >   drivers/net/ethernet/intel/ice/ice_common.c   | 388 +++++-----
> >   drivers/net/ethernet/intel/ice/ice_controlq.c |  53 +-
> >   drivers/net/ethernet/intel/ice/ice_dcb.c      |  36 +-
> >   drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
> >   drivers/net/ethernet/intel/ice/ice_ddp.c      |  47 +-
> >   drivers/net/ethernet/intel/ice/ice_dpll.c     |  20 +-
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +-
> >   .../net/ethernet/intel/ice/ice_fw_update.c    |  38 +-
> >   drivers/net/ethernet/intel/ice/ice_fwlog.c    |  16 +-
> >   drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
> >   drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
> >   drivers/net/ethernet/intel/ice/ice_main.c     |  63 +-
> >   drivers/net/ethernet/intel/ice/ice_nvm.c      |  38 +-
> >   drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
> >   drivers/net/ethernet/intel/ice/ice_sched.c    |  18 +-
> >   drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> >   drivers/net/ethernet/intel/ice/ice_switch.c   |  55 +-
> >   drivers/net/ethernet/intel/ice/ice_vf_mbx.c   |   6 +-
> >   drivers/net/ethernet/intel/ice/ice_virtchnl.c |   6 +-
> >   .../net/ethernet/intel/ice/ice_vlan_mode.c    |   6 +-
> >   .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  24 +-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 272 +++----
> >   .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |   4 +-
> >   drivers/net/ethernet/intel/libie/adminq.c     |  50 ++
> >   58 files changed, 1570 insertions(+), 2136 deletions(-)
> >   create mode 100644 include/linux/net/intel/libie/adminq.h
> >   create mode 100644 drivers/net/ethernet/intel/libie/adminq.c
> > 
> 

