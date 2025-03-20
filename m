Return-Path: <netdev+bounces-176575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C9A6AE67
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454B14860FB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2F227E99;
	Thu, 20 Mar 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="aT616jAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJzM14bF"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960B1E8339;
	Thu, 20 Mar 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498001; cv=none; b=b+lAKSU7Hk0KHKxzq6vay6qc661HQnXPKbKDY9BSs/Iu0OABt6ZxBT1inbS8474toCT/iH0MzE2+cQtfOMc5Aqj9ZRJ3AaSq/z3XlLU9tstZvCjquEeAA2HlRHCrvKLcuULuMKuGDA6X1OFAP1X4aQ508sct5s2J1crfJVaOraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498001; c=relaxed/simple;
	bh=w/1BLVeeR5mW230WGJrNA+NFTbyOHjTi05Pv0pOAJ1g=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=YVyff+D5a4wokl4Co7lNyaIcIHClvwzbI9hIsD77oIjg6cDGkMYvESWRcmq8DryJAarzibHn9BVd+0ZDiFFNltRZUZUUn5hoT9t/izgCbBl2tJSSlT2biCSecM0nSt7Ys7NTwc/eHVE/VgZHU/wNgY5qUKVh2tZQ3XaXVACLsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=aT616jAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJzM14bF; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 29A0F11400CA;
	Thu, 20 Mar 2025 15:13:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Mar 2025 15:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1742497996; x=1742584396; bh=IR0OXTd3Mv/VRatqgXGdaWOrIeWV/sLQ
	QJTuLfYjzLw=; b=aT616jAPMrlWAxnfKkedGpJkDfJb1DxJMfWphu5UHCC5PfvM
	pqB7cqm79krHFn+I39PTDENyTpkOfTOfG84/yPSTV3B9TnZxoX/hfAGDGt5JrdYD
	GbqOvGJKx6PM4WLuFEnrR2l7AV6wpOovOZa3HpjoiEE4ljmaBs3orjzAEsXXg4DU
	PHW0pMg+/n1WXMdY2eS7QPG+fHj1GOGzw3tTjjK36PmO7P4VGNMFcxnqlHHH3Q/v
	S1gVgNlBvrP3P5V4Tzp0iirSXaRsIwwWHlVBklmDt/rfPA5W1aXzU842CipwHEBO
	xAjaYSPLX4RFryZt08y3boX83gEHHGOZDKhKOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742497996; x=
	1742584396; bh=IR0OXTd3Mv/VRatqgXGdaWOrIeWV/sLQQJTuLfYjzLw=; b=b
	JzM14bF/3TePJ/3oTX5HMRKxuXa0o9RGUv1jh6o6cKkLWWqFpDHajoH0LprAtGqx
	ciexdFnN+Y9qG8pN5gZTIOao/FuaRLa+1cfoBCiIsJnvvg8x7aCaQwRjtr65r+Wh
	fFpI6+VlpUWjEQHMNOxqkqQUhrJGs8q5zT5XHu0F/LHPkQQ7lQqlbnb92Moo5Cl0
	m1QCF+n0AX28xhvttONLiJWZ+bGsWCr6R9CuUW31ziot0Cjgp0raz7j9eUjayI5l
	fMRXKXH60fFcF9H63Wbl0d2wO3j8UecllIbrrBd5IEtWfyO7iKrev7kN5ZG3CvYw
	XrTa7VuSjnfoGDTR5f54w==
X-ME-Sender: <xms:y2jcZ_5lCRQitctDFsBtHo0Noz8NQxgB8UgA_E4aV9UEvjAujS471Q>
    <xme:y2jcZ069wItkakjpBn_iDngyEnMPX4rp1wDBwo6aoMu_SwmJYN-j_3uPkEu8Eo-ga
    Nm0IiYV1IVN9XDsZxo>
