Return-Path: <netdev+bounces-37535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC137B5D63
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0C66C281414
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EEC20333;
	Mon,  2 Oct 2023 22:54:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACB1F170
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 22:54:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB749E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287284; x=1727823284;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9+YLYSnsxXRTIY+DBwUqbvgdZBkFlczFbzKfbgdKmLo=;
  b=OTzTM8kwnJHP8dUUUEfrSIrv8DhKaBOpnp7HdatIQJXhUOfEkYEK7TPV
   1Snw2uoq6gKwQbxlTgNAUMpguBhJaRTEEG1FoQS2juw+uS+PmynaMZHrf
   T8au55l7G8XTkjChKGssLcw4Md9f+941uQYTuswpkJhJWRY2+BXSgkluM
   fgp9nQwH8+J2S56ikZfGUKu0xNTw+sSu45Yso1S9CHWFNQhja1Ipu5rH7
   IlV91JOqvKAV8CzGwLUIfU4PcftmsGruQHQZ7+cbzoW+Zxl7DlSPAHfRc
   /R+bzIKnfFuAH14oY1F65BfJL4CfDzE0FfYWVjhUmSxV5r1bk4bYZhx4h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367808939"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="367808939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754196578"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754196578"
Received: from mtran5-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.77.185])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:54:43 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: alex.maftei@amd.com, chrony-dev@chrony.tuxfamily.org,
 davem@davemloft.net, horms@kernel.org, mlichvar@redhat.com,
 netdev@vger.kernel.org, ntp-lists@mattcorallo.com, reibax@gmail.com,
 richardcochran@gmail.com, rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel
 masks
In-Reply-To: <20230930080155.936-1-reibax@gmail.com>
References: <87jzs84jee.fsf@intel.com> <20230930080155.936-1-reibax@gmail.com>
Date: Mon, 02 Oct 2023 15:54:42 -0700
Message-ID: <87wmw43aa5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xabier Marquiegui <reibax@gmail.com> writes:

> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>
>> Looking below, at the usability of the API, it feels too complicated, I
>> was trying to think, "how an application would change the mask for
>> itself": first it would need to know the PID of the process that created
>> the fd, then it would have to find the OID associated with that PID, and
>> then build the request.
>> 
>> And it has the problem of being error prone, for example, it's easy for
>> an application to override the mask of another, either by mistake or
>> else.
>> 
>> My suggestion is to keep things simple, the "SET" only receives the
>> 'mask', and it only changes the mask for that particular fd (which you
>> already did the hard work of allowing that). Seems to be less error prone.
>> 
>> At least in my mental model, I don't think much else is needed (we
>> expose only a "SET" operation), at least from the UAPI side of things.
>> 
>> For "debugging", i.e. discovering which applications have what masks,
>> then perhaps we could do it "on the side", for example, a debugfs entry
>> that lists all open file descriptors and their masks. Just an idea.
>> 
>> What do you think?
>
> Thank you very much for your input Vinicius. I really appreciate it.
>
> I totally agree with your observations. I had already thought about that angle
> myself, but I decided to go this route anyway because it was the only way I
> could think of meeting all of Richard's requirements at that time.
>
> Even if being error prone, being able to externally manipulate the channel
> masks is the only way I can think of to make this feature backwards compatible
> with existing software. One example of a piece of software that would need to
> be updated to support multiple channels is linuxptp. If you try to start ts2phc
> with multiple channels enabled and no masks, it refuses to work stating that
> unwanted channels are present. This would be easy to fix, incorporating the
> SET operation you mention, but it is still something that needs to be changed.
>

I never looked at this a lot, so, as always, I could be missing stuff.

But from the way I see things, the solution that seems better has two
parts:

1. Fix ts2phc to ignore events from channels that it cannot/doesn't want
   to handle. (Is this possible?)
2. Add the "set mask ioctl/alternative ideas, is then more like a
   optimization, to avoid waking up applications that don't want some
   events;

So we have 'ts2phc' working on "old" kernels and on "new" kernels it is
"just" more efficient.

> Now that I think of it, it is true that nothing prevents us from having both
> methods available: the simple and safe, and the complicated and unsafe.
>
> Even with that option, I also think that going exclusively with the safe
> and simple route is better.
>
> So, I wonder: Can we just do it and require changes in software that relies
> on this driver, or should we maintain compatibility at all cost?
>
> Thank you very much for sharing your knowledge and experience.


Cheers,
-- 
Vinicius

