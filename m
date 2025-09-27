Return-Path: <netdev+bounces-226851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C566FBA5A67
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517614C6442
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9F2D2391;
	Sat, 27 Sep 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="BRlqEDUJ"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F92D0C69
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959355; cv=none; b=VoUTf1XCukHfXwMcFKY2NSQaEup7Qs00Hld5ZxWpHf/sPYJatzOUBiD7lGFNLFdBkAnf9K2D+ooqk80++ikQIvS7bxxs/jgSh3UL/ryjxOotuqp5xGFLdU1FiOoIyFX0HeTWSh88wuvUFr2v1Nr19Jl26SQ5WPps+TtGYDDE30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959355; c=relaxed/simple;
	bh=0SdfO78R3Ys/MvdDYyAvVvm5FyGOS0W6yqnZMeLOMQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXh+zcyS6XKDAiIdrp/YJM62PhIS5LCaCrH6AcBoqvJ+nanWn/eEO71CkzMC84XgYxFytwW266OVZN1a3WiNcJHFG+2RgaksTE3AEzNvW9S4V0LkFSyho76ZQ9slJ/LVRz/EejaweZFr/lZU7A5iBKjE6QHnRtDcX9/I+8I/0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=BRlqEDUJ; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w89026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:12 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w89026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956894; bh=nRMoFOSiaP1lYUNx1pFI27fFzLe4DmihyBhJ2UhrXEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRlqEDUJfLiv13J3Gr7HHS1rC+HtWV9Ch0IKejY2H7E5xL6sRHHo8vuUmybmfaDEf
	 sF+6YLlhTfmKeQOZQdzKnKhuJ2VPaPYZSW/4KYUyNPuLsoW7PN63rOxp9Hqw4eJg0/
	 DdwB/MUseMYxGRnSSo80EJXfp/BTPc6SuNEpMF/ReOcFv64rL0UrEvvShBjsItdK0m
	 Zb2colZAeGHExpPRI9ycocL3pfIefpRC+D9Aur3DrHz6sygNs2fpK+0Kpr4ekQg54d
	 TJiO2kqxH9Y6Jf5lzBdoJmQoe6+S042Txu2n0bQ0yuDFEorvBEv0ysLoaJ0zQ2Ap3S
	 v/5yN71cq9tXw==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 1/5] net: dsa: mv88e6xxx: add num_tx_queues to chip info structure
Date: Sat, 27 Sep 2025 17:07:04 +1000
Message-ID: <20250927070724.734933-2-lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927070724.734933-1-lukeh@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding 802.1Qav support (FQTSS), add an element to
struct mv88e6xxx_info indicating the number of transmit queues supported
by each chip.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 15 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b4d48997bf467..42189aeb9aec0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4099,6 +4099,8 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 			goto unlock;
 	}
 
+	ds->num_tx_queues = chip->info->num_tx_queues;
+
 	err = mv88e6xxx_stats_setup(chip);
 	if (err)
 		goto unlock;
@@ -5863,6 +5865,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6141_ops,
 	},
 
@@ -5965,6 +5968,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6172_ops,
 	},
 
@@ -6016,6 +6020,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
+		.num_tx_queues = 4,
 		.ops = &mv88e6176_ops,
 	},
 
@@ -6063,6 +6068,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.atu_move_port_mask = 0x1f,
+		.num_tx_queues = 8,
 		.ops = &mv88e6190_ops,
 	},
 
@@ -6088,6 +6094,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6190x_ops,
 	},
 
@@ -6217,6 +6224,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6240_ops,
 	},
 
@@ -6264,6 +6272,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.pvt = true,
 		.multi_chip = true,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6290_ops,
 	},
 
@@ -6292,6 +6301,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6320_ops,
 	},
 
@@ -6320,6 +6330,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6321_ops,
 	},
 
@@ -6347,6 +6358,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6341_ops,
 	},
 
@@ -6424,6 +6436,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
+		.num_tx_queues = 4,
 		.ops = &mv88e6352_ops,
 	},
 	[MV88E6361] = {
@@ -6477,6 +6490,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6390_ops,
 	},
 	[MV88E6390X] = {
@@ -6503,6 +6517,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
+		.num_tx_queues = 8,
 		.ops = &mv88e6390x_ops,
 	},
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2f211e55cb47b..b861486a7065e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -174,6 +174,9 @@ struct mv88e6xxx_info {
 	/* Supports PTP */
 	bool ptp_support;
 
+	/* Number of 802.1Qav TX queues */
+	u8 num_tx_queues;
+
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
-- 
2.43.0


