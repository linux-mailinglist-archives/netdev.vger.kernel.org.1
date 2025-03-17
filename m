Return-Path: <netdev+bounces-175404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08248A65AE0
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96503189A1EC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA71ACECE;
	Mon, 17 Mar 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvwdW+Su"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA581B042E
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232784; cv=none; b=DizIERFOsB1RlaHgpTUalSLd/+tYtwyN8V7wq4PsH/B6JHvm/KAfcc7HKTzrxAXqVH86drt9+BNGaxo6rZfzls1bmyVY9qUX8FxF9db7vpDPwLY/8UI2qknUEXvqTRLOFg9ktnw55pe4ExeXzoV7PkC2IlxRAZDfNrMZwfHYHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232784; c=relaxed/simple;
	bh=NZQewo8Vcue7b7MOZnDjfYQf4IrZrqq59kLs4AoFqD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLqrTqKc3EiAwqjAoTPSvRhkMBQm9HwYGQVj6lt6UTro6YNuohyefrqD+Ekc48mAVBrrU1MDDr1Ne02AhddksNHPjMAPz8Q3Sdz1eDhECImmvMSE4KuiIswz+UYtEbl2t/qPn3nTiGn5dGQFX0d6f7d6NctbXAk67y2jKSDAfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvwdW+Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E19FC4CEE3;
	Mon, 17 Mar 2025 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232784;
	bh=NZQewo8Vcue7b7MOZnDjfYQf4IrZrqq59kLs4AoFqD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvwdW+SurrHQjm+sUeW1DYF3Yp8AFHYDyg3haz48eUS1cDMybn3+sOFJ0hs0QZ9YA
	 itx9EmjfInMh6E7DmyOMn4Z5quMWnkQfXTZL9JHQfPfNnXVk6ldlsXZZcFyg0g0RDi
	 NfZ+WH49WxBLNKvDIxKevk3kUM1XhZktXcIg8wGcA2+KUBOS/kYkmPVEcG/GTxboTQ
	 QsmDx06SYBQF4zuCc5zTUL6xwtSOMowCpffY8uiYb4s1oYnG48/piMwzMXsQPxfHks
	 FLmXrXmQXoy35ip2tOMs2DbqOPwAgdr4kQUxX9IuV8nAh3lLdzgkYw9Y/xYlaHmRFA
	 Ioq7UhHO9mGZQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 4/7] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 17 Mar 2025 18:32:47 +0100
Message-ID: <20250317173250.28780-5-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317173250.28780-1-kabel@kernel.org>
References: <20250317173250.28780-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
did not add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3cddc8f084b3..f886a69d7a3c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5145,6 +5145,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5194,6 +5195,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.48.1


