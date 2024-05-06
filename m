Return-Path: <netdev+bounces-93657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E478BCA0D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E808282FC6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D81420C9;
	Mon,  6 May 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hsj2PDJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976C1420B9
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985493; cv=none; b=eW/lqU0uzGGgpC7Clw0Xow3Ck/wQVFoyNUCeVYrzs3kc86xSCsnq0C8Nmsv/+UrL8NhFcYKjqrj0yeA7CLVpWQzkGM03imu5TwhtcGWN270LcIiHwehcprqfKA9lOKz4Bk/xYyr2yxBSw5jeCANlzynGKQrTA7ab1Pt9zIPpOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985493; c=relaxed/simple;
	bh=n077hml70tQrzUxJl7tu8jfzK0VqIgZ/7Ew1bmK5Y+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kublFrc8zMrz8tK5AqsvJ7hMsn+pRvi6AI/qeeQSAMmUySnOIHtbOh1uf0mz+/PGXSi+2MHl6Xb8OtmiWKoGHnAIGD+ELpI46RPVu2r7PeT2kYkZ8jm+ft1XUbtm3FqVsMc+8SzFFAkqal7gRUi3PybbvIYiH2CGcG7WkAEXTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hsj2PDJ4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714985492; x=1746521492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n077hml70tQrzUxJl7tu8jfzK0VqIgZ/7Ew1bmK5Y+A=;
  b=Hsj2PDJ4z1FGgp+wNnceSzkdG0P0+UTkoBGTX04zODnF85miRCb7Nhsv
   8BHATxI/Ud7IkexnU3RHn+e9x/9k0QMzkOTvtyEY9CmX8uylvUuL7HuA8
   q1tKSQekcU4FU5f0uuQLQ8SN0/QhIAKaB6Mpg4mkqin/LxvFcQfX9vDsS
   e7GYTaac7YryJibW78MWJa6+q0VqRFrq4ssuiNRO+Wb28ZhhYZqafAPtN
   Nxy+hC94aDs+uq6BPB7Fwv2gowD/FDUvlR9nWJ9E4UJxevyCLLmssmuYN
   HS6nlv5oRhR7p/e4MgCoIMsBMrN7JaeIRv6QLp6BgrYh/bK/kdGvYC5K8
   A==;
X-CSE-ConnectionGUID: GK/4xz7FSWyfWT9kiTCoXg==
X-CSE-MsgGUID: bAKseya6QyGX56zSbtRCFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="22130421"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="22130421"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:51:31 -0700
X-CSE-ConnectionGUID: EB7Wb8sjSPqQumpTj1FBDw==
X-CSE-MsgGUID: yR1fEpw9T4GvwxMk6MSwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32771649"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:51:28 -0700
Date: Mon, 6 May 2024 10:50:53 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 3/4] ice: move VSI configuration outside repr setup
Message-ID: <ZjiZ7Re63+aEtROE@mev-dev>
References: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
 <20240419171336.11617-4-michal.swiatkowski@linux.intel.com>
 <7003fe5e-4bb9-8335-6d3f-9edab0aa3570@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7003fe5e-4bb9-8335-6d3f-9edab0aa3570@intel.com>

On Wed, Apr 24, 2024 at 02:08:11PM -0700, Tony Nguyen wrote:
> 
> 
> On 4/19/2024 10:13 AM, Michal Swiatkowski wrote:
> 
> > +/**
> > + * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
> > + * @vsi: VSI structure of representee
> > + * @mac: representee MAC
> 
> Can you fix the kdoc for this?
> 
> > drivers/net/ethernet/intel/ice/ice_eswitch.c:140: warning: No description
> found for return value of 'ice_eswitch_cfg_vsi'
> 
> Thanks,
> Tony
> 

I sent v2, sorry for late response, I was OOO.

Thanks,
Michal

> > + */
> > +int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> > +{
> > +	int err;
> > +

