Return-Path: <netdev+bounces-255172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHh9HZPQfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:38:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB804BC1AD
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9904E301104C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4397336EE3;
	Fri, 30 Jan 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="FbJXQXwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tO9/gv5J"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A3334C24;
	Fri, 30 Jan 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787535; cv=none; b=q1AhKPuHej0AVpAstk/36iAw5WHbJmK/nyoZErfeHGg2KyYsSiGOM4BV0Mqk+wV8h0cRCHSLsPrV5knkesh1kUaSXaSFozWiyPaq3oPObHUuIQTz5iY0twpOTVclKJxoLV7+IYsJNAyhvlkj9ge6yA9o5VWCHz2lDpzGgO27WrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787535; c=relaxed/simple;
	bh=bCzAuoYC2y7MrXXeTCUiZR3MapH4/FvcuXgSkwOlcm0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=st7MhZZath3KU8umpoCTYbw9Y6vIHJxTyXfEAfI+sNipqXeOs45s/dm7e9Q0kvGz29CVtskbBlrYKPPUPwCbsxjZEmgcbXzxSfoyrD1hGf7VbrEIMRQtu8qgIJEuDvIZQoTid35ZMX9sXVfODGHe5vlpo0RddMNPt33otiHvb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=FbJXQXwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tO9/gv5J; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C2B8EC057C;
	Fri, 30 Jan 2026 10:38:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 10:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1769787532; x=1769873932; bh=vSumldh0CD7k7bpV9a930
	QhMsKp5sS4frGwyVFI0Ibo=; b=FbJXQXwlWQw7gGai/19vStSPaYXoZ1G1pGrZo
	4O1kadFMzQ3skB6pClVyLRze4b80AhKQUSjiC1WFVsM/P8SblJl9J8BJmJXe5+SW
	wmfBsVAXvqvRtI/Zqx7EA+s7zBSq5bLXRpF6YlkukVUDdvkDsseVFXrc9sBoNUbU
	2aXsYa8DnTQJpfRm4eKg++bcY9OS0hptt1khSVQ2bzgU8Vhw9RGfiFOgvUXcxbMO
	RFj/2zMdUpCd/r8o0kxiFvIxQoObxEC9HhAJ6UZhmBPmNMuwCOYZDuMibuIPbi+X
	f5o0qsy7T3rdqIl8zVl45XUZzI2y3tsCe7uToG5BeR54XH4jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769787532; x=1769873932; bh=vSumldh0CD7k7bpV9a930QhMsKp5sS4frGw
	yVFI0Ibo=; b=tO9/gv5Jt2Zcpm0wMOEdEOIlgU3C3412YKG9Kcf56Xm3DRZLJUT
	pdK2bpZWat3Jerlv3pxd5f2K+4u3M90WJervC80FejLIjCuEmWjPAaloQaIjO/kn
	LNhIGuZGDyIzEjZVPvToe1GX6Q8XaBY1KFMwwPl1MCmyFvP1+PxKeWov8hrFu4YW
	nES2XzIXA1k9zc5bo37CWOjqqv/IMx0FD7rH4vPGKUaBfhA50GMe3XpCL/xM/LXv
	RGY1DNC4XuYgUrCnNBLvP01gyzEq8JvgOOlZuopJBDcaq+uesID3yEG1Wk/hzusp
	gFXop++1/HRt/Ab7wul3oMqMhRJwPivZyiw==
X-ME-Sender: <xms:i9B8afSFgThw2mLY5tW03t5N2P5hMupvxF5po2Wwz8p76rR38j6SZA>
    <xme:i9B8aVv2-4-4SPQg79E5nu_UWS-nXuuFIJclG42ZFQczrUP6za_sdLWat8V4yAt8s
    KQCLX2t1mFTJh8pcaPxy-P3kchj5HcRN-AYi8ZjNtcl4-4bCsSlcyU>
