Return-Path: <netdev+bounces-229020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CADBD7165
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C190840619F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17B3043C9;
	Tue, 14 Oct 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MBK4mtSG"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DB3043C7
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408971; cv=none; b=HJrdqL2GNaRH/Cup78jEomN0dKBM1eOdv5LABZ9NEim7beHWkgvZoXIeS/YRx3PKPtFHplZAhROcSvvZz0KoFptKu2y5Jwo0zKt8A3r5CckRoM9UxWh4jxPTnvVzguz5m1jLiOsAzPgR4WJ1mIh47kLMlZ3K4hhQSFxbKN+xWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408971; c=relaxed/simple;
	bh=ZsvAZnrUOhK82yhL3P8+glbdzPjfU2fpLzcIr7GBioc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCbVe7RmW57d2k5K1p9+raslcYSCfE81DXxiQxOS85PWdYQnw3UeZhtP0YZQy6coC2L+wzVAwvQgl2utt9GVjIPnCRAIQgHIIj80K393wCbbricGUEpKD4Agb8yam0nv+Jl/IrVdbe8ls4hnxneF2APE8hSNxluhq7x6vbblve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MBK4mtSG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d644c8af-2ffe-41c1-bc6d-3f95ddbac756@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760408967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsvAZnrUOhK82yhL3P8+glbdzPjfU2fpLzcIr7GBioc=;
	b=MBK4mtSGAfpnw9mB4OPwq1LJSaz9MSGynRRrB2QV21yFRlSl3WfEFdXFNuZJkBrCBI/AOH
	L7guSjCBaLONJWlUIisjLsPQmN1uBfevyGGQSrfUspXJHU21j7UKXdNv8ThMxiMOSIOVCJ
	Q8o8gAfNDUXPJda8F9FcrWYC+UqehDQ=
Date: Tue, 14 Oct 2025 10:29:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Simon Horman <horms@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
 <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
 <CAL+tcoBy+8RvKXDB2V0mcJ3pOFsrXEsaNYM_o21bk2Q1cLiNSA@mail.gmail.com>
 <71de19ef-6f63-47f5-b5ed-9eaef932439c@linux.dev>
 <aOzrup9K8AE_dV28@horms.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <aOzrup9K8AE_dV28@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/13 20:08, Simon Horman 写道:
> On Mon, Oct 13, 2025 at 03:04:34PM +0800, luoxuanqiang wrote:
>> 在 2025/10/13 14:26, Jason Xing 写道:
>>> On Mon, Oct 13, 2025 at 1:36 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>> On Tue, Sep 30, 2025 at 11:16:00AM +0800, Paolo Abeni wrote:
>>>>> On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
>>>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>>>
>>>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>>> [...]
>>>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>> This deserves explicit ack from RCU maintainers.
>>>>>
>>>>> Since we are finalizing the net-next PR, I suggest to defer this series
>>>>> to the next cycle, to avoid rushing such request.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Paolo
>>>> Hi maintainers,
>>>>
>>>> This patch was previously held off due to the merge window.
>>>>
>>>> Now that the merge net-next has open and no further changes are required,
>>>> could we please consider merging it directly?
>>>>
>>>> Apologies for the slight push, but I'm hoping we can get a formal
>>>> commit backported to our production branch.
>>> I suppose a new version that needs to be rebased is necessary.
>>>
>>> Thanks,
>>> Jason
>> I’ve rebased the series of patches onto the latest codebase locally and
>> didn’t encounter any errors.
>>
>> If there’s anything else I can do to help get these patches merged, just
>> let me know.
> Hi,
>
> The patch-set has been marked as "Deffered" in Patchwork.
> Presumably by Paolo in conjunction with his response above.
> As such the patch-set needs to be (rebased and) reposted in
> order for it to be considered by the maintainers again.
>
> I think the best practice is for this to happen _after_ one
> of the maintainers has sent an "ANN" email announcing that
> net-next has re-opened. I don't believe that has happened yet.
>
> Thanks!

Dear Simon,

Thanks for the detailed explanation. I think we now know how
to handle this kind of situation.

net‑next has been reopened, and I have rebased and resent
the patch-set.

Thanks!


