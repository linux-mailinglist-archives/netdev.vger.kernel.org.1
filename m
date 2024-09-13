Return-Path: <netdev+bounces-128182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988597866C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B85281988
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5581720;
	Fri, 13 Sep 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="35Tl/+z2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3x8OFGn"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3D63C;
	Fri, 13 Sep 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247271; cv=none; b=WEu5DMFmvxlhTKhFZ+A1q4i3QgTG0KQ+k7TFIUIlXnGy/fN+SD7XrtnnP6gVFCOS8uUJFA5UYRuE6nYvS/8DRHQyfXmcEtjVq49mJPrI5GSqXsOOi4NOKNwhyW7PXhjy4cJdIC4zq98Q+uiPKikIgrAVZSTjtbc1k1+n0i+SUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247271; c=relaxed/simple;
	bh=PYV58iWVC3PKfH4IsiVSBIPaNqZ76nH3yQUqTmGQM2s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wkt7cbTKcsOs5vMiRg0Bp95Cp20X4IxaiTELN5HChR4R00oeE/TyK79tPhj3MfFPF+kpJ7RuhVJ25W3ApXR1WxMKMfjK5YDIxbu78zNc34JxZaHHdQQEJHp5Fvs8D5j+CXnsx8xGfrfYBFEf0wPX9N5i2FFrXWXqXBkb+viKpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=35Tl/+z2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3x8OFGn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B2EE114008B;
	Fri, 13 Sep 2024 13:07:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Sep 2024 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1726247268; x=1726333668; bh=ltRxHgFwdb8npWJX4/vmgTP+KogieigH
	7exQIEBZgn8=; b=35Tl/+z23qNzU/034/LfXvlbJwK6VyYwrgTyHYrdgC5aNVNI
	Bpr6peHFBlEeSNcpgNXLpUS7m5c4cDIzxMC37mmFmw1eMrKjIEhmLqmlYL/WsWeh
	CFQGOdxE074PeAtcaL0V2TDY8IEdZ78OwXT+vryvKM++W0v15wwrywg6GN/6a+ur
	oIsXHtpjh/7Io2x7zmQKVGICD0mj3Gn9sN9vwgRY1pzPIvrBIeuqhGJpjgIMB3Ph
	XClpHz2MEsXA3HSSCr6mBw31Uf9ELtJqB8jtLUf+29TVm8QuWRPJJblj+ibeicdN
	AuAJpchtuiWl5l2AVt4jLqnRBG5Q7JGj19Z/+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726247268; x=
	1726333668; bh=ltRxHgFwdb8npWJX4/vmgTP+KogieigH7exQIEBZgn8=; b=S
	3x8OFGnnmzi1IWD+tONeGkKsJoHGBCc9djSDCeznHAVXRW1DiBIrMVjp6AecWpF1
	uj3VQuwq8u4Eusy2gNzQz1SNOUHzb8yu8Hg9/T02eN5fpwNjR2EcctmRcdeGl+d0
	TPw6KOl0XOrfiy7YpZEewnq+jMKHOVk5lWL2lXw6TYzpPMp9X5mEcIZ0NtAE9Jk7
	BDLFWFTi8hM14TSo8A/m5vv6HghSYeLoDr1eGGvgtzyIeoarxMYMttlZ0Ty5COkN
	/6wEqdHb88qFCbMnoFn2U3hMtL0JCa5/Gf8OUltdI3TOLidi25XBh0FbRh1oVNPg
	lPNtaxbDZY/qQUReZ+1Pg==
X-ME-Sender: <xms:ZHHkZg672g1SYSXClDiwAevO6MVTDuT89KO6YaxcnHEbcA5IaLTqsA>
    <xme:ZHHkZh5VDkdw3Zz5b2JfxyHk9v3HHPjHpJ-SNrVVmD-3Bsoh2qVTjfzVt68NTCb8U
    3rjilATfFWtblb9GQg>
