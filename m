Return-Path: <netdev+bounces-221430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE11B507C1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270A7462BCA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13024C692;
	Tue,  9 Sep 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="AhBeEIbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7N3A2Mm"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865124DCF6
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452136; cv=none; b=iksG89lrzhC620FeW8NJY14Am0ccSBtIe6LSMBYlcH2Y6rMAIpqhkrTNUGdw1XXQ/gvrOMBZk5Rq5UcqnoHfnOCWJUpXlQRxdRyZRLkpI0qkDxRZ6ekE8Bv8mppKjsoarYOcQlKxiya2Q8yX4UXSC2TM+JVjQIla/9L9lugSz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452136; c=relaxed/simple;
	bh=gT5bBlAG4d2uSIv6lzN/C4aEIYyowBreMtxucuCe5tM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=acLdndFaq1AsB/bO+z0RYrsBVM6cyrxd9UppCQHduitNgWAzJlKoMYYPVN7REgFi/gn8p6ZnTst9e9Y8JwKRS9+dQuLfvOkyDawF1LQCJ2197jM8tc9ZZWfGAsPEKr1t/+8qGDYKDr3G7HxMf2gGnohpZE7DVAB4WbqTZRZysEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=AhBeEIbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7N3A2Mm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08E8114000C9;
	Tue,  9 Sep 2025 17:08:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 17:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757452134; x=1757538534; bh=72cAxa5R8X1Dz3Omai68h
	pxzITSHzIqYLRjSacnDvJs=; b=AhBeEIbLop7+lfPTscf251jjAGtUKqqPs4qgx
	6lvpeJ05IwFknwiffo+Y42sDTQepua++t5klZvlZr6ELaXpmVDbXR3GLMcUwcrcl
	ectzpxrw+ZNxiM44BbsiqQ856IxqMrakVmxx1yO+rNAljHSi4hzsdIM00Pc13dsA
	wHgJ5+zIJffIlUlxLGAjMN5AY1pZkb3/4I4Q9SmzJuc1UMGVl5yZUM0mXVh++j9t
	5/ybZeK4BO/FSibA5j0n54TWY5Bubw/a9/M6zllEx/6Kwc1ekxfAo3wjX1fjOzt3
	wHi+gqJXK1P7c4V/lPCwCcvkVZiVc1vTYgScepN1qo8QP0zsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757452134; x=1757538534; bh=72cAxa5R8X1Dz3Omai68hpxzITSHzIqYLRj
	SacnDvJs=; b=J7N3A2MmVLBA3xf0EmeWgevrwY0ejKTntDou0cNv+an6BNhsl5w
	56+hoE6/IlAPZmViV/ng8BAYRQmwiJIWkkeaYME3j1BYRgsxjVYNmP14TLBHO1XN
	5+fk7g+r1cp3ZqjE6GzBmaIX3Oy0VunaUtegfdkoNZPtUznw5R6MHtDla9lzDvJ8
	oMwGLfI8+FZYWgEMhWY5pfOYcv4hETJEql6dbQ+n71NlUCxYySzD69i4oUYm5Nuy
	iA1vy3G6gDSHzF3uGtjKHYVRj3+caqqEZuHZ1ujkZxdkAXQWpjHmkQrdrycnzM+B
	f7tKJJiYLmNwcK/VHS7weKw2NFPIAa/jGgA==
X-ME-Sender: <xms:ZZfAaC-gWm-EHXAjPaTqKE-8GJk82YVfOsqiK1WfgafAbUIwoVqR3w>
    <xme:ZZfAaLWxIjpB9jJnQkLLLkbKBdB-3kxiYsFb2oFP5YBLRAbHvWvKIE90PnMtf00i2
    gqVHTenpxiZtE-EXLk>
X-ME-Received: <xmr:ZZfAaPcaL6wP-kf9jy-1YU4yg1KEUcary9igjwYqQ_wuTrTXlcIw37jhgbk7Eaon59botA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhrrgguvggvphhs
    sehlihhnuhigrdhvnhgvthdrihgsmhdrtghomhdprhgtphhtthhopehsthgvphhhvghnse
    hnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehirdhmrgigihhmvght
    shesohhvnhdrohhrghdprhgtphhtthhopegrmhhorhgvnhhoiiesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohephhgrlhhiuhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhr
    rgguvggvphesuhhsrdhisghmrdgtohhmpdhrtghpthhtohepfihilhguvghrsehushdrih
    gsmhdrtghomh
X-ME-Proxy: <xmx:ZZfAaEaAx38EBkIEb1KVOaMmOjhQY2Uq-aV4gWZyN3jMmwxSAIiqlw>
    <xmx:ZZfAaLPs6VYgKby8p9Sl6qKdKfKEV-LIGn3dTa66ehEwNqGD87Gbww>
    <xmx:ZZfAaKXTl2NxRmyAbL-qIWXmlOV7H-DAy0z7Gh4UxKeLSwCMzA26dA>
    <xmx:ZZfAaIKYlTSEtVZfuelHCMnAtT1OF4xBr8ZIrm0P4goXIUmugCCl8Q>
    <xmx:ZZfAaAYl8v3AXPSR5qq41QbFmCVNra9h1J1bud281q73S8dFLqeP1Gr3>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 17:08:53 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5FE649FCB4; Tue,  9 Sep 2025 14:08:52 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5F0CA9FC62;
	Tue,  9 Sep 2025 14:08:52 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: netdev@vger.kernel.org
cc: Nikolay Aleksandrov <razor@blackwall.org>,
    David Wilder <wilder@us.ibm.com>, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: Re: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
In-reply-to: <2921170.1757451242@famine>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-6-wilder@us.ibm.com>
 <2c0f972a-2393-4554-a76b-3ac425fed42b@blackwall.org>
 <2921170.1757451242@famine>
