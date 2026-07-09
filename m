Return-Path: <netdev+bounces-306390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YwbhBzIvUGoVuwIAu9opvQ
	(envelope-from <netdev+bounces-306390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F27363F3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=l2WEPuF3;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306390-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306390-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73845303D728
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF73B960F;
	Thu,  9 Jul 2026 23:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F83B7779;
	Thu,  9 Jul 2026 23:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639796; cv=none; b=EfSBUST5lQ1A3FnLg1VavUr9AeLM46eWxQEIqVfiJVgiuMfoeY3G4k1XxotlTdvDdck1w+Zax+akAFGKEvBFeQx2pQl16Mnl/p9HSLDkMz4pVV0NDdBkcNXfumnC6R+SaJWwr9fBu+O+m1CX+bBJ/2TRb0oRAaLSaSVwKo8Y9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639796; c=relaxed/simple;
	bh=F2P92v5D9RSLuZxtbqiajGUSBEG1KMr/dzdX20soGPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PadEMFWGamsdMsE1+3FnQpgT1q6/7DZxHGiAygN/dIOVD2GSITMaQNFAUYdw5sQMMI4fZFIZ5OIViNpVyqoCiQ2bJER8tawz03qwmxwzx6/Ccyrob9d9g5hINID8l81otMyY16eHSxlUDB5ri1Bg1ZCP3fQb9YQp/Rv6IDl1KN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=l2WEPuF3; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 8FD5760C0B;
	Thu,  9 Jul 2026 19:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783639788; bh=4Fbz8+UD3+42LZaHuscCilRmpcS4TEQ5GxprqzkdgIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2WEPuF3a4bTWVYHnLedz8y9k6PVX3GTVRfGayU3Vyl/B43q0cIrHpkcBINWZEjxQ
	 J6HYIJMY6f6LCrMn0G8c1UmmTSO+OhlPWRQv/4ely3axZqQQbvLrXVHntSS4gcee41
	 pKknimX2BXdgXb97BFNocQ7RI50LPqqL984GXvPmC1GKjzibb5qNul64OrL/vff903
	 LVM9nShiqGYgODQuDX3DtqGQ1XYa85JEseOHdGxI4E8L0ckOBhrGKtgPYbi11jOBTG
	 enCBDnxttnqvh+1i2h1xZ1f4rgXzmaPui19Tn1NZcFwStIL8hNkVvq+jMnS8AyqNq5
	 JqjdY+zZ/ri/A==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 10 Jul 2026 09:29:32 +1000
Subject: [PATCH net v2 1/2] net: dsa: mv88e6xxx: write the ATU FID register
 on 88E6141/88E6341
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mv88e6x41-fixes-v2-1-e23654c65aa0@padl.com>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
In-Reply-To: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783639779; l=10608;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=F2P92v5D9RSLuZxtbqiajGUSBEG1KMr/dzdX20soGPc=;
 b=X1dTKf15GqZAz7THmYUcx1IXUjSIybussNkNZfo0axVkYp8OqnNHyRnSU5R3GODhI6uv3qr7h
 jmD/MMAx9GnA2smIfFHPseF22oS/JM+XsRJ12sy/NhTm0xqQUlqwCcw
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306390-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A86F27363F3

The driver decided whether a device has a dedicated ATU FID register
from its database count, taking the register path only when there were
more than 256 databases. The 88E6141/88E6341 have 256 databases but do
have the register, so they fell back to the legacy path and the FID
register was never written. Every FDB entry was then loaded into FID 0,
breaking VLAN aware bridging.

The number of databases does not imply whether the register is present.
Add an explicit atu_fid_reg flag, set it on every device that has the
register (all that previously matched the >256 heuristic, plus the
88E6141/88E6341), and key the register access off the flag instead of
the database count.

Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c        | 27 +++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        | 10 +++++++---
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  4 ++--
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..7938e50900ca8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5747,6 +5747,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6097,
 		.name = "Marvell 88E6085",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 10,
 		.num_internal_phys = 5,
@@ -5792,6 +5793,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6097,
 		.name = "Marvell 88E6097/88E6097F",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 11,
 		.num_internal_phys = 8,
@@ -5817,6 +5819,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6165,
 		.name = "Marvell 88E6123",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 1024,
 		.num_ports = 3,
 		.num_internal_phys = 5,
@@ -5863,6 +5866,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
 		.num_databases = 256,
+		.atu_fid_reg = true,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -5889,6 +5893,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6165,
 		.name = "Marvell 88E6161",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 1024,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -5915,6 +5920,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6165,
 		.name = "Marvell 88E6165",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 6,
 		.num_internal_phys = 0,
@@ -5940,6 +5946,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6351,
 		.name = "Marvell 88E6171",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -5965,6 +5972,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6352,
 		.name = "Marvell 88E6172",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -5991,6 +5999,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6351,
 		.name = "Marvell 88E6175",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6016,6 +6025,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6352,
 		.name = "Marvell 88E6176",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6064,6 +6074,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6190",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
@@ -6089,6 +6100,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6190X",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
@@ -6114,6 +6126,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6191",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
@@ -6139,6 +6152,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6393,
 		.name = "Marvell 88E6191X",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.internal_phys_offset = 1,
@@ -6164,6 +6178,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6393,
 		.name = "Marvell 88E6193X",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
@@ -6218,6 +6233,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6352,
 		.name = "Marvell 88E6240",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6267,6 +6283,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6290",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
@@ -6294,6 +6311,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6320,
 		.name = "Marvell 88E6320",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 2,
@@ -6322,6 +6340,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6320,
 		.name = "Marvell 88E6321",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 2,
@@ -6350,6 +6369,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
 		.num_databases = 256,
+		.atu_fid_reg = true,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
@@ -6377,6 +6397,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6351,
 		.name = "Marvell 88E6350",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6402,6 +6423,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6351,
 		.name = "Marvell 88E6351",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6427,6 +6449,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6352,
 		.name = "Marvell 88E6352",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
@@ -6453,6 +6476,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6393,
 		.name = "Marvell 88E6361",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,
 		/* Ports 1, 2 and 8 are not routed */
@@ -6480,6 +6504,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6390",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
@@ -6508,6 +6533,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6390,
 		.name = "Marvell 88E6390X",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
@@ -6535,6 +6561,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.family = MV88E6XXX_FAMILY_6393,
 		.name = "Marvell 88E6393X",
 		.num_databases = 4096,
+		.atu_fid_reg = true,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..aca64fd4cb95c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -165,16 +165,20 @@ struct mv88e6xxx_info {
 	 */
 	bool dual_chip;
 
+	/* Has a dedicated ATU FID register. */
+	bool atu_fid_reg;
+
+	/* Supports PTP */
+	bool ptp_support;
+
 	enum mv88e6xxx_edsa_support edsa_support;
 
 	/* Mask for FromPort and ToPort value of PortVec used in ATU Move
 	 * operation. 0 means that the ATU Move operation is not supported.
 	 */
 	u8 atu_move_port_mask;
-	const struct mv88e6xxx_ops *ops;
 
-	/* Supports PTP */
-	bool ptp_support;
+	const struct mv88e6xxx_ops *ops;
 
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index c47f068f56b32..522978f638e2f 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -135,7 +135,7 @@ static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
 	int err;
 
 	/* FID bits are dispatched all around gradually as more are supported */
-	if (mv88e6xxx_num_databases(chip) > 256) {
+	if (chip->info->atu_fid_reg) {
 		err = mv88e6xxx_g1_atu_fid_write(chip, fid);
 		if (err)
 			return err;
@@ -179,7 +179,7 @@ static int mv88e6xxx_g1_atu_fid_read(struct mv88e6xxx_chip *chip, u16 *fid)
 	u16 val = 0, upper = 0, op = 0;
 	int err = -EOPNOTSUPP;
 
-	if (mv88e6xxx_num_databases(chip) > 256) {
+	if (chip->info->atu_fid_reg) {
 		err = mv88e6xxx_g1_read(chip, MV88E6352_G1_ATU_FID, &val);
 		val &= 0xfff;
 		if (err)

-- 
2.43.0


