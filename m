Return-Path: <netdev+bounces-219478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B1B417BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB167C261C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B772D8372;
	Wed,  3 Sep 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EqHqe5UC"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80752D660B
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886647; cv=none; b=L8ECHCk59GVgg1B//EBv/85gdxmKqGoCCyEJ4psYlsofMHY0Slrk8WHAwODMbiVepbIuCp8+28MCd3R0SiGPRwQby5448R0D1SIpXyXnC0bFcqvMeHdmkApIh3AoXF71YGnMm9oYpLP8VSyer6lEQstd6jZjXXijzSW1CQCWncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886647; c=relaxed/simple;
	bh=ZV9qi71QscQeVv5uCF8UYyV4Hlz121Xao3kjTBHsmaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUxmaQ7OXBH6TyZ2KPRXKWUb7pHiRVVR2kGn/7v4Yp+us438XJ+u8VF/P9JshHs7tLGM/MVAbt+n1RI64UGo/3Jy7FLMUc5vgaO1utpMLKZogMyGu5EISP2Ge+V90YrVY1J4Byc9X3JMaUjscjItrxdb/QtrVj24IGWO6FJtBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EqHqe5UC; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <175959a4-fe0d-472b-96c7-c8ae38e1404b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756886640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSp4lvMKOb23BNl+Pf66MdtN4cDp/UtZJawLvERigAU=;
	b=EqHqe5UC9n/4j/PxGZiXECTaQIhIR/+SvyszMzV5Xz0vaSPxPXI8ZL6vwOy/aRdJuSQDIk
	ZuB6q0x/SAGITnKagXyWsvJhfbAkLozL40jNnbanoJjjUDiCUnwogmbjAW/AfgFeywbiO/
	gieQB28E1p5hUPORZoHoror0pJdDXVM=
Date: Wed, 3 Sep 2025 16:03:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 kernelxing@tencent.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
 <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
 <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/3 14:52, Jason Xing 写道:
> On Wed, Sep 3, 2025 at 2:40 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Tue, Sep 2, 2025 at 7:46 PM Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>
>>> Since the lookup of sk in ehash is lockless, when one CPU is performing a
>>> lookup while another CPU is executing delete and insert operations
>>> (deleting reqsk and inserting sk), the lookup CPU may miss either of
>>> them, if sk cannot be found, an RST may be sent.
>>>
>>> The call trace map is drawn as follows:
>>>     CPU 0                           CPU 1
>>>     -----                           -----
>>>                                  spin_lock()
>>>                                  sk_nulls_del_node_init_rcu(osk)
>>> __inet_lookup_established()
>>>                                  __sk_nulls_add_node_rcu(sk, list)
>>>                                  spin_unlock()
>>>
>>> We can try using spin_lock()/spin_unlock() to wait for ehash updates
>>> (ensuring all deletions and insertions are completed) after a failed
>>> lookup in ehash, then lookup sk again after the update. Since the sk
>>> expected to be found is unlikely to encounter the aforementioned scenario
>>> multiple times consecutively, we only need one update.
>> No need for a lock really...
>> - add the new node (with a temporary 'wrong' nulls value),
>> - delete the old node
>> - replace the nulls value by the expected one.
> Yes. The plan is simple enough to fix this particular issue and I
> verified in production long ago. Sadly the following patch got
> reverted...
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3f4ca5fafc08881d7a57daa20449d171f2887043
>
> Thanks,
> Jason

Yes, I'm fully aware of this history. I was excited when this issue was 
once fixed, because we've already encountered this type of RST issue 
many times.


Also, I'm sharing the link to our previous discussion about this type of 
issue. If other people see this email, it might be easier for them to 
get the full details：

https://lore.kernel.org/netdev/20230615121345.83597-1-duanmuquan@baidu.com/ 
https://lore.kernel.org/lkml/20230112065336.41034-1-kerneljasonxing@gmail.com/ 



