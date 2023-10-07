Return-Path: <netdev+bounces-38719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D287BC353
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E5D282188
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3195197;
	Sat,  7 Oct 2023 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbfB1iSu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D851840
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:35:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77CBF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696638903; x=1728174903;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=k0BqfISFy7h5/w/xjzEu6/my4JGiGU9v00Ry7SuT/6Q=;
  b=kbfB1iSu3nSES37HX5OnzTex1/lAhIDiQPq0IFVnswxhZD8Vc619UB41
   Q+3PVDgKooiW2REnyIdqCPH41ORhv/QBd96Xpr7azvhwQC6sGyfn7WuSd
   5qXKV59G0QPqZOH/LOf+qOCmPPuBKE/eQuSrlDwOAeuGSnuIVgmbz5k5+
   4HLRVWw28nuqaOpCr9f8bKpyZEs1Y1aDVrTQ6IQl+Zwhpo9fcbKxu2LCW
   MORxO8H/Q6ItBmgtOmXR85g+xnt9lbj1jwzYIhlEJc93c7xg9Ac3MSvq5
   CmG1fbaG5gNirarZNFEX8UV28CFoGdyRy85jQyzULzoouLKDYMs26bMtK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363215536"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363215536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 17:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="756020660"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="756020660"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.24.14.106])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 17:35:03 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, reibax@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org, davem@davemloft.net, horms@kernel.org,
 jstultz@google.com, mlichvar@redhat.com, netdev@vger.kernel.org,
 ntp-lists@mattcorallo.com, richardcochran@gmail.com,
 rrameshbabu@nvidia.com, shuah@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH net-next v4 4/6] ptp: support event queue reader channel
 masks
In-Reply-To: <20231006233537.7721-1-reibax@gmail.com>
References: <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>
 <20231006233537.7721-1-reibax@gmail.com>
Date: Fri, 06 Oct 2023 17:35:02 -0700
Message-ID: <8734yn8e2x.fsf@intel.com>
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

> Simon Horman said:
>> Hi Xabier,
>>
>> queue appears to be leaked here.
>>
>> As flagged by Smatch.
>
> Nice catch Simon. Thank you very much. I think I know how to fix it. I
> will keep it in mind for the next revision.
>
> Vinicius Costa Gomes said:
>> Sorry that I only noticed a (possible) change in behavior now.
>>
>> Before this series, when there was a single queue, events where
>> accumulated until the application reads the fd associated with the PTP
>> device. i.e. it doesn't matter when the application calls open().
>
> You are totally correct about that observation. I had never thought of
> this angle until you mentioned it. Thank you for bringing it up.
>
>> AFter this series events, are only accumulated after the queue
>> associated with that fd is created, i.e. after open(). Events that
>> happened before open() are lost (is this true? are we leaking them?).
>
> Old events are indeed lost for a new reader, but I don't see how that
> could be causing a leak. The way it works is, we always have at least
> one queue: the one corresponding to sysfs.
>

Ah, yeah! I forgot that sysfs is a separate events consumer. Disregard
my comment about leaking events, then.

> Whenever a new reader accesses the device, a new queue is created and
> starts to get fed with new coming timestamps alongside the rest of
> existing queues.
>
>> Is this a desired/wanted change? Is it possible that we have
>> applications that depend on the "old" behavior?
>
> I would really like to hear the voice of more experience people on this.
> On my limited experience this is a non-issue because I can control the
> sequencing and I am sure to have the reader ready before I trigger events,
> but you might be right that there might be some use-cases I didn't imagine
> that could be affected by this change in behavior.
>

I am not a heavy user of these APIs, but I don't think this will break
anything. Just thought it important to voice this so when we make this
change in behavior we make it knowingly. (and my imagination could not
produce any practical case that this would be a problem)

But let's see what others say.

> We could tweak the system a little bit by having an additional reference
> fifo with no readers. Whenever a new ptp_open happens, I could just copy
> the entire reference fifo to the new one. I guess this would bring back
> the need to have the fifo mutex.
>
> If this idea works we could be maintaining the same functionality, at the
> cost of making the system be more complex and slower. Is it worth it?

Probably not. I would say that this change in behavior is fine/harmless.
Just a matter of being aware of it.

>
> I look forward to hearing opinions on this. Thank you everyone for your
> feedback.
>

Cheers,
-- 
Vinicius

