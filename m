Return-Path: <netdev+bounces-174584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF90A5F627
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56D917ED6A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BC267AFE;
	Thu, 13 Mar 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogn74Ta+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B80267AE8
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873319; cv=none; b=QGWUkFVb0uG0uKfEyF4QXCQ67JFRC6bby5bjGlfOuhvAEEqeoSL6tCDJ1eUFEINPlZS6ozR7HFCYd+NjWsxdMsopEr9u1jTkFMoSooiF0TzulAx675G31m225VWrwSvg9luseDhnNg1aJWV3dTgUBnoVgJrxPNSjTPL15tf2/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873319; c=relaxed/simple;
	bh=7y7lmY9fFtZ1M3ycc0ZidveBxq0X95qJTbS2zMGMHYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buOETmklME2/eh71gBql2gewidhXXl5Nk9uFxE/kcNALRMm4wQeWOsfnlo1XDUXjwoypoR2gadL6gK9Cy2/RLRW7RSN7lxuQSk8AB4p19MirMhSPs7cjBuE4WPI0J/9sPmA0YGOt7cTfMEzaDJDjO8itV2UOEc95MXe3lYGYlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogn74Ta+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0119CC4CEEF;
	Thu, 13 Mar 2025 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873317;
	bh=7y7lmY9fFtZ1M3ycc0ZidveBxq0X95qJTbS2zMGMHYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ogn74Ta+TGAPL1PiQvGxkk/bJ2Wp6p/K3tiWBqcqD6CgGkjjxgJx5PPmjSCsRQUQM
	 xGXqkbF2LgrByQNDvcW1GtewCnrZFX7E92faKv7TP6SRIROPMfArJu54cZ42jCYcFk
	 uwckAnUJJh1pIGnNK4AaIQN/DTwqHAr62nPMJPOOQgLFQUDOX16JC5Tw3uMwlDF0cI
	 nenUOZSQg8JmAVmbEI7o2XjIG8XvaVmXpPScVzTUt3MqOOIZpRbD2mwA93OPqTqors
	 /mcBwqURJUMKLeCGeZlrgIBhSbBEZ2eY88pYwkMsmnsPyGWNW5iT5i5yn0UNjHChL3
	 qsTceWJiuTRmw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 03/13] net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
Date: Thu, 13 Mar 2025 14:41:36 +0100
Message-ID: <20250313134146.27087-4-kabel@kernel.org>
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

The 6320 family has 9 global1 interrupt, not 8. Fix it.

Fixes: dc30c35be720 ("net: dsa: mv88e6xxx: Implement interrupt support.")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index aa8ebe9d6bdc..e8c93199e24a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6235,7 +6235,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
@@ -6261,7 +6261,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
-- 
2.48.1


