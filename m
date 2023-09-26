Return-Path: <netdev+bounces-36194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A37AE37F
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 887ED28145D
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E9637;
	Tue, 26 Sep 2023 01:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90881EA2
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:54:43 +0000 (UTC)
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [IPv6:2001:41d0:203:375::c3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E410C
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 18:54:42 -0700 (PDT)
Message-ID: <ef08645e-9891-0d12-2c87-39ce0be52aee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695693280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufzb6Q0ueCOMPAPRFaFdRhM3aTpkv2BWqJuSSkbzkI8=;
	b=jvH9uXw7nezAG9r0ukkLe3Z59PNuYljD/apS3isX3wIoOAT1qdv4Nb6X2B3d9TBwbdb6xU
	r27pWgb241Lm7ect9ttQMogWrTjTe9qkA8CUcEVOOvlxqUhCgYhuSF5d91Z+RChN8jzwJI
	/PwKsNIUHPJpXd4ui8UQYtg7zCK2NkI=
Date: Tue, 26 Sep 2023 09:54:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] i40e: fix the wrong PTP frequency calculation
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, jesse.brandeburg@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230627022658.1876747-1-yajun.deng@linux.dev>
 <10269e86-ed8a-0b09-a39a-a5239a1ba744@intel.com>
 <72bfc00f-7c60-f027-61cb-03084021c218@linux.dev>
 <9e1b824f-04d3-4acb-66d3-a5f90afbad0e@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <9e1b824f-04d3-4acb-66d3-a5f90afbad0e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/9/26 07:59, Tony Nguyen wrote:
> On 9/25/2023 12:55 AM, Yajun Deng wrote:
>>
>> On 2023/6/28 04:20, Jacob Keller wrote:
>>>
>>> On 6/26/2023 7:26 PM, Yajun Deng wrote:
>>>> The new adjustment should be based on the base frequency, not the
>>>> I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
>>>>
>>>> This issue was introduced in commit 3626a690b717 ("i40e: use
>>>> mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
>>>> commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
>>>> parts per million"). However the latter is a new feature and hasn't 
>>>> been
>>>> backported to the stable releases.
>>>>
>>>> This issue affects both v6.0 and v6.1 versions, and the v6.1 
>>>> version is
>>>> an LTS version.
>>>>
>
> ...
>
>>>
>>> Thanks for finding and fixing this mistake. I think its the simplest 
>>> fix
>>> to get into the stable kernel that are broken, since taking the
>>> adjust_by_scaled_ppm version would require additional patches.
>>>
>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>>
>> Kindly ping...
>
> As this patch looks to be for stable, you need to follow the process 
> for that. I believe your situation would fall into option 3:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3 
>
>
Yes, it needs an upstream commit ID. But this patch didn't need to apply 
to the upstream.

As the commit of the patch, the issue was fixed in
commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
parts per million"). However the commit is a new feature and hasn't been
backported to the stable releases.

Therefore, the patch does not have an upstream commit ID, and only needs 
to be applied to stable.


> Thanks,
> Tony

