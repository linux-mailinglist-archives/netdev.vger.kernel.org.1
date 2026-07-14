Return-Path: <netdev+bounces-307616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQAaJpjGVmpVBAEAu9opvQ
	(envelope-from <netdev+bounces-307616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76A759716
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=aSECAsqu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD607304A655
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D363437467;
	Tue, 14 Jul 2026 23:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4F41D640;
	Tue, 14 Jul 2026 23:30:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071803; cv=none; b=flg000XTzJFPuqxTvi5EvfSXBYd7vFow4npUorLGynD9T9asy6obyH3mDlerVbGYOrFHvx0vuoKZbnKynHqpHx90KNdCOgjzbRFe1p3quGL5tBfJsxjiHETP8HLD2zH2U7bHcYoUgB405Qw25D6OtBObjoAVvg+8n79fdGWD7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071803; c=relaxed/simple;
	bh=XDTWkz7O9M5hcf2/ooOl1pFfMwOqHJvSeAVx3aKFAn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZBdLHbBqs5nxmTJcU4n2cyRCcI+NZqQ8G27iP/z59SQMOrYi0Cj1pft/OrX1hltL6oaRptAwxdFsOPIYbuTOANVN4slfwRM+BqgGH0e2qbY+poC0x49nCYGxIzk7ZI0XYjwGXZFU8JLrvGueg4s3g9FMCnOXJ+v5ozeAdd+P2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=aSECAsqu; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3968261935;
	Tue, 14 Jul 2026 19:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784071800; bh=vL215MS/8idnecKgyAlKiTcIBe3X1kty3J9/cOedlys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aSECAsqu8mMW6e0exBzOI31eD6/P6OwQqS05RFYpHz2riPnJ133/yyopMCjqSLFwC
	 6UecUaggR0R51e5kjk6aeFu+etl4rwhoDr49qi8NCBNP1o2zCQhXvNKhxwJ8FNIAo+
	 B+hiY3C10tTFNc57mdVfoP7NRwoTqx7F2ITex3f3+LLZefGNBmxTPok9C/UGe0nIK7
	 Qc8I4eXlYC7730irQ+iBmkOoHo3bL2ehmbu4IG1IckEqvSNPquELHxGzbKXw1tBkSr
	 IQM2Nspxp2FOsJwVYkUt17nXgkRkYDfhsV843rSBfJt4HZZl57/iLMI6PtR3RdyqDY
	 hYPrZ/5xYwzxg==
From: Luke Howard <lukeh@padl.com>
Date: Wed, 15 Jul 2026 09:29:42 +1000
Subject: [PATCH net v3 2/3] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
In-Reply-To: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784071787; l=2392;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=XDTWkz7O9M5hcf2/ooOl1pFfMwOqHJvSeAVx3aKFAn8=;
 b=rJwRxjXZZgT5qGBJ8yakfqPy3IpG78q7GcVRhMD8yxdaW0GCs514kc4rvY7NRihpKfD0cs4dB
 H1Mf3pX0ETKDtciMx0g5LT//aIe/iW6tHfmRz/x5xP6eoQfb8XIafzy
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:mid,padl.com:email,padl.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A76A759716

Changing the ATU hash algorithm invalidates existing entries: those
loaded under the previous algorithm end up in different bins and read
back corrupted.

Flush the ATU whenever the hash algorithm is changed through devlink
and reload the default broadcast entries. Per-VLAN ATU entries and
any static addresses are not replayed, so the hash must be selected
before the FDB or MDB are configured.

Fixes: 23e8b470c778 ("net: dsa: mv88e6xxx: Add devlink param for ATU hash algorithm.")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.h    | 2 ++
 drivers/net/dsa/mv88e6xxx/devlink.c | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7938e50900ca8..6faae74de04a9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2523,7 +2523,7 @@ static int mv88e6xxx_port_add_broadcast(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_port_db_load_purge(chip, port, broadcast, vid, state);
 }
 
-static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
+int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
 {
 	int port;
 	int err;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index f1db12b7629bd..abbb446b73456 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -893,4 +893,6 @@ int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
 				 void *priv),
 		       void *priv);
 
+int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid);
+
 #endif /* _MV88E6XXX_CHIP_H */
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 6f034841883c6..5168335f52289 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -61,6 +61,12 @@ int mv88e6xxx_devlink_param_set(struct dsa_switch *ds, u32 id,
 	switch (id) {
 	case MV88E6XXX_DEVLINK_PARAM_ID_ATU_HASH:
 		err = mv88e6xxx_atu_set_hash(chip, ctx->val.vu8);
+		if (err)
+			break;
+		err = mv88e6xxx_g1_atu_flush(chip, 0, true);
+		if (err)
+			break;
+		err = mv88e6xxx_broadcast_setup(chip, 0);
 		break;
 	default:
 		err = -EOPNOTSUPP;

-- 
2.43.0


