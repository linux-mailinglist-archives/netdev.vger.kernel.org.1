Return-Path: <netdev+bounces-118642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FB952583
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6BEB2411F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC52154425;
	Wed, 14 Aug 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vJSUE2Zm"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B01494D6
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673915; cv=none; b=mXWiX3GgRL7KtLuP5VFTTk4acIZ/8fbIl+P6KSjQDnUbY322eixMxd5Wb6E72GqvsnZ8pyDvfcNMKIo/lvhCfpE4UF3MbACKeFyiIC92VaKUso+PnJMr9Mvq5zN26Y/I+yZYR6PrGyBY+b+pEN9+98YwT2HoDQvjPS7+u+bq02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673915; c=relaxed/simple;
	bh=f+u3erEYHc1AR9gHz9h4l94phSY7T1Pt4bptigB4+ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lfLXY430QL6TJ0yd1GhBO2ROCZ5YKwhYcIVi2kMvYADAe/xC/M/TqqpjLNGHJ5uyCl+s2DsDiN27JnyICRZKrUglu0VNRI8WcoeLXnBqL2plByyW79YNXAGA1Kk7B/6Gdr6/1r5rOeYWqGT+E5O6EQmW1ACO2Csn3vW0knTPwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vJSUE2Zm; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E85C02C0184;
	Thu, 15 Aug 2024 10:18:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1723673903;
	bh=Ob7hycpQZiFTwVZJ6GKkIKWCmplsVU2v0JMdXX34hUM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vJSUE2ZmOCtATlfiBUJTdNxwloW+nwbOM4+4Ngcko8d4vAwYUeeSKOwyI8+TtgRl9
	 zbrC/Fb//QX5TI205JA0IRT0XKoCeV2rM3ymZrkd4cKr+EFtYk247zqolQPnW+wh48
	 dmu5e49RK1VHHAliHhRoB7hfomEvxyMLZCcB6iNlPTI+hraS0/tGranOoScVIJolvn
	 WIk59JQ/3pq4AWFYWvBOvZb6cxWTR08ylPfyHeTKib6BPh7Awu2h+4CQ1L5u/pT/GQ
	 PKa+RjiPZ1jT9OZwgyHrO5yzGoo52aVGGiErSppP+2YkHXVre3vIWfQa3mnI70rUY1
	 wiWLZ3VimUrbg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66bd2d2f0000>; Thu, 15 Aug 2024 10:18:23 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id CA4BA13EE40;
	Thu, 15 Aug 2024 10:18:23 +1200 (NZST)
Message-ID: <d3244cef-9c6b-4bba-b184-4139f12224df@alliedtelesis.co.nz>
Date: Thu, 15 Aug 2024 10:18:23 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: understanding switchdev notifications
To: Tobias Waldekranz <tobias@waldekranz.com>, netdev
 <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d5c526af-5062-42ed-9d92-f7fc97a5d4bd@alliedtelesis.co.nz>
 <87jzgjfvcl.fsf@waldekranz.com>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <87jzgjfvcl.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIj5D0Fo c=1 sm=1 tr=0 ts=66bd2d2f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=S1RzVMCQbXe0KZFGlIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=aOckU8jMy-YA:10 a=pAl8zCnWZt0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Tobias,

