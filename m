Return-Path: <netdev+bounces-198661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47269ADCF97
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D229A17E387
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01382ED17B;
	Tue, 17 Jun 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drWdpzRp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70412DE1F9;
	Tue, 17 Jun 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169679; cv=none; b=EJKGie7PaIeuhUH6FMP3sK8AA6ttBD2hdDLmfqfICUPaBWnjflHvIQUWe7KDIMEyX3UHGipKANPmHhorYEArphZgaSHGFwXoQEQZBnUV5MgODAwPJ41Di9zJiANCR+rIq7cPXAmwavogHyc65NLMSyHVbisnTtzd1OnRkOzdZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169679; c=relaxed/simple;
	bh=pNelIk0pW9OO+Z6yvti9NhYvMQpkCMlkT9Y/4jcTlFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozpPY22oAR3P5AH4OThQhG5MkXK/Zb4+Z0HaRukMET8VvCHgTyPvtCX7sw0Fa+817iA1cVkZflNz4vvBGTIfjcSG7gGe9eh/ifHNMsDwfYTq+0P4iIk2zYWYAxTg4OUzAipyqCibAInj1piz7F0QGv49iSTWAFWE9y5/68dzu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drWdpzRp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750169678; x=1781705678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pNelIk0pW9OO+Z6yvti9NhYvMQpkCMlkT9Y/4jcTlFY=;
  b=drWdpzRpce3j/CwB4nALs7wn2l8yhI9fa0ul//NZJR5ci1fORKDtElbh
   PnwiTVCMi9Qr7VuInoCR8z00Ea+ONmjtLRv051nN+t64ZUkwOoAt1pAsr
   ZW4Obzy6jKei21mGGRZMxhDP8X4ho2oQwqH/gkSwvQNS73XAh/2dn+JLQ
   GlQdSmAVlhwxFnj2H0k5DSvU8L9wC6pAIS786tDcl7wDim9HEGXUmYM6+
   srjKLix9RZwjB4X4rbWUARleA/OvV4SUrCrdyvkTBQGlh0rsSOmjfh7ci
   SxsTnVm+ngDG1MVjXM9R8O+x7YjekT2ZGAYhLbsrSwWLYU5TQkNwOuywV
   g==;
X-CSE-ConnectionGUID: hKvsdmyzRE20UTwXe/v/hw==
X-CSE-MsgGUID: poCgf+ifRQmsx7Q8A9OcAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="77751066"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="77751066"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:14:37 -0700
X-CSE-ConnectionGUID: r4qahXrTQuW+V0XPog4gPA==
X-CSE-MsgGUID: JqKykOEgRcGfaGCDTBzSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149687143"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:14:33 -0700
Date: Tue, 17 Jun 2025 16:12:30 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 3/8] net: hns3: use hns3_get_ops() helper to
 reduce the unnecessary middle layer conversion
Message-ID: <aFF3zi+6tL1hr4UR@mev-dev.igk.intel.com>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-4-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:50AM +0800, Jijie Shao wrote:
> There are too many indirection layers in the HNS3 driver code,
> This issue was previously discussed with the maintainer,
> who suggested adding a helper function to fix the issue.
> In fact, the hns3_get_ops() helper is already defined
> and can fix this issue.
> 
> This patch uses hns3_get_ops() helper to reduce the unnecessary
> middle layer conversion. Apply it to the whole HNS3 driver.
> The former discusstion can be checked from the link.

Thanks for rewording the commit message.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/

I hope you will add getting hns3 device from netdev too in the future
(as this is main point in the link).

> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Change commit message and title, suggested by Michal Swiatkowski.
>   v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
> ---

[...]

