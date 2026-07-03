Return-Path: <netdev+bounces-304434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0q6KwBrR2r/XwAAu9opvQ
	(envelope-from <netdev+bounces-304434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E76FFC8C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=JT1TpIrV;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304434-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304434-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D29AF30577ED
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81174370ACC;
	Fri,  3 Jul 2026 07:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF715375F95;
	Fri,  3 Jul 2026 07:47:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064864; cv=none; b=CWYXjHWrIqBZs2tQzzHtnA0BcmsEaWgp5l0o2KFwVzI0HWKKWI5wG2BpAYwn59//aOhMzOH1fxjw5X0xWMA9eRvWm+s2+MdKB+DL1Zye3hg3R8pRLf7TCeb3BUuG8gz9IJaUL22YS1bMeztRy1aXVtWKW6aoPibuXyDhRFUSLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064864; c=relaxed/simple;
	bh=n7xZKCe7f2IAVPkAdpVeLDeFjJHQD0/tmVzkqjmisJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTSnajpNPO4b9CmdFapsUUy2wWaDe+dC8uQHapjFo2AbeKlRB9vGsJpV82jgzPvWHpPDxI+rBcUBfU94zp57emNTw9w5A0ahQ1ydomfJNu9laDVuJNCTfEahUtnsx3Zvw5/AifC3PMh8qEYcSHRO3Gsw9bRGiwpf0UN5lHNwMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=JT1TpIrV; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1C19560C04;
	Fri,  3 Jul 2026 03:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064862; bh=s1aQxJkRkEa2kjSQHdqAplXcK8QXv5RoOcx3bbA9U2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JT1TpIrVuyN/5DcShlQVsK1h7bM6stGkTv/Y9VmDMkykpVFDjYF7lMGJ1hSOK6hMe
	 gF7kB7GMNf/KRg+oIms8CLVwsM2RHVK8Ht4xKnwkJDlvvk+FB5+Ug7uKY0EugWx3kj
	 f1ZyBRt7NE8OygwF7G6Hm1w6yyE3wN8Qs0P0BIpT3TDE2+dkihJrg0jy799sTe2Ar6
	 SRiP3ej6zMh5Icmjnz7PpbkPkpe5hgEp6i+3u4FKeMhsy9VORGGDunqiI482G8gTSr
	 0Ad/tcK0lknwYyc933nUJD6yqIVGo87xeychHHKgx6xxwvulqYBdffEhJh4/+gH7fb
	 uqac+xarJo39w==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:47 +1000
Subject: [PATCH net-next 13/17] net: dsa: mv88e6xxx: Get some MIB stats via
 the RMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-13-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=7615;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=0A3Kt/raRmQfCInbA/uD5FNf2E5EhTLsV//YaowZPwI=;
 b=HRT7JHzrs20Ahsz9Vsh1ljUwO8HbITpnIxsElO/5Rqpu+uL6L0pdslvVAjW1ltUDpihcyPb6U
 pzGu1kU+a/HCNGWPqbLOng93X6eZ/5etR7967a2uG1SgP3XC+2/ZvsL
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
	TAGGED_FROM(0.00)[bounces-304434-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp,lunn.ch:email,resp.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 227E76FFC8C

From: Andrew Lunn <andrew@lunn.ch>

It is possible to access the bank 0 and the port statistics using an
RMU request. Bank 1 stats are not available in this way. Issue an RMU
request to get the statistics which are available, and use the big
table of statistics to decode the reply and return statistics in a way
that is compatible with the MDIO method.

Where bank 1 stats cannot be retrieved via RMU, fall back to individual
register reads and writes.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  15 ++++--
 drivers/net/dsa/mv88e6xxx/chip.h |   4 ++
 drivers/net/dsa/mv88e6xxx/rmu.c  | 101 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h  |  20 ++++++++
 4 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6431d25f3cfa2..531a59093ef97 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1337,9 +1337,9 @@ static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 	return 1;
 }
 
-static size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
-				       const struct mv88e6xxx_hw_stat *stat,
-				       uint64_t *data)
+size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				const struct mv88e6xxx_hw_stat *stat,
+				uint64_t *data)
 {
 	int ret = 0;
 
@@ -1360,6 +1360,15 @@ static size_t mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
 {
 	const struct mv88e6xxx_hw_stat *stat;
 	size_t i, j;
+	int err;
+
+	err = mv88e6xxx_rmu_stats(chip, port, data, mv88e6xxx_hw_stats,
+				  ARRAY_SIZE(mv88e6xxx_hw_stats));
+	if (err > 0)
+		return err;
+
+	if (!mv88e6xxx_rmu_can_mdio_fallback(chip, err))
+		return err;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
 		stat = &mv88e6xxx_hw_stats[i];
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 07300c25cbd36..7e483ba8c58d9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -905,4 +905,8 @@ int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
 				 void *priv),
 		       void *priv);
 
+size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
+				const struct mv88e6xxx_hw_stat *stat,
+				uint64_t *data);
+
 #endif /* _MV88E6XXX_CHIP_H */
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 03c6f47814c85..88b02030a774f 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -10,6 +10,7 @@
 #include <net/dsa.h>
 #include "chip.h"
 #include "global1.h"
+#include "port.h"
 #include "rmu.h"
 
 static const u8 mv88e6xxx_rmu_dest_addr[ETH_ALEN] = {
@@ -105,6 +106,106 @@ static int mv88e6xxx_rmu_request(struct mv88e6xxx_chip *chip,
 				  resp, resp_len, timeout_ms);
 }
 
