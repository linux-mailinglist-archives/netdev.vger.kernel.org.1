Return-Path: <netdev+bounces-185784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE5A9BB74
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B322E1BA4ECF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BF28E605;
	Thu, 24 Apr 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="pSAz60SO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ldCu1f0G"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF427FD46;
	Thu, 24 Apr 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538300; cv=none; b=bR489wM6O6Vatpr9ptSDeqnv8rzM0AStwXs4/TeOgwLY9+6rrqAbhgdIsB0DNE0czUOadtUk1/rY4VwmuohyD6EG0tcuy1pw9MhlLPAHl2xTwhB/joA8WgP2uAmu/rTqmK1NUMQvZSpjQ+eId634Xl+euzKy3homWwtm8XQ2cDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538300; c=relaxed/simple;
	bh=lun9oItj3a6mtNiZ2QrHlZ/USbxg+pQvtAnM5YQEJEg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=B+rLQDPoVUDpWf6UqE1OGRderQS8GTqflcyNacx0gTikhEZ+02qbYEx9+RjwumCF+pPsIT20STvPaEipxM4sF3U7vXD17blneKNSXKoiooKkZU0Oub95ySU7jiP5yV04rt9UgGcsCXiX/8rL38RTFRaCMPGCe25pOdM2gTNTkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=pSAz60SO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ldCu1f0G; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 24C8111401D4;
	Thu, 24 Apr 2025 19:44:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Apr 2025 19:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1745538294; x=1745624694; bh=o9S0MIYd6tAo0RWuuqQx3
	og4VdbgUeUIGxHVINE1dCg=; b=pSAz60SOOJuuVLuxdr7yb2lzD0l0sPjVIgNfX
	q5TtnpwAu1IkRglvW0h0SNppRSwq/ONY/E+JwjZ7LVFzcvE/ObauGxPoH5N7IGm4
	XHM1k+IkY/Vl5cmT2/XZQSdCPkgx79Bb730EguoY0oDA7wQYSFTAQ9a81wwnNcTv
	3f8ZQOEdLKdYLEJCqtj63BMXmpMXoebBvQMq8ULcDLhIfqy7QcGmsQXE1HMjdupB
	+vCv/QsU1qayEBUjG4lMPS345wsJnpvnnYX4Pd4wVv2ClU8COhA+c0ra24M8Hmx9
	YWRrLfNXWeKiAYJUSzF3hQiEuoT0SF0pvJ4rFF1PzNXNDLbJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745538294; x=1745624694; bh=o9S0MIYd6tAo0RWuuqQx3og4VdbgUeUIGxH
	VINE1dCg=; b=ldCu1f0GLfRQ+oizklWLsEZlOfv0NCKTVhXuF5mtujF5FyGvoBW
	FK0mxtNTAm1VDpIZgrOFQc5kpleXrth53r1VnVAJt0CIsezIXEKdRFZtHb211ul2
	A+EbGzo2KNoY/XnCygW7JT1BM7MA+PnOizXmxREtfy4KBi56qSMh27Fy79YChkgp
	AM0ABSkPX4djULxz7N2sU0d8TTrT9Kxo3dZzmqEqPutKiIMrXdJpbq4WVPQuVEs7
	HW/6EtcXI1gCSDj/+4LOgCKV9z1dWqAsFN/Ezp4+xF8tr5vybkU3LBncp/Fda1am
	bwMuIjvYFOPu0cNnGEs9taDVhAhamSoBasQ==
X-ME-Sender: <xms:9swKaB0LPIaR7dnnhmKIEirbeCXJWsXCXZu1UkZsly8r0KpQiTjwcQ>
    <xme:9swKaIHlPsadw9mWCQ8SN8XWXKJHq74ISfP-oKoNGSpucXAIlL5bOhSlXkWy-5gKL
    Sbp7gwlEYeQ1-UuYxs>
