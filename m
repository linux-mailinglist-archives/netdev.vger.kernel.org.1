Return-Path: <netdev+bounces-149923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CE9E8235
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137281884835
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9618A922;
	Sat,  7 Dec 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n3Xf/bFV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78375140E2E;
	Sat,  7 Dec 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606355; cv=none; b=c3YAYuljyl1mqkO9ee+LboPklvclTFCuA3iGXAWrzM4WV7fguk0oibq/7yZ65Amlp5pT4b86KAtLDApdICxzlZz20oCNeSt6W6H+y2M80iJE0VLxe2+/b6VgMYdOR37a3IlGuLOk79SjqciC9WWQOzAnEdzRlu1ccZ9Qy6JYubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606355; c=relaxed/simple;
	bh=E0zbpPH+nh1quz39zclZF0xo7Bi8D3qe8o4rac2Fhek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvTojE72ZaCHNVejqhIx2fBU2CE3xkLC3s784YzJhNbPp/g7TkDHWzyRIIoa1osuHK1H0Ra9PA1gtIkabHYwf9ugijfNaofUaQsEEYtS9TrQ4xFVkAlLPAyLBlKr98LMu6rVXVdEfdqynj6GVYsxQjE0GTh9rf3fds9ULrhw9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n3Xf/bFV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DHDNK/8plRu/NmkrLQJScqJM3ZjUtcDcKLe0yfv5CiE=; b=n3
	Xf/bFVI9TodWM+2d6MDTe/OYTlBUxqPOjE141PBU+mcaE+mo9tyZ8nVjmdzMcEimtHbzdLQU2qw9i
	ZOU8w8TVHQgWKDvl2mev47voCJygnAwXGozavqoYgMc1nMMYRUtrL5I2EdbC+s0aoAlnZASGJAWsi
	lEuXg+O4RXvO3l0=;
Received: from c-68-46-73-62.hsd1.mn.comcast.net ([68.46.73.62] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK2CX-00FVTF-Ty; Sat, 07 Dec 2024 22:19:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 07 Dec 2024 15:18:44 -0600
Subject: [PATCH 1/2] dsa: mv88e6xxx: Move available stats into info
 structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-1-b9960f839846@lunn.ch>
References: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
In-Reply-To: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12062; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=E0zbpPH+nh1quz39zclZF0xo7Bi8D3qe8o4rac2Fhek=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnVLvGXLh3tjwu4ez+IbjtZsWb7nPlbGQ0vNFA7
 bVpTGotTjKJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ1S7xgAKCRDmvw3LpmlM
 hIlGEADaTwxZ7B8bEOCGIChxsY0rg577EnftrVb89vYFJjsQwvTNkV6QkEIOS87uBh51S/JDmww
 YBOGS2wSzkAJuFgVvnFAdiwQucY3Dqatpucco+b7q/c+tfaa4CH9oTnfT2OZMGOVlISB+EuC9bA
 pzMEXV+NtGI/2yoXDdpUwNliVjLuEzuZVI3f2xfbfNm6N/AaSl4lHm4I/L3Wo+47xYLIct3/EqN
 b2CvNY6cp7tYHkHqKiVjWAwlrtSr/660PSKZgCcLGTs6cjMnC4Q/LvNJ2CLg5Spv7FicW9Zw8Lx
 gy9PvlheF5vgCzIiJTaSkRwBNEVStIqpmwXP8DoG7QRl+68z2fmG1B/IrdwM+5DB0KOlOHlejip
 ke6epHa0RR8pT/S/ZgMBimB/MTN14R79k+aGlRE+vUUB1owFQPitaX8G+d9dB9hx4eg5SOD3sXf
 iZQsQ3yw83aqyy1DVbofYdiaRidhQPiymJvfDa/sMWf5P7/7MBwosLwBM21+AUj7N4fjlebd39D
 yZCevuGGJhU/ndVAY9idCtc+A1uY+f3YmzKxAAdwdPuF6PMDC0gu67clY/aFwkYATFNr5mWjtWn
 MuWOPOaIzo9/JtZRrR16SM6F5euTrpai58HxbPzUL6fRjhnZ2PbZ68YFNaSZ9eUJoD4+F8q+Vml
 NeKB6mcbYxqpuTA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Different families of switches have different statistics available.
This information is current hard coded into functions, however this
information will also soon be needed when getting statistics from the
RMU. Move it into the info structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 42 ++++++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3a792f79270d9970a759f54635dc920fafed354d..794653b53bb5b822a6163d4f6076f3f9db8aa109 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1289,7 +1289,7 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_PORT)))
+	if (!(stat->type & chip->info->stats_type))
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
@@ -1301,7 +1301,7 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & STATS_TYPE_BANK0))
+	if (!(stat->type & chip->info->stats_type))
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
@@ -1313,7 +1313,7 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_BANK1)))
+	if (!(stat->type & chip->info->stats_type))
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
@@ -1326,7 +1326,7 @@ static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & (STATS_TYPE_BANK0 | STATS_TYPE_BANK1)))
+	if (!(stat->type & chip->info->stats_type))
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
@@ -5645,6 +5645,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 5,
+		.stats_type = STATS_TYPE_BANK0,
 		.atu_move_port_mask = 0xf,
 		.dual_chip = true,
 		.ops = &mv88e6250_ops,