X-ME-Received: <xmr:ZHHkZveJm5SIdlAUFw9FG8l_QNai80_jPKEX91vg9FmBS99s_2rXGZ775tmLP0wsKcPs_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    jeenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegfefghffghffhjefgveekhfeukeevffethffg
    tddutdefffeuheelgeelieeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopehsuhhrvghshhdvhedugeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZHHkZlIUxaqX4myGwMEdeekI7zZJtqk0Ye_HpKgqxvWdNG5JPpk7gQ>
    <xmx:ZHHkZkIXB9qwxGshNVqnaDiliWL-jy5ElLMGx7ryCxA8WwHQE0gz9Q>
    <xmx:ZHHkZmzPqGG7w1ZXXpuMzRxsUlmlJX3afT9Hy-8tp0ztpnE4txYj8A>
    <xmx:ZHHkZoLqaJGuzPFZlGqJxCGO2ENBVrMmOS1ACnjL6PFnSHE1fwRKvQ>
    <xmx:ZHHkZj_eLE7X5I_P9Kv4_hTVwqzMzhA3eal6LyphZ2TsLbZ3GUOAI0Xs>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 13:07:47 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 9AE159FC93; Fri, 13 Sep 2024 10:07:46 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 99D4A9FC8E;
	Fri, 13 Sep 2024 10:07:46 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: suresh ks <suresh2514@gmail.com>
cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bonding: do not set force_primary if reselect is set to failure
In-reply-to: <CABAyFk4dzN_Oprod1LM_X1x+-bHg8HxnJ1OzhLRD092mY4ON3w@mail.gmail.com>
References: <20240912064043.36956-1-suresh2514@gmail.com> <397121.1726186016@famine> <CABAyFk4dzN_Oprod1LM_X1x+-bHg8HxnJ1OzhLRD092mY4ON3w@mail.gmail.com>
Comments: In-reply-to suresh ks <suresh2514@gmail.com>
   message dated "Fri, 13 Sep 2024 08:06:06 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2024 10:07:46 -0700
Message-ID: <417266.1726247266@famine>

suresh ks <suresh2514@gmail.com> wrote:

>Hi,
>
>Thanks  a lot for reviewing.
>
>I was working for a customer issue where they removed a primary NIC for sw=
itch
>maintenance and when added back, it caused iscsi storage outage because th=
ey
>did not expect the bod to do a failover.
>
>So bonding is behaving as default. But then I thought maybe we can do
>something to cater for such scenarios and came up with this idea.  But
>I agree my
>testing was not a failure as I see ""Link Failure Count: 0" there.  I
>used the below
>command from my kvm host to simulate a link down and up.
>
>     virsh  detach-interface testvm1  --type network --mac 52:54:00:d7:a7:=
2a
>
>and attached it back with:
>
>    virsh  attach-interface testvm1 --type network --source default
>--mac 52:54:00:d7:a7:2a
>     --model e1000e --config --live

	This removes the interface entirely, so it's not just a link
failure.  You could probably simulate a link failure via something like
"ip link set dev ${INTERFACE} down", followed by a later "up" to restore
link state.  This would happen in the testvm1, and ${INTERFACE} is the
name of the bond member interface.

>So what would be the best solution here if I want to take out a
>primary NIC for maintenance,
>and then add it back ?.

	You could clear the primary option on the bond for the
maintenance window, and later set primary to the desired interface when
everything is ready for that interface to become active again.

	-J

