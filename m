Return-Path: <netdev+bounces-193166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A4AC2B35
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0231BA63D0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE519F12D;
	Fri, 23 May 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="WCw/0Fh/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4AMcs+k"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25721607AC;
	Fri, 23 May 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034233; cv=none; b=sTC9VLgGwVmQjJn8qTcCb8/lLbmKlq9z6ik/nfc4FTWn0kkO8vGJiWps4QhmXXap8RHBtBO/0K8BWRYTclHFa9HKHnffaSAH6KU00inUhUDC0S/+ul5BfLI8qYxT/rUyHqADFPKTePYGjGNMJ1cOKjpYabU6IvQyFS9jn1ZWMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034233; c=relaxed/simple;
	bh=/IiXj3E4+FeSoPsLAsIVemJgDu+JRE0O87UJmqVzfT8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=bq01BBo6naWpXsJhWyo7RQxAR8iogOxSRZtdZ5DuLzRpxQxMUYvaLgv5NaJgMPwdpjgZqnaQoP0/w+JNw1abBjq/mcX82xJ+iZT5fRR9EOa7zWLP7HSrEZCR/ADFnGZ4QN+zw5ACUBbnr3erTuBpopBSFRGMzXaPkm9SLxLJ/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=WCw/0Fh/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4AMcs+k; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B15C211400F9;
	Fri, 23 May 2025 17:03:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 23 May 2025 17:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1748034229; x=1748120629; bh=iD3kTN8lxZ46QjQ91/6E2
	NmFqApWChl1pBLEjrMFtw4=; b=WCw/0Fh/7KesMAiI3BHvJouv98em0iRYnujDL
	gBCC3m/Q2YJKp9LKJ97hTZ7K1ARTI7inZjzC2CTucWoAenpM2UGLgkUYwva33Bmh
	DgOHm9ItMnJVGYb7tUAKkDOiSan0ZrNzPiPf7Ih8wMVVMzJCKGLUXBtx9n6GJk0B
	WPkGWECc4w4EcPZh3woGk8kuL56S3SkafLdJZOaOs0j6xo/Yi4RduADWYFhnlwOP
	GkduhBWZB2hHaj9iCt5/rq+dDyI/2ZVxXdQKblJvjB4M5Gxi3N2y3NfCPn6Fmdyr
	D/qYRsAeGxcj/mCBb08rq7xy+gnLXnDOLoL52Rb9E77HGAqqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748034229; x=1748120629; bh=iD3kTN8lxZ46QjQ91/6E2NmFqApWChl1pBL
	EjrMFtw4=; b=I4AMcs+kRGtnpFP/cS+DEag58D38tFsZTnnNaatXbWUp6n3dsko
	oxK8lvDJdbJfr8u1jnZ20C3gVCYIH9ZUgNolDhs8Kge0Lwu5vnGbA/OqPwBon8pH
	Ry32dyNztX6wsGNX8BQjqKgPG55Fv3pBJgTTAYOt6SOj5ZCo2RvQcw6LyBe1sHd2
	plnYZyjMo1Pbe3FTJsqd9ZGw9Da9DOnNPtPiQUZa4voszgI+xuStN/vO2Xti9jHp
	ccilNJ0P/73FFQ/rDTZPz7TiWYC3SxSzfc4gpxfvzpxyKHPqS/lxbmfVMwsuR2de
	0+ygu5LqdBJExvVRt9Obau8DPo9zL1Fms7w==
X-ME-Sender: <xms:teIwaJxk5G-wonNWD3Cz9ykwPq72NBXR4kWU_aKh3MFwAC8tBMTqsg>
    <xme:teIwaJQaaSbZJ_3IoeGymMJTN-kLaC4M0Il_lDCgKsTwdIBQVh1PI-LDeukPfgzYh
    eqK5vdIQBbRYE5GZzI>
X-ME-Received: <xmr:teIwaDWhcZiJFdlHZ9OCfTdW9o_dwfUY4ZAjFyug5DF4iusuMTUYVVAA4147UsQpHL0PmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelkeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghfofgg
    tgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvh
    esjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeev
    tefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhn
    vghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhn
    rdgthhdprhgtphhtthhopehlihgrlhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:teIwaLit9tZmTozAlbJ14qu9X84v9kF2qv8Fnh-evJ1TVsT0PSmKEQ>
    <xmx:teIwaLAL_xgTWxmBkyf-Jc8b4KtyojP-wenLj-apfKEkJatew3hmfg>
    <xmx:teIwaEK2PrAOh5fsu4YSsjSFkwRAsrKn1A0Mnx4WYjgMv6Zx22o00w>
    <xmx:teIwaKB36BUzeAAzu1p1D4xWwNAwYTDMehPYHvs2eg6214OkQaGFHg>
    <xmx:teIwaB3ZAIScRG_Ytn-2fpPOU2scYblG3Nf2V4Pba3VHjYFA9qksXfiG>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 17:03:48 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 93E7E9FCA6; Fri, 23 May 2025 14:03:47 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 90EAE9FCA4;
	Fri, 23 May 2025 14:03:47 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
    Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: fix multicast MAC address synchronization
