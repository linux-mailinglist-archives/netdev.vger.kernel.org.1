Return-Path: <netdev+bounces-307617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlDLA5zGVmpWBAEAu9opvQ
	(envelope-from <netdev+bounces-307617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C9F75971B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b="Nk332/j0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 195D63012CF7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20343C06A;
	Tue, 14 Jul 2026 23:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFE435530;
	Tue, 14 Jul 2026 23:30:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071804; cv=none; b=A2YA6zY4ppEg4sOAaEAR6ED1d1RMaURBd1HeEOjxCv48padOtGyT8tkf0Td0OhpsKuZdjL9+okdyFMhhIt9ShojCU6mzb61pUBmPznDpbluvrvmDhcm4smmzZfK+SEVsRWJiVHsi4xuYb4KyzZ8GDojetSRzawmzEKes3ekdNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071804; c=relaxed/simple;
	bh=1tgVA/S6BsdDQgVSNZZ0wBTm+kotMhPUlsrZqxAa5Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYDrHeUbyPkF+9fEuaiAoNF0QWNpO2hfJcTB+O/VjN8A0vG7MOtHhvuj3Oimk+eQrPosAJE/i6a1psGZmNZuxHJ2nA1cOlg4ICmP2TEYu7VfeyKzhlzgWc6awNkCzTkGlLQcEJLPFHB22T+lbEiAI8DfvwflzHg4D8GP4O8B/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Nk332/j0; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D48A860D3C;
	Tue, 14 Jul 2026 19:29:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784071795; bh=LyGpKfgTEhM2g/vwEavRerpfkyM31GgXBro05X4cAX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nk332/j0SYHc5CQh3jftLhe/idDvfTsLtoCMIClgNr/qsIeqtgg6kPfxGk5R2iO+q
	 Ix6I7a47yAyAwtjuL8sgZsFERmjH99xN6seY7f4yQM6ORQPU6bCMY5CFxj1wFLYF9A
	 DjEh4/uxdlKiI2BMWLvOVkPX+c3E624WWpKqyQqu2oO36+JTT/Re16gCP3MWZ7XSgh
	 NscqfJw1DyRC+dnTFXx6LruXDDIJdQ28m5wINWy3vSkGnPXmyoZwyc0xADxCyCHy/2
	 l3V+JzsgKKZjdE0mgPc5Akbobt1LuQLcBSCvRk5ycVAbl+PRqkiEjIAl2tl+uDz4lR
	 L7YvxoGu4DDvQ==
From: Luke Howard <lukeh@padl.com>
Date: Wed, 15 Jul 2026 09:29:41 +1000
Subject: [PATCH net v3 1/3] net: dsa: mv88e6xxx: write the ATU FID register
 on 88E6141/88E6341
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mv88e6x41-fixes-v3-1-9a8702b27ecc@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784071787; l=10235;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=1tgVA/S6BsdDQgVSNZZ0wBTm+kotMhPUlsrZqxAa5Y0=;
 b=885jrRxyFv8nQ7uiFjgB0c1ce4/nOw8EhkwHLG/v/6iDsfQ2Ai1g/ymbqrRMozA7KGl7w2+3x
 NAXpLIXV1xwCSdeO4tPBQo8FfKC4HhixXxJVoNYicgbA+liP7/CoFLt
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307617-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:mid,padl.com:email,padl.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31C9F75971B

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
 drivers/net/dsa/mv88e6xxx/chip.h        |  3 +++
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  4 ++--
 3 files changed, 32 insertions(+), 2 deletions(-)

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
index e966e7c4cc5de..f1db12b7629bd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -176,6 +176,9 @@ struct mv88e6xxx_info {
 	/* Supports PTP */
 	bool ptp_support;
 
+	/* Has a dedicated ATU FID register. */
+	bool atu_fid_reg;
+
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
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