X-ME-Received: <xmr:i9B8aZHWATVzK0zZwId1N7TP_r-7UG9a8IaRDxM5akG_yqAdIFey-M_NxcoleOZKmyPp8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthgsohhgvg
    hnughovghrfhgvrhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i9B8aexX3NXTuF-aG47CZL-8_c0czBcsRgGN6-FRkpw5zjqHQiS0RQ>
    <xmx:i9B8ab1zZoQ8uy0aR20gFQrtDnrE0WLHQrPjgXSh_RSmM6AMsQGcDA>
    <xmx:i9B8aWr8ons1NgdPkXC9uPEDOx8pqFHW7PySHzwFsLmp-841imiZGg>
    <xmx:i9B8aQXuiiSgpDyv-1R1V4BVjJSN3I6GFZfjKrxDtrvIPbY6fIp5hA>
    <xmx:jNB8afP6YfwDWqHiuMXmjyrT-Hy4vDz8d1_iAkN1zKbJsm94CwvXppO3>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 10:38:51 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 63F699FCAE; Fri, 30 Jan 2026 07:38:50 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 60C619FC7D;
	Fri, 30 Jan 2026 07:38:50 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if getting
 speed failed
In-reply-to: <aXylwyr2pV0rZAW3@fedora>
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
 <aXylwyr2pV0rZAW3@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 30 Jan 2026 12:36:19 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3932973.1769787530.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 07:38:50 -0800
Message-ID: <3932974.1769787530@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255172-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BB804BC1AD
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote:
>> bond_update_speed_duplex() first set speed/duplex to unknown and
>> then asks slave driver for current speed/duplex. Since getting
>> speed/duplex might take longer there is a race, where this false state
>> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
>
>The patch looks good to me. But based on your description, I don't think
>the fixes tag is correct.

	Agreed on both points; I suspect the origin of the race window
is:

commit e9fe8efeeae11f19bb6fafd6153ec77deaeb4b83
Author: Nikolay Aleksandrov <razor@blackwall.org>
Date:   Tue Sep 9 23:17:01 2014 +0200

    bonding: procfs: clean bond->lock usage and use RCU

	as this patch converted some locking in the procfs logic to be
solely RCU.

	-J

>Thanks
>Hangbin
>>  update port speed when getting bond speed") this race gets more visibl=
e,
>> if user space is calling ethtool on a regular base.
>> =

>> Fix this by only setting speed/duplex to unknown, if link speed is
>> really unknown/unusable.
>> =

>> Fixes: 691b2bf14946 ("bonding: update port speed when getting bond spee=
d")
>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>> ---
>>  drivers/net/bonding/bond_main.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>> =

>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> index e7caf400a59c..4cdf89b21ca0 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave =
*slave)
>>  	struct ethtool_link_ksettings ecmd;
>>  	int res;
>>  =

>> -	slave->speed =3D SPEED_UNKNOWN;
>> -	slave->duplex =3D DUPLEX_UNKNOWN;
>> -
>>  	res =3D __ethtool_get_link_ksettings(slave_dev, &ecmd);
>>  	if (res < 0)
>> -		return 1;
>> +		goto speed_duplex_unknown;
>>  	if (ecmd.base.speed =3D=3D 0 || ecmd.base.speed =3D=3D ((__u32)-1))
>> -		return 1;
>> +		goto speed_duplex_unknown;
>>  	switch (ecmd.base.duplex) {
>>  	case DUPLEX_FULL:
>>  	case DUPLEX_HALF:
>>  		break;
>>  	default:
>> -		return 1;
>> +		goto speed_duplex_unknown;
>>  	}
>>  =

>>  	slave->speed =3D ecmd.base.speed;
>>  	slave->duplex =3D ecmd.base.duplex;
>>  =

>>  	return 0;
>> +
>> +speed_duplex_unknown:
>> +	slave->speed =3D SPEED_UNKNOWN;
>> +	slave->duplex =3D DUPLEX_UNKNOWN;
>> +
>> +	return 1;
>>  }
>>  =

>>  const char *bond_slave_link_status(s8 link)
>> -- =

>> 2.43.0
>> =


---
	-Jay Vosburgh, jv@jvosburgh.net

