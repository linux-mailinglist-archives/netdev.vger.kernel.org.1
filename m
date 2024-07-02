Return-Path: <netdev+bounces-108314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26E91ECE5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B681F22861
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E67C2F2;
	Tue,  2 Jul 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="acgWr6EG"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA476FCB
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719886180; cv=none; b=QIQ5YVYizgq16zxc/FniAHGgX/+bNxfcENfSFqaGw8mqL6c2SIAbTo14fImJ1izvzyac0/pIFFsBDNPmLCkBKB5sjAq50J1lAyMd0DJPn32+3zcIRNay6olP1wsa3qC6ubeHew9Cobc1ms0JAoLTvqjEl9uXqhkSbu5WFYXMYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719886180; c=relaxed/simple;
	bh=1p5SSAb7qWtnxkRYsNQrcwnlK8Do+lQhJ411E3url84=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mznbWuN81k1nZjhfdRHC+d91AHi0PZttm04niVphvkF0zpZo+iCm1aE5rOMTfrs31f/Zv/hPSojZN3NN3BBM5JfVLOQpnDLPeWhQ9RcxDDiWg5C7ZPk2i8ZFVymL/DUSNQAPzI6f2fmbUM4t0wxGDm/Qrshvor/aiyuFRcVBgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=acgWr6EG; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F2BEB2C0372;
	Tue,  2 Jul 2024 14:09:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1719886168;
	bh=e6Uweuk36+t1GhH6gy7+RAA1GKrHEeOut/4k2q3eTg8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=acgWr6EGciDtutsPoIOpJCgxjUXZKYFbc/8TcD0kJRP6hv/PscoZM5ovPZ+h07JTT
	 p2nFbYpqs44xLu24gIe9haJOr/5ft9NywD7shJVjbDoGD1o31h476KC+ZNAUSOtRj/
	 ri1wdHBjDemlvqogPcRPKD6JO0wQMNub+VLHO9t2MG1utn9kEmJkAqkPcc+CNhzkI7
	 CyAbU1lQER0wVjCCqsgXCCfQx3fdLEm+luQSt2G+0+6xtquXGXHwHopKvwPnPMXVfd
	 FQtYFrJc9bP1re3lEGdaMIM732KQD62vxEn+0rvCk6puUepbZWIcikmwxFYaFg7qDQ
	 BbIMqXe2JDTvA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668361580000>; Tue, 02 Jul 2024 14:09:28 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D73C313EE4B;
	Tue,  2 Jul 2024 14:09:28 +1200 (NZST)
