Return-Path: <netdev+bounces-219281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C5B40E33
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BB41886ED5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CF2E719C;
	Tue,  2 Sep 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Fp4X0jPm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ow4i9K/W"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FB1C68F;
	Tue,  2 Sep 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842981; cv=none; b=TgTljsJFH6dahtptGy25GH9b2ikmQNQWix+1e8NlKM7wbhYvLQYE+e5K0XKnbbyZkCXq4f4ujLH/+HXzlQ3ahLz7EgOAQik9Pv2XU7GJhIRs6T1jUaAOLFXkXJEZCMkEfQpT68fnd50S2N2dBy9wS1Irolo9kZzr21FNa880bb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842981; c=relaxed/simple;
	bh=prGZPWn0uTPOSiy4bNe8aXYm/0T4VRPNTZKETfJhpWg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Z2V8Pgx69Jr4UUKkC4nOL2Ln16CV/QNfdGxInfA6F9rR+rf+ohLfSSRfIXfxpoemVoJrbW0IEf3ECcqRmqPp3Ti4ATMZf3NwCLD8hdDwwFyt/PaGRzHYQ+sUkb0Y0iNa+ZyTmoDLXy3ZgYjC2Ea/OpdBURCvclmxE76HJlQ4GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Fp4X0jPm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ow4i9K/W; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EED2A1D0028F;
	Tue,  2 Sep 2025 15:56:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 02 Sep 2025 15:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1756842976; x=1756929376; bh=IHUatKglEYwdo6gUII/2s
	GxjBI5t43uQ5Ut4oWLEDbk=; b=Fp4X0jPmmMUZeu4syLbWQf0wU4yUfW27tf5OF
	U4pp9vy+8H2Cxl+bABoNDIGuJNPbVgVl1T66KElLuFP//kyrFA7OjfUurZN4VzZ7
	lsjVCCI+Ti2Xyh8WdRAIG0hBP82gvJ/93N2HrTRDSOr3NLCFZIeXkpjUDWvN+9q7
	pmT0np3naislZG1Hi9exF3DqboGCTpfowYb8GuLMFu/sx6QKIsthFTV6EbxMh6mt
	jRYiPFOIgeyd7iriPJ6+e//5r48f3iojW/fcAITy7K/EkGGr7lChN8+XpykesjXp
	xtTOvWnfvGQogH7SpOnNyrq5ef/AAi2GZg/ezYKv5hPrAfLZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756842976; x=1756929376; bh=IHUatKglEYwdo6gUII/2sGxjBI5t43uQ5Ut
	4oWLEDbk=; b=Ow4i9K/WFgZo+wvlNcLWipX3BXV/b10eSWY7GVebyJAL4jYzb4O
	CPAF8nRG4yxNlSm8Zh1h4Azg18qb4O3x3b5d9pAisZC91EmdGRNvPcuF6yoTZeo8
	mb+PP1Qnu6Hk6i+ugOmFkjJpoLXcPm8u99qxD084PTvLZVi5v+pNT2CKUc0a0cTR
	JimuC25G7i/+Vq56VmHeusE6BLmvm53w8gzoUFUOtUmX792HjUWXlIp5dU7CIcPV
	EZ+gnjg/fkttjHy5QKkuV3bdfdHRPh1l0CQZaREufhbyN+xQzrmJSpos0NoQWAat
	wjLI3wfO7SAAVGHND7bV7zOUjMBm66GT24g==
X-ME-Sender: <xms:4Eu3aMCwK_P0y9lQwtBzEY-Z5L7jwsNS_TSe91VK3YoZ0R8KYiYpSA>
    <xme:4Eu3aL6ZhJfoYSI7u2LP8yAxtqqpB6hDUUf3wnNXrXDO0tAVOsbmmmKd86vsihqYo
    okJbwhvdqieFN6Erx8>
