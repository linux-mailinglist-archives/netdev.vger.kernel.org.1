Return-Path: <netdev+bounces-292017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MfDOVQ+FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458E5DE043
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A363017240
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5B2D2496;
	Wed, 27 May 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="ONq1z6Or"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248C22D792;
	Wed, 27 May 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842641; cv=none; b=e+MOUsQ2wd+Ze7Hyx+cm8arZGAThId0XVsnX97YCqg7010b/11HFGxWLSm6/pR18nPDx9AwOlWq9WJouzTfsSt7P2AQqMtlovieHT1RqRpOluwXH6aooN9HGAxxKmfCp9zh0ZJFy++UmBGLGm/+LiRKUNy1jtreTHILlrlR4d3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842641; c=relaxed/simple;
	bh=HEyBNE2DNL1EoWl/ZyE8HcSo+KSfCa2SAkFZP1AriTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY+6NFxBhJaJTdsuoEx2GJl4wrHm9LLJOFdpPrd1z7eU56dG99iAjmnE5jTeV00ey84YRYmkON2vkW/BoE2LHk8UpojRjYvGTAnDMSRbw2Qv+HfxxPdW7UQxdK/O3VRGzdqqjdYvJUkutQL1+29/IMGkfjToUyM/HFYk8JIFRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=ONq1z6Or; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tF030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:35 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tF030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842619; bh=yMFMaIhjIuPbYHiNqCtAsD3cLQymHFHO8lFa6TgR7yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONq1z6OrknH1LUOoIwxR5YzFgTArzWPX80U1nUe6tH9aKxNsznZ5zGS0i3BC9ggac
	 /xMgtwG6VR6IZXHEv+nJqEIN5Eyl7AcQ1mfbXFEZcY1kzyNIoRva19uEyiztKK4hGR
	 4RMZ4XGcijQEIUvxOXHq+WE7FmvlZzHUt/kJ9QRvkKDLftnXMZU/l4RVrj+WV0zj0y
	 NLDXsoZ0TteAHrRwFKBYb2t8AgDLazvSnB6rGdHOoLEFU93mCrVCx/lBAnfYN61QRe
	 g/cNR/oL2+silNlPnDWtQc9/iN77fdtq5hkLOrmdauUG8+3q7zzoJHH5LHqjC8/83Z
	 r3wcj3YxXLLyw==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: dsa: mv88e6xxx: add num_tx_queues to chip info structure
Date: Wed, 27 May 2026 10:42:48 +1000
Message-ID: <63f824d7d797d55229d37771fd1bb66f30bd400f.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779841530.git.lukeh@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[padl.com,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292017-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8458E5DE043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for adding 802.1Qav support (FQTSS), add an element to
struct mv88e6xxx_info indicating the number of transmit queues supported
by each chip.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 23 +++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c30e4c13565a5..5d45363c67bbd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4106,6 +4106,8 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 			goto unlock;
 	}
 
+	ds->num_tx_queues = chip->info->num_tx_queues;
+
 	err = mv88e6xxx_stats_setup(chip);
 	if (err)
 		goto unlock;
@@ -5873,6 +5875,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6141_ops,
 	},
 
@@ -5899,6 +5902,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6161_ops,
 	},
 
@@ -5924,6 +5928,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6165_ops,
 	},
 
@@ -5975,6 +5980,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6172_ops,
 	},
 
@@ -6026,6 +6032,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6176_ops,
 	},
 
@@ -6073,6 +6080,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.atu_move_port_mask = 0x1f,
+		.num_tx_queues = 8,
 		.ops = &mv88e6190_ops,
 	},
 
@@ -6098,6 +6106,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6190x_ops,
 	},
 
@@ -6123,6 +6132,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6191_ops,
 	},
 
@@ -6148,6 +6158,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6393x_ops,
 	},
 
@@ -6175,6 +6186,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6393x_ops,
 	},
 
@@ -6229,6 +6241,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6240_ops,
 	},
 
@@ -6278,6 +6291,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6290_ops,
 	},
 
@@ -6306,6 +6320,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6320_ops,
 	},
 
@@ -6334,6 +6349,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6321_ops,
 	},
 
@@ -6361,6 +6377,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6341_ops,
 	},
 
@@ -6411,6 +6428,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6351_ops,
 	},
 
@@ -6438,6 +6456,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6352_ops,
 	},
 	[MV88E6361] = {
@@ -6465,6 +6484,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6393x_ops,
 	},
 	[MV88E6390] = {
@@ -6493,6 +6513,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6390_ops,
 	},
 	[MV88E6390X] = {
@@ -6519,6 +6540,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6390x_ops,
 	},
 
@@ -6546,6 +6568,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6393x_ops,
 	},
 };
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..146723fbca658 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -176,6 +176,9 @@ struct mv88e6xxx_info {
 	/* Supports PTP */
 	bool ptp_support;
 
+	/* Number of TX queues */
+	u8 num_tx_queues;
+
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
-- 
2.43.0


