Return-Path: <netdev+bounces-174585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7AA5F626
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EC97AABFE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA302267B6E;
	Thu, 13 Mar 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfnB3vid"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A3267B6A
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873320; cv=none; b=ES7owU7F2vPjr2Y7ZCWQbAkIYU1gAzPDHi4eRShB/U9bJ0aFg7m9KZkvQe/DPZNG4/9kKGbe5imWhLy7SGYqXXwZsl0gC5PVhuHVhWJYQacDBWpmHf3jZoTC5/mqAXGD6KSu9n2xXZNyZZZylf2fwuhNWFSUwDZL5Kq2Il7Z6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873320; c=relaxed/simple;
	bh=fNHQFHQkZH1QEGiKZccPzNa9H3mzKwgOGeHy4QonBqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaBvmb6PNaj3o9tB9nr9h1QNDAud/dF4UeztZoTV/MAjbauAZR44fRF9Pq5GrAivdM4NQTWsHOeE+biyT3YxSgdW1rR8ki0q4VpXgYZF/3mGz6x/ceZ4gq38RIrjTXxsACzY0PsUG+yDhsgJAFxJ6gnDQtzt57ri4nvQBtt/W7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfnB3vid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC5FC4CEEA;
	Thu, 13 Mar 2025 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873320;
	bh=fNHQFHQkZH1QEGiKZccPzNa9H3mzKwgOGeHy4QonBqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfnB3vid64yHHFr8tzvDTvCpcx4eaUpZUfWK2GPzw1bIkvG6qVt1jTxN7F/MvcS5w
	 rCmM17WeDpgmu9sn6kcYmjlmoh5YZ9+kouV67XCINHuawBG53ykEN3tKuOi04gSC0T
	 h013EfbQwmmmLFp+iwsuCS/42OeekGWen70Mwvqc3iHCBG4xAB/Inu301LuaQ2Acjh
	 1x3fnXyTPb2YtX3dZc2UqZ+j0B6HjFZJYHVsyaVYh/eiNaD1u0ufwHVP3Z5KNxBgWc
	 j+zW/zV7so6ZQxabbO8tMtunxw3pXWDw7z/pMAINytLxkhFcy8pBAahAoKl5OdoDKj
	 2iDl8xa1sLeBQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 04/13] net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported ports
Date: Thu, 13 Mar 2025 14:41:37 +0100
Message-ID: <20250313134146.27087-5-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
References: <20250313134146.27087-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 6320 family supports the ALT_SPEED bit on ports 2, 5 and 6. Allow
this speed by implementing 6320 family specific .port_set_speed_duplex()
method.

Fixes: 96a2b40c7bd3 ("net: dsa: mv88e6xxx: add port's MAC speed setter")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  4 ++--
 drivers/net/dsa/mv88e6xxx/port.c | 15 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e8c93199e24a..7e4de1d347ec 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5138,7 +5138,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
-	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
+	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
@@ -5187,7 +5187,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
-	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
+	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index d7a6d12aadbf..1b033056d409 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -327,6 +327,21 @@ int mv88e6250_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
+int mv88e6320_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
+				    int speed, int duplex)
+{
+	bool has_200 = (port == 2 || port == 5 || port == 6);
+
+	if (speed > 1000)
+		return -EOPNOTSUPP;
+
+	if (speed == 200 && !has_200)
+		return -EOPNOTSUPP;
+
+	return mv88e6xxx_port_set_speed_duplex(chip, port, speed, has_200,
+					       false, duplex);
+}
+
 /* Support 10, 100, 200, 1000, 2500 Mbps (e.g. 88E6341) */
 int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex)
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index d662b09bf481..4a4134987c43 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -490,6 +490,8 @@ int mv88e6185_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
 int mv88e6250_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
+int mv88e6320_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
+				    int speed, int duplex);
 int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
 int mv88e6352_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
-- 
2.48.1


