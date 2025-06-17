Return-Path: <netdev+bounces-198762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E32ADDAF9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49FA7AD14C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569726C38E;
	Tue, 17 Jun 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="V85HaxH1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8iIgrhS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC1156C6F;
	Tue, 17 Jun 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183023; cv=none; b=gKvZOaqaLLCFMOjWpAtzxAWtg+5GOpZ9wbD+Rx+iJVNHYb1/9iZVs5gc+eJj9ebA2ybZG6gY7nr1xFpcEwuK/mHndTIQr1AjqR5GkB5L4qn/DdAT4daO7gT+ZCU56jL8c55XEnU65wG/yR8rvmLZkCTIs6EgqVU3euzS6Irx+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183023; c=relaxed/simple;
	bh=y55Z1VjvdrkqqEtQsP/JjeLD6YX4X2Tz6tr9egFE7xs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=pFPlRAMJ4Dj1cjxeYvGnCcNOdjeIjBVFRb2vPlvP1ni2ln9pYUgSVs8lsiFhbRc5P8qnuGceMy4c1JfKm+IO2Ry1VqG1YpM+TNlLG5FbeKFhG2PY+I/XXuSt+PgSp6cSWvOyG1l03t7sW7wKNEv2qUMeSR33SA1o0ZeNcodL5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=V85HaxH1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8iIgrhS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E2891380451;
	Tue, 17 Jun 2025 13:56:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Jun 2025 13:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750183018; x=1750269418; bh=Up81oIZvfNKZDT8rbAcJp
	/j9gEnsVPnyARrXIDiA+qk=; b=V85HaxH1p8VasxtYcF1itgRhVOn07Kp1aRqxd
	waDh52ZISHAiIYl3HnlRLa2NoMiQLt/J79RKIwW3sfRGah2OnM28/wWlJz1noWUb
	ZEN8lW8q7gfveFqrWcTQjNPFG+nomQ3v5g4/hUmMBnogG/WbyDKvQWUqIEmZvN2t
	VKQecESvr79nfI2+r4ihHX+K3mgUGBMklKjy+HiEk88CeoZXEhVxdlZUJpPpT5ER
	qSGeLON6ROQ2LL6UrxqIe/Z50Uo6ULQQPtyunbydCkThcAEdII3QKGMOlvNQ7V6M
	BW/6U/fAC6VOU5xzqzbORDvQ1krH9oaolNr98sYuY/xzMhyng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750183018; x=1750269418; bh=Up81oIZvfNKZDT8rbAcJp/j9gEnsVPnyARr
	XIDiA+qk=; b=S8iIgrhSG5fGmROMlweiqHN3Q5pqzgp2dZ2QGA/ERuSg1QD0LPl
	mcBhfGHNWZQ+xbLldk2ONAAYOqOdrTpRdYz/32PdYwoOcBYRIWt5zoxrDSqtKNdz
	vzwaSYglX49k8ACh+ZaLLOGSPxW5b+K4wjsYFSPSldTB9dFPldinMi1G/aVEKB9L
	vFzsnr7j4wonlqpk3hSodKnqjgcDzGmzx0LcnrlbOSJ7za3am8RHxAtxXJhkDmq+
	r2Bdp/6K1/tc/oCp+ChsAufRw3hxTupfDAe99LQfIXElSu05ntSLXhRogK+flOui
	PXu6Ws3TKMkNuEj49h0jpgX1q/y6DyzW28g==
X-ME-Sender: <xms:aaxRaFbffABGdrSeamdU_9Wtg6DsnXdcmZg2k5IlCGPc-492ug1p8A>
    <xme:aaxRaMZ3ECXUrWCnHIQTUnkxMOoTTxyFZqyzMi8XyKljKo_BUG04z9UcY-7VRSTzN
    Wc61osbRHyQBylOoS0>
X-ME-Received: <xmr:aaxRaH87h6l-okih2iZR1BOY94InP7x7hFFsSAVvJXrUMjYKRanR4clH28R_LOC3aCZdMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvden
    ucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvg
    htqeenucggtffrrghtthgvrhhnpeejvedukeevveeftdehuedujefgffettdekvdevgfeu
    uefhieduheeitefffefgleenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsph
    hothdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprh
    gtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhes
    sghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthho
    pehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtsehl
    fihnrdhnvght
