Return-Path: <netdev+bounces-85458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F89ACCE
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04741F21BD3
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE294E1C8;
	Sat,  6 Apr 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UUNT1Gvz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7E4C610
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434446; cv=none; b=GFKQLpQgTIskGhQN+NqAIkVyxkQC4S7dlk6qjH7kIDe9KYgAMdhBuDZdGXLKcpXnboJui8J4BRaKiCOBh4M0mf1dbPPvE6VqqiHS7s18t0ZfiTV+w5kf03TQ7cTzyMtjwxeUI4t5LYEMj6ycAl5aEainm9rULvNgxkoMKLy7JQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434446; c=relaxed/simple;
	bh=bE8D8/N3rAVLAFyNDOg7tStifl1F1eidOd4mG2J8mIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpyLkAVIfBuH4bzArAkPFWP4l9JzPS9zGB6OHUUvg2cMb61LdD05oiIu4JOxZNeKG5TW273gZd4TVwAD2iM7isoee9RdbqHZBFyYfDtQd9hYJp5yxSA03b7yWgIOpgWLHqBvVrFmI0DIFojjsLDLD/9vb1U6kymQKmAU/6DBPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UUNT1Gvz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZzOptbSM+ThCI68o1UXhs7ybp5SEQu4+mvoh3ouFUcA=; b=UU
	NT1GvzoUUT53adKOrLPXPBCYvR7z2/MMYhw5Q7bPDWlsdXwH7WucHzOAi5NLeKknImep7MfN+YBno
	4zo6GC0Um/LgGcy1xquuxelMt8eO1HT58GgVCourTRh7ShHQRLJrbUW4G/zPDNclaZmygiq6J5doJ
	arcnXawGYYhTBUk=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQM-00COA7-5o; Sat, 06 Apr 2024 22:14:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:29 -0500
Subject: [PATCH net-next v4 2/8] net: dsa: break out port setup and
 teardown code per port type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-2-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3791; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=m4R+FzkPdG0f2iBbW8//G6Yqgb/4rK41MXzEqU3faJc=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEaz/oWeYWZ7x19cv6BBmUR6zfoYns9XKlGdRj
 vTAt/lUxbyJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGs/wAKCRDmvw3LpmlM
 hJkSD/91j7Saqkbix9xbNxCp94OgeaaIL0L+DJFIRBzLkwheDHXViSFNNQJ9o+zuYDYVZPyDY0z
 Ra/VyVuZ2kFm3K98cjERcuMdoMZCnMWuXww7knZH0E3um2pyUKAPvCwzO1BOc6ZxiWFFFJcvFbo
 A5qLGTDcN3IsolKQozU8Fs81sistglgAQ8RGH9OJhr7GpKM3QFX0VcLXDDNSUsOoelaT3FQUEBe
 dtA2UNehudN2/N9Ka2P06I/PnlXbLurRDHT+oiQL1brrmN4ISXYtKq/o2fZEOhouQlKw38bzlmz
 aexPPxiHwsTUL9scTaVlk1kKpFpKwTiRMwQ+N9HaiR6US0WGkoMhPCg6EioAI6KWW38CQgF4ATs
 R/jMTllqZhmwTnLmtT2bnDA4B7sf3MGtLgy7E5HI4tslOzja9/gYRqHl+VZCh63nfXd/Sj3DRRS
 1KVDDH0yxeCDo8clWW3SwWUDhSV7cIZgCx6olzIEaOsllt1X//Kopv1c6RjbM16URb6TIhXIcq3
 GNxwUW4/IbEqh8v/jGxiL+xDXrthlE4WsuSdi8VeSqPRZRxF2uk7yDsvwN5Vl33Trh/Gc3GTMF7
 B/bfR/FESAAu0paCe3mUSg8PdT5NFfJ4Nz7xPPE1NWnI7kG/fvBlQ+ZELDRa4LDA8civXQGu43f
 zwXZoKHBu3A5ThA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It is very hard to make changes to the control flow of dsa_port_setup(),
