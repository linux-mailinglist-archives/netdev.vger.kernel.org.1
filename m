Return-Path: <netdev+bounces-31250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6449478C543
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F611C20A32
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD3174FB;
	Tue, 29 Aug 2023 13:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91861174FA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:27:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1CD1BF;
	Tue, 29 Aug 2023 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315676; x=1724851676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=laQRomop/n4nHuaCgZ5NZ9HZ/MzLLf0xrWo3cv6IzIE=;
  b=WMOBye1KLzqHUs2GNLhtirkKGpD/DyAdrLyHh5+cZ/v2lXtdKYMT3eeU
   FkS+MWv7BbXaStdrwTWL4IfY0ojTCxHl2QUBDeIf7eN6aPKSIxL8MHNnz
   epB7N7kB4VNpyBYGQCCAXZHkqTGg/1baTzPQM3Ld1omw8XxXhHvreczjD
   Mz8m/Bh/yCGJSbxQyRg0GJRIvOi0i4BRDzLWtGeFkeIqEjxd60J09XvAC
   a4iA90Kq6YldIWwqmW0+jShXwNruY4+BvRRQLvs+qsFNEd5JdB7Pg3+Qn
   itrbUvxKd8JUmeSMvRFH/9yvBXAhDPj2+m3/1cemZAkmN1Vt+kDQ4snnR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354879049"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="354879049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768074772"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="768074772"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2023 06:27:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qaykF-004tC2-0a;
	Tue, 29 Aug 2023 16:26:59 +0300
Date: Tue, 29 Aug 2023 16:26:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: haozhe chang <haozhe.chang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <ZO3yIo3tGb8NRiy6@smile.fi.intel.com>
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
 <20230828124524.5ca4da50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230828124524.5ca4da50@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 12:45:24PM -0700, Jakub Kicinski wrote:
> On Mon, 28 Aug 2023 16:19:53 +0300 Andy Shevchenko wrote:
> > Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> > It is less verbose and it improves the type checking and semantic.
> > 
> > While at it, add missing header inclusion (should be bitops.h,
> > but with the above change it becomes bitmap.h).
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.6 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.

Sure.

> Please repost when net-next reopens after Sept 11th.

I'm wondering since we have established lore archive along with `b4` or any
analogous tool (since there is an API) why I need to repost. It increases
the SNR in the mailing lists, consumes more resources —> adds into global
climate change.

-- 
With Best Regards,
Andy Shevchenko



