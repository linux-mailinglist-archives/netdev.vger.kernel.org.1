Return-Path: <netdev+bounces-184067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7CA93108
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 05:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A307619E457C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E32686BD;
	Fri, 18 Apr 2025 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="J0A8bfBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiCakURp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D52686A0
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948772; cv=none; b=rnEk/sAmfRCoPivVRMUQUqFFwHvd9UZsVkzG6zpJo/BsxQW0d1rffYN73DyXRGn5bi3lMBqLqyirEpfGtdrjeZYIKovW3udr9+E7WffkYg5pmccNmobUq2M3bqONEtbifvPxx+E4Ixce52TQ+MxUlFMykn7GplXJsHvqbi4nH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948772; c=relaxed/simple;
	bh=MgWKIFhArjYj8r71s5MsyfM8gQBpBcrHi8EA+56+uAo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=QBvfVvSwRFPUQ9WCm5XPt9uHXhtWIKDSsioqRHbeIS+BngsE1KpUW8w9vw6aVr2yxcvtHTF60qccK4CaQ5kMUTX9d60anej5WUHAckAdkYZ5+ObQVseWs+8UWKo2LsYGxYJah3Gc8t1GriqBVm8c/LYZtpZBK1t2zv1ksrdKytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=J0A8bfBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiCakURp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB64B2540134;
	Thu, 17 Apr 2025 23:59:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 23:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744948767; x=1745035167; bh=7YnNC530/IzrmI0ixZVgf
	4rHY3PtCRjHnQASzLT7PaA=; b=J0A8bfBIGXlU7JsXdbLT6X8uDskXPj0IueiIy
	YcYlj/OHldphOdGqg3WGNJ8GNDPRa6yh76TEGAE9mxl7NHipF0f4N6mFx3VzAnOE
	0xsmikWkkJFQCF+XUxgafofmPheaUijjNgBLjKXYKzzcMvfb5Dk/lU5iJ3ou+YF/
	wa5tmtWDlH6fmz7swWk62SfdqWkqIsTugvUtn58KXAOx9VZUTvfVxS0qawyMMQnV
	OpyHe7k5j9KQWtMSBUE7vpqhBSy0tXXh0ncHx7pH1sRvUnN+Se98rb5LOTigTCMV
	90MGwcLv4lzSVXl9Bdx5yfiKX2lB4zl8tVtZKYna41DdN+1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744948767; x=1745035167; bh=7YnNC530/IzrmI0ixZVgf4rHY3PtCRjHnQA
	SzLT7PaA=; b=PiCakURpOxLlnsmZpmnk04CoFAR32VPY82trlcJw5hk/RhS4D8C
	bTyHVX7DlRHy1f6EFM2ceSiD7KImr1nFr+nnRUmrh5fTl7aNDziMATI8KrAxg8Sv
	Rea58qHDPZ5zcZSVKlNrdTBV4H14g3vRgnnETUk+6v7i1yD1e2Gu2i87EZySZBtV
	rD818+GmCKjwnTIyxKq4qY7UdVQNTBu9oaUZYI4WDPsFrxYVwX/JfNxqksALU/jV
	H1QPlZ//q+j81H/zHmwCID/9711zaJKIhV+IFMnzgFSMngTqJpy6XHJ8PyXp6wJ+
	LneOn1FxGEWojkRoEj+gcDeFUOMlNtKsZQg==
X-ME-Sender: <xms:Hs4BaKPV2QkP2o4vqWrXeMGk-Vy7eNJ5JzIt9QKe95_GCqdOjOR9Cw>
    <xme:Hs4BaI-E6nuW47iLb4oJS-16UB3lf-xFbmAAlVyO02ToVwc4wxUOWQUhn7zTjvu59
    7mueDC3uExDaDPoVcs>
