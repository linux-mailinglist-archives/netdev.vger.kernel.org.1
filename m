Return-Path: <netdev+bounces-102271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8690228E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7AD1C2139B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81C823CE;
	Mon, 10 Jun 2024 13:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B084501B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025674; cv=none; b=iUuuQ2ZIllSq3wWCTVHVqPUz6EkX+FCKsNvNGbiZ89lO9PHHlFCzWrBz9F/V54sd8XoBOzX1SBynarAw25d5kMfnTJIHZI6MOy7NzxZD7thhHhK+vzdmdkjDcN+6layGHQpd6J1CoSHwU1DXe5yBG85CDQRtnoko4raXe3jz1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025674; c=relaxed/simple;
	bh=tOiwEBHts0oT/8P37DuskyT1S9KW+1A5DPlGOTAg0S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbBMI5Ij0ZeYPJ31xzfVrcTqvn/s4GdngJJQtojQVVyfBqYtwcQF3LnKT5nWYFIuCsXu/QtZRZ0gp/0fE8uEl6INIxo7ni4xj0JogSbvTjm7gL51WdifBVJs6ZO1xI6S2nT15nzAwDiiJVezh9cWj8V0QkFvsacLt3kseJR76DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45ADL9kU063277;
	Mon, 10 Jun 2024 22:21:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 10 Jun 2024 22:21:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45ADL9r9063274
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 10 Jun 2024 22:21:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <92ac2300-b1ba-44b0-98a0-c6ab084dfddd@I-love.SAKURA.ne.jp>
Date: Mon, 10 Jun 2024 22:21:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in
 __netlink_dump_start()
To: Eric Dumazet <edumazet@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-7-edumazet@google.com> <Zdd0SWlx4wH-sXbe@nanopsycho>
 <cbbd6e2d-39da-4da3-b239-1248ac8ded10@I-love.SAKURA.ne.jp>
 <628624ea-d815-4866-9711-70d096ea801d@I-love.SAKURA.ne.jp>
 <CANn89iJ34qOSiy7RFzqML-hSS5beniQCcKqP3nOERXKxt0RB1A@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iJ34qOSiy7RFzqML-hSS5beniQCcKqP3nOERXKxt0RB1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/06/10 21:59, Eric Dumazet wrote:
> On Sun, Jun 9, 2024 at 10:29 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2024/06/09 17:17, Tetsuo Handa wrote:
>>> Hello.
>>>
>>> While investigating hung task reports involving rtnl_mutex, I came to
>>> suspect that commit b5590270068c ("netlink: hold nlk->cb_mutex longer
>>> in __netlink_dump_start()") is buggy, for that commit made only
>>> mutex_lock(nlk->cb_mutex) side conditionally. Why don't we need to make
>>> mutex_unlock(nlk->cb_mutex) side conditionally?
>>>
>>
>> Sorry for the noise. That commit should be correct, for the caller
>> no longer calls mutex_unlock(nlk->cb_mutex).
>>
>> I'll try a debug printk() patch for linux-next.
> 
> I also have a lot of hung task reports as well, but in most reports
> the console is flooded
> before the crashes.

Yeah, printk() flooding is the cause of some of hung task reports.

I queued https://sourceforge.net/p/tomoyo/tomoyo.git/ci/c2bfadd666b5852974071df0588d7eb0f499b7b5/
for linux-next.git . You can try this patch to see what the owner of rtnl_mutex is doing.