@@ -5665,6 +5666,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 5,
+		.stats_type = STATS_TYPE_BANK0,
 		.atu_move_port_mask = 0xf,
 		.dual_chip = true,
 		.ops = &mv88e6250_ops,
@@ -5687,6 +5689,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5708,6 +5711,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.multi_chip = true,
 		.ops = &mv88e6095_ops,
@@ -5730,6 +5734,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5754,6 +5759,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5776,6 +5782,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.multi_chip = true,
 		.ops = &mv88e6131_ops,
@@ -5800,6 +5807,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.atu_move_port_mask = 0x1f,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
@@ -5823,6 +5831,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5848,6 +5857,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5872,6 +5882,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5897,6 +5908,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5921,6 +5933,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5946,6 +5959,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -5968,6 +5982,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
@@ -5992,6 +6007,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.pvt = true,
 		.multi_chip = true,
 		.atu_move_port_mask = 0x1f,
@@ -6016,6 +6032,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6039,6 +6056,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6063,6 +6081,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 10,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6087,6 +6106,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 10,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6114,6 +6134,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0,
 		.atu_move_port_mask = 0xf,
 		.dual_chip = true,
 		.ptp_support = true,
@@ -6138,6 +6159,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -6161,6 +6183,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0,
 		.atu_move_port_mask = 0xf,
 		.dual_chip = true,
 		.ptp_support = true,
@@ -6184,6 +6207,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6208,6 +6232,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -6233,6 +6258,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 8,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
@@ -6259,6 +6285,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.atu_move_port_mask = 0x1f,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
@@ -6283,6 +6310,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -6307,6 +6335,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -6332,6 +6361,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
@@ -6359,6 +6389,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 10,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6383,6 +6414,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6408,6 +6440,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 9,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
@@ -6433,6 +6466,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 3750,
 		.g1_irqs = 10,
 		.g2_irqs = 14,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0x1f,
 		.pvt = true,
 		.multi_chip = true,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9fe8e8a7856b271c2efd952b39131ba0977eb4b8..86bf113c9bfa1e9ca15d0d651ea96a56a4c14605 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -144,6 +144,7 @@ struct mv88e6xxx_info {
 	unsigned int age_time_coeff;
 	unsigned int g1_irqs;
 	unsigned int g2_irqs;
+	int stats_type;
 	bool pvt;
 
 	/* Mark certain ports as invalid. This is required for example for the

-- 
2.45.2


