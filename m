Return-Path: <netdev+bounces-37140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5C7B3D05
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 01:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2BDB3B209C5
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9567BE5;
	Fri, 29 Sep 2023 23:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847CF9F6
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 23:39:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7CEB
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696030776; x=1727566776;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rrmXdOmJVcXzxrsJPfrC/YYAM363VfW+PAK+sq1EFwg=;
  b=AmIWVDD3sl74d9paWsWx9aCYHPlwad3f56X2AtwIhDYSlkoCz93Ic7PB
   M9noob3diV8HN4AuIFPvSsymw2Dx3hoeDkXbx6tqSRuRajgsj9eHIpLkC
   X2gFkw4vseNwogp9S9A3JDKualcAOG0UOD9L/jzC8GfnPfCg20dpSRTNQ
   YZJl1Lmp+6bSvW3MEBalMtGwdcvB4sNYfhjkNNWY8V6LGj/UKJ0XdOFYM
   HOU+p3/ZKi+VIsAvrBrGb/VBt9pHIkOb4dW+kHvZ4fQSSQpm+SiE/6/LJ
   /Zcb17oWN91CD/I8/iqfsGpI4YRhqF5NnC2tuG+vLmQUzS4kVOtiRBnc5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379684874"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379684874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="873828187"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="873828187"
Received: from jinsungk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.192.47])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:39:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, horms@kernel.org,
 chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com, reibax@gmail.com,
 ntp-lists@mattcorallo.com, alex.maftei@amd.com, davem@davemloft.net,
 rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v3 0/3] ptp: Support for multiple filtered
 timestamp event queue readers
In-Reply-To: <20230928133544.3642650-1-reibax@gmail.com>
References: <20230928133544.3642650-1-reibax@gmail.com>
Date: Fri, 29 Sep 2023 16:39:35 -0700
Message-ID: <87y1go4ki0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xabier Marquiegui <reibax@gmail.com> writes:

> On systems with multiple timestamp event channels, there can be scenarios where
> multiple userspace readers want to access the timestamping data for various
> purposes.
>
> One such example is wanting to use a pps out for time synchronization, and
> wanting to timestamp external events with the synchronized time base 
> simultaneously.
>
> Timestmp event consumers on the other hand, are often interested in a subset of
> the available timestamp channels. linuxptp ts2phc, for example, is not happy if
> more than one timestamping channel is active on the device it is reading from.
>
> This patch-set introduces linked lists to support multiple timestamp event queue
> consumers, and timestamp event channel filters through IOCTLs.
>
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>

On the series organization side, my suggestion about the order of things:

1. Any preparation work;
2. Introduce the new UAPI: the ioctls (this needs to be front and center, as it has
   to be maintained for a long time);
3. Changes to the "core" (posix_clock and friends);
4. "glueing" everything together in the driver;
5. Tests;

(it is possible that that the "preparation" can be moved to the
"glueing" part)


Cheers,
-- 
Vinicius

