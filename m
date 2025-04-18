Return-Path: <netdev+bounces-184068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B6A93120
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 06:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BFA8A752C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70431D5ACE;
	Fri, 18 Apr 2025 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="GWjpOOLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gByvhMxz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCE1CD15;
	Fri, 18 Apr 2025 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949798; cv=none; b=YzF0s1aFXNb1lbJl5Rs4ZfMmURdd5pyhpLOW+VXOqEsZpAlueiL06Uk+SBxdEtHOInaHuccFJH3K3wvTtGn6N3iUZLQwbj2V+aaNeWeC8M53HWCqR6QgCgNZOj8Bdv+ZYzzMWooKN7wUQtTpbKsGtwoonLwLVf3DYZq+8fOeOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949798; c=relaxed/simple;
	bh=HTVYu5YZ2UlRDgI4DhnXcUjUecU98qvOKuPpLwHFjH4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Z00f+SkESorJTyCcDtQPX77AorPRz3wpMPy8I0wRrPnM6WivVzf6jtEQlQXG5uOT7MG4NEkVaMFXKDF7jO3oDo85srZVWNQ7eCf2w7GmbMqqoBOqSarDJ2yZ9euzg+PqkPDbqDaIRqcGxfcbQJY0ABqBGz0wARghZxr41yb+70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=GWjpOOLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gByvhMxz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD446254017D;
	Fri, 18 Apr 2025 00:16:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 18 Apr 2025 00:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744949794; x=1745036194; bh=AtjvMy942rp3hJyuKVGEc
	B4Dnhb47VVFNtGVTXF0hBw=; b=GWjpOOLl8LhQViF9tRH/2ZeieN8UFtJU6MdJh
	Ne7KbESBBin2fIilQRl9NjeH1hXaVH6gU55ykFOZjz6NsZZCudllekf7mY/YM94o
	GyXF6l4fXe1z+/nERdhQ7LY6jsj3fIKVDKR2IXReUcAyyn5WGN40+q7fQl6I+TqB
	hrjihkjXNINlNwTcMj1UTKROjbclZOCmvuyLL7biN/ysqxx82FONzCwv4Im9p1GT
	+j/wNiB028WksuLHsq25ww7nwlyXqcXYAQhBzr59npmgxaw7zqhGxKjoFBGnkSOS
	LcS+7vpjnuOd/tSpVz6NHOFGVb2xAtj7kL3zXVrZlYsCxa72g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744949794; x=1745036194; bh=AtjvMy942rp3hJyuKVGEcB4Dnhb47VVFNtG
	VTXF0hBw=; b=gByvhMxzQd4s7DeCJVY/RlE0huYoKEPBzHdpeKhr2MsUAqfKg+i
	mn+0p9q9LP034AntaPC09XJ3WbqWlwkJcvYacEBzSFI/4zyZ1mHqZ0zfV3pNIAfA
	83f/6uUiC1sYYbGtjT6UsLhWAiB7NYIZSkQ0KdKpdSK0d4MrZNAxENO8LZUrBaVZ
	u+cc/AhskHYfDwV5fg90uriqzncnk8M/foAVe50MGOJ0yGyl1P4LVbbQiEauOFA2
	6NOlkbqW47tDoUnpLNWhlhE5zbSdmEKCpLhoW53emOF6xaHkIoyDwpwAV2sWAG+d
	liiWL1O9rPiOAoiqvFsmW3MRbk+OiT/pZfw==
X-ME-Sender: <xms:ItIBaDosh1SLXVcltLD_8gRJDSfID2k5CqeZdpG9qAtjPtoKYVV7xQ>
    <xme:ItIBaNoMuMgfvM1JvindWoYVnReF754JRJb2jUSOYd39xLx7Ka1n_Gv-uDkXf46ms
    9o0vcAJu6PjS3BwlfY>
X-ME-Received: <xmr:ItIBaAOtQa7fDZo7lNgzUJUVjkZtIF_3SPuXbbBcDb4d0QZbHWCGLX_blwDyEshM2iX_ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthho
    pegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvg
    guhhgrthdrtghomh
