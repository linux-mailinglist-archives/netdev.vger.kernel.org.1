Return-Path: <netdev+bounces-183088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CE9A8AD6D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCBB1691CF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA951DA31F;
	Wed, 16 Apr 2025 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="P8Hn6Q/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdeakeZ5"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA268A29
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765894; cv=none; b=QeTmXqaWuV6/TdM1takpCKOHcASTT+NeppmbycjQ03thRYY0zhr44kvpz5bkhO3BRuFtCX5BIdcf4w20RzpbfVvfSVTQqo+mw+mD5bk1lZnWP6gvEYp6w52siX8ZRlFO0o7NMInVEEwdM+KSgJeZyoZxVBb48VOQcqcls1TMYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765894; c=relaxed/simple;
	bh=7ar197Xewb/nnqWmQytwqfuUI9Zg/ZIHzfXRpKqiCZs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=og7XFp83VDIBQ5HEWW5Buuk7zq+hrarHkIE0yCCnQeM0p2/V5NQY6VdbZQFSJLKNdq1E5agtK4lrqtImwXRuP4w10sMeL4IjKlxNmtGdGJMrp9knksBhIgW+RMOBph47Zg1xMQAkEQw6fSQN+fk3AUfHlAJjlZ3cY3xv0Fr73zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=P8Hn6Q/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdeakeZ5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5938114011F;
	Tue, 15 Apr 2025 21:11:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 21:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744765889; x=1744852289; bh=vKIBujJn2+QGxiRh8SBnP
	TaWwbNdhX5svByHUZ5bfYM=; b=P8Hn6Q/H4BlMjHky2Dqc6qjFElaFpbX9suW5V
	wQ6eE9VcprlzupoxmF+qqw/a87HaJWH8wx5j98FuPTcaz9Wjfg7rb84HIhEVHrsU
	LBVhnY+X9PsfSBsbrrYHZ/7nhUjh59LjGQwzvFmc7qIXjJbtRlPXY4FPAmgBcE/K
	op5R+2B+8gM+AYgyJk6Ki3dkUDlICMPRzSFcPULqOKebvCFsGxxYQP5n3EBWXbY1
	dvL0jaADvmswoI88ncz2VyP0NpehpSyNNjmpc8qC6qBfsSyWN7a/Z/GFjbb5C7tI
	SQfS7lvKkzHcUlaGiSZInbInrgV09SEnOzA6w1Vc0tBCM8hEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744765889; x=1744852289; bh=vKIBujJn2+QGxiRh8SBnPTaWwbNdhX5svBy
	HUZ5bfYM=; b=FdeakeZ5QWktxD8iYpYKkewD/9+l/RfKlxIemGOEeoA6CE0S1WJ
	XBIdhaUm/iZy7A+VtWYnV14YaDnzk5K54VNGKQA8nL8YqZVeXq4tEjgsK1kADrAG
	vINd8eCHFTeEwbpuvtC5PL7gpxxNK0p7YiAoI41LFznRT1Mxn5+WVvLMA58vAI8a
	r8D+8gGw3xdRLz/Ds7jbbyu4ayciBVphPSXmbMtWwlNHvb+g5m4jMAzMta5Fm1Vh
	vZOzj2CNoVY8cmyJiR7gfWeBgmEk30dtrR2B8ZObvxGcIBjG5RKDxqARtYswFRCz
	Lnj/pKO3LgzIRQ+odjb1RlQpb5Ll+CRlrXQ==
X-ME-Sender: <xms:wAP_Z4KE0cIOdx9JVHZpUwMtvht403vwxViQ8qG4Ru1D4QKI_7ohqA>
    <xme:wAP_Z4JTEFyeCK7Lcj_ljUpWcaEjdyXXpiEvs3_f51Nh9NTUm5omKIfiJOIuu8Hs3
    BIEBImTAAo93hx9fJs>
