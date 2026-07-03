Return-Path: <netdev+bounces-304426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 60kUHuFpR2qzXwAAu9opvQ
	(envelope-from <netdev+bounces-304426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1C6FFBDE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:50:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=s+2UcFyI;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304426-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304426-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FD70309832F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD736F434;
	Fri,  3 Jul 2026 07:47:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299436E468;
	Fri,  3 Jul 2026 07:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064828; cv=none; b=hC/gzuVWMZs+iZ+HE66UdTM6kfu/2DWA67L08FuLywQIJqGjFKE8UdFwk9KykPGpiScX38Pv/2jsfNUw45Ax3IIgsvVOmaDzoVs/g1C+U8Rg/j+5vfAZTEHv8fh8VtE7wFsPK/x1eERAEIV8T8w+MUussqmosVK5Ut1VmceDozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064828; c=relaxed/simple;
	bh=CyUivMR8Llv06EhRIKDpn3Fe3pNlH0ueFS4t4ZoiLf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlilFj+zRax1UtrcaN7AAw187HMndiqoBdoutYzX0ScRo5bR6eqsfkMv/GI7QEYEBrcU1bLzXg/9nZsZTaXyHuUfAbhuf0xj332nOb05no9Jt+NrQaeXZh/rvFJ6LCbOb4n04QoeZYP8hH0J8QYL8Btv/o+ufbrqE5JISfOsrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=s+2UcFyI; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 9DC1B60C04;
	Fri,  3 Jul 2026 03:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064825; bh=bJMr/qHc7ymioqh7BOmXgJGPVRBK1nh6eJFKKNpkeIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s+2UcFyIzPmJKj4pUmtz/nKV8pDbVdtH96IK/ia8uPnCsufaQrPWvzS9CyAC4oEna
	 5DqfltRdxhRc95vwpHviZ79zrKx/g8jH54zgsAEmhmBCSHvMSCiPYjmPC+zKjXo/WX
	 CSvxtTz1GIba1regAKBsToGkNb1nvWCyF4tkI0gOI344p+V4mBbMWzNf3tpGddXgqJ
	 s1UWBZaWpGCueYj/7kFC04cwMu2xsx49FHcWQupDBJAcvwWPWaFvDki7Hq3a/ckPVC
	 bWcsaaB+Whn9RsNvf+z8P3Y1ljno20WX9QnOXYDOVPMcWScA/Q11vdNS/7Nk2AjfKT
	 EaZSc/EqzDPRA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:39 +1000
Subject: [PATCH net-next 05/17] net: dsa: mv88e6xxx: Add conduit state
 change handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-5-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=4698;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=Dq6jpBuZlPa/OHY/Kpn4yyE39BjKNkXf/FngrDh8eUc=;
 b=XimQFpWDaVAfYNi3CEWZeRQ1h+FUNfWLnNig4GivUKTFOoremhmYJUPJ7VSYFoI6zrkaW8lqM
 1bGXmarK4NTARvVww4RikrRkmlf1NubL9B+lhhFtpc+uNx/qApSlJxH
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304426-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7E1C6FFBDE

From: Andrew Lunn <andrew@lunn.ch>

When the conduit interface comes up, try to enable the RMU.  Failing to
enable the remote management unit is not fatal, not all chips support
it, and some boards have chips which do support RMU, but with wrong
port is connected to the CPU.

When the conduit interface goes down, disable the RMU.

Keep track of the conduit interface, so that RMU frames can be sent to
it.

Co-developed: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/Makefile |  1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |  2 ++
 drivers/net/dsa/mv88e6xxx/chip.h   |  3 +++
 drivers/net/dsa/mv88e6xxx/rmu.c    | 50 ++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h    | 15 ++++++++++++
 5 files changed, 71 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index b0b08c6f159c6..1f3571061a550 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -17,6 +17,7 @@ mv88e6xxx-objs += phy.o
 mv88e6xxx-objs += port.o
 mv88e6xxx-objs += port_hidden.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += ptp.o
+mv88e6xxx-objs += rmu.o
 mv88e6xxx-objs += serdes.o
 mv88e6xxx-objs += smi.o
 mv88e6xxx-objs += switchdev.o
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index dbfbdb982fc00..d6c6834cca2cb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -41,6 +41,7 @@
 #include "phy.h"
 #include "port.h"
 #include "ptp.h"
+#include "rmu.h"
 #include "serdes.h"
 #include "smi.h"
 #include "tcam.h"
@@ -7265,6 +7266,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_change	= mv88e6xxx_crosschip_lag_change,
 	.crosschip_lag_join	= mv88e6xxx_crosschip_lag_join,
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
+	.conduit_state_change	= mv88e6xxx_rmu_conduit_state_change,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 12fdcb63252eb..76958b588a908 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -457,6 +457,9 @@ struct mv88e6xxx_chip {
 
 	/* Global2 scratch register config data3 */
 	u8 g2_scratch_config3;
+
+	/* Remote Management Unit state. */
+	struct net_device *rmu_conduit;
 };
 
 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
new file mode 100644
index 0000000000000..64e93e2eaf550
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Marvell 88E6xxx Switch Remote Management Unit Support
+ *
+ * Copyright (c) 2022 Mattias Forsblad <mattias.forsblad@gmail.com>
+ *
+ */
+
+#include <net/dsa.h>
+#include "chip.h"
+#include "global1.h"
+#include "rmu.h"
+
+void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
+					const struct net_device *conduit,
+					bool operational)
+{
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port;
+	int ret;
+
+	port = dsa_towards_port(ds, cpu_dp->ds->index, cpu_dp->index);
+
+	mv88e6xxx_reg_lock(chip);
+
+	if (operational && chip->info->ops->rmu_enable) {
+		ret = chip->info->ops->rmu_enable(chip, port);
+		if (ret == -EOPNOTSUPP) {
+			dev_info(chip->dev, "RMU: not usable on this board");
+			goto out;
+		} else if (ret < 0) {
+			dev_err(chip->dev, "RMU: unable to enable on port %d %pe",
+				port, ERR_PTR(ret));
+			goto out;
+		}
+
+		WRITE_ONCE(chip->rmu_conduit, (struct net_device *)conduit);
+
+		dev_dbg(chip->dev, "RMU: Enabled on port %d", port);
+	} else {
+		if (chip->info->ops->rmu_disable)
+			chip->info->ops->rmu_disable(chip);
+
+		WRITE_ONCE(chip->rmu_conduit, NULL);
+	}
+
+out:
+	mv88e6xxx_reg_unlock(chip);
+}
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
new file mode 100644
index 0000000000000..71c4fc1d4113f
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Marvell 88E6xxx Switch Remote Management Unit Support
+ *
+ * Copyright (c) 2022 Mattias Forsblad <mattias.forsblad@gmail.com>
+ *
+ */
+
+#ifndef _MV88E6XXX_RMU_H_
+#define _MV88E6XXX_RMU_H_
+
+void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
+					const struct net_device *conduit,
+					bool operational);
+#endif /* _MV88E6XXX_RMU_H_ */

-- 
2.43.0


