Return-Path: <netdev+bounces-103455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34A9082D1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46281C22158
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFE12C7E3;
	Fri, 14 Jun 2024 04:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F24146A6F
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337657; cv=none; b=UWAsqmFsnUVVDnhmm2S7EV8tkbmxarB+IDVXb5Fq+Vtho9q2S4wFtFuaxQIWpHGocIqn5GI6xANG0iBekbkPc6b26YXinJnUmnVIKwOzfaf/DZU7CPqMm+iWqxx2m78smoQKXwJp+ZasOv9EGkzT1F9OovmGXhwJ8Lry5fib4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337657; c=relaxed/simple;
	bh=YD/hzsHGKMaPc9AEbzcC6z/zcPMYzbpxMvd818N27SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1sYByqpsnJrS360dmlWfT/F10X4DTxHsRzJgpcnuwca2YfExhfGlGjq1txi9yfXvyHO7BfPIjSkg6yaPjsUodELApQu9geOc7gPzEKi3vayt6H7jQSHSaZB9rnSRYcajdeKl6NiOF6CNpT4OEJREXslvq2UFd22cctBBI868SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45E40WLc079668;
	Fri, 14 Jun 2024 13:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 14 Jun 2024 13:00:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45E40WRc079665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Jun 2024 13:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <522c0b17-c515-475d-8224-637ca0eaf6a2@I-love.SAKURA.ne.jp>
Date: Fri, 14 Jun 2024 13:00:30 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net/sched] Question: Locks for clearing ERR_PTR() value from
 idrinfo->action_idr ?
To: Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
 <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/14 11:47, Pedro Tammela wrote:
> On 13/06/2024 21:58, Tetsuo Handa wrote:
>>
>> Is there a possibility that tcf_idr_check_alloc() is called without holding
>> rtnl_mutex?
> 
> There is, but not in the code path of this reproducer.
> 
>> If yes, adding a sleep before "goto again;" would help. But if no,
>> is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?
> 
> The reproducer is sending a new action message with 2 actions.
> Actions are committed to the idr after processing in order to make them visible
> together and after any errors are caught.
> 
> The bug happens when the actions in the message refer to the same index. Since
> the first processing succeeds, adding -EBUSY to the index, the second processing,
> which references the same index, will loop forever.
> 
> After the change to rely on RCU for this check, instead of the idr lock, the hangs
> became more noticeable to syzbot since now it's hanging a system-wide lock.

Thank you for explanation. Then, what type of sleep do we want?

schedule_timeout_uninteruptible(1)
(based on an assumption that conflict will be solved shortly) ?

wait_event()/wake_up_all() using one global waitqueue
(based on an assumption that conflict is rare) ?

wait_event()/wake_up_all() using per struct tcf_idrinfo waitqueue
(based on an assumption that conflict might not be rare) ?


