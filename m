Return-Path: <netdev+bounces-48060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA27EC661
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C5E1F2770C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2D2EB06;
	Wed, 15 Nov 2023 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA8trfEm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F42D022
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:53:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9644A6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700060025; x=1731596025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAi7jHAIMqeMc6zhgZ7aaOgbisx8HpuZ3ec/cK4oxiY=;
  b=dA8trfEmQv5HJZd+PZDFWxC7ahOMbGPj8a7XHg6EaX+IimWVMtSVshvz
   jbBV943MbJqYghw7OoZ28PTnESpBwr5ErMS4s7X1Pw2CTyNm1XPBrs8nC
   mVzHXcdF17xqSRlOXw9WYsiBalKEWaqff7UTMTyVFxGsDfdzNEY5ak0xv
   WpTbGX+/2/HOMsio4NfQPqDunO16APK6GZx40kB5Rxr7Jx6S8Xc9NtaIP
   +1irmH4v09vhRQLKqO108RV/I9WIQ7erHZgctJ15Htn2xrOKSf5ziYfxG
   CSGmmql1mq9SFUS5m/S4qmaNz26sslvJI6reCGK9u046ROB+HgenCPnza
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394807407"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="394807407"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758511575"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="758511575"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:53:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r3HGs-0000000ELJb-0kto;
	Wed, 15 Nov 2023 16:53:38 +0200
Date: Wed, 15 Nov 2023 16:53:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 6/8] genetlink: introduce helpers to do filtered
 multicast
Message-ID: <ZVTbccC0VhT4CetU@smile.fi.intel.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115141724.411507-7-jiri@resnulli.us>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 15, 2023 at 03:17:22PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently it is possible for netlink kernel user to pass custom
> filter function to broadcast send function netlink_broadcast_filtered().
> However, this is not exposed to multicast send and to generic
> netlink users.
> 
> Extend the api and introduce a netlink helper nlmsg_multicast_filtered()
> and a generic netlink helper genlmsg_multicast_netns_filtered()
> to allow generic netlink families to specify filter function
> while sending multicast messages.

...

> +/**
> + * genlmsg_multicast_netns_filtered - multicast a netlink message
> + *				      to a specific netns with filter
> + *				      function
> + * @family: the generic netlink family
> + * @net: the net namespace
> + * @skb: netlink message as socket buffer
> + * @portid: own netlink portid to avoid sending to yourself
> + * @group: offset of multicast group in groups array
> + * @flags: allocation flags
> + * @filter: filter function
> + * @filter_data: filter function private data

	scripts/kernel-doc -v -none -Wall ...

will complain.

> + */

...

> +				 int (*filter)(struct sock *dsk,
> +					       struct sk_buff *skb,
> +					       void *data),

Since it occurs more than once, perhaps

typedef int (*genlmsg_filter_fn)(struct sock *, struct sk_buff *, void *);

?

...

>  /**
> - * nlmsg_multicast - multicast a netlink message
> + * nlmsg_multicast_filtered - multicast a netlink message with filter function
>   * @sk: netlink socket to spread messages to
>   * @skb: netlink message as socket buffer
>   * @portid: own netlink portid to avoid sending to yourself
>   * @group: multicast group id
>   * @flags: allocation flags
> + * @filter: filter function
> + * @filter_data: filter function private data

I believe same complain by kernel-doc here and in more places...

Can you at least make sure your patches do not add new ones and removes ones
where you touch the code?

-- 
With Best Regards,
Andy Shevchenko