X-ME-Received: <xmr:4Eu3aG6hwP1cJPdSIIVJjfel047VSXR64hwcvYvF6s5_-vZ8LMhllm08egDiZqPiCV6yTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epieeiueekleeuudfgteeuhfdvfeejgefgfeeggeekudeghefghfefueejiedttddunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshihiihkrghllhgvrhdrrghpphhsphhoth
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepshhtfhhomhhitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegt
    ohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:4Eu3aNT4NeUVDQBdclDJmVqGZzUjsJ3X3cDTKOICC4-7r9kSTY9c6Q>
    <xmx:4Eu3aO96axOh5c5a68yxm1y5neVUv61ginycZ9jh6Pn4uobFoLVYZA>
    <xmx:4Eu3aObTBPUn29cp5ULoQLhkPZCf6CMk826G7LcwxutDSBhGGR-Zvg>
    <xmx:4Eu3aPpi79cC43KGtIdrMzlmi4oARvINWZWja3cavcP2qJn7xj1iyA>
    <xmx:4Eu3aLRQMkH5TpdR9qLEONGBh0BMKGN9yF2SNx1Bjyr-eIC9BvJ78ayc>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 15:56:16 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id AB0579FCA0; Tue,  2 Sep 2025 12:56:14 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A9B1C9FC95;
	Tue,  2 Sep 2025 12:56:14 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Stanislav Fomichev <stfomichev@gmail.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
In-reply-to: <aLcXNO6ginmuiBOw@mini-arch>
References: <2029487.1756512517@famine> <aLcXNO6ginmuiBOw@mini-arch>
Comments: In-reply-to Stanislav Fomichev <stfomichev@gmail.com>
   message dated "Tue, 02 Sep 2025 09:11:32 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2351813.1756842974.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 12:56:14 -0700
Message-ID: <2351814.1756842974@famine>

Stanislav Fomichev <stfomichev@gmail.com> wrote:

>On 08/29, Jay Vosburgh wrote:
>> 	 Remove the implementation of use_carrier, the link monitoring
>> method that utilizes ethtool or ioctl to determine the link state of an
>> interface in a bond.  Bonding will always behaves as if use_carrier=3D1=
,
>> which relies on netif_carrier_ok() to determine the link state of
>> interfaces.
>> =

>> 	To avoid acquiring RTNL many times per second, bonding inspects
>> link state under RCU, but not under RTNL.  However, ethtool
>> implementations in drivers may sleep, and therefore this strategy is
>> unsuitable for use with calls into driver ethtool functions.
>> =

>> 	The use_carrier option was introduced in 2003, to provide
>> backwards compatibility for network device drivers that did not support
>> the then-new netif_carrier_ok/on/off system.  Device drivers are now
>> expected to support netif_carrier_*, and the use_carrier backwards
>> compatibility logic is no longer necessary.
>> =

>> 	The option itself remains, but when queried always returns 1,
>> and may only be set to 1.
>> =

>> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.=
com/
>> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9=
c9ded97163aef4e4de10985cd8f7de60d28@changeid/
>> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
>> =

>> ---
>> =

>> Note: Deliberately omitting a Fixes tag to avoid removing functionality
>> in older kernels that may be in use.
>
>What about syzbot metadata?
>
>Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3Db8c48ea38ca27d150063
>
>?

	I can add these and repost in a day or so.

>>  Documentation/networking/bonding.rst |  79 +++----------------
>>  drivers/net/bonding/bond_main.c      | 113 ++-------------------------
>>  drivers/net/bonding/bond_netlink.c   |  14 ++--
>>  drivers/net/bonding/bond_options.c   |   7 +-
>>  drivers/net/bonding/bond_sysfs.c     |   6 +-
>>  include/net/bonding.h                |   1 -
>>  6 files changed, 28 insertions(+), 192 deletions(-)
>> =

>> diff --git a/Documentation/networking/bonding.rst b/Documentation/netwo=
rking/bonding.rst
>> index f8f5766703d4..a2b42ae719d2 100644
>> --- a/Documentation/networking/bonding.rst
>> +++ b/Documentation/networking/bonding.rst
>> @@ -582,10 +582,8 @@ miimon
>>  	This determines how often the link state of each slave is
>>  	inspected for link failures.  A value of zero disables MII
>>  	link monitoring.  A value of 100 is a good starting point.
>> -	The use_carrier option, below, affects how the link state is
>> -	determined.  See the High Availability section for additional
>> -	information.  The default value is 100 if arp_interval is not
>> -	set.
>> +
>> +	The default value is 100 if arp_interval is not set.
>>  =