On 14/08/24 18:54, Tobias Waldekranz wrote:
> On tor, aug 08, 2024 at 12:48, Chris Packham <chris.packham@alliedteles=
is.co.nz> wrote:
>> Hi,
>>
>> I'm trying to get to grips with how the switchdev notifications are
>> supposed to be used when developing a switchdev driver.
>>
>> I have been reading through
>> https://www.kernel.org/doc/html/latest/networking/switchdev.html which
>> covers a few things but doesn't go into detail around the notifiers th=
at
>> one needs to implement for a new switchdev driver (which is probably
>> very dependent on what the hardware is capable of).
>>
>> Specifically right now I'm looking at having a switch port join a vlan
>> aware bridge. I have a configuration something like this
>>
>>   =C2=A0=C2=A0=C2=A0 ip link add br0 type bridge vlan_filtering 1
>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p5 master br0
>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p1 master br0
>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev br0 self
>>   =C2=A0=C2=A0=C2=A0 ip link add link br0 br0.2 type vlan id 2
>>   =C2=A0=C2=A0=C2=A0 ip addr add dev br0.2 192.168.2.1/24
>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan5 pvid untagged
>>   =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan1
>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p5 up
>>   =C2=A0=C2=A0=C2=A0 ip link set sw1p1 up
>>   =C2=A0=C2=A0=C2=A0 ip link set br0 up
>>   =C2=A0=C2=A0=C2=A0 ip link set br0.2 up
>>
>> Then I'm testing by sending a ping to a nonexistent host on the
>> 192.168.2.0/24 subnet and looking at the traffic with tcpdump on anoth=
er
>> device connected to sw1p5.
>>
>> I'm a bit confused about how I should be calling
>> switchdev_bridge_port_offload(). It takes two netdevs (brport_dev and
>> dev) but as far as I've been able to see all the callers end up passin=
g
>> the same netdev for both of these (some create a driver specific brpor=
t
>> but this still ends up with brport->dev and dev being the same object)=
.
> In the simple case when a switchport is directly attached to a bridge,
> brport_dev and dev will be the same. If the attachment is indirect, via
> a bond for example, they will differ:
>
>         br0
>         /
>      bond0
>     /    \
> sw1p1  sw1p5
>
> In the setup above, the bridge has no reference to any sw*p* interfaces=
,
> all generated notifications will reference "bond0". By including the
> switchdev port in the message back to the bridge, it can perform
> validation on the setup; e.g. that bond0 is not made up of interfaces
> from different hardware domains.

Ah that makes sense. I haven't got to bonds yet so I hadn't hit that case=
.

>> I've figured out that I need to set tx_fwd_offload=3Dtrue so that the
>> bridge software only sends one packet to the hardware. That makes sens=
e
>> as a way of saying the my hardware can take care of sending the packet
>> out the right ports.
>>
>> I do have a problem that what I get from the bridge has a vlan tag
>> inserted (which makes sense in sw when the packet goes from br0.2 to
>> br0). But I don't actually need it as the hardware will insert a tag f=
or
>> me if the port is setup for egress tagging. I can shuffle the Ethernet
>> header up but I was wondering if there was a way of telling the bridge
>> not to insert the tag?
> Signaling tx_fwd_offload=3Dtrue means assuming responsibility for
> delivering each packet to all ports that the bridge would otherwise hav=
e
> sent individual skbs for.
>
> Let's expand your setup slightly, and see why you need the tag:
>
>     br0.2 br0.3
>         \ /
>         br0
>        / |  \
>       /  |   \
> sw1p1 sw1p3  sw1p5
> (2U)  (3U)  (2T,3T)
>
> sw1p5 is now a trunk. We can trigger an ARP broadcast to be sent out
> either via br0.2 or br0.3, depending on the subnet we choose to target.
>
> Your driver will receive a single skb to transmit, and skb->dev can be
> set to any of sw1p{1,3,5} depending on config order, FDB entries
> (i.e. the order of previously received packets) etc., and is thus
> nondeterministic.
>
> So presumably, even though you might need to remove the 802.1Q tag from
> the frame, you need some way of tagging the packet with the correct VID
> in order for the hardware to do the right thing; possibly via a field i=
n
> the vendor's hardware specific tag.

I did eventually find NETIF_F_HW_VLAN_CTAG_TX which stops the packet=20
data coming down to the switch driver with a vlan tag inserted. The=20
intended egress vlan is still available via skb_vlan_tag_get_id() so I=20
can add it to hardware specific tag (which for me is part of the TX DMA=20
descriptor) and I don't need to shuffle any bytes around which is great.

>> Finally I'm confused about the atomic_nb/atomic_nb parameters. Some
>> drivers just pass NULL and others pass the same notifier blocks that
>> they've already registered with
>> register_switchdev_notifier()/register_switchdev_notifier(). If
>> notifiers are registered why does switchdev_bridge_port_offload() take
>> them as parameters?
> Because when you add a port to the bridge, lots of stuff that you want
> to offload might already have been configured. E.g., imagine that you
> were to add vlan 2 to br0 before adding the switchports; then you
> probably need those events to be replayed to the new ports in order to
> add your CPU-facing switchport to vlan 2. However, we do not want to
> bother existing bridge members with duplicated events (and risk messing
> up any reference counters they might maintain for these
> objects). Therefore we bypass the standard notifier calls and "unicast"
> the replay events only to the driver for the port being added.

This part I still don't get. I understand that there may be scenarios=20
where switchdev decides it needs to unicast events to a specific device.=20
But why does the caller of switchdev_bridge_port_offload() need to make=20
that distinction?

>> Thanks,
>> Chris

