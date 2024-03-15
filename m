Return-Path: <netdev+bounces-80087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2187CF0D
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E871F23647
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8A6381B4;
	Fri, 15 Mar 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv+Xdvo2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324E26AF2
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513374; cv=none; b=lubPKq+cX00S7TqFRMIb9rS/9vHLlvaBp2Wfpag0j2BO/NVzFD6Ux6D4luHfJGHIfFxMOm9SZ7aXH+Tzlaq14g9ZY1t/B0Blhvh+SnNivlBuCNTYssQAGhb6hJRUWC6PC8A4eXbupyf44g5clWcqRC6XfyvrfkgfJLjd7GOgG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513374; c=relaxed/simple;
	bh=9q6xkkI3TdiGRL7gVt+yiNOkkYp51/q6wkRR0IUPxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+ShAD2DhBOKAs+WC8kW7uhtpzDTdYg6mpHXCE7744QuOM9cCady2S1lWvC/rl6rAj9ECZmUmcHh4qc9Y0HmG7ABBxwk9vNZv+GMMD1OByBrBTOEoLgNRERTPntmaiBxzBybgKkqpx0qwFLClI93tgbLXO59fQ5qhY9aZpvBydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv+Xdvo2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710513372; x=1742049372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9q6xkkI3TdiGRL7gVt+yiNOkkYp51/q6wkRR0IUPxxk=;
  b=Tv+Xdvo2IHOOgLOIc8GCTdJ4/rUYq5qYJFZGButxofFBiJUUfkDFrBs2
   PL5p4t2T5zlu//NDD+OSKDECgISs7rikX6owmFNacOwbTKJvser6e9AN8
   HZJjDJzqvcDdLHgk5N3QhW3k13TevoVVDnnMb2d/zFrdrC9wyO422W2h6
   aAq4yCGuWwWT7amEr7FMN0pvQ2Uop/oBucwCjsVmMYjQ7JbZ5Wf97iuFK
   3d3WzRi+o7QupjhO1atyXv+PKhCHWCLGUEuhgtake7/WCc3dg3oPeahsU
   9ZVnmskISW2S0+Lp3iDDH6wydFgF1T6Sk1G6VGemGpoRNXUMai4CCwMCb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16030889"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="16030889"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="914498812"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="914498812"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:36:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rl8fF-0000000DBeR-39AR;
	Fri, 15 Mar 2024 16:36:05 +0200
Date: Fri, 15 Mar 2024 16:36:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, anjali.k.kulkarni@oracle.com,
	pctammela@mojatatu.com, dhowells@redhat.com, kuniyu@amazon.com,
	netdev@vger.kernel.org, zzjas98@gmail.com
Subject: Re: [net/netlink] Question about potential memleak in
 netlink_proto_init()
Message-ID: <ZfRc1eUJJSoaGSpn@smile.fi.intel.com>
References: <ZfOalln/myRNOkH6@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfOalln/myRNOkH6@cy-server>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 14, 2024 at 07:47:18PM -0500, Chenyuan Yang wrote:
> Dear Netlink Developers,
> 
> We are curious whether the function `netlink_proto_init()` might have a
> memory leak.
> 
> The function is
> https://elixir.bootlin.com/linux/v6.8/source/net/netlink/af_netlink.c#L2908
> and the relevant code is
> ```
> static int __init netlink_proto_init(void)
> {
> 	int i;
>   ...
> 
> 	for (i = 0; i < MAX_LINKS; i++) {
> 		if (rhashtable_init(&nl_table[i].hash,
> 				    &netlink_rhashtable_params) < 0) {
> 			while (--i > 0)
> 				rhashtable_destroy(&nl_table[i].hash);
> 			kfree(nl_table);
> 			goto panic;
> 		}
> 	}
>   ...
> }
> ```
> 
> In the for loop, when `rhashtable_init()` fails, the function will free the
> allocated memory for `nl_table[i].hash` by checking `while (--i > 0)`.
> However, the first element (`i=1`) of `nl_table` is not freed since `i` is
> decremented before the check.
> 
> Based on our understanding, a possible fix would be
> ```
> -      while (--i > 0)
> +      while (--i >= 0)
> ```

The better pattern (and widely used in kernel) is

	while (i--)

> Please kindly correct us if we missed any key information. Looking forward to
> your response!

-- 
With Best Regards,
Andy Shevchenko