X-ME-Received: <xmr:wAP_Z4uyMo2KmZGm65kZmW_UrYnPhZiDTAFA3v8dK5FeiHmIIfA8XoLKPFAFcARxkHftYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehtddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wAP_Z1ZTBhIFA1YWXpD2igXzg7J__AqIxHMCEG2bIMB3ww6cA6Ddzg>
    <xmx:wQP_Z_aDHP8Vhhmf8L2zCKYKginSbtXjUVq4t4yLmVhQfISclMtnkg>
    <xmx:wQP_ZxDQYbm98yIvOBViZJoJzte5uZwX9hzsUQ_ol7NE3YjXbXsWUQ>
    <xmx:wQP_Z1aI8fCuT1GidoQt0pnCvwF5WtzvvARYaUxlLlc0K5Cz22AvhQ>
    <xmx:wQP_ZwQwChzZLTO__LjMFG56q1fnvW0KJMH73NST2PPakgXAeJ6jn4JC>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 21:11:28 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 9F24C9FD38; Tue, 15 Apr 2025 18:11:27 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 9BCA79FC8A;
	Tue, 15 Apr 2025 18:11:27 -0700 (PDT)
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
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Tue, 15 Apr 2025 22:13:18 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4177846.1744765887.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Apr 2025 18:11:27 -0700
Message-ID: <4177847.1744765887@famine>

David Wilder <wilder@us.ibm.com> wrote:

>>>>>> Adding limited support for the ARP Monitoring feature when ovs is
>>>>>> configured above the bond. When no vlan tags are used in the config=
uration
>>>>>> or when the tag is added between the bond interface and the ovs bri=
dge arp
>>>>>> monitoring will function correctly. The use of tags between the ovs=
 bridge
>>>>>> and the routed interface are not supported.
>>>>>
>>>>>       Looking at the patch, it isn't really "adding support," but
>>>>> rather is disabling the "is this IP address configured above the bon=
d"
>>>>> checks if the bond is a member of an OVS bridge.  It also seems like=
 it
>>>>> would permit any ARP IP target, as long as the address is configured
>>>>> somewhere on the system.
>>>>>
>>>>>       Stated another way, the route lookup in bond_arp_send_all() fo=
r
>>>>> the target IP address must return a device, but the logic to match t=
hat
>>>>> device to the interface stack above the bond will always succeed if =
the
>>>>> bond is a member of any OVS bridge.
>>>>>
>>>>>       For example, given:
>>>>>
>>>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1
>>>>> eth2 IP=3D20.0.0.2
>>>>>
>>>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently
>>>>> succeed after this patch is applied, and the bond would send ARPs fo=
r
>>>>> 20.0.0.2.
>>>>>
>>>>>> For example:
>>>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
>>>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
>>>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not sup=
ported.
>>>>>>
>>>>>> Configurations #1 and #2 were tested and verified to function corec=
tly.
>>>>>> In the second configuration the correct vlan tags were seen in the =
arp.
>>>>>
>>>>>       Assuming that I'm understanding the behavior correctly, I'm no=
t
>>>>> sure that "if OVS then do whatever" is the right way to go, particul=
arly
>>>>> since this would still exhibit mysterious failures if a VLAN is
>>>>> configured within OVS itself (case 3, above).
>>>>
>>>> Note: vlan can also be pushed or removed by the OpenFlow pipeline wit=
hin
>>>> openvswitch between the ovs-port and the bond0.  So, there is actuall=
y no
>>>> reliable way to detect the correct set of vlan tags that should be us=
ed.
>>>> And also, even if the IP is assigned to the ovs-port that is part of =
the
>>>> same OVS bridge, there is no guarantee that packets routed to that IP=
 can
>>>> actually egress from the bond0, as the forwarding rules inside the OV=
S
>>>>datapath can be arbitrarily complex.
>>>>
>>>> And all that is not limited to OVS even, as the cover letter mentions=
, TC
>>>> or nftables in the linux bridge or even eBPF or XDP programs are not =
that
>>>> different complexity-wise and can do most of the same things breaking=
 the
