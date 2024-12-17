Return-Path: <netdev+bounces-152531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F182A9F47CA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608871884CC6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC11DEFF5;
	Tue, 17 Dec 2024 09:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E811DC19F;
	Tue, 17 Dec 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428513; cv=none; b=rSNvRP4vBs/wINkqOPV0m5/p2mEAW9yFz2Hz79UzifL7XayCGM6Sa6YYPfUzX2KDIr+Kyfrqx2KgJDx/+x+kyPZ82C2f1DwbpQZ+sTuwQg41Czr6DMUYMFycu/SmbtNL5JQwD18n5mjAT04EIpVgi5ZGpwEUWz+zU2blMhMwzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428513; c=relaxed/simple;
	bh=zvXi+zpQ2PSb79YnO5gx+w5GkO569/pAtSaHL7iDBP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyLOQsdfgRSvsIHlOw82WACYFdEyKiLReXphaLZvFKObpG34/FBlhkgK+p2eaWxMndn1Bfpc9bUbJSVpQC4dp4UV2kroNOWUbL1pSu+UUBtA4xrBUN0/W8Q8N5we+SKLDFyWxYqdREEnnzFzFYJ62uTTIqArcABoT0omWWV2JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YCBfP4lvTz9sPd;
	Tue, 17 Dec 2024 10:41:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHsnCo-8gqUl; Tue, 17 Dec 2024 10:41:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YCBfP3mYqz9rvV;
	Tue, 17 Dec 2024 10:41:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DB388B76D;
	Tue, 17 Dec 2024 10:41:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IQiCAtiPD4Ue; Tue, 17 Dec 2024 10:41:49 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D28938B763;
	Tue, 17 Dec 2024 10:41:48 +0100 (CET)
Message-ID: <8e3c9ebc-e047-4dfd-ad1d-6bbe918aa98b@csgroup.eu>
Date: Tue, 17 Dec 2024 10:41:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
 CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com>
 <49a43774-bf97-4b20-8382-4fb921f34c66@csgroup.eu>
 <CANn89iLKPx+=gHaM_V77iwUwzqQe_zyUc0Dm1KkPo3GuE40SRw@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CANn89iLKPx+=gHaM_V77iwUwzqQe_zyUc0Dm1KkPo3GuE40SRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/12/2024 à 10:20, Eric Dumazet a écrit :
> On Tue, Dec 17, 2024 at 9:59 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 17/12/2024 à 09:16, Eric Dumazet a écrit :
>>> On Tue, Dec 17, 2024 at 8:18 AM Christophe Leroy
>>> <christophe.leroy@csgroup.eu> wrote:
>>>>
>>>> The following problem is encountered on kernel built with
>>>> CONFIG_PREEMPT. An snmp daemon running with normal priority is
>>>> regularly calling ioctl(SIOCGMIIPHY). Another process running with
>>>> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.
>>>>
>>>> After some random time, the snmp daemon gets preempted while holding
>>>> the RTNL mutex then the high priority process is busy looping into
>>>> carrier_show which bails out early due to a non-successfull
>>>> rtnl_trylock() which implies restart_syscall(). Because the snmp
>>>> daemon has a lower priority, it never gets the chances to release
>>>> the RTNL mutex and the high-priority task continues to loop forever.
>>>>
>>>> Replace the trylock by lock_interruptible. This will increase the
>>>> priority of the task holding the lock so that it can release it and
>>>> allow the reader of /sys/class/net/eth0/carrier to actually perform
>>>> its read.
>>>>
>>
>> ...
>>
>>>>
>>>> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods.")
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>> ---
>>>
>>> At a first glance, this might resurface the deadlock issue Eric W. Biederman
>>> was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
>>> sysfs methods.")
>>
>> Are you talking about the deadlock fixed (incompletely) by 5a5990d3090b
>> ("net: Avoid race between network down and sysfs"), or the complement
>> provided by 336ca57c3b4e ?
>>
>> My understanding is that mutex_lock() will return EINTR only if a signal
>> is pending so there is no need to set signal_pending like it was when
>> using mutex_trylock() which does nothing when the mutex is already locked.
>>
>> And an EINTR return is expected and documented for a read() or a
>> write(), I can't see why we want ERESTARTNOINTR instead of ERSTARTSYS.
>> Isn't it the responsibility of the user app to call again read or write
>> if it has decided to not install the necessary sigaction for an
>> automatic restart ?
>>
>> Do you think I should instead use rtnl_lock_killable() and return
>> ERESTARTNOINTR in case of failure ? In that case, is it still possible
>> to interrupt a blocked 'cat /sys/class/net/eth0/carrier' which CTRL+C ?
> 
> Issue is when no signal is pending, we have a typical deadlock situation :
> 
> One process A is :
> 
> Holding sysfs lock, then attempts to grab rtnl.
> 
> Another one (B) is :
> 
> Holding rtnl, then attempts to grab sysfs lock.

Ok, I see.

But then what can be the solution to avoid busy looping with 
mutex_trylock , not giving any chance to the task holding the rtnl to 
run and unlock it ?

> 
> Using rtnl_lock_interruptible()  in A will still block A and B, until
> a CTRL+C is sent by another thread.


