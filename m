Return-Path: <netdev+bounces-33938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950627A0B51
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6228233F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37672628E;
	Thu, 14 Sep 2023 17:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C7208A1
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:13:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1D1FE6
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711582; x=1726247582;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4Tr2akDNB10aFXOZ8QrUwcUPWLofZiQYSqaB7tyGJDE=;
  b=ZakiG9JkWbG935K03/+AFcBWohQQDxd1ucAuixTOanYevuVEo4DuRhm9
   wiM7T6laoNbGA+obUOcf21ZM1U/jSO8sQQp8zfbhq/LlwTERpyIBEOdG0
   hrv+ss5Izv8GM1h84Kp34ajMj3U02ghVHdPk5zw97Bs8H8BEuzjJ8/D31
   VE52WpMmfBXHIywFW/ijjRWkE4L+1tYUGg8/hj1LsfuWE25VDhdBJbPVT
   jV5ZNJcHdLCmcvrN717u+5BVvO90acOLTw2k64q9pt4CE/DEfgt6fPhN1
   5djzRcFiMel9r/wUkSoCeK7U21mUHd3vXn5tmPWjRgAOaBYZNNNrBu2lP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381732086"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381732086"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834819819"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834819819"
Received: from mcphill2-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.49.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:12:55 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Xabier Marquiegui <xabier.marquiegui@gmail.com>, alex.maftei@amd.com,
 chrony-dev@chrony.tuxfamily.org, davem@davemloft.net, horms@kernel.org,
 mlichvar@redhat.com, netdev@vger.kernel.org, ntp-lists@mattcorallo.com,
 reibax@gmail.com, rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v2 2/3] ptp: support multiple timestamp event
 readers
In-Reply-To: <ZQMiKE6x/euOv3Hc@hoboy.vegasvil.org>
References: <871qf3oru4.fsf@intel.com>
 <20230913085737.2214180-1-xmarquiegui@ainguraiiot.com>
 <87wmwtojdv.fsf@intel.com> <ZQMiKE6x/euOv3Hc@hoboy.vegasvil.org>
Date: Thu, 14 Sep 2023 10:12:54 -0700
Message-ID: <87jzssel0p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> On Wed, Sep 13, 2023 at 02:25:48PM -0700, Vinicius Costa Gomes wrote:
>
>> Taking a quick look, it seems that you would have to change 'struct
>> posix_clock_file_operations' to also pass around the 'struct file' of
>> the file being used.
>
> And let drivers compare struct file pointers from different consumers?
>

That was the first idea, not very good I admit.

What you said below sounds better, more "final product".

>> That way we can track each user/"open()". And if one program decides
>> that it needs to have have multiple fds with different masks, and so
>> different queues, it should just work.
>> 
>> What do you think?
>
> See posix-clock.c : posix_clock_open()
>
> When the file is opened, the fp->private_data is used to track the
> posix_clock that was registered as a character device by the ptp
> clock instance.
>
> That character device may be opened multiple times, each time there is
> a unique fp, but fp->private_data points to the same ptp clock instance.
>
> So the information of which fp is being read() is lost.

yeah, that's the core issue.

>
> Looks like you will have to re-work posix-clock.c to allow drivers to
> provide their own "private" data populated during posix_clock_operations::open()
>
> Needs thought...
>


Cheers,
-- 
Vinicius

