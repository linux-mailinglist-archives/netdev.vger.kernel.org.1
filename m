Return-Path: <netdev+bounces-304432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hozHKdJrR2opYAAAu9opvQ
	(envelope-from <netdev+bounces-304432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DD6FFD08
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=qXL1hFgC;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304432-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304432-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E79553043D02
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39699377EA7;
	Fri,  3 Jul 2026 07:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D137206D;
	Fri,  3 Jul 2026 07:47:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064855; cv=none; b=SdL+otuWP/qHNMilDBwBETFdp9jU/Bsycb5Sp1phTPCKzzwVz6bw2HgKdyqekfe21FDXlMzSshuadTk6XYyejnvA/U4RHlzaqVGjjhBXyoNFserTWi1p/em5UplcUpSzw/71ZPq8nUt7H8rAhH/LwVQmx3Q94ZCP6iNDTcSleJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064855; c=relaxed/simple;
	bh=D+yf9kjAMB/zkC8MgJHTT0pGrAH9HCJ+jz7kqKRfeBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPODFZobuItldTKNA5IYuPpr2UuG2i4uAr/4Dep5vJzwi+st51FfsbAhTRbeo8sf5/U/ptbXeq/yWsmpI+SZ4AZtl20OET5mq7+HD+Fix8jVhhv8XnjCFFZE+YQYbmj73K915tPSmIs9pC3ncYXU97RXGEOOOaRg7DeVpHsnJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=qXL1hFgC; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id F10B560C04;
	Fri,  3 Jul 2026 03:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064853; bh=s5VywYlkmZolvxFOUa7w4C8xHLD3JXzD8cViJNSRd4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qXL1hFgCwQOUBEZoFdX9uaBzIf1CfCaXFdMUlxmQoVeQ3DWlO+yvu1/mJi89nuDbm
	 eXtRWTsOgQMyMuPbITeWGD3pRZLfNKAsgZNZ6P9ZpHqwjFs9km56TfSc5XaFiBtK8T
	 mvPu9J6Ez33yvo5AijvohzzM/54eQoMI9kjkZk6fMrwNAmgaxSSudO4SctZ5xu6IZj
	 4NcmmC4dGvWo9dJb7XmCjM86q0XrxeMmPpoyvnys57WyYeBuPT6WAiEDgboROYV2wA
	 l8Naz4XCs/0Ov6ZyNt7SUrEiHcSMld3LdRtKd1K1KhLDa9HHwRequRPmvq8ylBVbuq
	 ER2syn7XU7jdQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:45 +1000
Subject: [PATCH net-next 11/17] net: dsa: mv88e6xxx: Move available stats
 into info structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-11-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=2105;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=Fe1euValr/zoeH1D/n+pdyUZK92ZkMy3ZmSl93LbDVQ=;
 b=QNLQITB9LwRwDktyC8VI5+gVH1YInvDt2o1YLv3xjACwVTR1bSH9WFpaghKZ+1rgWzQ9JpZph
 zd5CLIOkbGZAgberoXSKaxleY75oomkCuV+glF/bttOdg5C6+AP1qhU
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304432-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,padl.com:from_mime,padl.com:dkim,padl.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27DD6FFD08

From: Andrew Lunn <andrew@lunn.ch>

Different families of switches have different statistics available.
This information is current hard coded into functions, however this
information will also soon be needed when getting statistics from the
RMU. Move it into the info structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6431d25f3cfa2..5c0a1e2b0507d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1303,6 +1303,9 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
+	if (!(stat->type & chip->info->stats_type))
+		return 0;
+
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1312,6 +1315,9 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
+	if (!(stat->type & chip->info->stats_type))
+		return 0;
+
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1321,6 +1327,9 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
+	if (!(stat->type & chip->info->stats_type))
+		return 0;
+
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
@@ -1331,6 +1340,9 @@ static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
+	if (!(stat->type & chip->info->stats_type))
+		return 0;
+
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_10,
 					    0);

-- 
2.43.0


