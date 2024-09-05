Return-Path: <netdev+bounces-125567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8A96DBC0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242D4B21207
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6E1DDF5;
	Thu,  5 Sep 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9yrkk6C"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36999DDBE
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546467; cv=none; b=csImyl3Jw7+aqtp+o+KwX81Lkx/K5IUhpio918AKZJgxxueisjJ0WXjwdB8Yw/W4B8Tw1mr3ryat4R94NW0KbQvHBe3iYlvxWCe84BUy8wz3ie/fFNdf4k0aWZnSRNnzusKhps4M4H5DxTwKQpiEqhTVlJ/4mRYwZKnruIkxFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546467; c=relaxed/simple;
	bh=PvEB+sgEt6uP0fVjIn65cBLZJR2yOj3z0eJrr+E/71c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKPZSCBrQaIZ3khqCzS8GC1UTaEV1rJSc/0zc8DrLef5cGU8YoJgJIb01aFkpwnMUYl20sufoG+agt5HDnl+mzHlb25fX07a07PMyGpMxmdpqVsAMuXA7BKV8exGb4zi/3Iy8kACBA+iMq/jzr/9EbI0RsNpqaD8qhK8VvtNGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9yrkk6C; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f74395f-55f6-46f3-8a84-bbf033e0f2d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725546464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfjIyfKExbojvg4OqW0T1atlcXrmiOV6/uFDjaE/LIA=;
	b=T9yrkk6Ct/0LGScShWGpb5aamMC5ZhXBKN+WcickoCJCGoUskP5BpaTsMLphv8LOQx+p/N
	hTWM5MbQ+k3MGQDkhUxhpYXJv1qYWV2SZBSkiX0GwQYLKSME6a/hgrn+Bl7IRmNcB4pscJ
	qM1MVTYiv7ThzrYaGkjooGNKNPhq11E=
Date: Thu, 5 Sep 2024 10:27:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, Heng Qi <hengqi@linux.alibaba.com>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
 <20240903192524.4158713-3-sean.anderson@linux.dev>
 <CANn89iJki26SoevkdvcFO8HBCDbXR4-0nyZ55fFb2B66Pk63qA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89iJki26SoevkdvcFO8HBCDbXR4-0nyZ55fFb2B66Pk63qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 13:04, Eric Dumazet wrote:
> On Tue, Sep 3, 2024 at 9:25 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
> 
>> +
>> +/**
>> + * axienet_rx_dim_work() - Adjust RX DIM settings
>> + * @work: The work struct
>> + */
>> +static void axienet_rx_dim_work(struct work_struct *work)
>> +{
>> +       struct axienet_local *lp =
>> +               container_of(work, struct axienet_local, rx_dim.work);
>> +
>> +       rtnl_lock();
> 
> Why do you need rtnl ?

To protect against concurrent modification in axienet_ethtools_set_coalesce.

> This is very dangerous, because cancel_work_sync(&lp->rx_dim.work)
> might deadlock.

Ah, you're right. So maybe I should add a separate mutex for this.

--Sean

>> +       axienet_dim_coalesce_rx(lp);
>> +       axienet_update_coalesce_rx(lp);
>> +       rtnl_unlock();
>> +
>> +       lp->rx_dim.state = DIM_START_MEASURE;
>> +}
>>


