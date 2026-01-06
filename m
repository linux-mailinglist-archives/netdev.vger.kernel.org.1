Return-Path: <netdev+bounces-247340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AE0CF7D1A
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 11:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 146913021A6F
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009DE34106A;
	Tue,  6 Jan 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="smQWWFRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E69340287
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695430; cv=none; b=Yr7wA4EJU4To83igzZvLgYaYlmEkBR3GmweN5wYYgZ0eklQD445vbV1mGsBsFiWAht/EwWQfhqtic79HkOwMRTOZ6CEFGaHAZROUoyXTHJ+gAxAFXD/BiTEfzDmFHJYwAl8NhGBr8eZJPXRFywj7mRjaaNwztkK1X9f3R4DWDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695430; c=relaxed/simple;
	bh=uqx4UNio5IZHh0domM8JuvlnEo/PhdnFDKl+/fCu09A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4TIXVjydTeq6nPHzFui0Hyro2z/1+RxG2fBlrDUg7jKgkc4gJh9XOHu+IAOGH7+G7eAlAmuVg1WMRd9u1NwSnhKBfR8oDOcqSBkmIGD1O0+qVAKUnlgv7JgYDjWnyqr8QzaFm2adIdXNcm7ymimU7efwxOGctK+0avw9gzF72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=smQWWFRk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1767695424; bh=uqx4UNio5IZHh0domM8JuvlnEo/PhdnFDKl+/fCu09A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=smQWWFRkFDf0Yzu3ZSqtvimCM8d5274H0RdCyWUTgtRYG3s7HC60EziqBPvGRILfo
	 tmSP3ZqsPqrNeBQj9jRLdparj6mUkD66dmNE0CsRM8ylbOYWtxhLT+n7f/eTMoHJgT
	 DduSqs4LG02I8/ZV+ctmKj8vJZ4hG/AE551e44VyHaK/A4nudxX/ikjQMxNOrzuFMX
	 J385VqHdTUFoL6Cz9EjbQKcsZlbMwXp4la/2ESaljJ1SPYN/K1KW2omV4gPDo82GWC
	 u7oMVzCC/M42w1BGzG0Ri1yDqOEAftkGmxquO+bnvsb3KupWXUvrH2qJ+aQUdaMAZr
	 qpGbi7+lSxLuQ==
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
In-Reply-To: <04a4cfc3-ca15-49cf-89c1-17a4bc374caa@mojatatu.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
 <20260105-mq-cake-sub-qdisc-v5-6-8a99b9db05e6@redhat.com>
 <04a4cfc3-ca15-49cf-89c1-17a4bc374caa@mojatatu.com>
Date: Tue, 06 Jan 2026 11:30:23 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875x9f58zk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Victor Nogueira <victor@mojatatu.com> writes:

> On 05/01/2026 09:50, Toke H=C3=83=C2=B8iland-J=C3=83=C2=B8rgensen wrote:
>> From: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>> [...]
>> Test 18e0: Fail to install CAKE_MQ on single queue device
>>  [...]
>> +    {
>> +        "id": "18e0",
>> +        "name": "Fail to install CAKE_MQ on single queue device",
>> +        "category": [
>> +            "qdisc",
>> +            "cake_mq"
>> +        ],
>> +        "plugins": {
>> +            "requires": "nsPlugin"
>> +        },
>> +        "setup": [
>> +            "echo \"1 1 1\" > /sys/bus/netdevsim/new_device"
>> +        ],
>> +        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq",
>> +        "expExitCode": "2",
>> +        "verifyCmd": "$TC qdisc show dev $ETH",
>> +        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4])=
 bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter sp=
lit-gso rtt 100ms raw overhead 0 ",
>> +        "matchCount": "0",
>> +        "teardown": []
>
> Hi!
>
> This test is missing the device deletion on the teardown stage.

Ah, oops; will fix and respin, thanks for catching this!

-Toke

