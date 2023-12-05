Return-Path: <netdev+bounces-54001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10645805948
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886471F2156A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226260B91;
	Tue,  5 Dec 2023 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKqBKfFS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04A120
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701791936; x=1733327936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNI2sjfhfAVzVBgHSg5tQ21tJQX6wOTTkGMNm8iRUbg=;
  b=iKqBKfFS+5hxYWoBwhVu5CLxjRReIo15G4IOHsUGAw7wnAScc5Fod7QN
   Rqw2/iLdhk0PsuNAzoLsaa9D+qSoYVjthwLwSwJgo7EFMCpOUypbKGCrH
   wDSCEGfzjv9VcuxaJhQAWDTU+/kYgpDAaEz6cxGNegbzZ4Ez9h20bfYyP
   GNiMfDkKKFou1xMcx86OlZPTpAK+o4TZ1Kiwq/6W3jfTIPABJez6D4fOx
   a+TEEFLNJSWkpDQdpDZ+nAVPWN4U+YU6QMI7HqSkZ2CjNpdwoD9IiaY+m
   C8AVtCrxMjUqvYiABlmYILCCXcTBer31r7gtNtvcWHEh6jBDoeMRFmJBN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="979025"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="979025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837010730"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="837010730"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:58:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rAXou-000000024uA-2q04;
	Tue, 05 Dec 2023 17:58:48 +0200
Date: Tue, 5 Dec 2023 17:58:48 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"Hadi Salim, Jamal" <jhs@mojatatu.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"sdf@google.com" <sdf@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZW9IuN82orhqwjvV@smile.fi.intel.com>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
 <ZW39QoYQUSyIr89P@nanopsycho>
 <CO1PR11MB5089142F465D060B9AE3FDC0D686A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <ZW7Vn4F6bm2hYgpi@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW7Vn4F6bm2hYgpi@nanopsycho>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 08:47:43AM +0100, Jiri Pirko wrote:
> Mon, Dec 04, 2023 at 08:17:24PM CET, jacob.e.keller@intel.com wrote:
> >> -----Original Message-----
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Monday, December 4, 2023 8:25 AM
> >> Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
> >> >On 11/23/23 19:15, Jiri Pirko wrote:

...

> >> >> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
> >> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
> >> >> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
> >> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
> >> >> +
> >> >> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
> >> >
> >> >instead of arithmetic here, you could use struct_size()
> >> 
> >> That is used for flex array, yet I have no flex array here.
> >
> >Yea this isn't a flexible array. You could use size_add to ensure that this
> >can't overflow. I don't know what the bound on the attribute sizes is.
> 
> Okay, will do that to be on a safe side.

If we go this direction it may be makes sense to have done inside nla_len():ish
type of helper, so it will be once for everyone. But I haven't checked the code
on how many cases we have when we need to count the size depending on the present
attributes.

-- 
With Best Regards,
Andy Shevchenko