In-reply-to: <20250523022313.906-1-liuhangbin@gmail.com>
References: <20250523022313.906-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 23 May 2025 02:23:13 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302766.1748034227.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 May 2025 14:03:47 -0700
Message-ID: <302767.1748034227@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>There is a corner case where the NS (Neighbor Solicitation) target is set=
 to
>an invalid or unreachable address. In such cases, all the slave links are
>marked as down and set to backup. This causes the bond to add multicast M=
AC
>addresses to all slaves.
>
>However, bond_ab_arp_probe() later tries to activate a carrier on slave a=
nd
>sets it as active. If we subsequently change or clear the NS targets, the
>call to bond_slave_ns_maddrs_del() on this interface will fail because it
>is still marked active, and the multicast MAC address will remain.

	This seems complicated, so, just to make sure I'm clear, the bug
being fixed here happens when:

(a) ARP monitor is running with NS target(s), all of which do not
solicit a reply (invalid address or unreachable), resulting in all
interfaces in the bond being marked down

(b) while in the above state, the ARP monitor will cycle through each
interface, making them "active" (active-ish, really, just enough for the
ARP mon stuff to work) in turn to check for a response to a probe

(c) while the cycling from (b) is occurring, attempts to change a NS
target will fail on the interface that happens to be quasi-"active" at
the moment.

	Is my summary correct?

	Doesn't the failure scenario also require that arp_validate be
enabled?  Looking at bond_slave_ns_maddrs_{add,del}, they do nothing if
arp_validate is off.

>To fix this issue, move the NS multicast address add/remove logic into
>bond_set_slave_state() to ensure multicast MAC addresses are updated
>synchronously whenever the slave state changes.

	Ok, but state change calls happen in a lot more places than the
existing bond_hw_addr_swap(), which is only called during change of
active for active-backup, balance-alb, and balance-tlb.  Are you sure
that something goofy like setting arp_validate and an NS target with the
ARP monitor disabled (or in a mode that disallows it) will behave
rationally?

>Note: The call to bond_slave_ns_maddrs_del() in __bond_release_one() is
>kept, as it is still required to clean up multicast MAC addresses when
>a slave is removed.
>
>Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave d=
evice")
>Reported-by: Liang Li <liali@redhat.com>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 9 ---------
> include/net/bonding.h           | 7 +++++++
> 2 files changed, 7 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 8ea183da8d53..6dde6f870ee2 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1004,8 +1004,6 @@ static void bond_hw_addr_swap(struct bonding *bond,=
 struct slave *new_active,
> =

> 		if (bond->dev->flags & IFF_UP)
> 			bond_hw_addr_flush(bond->dev, old_active->dev);
>-
>-		bond_slave_ns_maddrs_add(bond, old_active);
> 	}
> =

> 	if (new_active) {
>@@ -1022,8 +1020,6 @@ static void bond_hw_addr_swap(struct bonding *bond,=
 struct slave *new_active,
> 			dev_mc_sync(new_active->dev, bond->dev);
> 			netif_addr_unlock_bh(bond->dev);
> 		}
>-
>-		bond_slave_ns_maddrs_del(bond, new_active);
> 	}
> }
> =

>@@ -2350,11 +2346,6 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
> 	bond_compute_features(bond);
> 	bond_set_carrier(bond);
> =

>-	/* Needs to be called before bond_select_active_slave(), which will
>-	 * remove the maddrs if the slave is selected as active slave.
>-	 */
>-	bond_slave_ns_maddrs_add(bond, new_slave);
>-
> 	if (bond_uses_primary(bond)) {
> 		block_netpoll_tx();
> 		bond_select_active_slave(bond);
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 95f67b308c19..0041f7a2bd18 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -385,7 +385,14 @@ static inline void bond_set_slave_state(struct slave=
 *slave,
> 	if (slave->backup =3D=3D slave_state)
> 		return;
> =

>+	if (slave_state =3D=3D BOND_STATE_ACTIVE)
>+		bond_slave_ns_maddrs_del(slave->bond, slave);
>+
> 	slave->backup =3D slave_state;
>+
>+	if (slave_state =3D=3D BOND_STATE_BACKUP)
>+		bond_slave_ns_maddrs_add(slave->bond, slave);

	This code pattern kind of makes it look like the slave->backup
assignment must happen between the two new if blocks.  I don't think
that's true, and things would work correctly if the slave->backup
assignment happened first (or last).

	Assuming I'm correct, could you move the assignment so it's not
in the middle?  If, however, it does need to be in the middle, that
deserves a comment explaining why.

	-J

>+
> 	if (notify) {
> 		bond_lower_state_changed(slave);
> 		bond_queue_slave_event(slave);
>-- =

>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