Comments: In-reply-to Jay Vosburgh <jv@jvosburgh.net>
   message dated "Tue, 09 Sep 2025 13:54:02 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2921827.1757452132.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 14:08:52 -0700
Message-ID: <2921828.1757452132@famine>

Jay Vosburgh <jv@jvosburgh.net> wrote:

>Nikolay Aleksandrov <razor@blackwall.org> wrote:
>
>>On 9/5/25 01:18, David Wilder wrote:
>>> bond_arp_send_all() will pass the vlan tags supplied by
>>> the user to bond_arp_send(). If vlan tags have not been
>>> supplied the vlans in the path to the target will be
>>> discovered by bond_verify_device_path(). The discovered
>>> vlan tags are then saved to be used on future calls to
>>> bond_arp_send().
>>> bond_uninit() is also updated to free vlan tags when a
>>> bond is destroyed.
>>> Signed-off-by: David Wilder <wilder@us.ibm.com>
>>> ---
>>>   drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
>>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>> diff --git a/drivers/net/bonding/bond_main.c
>>> b/drivers/net/bonding/bond_main.c
>>> index 7548119ca0f3..7288f8a5f1a5 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -3063,18 +3063,19 @@ struct bond_vlan_tag *bond_verify_device_path(=
struct net_device *start_dev,
>>>     static void bond_arp_send_all(struct bonding *bond, struct slave
>>> *slave)
>>>   {
>>> -	struct rtable *rt;
>>> -	struct bond_vlan_tag *tags;
>>>   	struct bond_arp_target *targets =3D bond->params.arp_targets;
>>> +	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
>>> +	struct bond_vlan_tag *tags;
>>>   	__be32 target_ip, addr;
>>> +	struct rtable *rt;
>>>   	int i;
>>>     	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i=
++)
>>> {
>>>   		target_ip =3D targets[i].target_ip;
>>>   		tags =3D targets[i].tags;
>>>   -		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
>>> -			  __func__, &target_ip);
>>> +		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
>>> +			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
>>>     		/* Find out through which dev should the packet go */
>>>   		rt =3D ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
>>> @@ -3096,9 +3097,13 @@ static void bond_arp_send_all(struct bonding *b=
ond, struct slave *slave)
>>>   		if (rt->dst.dev =3D=3D bond->dev)
>>>   			goto found;
>>>   -		rcu_read_lock();
>>> -		tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>>> -		rcu_read_unlock();
>>> +		if (!tags) {
>>> +			rcu_read_lock();
>>> +			tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>>> +			/* cache the tags */
>>> +			targets[i].tags =3D tags;
>>> +			rcu_read_unlock();
>>
>>Surely you must be joking. You cannot overwrite the tags pointer without=
 any synchronization.
>
>	Agreed, I think this will race with at least bond_fill_info,
>_bond_options_arp_ip_target_set, and bond_option_arp_ip_target_rem.
>
>	Also, pretending for the moment that the above isn't an issue,
>does this cache handle changes in real time?  I.e., if the VLAN above
>the bond is replumbed without dismantling the bond, will the above
>notice and do the right thing?
>
>	The current code checks the device path on every call, and I
>don't see how it's feasible to skip that.

	Ok, thinking this through a little more... the point of the
patch set is to permit the user to supply the tags via option setting
for cases that bond_verify_device_path can't figure things out.  So the
tags stashed as part of the bond (i.e., provided as option settings from
user space) should only be changable from user space.

	So, I think the way it'll have to work is, if user space
provided tags then use them, otherwise call bond_verify_device_path and
use whatever it says, but throw that away after each pass.

	If user space provided tags and then replumbs things, then it'll
be on user space to update the tags, as the option is essentially
overriding the automatic lookup provided by bond_verify_device_path.

	If the tags stashed in the bond configuration can only be
changed via user space option settings, I think that can be done safely
in an RCU manner (as netlink always operates with RTNL held, if memory
serves).

	-J

>	Separately, a random thought while looking at the code, I feel
>like there ought to be a way to replace the GFP_ATOMIC memory allocation
>in bond_verify_device_path with storage local to its caller (since it's
>always immediately freed), but that's probably not something to get into
>for this patch set.
>
>	-J
>
>>> +		}
>>>     		if (!IS_ERR_OR_NULL(tags))
>>>   			goto found;
>>> @@ -3114,7 +3119,6 @@ static void bond_arp_send_all(struct bonding *bo=
nd, struct slave *slave)
>>>   		addr =3D bond_confirm_addr(rt->dst.dev, target_ip, 0);
>>>   		ip_rt_put(rt);
>>>   		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
>>> -		kfree(tags);
>>>   	}
>>>   }
>>>   @@ -6047,6 +6051,7 @@ static void bond_uninit(struct net_device
>>> *bond_dev)
>>>   	bond_for_each_slave(bond, slave, iter)
>>>   		__bond_release_one(bond_dev, slave->dev, true, true);
>>>   	netdev_info(bond_dev, "Released all slaves\n");
>>> +	bond_free_vlan_tags(bond->params.arp_targets);
>>>     #ifdef CONFIG_XFRM_OFFLOAD
>>>   	mutex_destroy(&bond->ipsec_lock);
>>> @@ -6633,7 +6638,6 @@ static void __exit bonding_exit(void)
>>>     	bond_netlink_fini();
>>>   	unregister_pernet_subsys(&bond_net_ops);
>>> -
>>>   	bond_destroy_debugfs();
>>>     #ifdef CONFIG_NET_POLL_CONTROLLER
>>
>
>---
>	-Jay Vosburgh, jv@jvosburgh.net
>

---
	-Jay Vosburgh, jv@jvosburgh.net

