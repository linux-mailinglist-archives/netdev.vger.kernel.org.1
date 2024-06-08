Return-Path: <netdev+bounces-101982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B507D900F24
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 03:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A6EB2379F
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487A8465;
	Sat,  8 Jun 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com.au header.i=@fastmail.com.au header.b="hdTzjzyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WybPuoCO"
X-Original-To: netdev@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8656FC6;
	Sat,  8 Jun 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717811269; cv=none; b=hGiHJU6cwTXveVgaltl4zez+0nF4EMJ/YgIDEALNLLd3Szt5H81+7MfG7eVYpghZpHD3z9ZmSG/WvhC7QSQi86zs7wSZxVrYzCSoxeHQJs48Yh0I9dyBIVMNq8lvMmH7WcSINmPejFanO3+a0sVvNrusTEMeRfXAFQuN0HJTnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717811269; c=relaxed/simple;
	bh=3hAKft0IpTlaATaf6B4KLpVNg79DZ5h1pzjABHPAuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeKIaml8OOHw+iWi1mv2g8CJKlpfg4cBNpia8JlXHN6iJ/jKNzkoxG8GEH/FfJxJge1G7dnE9oOTlXUy2OgbwK1FAUvqufldrZG3B3qxydz3Cm8Kwza3HrzQwPB+ZObGNswBB3anK6oeXCpG153M0ivBOCPpA2f1Dkti5za6nkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnthomson.fastmail.com.au; spf=pass smtp.mailfrom=johnthomson.fastmail.com.au; dkim=pass (2048-bit key) header.d=fastmail.com.au header.i=@fastmail.com.au header.b=hdTzjzyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WybPuoCO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnthomson.fastmail.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnthomson.fastmail.com.au
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75A13138019E;
	Fri,  7 Jun 2024 21:47:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Jun 2024 21:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1717811266; x=1717897666; bh=wVtkKE02aG
	BtUM4XVJj9v4PooiUi8hPGO3tB8GgDw7E=; b=hdTzjzycTW0W5sG4FreOYRTMaF
	9r3BiaiIiAZoTUa/iDwQlVvTtw2mF5dVk+7uiS+OAoRRWf87LcPi5PER4f/p9l7o
	+ic2UISgdAfXGoN1veCJfWCvcmAQN41DHRxrAgieont0uIT3Po/bawxhqHw37Rqi
	ENe//xnQMZb7B6jlq9/vFJ9gRtbS3iSMtyWk8w0oIAAAr9aQh4L/ztEM1spFQAU4
	1bXrsmnIPetZdE5/IAdb8kvsV9FtiACZ4gCnAvgKM4iwMvrdqrRblMYa97OhOLTo
	WIv7GylXyQFED8GNk3I2vFZ1FTqeukVTSaTfcBDIM/TAu6joXYTyWjXGqJ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717811266; x=1717897666; bh=wVtkKE02aGBtUM4XVJj9v4PooiUi
	8hPGO3tB8GgDw7E=; b=WybPuoCOmiH6K2dnfgpCvA4vI8Z9IkaN4tqIcY5di8Pm
	RGORf+bfZpi2Q2eopd7ltknL5w28c5A9t/jt2Tczsn3+npD9zpZ4l1AKuQSR81Yz
	y4+bj6SNKYLn669v9J5GPrnXph20Lie5/YRezb0CKW19o4ApzjaLWz5Mt0nNHcbN
	kSTTtQLzH0YUhH3Q8MEOZ2pgo1cHHh/WLp7NBt0hjBAw6dgHvFo65EG8DYaiRYiF
	6I7gTNp82xu6d0qyoI5umfIOy2tZQkwKsH3Hx+wQUdiP9TE4JjYqwn5KvRqPGWb+
	XKGB378X6bx6mVhVh9vQuu2+05eQqLm/HD1MyAYYug==
X-ME-Sender: <xms:QbhjZjTTm8Pg0y9AlgwqVYUUdKbMi9sipOYi7Y2youjo3a3bhbDZfQ>
    <xme:QbhjZkzB_1z1vF0T9ty83Bl-eEGdIAlnycxOE-5RjVcNiI_JwVo4s3HU6wx9JRHZ-
    YTTFaaKkPjARYG8kg>
X-ME-Received: <xmr:QbhjZo3t_3GU1qZmgJ__-j7mXL3lca2uCGxcHiWHkXkUNU6F5gzqsmaeRu9v6CsYHl12FFynEPnAqXk7W0KGz5NpZwxdeBSroBGSeQWbXDOXxRdmhAgwSXp-Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflohhhnhcuvfhhohhmshhonhcuoehgihhtsehjohhhnhhthhho
    mhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeefvd
    ekveeggfekgeehvdelteeiffehgfeihfelgfdvkeefvdetkeeuueevleehveenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhl
    rdgtohhmrdgruh