+int mv88e6xxx_rmu_stats(struct mv88e6xxx_chip *chip, int port,
+			u64 *data,
+			const struct mv88e6xxx_hw_stat *hw_stats,
+			int num_hw_stats)
+{
+	__be16 req[] = {
+		MV88E6XXX_RMU_REQ_FORMAT_SOHO,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_MIB,
+		htons(port),
+	};
+	const struct mv88e6xxx_hw_stat *stat;
+	struct mv88e6xxx_rmu_mib_resp resp;
+	int i, j, ret;
+	int resp_len;
+	u64 high;
+
+	if (chip->rmu_state == MV88E6XXX_RMU_DISABLED)
+		return -EOPNOTSUPP;
+
+	resp_len = sizeof(resp) - sizeof(resp.data);
+	if (chip->info->stats_type & STATS_TYPE_BANK0)
+		resp_len += MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN;
+	if (chip->info->stats_type & STATS_TYPE_PORT)
+		resp_len += MV88E6XXX_RMU_STATS_TYPE_PORT_LEN;
+	else if (chip->info->stats_type & STATS_TYPE_BANK1)
+		resp_len += MV88E6XXX_RMU_STATS_TYPE_DATA1_LEN;
+
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command MIB %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: MIB returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.rmu_header.code != MV88E6XXX_RMU_RESP_CODE_MIB) {
+		dev_err(chip->dev, "RMU: MIB returned wrong code %d\n",
+			be16_to_cpu(resp.rmu_header.code));
+		return -EPROTO;
+	}
+
+	for (i = 0, j = 0; i < num_hw_stats; i++) {
+		stat = &hw_stats[i];
+
+		if ((stat->type & chip->info->stats_type) == 0) {
+			/* Not available via RMU, use SMI (if available) */
+			j += mv88e6xxx_stats_get_stat(chip, port, stat, &data[j]);
+			continue;
+		}
+
+		if (stat->type & STATS_TYPE_PORT) {
+			__be16 *port = (__be16 *)resp.data;
+
+			if (chip->info->stats_type & STATS_TYPE_BANK0)
+				port += MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN / 2;
+
+			switch (stat->reg) {
+			case MV88E6XXX_PORT_IN_DISCARD_LO:
+				data[j] = be16_to_cpu(port[0]) << 16;
+				data[j] |= be16_to_cpu(port[1]);
+				break;
+			case MV88E6XXX_PORT_IN_FILTERED:
+				data[j] = be16_to_cpu(port[3]);
+				break;
+			case MV88E6XXX_PORT_OUT_FILTERED:
+				data[j] = be16_to_cpu(port[5]);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+
+		if (stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_BANK1)) {
+			int reg = stat->reg;
+
+			if (stat->type & STATS_TYPE_BANK1 &&
+			    (chip->info->stats_type & STATS_TYPE_BANK0))
+				reg += MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN / 4;
+
+			data[j] = be32_to_cpu(resp.data[reg]);
+			if (stat->size == 8) {
+				high = be32_to_cpu(resp.data[reg + 1]);
+				data[j] |= (high << 32);
+			}
+		}
+
+		j++;
+	}
+
+	return j;
+}
+
 int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 {
 	__be16 req[] = {
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index 4b9df3119d517..0865e899cb340 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -17,6 +17,7 @@
 #define MV88E6XXX_RMU_REQ_FORMAT_SOHO		htons(0x0001)
 #define MV88E6XXX_RMU_REQ_PAD			htons(0x0000)
 #define MV88E6XXX_RMU_REQ_CODE_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_CODE_MIB		htons(0x1020)
 #define MV88E6XXX_RMU_REQ_CODE_REG_RW		htons(0x2000)
 #define MV88E6XXX_RMU_REQ_DATA			htons(0x0000)
 
@@ -49,6 +50,7 @@
 #define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
 #define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
 #define MV88E6XXX_RMU_RESP_CODE_GOT_ID		htons(0x0000)
+#define MV88E6XXX_RMU_RESP_CODE_MIB		htons(0x1020)
 #define MV88E6XXX_RMU_RESP_CODE_REG_RW		htons(0x2000)
 
 struct mv88e6xxx_rmu_header {
@@ -65,6 +67,24 @@ struct mv88e6xxx_rmu_rw_resp {
 	__be16 end1;
 } __packed;
 
+/* number of RMU MIB statistics, by type, in octets */
+#define MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN	128
+#define MV88E6XXX_RMU_STATS_TYPE_PORT_LEN	12
+#define MV88E6XXX_RMU_STATS_TYPE_DATA1_LEN	128
+#define MV88E6XXX_RMU_STATS_TYPE_MAX_LEN	(MV88E6XXX_RMU_STATS_TYPE_DATA0_LEN + \
+						 MV88E6XXX_RMU_STATS_TYPE_DATA1_LEN)
+
+struct mv88e6xxx_rmu_mib_resp {
+	struct mv88e6xxx_rmu_header rmu_header;
+	__be16 swport;
+	__be32 timestamp;
+	__be32 data[MV88E6XXX_RMU_STATS_TYPE_MAX_LEN / 4];
+} __packed;
+
+int mv88e6xxx_rmu_stats(struct mv88e6xxx_chip *chip, int port,
+			u64 *data,
+			const struct mv88e6xxx_hw_stat *hw_stats,
+			int num_hw_stats);
 int mv88e6xxx_rmu_write(struct mv88e6xxx_chip *chip, int addr, int reg,
 			u16 val);
 int mv88e6xxx_rmu_read(struct mv88e6xxx_chip *chip, int addr, int reg,

-- 
2.43.0