>>  min_links
>>  =

>> @@ -896,25 +894,14 @@ updelay
>>  =

>>  use_carrier
>>  =

>> -	Specifies whether or not miimon should use MII or ETHTOOL
>> -	ioctls vs. netif_carrier_ok() to determine the link
>> -	status. The MII or ETHTOOL ioctls are less efficient and
>> -	utilize a deprecated calling sequence within the kernel.  The
>> -	netif_carrier_ok() relies on the device driver to maintain its
>> -	state with netif_carrier_on/off; at this writing, most, but
>> -	not all, device drivers support this facility.
>> -
>> -	If bonding insists that the link is up when it should not be,
>> -	it may be that your network device driver does not support
>> -	netif_carrier_on/off.  The default state for netif_carrier is
>> -	"carrier on," so if a driver does not support netif_carrier,
>> -	it will appear as if the link is always up.  In this case,
>> -	setting use_carrier to 0 will cause bonding to revert to the
>> -	MII / ETHTOOL ioctl method to determine the link state.
>> -
>> -	A value of 1 enables the use of netif_carrier_ok(), a value of
>> -	0 will use the deprecated MII / ETHTOOL ioctls.  The default
>> -	value is 1.
>> +	Obsolete option that previously selected between MII /
>> +	ETHTOOL ioctls and netif_carrier_ok() to determine link
>> +	state.
>> +
>> +	All link state checks are now done with netif_carrier_ok().
>> +
>> +	For backwards compatibility, this option's value may be inspected
>> +	or set.  The only valid setting is 1.
>>  =

>>  xmit_hash_policy
>>  =

>> @@ -2036,22 +2023,8 @@ depending upon the device driver to maintain its=
 carrier state, by
>>  querying the device's MII registers, or by making an ethtool query to
>>  the device.
>>  =

>> -If the use_carrier module parameter is 1 (the default value),
>> -then the MII monitor will rely on the driver for carrier state
>> -information (via the netif_carrier subsystem).  As explained in the
>> -use_carrier parameter information, above, if the MII monitor fails to
>> -detect carrier loss on the device (e.g., when the cable is physically
>> -disconnected), it may be that the driver does not support
>> -netif_carrier.
>> -
>> -If use_carrier is 0, then the MII monitor will first query the
>> -device's (via ioctl) MII registers and check the link state.  If that
>> -request fails (not just that it returns carrier down), then the MII
>> -monitor will make an ethtool ETHTOOL_GLINK request to attempt to obtai=
n
>> -the same information.  If both methods fail (i.e., the driver either
>> -does not support or had some error in processing both the MII register
>> -and ethtool requests), then the MII monitor will assume the link is
>> -up.
>> +The MII monitor relies on the driver for carrier state information (vi=
a
>> +the netif_carrier subsystem).
>>  =

>>  8. Potential Sources of Trouble
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> @@ -2135,34 +2108,6 @@ This will load tg3 and e1000 modules before load=
ing the bonding one.
>>  Full documentation on this can be found in the modprobe.d and modprobe
>>  manual pages.
>>  =

