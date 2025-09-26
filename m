Return-Path: <netdev+bounces-226588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8ABA262C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2534B189E812
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E426FA4E;
	Fri, 26 Sep 2025 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdU+DERE"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB78288A2
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861251; cv=none; b=LZ1p274lDKdAYmwfNxbeyMSicRtggfmEaWCS3tM4+0nNPsSlQwjG2uteGO12UyE7pgOX2gigRenEevoJlRtjLr0xopxClH7ugubjecICbHz43vg2yg2s/Iycxb76oDgnYwt1lG1HGOUwxDlvBWAt8kJiGl5FDLcbLQGeE/3+2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861251; c=relaxed/simple;
	bh=rO5f4poW0ZYKPc5Dr/saILn37G2vH1Hi7UtOKXBK1bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOrEay106BYRiZnnT4UXguLsk//kIOKuwZr21QB6lHxWIGHOdV+PsMEeagZIGQ3ZqLTFvw3lh2oh6QmXofmqIeQTbRrjIEvZ1loNMjfngw7Kdo413XXbWy3mZRQFFsqGWUB8i/yXZrsZC1MkoVAu8RBDbzqVqdcfQDOtnbQ/W3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bdU+DERE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15ce9ffb-fdd0-4dba-8cfa-b24de99368fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758861245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSd6kR+MBzz5kbwM+fgaPOoqvYpsVsiRnt/J6kc4a5g=;
	b=bdU+DEREs70XZZncQj+7jIPuKICjrOp72X4ptCLI4UzUPq9GFXy4OPuj6zxA/PX8arpOXj
	/AK9NYU2DKjgPkxuRfTbYxi3YOeSHAsQzHRDM0XmL/vRsdDJciSD1lmd+lScoA1qCKl4Ma
	F5JShMv1rmNmc+bQkygsQj300caV8uk=
Date: Fri, 26 Sep 2025 12:33:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, "Paul E. McKenney" <paulmck@kernel.org>,
 kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
 <20250925021628.886203-2-xuanqiang.luo@linux.dev>
 <CAAVpQUDNiOyfUz5nwW+v7oZ-EvR0Pf82yD0S2Wsq+LEO2Y2hhA@mail.gmail.com>
 <5d7904e8-977e-499c-b877-901facac5dea@linux.dev>
 <CAAVpQUAi2TLyODdvK=EAh0OyL_ZzLQWA_XrrQaspXTNdEmapWA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUAi2TLyODdvK=EAh0OyL_ZzLQWA_XrrQaspXTNdEmapWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/26 12:02, Kuniyuki Iwashima 写道:
> On Thu, Sep 25, 2025 at 8:23 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
> [...]
>>>> +{
>>>> +       struct hlist_nulls_node *next = old->next;
>>>> +
>>>> +       WRITE_ONCE(new->next, next);
>>>> +       WRITE_ONCE(new->pprev, old->pprev);
>>>> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev, new);
>>> nit: define hlist_nulls_prev_rcu() like hlist_nulls_next_rcu().
>> I'm wondering if defining a macro called hlist_nulls_prev_rcu() might
>> be controversial, since it should actually be getting the prev->next
>> rather than the prev itself.
> See hlist_add_before_rcu() for an example:
>
>      rcu_assign_pointer(hlist_pprev_rcu(n), n);
>
> You can define hlist_nulls_pprev_rcu() and use it alike.
>
>      rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
>
>
> [...]
>> However, I noticed that in the definition of hlist_pprev_rcu(), it directly
>> uses pprev:
>>
>> #define hlist_pprev_rcu(node)    (*((struct hlist_node __rcu **)((node)->pprev)))
> Note it dereferences *((node)->pprev).  The macro is not to iterate the
> lengthy cast.

Thank you for the quick and clear explanation!

I'll apply these changes in the next version.

Appreciate it!


