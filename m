Return-Path: <netdev+bounces-183002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCACA8A8DF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987963AEE03
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0F2522A4;
	Tue, 15 Apr 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="wZWOV3bz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7quyGGP"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA582505A9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747802; cv=none; b=lkeZmIQPZXcAuegYUVYVEh7DqSwxjVPwHJZ/cn/MEXxYdCexOtOSHiF5gnycu9/wVvbOOMeVfdBBuXwmxkCHaWDp5leZZOrfklCaPpRIjK4z3spbFCKcFIvUPuhdEPCfgnodJJlEgb1pc9c7srDofmRD9m2JBHXWscNUyXA0Ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747802; c=relaxed/simple;
	bh=6vmvOJz0Rtg8NCJpxE1495KIoRkHP9wy5rbN1IhCJ/M=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dqQ0gBeGVXYnqP7tmqOWLoKoRRtfRLlYBIWhK/gJ0T5xm432fLZG4p3daPusV1YZY1r34PDWNQkrDNtshWFrv2K0mMzVatRl5exyStm0exDid9BZ3qzAxAZcKNovtqjtdvonTdq2N1OCWIoFLP7E2V+qLZP0ogqzDqM630ttnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=wZWOV3bz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7quyGGP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9365C13801F4;
	Tue, 15 Apr 2025 16:09:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 16:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744747798; x=1744834198; bh=PmvRmAL3zeDo/DPtctpSg
	u9QOlY4+Czidf52UOqaXyc=; b=wZWOV3bzt2R0/Qp53501ndgX1nNlVg3G2m3AO
	C6qHRZxJ7JoxSOogmM6ibtmtFxxoimTP8Lb+LPBoepgw8+6xFwftuewVZYPLv33+
	UylInJI7bbFC2yjb3pAOfDz+9J3fy3He0h8+0+yz1dOMlMA+y+2mDRTkX80+6J0B
	nsVbqu9AgjavDbx8ltFpjpmbozytYTnqz/JWH87BlZr3INDJJhxoo+TJopY4fFzE
	CABxmwTIGXpnXS7n/oqdLXWaiyerPw23oqX6eOzqMSeNpJRXVKrRRw6AxTP57WXK
	RyUSfJ1sAn2vcP0fXyXXo6/jpDs+c0bx58QGlwN6NOOpzD8rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744747798; x=1744834198; bh=PmvRmAL3zeDo/DPtctpSgu9QOlY4+Czidf5
	2UOqaXyc=; b=v7quyGGPNbVNVI+WppASX39RGXImT/ckiJmVBVtunZpOFsoac+d
	lObYHHXPSGcNcpOW672nSEkf18FFB58pVkcanC6Ez14LzxbkbYTkSZBfjEDn6raf
	ig/p8PIQI6dQtr0QSy0JtLt0op14omN1s0qfZj7R6fmtj0OvxIeQahE2v/CRGWoL
	cV4Sbcja8/MGBna9QJTrsg/YtNev+s6ZZNN6YtQBmJGnSv4+aQeiKlB+WbkK0RIv
	WH+vTgFwwQAG3PZYSdoGcdt3DEA7YOUG7j+P9Qvo1vQObpdt9h+bulbS34c3AJHJ
	efmzeipBpamMd9jMbXa9kgr7cQzRVm1mRNQ==
X-ME-Sender: <xms:Fb3-Z-m9YwlkJ6atzVCPCYu75Pv7zXWZZ8OkBz6mlp5NUTRsStyvWQ>
    <xme:Fb3-Z11O2QRiqnm9EHuxN8U3QwUYPTy1stu3oHvmz4lqu4Zvu1ugF1F0N6yezb8gP
    0hwHyWCcou6oCzxDAk>
X-ME-Received: <xmr:Fb3-Z8pDCijUCeE17w-ofCoIxLfyz7cZ6wKynujv1xRhhb6b2FEp_tHN5cVsfD9wnc1H0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeggeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgruggvvghpsheslh
    hinhhugidrvhhnvghtrdhisghmrdgtohhmpdhrtghpthhtohepihdrmhgrgihimhgvthhs
    sehovhhnrdhorhhgpdhrtghpthhtoheprghmohhrvghnohiisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehhrghlihhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehprhgr
    uggvvghpsehushdrihgsmhdrtghomhdprhgtphhtthhopeifihhluggvrhesuhhsrdhisg
    hmrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Fb3-ZynFYTQzf_Q9TH2_7wlDuQhEmUP6uhtKW2l1x-eiuddle2UgYA>
    <xmx:Fb3-Z82M07BVHVdqPRCguvcAIXC4cHCdYBiDc_K7UHjBnNVQ4Ji54g>
    <xmx:Fb3-Z5u9dW7sa-935bh1NmosQhtJ6wxSteyONmGyRsjGv5L2tjQaGA>
    <xmx:Fb3-Z4WO_HfLXNAqWJ46C43th4w72x0uddQK1SRRGnOA06HWT0muuA>
    <xmx:Fr3-Z9_9gG923kVE7b-hnz3i2nzD8c5oNmoaeXwowMhWqdW9SJvCSzcX>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 16:09:56 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E25B09FD38; Tue, 15 Apr 2025 13:09:55 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id DF9D29FC8A;
	Tue, 15 Apr 2025 13:09:55 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: Ilya Maximets <i.maximets@ovn.org>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
    Pradeep Satyanarayana <pradeep@us.ibm.com>,
    Adrian Moreno Zapata <amorenoz@redhat.com>,
    Hangbin Liu <haliu@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