>> -8.3. Painfully Slow Or No Failed Link Detection By Miimon
>> ----------------------------------------------------------
>> -
>> -By default, bonding enables the use_carrier option, which
>> -instructs bonding to trust the driver to maintain carrier state.
>> -
>> -As discussed in the options section, above, some drivers do
>> -not support the netif_carrier_on/_off link state tracking system.
>> -With use_carrier enabled, bonding will always see these links as up,
>> -regardless of their actual state.
>> -
>> -Additionally, other drivers do support netif_carrier, but do
>> -not maintain it in real time, e.g., only polling the link state at
>> -some fixed interval.  In this case, miimon will detect failures, but
>> -only after some long period of time has expired.  If it appears that
>> -miimon is very slow in detecting link failures, try specifying
>> -use_carrier=3D0 to see if that improves the failure detection time.  I=
f
>> -it does, then it may be that the driver checks the carrier state at a
>> -fixed interval, but does not cache the MII register values (so the
>> -use_carrier=3D0 method of querying the registers directly works).  If
>> -use_carrier=3D0 does not improve the failover, then the driver may cac=
he
>> -the registers, or the problem may be elsewhere.
>> -
>> -Also, remember that miimon only checks for the device's
>> -carrier state.  It has no way to determine the state of devices on or
>> -beyond other ports of a switch, or if a switch is refusing to pass
>> -traffic while still maintaining carrier on.
>> -
>>  9. SNMP agents
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  =

>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> index 257333c88710..f25c2d2c9181 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -142,8 +142,7 @@ module_param(downdelay, int, 0);
>>  MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
>>  			    "in milliseconds");
>>  module_param(use_carrier, int, 0);
>> -MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in=
 miimon; "
>> -			      "0 for off, 1 for on (default)");
>> +MODULE_PARM_DESC(use_carrier, "option obsolete, use_carrier cannot be =
disabled");
>>  module_param(mode, charp, 0);
>>  MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
>>  		       "1 for active-backup, 2 for balance-xor, "
>> @@ -830,77 +829,6 @@ const char *bond_slave_link_status(s8 link)
>>  	}
>>  }
>>  =

>> -/* if <dev> supports MII link status reporting, check its link status.
>> - *
>> - * We either do MII/ETHTOOL ioctls, or check netif_carrier_ok(),
>> - * depending upon the setting of the use_carrier parameter.
>> - *
>> - * Return either BMSR_LSTATUS, meaning that the link is up (or we
>> - * can't tell and just pretend it is), or 0, meaning that the link is
>> - * down.
>> - *
>> - * If reporting is non-zero, instead of faking link up, return -1 if
>> - * both ETHTOOL and MII ioctls fail (meaning the device does not
>> - * support them).  If use_carrier is set, return whatever it says.
>> - * It'd be nice if there was a good way to tell if a driver supports
>> - * netif_carrier, but there really isn't.
>> - */
>> -static int bond_check_dev_link(struct bonding *bond,
>> -			       struct net_device *slave_dev, int reporting)
>> -{
>> -	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
>> -	struct mii_ioctl_data *mii;
>> -	struct ifreq ifr;
>> -	int ret;
>> -
>> -	if (!reporting && !netif_running(slave_dev))
>> -		return 0;
>> -
>> -	if (bond->params.use_carrier)
>> -		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
>> -
>> -	/* Try to get link status using Ethtool first. */
>> -	if (slave_dev->ethtool_ops->get_link) {
>> -		netdev_lock_ops(slave_dev);
>> -		ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
>> -		netdev_unlock_ops(slave_dev);
>> -
>> -		return ret ? BMSR_LSTATUS : 0;
>> -	}
>> -
>> -	/* Ethtool can't be used, fallback to MII ioctls. */
>> -	if (slave_ops->ndo_eth_ioctl) {
>> -		/* TODO: set pointer to correct ioctl on a per team member
>> -		 *       bases to make this more efficient. that is, once
>> -		 *       we determine the correct ioctl, we will always
>> -		 *       call it and not the others for that team
>> -		 *       member.
>> -		 */
>> -
>> -		/* We cannot assume that SIOCGMIIPHY will also read a
>> -		 * register; not all network drivers (e.g., e100)
>> -		 * support that.
>> -		 */
>> -
>> -		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
>> -		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
>> -		mii =3D if_mii(&ifr);
>> -
>> -		if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIPHY) =3D=3D 0) {
>> -			mii->reg_num =3D MII_BMSR;
>> -			if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIREG) =3D=3D 0)
>> -				return mii->val_out & BMSR_LSTATUS;
>> -		}
>> -	}
>> -
>> -	/* If reporting, report that either there's no ndo_eth_ioctl,
>> -	 * or both SIOCGMIIREG and get_link failed (meaning that we
>> -	 * cannot report link status).  If not reporting, pretend
>> -	 * we're ok.
>> -	 */
>> -	return reporting ? -1 : BMSR_LSTATUS;
>> -}
>> -
>>  /*----------------------------- Multicast list -----------------------=
-------*/
>>  =