X-ME-Proxy: <xmx:aaxRaDrb_-3YyxxpG-0oLMc9Ut1SpwbWVnmFMnGIrzmJzGdESHLQuA>
    <xmx:aaxRaAo4otZWJEf27AQ4zpS7vRRPadvpwSI41BD0jPdleHnScPjMww>
    <xmx:aaxRaJR0iffO6KSMVSIoYh0Twu8RWm7l0_5ufbZFF9lW5AT39RxJ9w>
    <xmx:aaxRaIosUSeJBwnVp3oFWobI5b2vSzk96u6M77j9wmAa_0tUaV70oQ>
    <xmx:aqxRaNzNXVbWfceCgy9o1TmzegdvMr994-8kmkdsBT8a2NG25nXcRR_F>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 13:56:57 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 0C1A39FCA8; Tue, 17 Jun 2025 10:56:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 092979FC65;
	Tue, 17 Jun 2025 10:56:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hangbin Liu <liuhangbin@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier = 0
In-reply-to: <92580e9d-55c1-4298-ae7a-00726a727fb5@blackwall.org>
References: <1922517.1750109336@famine>
 <92580e9d-55c1-4298-ae7a-00726a727fb5@blackwall.org>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Tue, 17 Jun 2025 08:57:54 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1974331.1750183016.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 10:56:56 -0700
Message-ID: <1974332.1750183016@famine>

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On 6/17/25 00:28, Jay Vosburgh wrote:
>> 	 Remove the ability to disable use_carrier in bonding, and remove
>> all code related to the old link state check that utilizes ethtool or
>> ioctl to determine the link state of an interface in a bond.
>> =

>> 	To avoid acquiring RTNL many times per second, bonding's miimon
>> link monitor inspects link state under RCU, but not under RTNL.  Howeve=
r,
>> ethtool implementations in drivers may sleep, and therefore the ethtool=
 or
>> ioctl strategy is unsuitable for use with calls into driver ethtool
>> functions.
>> =

>> 	The use_carrier option was introduced in 2003, to provide
>> backwards compatibility for network device drivers that did not support
>> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
>> expected to support netif_carrier_*, and the use_carrier backwards
>> compatibility logic is no longer necessary.
>> =

>> 	Bonding now always behaves as if use_carrier=3D1, which relies on
>> netif_carrier_ok() to determine the link state of interfaces.  This has
>> been the default setting for use_carrier since its introduction.  For
>> backwards compatibility, the option itself remains, but may only be set=
 to
>> 1, and queries will always return 1.
>> =

>> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Db8c48ea38ca27d150063
>> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.=
com/
>> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9=
c9ded97163aef4e4de10985cd8f7de60d28@changeid/
>> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
>> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
>> =

>> ---
>>  Documentation/networking/bonding.rst |  79 +++----------------
>>  drivers/net/bonding/bond_main.c      | 113 ++-------------------------
>>  drivers/net/bonding/bond_netlink.c   |  11 +--
>>  drivers/net/bonding/bond_options.c   |   7 +-
>>  drivers/net/bonding/bond_sysfs.c     |   6 +-
>>  include/net/bonding.h                |   1 -
>>  6 files changed, 25 insertions(+), 192 deletions(-)
>> =

>[snip]
>> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/b=
ond_netlink.c
>> index ac5e402c34bc..98f9bef61474 100644
>> --- a/drivers/net/bonding/bond_netlink.c
>> +++ b/drivers/net/bonding/bond_netlink.c
>> @@ -258,13 +258,8 @@ static int bond_changelink(struct net_device *bond=
_dev, struct nlattr *tb[],
>>  			return err;
>>  	}
>>  	if (data[IFLA_BOND_USE_CARRIER]) {
>> -		int use_carrier =3D nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
>> -
>> -		bond_opt_initval(&newval, use_carrier);
>> -		err =3D __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
>> -				     data[IFLA_BOND_USE_CARRIER], extack);
>> -		if (err)
>> -			return err;
>> +		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) !=3D 1)
>
>you can set extack to send back an error to the user that use_carrier
>is now obsolete

	Fair point, will add that and repost.

	-J

>> +			return -EINVAL;
>>  	}
>>  	if (data[IFLA_BOND_ARP_INTERVAL]) {
>>  		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
>> @@ -676,7 +671,7 @@ static int bond_fill_info(struct sk_buff *skb,
>>  			bond->params.peer_notif_delay * bond->params.miimon))
>>  		goto nla_put_failure;
>>  =

>> -	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
>> +	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
>>  		goto nla_put_failure;
>>  =

>>  	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interva=
l))

---
	-Jay Vosburgh, jv@jvosburgh.net

