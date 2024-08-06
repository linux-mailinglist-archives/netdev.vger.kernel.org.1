Return-Path: <netdev+bounces-116156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B19494E1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3241C1F22919
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09592770B;
	Tue,  6 Aug 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="NixDhDLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6C43147
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959613; cv=none; b=u+NV+PxEqxvIDBxxEZfvYjNURhb9jB6CbVYg1J5eqw9VvoEFL3R1sN4F2HGFm3gv3q+6hrr3pCwSBNrey4h5mwQlM2tWlZK5vFvB7JmlxgkdJL0bURXW6oKS97+1orxh5SR7xTwXO8Dr4JQoNmmxRD4SEcKRfj/bF2pIoI2XAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959613; c=relaxed/simple;
	bh=I8fjCWsguINdxMkQgZqRXGZ6bSCz6ukRfaAnOvznIZk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=u1M89DO0dq2Fjn39S5bBD4vkWBH9V1K+97bMVPnlpI1Xmb37vR/ZUdHChDysbb5KO5lMMPfJTfZfL/dZAO9S0qVFsU7Hu6uSJp7hYYU3JnX0ADDRYqFhdIaHxi9k6YosCx+KWhCxLgSbJUwIKPUHtfcp8cx1hzfWORIPx7RFtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=NixDhDLw; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 80D847D9B6;
	Tue,  6 Aug 2024 16:53:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722959604; bh=I8fjCWsguINdxMkQgZqRXGZ6bSCz6ukRfaAnOvznIZk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<bb820af8-6079-cd7f-4466-9c9a9851155e@katalix.com>|
	 Date:=20Tue,=206=20Aug=202024=2016:53:24=20+0100|MIME-Version:=201
	 .0|To:=20Simon=20Horman=20<horms@kernel.org>|Cc:=20netdev@vger.ker
	 nel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A=20kub
	 a@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20tparkin
	 @katalix.com|References:=20<cover.1722856576.git.jchapman@katalix.
	 com>=0D=0A=20<20240806144038.GV2636630@kernel.org>|From:=20James=2
	 0Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCH=20net-ne
	 xt=200/9]=20l2tp:=20misc=20improvements|In-Reply-To:=20<2024080614
	 4038.GV2636630@kernel.org>;
	b=NixDhDLwQvTC7BaS94lcEaYulgb3/jm20espAG0SPMyHRqB2N4U6IJPFdnfDOTsoC
	 SMMbO4Q1j40Srn4CaIoLgQ+ifl72TFDoZvw1ApPSpLVk6fi8lkjsHSUZHeYKkgchvV
	 xvFpGZKF4Xt/reASn+DgiFpdc/raJ3HI0qUY+4DeG7AtjKt/rPzxBrLOTDXYdFizdJ
	 HNtBuhC+d+X1BtKrUqWXfCFgqKexdZl30E3Q78g70iuCVmaV8JXX5GEdV7Izlq8IuK
	 +LkXE5BjXuu3nPuL4RK+rBOpnscvp8hySERLOFLEXe0Fybj3Fkv5xjhUu0gEOS0Nzp
	 D6XvtDeG7Dbnw==
Message-ID: <bb820af8-6079-cd7f-4466-9c9a9851155e@katalix.com>
Date: Tue, 6 Aug 2024 16:53:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com
References: <cover.1722856576.git.jchapman@katalix.com>
 <20240806144038.GV2636630@kernel.org>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next 0/9] l2tp: misc improvements
In-Reply-To: <20240806144038.GV2636630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2024 15:40, Simon Horman wrote:
> On Mon, Aug 05, 2024 at 12:35:24PM +0100, James Chapman wrote:
>> This series makes several improvements to l2tp:
>>
>>   * update documentation to be consistent with recent l2tp changes.
>>   * move l2tp_ip socket tables to per-net data.
>>   * fix handling of hash key collisions in l2tp_v3_session_get
>>   * implement and use get-next APIs for management and procfs/debugfs.
>>   * improve l2tp refcount helpers.
>>   * use per-cpu dev->tstats in l2tpeth devices.
>>   * fix a lockdep splat.
>>   * fix a race between l2tp_pre_exit_net and pppol2tp_release.
>>
>> James Chapman (9):
>>    documentation/networking: update l2tp docs
>>    l2tp: move l2tp_ip and l2tp_ip6 data to pernet
>>    l2tp: fix handling of hash key collisions in l2tp_v3_session_get
>>    l2tp: add tunnel/session get_next helpers
>>    l2tp: use get_next APIs for management requests and procfs/debugfs
>>    l2tp: improve tunnel/session refcount helpers
>>    l2tp: l2tp_eth: use per-cpu counters from dev->tstats
>>    l2tp: fix lockdep splat
>>    l2tp: flush workqueue before draining it
> 
> Hi James,
> 
> I notice that some of these patches are described as fixes and have Fixes
> tags. As such they seem appropriate for, a separate, smaller series,
> targeted at net.
> 
> ...

Hi Simon,

Thanks for reviewing.

Patch 3 changes code which already differs in the net-next and net 
trees. If it is applied to net, I think commit 24256415d1869 ("l2tp: 
prevent possible tunnel refcount underflow") is also suitable for net. I 
see now that I haven't used the Fixes tag consistently. tbh, I think 
both commits address possible issues in a rare use case so aren't 
necessary for net. But if you or others think otherwise, I'll respin for 
net.

I'll respin patch 8 targetted at net.

Patch 9 addresses changes code that isn't yet in the net tree. I'll 
remove the Fixes tag in v2.



