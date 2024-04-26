Return-Path: <netdev+bounces-91519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E29C8B2ECE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37856B21A84
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654FE74E0A;
	Fri, 26 Apr 2024 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E3pX4Run"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14574BF8
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714100153; cv=none; b=iNE2VjA/xnE7dvC3HCKFTN/wXP1Hs7ZkgCE7Bmak8MCf3ukVxBeYn2Kzm7a4Tq9BRvjmwzeiaJRmHlgVA1iTqFOFO9i3AXxx987GkAsoEX3UDBprIh+l7k1AqjSncg1tT/jjGa8kibuNZav+C4Hz221Uu4w8jTqBHlEAT/M/A6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714100153; c=relaxed/simple;
	bh=5khsWcNYkskwKGSUFnHNopim4d9feFyBoXSQCLbwE2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoAOOelBgWg2NcgkyNx+i5r3LUrjeq2ltgKvi4QjHlDZ+fI3d44trUH6H6W2FiAiip//AHW9Vw1hr+t1dtt3rc2WKNskFEnFetsqHKDrxpQu4365VLccp/jbeqmJKBJSvsPEtSZzi13NZF2mm7IGEDYMmNYxpAx96AgkOMvn7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E3pX4Run; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714100142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hSVic2/Z1FN21OR+wJJJbFXWXZe5i38ynfcaVLxe3ow=;
	b=E3pX4RunbkBuePzLiHPPKOefkCs3cKoE8qiSdk4CiiIYpAtpVJcOudLkXVqpOp5aewnZcI3s4tXEBL9bLZTtko17u3uqXD5dmDQJHXfrN77eOZixgscpzmgmUMeen4wyMucNwTuA3pD2FUFF4JuDQa/YPMg2lOpXBbOa9BF1RbA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5HRA3S_1714100140;
Received: from 30.221.145.218(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5HRA3S_1714100140)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 10:55:41 +0800
Message-ID: <20b09b78-0d59-4f2f-b5cd-5965042651c6@linux.alibaba.com>
Date: Fri, 26 Apr 2024 10:55:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] virtio_net: fix possible dim status
 unrecoverable
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
 <20240425125855.87025-3-hengqi@linux.alibaba.com>
 <20240425192150.0685d4b3@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240425192150.0685d4b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/26 上午10:21, Jakub Kicinski 写道:
> On Thu, 25 Apr 2024 20:58:54 +0800 Heng Qi wrote:
>> When the dim worker is scheduled, if it no longer needs to issue
>> commands, dim may not be able to return to the working state later.
>>
>> For example, the following single queue scenario:
>>    1. The dim worker of rxq0 is scheduled, and the dim status is
>>       changed to DIM_APPLY_NEW_PROFILE;
>>    2. dim is disabled or parameters have not been modified;
>>    3. virtnet_rx_dim_work exits directly;
>>
>> Then, even if net_dim is invoked again, it cannot work because the
>> state is not restored to DIM_START_MEASURE.
>>
>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> This sounds like a legitimate bug fix so it needs to be sent separately
> to the net tree (subject tagged with [PATCH net]) and then you'll have
> to wait until the following Thursday for the net tree to get merged
> into net-next. At which point you can send the improvements.
> (Without the wait there would be a conflict between the trees).


Yes, you are right, since this set is on top of the one DanJ is working on

(which I mentioned in the commit log and patchwork will warn about),

I merged the fix patch into this series. I'll wait for his set to be merged and push it again.

Thanks a lot!


>
> Right now the series does not apply to net-next anyway.

