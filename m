Return-Path: <netdev+bounces-118382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E89516FD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB61C2136D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE161422C3;
	Wed, 14 Aug 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltbScUbO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F713E8A5
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625358; cv=none; b=l9dROUqfnVSRv+yrPCBU4tW+IWex5YaxCckmtxVC3NGhHfltDczKAXJNBhSOJxnkgDCl5Cs6HHMYDLFjAX2Xc1ZdA0tLyrmEhDwns5I10sqEXlR3iVqA2If0VhxOjSf3AoKBWN/GLXCJrNQ4wEy41es0J4E8Hm46PuOu1O99JRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625358; c=relaxed/simple;
	bh=KCO2X9z/N45Mg/fEQRPw3Ls/q9XUQQi/8D/19Wy2UnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9D0uX3QSOby4J8MqTb5Jv3EfBOHv8m+PnV3Ny2gH3nneWGF1GfFlv1z42+LvzLKbNEyjy6+9piJSWmaq2d3qJ+QEFwtGyRU8OYF8w9FTlfnhxfTlG/eblHH2FtL9uDhmBFqidEvq09sUI30alsz0c20ckOBsHj6jVA+43bGtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltbScUbO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723625357; x=1755161357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCO2X9z/N45Mg/fEQRPw3Ls/q9XUQQi/8D/19Wy2UnE=;
  b=ltbScUbOQYvv+O4hO9yhMUjcG5oghOfnKfd5B3PQjr91Rou6yl7XlfrB
   dhPaEUG48qX7vgB53Kjj3vKkc3rYXQi6lp4PYv0SE5kogDgzvCO1pHxMU
   fPnepfWUOuK5QZ3619D8q0wdo0C4KVvKoJtOVKYXaBmYL2E5fzQhWk8mK
   UTtUEcnXCGKnnAGSTeXd6V0YU/96a4FcqUZdRR1qYzWAie1mkHAiBpWT1
   gaYPxthsMsOLD3cN1h4G6A3QcJg2BmowFZwFLQZuY4xl4pIjOc5Yjnmb3
   f0F35QFgfjFOVMLPiTxo0oyvAxnAHpkXWlSiceDDi4sxI/ZhUDQVf70ge
   w==;
X-CSE-ConnectionGUID: XgWqu/58R5GEbTY4JEyHhg==
X-CSE-MsgGUID: g87+x1jcRUSV6Oxsr75IWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25692148"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="25692148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:49:17 -0700
X-CSE-ConnectionGUID: PzY4O03kSkuQpGc56fUhvg==
X-CSE-MsgGUID: NXCE4ZRiRw61SqP+PwqM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="59515074"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:49:12 -0700
Date: Wed, 14 Aug 2024 10:47:02 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v4 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZrxvBiSWORs8dcOS@mev-dev.igk.intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
 <ZrxuSkbu7PEAmfa9@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrxuSkbu7PEAmfa9@nanopsycho.orion>

On Wed, Aug 14, 2024 at 10:43:54AM +0200, Jiri Pirko wrote:
> Tue, Aug 13, 2024 at 11:49:49PM CEST, anthony.l.nguyen@intel.com wrote:
> >Michal Swiatkowski says:
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
> >---
> >v4:
> >- fix dev warn message when index isn't supported 
03/15
> >- change pf->hw.bus.func to internal pf id
03/15
> >- use devl_register instead of locking version
06/15
> >- rephrase last commit message
15/15

> 
> Could you at least mention in which patch you do which changes?
> 

Noted.

