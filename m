Return-Path: <netdev+bounces-33682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF979F3BF
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465081F215D6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DD22EF2;
	Wed, 13 Sep 2023 21:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC929CA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 21:25:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8291724
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694640350; x=1726176350;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W+1EhtKzhbn4AbvCnAc/x+7/0nn20/dGoz+lMZ2HDOs=;
  b=nwx9O2u5ekzdc2Qfif4pwc/UECV60RPz1dy2702sHVdEftVfbxJENavx
   5F9OERgK7T+WhMmuCdb5t5DQ/NaaWu2DIIVs8j0sE72rsN/z3Tt6hMzwq
   mbshirQ40YuaBk3pCAnExBPun/kuG0o3fEjpTUc2c/qMNmSGBWsvH3vpf
   Nlgr2jjyri7J3C8nRcC1QNQrvZ1OAFQ90GlxcNXApmfvcnRH1AYQzQbIt
   KaHy4XO5NDPHA6LkE3jTYshuPoEwc1mwHwelPtNIaWRXwW1+CEyOEAc9G
   ogYriFZ/tz0T6H0s5eOOX+sQV73xIRfY5QJT7ymcvjsoHa9AGT24q1v85
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445222972"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="445222972"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 14:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814411357"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="814411357"
Received: from jlangsto-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.49.254])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 14:25:48 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <xabier.marquiegui@gmail.com>
Cc: alex.maftei@amd.com, chrony-dev@chrony.tuxfamily.org,
 davem@davemloft.net, horms@kernel.org, mlichvar@redhat.com,
 netdev@vger.kernel.org, ntp-lists@mattcorallo.com, reibax@gmail.com,
 richardcochran@gmail.com, rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v2 2/3] ptp: support multiple timestamp event
 readers
In-Reply-To: <20230913085737.2214180-1-xmarquiegui@ainguraiiot.com>
References: <871qf3oru4.fsf@intel.com>
 <20230913085737.2214180-1-xmarquiegui@ainguraiiot.com>
Date: Wed, 13 Sep 2023 14:25:48 -0700
Message-ID: <87wmwtojdv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xabier Marquiegui <xabier.marquiegui@gmail.com> writes:

>> Using the pid of the task will break when using some form of file
>> descriptor passing. e.g. Task A opened the chardev, called the ioctl()
>> with some mask and then passed the fd to Task B, that's actually going
>> to use the fd.
>> 
>> Is this something that we want to support? Am I missing something?
>
> Thank you very much for your valuable comments Vinicius,
>
> Let me try to confirm if I understand what you are observing here.
>
> Let's say we have a process with two threads. One of them opens the device
> file to do IOCTL operations, and the other one opens the device file to
> read timestamp events. Since both have the same PID, all the operations
> (read,release...) would fail because I designed them under the assumption
> that only one open operation would happen per PID.
>

I was initially thinking about another scenario: when Process A passes
the open file descriptor via SCM_RIGHTS to Process B.

But your scenario also shows the limitations of the current approach.

> This is indeed not as safe as it should be and I should try to improve it.
>
> I am already looking at alternatives, but maybe someone can give me a hint.
> Do you have any suggestions on what I could do to have file operations 
> (read, release...) determine which open instance they belong to?

Taking a quick look, it seems that you would have to change 'struct
posix_clock_file_operations' to also pass around the 'struct file' of
the file being used.

That way we can track each user/"open()". And if one program decides
that it needs to have have multiple fds with different masks, and so
different queues, it should just work.

What do you think?


Cheers,
-- 
Vinicius

