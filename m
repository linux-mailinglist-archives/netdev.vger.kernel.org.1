Return-Path: <netdev+bounces-304435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCliCwtrR2oBYAAAu9opvQ
	(envelope-from <netdev+bounces-304435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:55:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1A6FFC92
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=fPtfSKoj;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304435-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304435-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 453BD305DAD8
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7883769F7;
	Fri,  3 Jul 2026 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98762379C46;
	Fri,  3 Jul 2026 07:47:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064869; cv=none; b=XFEhi4n6nnx2UFT4uH6td4bvRoHqLG8StwD2zzvrbI1RqIZ//1XsB8Ej/CAH8m9h5iKkvPHSQ5SCewLNRktwyWAZQ+YeXRvYKsa3K8cyQCGtBDZAW9B9FN6/8JRSG0IbAwpHisrNk4QkwAzzX/g9uCTPyi0Apt6ksEsobGdxRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064869; c=relaxed/simple;
	bh=gg7sZKNi8J0S1o4A3nkTM7ucIjyFpFGgHNsSA9Lsy5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IprVnQqrMJkMmvPXAbTEnZgaxQVT7ge5CGTWcaFYQf+FGwcsbqQFCy4LdR1OMTN7YeNv3JmWY2ct6j6UhXhBrBMfHHAkDuBwrWZKGTpOEbRBckH3viQuFu0/7ccLolCXWb8jJCmmGxmPJevu2OyDdVypN1htljy3nxgthLHko1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=fPtfSKoj; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id A3B1360C0B;
	Fri,  3 Jul 2026 03:47:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064866; bh=/x+od2qSec+JKpC2fTu8kMQUpWLeQCnxIOFn4eM+m2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fPtfSKoj7msJit/dY3EGKseUY5sHXfMo8ZXg9eOXWQziEaAofcGgf6Q51KsmndQkG
	 9Zpw70ss+P4DGol4/P/FjrxJX/WOi0QDDBeD3rPdEdPbPbDjphVu+3uK4ojzdntyc8
	 FyiBL9J+RzGIb/AB2gIxKnf+rd+oPAeDI+jM12KSbDIggdG3sntoKxiORhdc5BpKhj
	 hljCi3OxQ3zT0s15m4W1+MmWK3rIekeFUtlmD8i2T87ALiZPmz8mpmEeTjZl4upz7a
	 lJhQ1N+lwRqStX0js2RO9EgKEtxa853V/20x34D/0P3pz7Crv1GNI0TYX/nuJ0Qy5g
	 IPuIrVtzTQxFA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:48 +1000
Subject: [PATCH net-next 14/17] net: dsa: mv88e6xxx: Time RMU operations
 and disable if slow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-14-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=5597;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=m0LK2G8pOTQuHUBc/C3G7JO2AS75KtAV9LnGPCVk2gU=;
 b=TSU0VltFan6mJZaeqzpVdN0PF7w7NcCOhAJ3LJgAGRoQTo88kk5fJEjBOD/34mbyuTo1elZC0
 seABTx3+Pr1AsIi8QfXsrokfY8S73Vxpm/F23WWy6FsI5NDRBKmyvcx
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
	TAGGED_FROM(0.00)[bounces-304435-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BA1A6FFC92

From: Andrew Lunn <andrew@lunn.ch>

MII access to the switch generally has consistent latency. Sending and
receiving frames on the other hand has a big variance in
latency. Receiver interrupt coalescence can result in delays of
100us. As a result, the RMU can be slower than MDIO.

Measure the latency of the first 16 read requests performed using the
RMU, and compare it to the latency on an MDIO read. If the RMU is
slower than MDIO, do not use if for single register reads, writes and
waiting for bits to be set. Do however use it for retrieving MIB
values since a single RMU requests replaces a large number of MIDO
transactions.

Testing on ZII Devel C, which uses a FEC, and Marvel 370RD using
mvneta has show RMU is slower than MDIO. ZII RAP however, makes use of
bit banging MDIO and an IGB. IGB by default has a short interrupt
coalesce period, making RMU much faster than bit banging, by around 20
times.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  6 +++++
 drivers/net/dsa/mv88e6xxx/rmu.c  | 58 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 7e483ba8c58d9..fdc87d02469b5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -355,6 +355,8 @@ enum mv88e6xxx_rmu_state {
 	 */
 };
 
+#define MV88E6XXX_RMU_IS_SLOW	BIT(0)
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -471,6 +473,10 @@ struct mv88e6xxx_chip {
 	struct net_device *rmu_conduit;
 	struct dsa_inband rmu_inband;
 	enum mv88e6xxx_rmu_state rmu_state;
+	u8 rmu_flags;
+	ktime_t rmu_read_latencies[16];
+	u32 rmu_samples;
+	ktime_t smi_read_latency;
 };
 
 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 88b02030a774f..5660372f41ad7 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -221,7 +221,8 @@ int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 	int resp_len;
 	int ret = -1;
 
-	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED ||
+	    (chip->rmu_flags & MV88E6XXX_RMU_IS_SLOW))
 		return -EOPNOTSUPP;
 
 	resp_len = sizeof(resp);
@@ -249,6 +250,33 @@ int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 	return 0;
 }
 
