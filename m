Return-Path: <netdev+bounces-228671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C459BD1BBE
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3EC54E3F9F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A92820B7;
	Mon, 13 Oct 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJvK6IaD"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5020296C
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339136; cv=none; b=FZTkIKwbrrn/qdXk9IjhW2CYI+uvW+q+9eKu4zJqQiMW8qBZtBgfS9iesIB024+pDZo9MUWVe/Tp2jvHBEyp1LdivELl9c96hsLeXWEWvmXfLNgF6d3sl7b0dUS0yCgYoKmyLRwMPWmphc9T7TkOLBKLbtktXSMKWynasPNTebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339136; c=relaxed/simple;
	bh=enscrPoK5HyiexvfGI0mrnTqAo+X6rXBq6Q5f1S4rWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLRUi18/SPFkiFuTgKk3M3f0tiQbfQqYccDaiwFEhv+V8MLnd8Ub6T8r8wBlY6629W/Nl3lcMR/WWo+LsDgiFhVVHocig/PoaGrQ/RlrUn8vwU/XqwJwrbpis4NocKpYjkZDusBTpEfo7mKKj0YdQsfxhBF7iNtzL8ObsEDe/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJvK6IaD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71de19ef-6f63-47f5-b5ed-9eaef932439c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760339130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enscrPoK5HyiexvfGI0mrnTqAo+X6rXBq6Q5f1S4rWU=;
	b=IJvK6IaDdOjBZlU9tryJ/iBBbiRuToc189qbubAvSlcYJpxWruY2WwCRLoeZh66M7xO+Yf
	s/iKTTYpfaIml+7xAZRYFYNQUm8jjNQ6OKvjO8lnto5eK+fkNkS6mhoCkLDj6TlE6oaU8g
	8zwfevNd2A+F8bqNdXzWF5A9uCKaL3E=
Date: Mon, 13 Oct 2025 15:04:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Jason Xing <kerneljasonxing@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, horms@kernel.org, kuniyu@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
 <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
 <CAL+tcoBy+8RvKXDB2V0mcJ3pOFsrXEsaNYM_o21bk2Q1cLiNSA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAL+tcoBy+8RvKXDB2V0mcJ3pOFsrXEsaNYM_o21bk2Q1cLiNSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/13 14:26, Jason Xing 写道:
> On Mon, Oct 13, 2025 at 1:36 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> On Tue, Sep 30, 2025 at 11:16:00AM +0800, Paolo Abeni wrote:
>>> On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>
>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>> [...]
>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>> This deserves explicit ack from RCU maintainers.
>>>
>>> Since we are finalizing the net-next PR, I suggest to defer this series
>>> to the next cycle, to avoid rushing such request.
>>>
>>> Thanks,
>>>
>>> Paolo
>> Hi maintainers,
>>
>> This patch was previously held off due to the merge window.
>>
>> Now that the merge net-next has open and no further changes are required,
>> could we please consider merging it directly?
>>
>> Apologies for the slight push, but I'm hoping we can get a formal
>> commit backported to our production branch.
> I suppose a new version that needs to be rebased is necessary.
>
> Thanks,
> Jason

I’ve rebased the series of patches onto the latest codebase locally and
didn’t encounter any errors.

If there’s anything else I can do to help get these patches merged, just
let me know.

Thanks!


