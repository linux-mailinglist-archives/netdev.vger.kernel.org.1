Return-Path: <netdev+bounces-31248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D738C78C528
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910CE281192
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C5174DF;
	Tue, 29 Aug 2023 13:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6714F70
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:25:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB4198;
	Tue, 29 Aug 2023 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315522; x=1724851522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Su8TWlvT1KlZHo58Z3GoON6BauY+84W3pS8MMxeoPRI=;
  b=b7BuU+ZadwAZvqRCpdNfjPUPxKsbOuWPJeWVarcZ71vrAiOxR+vHnU9k
   qRhp0rgEy3GW0TUYmSiE3e5+ToG938h+jgDXdpQFB9TjcI6USEKCbts3C
   9nkBpJgVcskIHtvmZ/ei7+a0niiUM9ntDudDUxy+bPsC8amvA5ejAWkFD
   k572Zf/welBBP1lRvHeAbLD0se2UOTrYuaEA+80FHB4tS9RVYMzQJ1Qj4
   zc69RIQfhMXHIC5zXW+wV0r9xna0Q2i/APgFyd4DuXt7iTB5BMLyu/MBq
   fkGlRIiUsevu4VgAh+f2vjnlmK7YcMjTX8VUT5SO64+dqgQTBNDPZXaky
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372778421"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372778421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853285626"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853285626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 06:24:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qayhx-004tAX-05;
	Tue, 29 Aug 2023 16:24:37 +0300
Date: Tue, 29 Aug 2023 16:24:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	haozhe chang <haozhe.chang@mediatek.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <ZO3xlJ/7WDCDuz2T@smile.fi.intel.com>
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
 <689ae7b5-0b73-3cb3-5d9c-5ae23e36ee85@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689ae7b5-0b73-3cb3-5d9c-5ae23e36ee85@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 09:06:09PM +0300, Sergey Ryazanov wrote:
> On 28.08.2023 16:19, Andy Shevchenko wrote:
> > Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> > It is less verbose and it improves the type checking and semantic.
> > 
> > While at it, add missing header inclusion (should be bitops.h,
> > but with the above change it becomes bitmap.h).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Make sense. Thank you.
> 
> BTW, any plans to update __dev_alloc_name(), which was used as reference, in
> the same way?

Ah, will look at it, thanks for the pointer.

> Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

And thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



