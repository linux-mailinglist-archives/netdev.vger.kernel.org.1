Return-Path: <netdev+bounces-71250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFF852D23
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED981C266E8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C5224D5;
	Tue, 13 Feb 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGI21N5L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6C33CD1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818113; cv=none; b=kqFPHfyZF4b2x5gdatoL8oqe1lRyIfD4K1AxVs4r2Oon+ZyRmy+NX1VP70jhylxjrLkLZDj8Zkj4M7Thdl4EJndbKWzG/UlM+A9IMj59/s1snD1ELV8L8IpG/qcrHlo8hEnQPng8PcYbz3fZ2lGRIP9tgaGCgRuF/Cga3g0Nh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818113; c=relaxed/simple;
	bh=bweGwSW7+73NAdL702iBH2wxcyPFz80FLUKLmctgKLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaKIZ2HJffQ0FQwQ0UhxxUVAkOXN2QrHqCEGq/csfsNktMMhickXQReshDiFFK1tZDrMuAYD+M/ssLmx6HgcbujL30eyhzZJxZBiR1Zfe2ClwJZkc6f1df2/Zgx/W39bVisTIbB4JlB7Yde1NMuFumH2Cpt/v4j+ST51yf/VACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGI21N5L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707818112; x=1739354112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bweGwSW7+73NAdL702iBH2wxcyPFz80FLUKLmctgKLc=;
  b=IGI21N5LjLGFMUusY720hEgEhb0aUzpCSbbg2dzh7GZZjnl7iVq/mi+U
   CbtbOCcy9mc5BT2tGRihAtPHkc/W53qNW/nT3Qywua5kep1HpxLv13T2l
   M4s3IeN51cth/cqLOYx00qdVYYXKxhxQwEITa0d/3020EiwCsCenXoRoh
   gpBQUou2BymLB3qeyyXAx5RW3GT2cTzFUtzL74w+f5RD9j9/xTGTTQWzM
   TcgDce1krRd8/YDGrsiGNKzz2aYjwFGAE+anruEaYI1WoupxJSvog+lHg
   aBlasBXBpx4HB1ezdwLcBIgUdi03iJyvGjqg2mB/bJI76Y3z3T2nWI+c4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13210523"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="13210523"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="33646766"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:55:08 -0800
Date: Tue, 13 Feb 2024 10:55:05 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com
Subject: Re: [iwl-next v1 10/15] ice: create port representor for SF
Message-ID: <Zcs8eSp0R98Ejrce@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-11-michal.swiatkowski@linux.intel.com>
 <ZcsvpByD9n9BR-6D@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcsvpByD9n9BR-6D@nanopsycho>

On Tue, Feb 13, 2024 at 10:00:20AM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 08:27:19AM CET, michal.swiatkowski@linux.intel.com wrote:
> >Store subfunction and VF pointer in port representor structure as an
> >union. Add port representor type to distinguish between each of them.
> >
> >Keep the same flow of port representor creation, but instead of general
> >attach function create helpers for VF and subfunction attach function.
> >
> >Type of port representor can be also known based on VSI type, but it
> >is more clean to have it directly saved in port representor structure.
> >
> >Create port representor when subfunction port is activated.
> >
> >Add devlink lock for whole VF port representor creationi and destruction.
> >It is done to be symmetric with what happens in case of SF port
> >representor. SF port representor is always added or removed with devlink
> >lock taken. Doing the same with VF port representor simplify logic.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../intel/ice/devlink/ice_devlink_port.c      |   4 +-
> > .../intel/ice/devlink/ice_devlink_port.h      |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  82 ++++++++++---
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 110 +++++++++++-------
> > drivers/net/ethernet/intel/ice/ice_repr.h     |  21 +++-
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   |  11 ++
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> > drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> > 10 files changed, 184 insertions(+), 77 deletions(-)
> 
> Again, please split.

Ok

