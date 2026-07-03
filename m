Return-Path: <netdev+bounces-304369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UteLOFBaR2rmWgAAu9opvQ
	(envelope-from <netdev+bounces-304369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E866FF2A2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:44:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=FS0XqQbE;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304369-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304369-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A7B302D53C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9838331D;
	Fri,  3 Jul 2026 06:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5035E1A2;
	Fri,  3 Jul 2026 06:43:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060993; cv=none; b=Eek+EAyZ+AYm0ODbWpVFIyfes7W3vWru+bMtHkxZfGMA+mvO3O/9AB0XsILQs3x/iTQaedpwI52IWHR8D6Xij21bOg8NqVuvJoL9dXPrimz9GAX/2xDUyO5URruvMpEKT70vdWoeZE4Iul+qhctASltNdpvbYZcbZHcYrmDr8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060993; c=relaxed/simple;
	bh=Kt5zJaj+PnfaguwPDZKUcMOpIkJM+xW/jEzTFJvjzow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wa8wUSiJ1hIBkoez2gkpLIC3L8pJzUjN9ZE9aTI82cfz5GZCFl/P0yZwh0vvzz1G1geuoYGyl6QsZ3FEGuVPb4RSqZgX7u8Uw9tqEz4ZK2g7QrqHcMm0Bu7+rC87TePXzJde2Mt+Jl1z5/NLhALM5TdQ0QB+ZMw6RCNhNwFZLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=FS0XqQbE; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id E866D60D3C;
	Fri,  3 Jul 2026 02:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060989; bh=Fd6rR34ZFWY1pXqW7f4KT/kNbZgfsgQgITd2aZ0VAwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FS0XqQbE7RN1v1mqbt4C56Wrxk7E6D3hAPfcxUWDC90eUkR6wbJq4EFQF5kdLNqlC
	 dLmCpigGWEE6Z9SHX34amXlNLu66DviSkZx7+SBg0oZaZHW/GizxBeiR1xSYF0dMOb
	 A6U3twOb/LBl/yDUWG8SCGR4PZNjSFcHDcurkMdKC9pNGrmOR0ydIh39rCtlzgW/V3
	 OVtuyhAB2G61VXiXHDBhAeKlrLL1rJgv5OrDepF4s0XBh6trlgY+8TH8cYZVM5Eggs
	 Kgnqijk7A8h8PBiDf4tHz6vxghGj59sAxS4QkkGfTdRNUhyohjsvqtgVIx1EmmImOJ
	 8uDbYsR/NOWQA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:42:55 +1000
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6x41-fixes-v1-1-fbd3a1bf8965@padl.com>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
In-Reply-To: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060981; l=2859;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=Kt5zJaj+PnfaguwPDZKUcMOpIkJM+xW/jEzTFJvjzow=;
 b=1vuifhAxmwEH/o/uEXswqvULZoXcFti7e7jfkIZWOmKXzkTguU01cXqWgQRcV6+LjCyk0WH/t
 bHrspaUGvF2DEYpamezvBFuoH36VJWCiM0ICksunVPo1sVCElueEv8+
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
	TAGGED_FROM(0.00)[bounces-304369-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E866FF2A2

The existing code assumed the 88E6141/88E6341 did not have a dedicated
ATU FID register because of its database count (256), instead taking
the legacy path which resulted in the FID register never being set.

This resulted in every FDB entry being loaded into FID 0, breaking
VLAN aware bridging.

Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c        | 2 ++
 drivers/net/dsa/mv88e6xxx/chip.h        | 1 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..60d46680fb50e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5863,6 +5863,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
 		.num_databases = 256,
+		.atu_fid_reg = true,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -6350,6 +6351,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
 		.num_databases = 256,
+		.atu_fid_reg = true,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..9f23d2a7165f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -131,6 +131,7 @@ struct mv88e6xxx_info {
 	u16 prod_num;
 	const char *name;
 	unsigned int num_databases;
+	bool atu_fid_reg;
 	unsigned int num_macs;
 	unsigned int num_ports;
 	unsigned int num_internal_phys;
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index c47f068f56b32..aa5adc78607ca 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -135,7 +135,7 @@ static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
 	int err;
 
 	/* FID bits are dispatched all around gradually as more are supported */
-	if (mv88e6xxx_num_databases(chip) > 256) {
+	if (mv88e6xxx_num_databases(chip) > 256 || chip->info->atu_fid_reg) {
 		err = mv88e6xxx_g1_atu_fid_write(chip, fid);
 		if (err)
 			return err;
@@ -179,7 +179,7 @@ static int mv88e6xxx_g1_atu_fid_read(struct mv88e6xxx_chip *chip, u16 *fid)
 	u16 val = 0, upper = 0, op = 0;
 	int err = -EOPNOTSUPP;
 
-	if (mv88e6xxx_num_databases(chip) > 256) {
+	if (mv88e6xxx_num_databases(chip) > 256 || chip->info->atu_fid_reg) {
 		err = mv88e6xxx_g1_read(chip, MV88E6352_G1_ATU_FID, &val);
 		val &= 0xfff;
 		if (err)

-- 
2.43.0