>>  /* Push the promiscuity flag down to appropriate slaves */
>> @@ -1966,7 +1894,6 @@ int bond_enslave(struct net_device *bond_dev, str=
uct net_device *slave_dev,
>>  	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
>>  	struct slave *new_slave =3D NULL, *prev_slave;
>>  	struct sockaddr_storage ss;
>> -	int link_reporting;
>>  	int res =3D 0, i;
>>  =

>>  	if (slave_dev->flags & IFF_MASTER &&
>> @@ -1976,12 +1903,6 @@ int bond_enslave(struct net_device *bond_dev, st=
ruct net_device *slave_dev,
>>  		return -EPERM;
>>  	}
>>  =

>> -	if (!bond->params.use_carrier &&
>> -	    slave_dev->ethtool_ops->get_link =3D=3D NULL &&
>> -	    slave_ops->ndo_eth_ioctl =3D=3D NULL) {
>> -		slave_warn(bond_dev, slave_dev, "no link monitoring support\n");
>> -	}
>> -
>>  	/* already in-use? */
>>  	if (netdev_is_rx_handler_busy(slave_dev)) {
>>  		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>> @@ -2195,29 +2116,10 @@ int bond_enslave(struct net_device *bond_dev, s=
truct net_device *slave_dev,
>>  =

>>  	new_slave->last_tx =3D new_slave->last_rx;
>>  =

>> -	if (bond->params.miimon && !bond->params.use_carrier) {
>> -		link_reporting =3D bond_check_dev_link(bond, slave_dev, 1);
>> -
>> -		if ((link_reporting =3D=3D -1) && !bond->params.arp_interval) {
>> -			/* miimon is set but a bonded network driver
>> -			 * does not support ETHTOOL/MII and
>> -			 * arp_interval is not set.  Note: if
>> -			 * use_carrier is enabled, we will never go
>> -			 * here (because netif_carrier is always
>> -			 * supported); thus, we don't need to change
>> -			 * the messages for netif_carrier.
>> -			 */
>> -			slave_warn(bond_dev, slave_dev, "MII and ETHTOOL support not availa=
ble for slave, and arp_interval/arp_ip_target module parameters not specif=
ied, thus bonding will not detect link failures! see bonding.txt for detai=
ls\n");
>> -		} else if (link_reporting =3D=3D -1) {
>> -			/* unable get link status using mii/ethtool */
>> -			slave_warn(bond_dev, slave_dev, "can't get link status from slave; =
the network driver associated with this interface does not support MII or =
ETHTOOL link status reporting, thus miimon has no effect on this interface=
\n");
>> -		}
>> -	}
>> -
>>  	/* check for initial state */
>>  	new_slave->link =3D BOND_LINK_NOCHANGE;
>>  	if (bond->params.miimon) {
>> -		if (bond_check_dev_link(bond, slave_dev, 0) =3D=3D BMSR_LSTATUS) {
>> +		if (netif_carrier_ok(slave_dev)) {
>>  			if (bond->params.updelay) {
>>  				bond_set_slave_link_state(new_slave,
>>  							  BOND_LINK_BACK,
>> @@ -2759,7 +2661,7 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
>>  	bond_for_each_slave_rcu(bond, slave, iter) {
>>  		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
>>  =

>> -		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
>> +		link_state =3D netif_carrier_ok(slave->dev);
>>  =

>>  		switch (slave->link) {
>>  		case BOND_LINK_UP:
>> @@ -6257,10 +6159,10 @@ static int __init bond_check_params(struct bond=
_params *params)
>>  		downdelay =3D 0;
>>  	}
>>  =

>> -	if ((use_carrier !=3D 0) && (use_carrier !=3D 1)) {
>> -		pr_warn("Warning: use_carrier module parameter (%d), not of valid va=
lue (0/1), so it was set to 1\n",
>> -			use_carrier);
>> -		use_carrier =3D 1;
>> +	if (use_carrier !=3D 1) {
>> +		pr_err("Error: invalid use_carrier parameter (%d)\n",
>> +		       use_carrier);
>> +		return -EINVAL;
>>  	}
>>  =

>>  	if (num_peer_notif < 0 || num_peer_notif > 255) {
>> @@ -6507,7 +6409,6 @@ static int __init bond_check_params(struct bond_p=
arams *params)
>>  	params->updelay =3D updelay;
>>  	params->downdelay =3D downdelay;
>>  	params->peer_notif_delay =3D 0;
>> -	params->use_carrier =3D use_carrier;
>>  	params->lacp_active =3D 1;
>>  	params->lacp_fast =3D lacp_fast;
>>  	params->primary[0] =3D 0;
>> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/b=
ond_netlink.c
>> index 57fff2421f1b..e573b34a1bbc 100644
>> --- a/drivers/net/bonding/bond_netlink.c
>> +++ b/drivers/net/bonding/bond_netlink.c
>> @@ -259,13 +259,11 @@ static int bond_changelink(struct net_device *bon=
d_dev, struct nlattr *tb[],
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
>> +		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) !=3D 1) {
>> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_USE_CARRIER],
>> +					    "option obsolete, use_carrier cannot be disabled");
>> +			return -EINVAL;
>> +		}
>>  	}
>>  	if (data[IFLA_BOND_ARP_INTERVAL]) {
>>  		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
>> @@ -688,7 +686,7 @@ static int bond_fill_info(struct sk_buff *skb,
>>  			bond->params.peer_notif_delay * bond->params.miimon))
>>  		goto nla_put_failure;
>>  =

>> -	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
>> +	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
>>  		goto nla_put_failure;
>>  =

>>  	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interva=
l))
>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/b=
ond_options.c
>> index 3b6f815c55ff..c0a5eb8766b5 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -187,7 +187,6 @@ static const struct bond_opt_value bond_primary_res=
elect_tbl[] =3D {
>>  };
>>  =

>>  static const struct bond_opt_value bond_use_carrier_tbl[] =3D {
>> -	{ "off", 0,  0},
>>  	{ "on",  1,  BOND_VALFLAG_DEFAULT},
>>  	{ NULL,  -1, 0}
>>  };
>> @@ -419,7 +418,7 @@ static const struct bond_option bond_opts[BOND_OPT_=
LAST] =3D {
>>  	[BOND_OPT_USE_CARRIER] =3D {
>>  		.id =3D BOND_OPT_USE_CARRIER,
>>  		.name =3D "use_carrier",
>> -		.desc =3D "Use netif_carrier_ok (vs MII ioctls) in miimon",
>> +		.desc =3D "option obsolete, use_carrier cannot be disabled",
>>  		.values =3D bond_use_carrier_tbl,
>>  		.set =3D bond_option_use_carrier_set
>>  	},
>> @@ -1091,10 +1090,6 @@ static int bond_option_peer_notif_delay_set(stru=
ct bonding *bond,
>>  static int bond_option_use_carrier_set(struct bonding *bond,
>>  				       const struct bond_opt_value *newval)
>>  {
>> -	netdev_dbg(bond->dev, "Setting use_carrier to %llu\n",
>> -		   newval->value);
>> -	bond->params.use_carrier =3D newval->value;
>> -
>>  	return 0;
>
>Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>
>nit: any reason not to return -EINVAL here when the new value is not "1"?
>You do it for the module param, but not for the sysfs file here.

	For the sysfs option path, the new setting is validated against
the contents of use_carrier_tbl by __bond_opt_set before the above is
called, so we don't need to check it here.  The sysfs parsing accepts
either the number 1 or the text "on", so it's a bit more complicated.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

