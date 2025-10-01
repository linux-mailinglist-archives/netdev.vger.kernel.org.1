Return-Path: <netdev+bounces-227488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C5EBB0F82
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382C5321974
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC64309F02;
	Wed,  1 Oct 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nY4I8eVU"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCE309F01
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331032; cv=none; b=cxc/wWh6vktT7eTxF5avI3LW2VIMKvwXSau0CIS9TukXufCPhmrJmvejeskWXxsm2JuFHe708OwMgMVrZ6+gqrHLNtoYzpi6e8crm3iqiuiUKbXOV/TvcQjfXXKFI93GMMWahimv3IW9Pk0xaGF8UcoGSJIidK7uWkVaNDwVzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331032; c=relaxed/simple;
	bh=vAyHGQf9eHCuMFSYsKuW673XnzwqpO+E02CQjn8sdbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmhKggttpv0Kai0oWVSivCOLdEaSbuVQ7VGnQbk6Iu8UgwM1Mu3VlPesHPmd2dpkEi+sNz/NmXe50ysR6riMadTzKom6YCNB2zgLifXWbD/5qYc8gx+n9E4cLHTfXZo4N+XzWlQWRTFgGvrxLv7kG9/GiTWh3ERmC7H5cEXcd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nY4I8eVU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d11a4e1c-b44c-4076-8de8-326183ebc3d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759331027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAyHGQf9eHCuMFSYsKuW673XnzwqpO+E02CQjn8sdbQ=;
	b=nY4I8eVUBGSnjwB3ltFLey6pYX5nK1TfNSOkM7xACCtS+nmxahCUeQxPQf8EPkzmaNykoG
	+FhaB5t/wSy4JSNnOzMyG2FaW3xqfyj7O6l6Jd0j74un0+WwRbzcPJKhCfi9F7sJux2Ul3
	I8daziE+mVSu3fvxseWss3IQajS5f4A=
Date: Wed, 1 Oct 2025 23:03:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, kuniyu@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/30 17:16, Paolo Abeni 写道:
> On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
>> mentioned in the patch below:
>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
>> rculist_nulls")
>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
>> hlist_nulls")
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> This deserves explicit ack from RCU maintainers.
>
> Since we are finalizing the net-next PR, I suggest to defer this series
> to the next cycle, to avoid rushing such request.
>
> Thanks,
>
> Paolo
>
No problem. Thanks for noticing this series of patches!

I'll resend them in the next cycle if they get forgotten.

Thanks!
Xuanqiang