X-ME-Proxy: <xmx:ItIBaG7IDpHgspr7kZCbcP-YgvRqHFQh_pn3X1P5yDQe9AgAvgUsGg>
    <xmx:ItIBaC7vCXHkK4iBbKS9EyUES9nIa5yExCjP2v0L7dzTWVyPu6f9Hw>
    <xmx:ItIBaOjGbPFYtEXk05wQmVRumf0rPa9UoBQ11QqEN-bzYIgIgFiQqg>
    <xmx:ItIBaE6ygoZ-FwWjwZwlFBRYa8cpLTyz557Mv5IiUwp_pWMo5HpElQ>
    <xmx:ItIBaIW16v3G8gJufpwJVey452nggftuZ0TrUuJoD8OI_Ut2X3gWn5mQ>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 00:16:33 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2126E9FD3F; Thu, 17 Apr 2025 21:16:33 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1D94C9FC4C;
	Thu, 17 Apr 2025 21:16:33 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
In-reply-to: <Z_8bfpQb_3fqYEcn@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine> <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora> <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 16 Apr 2025 02:52:46 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <155384.1744949793.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Apr 2025 21:16:33 -0700
Message-ID: <155385.1744949793@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Tue, Apr 15, 2025 at 06:15:12PM -0700, Jay Vosburgh wrote:
>> >> =

>> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/b=
ond_main.c
>> >> index 950d8e4d86f8..0d4e1ddd900d 100644
>> >> --- a/drivers/net/bonding/bond_main.c
>> >> +++ b/drivers/net/bonding/bond_main.c
>> >> @@ -2120,6 +2120,24 @@ int bond_enslave(struct net_device *bond_dev,=
 struct net_device *slave_dev,
>> >>  			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address=
\n", res);
>> >>  			goto err_restore_mtu;
>> >>  		}
>> >> +	} else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
>> >> +		   BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>> >> +		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr=
_len) =3D=3D 0) {
>> >> +		/* Set slave to current active slave's permanent mac address to
>> >> +		 * avoid duplicate mac address.
>> >> +		 */
>> >> +		curr_active_slave =3D rcu_dereference(bond->curr_active_slave);
>> >> +		if (curr_active_slave) {
>> >> +			memcpy(ss.__data, curr_active_slave->perm_hwaddr,
>> >> +			       curr_active_slave->dev->addr_len);
>> >> +			ss.ss_family =3D slave_dev->type;
>> >> +			res =3D dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
>> >> +					extack);
>> >> +			if (res) {
>> >> +				slave_err(bond_dev, slave_dev, "Error %d calling set_mac_addres=
s\n", res);
>> >> +				goto err_restore_mtu;
>> >> +			}
>> >> +		}
>> =

>> 	Is this in replacement of the prior patch (that does stuff
>> during failover), or in addition to?
>> =

>> 	I'm asking because in the above, if there is no
>> curr_active_slave, e.g., all interfaces in the bond are down, the above
>> would permit MAC conflict in the absence of logic in failover to resolv=
e
>> things.
>
>Hmm, then how about use bond_for_each_slave() and find out the link
>that has same MAC address with bond/new_slave?

	But even if we find it, aren't we stuck at that point?  The
situation would be that the bond and one backup interface have MAC#1.
MAC#1 may or may not be that backup interface's permanent MAC address,
and we're adding another interface, also with MAC#1, which might be the
newly added interface's permanent MAC.  The MAC swap gyrations to
guarantee this would work correctly in all cases seem to be rather
involved.

	Wouldn't it be equally effective to, when the conflicting
interface is added, give it a random MAC to avoid the conflict?  That
random MAC shouldn't end up as the bond's MAC, so it would exist only as
a placeholder of sorts.

	I'm unsure if there are many (any?) devices in common use today
that actually have issues with multiple ports using the same MAC, so I
don't think we need an overly complicated solution.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