>>>> assumptions bonding code makes.
>>>>
>>>>>
>>>>>       I understand that the architecture of OVS limits the ability t=
o
>>>>> do these sorts of checks, but I'm unconvinced that implementing this
>>>>> support halfway is going to create more issues than it solves.
>>
>>    Re-reading my comment, I clearly meant "isn't going to create
>>    more issues" here.
>>
>>>>>       Lastly, thinking out loud here, I'm generally loathe to add mo=
re
>>>>> options to bonding, but I'm debating whether this would be worth an
>>>>> "ovs-is-a-black-box" option somewhere, so that users would have to
>>>>> opt-in to the OVS alternate realm.
>>>
>>>> I agree that adding options is almost never a great solution.  But I =
had a
>>>> similar thought.  I don't think this option should be limited to OVS =
though,
>>>>as OVS is only one of the cases where the current verification logic i=
s not
>>>>sufficient.
>>
>>        Agreed; I wasn't really thinking about the not-OVS cases when I
>>wrote that, but whatever is changed, if anything, should be generic.
>
>>>What if we build on the arp_ip_target setting.  Allow for a list of vla=
n tags
>>> to be appended to each target. Something like: arp_ip_target=3Dx.x.x.x=
[vlan,vlan,...].
>>> If a list of tags is omitted it works as before, if a list is supplied=
 assume we know what were doing
>>> and use that instead of calling bond_verify_device_path(). An empty li=
st would be valid.
>
>>        Hmm, that's ... not too bad; I was thinking more along the lines
>>of a "skip the checks" option, but this may be a much cleaner way to do
>>it.
>
>>        That said, are you thinking that bonding would add the VLAN
>>tags, or that some third party would add them?  I.e., are you trying to
>>accomodate the case wherein OVS, tc, or whatever, is adding a tag?
>
>It would be up to the administrator to add the list of tags to the
>arp_target list.  I am unsure how a third party could know what tags
>might be added by other components.  Knowing what tags to add to the
>list may be hard to figure out in a complicated configuration.  The
>upside is it should be possible to configure for any list of tags even
>if difficult.

	I suspect I wasn't clear in my question; what I'm asking is what
you envision for the implementation within bonding for the "[vlan,vlan]"
part, and by "third party," I mean "not bonding," so OVS, tc, etc.

	Would bonding need to add the tags in the list, or expect one of
the thiry parties to do it, or some kind of mix?

	Does bonding need to know what tags any third party adds?  I.e.,
for your case 3, above, wherein OVS adds a tag, why does that fail to
work?

>A "skip the checks" option would be easier to code. If we skip the
>process of gathering tags would that eliminate any configurations with
>any vlan tags?.

	So, yes, it would be easier to implement, and, no, I think a
simple "skip the checks" switch could be implemented such that it still
runs the device path and gathers the tags, but doesn't care if the end
of the device path matches.

	That said, such an implementation is effectively the same as
your original patch, except with an option instead of an OVS-ness check,
and I'm still undecided on whether that's better than something that
requires more specific configuration.

	-J


>>>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>
>>>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> drivers/net/bonding/bond_main.c | 8 +++++++-
>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
>>>>>> index 950d8e4d86f8..6f71a567ba37 100644
>>>>>> --- a/drivers/net/bonding/bond_main.c
>>>>>> +++ b/drivers/net/bonding/bond_main.c
>>>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_pat=
h(struct net_device *start_dev,
>>>>>>      struct net_device *upper;
>>>>>>      struct list_head  *iter;
>>>>>>
>>>>>> -    if (start_dev =3D=3D end_dev) {
>>>>>> +    /* If start_dev is an OVS port then we have encountered an ope=
nVswitch
>>>>
>>>> nit: Strange choice to capitalize 'V'.  It should be all lowercase or=
 a full
>>>> 'Open vSwitch' instead.
>>>
>>>>>> +     * bridge and can't go any further. The programming of the swi=
tch table
>>>>>> +     * will determine what packets will be sent to the bond. We ca=
n make no
>>>>>> +     * further assumptions about the network above the bond.
>>>>>> +     */
>>>>>> +
>>>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) =
{
>>>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC)=
;
>>>>>>              if (!tags)
>>>>>>                      return ERR_PTR(-ENOMEM);
>>>>>
>>>>> ---
>>>>>       -Jay Vosburgh, jv@jvosburgh.net
>>>>
>>>> Best regards, Ilya Maximets.
>>>
>>>David Wilder (wilder@us.ibm.com)
>>
>>---
>>        -Jay Vosburgh, jv@jvosburgh.net
>
>David Wilder (wilder@us.ibm.com)

---
	-Jay Vosburgh, jv@jvosburgh.net