+static void mv88e6xxx_rmu_read_latency(struct mv88e6xxx_chip *chip,
+				       ktime_t latency)
+{
+	ktime_t average = 0;
+	int i;
+
+	if (chip->rmu_samples >= ARRAY_SIZE(chip->rmu_read_latencies))
+		return;
+
+	chip->rmu_read_latencies[chip->rmu_samples++] = latency;
+
+	if (chip->rmu_samples == ARRAY_SIZE(chip->rmu_read_latencies)) {
+		for (i = 0; i < ARRAY_SIZE(chip->rmu_read_latencies); i++)
+			average += chip->rmu_read_latencies[i];
+		average = average / ARRAY_SIZE(chip->rmu_read_latencies);
+
+		dev_dbg(chip->dev, "RMU %lldus, smi %lldus\n",
+			div_u64(average, 1000),
+			div_u64(chip->smi_read_latency, 1000));
+
+		if (chip->smi_read_latency < average)
+			chip->rmu_flags |= MV88E6XXX_RMU_IS_SLOW;
+
+		chip->rmu_samples = U32_MAX;
+	}
+}
+
 int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,
 		       u16 *val)
 {
@@ -263,11 +291,15 @@ int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,
 	};
 	struct mv88e6xxx_rmu_rw_resp resp;
 	int resp_len;
-	int ret = -1;
+	ktime_t start;
+	int ret;
 
-	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED ||
+	    (chip->rmu_flags & MV88E6XXX_RMU_IS_SLOW))
 		return -EOPNOTSUPP;
 
+	start = ktime_get();
+
 	resp_len = sizeof(resp);
 	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
 				    &resp, resp_len,
@@ -290,6 +322,8 @@ int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,
 		return -EPROTO;
 	}
 
+	mv88e6xxx_rmu_read_latency(chip, ktime_get() - start);
+
 	*val = ntohs(resp.value);
 
 	return 0;
@@ -312,7 +346,8 @@ int mv88e6xxx_rmu_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
 	int resp_len;
 	int ret = -1;
 
-	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED ||
+	    (chip->rmu_flags & MV88E6XXX_RMU_IS_SLOW))
 		return -EOPNOTSUPP;
 
 	resp_len = sizeof(resp);
@@ -389,8 +424,10 @@ void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 {
 	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct mv88e6xxx_chip *chip = ds->priv;
+	ktime_t start;
 	int port;
 	int ret;
+	u16 id;
 
 	port = dsa_towards_port(ds, cpu_dp->ds->index, cpu_dp->index);
 
@@ -414,13 +451,24 @@ void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 		if (ret < 0) {
 			dev_err(chip->dev, "RMU: initialization check failed %pe",
 				ERR_PTR(ret));
-			goto out;
+			goto out_disable;
 		}
+
+		start = ktime_get();
+		ret = mv88e6xxx_port_read(chip, 0, MV88E6XXX_PORT_SWITCH_ID,
+					  &id);
+		if (ret < 0) {
+			dev_err(chip->dev, "RMU: SMI latency read failed %pe",
+				ERR_PTR(ret));
+			goto out_disable;
+		}
+		chip->smi_read_latency = ktime_get() - start;
 		chip->rmu_state = MV88E6XXX_RMU_ENABLED;
 
 		dev_info(chip->dev, "RMU: enabled on port %d via conduit device %s",
 			 port, chip->rmu_conduit->name);
 	} else {
+out_disable:
 		if (chip->info->ops->rmu_disable)
 			chip->info->ops->rmu_disable(chip);
 

-- 
2.43.0


