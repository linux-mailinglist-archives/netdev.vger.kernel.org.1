Return-Path: <netdev+bounces-125466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3396D2BE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA34281BE3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DA194ACB;
	Thu,  5 Sep 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFGaBO9C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFB19258A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527184; cv=none; b=T4+0jkpdbPMMMXaEymUprwDS5gOz1nmdToe6/3xxpNgqa4EQCH9IalIbrMDVxR4YUuyg/+Q5srzUGccqXLidgdmsHcSvNwcTnpNGrEN1kwVhwhZ8L01QDWxAlg1aKJG8+LWMA3CVeu0zgCKOeDUi35pzoSmMkT9yzJqxO7M5A04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527184; c=relaxed/simple;
	bh=vVOP1mOoLSS9Isujf+VH28F2S18jITj6Qsni3mfL47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChZjTjb+356rW5pCpIbDORPHPWLFa9+fnTA8byikKiNv9XiK7I978zyDqvtH6n9BFcJrDMPrLfq7+IFlWJw5XFFfXz/kimFKkhwXWsg01roOVr/2Nj30SMvhyD81z7rUdKFjZw/+8fOcjDSfL42yLkMU46AvkJAL7ZSIjuyJF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFGaBO9C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725527183; x=1757063183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVOP1mOoLSS9Isujf+VH28F2S18jITj6Qsni3mfL47c=;
  b=RFGaBO9CeAqvEQl98BJI2exw2tJdUTjSky2S8+NwVjjqq1UmY9pe02ps
   oldlSH2N69JAekk0RK4QO53B+x8HZ23m4OSJOSdI8m6RIWDLWOwhjJv1P
   U4CR5TVnqo8GGj3JPPkiS3lAwyzHAGwB6YyFo78SDHUhUYffHaeaWMOj+
   q9oOUhnGUBZXJnfCaFqlsAeZZT88Ab65KZYfIARvJ3EFgUqleeyKelqlf
   XmonRDekl8GelN0AAvTqO2xeRZhIlsYT4uWujSGMFPLlqZ4xvWDc5DT9a
   o7+auGetYwRuzqV1U5FiKiAVNvt6Lf8U5JrmcxRd+nQwIpqIckio1S7xV
   g==;
X-CSE-ConnectionGUID: 0hiQrBSURPmfWD/uagPmsg==
X-CSE-MsgGUID: XfvKt46STQy/ZTwjtDxOBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27983982"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="27983982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 02:06:22 -0700
X-CSE-ConnectionGUID: Q69MFm30TcOPGV6p3jty6A==
X-CSE-MsgGUID: +jx0jdAISW6uGg0MhVMPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70481386"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 02:06:14 -0700
Date: Thu, 5 Sep 2024 11:04:17 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [iwl-net v1] iavf: allow changing VLAN state
 without calling PF
Message-ID: <Ztl0ES4k0dyI7Qio@mev-dev.igk.intel.com>
References: <20240904120052.24561-1-michal.swiatkowski@linux.intel.com>
 <65f17b12-860e-4cd0-a996-459fee71b4f8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f17b12-860e-4cd0-a996-459fee71b4f8@intel.com>

On Thu, Sep 05, 2024 at 08:19:58AM +0200, Przemek Kitszel wrote:
> On 9/4/24 14:00, Michal Swiatkowski wrote:
> > First case:
> 
> [...]
> 
> > Second case:
> 
> [...]
> 
> > With fix for previous case we end up with no VLAN filters in hardware.
> > We have to remove VLAN filters if the state is IAVF_VLAN_ADD and delete
> > VLAN was called. It is save as IAVF_VLAN_ADD means that virtchnl message
> > wasn't sent yet.
> 
> I'm fine with combining the two cases into one commit as that is related
> 
> > 
> > Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/iavf/iavf_main.c | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > @@ -793,8 +798,17 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
> >   	f = iavf_find_vlan(adapter, vlan);
> >   	if (f) {
> > -		f->state = IAVF_VLAN_REMOVE;
> 
> you forgot to put this line in else case below
> 

Oh, sorry, thanks for finding that. Will send v2.

> > -		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
> > +		/* IAVF_ADD_VLAN means that VLAN wasn't even added yet.
> > +		 * Remove it from the list.
> > +		 */
> > +		if (f->state == IAVF_VLAN_ADD) {
> > +			list_del(&f->list);
> > +			kfree(f);
> > +			adapter->num_vlan_filters--;
> > +		} else {
> > +			iavf_schedule_aq_request(adapter,
> > +						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
> > +		}
> >   	}
> >   	spin_unlock_bh(&adapter->mac_vlan_list_lock);
> 