In-reply-to: 
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Sun, 13 Apr 2025 02:37:20 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4164871.1744747795.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Apr 2025 13:09:55 -0700
Message-ID: <4164872.1744747795@famine>

David Wilder <wilder@us.ibm.com> wrote:

>
>
>>>> Adding limited support for the ARP Monitoring feature when ovs is
>>>> configured above the bond. When no vlan tags are used in the configur=
ation
>>>> or when the tag is added between the bond interface and the ovs bridg=
e arp
>>>> monitoring will function correctly. The use of tags between the ovs b=
ridge
>>>> and the routed interface are not supported.
>>>
>>>       Looking at the patch, it isn't really "adding support," but
>>> rather is disabling the "is this IP address configured above the bond"
>>> checks if the bond is a member of an OVS bridge.  It also seems like i=
t
>>> would permit any ARP IP target, as long as the address is configured
>>> somewhere on the system.
>>>
>>>       Stated another way, the route lookup in bond_arp_send_all() for
>>> the target IP address must return a device, but the logic to match tha=
t
>>> device to the interface stack above the bond will always succeed if th=
e
>>> bond is a member of any OVS bridge.
>>>
>>>       For example, given:
>>>
>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1
>>> eth2 IP=3D20.0.0.2
>>>
>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently
>>> succeed after this patch is applied, and the bond would send ARPs for
>>> 20.0.0.2.
>>>
>>>> For example:
>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not suppo=
rted.
>>>>
>>>> Configurations #1 and #2 were tested and verified to function corectl=
y.
>>>> In the second configuration the correct vlan tags were seen in the ar=
p.
>>>
>>>       Assuming that I'm understanding the behavior correctly, I'm not
>>> sure that "if OVS then do whatever" is the right way to go, particular=
ly
>>> since this would still exhibit mysterious failures if a VLAN is
>>> configured within OVS itself (case 3, above).
>>
>> Note: vlan can also be pushed or removed by the OpenFlow pipeline withi=
n
>> openvswitch between the ovs-port and the bond0.  So, there is actually =
no
>> reliable way to detect the correct set of vlan tags that should be used=
.
>> And also, even if the IP is assigned to the ovs-port that is part of th=
e
>> same OVS bridge, there is no guarantee that packets routed to that IP c=
an
>> actually egress from the bond0, as the forwarding rules inside the OVS
>>datapath can be arbitrarily complex.
>>
>> And all that is not limited to OVS even, as the cover letter mentions, =
TC
>> or nftables in the linux bridge or even eBPF or XDP programs are not th=
at
>> different complexity-wise and can do most of the same things breaking t=
he
>> assumptions bonding code makes.
>>
>>>
>>>       I understand that the architecture of OVS limits the ability to
>>> do these sorts of checks, but I'm unconvinced that implementing this
>>> support halfway is going to create more issues than it solves.

	Re-reading my comment, I clearly meant "isn't going to create
more issues" here.

>>>       Lastly, thinking out loud here, I'm generally loathe to add more
>>> options to bonding, but I'm debating whether this would be worth an
>>> "ovs-is-a-black-box" option somewhere, so that users would have to
>>> opt-in to the OVS alternate realm.
>
>> I agree that adding options is almost never a great solution.  But I ha=
d a
>> similar thought.  I don't think this option should be limited to OVS th=
ough,
>>as OVS is only one of the cases where the current verification logic is =
not
>>sufficient.

	Agreed; I wasn't really thinking about the not-OVS cases when I
wrote that, but whatever is changed, if anything, should be generic.

>What if we build on the arp_ip_target setting.  Allow for a list of vlan =
tags
> to be appended to each target. Something like: arp_ip_target=3Dx.x.x.x[v=
lan,vlan,...].
> If a list of tags is omitted it works as before, if a list is supplied a=
ssume we know what were doing
> and use that instead of calling bond_verify_device_path(). An empty list=
 would be valid.

	Hmm, that's ... not too bad; I was thinking more along the lines
of a "skip the checks" option, but this may be a much cleaner way to do
it.

	That said, are you thinking that bonding would add the VLAN
tags, or that some third party would add them?  I.e., are you trying to
accomodate the case wherein OVS, tc, or whatever, is adding a tag?

	-J

>>>
>>>       -J
>>>
>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>
>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>
>>>> ---
>>>> drivers/net/bonding/bond_main.c | 8 +++++++-
>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
>>>> index 950d8e4d86f8..6f71a567ba37 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(=
struct net_device *start_dev,
>>>>      struct net_device *upper;
>>>>      struct list_head  *iter;
>>>>
>>>> -    if (start_dev =3D=3D end_dev) {
>>>> +    /* If start_dev is an OVS port then we have encountered an openV=
switch
>>
>> nit: Strange choice to capitalize 'V'.  It should be all lowercase or a=
 full
>> 'Open vSwitch' instead.
>
>>>> +     * bridge and can't go any further. The programming of the switc=
h table
>>>> +     * will determine what packets will be sent to the bond. We can =
make no
>>>> +     * further assumptions about the network above the bond.
>>>> +     */
>>>> +
>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) {
>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
>>>>              if (!tags)
>>>>                      return ERR_PTR(-ENOMEM);
>>>
>>> ---
>>>       -Jay Vosburgh, jv@jvosburgh.net
>>
>> Best regards, Ilya Maximets.
>
>David Wilder (wilder@us.ibm.com)

---
	-Jay Vosburgh, jv@jvosburgh.net