X-ME-Received: <xmr:Hs4BaBRDJ6OAwt6Xd4KFZFWrI9v39U9PVlg-fDG2wN4SP7Hv_H1Tql11q7CEVpByPM5FCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeduuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Hs4BaKvzTjHIRE1Uihcz538z1_EGoA-TFeGIDk6KX9obVEXxboFEEg>
    <xmx:Hs4BaCcmcRVqfzlUn3OZ-4tzut2dMKAsIkuLcEoDE47Fm7LlgflcWw>
    <xmx:Hs4BaO3kTkgUftjHVpxSEpUt6865IGAOctqbvGSBru0dup-Re7w-Lg>
    <xmx:Hs4BaG_4Xa7QG9kleQ8tn8p0F8EjS8yyNdk984VMLwX5nLgVcuCosg>
    <xmx:H84BaBG2aPoCH9r543iifCr2T-qU9mEeFP_5LkoXYf8uNXJwUV688zW3>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 23:59:26 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E35799FD3F; Thu, 17 Apr 2025 20:59:24 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id DF8B39FC4C;
	Thu, 17 Apr 2025 20:59:24 -0700 (PDT)
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
 <MW3PR15MB39131B4CAE5E3D06084D2A7DFABD2@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4177847.1744765887@famine>
 <MW3PR15MB39131B4CAE5E3D06084D2A7DFABD2@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Wed, 16 Apr 2025 18:57:10 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <154691.1744948764.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Apr 2025 20:59:24 -0700
Message-ID: <154692.1744948764@famine>

David Wilder <wilder@us.ibm.com> wrote:

>>>>>>>> Adding limited support for the ARP Monitoring feature when ovs is
>>>>>>>> configured above the bond. When no vlan tags are used in the conf=
iguration
>>>>>>>> or when the tag is added between the bond interface and the ovs b=
ridge arp
>>>>>>>> monitoring will function correctly. The use of tags between the o=
vs bridge
>>>>>>>> and the routed interface are not supported.
>>>>>>>
>>>>>>>       Looking at the patch, it isn't really "adding support," but
>>>>>>> rather is disabling the "is this IP address configured above the b=
ond"
>>>>>>> checks if the bond is a member of an OVS bridge.  It also seems li=
ke it
>>>>>>> would permit any ARP IP target, as long as the address is configur=
ed
>>>>>>> somewhere on the system.
>>>>>>>
>>>>>>>       Stated another way, the route lookup in bond_arp_send_all() =
for
>>>>>>> the target IP address must return a device, but the logic to match=
 that
>>>>>>> device to the interface stack above the bond will always succeed i=
f the
>>>>>>> bond is a member of any OVS bridge.
>>>>>>>
>>>>>>>       For example, given:
>>>>>>>
>>>>>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1
>>>>>>> eth2 IP=3D20.0.0.2
>>>>>>>
>>>>>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparent=
ly
>>>>>>> succeed after this patch is applied, and the bond would send ARPs =
for
>>>>>>> 20.0.0.2.
>>>>>>>
>>>>>>>> For example:
>>>>>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
>>>>>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supporte=
d.
>>>>>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not s=
upported.
>>>>>>>>
>>>>>>>> Configurations #1 and #2 were tested and verified to function cor=
ectly.
>>>>>>>> In the second configuration the correct vlan tags were seen in th=
e arp.
>>>>>>>
>>>>>>>       Assuming that I'm understanding the behavior correctly, I'm =
not
>>>>>>> sure that "if OVS then do whatever" is the right way to go, partic=
ularly
>>>>>>> since this would still exhibit mysterious failures if a VLAN is
>>>>>>> configured within OVS itself (case 3, above).
>>>>>>
>>>>>> Note: vlan can also be pushed or removed by the OpenFlow pipeline w=
ithin
>>>>>> openvswitch between the ovs-port and the bond0.  So, there is actua=
lly no
>>>>>> reliable way to detect the correct set of vlan tags that should be =
used.
>>>>>> And also, even if the IP is assigned to the ovs-port that is part o=
f the
>>>>>> same OVS bridge, there is no guarantee that packets routed to that =
IP can
>>>>>> actually egress from the bond0, as the forwarding rules inside the =
OVS
>>>>>>datapath can be arbitrarily complex.
>>>>>>
>>>>>> And all that is not limited to OVS even, as the cover letter mentio=
ns, TC
>>>>>> or nftables in the linux bridge or even eBPF or XDP programs are no=
t that
>>>>>> different complexity-wise and can do most of the same things breaki=
ng the
>>>>>> assumptions bonding code makes.
>>>>>>
>>>>>>>
>>>>>>>       I understand that the architecture of OVS limits the ability=
 to
