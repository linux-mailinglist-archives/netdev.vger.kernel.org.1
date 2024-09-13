Return-Path: <netdev+bounces-127976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF09775E4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AE11F24507
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FBF391;
	Fri, 13 Sep 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="ZJOZDOKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dF7s8E3j"
X-Original-To: netdev@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858B376;
	Fri, 13 Sep 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186021; cv=none; b=j62e+QKGfVVlZIe3b7B6napogj/A9JxJbGKVU3M1ZlUEMSNWZOHdjABLquNZ4xv0emLhXGEgKZJjtzElihGE7fudNyHvMeZ6fFCzooCgxpQOivEleHDglWt7uSZMrtA48o3EHJ3Vix2WB9h5oG+ypVR7VvDXl2n4PNDsz1q4LVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186021; c=relaxed/simple;
	bh=FvXbuDIYKjNAbAAcRxFAh7oxKSlBNc2itf3fVC7x4B8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=b5v1xSxMPfaLqsESPwHR2EMeRFvFroOMPcZ+JswBv39d8qgM+KbzPbtX4wU53YfXi7jVvpOODIdb/SXOGLNnKcYhkNjcnKjbQIyVCld+MmiIqZFDSR5mBcYpZEHz0OY8JOqUCypQ5fsNo0shfqVFmHVzKYCcA+YK0SCauTMwzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=ZJOZDOKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dF7s8E3j; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D5AF13800B5;
	Thu, 12 Sep 2024 20:06:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 20:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1726186018; x=1726272418; bh=VIpDzQ5Q47McP90RMpSYT
	K1CUPLCRSwo82eQcpu1SQI=; b=ZJOZDOKrKA03oR165BSNuW9IDaomh43JA0Z2Y
	gSBm0dgshkYVZZ6mSlXd+Y4el06orAs9igwTVd9QKZsjZtFQrgjCFM85vZyME11B
	Y4+QxqnSnm1OE9r1CoXliylu61+BesWPz9iqRJk80Zhl1W5HaghcK3K2MXWIQ1e8
	hHp9L6p7ebcA2YkatyHLZmI8ME8J4oZxJ4+c9wK42rp5TbsF2C6l6CnT7/0gjcC0
	QG4FbSms3xA0BeXnSLGvjY+EQt69ZR9XCqrA0Um+3E1TjGTvpUVxWSE+8LWdkIgA
	qA82mHfP4dvW0snRSqtVIev7f4GAYLuzpxBLX5VgE84OkHgNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726186018; x=1726272418; bh=VIpDzQ5Q47McP90RMpSYTK1CUPLC
	RSwo82eQcpu1SQI=; b=dF7s8E3ji2RP1jjjkTdmLe1c+lmHTYyYB2mrgOhkWe+u
	dMvFH/oxSm8nIrhwNWG9bb/dnvH4h9qgCuJQxpEwUL2cZjGabDtFJhatIKnCcyMI
	K7PS7soWiHVMN/3EHNEcyxKvfl5j7dpaHn79kWqXJ6P4wVNI0KNm66FCf7VXpGCy
	vZ8QzLuMOPwiiLnjd5ho3x/iSE8PDHkwmGjzui4hhrahP9SeR+ul8sVb+j7XyfMy
	G5ORrwoySaPMJ6Zs0OnU24mlfqFX2M43NCSPvG67eBo8kjtDmnfTzrJIj37I7l8V
	0KGXutApU6l/h6v3dPy7HmMmydaevRTLqoid9cOB/Q==
X-ME-Sender: <xms:IYLjZhQQCNfafdql9BRKI7ssAXB7xGyqrIWpfsuarrBszhKiMFj7Cg>
    <xme:IYLjZqzsRj9kBBjyyNg9aN1WxPSDi5hPN3ayG5i-KcIY_cK7GX-66cIJPKRW3zLE3
    -k5za5ZOS_vexQ6TAk>
X-ME-Received: <xmr:IYLjZm2lxff8WdXuDR3m226RucwbrFGjXTelG1zsfZVm1Qrlu13ILbZ29APegV0BKArDZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddv
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveel
    ffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepshhurhgvshhhvdehudegsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    grnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IYLjZpDJJl0BhUj3jOy57IMZ3N4kWpcMMiilIQWTj2qU330C2iphMA>
    <xmx:IYLjZqj2nm-26_C_rAx880Y-A0c-zJSbf9mbooWzq6TmsUVulRACww>
    <xmx:IYLjZtqREOwMZSUJxTOamzgniKg_NQFi1nHSapTCBQJ5lT6niTPz5g>
    <xmx:IYLjZliHrVligt1w_rirahdkFpOc0BM-irf6x1i1hxX1lo1cfpbAAg>
    <xmx:IoLjZjXDjIFDTHGoMk1e75wJlrVxNqDNsc-J4WHJj2qtUdJNDuxtpbxG>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 20:06:57 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2D0869FC93; Thu, 12 Sep 2024 17:06:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 29BDB9FC92;
	Thu, 12 Sep 2024 17:06:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Suresh Kumar <suresh2514@gmail.com>
cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bonding: do not set force_primary if reselect is set
 to failure
In-reply-to: <20240912064043.36956-1-suresh2514@gmail.com>
References: <20240912064043.36956-1-suresh2514@gmail.com>
Comments: In-reply-to Suresh Kumar <suresh2514@gmail.com>
   message dated "Thu, 12 Sep 2024 12:10:43 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <397120.1726186016.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 17:06:56 -0700
Message-ID: <397121.1726186016@famine>

Suresh Kumar <suresh2514@gmail.com> wrote:

>when bond_enslave() is called, it sets bond->force_primary to true
>without checking if primary_reselect is set to 'failure' or 'better'.
>This can result in primary becoming active again when link is back which
>is not what we want when primary_reselect is set to 'failure'

	The current behavior is by design, and is documented in
Documentation/networking/bonding.rst:


	The primary_reselect setting is ignored in two cases:

		If no slaves are active, the first slave to recover is
		made the active slave.

		When initially enslaved, the primary slave is always made
		the active slave.


	Your proposed change would cause the primary to never be made
the active interface when added to the bond for the primary_reselect
"better" and "failure" settings, unless the primary interface is added
to the bond first or all other interfaces are down.

	Also, your description above and the test example below use the
phrases "link is back" and "primary link failure" but the patch and test
context suggest that the primary interface is being removed from the
bond and then later added back to the bond, which is not the same thing
as a link failure.

	-J

>Test
>=3D=3D=3D=3D
>Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
>
>Bonding Mode: fault-tolerance (active-backup)
>Primary Slave: enp1s0 (primary_reselect failure)
>Currently Active Slave: enp1s0
>MII Status: up
>MII Polling Interval (ms): 100
>Up Delay (ms): 0
>Down Delay (ms): 0
>Peer Notification Delay (ms): 0
>
>Slave Interface: enp1s0
>MII Status: up
>Speed: 1000 Mbps
>Duplex: full
>Link Failure Count: 0
>Permanent HW addr: 52:54:00:d7:a7:2a
>Slave queue ID: 0
>
>Slave Interface: enp9s0
>MII Status: up
>Speed: 1000 Mbps
>Duplex: full
>Link Failure Count: 0
>Permanent HW addr: 52:54:00:da:9a:f9
>Slave queue ID: 0
>
>
>After primary link failure:
>
>Bonding Mode: fault-tolerance (active-backup)
>Primary Slave: None
>Currently Active Slave: enp9s0 <---- secondary is active now
>MII Status: up
>MII Polling Interval (ms): 100
>Up Delay (ms): 0
>Down Delay (ms): 0
>Peer Notification Delay (ms): 0
>
>Slave Interface: enp9s0
>MII Status: up
>Speed: 1000 Mbps
>Duplex: full
>Link Failure Count: 0
>Permanent HW addr: 52:54:00:da:9a:f9
>Slave queue ID: 0
>
>
>Now add primary link back and check bond status:
>
>Bonding Mode: fault-tolerance (active-backup)
>Primary Slave: enp1s0 (primary_reselect failure)
>Currently Active Slave: enp1s0  <------------- primary is active again
>MII Status: up
>MII Polling Interval (ms): 100
>Up Delay (ms): 0
>Down Delay (ms): 0
>Peer Notification Delay (ms): 0
>
>Slave Interface: enp9s0
>MII Status: up
>Speed: 1000 Mbps
>Duplex: full
>Link Failure Count: 0
>Permanent HW addr: 52:54:00:da:9a:f9
>Slave queue ID: 0
>
>Slave Interface: enp1s0
>MII Status: up
>Speed: 1000 Mbps
>Duplex: full
>Link Failure Count: 0
>Permanent HW addr: 52:54:00:d7:a7:2a
>Slave queue ID: 0
>
>Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index bb9c3d6ef435..731256fbb996 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2146,7 +2146,9 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 		/* if there is a primary slave, remember it */
> 		if (strcmp(bond->params.primary, new_slave->dev->name) =3D=3D 0) {
> 			rcu_assign_pointer(bond->primary_slave, new_slave);
>-			bond->force_primary =3D true;
>+            if (bond->params.primary_reselect !=3D BOND_PRI_RESELECT_FAI=
LURE  &&
>+                bond->params.primary_reselect !=3D BOND_PRI_RESELECT_BET=
TER)
>+			    bond->force_primary =3D true;
> 		}
> 	}
> =

>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

