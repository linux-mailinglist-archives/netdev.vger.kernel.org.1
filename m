Return-Path: <netdev+bounces-149261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C119A9E4F0C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C558161945
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A31C7B62;
	Thu,  5 Dec 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="R2whUccQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4F1C5799
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385609; cv=none; b=FIR+gUnKFs9B2X5PQCoEoC/D55ha4bhQ148EAp0pZdBujN3fqY7UzrlI6gCMVuMo4gu4FYLz01d4t0YYZ6ZuCQVScae/+xH+d3milAcjaX54YgioynxfrO8F2mMMeen0d+sR9xLsNegQIz16Jq7V1Fe85DajCvG7jNVtt6EP7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385609; c=relaxed/simple;
	bh=kL7pEKBBJtnWKca+DEkPqpnopJI7pltEg6bMWuR80r8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=E5Of9TFojHFOWsAhI/HPljvHRX8v33/aHT0F/9BepbA4EBnifOWjwi0r1DaMB0GEXVriJL5jX9welUtBS4t8gDEI4NuXnHM1r29TZdXY+BUDChot5renhirIgOGW0P4KCdxkTJkp/Z+QlGRizdYYXMKPrH0bEcmsrQWAIIE6584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=R2whUccQ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:9c63:293c:9db9:bde3] (unknown [IPv6:2a02:8010:6359:2:9c63:293c:9db9:bde3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 88CC27DD24;
	Thu,  5 Dec 2024 08:00:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1733385605; bh=kL7pEKBBJtnWKca+DEkPqpnopJI7pltEg6bMWuR80r8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<ed0ffb72-3848-d1be-6903-d6ab21a0f77f@katalix.com>|
	 Date:=20Thu,=205=20Dec=202024=2008:00:05=20+0000|MIME-Version:=201
	 .0|To:=20Preston=20<preston@yourpreston.com>|Cc:=20netdev=20<netde
	 v@vger.kernel.org>|References:=20<CABBfiem067qtdVbMeq2bGrn-5bKZsy_
	 M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>=0D=0A=20<3e6af55f-3270-604b-c1
	 34-456200188f94@katalix.com>=0D=0A=20<CABBfie=3D3+NBmjpVHn8Ji7VakE
	 o9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>|From:=20James=20Chapman=
	 20<jchapman@katalix.com>|Subject:=20Re:=20ethernet=20over=20l2tp=2
	 0with=20vlan|In-Reply-To:=20<CABBfie=3D3+NBmjpVHn8Ji7VakEo9-JMKDH3
	 ut5d1nXnDneC0tPw@mail.gmail.com>;
	b=R2whUccQF6GAdbOPedBmKibG7d7L9RhTZ91lzHolIpaa/cVQv9G0fkS2QCahl4l7A
	 CQG34ZG8bIqhmTYBkySXvrOPuV9dh1dOV9kMV/B6cF2in5UDQfrwtmFPfo91lhV4uM
	 ArB1lybCIC7/ZABlxki5GRb/Ar/+NcVqtRdX8YkPrVr133HoE2wyCXer4YnA2LE5xS
	 Wg7wsT0kydVOPnd+9ytSIe6qqCc1X5JdUjdE1rrf3TG/VIABzspXqetJu1GD5iHhrm
	 ANBmxbYECqQsd4ls/uLA9svDUQKP2r6WsIo5qAGjjjcfAcJcR0OWBcLklxs6snb+57
	 MQMZFfQc0FLKw==
Message-ID: <ed0ffb72-3848-d1be-6903-d6ab21a0f77f@katalix.com>
Date: Thu, 5 Dec 2024 08:00:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Preston <preston@yourpreston.com>
Cc: netdev <netdev@vger.kernel.org>
References: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
 <3e6af55f-3270-604b-c134-456200188f94@katalix.com>
 <CABBfie=3+NBmjpVHn8Ji7VakEo9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: ethernet over l2tp with vlan
In-Reply-To: <CABBfie=3+NBmjpVHn8Ji7VakEo9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 21:04, Preston wrote:
> l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
> commands. But since it's encapsulating and setting a new destination
> IP address, packets are referred to the route table.

Please don't top-post. It makes it much harder for other readers to 
follow the discussion. I'll repaste your reply below this time.

> On Wed, Dec 4, 2024 at 6:48 AM James Chapman <jchapman@katalix.com> wrote:
>>
>> On 03/12/2024 16:14, Preston wrote:
>>> Hello folks, please let me know if there’s a more appropriate place to
>>> ask this but I believe I’ve found something that isn’t supported in
>>> iproute2 and would like to ask your thoughts.
>>
>> Thanks for reaching out.
>>
>>> I am trying to encapsulate vlan tagged ethernet traffic inside of an
>>> l2tp tunnel.This is something that is actively used in controllerless
>>> wifi aggregation in large networks alongside Ethernet over GRE. There
>>> are draft RFCs that cover it as well. The iproute2 documentation I’ve
>>> found on this makes it seem that it should work but isn’t explicit.
>>>
>>> Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
>>> work with GRE without issue. L2tp on the other hand seems to quietly
>>> drop the vlan header. I’ve tried doing the same with a bridge type
>>> setup and still see the same behavior. I've been unsuccessful in
>>> debugging it further, I don’t think the debug flags in iproute2's
>>> ipl2tp.c are functional and I suppose the issue might instead be in
>>> the kernel module which isn’t something I’ve tried debugging before.
>>> Is this a bug? Since plain ethernet over l2tp works I assumed vlan
>>> support as well.
>>>
>>>
>>> # Not Working L2TP:
>>> [root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap
>>> udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
>>> [root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_session_id 1
>>> [root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vlan id 1319
>>> [root@iperf1 ~]# ip link set l2tpeth0 up
>>> [root@iperf1 ~]# ip link set l2tpeth0.1319 up
>>> Results: (captured at physical interface, change wireshark decoding
>>> l2tp value 0 if checking yourself)
>>> VLAN header dropped
>>> Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png
>>
>> This should work.
>>
>> In your test network, how is the virtual interface l2tpeth0 connected to
>> the physical interface which you are using to capture packets?
 >
 > l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
 > commands. But since it's encapsulating and setting a new destination
 > IP address, packets are referred to the route table.

Are you configuring an IP address on l2tpeth0.1319 and capturing on 
l2tpeth0?

>>
>>>
>>>
>>> # Working GRE:
>>> [root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
>>> [root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
>>> 802.1q id 120
>>> [root@iperf1 ~]# ip link set gre1 up
>>> [root@iperf1 ~]# ip link set gre1.120 up
>>> Results:
>>> VLAN header present
>>> Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png
>>>
>>>
>>> -------------------------------------------------------
>>> ~Preston Taylor
>>>
>>
> 


