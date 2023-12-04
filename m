Return-Path: <netdev+bounces-53557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A27803ABB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCC52814D2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179C2557C;
	Mon,  4 Dec 2023 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qt3DxPuB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F61125
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701708443; x=1733244443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rELzeYQdUfU3Z5kQW2FYnnml5bzAQvAdYt6NV1Uid7s=;
  b=Qt3DxPuBxiS22e+WpC2YMct1Ud5yELpT52Rj/tRyXMNHb0MH15SNg5Ok
   zZNqDwoHbO/rKG3UWnTfQ71HGOLdhkDm91xEVcfC1kcGORzuKnQVl9fbX
   IUohpp3pINQP3xEu75jAaTAaSgLjS60rrIQePIftCW76/6UYfyYm+j4SW
   2eyd9vz0VDTeSQ3aT9Wjokr8BrjHMo+zoC7T7Ei9mGVAGDi6vibYx6Fqv
   9EhvQgnMThGjEMW0ncGegOUy0ye8BY40U7Rc2xUjBttsfeBrtlnXG/WDY
   3ohnNL55SrWAkNQNuT9HOvTc+uRkvgsJcb7/2Dykhle48OObf028YivD9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12476787"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="12476787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836642168"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836642168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:47:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rAC6G-00000001o4D-3jcp;
	Mon, 04 Dec 2023 18:47:16 +0200
Date: Mon, 4 Dec 2023 18:47:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, amritha.nambiar@intel.com,
	sdf@google.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZW4ClD9JC22qh90E@smile.fi.intel.com>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
 <ZW39QoYQUSyIr89P@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW39QoYQUSyIr89P@nanopsycho>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 04, 2023 at 05:24:34PM +0100, Jiri Pirko wrote:
> Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
> >On 11/23/23 19:15, Jiri Pirko wrote:

[...]

> >> +	size_t data_size = 0;
> >> +	char *pos;
> >> +
> >> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
> >> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
> >> +
> >> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
> >
> >instead of arithmetic here, you could use struct_size()
> 
> That is used for flex array, yet I have no flex array here.

It feels like you use flexible array even if you have the top limit of
the size. But yeah, the attributes seem out of the variadic length and
struct_size() here won't help anyway.

-- 
With Best Regards,
Andy Shevchenko



