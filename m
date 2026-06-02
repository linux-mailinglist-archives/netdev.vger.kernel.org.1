Return-Path: <netdev+bounces-293941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFIvDRcpHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2E626BC2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876B030D22BC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF531F98A;
	Tue,  2 Jun 2026 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="CwK2A15L"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AE1E1E12;
	Tue,  2 Jun 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361105; cv=none; b=pjV4o/hmUrPssCwUSNZg+tcdyH8VlMvSrh7bW2jDtQQwKbeMwX1ktl2VzIWq8l2BYkvTd7+8yb/kGAxsqcrixLXL3fmbGG5U9ukVOiixbjjk1S36Cqzh7mavVD8I++NzuoBt4VNwjdju+xYmvdnnq/PDx+pQIVgWojmF7Jv/XO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361105; c=relaxed/simple;
	bh=bv6tT8y+sYRr4rUbGXcdOd8wG/5DRS61mv1iJU6vvi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ro8rihei90G6ykcqKZA6XxoJpEnOv7yuTFif0sEBY4sei7+fqsZIg8Jx1wURjvu+Way2H2A5vw0CpTQo4Npd8aKdR0KItFkEqWqB+i3FXFe1hgo7CpDj4Idelz/+Peh1li7RZfGsK5vpR3MXAAu8ZJpzuS6Je+x8jfOgsqBkmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=CwK2A15L; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8w030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:38 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8w030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361083; bh=kT2kb8Zbt0fXPRAiw+lJHS3Bb+BFyDXh5on7RYGIJsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CwK2A15LhfIGtKSya7AmcQwqk+0Xux9fwQt+ceRrhlpWvACT3z4BTXDHKL4kbR8fu
	 jX3ZHfzaOaCwOWq5MSo3vc7Ae9VqpMKp1FMp6lBhkzb4LJY00xS/+pvAzMtXY9g9jK
	 4HgXTRTbMTE1fyHcZhN9imSVIWyJihpbicwt0kuYWgX5Ipsc2uoTbyOdzafQ6TbWeK
	 Swk1cnb+C9iDCrTYfZdtfZc+dikEtqxYUoVxSKOL9kg4ZUUPVDEQs0bjwfhKUec1eQ
	 8+KSelZSRRlhr1uakL+Oy1TTk51PU2UB/PMRHLGXuwNOC4K8IjqdOokyIQuMUJWIPj
	 0K1YDOVECorTw==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:51 +1000
Subject: [PATCH net-next v2 6/6] net: dsa: mv88e6xxx: honour
 MDB_FLAGS_STREAM_RESERVED for AVB streams
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-6-72be14522e7c@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>,
        Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293941-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 91C2E626BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Map the MDB_FLAGS_STREAM_RESERVED flag to MC_STATIC_AVB_NRL when adding
or removing MDB entries to the ATU. The presence or absence of this flag
must match any existing ATU entries for the destination address, as the
ATU entry type applies to all destination ports.

A port in enhanced mode, requested by BR_FILTER_STREAM_RESERVED, will only
admit frames with priorities associated with AVB traffic classes for these
destinations.

Note: MC_STATIC_AVB_NRL entries persist independently of the MQPRIO mode.
If port ingress rate limiting (PIRL) support is ever added, this should
be revisited.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 101 ++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index db79302c2b84d..ef3cb1cca134d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2269,6 +2269,35 @@ static bool mv88e6xxx_port_db_find(struct mv88e6xxx_chip *chip,
 	return entry.state && ether_addr_equal(entry.mac, addr);
 }
 
+static int mv88e6xxx_port_db_loadpurge_entry(struct mv88e6xxx_chip *chip,
+					     int port, u16 fid,
+					     const unsigned char *addr,
+					     struct mv88e6xxx_atu_entry *entry,
+					     u8 state)
+{
+	/* Initialize a fresh ATU entry if it isn't found */
+	if (!entry->state || !ether_addr_equal(entry->mac, addr)) {
+		memset(entry, 0, sizeof(*entry));
+		ether_addr_copy(entry->mac, addr);
+	}
+
+	/* Purge the ATU entry only if no port is using it anymore */
+	if (!state) {
+		entry->portvec &= ~BIT(port);
+		if (!entry->portvec)
+			entry->state = 0;
+	} else {
+		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
+			entry->portvec = BIT(port);
+		else
+			entry->portvec |= BIT(port);
+
+		entry->state = state;
+	}
+
+	return mv88e6xxx_g1_atu_loadpurge(chip, fid, entry);
+}
+
 static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 					const unsigned char *addr, u16 vid,
 					u8 state)
@@ -2281,27 +2310,8 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	if (err)
 		return err;
 
-	/* Initialize a fresh ATU entry if it isn't found */
-	if (!entry.state || !ether_addr_equal(entry.mac, addr)) {
-		memset(&entry, 0, sizeof(entry));
-		ether_addr_copy(entry.mac, addr);
-	}
-
-	/* Purge the ATU entry only if no port is using it anymore */
-	if (!state) {
-		entry.portvec &= ~BIT(port);
-		if (!entry.portvec)
-			entry.state = 0;
-	} else {
-		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
-			entry.portvec = BIT(port);
-		else
-			entry.portvec |= BIT(port);
-
-		entry.state = state;
-	}
-
-	return mv88e6xxx_g1_atu_loadpurge(chip, fid, &entry);
+	return mv88e6xxx_port_db_loadpurge_entry(chip, port, fid, addr, &entry,
+						 state);
 }
 
 static int mv88e6xxx_policy_apply(struct mv88e6xxx_chip *chip, int port,
@@ -6781,16 +6791,61 @@ static int mv88e6xxx_change_tag_protocol(struct dsa_switch *ds,
 	return err;
 }
 
+static bool mv88e6xxx_atu_mc_entry_changed(const struct mv88e6xxx_atu_entry *existing,
+					   int port,
+					   const struct switchdev_obj_port_mdb *mdb,
+					   u8 state)
+{
+	if (!ether_addr_equal(existing->mac, mdb->addr))
+		return false;
+
+	if (existing->state != MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC &&
+	    existing->state != MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL)
+		return false;
+
+	if (existing->state == state)
+		return false;
+
+	if (!(existing->portvec & ~BIT(port)))
+		return false;
+
+	return true;
+}
+
 static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				  const struct switchdev_obj_port_mdb *mdb,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_atu_entry existing;
+	u8 state;
+	u16 fid;
 	int err;
 
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+
+	/* Note that AVB_NRL entries persist independently of the MQPRIO mode;
+	 * as ingress rate control is not used by this driver, this is safe.
+	 */
+	if ((mdb->flags & SWITCHDEV_MDB_F_STREAM_RESERVED) && chip->info->qav)
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL;
+	else
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
+
+	err = mv88e6xxx_port_db_get(chip, mdb->addr, mdb->vid, &fid, &existing);
+	if (err)
+		goto out;
+
+	if (mv88e6xxx_atu_mc_entry_changed(&existing, port, mdb, state)) {
+		dev_info_ratelimited(chip->dev,
+				     "p%d: cannot offload MDB %pM: stream-reserved flag conflicts with existing entry\n",
+				     port, mdb->addr);
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mv88e6xxx_port_db_loadpurge_entry(chip, port, fid, mdb->addr,
+						&existing, state);
 	if (err)
 		goto out;
 

-- 
2.43.0