X-ME-Received: <xmr:9swKaB72RVMcMERQ_zRQGDaqatS1VDY7tmcsvgBy4FhHFDS5LLUjoZMzm2HNVJoCzrmYGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9swKaO0qdHztAVpXS07MWlk0XaV0l6g-E6CySBWR5cMG5aHt3GKPcw>
    <xmx:9swKaEH5xrDSyjmAK7DMl7HDGJF8SFUYIgDaDg8P2Nj2WRt7ix6lmw>
    <xmx:9swKaP8ie6-zlLMX9hV-_WQ6_D8ECtrRP85QlLU6XSMxvBVn7y1Yyg>
    <xmx:9swKaBmSkDAe-554tXvxDqVYfWvAnMH8TnMmxscIzqGcDC4VqPiZQA>
    <xmx:9swKaJQ_zHmdjLHBZsxgeXowMqBhJ9yojvzZtwb_9OcJVunFzd3FoRcC>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:44:53 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id D0C839FD42; Thu, 24 Apr 2025 16:44:52 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CFA3A9FC3F;
	Thu, 24 Apr 2025 16:44:52 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net] bonding: assign random address if device address is
 same as bond
In-reply-to: <20250424042238.618289-1-liuhangbin@gmail.com>
References: <20250424042238.618289-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 24 Apr 2025 04:22:38 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <587558.1745538292.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2025 16:44:52 -0700
Message-ID: <587559.1745538292@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>This change addresses a MAC address conflict issue in failover scenarios,
>similar to the problem described in commit a951bc1e6ba5 ("bonding: correc=
t
>the MAC address for 'follow' fail_over_mac policy").
>
>In fail_over_mac=3Dfollow mode, the bonding driver expects the formerly a=
ctive
>slave to swap MAC addresses with the newly active slave during failover.
>However, under certain conditions, two slaves may end up with the same MA=
C
>address, which breaks this policy:
>
>1) ip link set eth0 master bond0
>   -> bond0 adopts eth0's MAC address (MAC0).
>
>2) ip link set eth1 master bond0
>   -> eth1 is added as a backup with its own MAC (MAC1).
>
>3) ip link set eth0 nomaster
>   -> eth0 is released and restores its MAC (MAC0).
>   -> eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
>
>4) ip link set eth0 master bond0
>   -> eth0 is re-added to bond0, now both eth0 and eth1 have MAC0.
>
>This results in a MAC address conflict and violates the expected behavior
>of the failover policy.
>
>To fix this, we assign a random MAC address to any newly added slave if
>its current MAC address matches that of the bond. The original (permanent=
)
>MAC address is saved and will be restored when the device is released
>from the bond.
>
>This ensures that each slave has a unique MAC address during failover
>transitions, preserving the integrity of the fail_over_mac=3Dfollow polic=
y.
>
>Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

	The code flow is a little clunky in the "if (situation one) else
if (situation two) else goto skip_mac_set" bit, but I don't really have
a better suggestion that isn't clunky in some other way.

	This implementation does keep the already complicated failover
logic from becoming more complicated for this corner case.

	-J

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
>v3: set random MAC address for the new added link (Jakub Kicinski)
>    change the MAC address during enslave, not failover (Jay Vosburgh)
>v2: use memcmp directly instead of adding a redundant helper (Jakub Kicin=
ski)
>---
> drivers/net/bonding/bond_main.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 8ea183da8d53..b91ed8eb7eb7 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2118,15 +2118,26 @@ int bond_enslave(struct net_device *bond_dev, str=
uct net_device *slave_dev,
> 		 * set the master's mac address to that of the first slave
> 		 */
> 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
>-		ss.ss_family =3D slave_dev->type;
>-		res =3D dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
>-					  extack);
>-		if (res) {
>-			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", =
res);
>-			goto err_restore_mtu;
>-		}
>+	} else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
>+		   BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>+		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len)=
 =3D=3D 0) {
>+		/* Set slave to random address to avoid duplicate mac
>+		 * address in later fail over.
>+		 */
>+		eth_random_addr(ss.__data);
>+	} else {
>+		goto skip_mac_set;
> 	}
> =

>+	ss.ss_family =3D slave_dev->type;
>+	res =3D dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, extack);
>+	if (res) {
>+		slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", r=
es);
>+		goto err_restore_mtu;
>+	}
>+
>+skip_mac_set:
>+
> 	/* set no_addrconf flag before open to prevent IPv6 addrconf */
> 	slave_dev->priv_flags |=3D IFF_NO_ADDRCONF;
> =

>-- =

>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