> I was also  trying with 'ifenslave'  to first
>make secondary NIC active
>and then remove primary NIC.
>
>   ifenslave -d bond0 enp1s0
>
>The interface changed to 'down', but immediately it came back up and
>became active again.
>I don't know why. The journal logs suggest my NetworkManager is
>autoactivating it again :)
>
>Thanks a lot for your time again.
>
>- Suresh
>
>On Fri, Sep 13, 2024 at 5:36=E2=80=AFAM Jay Vosburgh <jv@jvosburgh.net> wr=
ote:
>>
>> Suresh Kumar <suresh2514@gmail.com> wrote:
>>
>> >when bond_enslave() is called, it sets bond->force_primary to true
>> >without checking if primary_reselect is set to 'failure' or 'better'.
>> >This can result in primary becoming active again when link is back which
>> >is not what we want when primary_reselect is set to 'failure'
>>
>>         The current behavior is by design, and is documented in
>> Documentation/networking/bonding.rst:
>>
>>
>>         The primary_reselect setting is ignored in two cases:
>>
>>                 If no slaves are active, the first slave to recover is
>>                 made the active slave.
>>
>>                 When initially enslaved, the primary slave is always made
>>                 the active slave.
>>
>>
>>         Your proposed change would cause the primary to never be made
>> the active interface when added to the bond for the primary_reselect
>> "better" and "failure" settings, unless the primary interface is added
>> to the bond first or all other interfaces are down.
>>
>>         Also, your description above and the test example below use the
>> phrases "link is back" and "primary link failure" but the patch and test
>> context suggest that the primary interface is being removed from the
>> bond and then later added back to the bond, which is not the same thing
>> as a link failure.
>>
>>         -J
>>
>> >Test
>> >=3D=3D=3D=3D
>> >Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
>> >
>> >Bonding Mode: fault-tolerance (active-backup)
>> >Primary Slave: enp1s0 (primary_reselect failure)
>> >Currently Active Slave: enp1s0
>> >MII Status: up
>> >MII Polling Interval (ms): 100
>> >Up Delay (ms): 0
>> >Down Delay (ms): 0
>> >Peer Notification Delay (ms): 0
>> >
>> >Slave Interface: enp1s0
>> >MII Status: up
>> >Speed: 1000 Mbps
>> >Duplex: full
>> >Link Failure Count: 0
>> >Permanent HW addr: 52:54:00:d7:a7:2a
>> >Slave queue ID: 0
>> >
>> >Slave Interface: enp9s0
>> >MII Status: up
>> >Speed: 1000 Mbps
>> >Duplex: full
>> >Link Failure Count: 0
>> >Permanent HW addr: 52:54:00:da:9a:f9
>> >Slave queue ID: 0
>> >
>> >
>> >After primary link failure:
>> >
>> >Bonding Mode: fault-tolerance (active-backup)
>> >Primary Slave: None
>> >Currently Active Slave: enp9s0 <---- secondary is active now
>> >MII Status: up
>> >MII Polling Interval (ms): 100
>> >Up Delay (ms): 0
>> >Down Delay (ms): 0
>> >Peer Notification Delay (ms): 0
>> >
>> >Slave Interface: enp9s0
>> >MII Status: up
>> >Speed: 1000 Mbps
>> >Duplex: full
>> >Link Failure Count: 0
>> >Permanent HW addr: 52:54:00:da:9a:f9
>> >Slave queue ID: 0
>> >
>> >
>> >Now add primary link back and check bond status:
>> >
>> >Bonding Mode: fault-tolerance (active-backup)
>> >Primary Slave: enp1s0 (primary_reselect failure)
>> >Currently Active Slave: enp1s0  <------------- primary is active again
>> >MII Status: up
>> >MII Polling Interval (ms): 100
>> >Up Delay (ms): 0
>> >Down Delay (ms): 0
>> >Peer Notification Delay (ms): 0
>> >
>> >Slave Interface: enp9s0
>> >MII Status: up
>> >Speed: 1000 Mbps
>> >Duplex: full
>> >Link Failure Count: 0
>> >Permanent HW addr: 52:54:00:da:9a:f9
>> >Slave queue ID: 0
>> >
>> >Slave Interface: enp1s0
>> >MII Status: up
>> >Speed: 1000 Mbps
>> >Duplex: full
>> >Link Failure Count: 0
>> >Permanent HW addr: 52:54:00:d7:a7:2a
>> >Slave queue ID: 0
>> >
>> >Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
>> >---
>> > drivers/net/bonding/bond_main.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> >index bb9c3d6ef435..731256fbb996 100644
>> >--- a/drivers/net/bonding/bond_main.c
>> >+++ b/drivers/net/bonding/bond_main.c
>> >@@ -2146,7 +2146,9 @@ int bond_enslave(struct net_device *bond_dev, str=
uct net_device *slave_dev,
>> >               /* if there is a primary slave, remember it */
>> >               if (strcmp(bond->params.primary, new_slave->dev->name) =
=3D=3D 0) {
>> >                       rcu_assign_pointer(bond->primary_slave, new_slav=
e);
>> >-                      bond->force_primary =3D true;
>> >+            if (bond->params.primary_reselect !=3D BOND_PRI_RESELECT_F=
AILURE  &&
>> >+                bond->params.primary_reselect !=3D BOND_PRI_RESELECT_B=
ETTER)
>> >+                          bond->force_primary =3D true;
>> >               }
>> >       }
>> >
>> >--
>> >2.43.0
>> >
>>
>> ---
>>         -Jay Vosburgh, jv@jvosburgh.net


