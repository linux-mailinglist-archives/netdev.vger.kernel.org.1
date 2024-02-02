Return-Path: <netdev+bounces-68362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD88846B2D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3B51C269AC
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D05FF10;
	Fri,  2 Feb 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DI5RaeN8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E65FF0C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863708; cv=none; b=eMhbAK8eILF93CJUZp6TgpeCsB914N8wmxHSzTC3OpYtQRq4LPXuS+XvHgvhIYzMo1XW0VSzem0HQEizE1PixyJLFdMtNeaJoTE4UQPB7h5IlTsXVTeKnNssvR63r68pTDeE1nax8UPjKxNOPNPpV6UQcV70JV8Gvr8KaAcZWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863708; c=relaxed/simple;
	bh=giPRyOV5I52f7S0E9p8//2PldUVaMgBAQHbHgx/8CUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaZrlPjLJq5EVeZZlSlij0OZE5L9Ty+gZNBooJdOc7Cl4sKlunMBCKRz1O7hg55O4Hvzbl0baOx5xQUJBWVu0ZrSNl6+GuBOYP2VxDqTa1TUdrfiFknXv3+rYrwRVQxUYQ0O0huCtB/weKDIEIufzqmv+5PscQGX979bw7qP5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DI5RaeN8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863707; x=1738399707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=giPRyOV5I52f7S0E9p8//2PldUVaMgBAQHbHgx/8CUk=;
  b=DI5RaeN8nwoEvVK9cFqSfdK2Jh8p02ybDXaFU93LxmqVvI+R1eKtrM69
   j7uojQNFSq30sNHuZJ2DPu7QG9yFg0hfjJ181iN9Nkbsx9oo2nV5HXA1Y
   qfuNik7aEM9io4OIQlnGrEZROZ+Y6vsRVtfz69DpsvR+51hGz3mOymLDt
   jrwBl2cLWkq+zuifvVKBvDOUtHQUkYFe2+QHP6ETfLzKHSgHbopnQlN2O
   QDP9poc9cPuTWRemISHcPLuhaTxt2uFc8so48XdfGnHHch8BLRQAI/nr9
   rIVW/fWcWFlYe2Myti5BsVxOs1SGp4nqdkutNMFLpW9DRV+1HkwukKHMi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="25565046"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="25565046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="30843608"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:48:25 -0800
Date: Fri, 2 Feb 2024 09:48:13 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: William Tu <witu@nvidia.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
	jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <ZbysTRVYtih/1fOc@mev-dev>
References: <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <6bea046d-326e-4f32-b6cb-dd92811b5fcb@intel.com>
 <82c97129-5d87-435e-b0f0-863733e16633@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82c97129-5d87-435e-b0f0-863733e16633@nvidia.com>

On Thu, Feb 01, 2024 at 06:00:54AM -0800, William Tu wrote:
> 
> On 1/31/24 6:23 PM, Samudrala, Sridhar wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 1/31/2024 5:17 PM, Jakub Kicinski wrote:
> > > On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
> > > > > I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt,
> > > > > ice and nfp
> > > > > all do buffer sharing. You're saying you mux Tx queues but not Rx
> > > > > queues? Or I need to actually read the code instead of grepping? :)
> > > > 
> > > > I guess bnxt, ice, nfp are doing tx buffer sharing?
> > > 
> > > I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
> > > I'm 99.9% sure nfp does.
> > 
> > In ice, all the VF representor netdevs share a VSI(TX/RX queues). UL/PF
> > netdev has its own VSI and TX/RX queues. But there is patch from Michal
> > under review that is going to simplify the design with a single VSI and
> > all the VF representor netdevs and UL/PF netdev will be sharing the
> > TX/RX queues in switchdev mode.
> > 
> Thank you!
> 
> Reading the ice code, ice_eswitch_remap_rings_to_vectors(), it is setting up
> tx/rx rings for each reps.
> 
> "Each port representor will have dedicated 1 Tx/Rx ring pair, so number of
> rings pair is equal to
>  number of VFs."
> 
> So after Michal's patch, representors will share TX/RX queues of uplink-pf?
> 
> 

Yeah, right, we though about solution like in mlx5, but we can easily
get queues shortage in ice. We need to allow representor to share the
queues. The easiest solution was to move to sharing queues with PF like
(I think so) nfp and few other vendors do.

> > Does mlx5 has separate TX/RX queues for each of its representor netdevs?
> > 
> Yes, in mlx5e_rep_open calls mlx5e_open_locked, which will create TX/RX
> queues like typical mlx5 device.
> 
> Each representor can set it TX/RX queues by using ethtool -L
>

I am a little out of context here. Do you allow also sharing queues
between representors? API for sharing descriptors sounds great, but in
ice we also have queues shortage, because of that we want to use PF
queues instead.

> > > It'd be great if you could do the due diligence rather than guessing
> > > given that you're proposing uAPI extension :(
> > > 
> Working on it!
> 
> Thanks
> 
> William
> 
>

Thaks,
Michal