Message-ID: <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
Date: Tue, 2 Jul 2024 14:09:28 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: net: dsa: Realtek switch drivers
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "olteanv@gmail.com" <olteanv@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "justinstitt@google.com" <justinstitt@google.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sander@svanheule.net" <sander@svanheule.net>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=66836158 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=l7AzUe4WSKfLcy4FgSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hPAN1OI7KfYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 15/06/24 09:36, Luiz Angelo Daros de Luca wrote:
> Hello Chris and Linus,
>
>>> I'm starting to look at some L2/L3 switches with Realtek silicon. I see
>>> in the upstream kernel there are dsa drivers for a couple of simple L2
>>> switches. While openwrt has support for a lot of the more advanced
>>> silicon. I'm just wondering if there is a particular reason no-one has
>>> attempted to upstream support for these switches?
>> It began with the RTL8366RB ("RTL8366 revision B") which I think is
>> equivalent to RTL8366S as well, but have not been able to test.
>>
>> Then Luiz and Alvin jumped in and fixed up the RTL8365MB family.
>>
>> So the support is pretty much what is stated in the DT bindings
>> in Documentation/devicetree/bindings/net/dsa/realtek.yaml:
>>
>> properties:
>>    compatible:
>>      enum:
>>        - realtek,rtl8365mb
>>        - realtek,rtl8366rb
>>      description: |
>>        realtek,rtl8365mb:
>>          Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
>>          RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL8367S,
>>          RTL8367SB, RTL8370MB, RTL8310SR
>>        realtek,rtl8366rb:
>>          Use with models RTL8366RB, RTL8366S
>>
>> It may look like just RTL8365 and RTL8366 on the surface but the sub-version
>> is detected at runtime.
>>
>>> If I were to start
>>> grabbing drivers from openwrt and trying to get them landed would that
>>> be a problem?
>> I think the base is there, when I started with RTL8366RB it was pretty
>> uphill but the kernel DSA experts (Vladimir & Andrew especially) are super
>> helpful so eventually we have arrived at something that works reasonably.
>>
>> The RTL8356MB-family driver is more advanced and has a lot more features,
>> notably it supports all known RTL8367 variants.
> I played with RTL8367R. It mostly works with rtl8365mb driver but I
> wasn't able to enable the CPU tagging. Although
>
>> The upstream OpenWrt in target/linux/generic/files/drivers/net/phy
>> has the following drivers for the old switchdev:
>> -rw-r--r--. 1 linus linus 25382 Jun  7 21:44 rtl8306.c
>> -rw-r--r--. 1 linus linus 40268 Jun  7 21:44 rtl8366rb.c
>> -rw-r--r--. 1 linus linus 33681 Jun  7 21:44 rtl8366s.c
>> -rw-r--r--. 1 linus linus 36324 Jun  7 21:44 rtl8366_smi.c
>> -rw-r--r--. 1 linus linus  4838 Jun  7 21:44 rtl8366_smi.h
>> -rw-r--r--. 1 linus linus 58021 Jun 12 18:50 rtl8367b.c
>> -rw-r--r--. 1 linus linus 59612 Jun 12 18:50 rtl8367.c
>>
>> As far as I can tell we cover all but RTL8306 with the current in-tree
>> drivers, the only reason these are still in OpenWrt would be that some
>> boards are not migrated to DSA.
> These drivers you listed are mostly found in old or low spec devices.
> There is little incentive to invest too much time to migrate them. For
> rtl8365mb, it still lacks support for vlan and forwarding offload. So,
> the swconfig driver still makes sense.
> There is also a performance problem with checksum offloading. These
> switches are used with non-realtek SoC, which might lead to:
>
> "Checksum offload should work with category 1 and 2 taggers when the
> DSA conduit driver declares NETIF_F_HW_CSUM in vlan_features and looks
> at csum_start and csum_offset. For those cases, DSA will shift the
> checksum start and offset by the tag size. If the DSA conduit driver
> still uses the legacy NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM in
> vlan_features, the offload might only work if the offload hardware
> already expects that specific tag (perhaps due to matching vendors).
> DSA user ports inherit those flags from the conduit, and it is up to
> the driver to correctly fall back to software checksum when the IP
> header is not where the hardware expects. If that check is
> ineffective, the packets might go to the network without a proper
> checksum (the checksum field will have the pseudo IP header sum). For
> category 3, when the offload hardware does not already expect the
> switch tag in use, the checksum must be calculated before any tag is
> inserted (i.e. inside the tagger). Otherwise, the DSA conduit would
> include the tail tag in the (software or hardware) checksum
> calculation. Then, when the tag gets stripped by the switch during
> transmission, it will leave an incorrect IP checksum in place."
> See: https://docs.kernel.org/networking/dsa/dsa.html
>
>> But maybe I missed something?
> I guess Chris is talking about the realtek target that uses Realtek
> SoC (target/linux/realtek/files-5.15/). That is a completely different
> beast. Although it might share some (or a lot) logic with current
> upstream drivers, it is way more complex. It might require a
> multi-function device driver. Anyway, the current realtek SoC/target
> drivers need some love, like using regmap, implement functions using
> an abstraction layer (and not if model a inside the code), get rid of
> all magic numbers and replace them with meaningful macros, create a
> proper tagger (and not translate a generic one just before forwarding
> it). In OpenWrt, a code that gets things done might be acceptable but
> the upstream kernel requires something more maintainable. So, if you
> want to upstream those drivers, you can start by improving them in the
> openwrt.

So now got access to the Realtek docs and I've been pouring over them 
and the openwrt code (I'm avoiding looking at the Realtek SDK for now, 
just to make sure I don't submit something I don't have the rights to).

If someone were to look at the block diagram in the brief datasheet 
they'd probably come away with the impression that it very much fits the 
DSA model. There's a SoC portion with the CPU, peripherals and a "NIC". 
That NIC is connected to the CPU MAC in the switch block. All seems like 
a pretty standard DSA type design and that's what the openwrt code 
implements a ethernet/rtl838x_eth.c driver for the Ethernet NIC and a 
dsa/rtl83xx driver for the DSA switch.

But when you start digging into the detail you find that the registers 
for the NIC are scattered through the address space for the switch. Same 
for the MDIO related registers. There is a more detailed block diagram 
in the CPU and Peripherals datasheet that shows the NIC and switch as 
part of the same IP block. The openwrt implementation does things that I 
think would be frowned upon upstream like calling from the Ethernet 
driver into the switch driver to access registers.

This leads me to conclude that what Realtek call the "NIC" is actually 
just the DMA interface for packets sent from or trapped to the CPU. 
Rather than trying to make this fit the DSA model I should be looking at 
using switchdev directly (I can still probably leverage a lot of code 
from the openwrt drivers because the switch tables are the same either way).

What would I be loosing if I don't use the DSA infrastructure? I got 
kind of hung up at the point where it really wanted a CPU port and I 
just couldn't provide a nice discrete NIC.



