Return-Path: <netdev+bounces-51811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC97FC4E0
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA7282E49
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456140C07;
	Tue, 28 Nov 2023 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0npRPKv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1510F0
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202023; x=1732738023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dudf7D7lifL9jFYgzm7GZmAN7wqe+0WYDLwaVZyypPA=;
  b=K0npRPKvPf5ozW2++o9fJpqzJADKp7UTbQNbHQm9ETOTfGex6/MhmFLw
   j05wsgS6ahMgisQ9+4VDVydp/5lldby4GyAsi3XRN6BD8EWx7eiOsz4Oo
   iIdr+4ht/vYOeyk/Z4VU/7gC4OiMaLWR3vDUWOaqPgR8VYxKMtMGhk/A9
   /MtM5ybS4rWXhUnRvZrhjltStUVRieWHQbz1P5YJSzz/I6RscQe7ScQZE
   bqQGDBvu9FMoiYHLum+pXCdH7emB3XyOHu1Iptg1BJAJm/WRVIjFn3Pef
   7wah3xHFsOWKIUq+thvkSn7FnmJcxKv9nRuzXG4aeaFfbZ5X1Jr+OS6wc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479209150"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479209150"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:06:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="886556364"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="886556364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:06:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r84LZ-00000000G27-37Yk;
	Tue, 28 Nov 2023 22:06:17 +0200
Date: Tue, 28 Nov 2023 22:06:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, amritha.nambiar@intel.com,
	sdf@google.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWZIOY7Mzx5oFdAu@smile.fi.intel.com>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
 <ZWYSz87OfY_J8RYq@smile.fi.intel.com>
 <37a14eca-8127-4897-a6bf-c6260d9d33b9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a14eca-8127-4897-a6bf-c6260d9d33b9@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 28, 2023 at 11:59:05AM -0800, Jacob Keller wrote:
> On 11/28/2023 8:18 AM, Andy Shevchenko wrote:
> > On Tue, Nov 28, 2023 at 01:30:51PM +0100, Przemek Kitszel wrote:
> >> On 11/23/23 19:15, Jiri Pirko wrote:

...

> >>> + * Returns: valid pointer on success, otherwise NULL.
> >>
> >> since you are going to post next revision,
> >>
> >> kernel-doc requires "Return:" section (singular form)
> >> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> >>
> >> for new code we should strive to fulfil the requirement
> >> (or piss-off someone powerful enough to change the requirement ;))
> > 
> > Interestingly that the script accepts plural for a few keywords.
> > Is it documented somewhere as deprecated?
> 
> I also checked the source:
> 
> $git grep --count -h 'Returns:' |  awk '{ sum += $1 } END { print sum }'
> 3646
> $git grep --count -h 'Return:' |  awk '{ sum += $1 } END { print sum }'
> 10907
> 
> So there is a big favor towards using 'Return:', but there are still
> about 1/3 as many uses of 'Returns:'.
> 
> I dug into kernel-doc and it looks like it has accepted both "Return"
> and "Returns" since the first time that section headers were limited:
> f624adef3d0b ("kernel-doc: limit the "section header:" detection to a
> select few")
> 
> I don't see any documentation on 'Returns;' being deprecated, but the
> documentation does only call out 'Return:'.

Then I would amend documentation followed by amending scripts, etc.
Before that it's unclear to me that contributor must use Return:. It
sounds like similar collision to 80 vs. 100 (former in documentation,
latter in the checkpatch).

Of course, there might be sunsystem rules, but again, has to be documented.
Right?

-- 
With Best Regards,
Andy Shevchenko



