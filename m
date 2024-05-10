Return-Path: <netdev+bounces-95339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0918C1EEC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1011F2215E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0D15F302;
	Fri, 10 May 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aek+N2dk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AF15EFB4
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325689; cv=none; b=GnVQwd0WnTgrbN887m2rMMAlRwnyY8X8qo7HhaxwygzRLY3TO04+YI3Jcf6MjhmJ85OsnzOg7TsMJsQ/FXWfCmzZeJkOI7leP28EZuVZd4S8T33jGaovdOYBwnCIkqKa0IwJT7zFVnk3tbGxgRZ/VzEqaX/2KE23bRNgj18EcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325689; c=relaxed/simple;
	bh=GStYpJUsqp/2cKsgNBZ5G3Yc4IcXr2kIMIWZMjevH+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2nP1ZAERmG+DnFO1z6pGfEnPFwIIz03kQcT8DpWjZMO7wzWIbUKyYb6pByIOsQtlLL8XyQTtFcH+yDOh/QmuvxMJ2Eb3s8IiSC/GwrnJIIJn3rpDWzUa1+Qi7D9xvEdOF4BoKlPg0hF+ZLgvPbJEsYU1a5PdwLFzOQDzRcHsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aek+N2dk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325688; x=1746861688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GStYpJUsqp/2cKsgNBZ5G3Yc4IcXr2kIMIWZMjevH+4=;
  b=aek+N2dkWInPHTcMr8OXapNjkFoGkBQnCvQNyYFQXwWABghIwDUVCcZU
   kVTUX70ZzBqgPCxVB1eKdsE84aWifkhekb/+dLiO3WTM/ljV0LoDkdslu
   dhsB1qHt8yWRz4WVrlV3bnKTAB6n6oDcYutSfFMKef3xYF683OEAHEDut
   2z4oFb0FA89vGRfo/a/akuxEQO6p+tI2dk1r3HEHnkpGkToZkPH0iH+r4
   FfiSRRfUHoHYOVhxB+abVMhoi7v9Ktvdnfp7Zr0u37n7KzlHOOJ+M/qDE
   psDj0szOOVjf7iDk5GsarFm6sWU+MxZC1sQfxo0HrvmVfoqWwe79z+YZT
   g==;
X-CSE-ConnectionGUID: 34XcVHOWQymHKbrxCFNeQg==
X-CSE-MsgGUID: kp0RtpllSj6wLwNEzVN7Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15100811"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15100811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:21:27 -0700
X-CSE-ConnectionGUID: NGjGMmOzRKGiDzTBH8sdAA==
X-CSE-MsgGUID: iRd8PrDdQiumgMtOOS1CwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34381402"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:21:24 -0700
Date: Fri, 10 May 2024 09:20:51 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 06/14] ice: base subfunction aux driver
Message-ID: <Zj3K0+JB55UFZYXF@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>
 <Zjyv8xAEDhtzXAIx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjyv8xAEDhtzXAIx@nanopsycho.orion>

On Thu, May 09, 2024 at 01:13:55PM +0200, Jiri Pirko wrote:
> Tue, May 07, 2024 at 01:45:07PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Implement subfunction driver. It is probe when subfunction port is
> >activated.
> >
> >VSI is already created. During the probe VSI is being configured.
> >MAC unicast and broadcast filter is added to allow traffic to pass.
> >
> >Store subfunction pointer in VSI struct. The same is done for VF
> >pointer. Make union of subfunction and VF pointer as only one of them
> >can be set with one VSI.
> >
> >Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Perhaps it would make things clearer for reviewer to have all patches
> related to sf auxdev/devlink/netdev at the end of the patchset, after
> activation patch. Not sure why you want to mix it here.

I need this code to use it in port representor implementation. You
suggested in previous review to move activation at the end [1].

[1] https://lore.kernel.org/netdev/Zhje0mQgQTMXwICb@nanopsycho/

