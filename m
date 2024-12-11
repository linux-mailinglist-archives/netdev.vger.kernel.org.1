Return-Path: <netdev+bounces-151053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB379EC962
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF8A18825D8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827E1A83FE;
	Wed, 11 Dec 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="lwA3jy5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25664236FB6
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910206; cv=none; b=svi1jF08yqzqCRaYC2sjr90rOlivGygpXOG4w8QwDkEjhJ+DvdUNAQUSXa3aWWyjXqGPuB6OmY/y5jyx8Ad+kFvGuIR2pulNcBo1yVV/3WeTxIZ3yjsqG/rWafi+5jR0Bn6bhkUtoaT4mttLizqxIDaFmKZwQuUZgkCbTvYMabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910206; c=relaxed/simple;
	bh=fjay/P8NW6O9+UbSe7xhuqU3lBYGjE2l8y6uvwci7VY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=EvnPAbkWRbX3eGWF0Lh5jG+L5PTozZlusMjSvSI8cmtDLq0dtIhYRp4e/9JvXtRir2I1z7rHnhIKjjQsfAB32aCaf6UiPJ+1sJ6LRXU3T0qTeEFrGgBkr96YI8Q8ZEQW2BQNL+31ApivZq8m7LDZp/z7Tj0Sa/b/7pN8rERiYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=lwA3jy5j; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:9c63:293c:9db9:bde3] (unknown [IPv6:2a02:8010:6359:2:9c63:293c:9db9:bde3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C855B7DCB8;
	Wed, 11 Dec 2024 09:43:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1733910196; bh=fjay/P8NW6O9+UbSe7xhuqU3lBYGjE2l8y6uvwci7VY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<682346f6-5a19-1b09-c201-9ab210643ca0@katalix.com>|
	 Date:=20Wed,=2011=20Dec=202024=2009:43:16=20+0000|MIME-Version:=20
	 1.0|To:=20Preston=20<preston@yourpreston.com>|Cc:=20netdev=20<netd
	 ev@vger.kernel.org>|References:=20<CABBfiem067qtdVbMeq2bGrn-5bKZsy
	 _M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>=0D=0A=20<3e6af55f-3270-604b-c
	 134-456200188f94@katalix.com>=0D=0A=20<CABBfie=3D3+NBmjpVHn8Ji7Vak
	 Eo9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>=0D=0A=20<ed0ffb72-3848-
	 d1be-6903-d6ab21a0f77f@katalix.com>=0D=0A=20<CABBfienZDG=3DkFMfGe=
	 3DAwa4ZhuhGTRRy7uGcPjWaZLiGi+XWBDA@mail.gmail.com>|From:=20James=2
	 0Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20ethernet=20over
	 =20l2tp=20with=20vlan|In-Reply-To:=20<CABBfienZDG=3DkFMfGe=3DAwa4Z
	 huhGTRRy7uGcPjWaZLiGi+XWBDA@mail.gmail.com>;
	b=lwA3jy5jaFvJsySx2mEWkRWEODqw134GfwKaQ6RRsXkADKAme0IgxrAVpyTJDjp7i
	 0QVFQAsbWBKJ/9s4iVsHdkrue37wiqxBzkv7EzwzRR8fYF0MPZMjR0OQysVbUbE3Nx
	 FNABkVFiMunVFKCrfVpl2O+2ioOcPLLe1iIlQE6I0vVHQISpqEi+KBuWB5Pb9zX8Py
	 X88uWhZ8Ll1h1I5DDwk1hjvw7Yu33SH7iahPNxsBTCc9JnHOCm4ArJQnEnCfKDRsQV
	 kKI4ro4g9EtWbS3EkV+debluk+uM3BQ90oTZs2+RlWsCOYmxxysbnSHPyesfPCaqmG
	 sdU/7PXRrzOMA==
Message-ID: <682346f6-5a19-1b09-c201-9ab210643ca0@katalix.com>
Date: Wed, 11 Dec 2024 09:43:16 +0000
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
 <ed0ffb72-3848-d1be-6903-d6ab21a0f77f@katalix.com>
 <CABBfienZDG=kFMfGe=Awa4ZhuhGTRRy7uGcPjWaZLiGi+XWBDA@mail.gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: ethernet over l2tp with vlan
In-Reply-To: <CABBfienZDG=kFMfGe=Awa4ZhuhGTRRy7uGcPjWaZLiGi+XWBDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2024 20:00, Preston wrote:
> On Thu, Dec 5, 2024 at 3:00 AM James Chapman <jchapman@katalix.com> wrote:
>> Please don't top-post.
> Apologies, first timer.
>> Are you configuring an IP address on l2tpeth0.1319 and capturing on
> l2tpeth0?
> I'm running dhclient on  l2tpeth0.1319, the DHCP discover from that is
> the packet you see in the screenshot. The pcap is being taken on the
> physical interface.

You've top-posted again! Don't c&p parts of text to the top of emails 
when replying. Please see https://subspace.kernel.org/etiquette.html

I'll add your reply text below and answer there, in the interest of 
making progress.
> 
> 
>>
>> On 04/12/2024 21:04, Preston wrote:
>>> l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
>>> commands. But since it's encapsulating and setting a new destination
>>> IP address, packets are referred to the route table.
>>
>> Please don't top-post. It makes it much harder for other readers to
>> follow the discussion. I'll repaste your reply below this time.
>>
>>> On Wed, Dec 4, 2024 at 6:48 AM James Chapman <jchapman@katalix.com> wrote:
>>>>
>>>> On 03/12/2024 16:14, Preston wrote:
>>>>> Hello folks, please let me know if there’s a more appropriate place to
>>>>> ask this but I believe I’ve found something that isn’t supported in
>>>>> iproute2 and would like to ask your thoughts.
>>>>
>>>> Thanks for reaching out.
>>>>
>>>>> I am trying to encapsulate vlan tagged ethernet traffic inside of an
>>>>> l2tp tunnel.This is something that is actively used in controllerless
>>>>> wifi aggregation in large networks alongside Ethernet over GRE. There
>>>>> are draft RFCs that cover it as well. The iproute2 documentation I’ve
>>>>> found on this makes it seem that it should work but isn’t explicit.
>>>>>
>>>>> Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
>>>>> work with GRE without issue. L2tp on the other hand seems to quietly
>>>>> drop the vlan header. I’ve tried doing the same with a bridge type
>>>>> setup and still see the same behavior. I've been unsuccessful in
>>>>> debugging it further, I don’t think the debug flags in iproute2's
>>>>> ipl2tp.c are functional and I suppose the issue might instead be in
>>>>> the kernel module which isn’t something I’ve tried debugging before.
>>>>> Is this a bug? Since plain ethernet over l2tp works I assumed vlan
>>>>> support as well.
>>>>>
>>>>>
>>>>> # Not Working L2TP:
>>>>> [root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap
>>>>> udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
>>>>> [root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_session_id 1
>>>>> [root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vlan id 1319
>>>>> [root@iperf1 ~]# ip link set l2tpeth0 up
>>>>> [root@iperf1 ~]# ip link set l2tpeth0.1319 up
>>>>> Results: (captured at physical interface, change wireshark decoding
>>>>> l2tp value 0 if checking yourself)
>>>>> VLAN header dropped
>>>>> Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png
>>>>
>>>> This should work.
>>>>
>>>> In your test network, how is the virtual interface l2tpeth0 connected to
>>>> the physical interface which you are using to capture packets?
>>   >
>>   > l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
>>   > commands. But since it's encapsulating and setting a new destination
>>   > IP address, packets are referred to the route table.
>>
>> Are you configuring an IP address on l2tpeth0.1319 and capturing on
>> l2tpeth0?

> l2tpeth0?

Yes.

> I'm running dhclient on  l2tpeth0.1319, the DHCP discover from that is
> the packet you see in the screenshot. The pcap is being taken on the
> physical interface.

Which physical interface? Please share your tcpdump/wireshark/other 
command line to show which interface you are capturing packets on.

If you capture on l2tpeth0.1319, you will see untagged packets carried 
over l2tpeth0 on VLAN 1319.

If you capture on l2tpeth0, you will see all packets carried over 
l2tpeth0, with VLAN tags, if any. In your case, you should see tagged 
packets of VLAN 1319.

If you capture on the network interface used by the L2TP tunnel, you 
will see the L2TP packets with their tunnel IP header.

>>
>>>>
>>>>>
>>>>>
>>>>> # Working GRE:
>>>>> [root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
>>>>> [root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
>>>>> 802.1q id 120
>>>>> [root@iperf1 ~]# ip link set gre1 up
>>>>> [root@iperf1 ~]# ip link set gre1.120 up
>>>>> Results:
>>>>> VLAN header present
>>>>> Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png
>>>>>
>>>>>
>>>>> -------------------------------------------------------
>>>>> ~Preston Taylor
>>>>>
>>>>
>>>
>>
> 
> 
> --
> -------------------------------------------------------
> ~Preston Taylor