X-ME-Proxy: <xmx:QbhjZjA_RAISdoskpNW2efmv-pAul3XpVgE29J_Kkb7LmOXPmxCNfA>
    <xmx:QbhjZsjLV2RbFUka9q8VxReyviuwlp_7Z4koRLNU_JxpI6G66j6RoQ>
    <xmx:QbhjZnoQvmcO9cYfO7ZYhyRaN6jKbkmbIJ7qDuCBoeJa6xwyKY9mXA>
    <xmx:QbhjZngx0F34ySU9YZ-12hAFsB5jaR6t2A5Y44QP61EdzBjF4cKZRw>
    <xmx:QrhjZoyLNwbENlmanbnJaMrTKai9grgA6-kNv2CZ8DESQ3u7iFIorhnx>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 21:47:40 -0400 (EDT)
From: John Thomson <git@johnthomson.fastmail.com.au>
To: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Thomson <git@johnthomson.fastmail.com.au>
Subject: [RFC net-next] net: dsa: generate port ifname if exists or invalid
Date: Sat,  8 Jun 2024 11:47:24 +1000
Message-ID: <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where a DSA port (via DTB label) had an interface name
that collided with an existing netdev name, register_netdevice failed
with -EEXIST, and the port was not usable. While this did correctly
identify a configuration error in DTB, rather bringup the port with an
enumerated interface name, which can be renamed later from userspace
where required.
While this does change the implicit expectation that it is an error if
the DSA port cannot use it's predictable (DTS label) name, there is no
functionality to stop netdev from allocating one of these (perhaps
poorly selected) DSA port names to a non-DSA device before the DSA
device can.

While at it, also test that the port name is a valid interface name,
before doing the work to setup the device, and use an enumerated name
otherwise.

This was seen recently (for the EdgeRouter X device) in OpenWrt when a
downstream hack [1] was removed, which had used DTS label for ifname
in an ethernet device driver, in favour of renaming ifnames in userspace.
At the time the device was added to OpenWrt, it only used one network
device driver interface, plus the switch ports, so eth1 (matching physical
labelling) was used as a switch port label. Since, this device has
been adjusted to use phy muxing, exposing a switch port instead as the
second network device, so at bringup for this DSA port, eth1
(which is later renamed in userspace) exists, and the eth1 labelled
DSA port cannot be used.

[1]: https://lore.kernel.org/netdev/20210419154659.44096-3-ilya.lipnitskiy@gmail.com/

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---

RFC:
Not a full solution.

Not sure if supported, I cannot see any users in tree DTS,
but I guess I would need to skip these checks (and should mark as
NEM_NAME_ENUM) if port->name contains '%'.

name is also used in alloc_netdev_mqs, and I have not worked out if any
of the functionality between alloc_netdev_mqs and the register_netdevice
uses name, so I added these test early, but believe without a rntl lock,
a colliding name could still be allocated to another device between this
introduced test, and where this device does lock and register_netdevice
near the end of this function.
To deal with this looks to require moving the rntl_lock before
these tests, which would lock around significantly more.

As an alternative, could we possibly always register an enumerated name,
then (if name valid) dev_change_name (not exported), while still within
the lock after register_netdevice?

Or could we introduce a parameter or switch-level DTS property that forces
DSA to ignore port labels, so that all network devices names can be
managed from userspace (using the existing port DSA label as intended name,
as this still seems the best place to define device labels, even if the
driver does not use this label)?

Cheers
---
 net/dsa/user.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 867c5fe9a4da..347d2d8eb219 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2684,6 +2684,7 @@ int dsa_user_create(struct dsa_port *port)
 	struct dsa_switch *ds = port->ds;
 	struct net_device *user_dev;
 	struct dsa_user_priv *p;
+	bool valid_name = false;
 	const char *name;
 	int assign_type;
 	int ret;
@@ -2692,6 +2693,20 @@ int dsa_user_create(struct dsa_port *port)
 		ds->num_tx_queues = 1;
 
 	if (port->name) {
+		if (!netdev_name_in_use(&init_net, port->name))
+			valid_name = true;
+		else
+			netdev_warn(conduit, "port %d set name: %s: already in use\n",
+				    port->index, port->name);
+		if (dev_valid_name(port->name)) {
+			valid_name &= true;
+		} else {
+			valid_name = false;
+			netdev_warn(conduit, "port %d set name: %s: is invalid\n",
+				    port->index, port->name);
+		}
+	}
+	if (valid_name) {
 		name = port->name;
 		assign_type = NET_NAME_PREDICTABLE;
 	} else {
-- 
2.45.1