>>>>>>> do these sorts of checks, but I'm unconvinced that implementing th=
is
>>>>>>> support halfway is going to create more issues than it solves.
>>>>
>>>>    Re-reading my comment, I clearly meant "isn't going to create
>>>>    more issues" here.
>>>>
>>>>>>>       Lastly, thinking out loud here, I'm generally loathe to add =
more
>>>>>>> options to bonding, but I'm debating whether this would be worth a=
n
>>>>>>> "ovs-is-a-black-box" option somewhere, so that users would have to
>>>>>>> opt-in to the OVS alternate realm.
>>>>>
>>>>>> I agree that adding options is almost never a great solution.  But =
I had a
>>>>>> similar thought.  I don't think this option should be limited to OV=
S though,
>>>>>>as OVS is only one of the cases where the current verification logic=
 is not
>>>>>>sufficient.
>>>>
>>>>        Agreed; I wasn't really thinking about the not-OVS cases when =
I
>>>>wrote that, but whatever is changed, if anything, should be generic.
>>>
>>>>>What if we build on the arp_ip_target setting.  Allow for a list of v=
lan tags
>>>>> to be appended to each target. Something like: arp_ip_target=3Dx.x.x=
.x[vlan,vlan,...].
>>>>> If a list of tags is omitted it works as before, if a list is suppli=
ed assume we know what were doing
>>>>> and use that instead of calling bond_verify_device_path(). An empty =
list would be valid.
>>>
>>>>        Hmm, that's ... not too bad; I was thinking more along the lin=
es
>>>>of a "skip the checks" option, but this may be a much cleaner way to d=
o
>>>>it.
>>>
>>>>        That said, are you thinking that bonding would add the VLAN
>>>>tags, or that some third party would add them?  I.e., are you trying t=
o
>>>>accomodate the case wherein OVS, tc, or whatever, is adding a tag?
>>>
>>>It would be up to the administrator to add the list of tags to the
>>>arp_target list.  I am unsure how a third party could know what tags
>>>might be added by other components.  Knowing what tags to add to the
>>>list may be hard to figure out in a complicated configuration.  The
>>>upside is it should be possible to configure for any list of tags even
>>>if difficult.
>>
>>  I suspect I wasn't clear in my question; what I'm asking is what
>>you envision for the implementation within bonding for the "[vlan,vlan]"
>>part, and by "third party," I mean "not bonding," so OVS, tc, etc.
>>
>>  Would bonding need to add the tags in the list, or expect one of
>>the thiry parties to do it, or some kind of mix?
>
>Bonding needs to add all the tags. I am just optionally replacing
>the collection of tags by bond_verify_device_path() with a list of tags
>supplied in the arp_target list. (Optional Per target).
>
>To be clear, if you chose to supply tags manually, you need to supply
>all the tags needed for that target,  not just the tags bonding could not
>figure out on its own. An empty list [] would be valid and would just cau=
se
>bonding to skip tag collection.
>
>If OVS adds a tag it would be up to the user to know that and update
>the bonding configuration to include all tags for the target.  =


	If OVS adds a tag, and the ARP traverses through OVS, why would
