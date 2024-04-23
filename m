Return-Path: <netdev+bounces-90521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBD8AE5A2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E1B1C22EFE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375982888;
	Tue, 23 Apr 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="anjvbReb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B4824B1
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874186; cv=none; b=tHAJvuTEZ1W4S182cs1ajcBJ/yyB3Ub9T7FmI8v6lBHJw0zPAAgaXCw2lBKHCvyxamtk4WE02cQOcW6u2CUkHIWn+atVHunzqHTa2ALhzDTQEW3ZI4G+mEdfPxZTb02XCeKeksIg2tzVkmT9D3z5fO5hKJZZfDBlpnV+4r/G17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874186; c=relaxed/simple;
	bh=DKRem/apoFkELqSt4RevS4XvEsKV5xl0jVjAX8BiRdA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=c2YJ/9ZkNp99H/sehntBIp9h47KyJEiydjoLx/0rMPVaJV5WEOup+Tf7v5+4Sbr8i0woIrRkp50ldzYdSaN812S2U816wXPgdbFCoIjTgUlCyIwFRL+jUu6Ooqja3pvHO4ScH+aXTUgidkMhho2VDkNb3paDsxpINLXhHBNZw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=anjvbReb; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:708d:7839:ba7f:c289] (unknown [IPv6:2a02:8010:6359:2:708d:7839:ba7f:c289])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1B5D57D965;
	Tue, 23 Apr 2024 13:03:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1713873825; bh=DKRem/apoFkELqSt4RevS4XvEsKV5xl0jVjAX8BiRdA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<1dec3124-de04-1d69-79cb-16d3ea237e5f@katalix.com>|
	 Date:=20Tue,=2023=20Apr=202024=2013:03:44=20+0100|MIME-Version:=20
	 1.0|To:=20David=20Bauer=20<mail@david-bauer.net>,=20Daniel=20Golle
	 =20<daniel@makrotopia.org>|Cc:=20davem@davemloft.net,=20edumazet@g
	 oogle.com,=20kuba@kernel.org,=0D=0A=20pabeni@redhat.com,=20netdev@
	 vger.kernel.org|References:=20<20240420133940.5476-1-mail@david-ba
	 uer.net>=0D=0A=20<ZiPLEdv97kX39k21@makrotopia.org>=0D=0A=20<5aaa43
	 fb-cc44-4af8-8c78-201bcc04ea00@david-bauer.net>|From:=20James=20Ch
	 apman=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCH=20net-next]
	 =20net=20l2tp:=20drop=20flow=20hash=20on=20forward|In-Reply-To:=20
	 <5aaa43fb-cc44-4af8-8c78-201bcc04ea00@david-bauer.net>;
	b=anjvbReb3syQP51bEMhadg+54pEXzJa1JmxoT625o2vAt7DYiey+drX51GAuXH7c8
	 4ZgMo1cv7Bw4hmX52zY7wMhj6vhjzitaLHP7C9C0RmIZucu+di81ALzb2YNDvh4Itr
	 R7asad5iQXGIf8qj6G/QQ2+HQmo4ETCsyLRsaJk9iyQOFSd0FrP/ce0zZXk2H45P6h
	 am8My+fEjUIAvJPl6phNpC1RJI0cwhVkbp69iWHrYnZrB7yNbyQq6OdJ5IlWTp3f/X
	 Ve3U+YG9Z4kRaiHQRMavzulmZVdnhGSco7FHIHhCPi7PAVFCOl2aT1AbLESXViv2VA
	 IDVvReYvX4s1Q==
Message-ID: <1dec3124-de04-1d69-79cb-16d3ea237e5f@katalix.com>
Date: Tue, 23 Apr 2024 13:03:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: David Bauer <mail@david-bauer.net>, Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240420133940.5476-1-mail@david-bauer.net>
 <ZiPLEdv97kX39k21@makrotopia.org>
 <5aaa43fb-cc44-4af8-8c78-201bcc04ea00@david-bauer.net>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next] net l2tp: drop flow hash on forward
In-Reply-To: <5aaa43fb-cc44-4af8-8c78-201bcc04ea00@david-bauer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/04/2024 15:39, David Bauer wrote:
> Hi Daniel,
>
> On 4/20/24 16:02, Daniel Golle wrote:
>> On Sat, Apr 20, 2024 at 03:39:40PM +0200, David Bauer wrote:
>>> Drop the flow-hash of the skb when forwarding to the L2TP netdev.
>>>
>>> This avoids the L2TP qdisc from using the flow-hash from the outer
>>> packet, which is identical for every flow within the tunnel.
>>>
>>> This does not affect every platform but is specific for the ethernet
>>> driver. It depends on the platform including L4 information in the
>>> flow-hash.
>>>
>>> One such example is the Mediatek Filogic MT798x family of networking
>>> processors.
>>>
>>> Signed-off-by: David Bauer <mail@david-bauer.net>
>>
>> While it's difficult to say which exact commit this fixes, I still
>> consider it being a fix, as otherwise flow-offloading on mentioned
>> platforms will face difficulties when using L2TP (right?).
>
> I'm unsure whether flow-offloading is affected. What is definitely 
> affected are
> network schedulers which rely on flow-information (such as fq_codel or 
> cake)
>
>> Hence maybe it should go via 'net' tree rather than via 'net-next'?
>
> I was unsure where to send, i can resend it on net if it is more 
> appropriate.

This has been missing since L2TP ethernet support was first added. 
Thanks for reporting it!

If you need a Fixes tag, I suggest: d9e31d17ceba5 ( "l2tp: Add L2TP 
ethernet pseudowire support" )

Acked-by: James Chapman <jchapman@katalix.com>


>
> Best
> David
>
>>
>> The fix itself looks fine to me.
>>
>>> ---
>>>   net/l2tp/l2tp_eth.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
>>> index 39e487ccc468..8ba00ad433c2 100644
>>> --- a/net/l2tp/l2tp_eth.c
>>> +++ b/net/l2tp/l2tp_eth.c
>>> @@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct 
>>> l2tp_session *session, struct sk_buff *skb,
>>>       /* checksums verified by L2TP */
>>>       skb->ip_summed = CHECKSUM_NONE;
>>>   +    /* drop outer flow-hash */
>>> +    skb_clear_hash(skb);
>>> +
>>>       skb_dst_drop(skb);
>>>       nf_reset_ct(skb);
>>>   --
>>> 2.43.0
>>>
>>>
>