and this is because the different port types need a different setup
procedure.

By breaking these out into separate functions, it becomes clearer what
needs what, and how the teardown should look like.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/dsa.c | 102 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 35 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 64369fa5fd07..5d65da9a1971 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -460,12 +460,69 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
 			dp->cpu_dp = NULL;
 }
 
-static int dsa_port_setup(struct dsa_port *dp)
+static int dsa_unused_port_setup(struct dsa_port *dp)
+{
+	dsa_port_disable(dp);
+
+	return 0;
+}
+
+static void dsa_unused_port_teardown(struct dsa_port *dp)
+{
+}
+
+static int dsa_shared_port_setup(struct dsa_port *dp)
 {
-	bool dsa_port_link_registered = false;
 	struct dsa_switch *ds = dp->ds;
-	bool dsa_port_enabled = false;
-	int err = 0;
+	bool link_registered = false;
+	int err;
+
+	if (dp->dn) {
+		err = dsa_shared_port_link_register_of(dp);
+		if (err)
+			return err;
+
+		link_registered = true;
+	} else {
+		dev_warn(ds->dev,
+			 "skipping link registration for %s port %d\n",
+			 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
+			 dp->index);
+	}
+
+	err = dsa_port_enable(dp, NULL);
+	if (err && link_registered)
+		dsa_shared_port_link_unregister_of(dp);
+
+	return err;
+}
+
+static void dsa_shared_port_teardown(struct dsa_port *dp)
+{
+	dsa_port_disable(dp);
+	if (dp->dn)
+		dsa_shared_port_link_unregister_of(dp);
+}
+
+static int dsa_user_port_setup(struct dsa_port *dp)
+{
+	of_get_mac_address(dp->dn, dp->mac);
+
+	return dsa_user_create(dp);
+}
+
+static void dsa_user_port_teardown(struct dsa_port *dp)
+{
+	if (!dp->user)
+		return;
+
+	dsa_user_destroy(dp->user);
+	dp->user = NULL;
+}
+
+static int dsa_port_setup(struct dsa_port *dp)
+{
+	int err;
 
 	if (dp->setup)
 		return 0;
@@ -476,38 +533,17 @@ static int dsa_port_setup(struct dsa_port *dp)
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
-		dsa_port_disable(dp);
+		err = dsa_unused_port_setup(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
-		if (dp->dn) {
-			err = dsa_shared_port_link_register_of(dp);
-			if (err)
-				break;
-			dsa_port_link_registered = true;
-		} else {
-			dev_warn(ds->dev,
-				 "skipping link registration for %s port %d\n",
-				 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
-				 dp->index);
-		}
-
-		err = dsa_port_enable(dp, NULL);
-		if (err)
-			break;
-		dsa_port_enabled = true;
-
+		err = dsa_shared_port_setup(dp);
 		break;
 	case DSA_PORT_TYPE_USER:
-		of_get_mac_address(dp->dn, dp->mac);
-		err = dsa_user_create(dp);
+		err = dsa_user_port_setup(dp);
 		break;
 	}
 
-	if (err && dsa_port_enabled)
-		dsa_port_disable(dp);
-	if (err && dsa_port_link_registered)
-		dsa_shared_port_link_unregister_of(dp);
 	if (err) {
 		dsa_port_devlink_teardown(dp);
 		return err;
@@ -525,18 +561,14 @@ static void dsa_port_teardown(struct dsa_port *dp)
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
+		dsa_unused_port_teardown(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
 	case DSA_PORT_TYPE_DSA:
-		dsa_port_disable(dp);
-		if (dp->dn)
-			dsa_shared_port_link_unregister_of(dp);
+		dsa_shared_port_teardown(dp);
 		break;
 	case DSA_PORT_TYPE_USER:
-		if (dp->user) {
-			dsa_user_destroy(dp->user);
-			dp->user = NULL;
-		}
+		dsa_user_port_teardown(dp);
 		break;
 	}
 

-- 
2.43.0


