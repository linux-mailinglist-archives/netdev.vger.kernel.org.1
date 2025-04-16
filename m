Return-Path: <netdev+bounces-183090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA7A8AD76
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C5516D055
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F72211A2A;
	Wed, 16 Apr 2025 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="V8jbW0Ym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mg5KYN3H"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE5211704;
	Wed, 16 Apr 2025 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744766119; cv=none; b=UFFBsAAr5VV+fSz2S9ciiP/Tq4QJCrjAb/1AwWdYpC7+ulz3/b5cdtGcPDa44zoSU0q3PRLz05AD3mUVLfHHHjd4sCE5pOi0M6qgWGH+nIaeGOWBef/aU315bodeQKGv49YQ5moIOEY4ySvu/gebk9E1w+u2QvYCcSFScSi4R5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744766119; c=relaxed/simple;
	bh=LbR/HO1xEgWhqjMGIMXVt/qdUpBIhy50VbWTpdakICs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TFK11aVsFGigKA1fCJyynxnGSO7MPO47Ju/f+upIWZ/dUs6LpdlaUgEHMaQCBe4bJDRFY2D4RxJIiNTr1vhRTZmERnqJjpoxHpCKtW4uPfy+eGKuZG3JnnS1UJexSeiE20A40cCcCkBB17SlNqEFzQ8q98MhIZI0RLoh753+r/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=V8jbW0Ym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mg5KYN3H; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F3581140189;
	Tue, 15 Apr 2025 21:15:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Apr 2025 21:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744766114; x=1744852514; bh=jnBIm/5tJ4NzfihYdPrUq
	zBTp2e3zOqRSopkwUkiu88=; b=V8jbW0YmedV1RrcpdViZQB+sIk9kbI6Jx1/jx
	V7uWn3ALJdup97PQjc+jJoDx/gP6oopqtN/Vp0TK49LFH7v65RGzQnI0Swbjh6vn
	9sjJP3+1DSgWzm1lawMounN1EZ9z4U3XpzxZWT0vXnP+Xr9EOVArTlOTWpbK+J2H
	FYwdnZbNzlv2P0aKXbfrodna7nwjR5Vi5vKzNwy0bauksaZ4poKGeJcGTMNCzyKD
	AWFyxR9AJy3RlYaXCrxXNOLYYLZdkJTbcZJSH5f+30Y3SZTtWPpolAiZ1kATU8+J
	PeXDom/k/MoD3IKYJTWCqYTgUwndM7rGR9oFW3BgdaKYUkpeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744766114; x=1744852514; bh=jnBIm/5tJ4NzfihYdPrUqzBTp2e3zOqRSop
	kwUkiu88=; b=mg5KYN3HCnVIzIAMTJPpK6780M/Fp4qBDKnCAI7mlnoqgfntmS3
	z0PcqpxIgQ0pCsJ5S4Y+jQN90zZ/kr7TBAE19GfMQyB0VDcbVzpN8pGWmX2H+Vvr
	CWzIDovsyIeeXKqMqg0LhlwO9Frz8hWmkfMC6vCvBSLTYBXgG/eOEJ4FvTQtWqLK
	VU4YA7TprJwem1fu+hzl9OfRj+V/eeCppeiYcIMpHBVjO0sPKUCS7yP+B4p6BdTy
	kErmncuxsIheBTqHowHftCcJjLgdFG36cXHUxXNA+7XFehbbhjBW1VKSmIgjaxoU
	8mBRASDLKGIHcqhMbvHAjl5uaEcgcYatFcw==
X-ME-Sender: <xms:oQT_Z7r0R2Ex9_fu82WNymrM3go1eAs98EqgNA9LNfzZ2UxvejCZ7w>
    <xme:oQT_Z1pr8EA883QYNf25LPqWZavwP9k5GGzQ7CfFCUniLZv5uks1BEW8-b1rt7M5S
    O9mBj4jBVNBuNB4E3o>
X-ME-Received: <xmr:oQT_Z4PpKKEwpM9-2k4pL1mq9BLFsqORshwg2O92vLgvajoHThxnysv5wxd4jyG2MW72wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehtddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oQT_Z-6K3oOm8X1i3wQBeba6-yep9HX0QAQ4ORVXZa8_xBUv6lT3iA>
    <xmx:oQT_Z66_PspOnYT3HtBJ6eNyvbGiw_Tjfd8sha0_1PAHC3kZqorC_A>
    <xmx:oQT_Z2iNPJY3bXpQCo_gitWZYXdZhzpa_Gk61pIR0pFGgOt7h4iZKQ>
    <xmx:oQT_Z842UV0jZbXuj2Z-YEkLb1JRa0jrpnmsJLFGFzVm6le3owMaZQ>
    <xmx:ogT_ZwWQ93gElikdbVI-4oTJDu-iThqCSUvhZzEoIXhnWQnptNOVe92I>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 21:15:13 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B5C589FD38; Tue, 15 Apr 2025 18:15:12 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B2CA39FC8A;
	Tue, 15 Apr 2025 18:15:12 -0700 (PDT)
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
In-reply-to: <Z_yl7tQne6YTcU6S@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine> <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 14 Apr 2025 06:06:38 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4177945.1744766112.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Apr 2025 18:15:12 -0700
Message-ID: <4177946.1744766112@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>On Mon, Apr 07, 2025 at 09:35:03AM +0000, Hangbin Liu wrote:
>> > 	So this patch's change wouldn't actually resolve the MAC
>> > conflict until a failover takes place?  I.e., if we only do step 4 bu=
t
>> > not step 5 or 6, eth0 and eth1 will both have the same MAC address.  =
Am
>> > I understanding correctly?
>> =

>> Yes, you are right. At step 4, there is no failover, so eth0 is still u=
sing
>> it's own mac address. How about set the mac at enslave time, with this =
we
>> can get correct mac directly. e.g.
>
>Any comments for the new approach?

	Sorry, just getting back to this.

>Thanks
>Hangbin
>> =

>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> index 950d8e4d86f8..0d4e1ddd900d 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -2120,6 +2120,24 @@ int bond_enslave(struct net_device *bond_dev, st=
ruct net_device *slave_dev,
>>  			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n"=
, res);
>>  			goto err_restore_mtu;
>>  		}
>> +	} else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
>> +		   BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>> +		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_le=
n) =3D=3D 0) {
>> +		/* Set slave to current active slave's permanent mac address to
>> +		 * avoid duplicate mac address.
>> +		 */
>> +		curr_active_slave =3D rcu_dereference(bond->curr_active_slave);
>> +		if (curr_active_slave) {
>> +			memcpy(ss.__data, curr_active_slave->perm_hwaddr,
>> +			       curr_active_slave->dev->addr_len);
>> +			ss.ss_family =3D slave_dev->type;
>> +			res =3D dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
>> +					extack);
>> +			if (res) {
>> +				slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n=
", res);
>> +				goto err_restore_mtu;
>> +			}
>> +		}

	Is this in replacement of the prior patch (that does stuff
during failover), or in addition to?

	I'm asking because in the above, if there is no
curr_active_slave, e.g., all interfaces in the bond are down, the above
would permit MAC conflict in the absence of logic in failover to resolve
things.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