bonding need to add that tag?  Wouldn't OVS add the tag again?

>>   Does bonding need to know what tags any third party adds?  I.e.,
>>for your case 3, above, wherein OVS adds a tag, why does that fail to
>>work?
>
>Today it fails since bond_verify_device_path() cant see the tags
>added by or above OVS.  Adding a list of tags [vlan vlan] or [] would eff=
ectively =

>do the the same as the "skip the checks" option.  But allows a way to mak=
e
>case 3 work.
>
>>
>>>A "skip the checks" option would be easier to code. If we skip the
>>>process of gathering tags would that eliminate any configurations with
>>>any vlan tags?.
>>
>>  So, yes, it would be easier to implement, and, no, I think a
>>simple "skip the checks" switch could be implemented such that it still
>>runs the device path and gathers the tags, but doesn't care if the end
>>of the device path matches.
>>
>>  That said, such an implementation is effectively the same as
>>your original patch, except with an option instead of an OVS-ness check,
>>and I'm still undecided on whether that's better than something that
>>requires more specific configuration.
>
>Ah,  ok I get it.  =

>
>The "skip the checks" option has the advantage in simplicity and will
>fix the problem I started out solving.  The downside is it wont solve mor=
e
>complex configurations Ilya is concerned with (see case 3). I am all for =
starting
>with the "kiss" approach, we can always pivot to something more complex l=
ater if we have
>the demand.

	Modulo some of the implementation details from above, I'm more
inclined at the moment towards the "specify the tags" solution (specify
all the tags), rather than the "skip the checks" option.

	The reason is that, once we add an option, it generally cannot
ever be removed, and so there isn't really a "pivot" in the sense that
an existing option would ever go away.  In that case, the only way
forward would be to add another option (the "specify the tags" one), and
now we've got two different options for the same thing that work
differently.  I'd like to avoid that.

	-J

>>
>>-J
>
>
>>>>>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>
>>>>>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com=
>
>>>>>>>> ---
>>>>>>>> drivers/net/bonding/bond_main.c | 8 +++++++-
>>>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bondin=
g/bond_main.c
>>>>>>>> index 950d8e4d86f8..6f71a567ba37 100644
>>>>>>>> --- a/drivers/net/bonding/bond_main.c
>>>>>>>> +++ b/drivers/net/bonding/bond_main.c
>>>>>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_p=
ath(struct net_device *start_dev,
>>>>>>>>      struct net_device *upper;
>>>>>>>>      struct list_head  *iter;
>>>>>>>>
>>>>>>>> -    if (start_dev =3D=3D end_dev) {
>>>>>>>> +    /* If start_dev is an OVS port then we have encountered an o=
penVswitch
>>>>>>
>>>>>> nit: Strange choice to capitalize 'V'.  It should be all lowercase =
or a full
>>>>>> 'Open vSwitch' instead.
>>>>>
>>>>>>>> +     * bridge and can't go any further. The programming of the s=
witch table
>>>>>>>> +     * will determine what packets will be sent to the bond. We =
can make no
>>>>>>>> +     * further assumptions about the network above the bond.
>>>>>>>> +     */
>>>>>>>> +
>>>>>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)=
) {
>>>>>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMI=
C);
>>>>>>>>              if (!tags)
>>>>>>>>                      return ERR_PTR(-ENOMEM);
>>>>>>>
>>>>>>> ---
>>>>>>>       -Jay Vosburgh, jv@jvosburgh.net
>>>>>>
>>>>>> Best regards, Ilya Maximets.
>>>>>
>>>>>David Wilder (wilder@us.ibm.com)
>>>>
>>>>---
>>>>        -Jay Vosburgh, jv@jvosburgh.net
>>>
>>>David Wilder (wilder@us.ibm.com)
>>
>>---
>>  -Jay Vosburgh, jv@jvosburgh.net
>

---
	-Jay Vosburgh, jv@jvosburgh.net