X-ME-Received: <xmr:y2jcZ2cGbcrWm4bWNNMAE4KRk3Ky1Cc1VTm_63gsSiaQN_ZAbfOlN2rUWR4VwKg6iQwqhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepgeefgffhgffhhfejgfevkefhueekvefftefh
    gfdtuddtfeffueehleegleeiuefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthho
    pegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhirghlihesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:y2jcZwKwA6JMSeVR8VAyAt4_DPAqXZbTvcm0Kaz73D26vRJcEEYPNA>
    <xmx:y2jcZzKBz4VrZrhhZ_0CNrCJiwLHkcib3ZmL0lci2NWHeliMEuPzyw>
    <xmx:y2jcZ5yKa147PyFblOVwWW_70K6ypQ7COYvOIxne4Ii8xBnLZEqk2w>
    <xmx:y2jcZ_K9v1SsvGa8r4PyF5ibGRU9NXlPJcG5PPQYmzlMyTlZUm9qTQ>
    <xmx:zGjcZ9Aef3wNq5BRxRpeSg1IhKx44YDjc0Bfo8ekGzANUm1-HY0CuqR_>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 15:13:15 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 344A79FC4A; Thu, 20 Mar 2025 12:13:14 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 318109FC46;
	Thu, 20 Mar 2025 12:13:14 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if device address is same
In-reply-to: <20250319080947.2001-1-liuhangbin@gmail.com>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 19 Mar 2025 08:09:47 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Mar 2025 12:13:14 -0700
Message-ID: <2696885.1742497994@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
>fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
>active slave to swap MAC addresses with the newly active slave during
>failover. However, the slave's MAC address can be same under certain
>conditions:
>
>1) ip link set eth0 master bond0
>   bond0 adopts eth0's MAC address (MAC0).
>
>1) ip link set eth1 master bond0
>   eth1 is added as a backup with its own MAC (MAC1).
>
>3) ip link set eth0 nomaster
>   eth0 is released and restores its MAC (MAC0).
>   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
>
>4) ip link set eth0 master bond0
>   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
>   breaking the follow policy.

	Are all of these steps necessary, or does the issue happen if a
new interface (not previously part of the bond) is added to the bond
with its MAC set to whatever the bond's MAC is?

	Did this come up in practise somewhere, or through inspection /
testing?  I'm curious as I'd expect usage of this option today would be
rare, as I hope that current hardware wouldn't have the "MAC assigned to
multiple ports" issues that led to the "follow" logic.  If memory
serves, the issue arose originally in the ehea network device (on IBM
POWER), which I believe is out of production now for some years.

>To resolve this issue, we need to swap the new active slave=E2=80=99s perm=
anent
>MAC address with the old one. The new active slave then uses the old
>dev_addr, ensuring that it matches the bond address. After the fix:
>
>5) ip link set bond0 type bond active_slave eth0
>   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
>   Swap new active eth0's permanent MAC (MAC0) to eth1.
>   MAC addresses remain unchanged.
>
>6) ip link set bond0 type bond active_slave eth1
>   dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
>   Swap new active eth1's permanent MAC (MAC1) to eth0.
>   The MAC addresses are now correctly differentiated.

	An alternative solution could be to disallow adding a new
interface in "follow" mode if its MAC matches the active interface of
the bond.  If this patch is more of an correctness exercise rather than
something found out in the world impacting production deployments, it
might be better to keep the MAC swapping logic in the failover code
simpler.

	-J

>Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
>Reported-by: Liang Li <liali@redhat.com>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 9 +++++++--
> include/net/bonding.h           | 8 ++++++++
> 2 files changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index e45bba240cbc..9cc2348d4ee9 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *b=
ond,
> 			old_active =3D bond_get_old_active(bond, new_active);
>=20
> 		if (old_active) {
>-			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
>-					  new_active->dev->addr_len);
>+			if (bond_hw_addr_equal(old_active->dev->dev_addr, new_active->dev->dev=
_addr,
>+					       new_active->dev->addr_len))
>+				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
>+						  new_active->dev->addr_len);
>+			else
>+				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
>+						  new_active->dev->addr_len);
> 			bond_hw_addr_copy(ss.__data,
> 					  old_active->dev->dev_addr,
> 					  old_active->dev->addr_len);
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 8bb5f016969f..de965c24dde0 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -463,6 +463,14 @@ static inline void bond_hw_addr_copy(u8 *dst, const u=
8 *src, unsigned int len)
> 	memcpy(dst, src, len);
> }
>=20
>+static inline bool bond_hw_addr_equal(const u8 *dst, const u8 *src, unsig=
ned int len)
>+{
>+	if (len =3D=3D ETH_ALEN)
>+		return ether_addr_equal(dst, src);
>+	else
>+		return (memcmp(dst, src, len) =3D=3D 0);
>+}
>+
> #define BOND_PRI_RESELECT_ALWAYS	0
> #define BOND_PRI_RESELECT_BETTER	1
> #define BOND_PRI_RESELECT_FAILURE	2
>--=20
>2.46.0

---
	-Jay Vosburgh, jv@jvosburgh.net


