Return-Path: <netdev+bounces-174590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7ABA5F62D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1631842043B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C637267B67;
	Thu, 13 Mar 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK7U3iSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78638267B66
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873331; cv=none; b=f8oDL2EVziDaH6bBksc1Hma1Z89cdWxgEpQshGXbFIOk2cLE1c3zUOh1nVSpvOamX8Ny+Ch/3BHUpofiVUFFdbfrth8N2X4wNBXdQjm/EaENFHj7Q/WTmdnLFbeaPh7AqJ/j0xqRny1hWwHbY1ZxyH/sqSyTWVTa0Fnrgxyv7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873331; c=relaxed/simple;
	bh=tYchkEJVToIKJr8VHfiD2OO+eSNWneOh4XLK8FNZJaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvGWksXS+yFAMthcTLsLstFiv/gQGlb4mjz3ZOSjISJk2jrJ4q1A5dJCupgpGAnTW+e385Mq/7f7tN5ylzxLDjZ8reMx6BPZt28aDi1NZBp3UEvzB72VAnSg3p1q3weuibUaMZaujIISICCUUxLxqMzbxmO+ndt8B5/GiSllsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK7U3iSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A365C4CEEB;
	Thu, 13 Mar 2025 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873331;
	bh=tYchkEJVToIKJr8VHfiD2OO+eSNWneOh4XLK8FNZJaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK7U3iSs7SrZkyRlV91SLxf1DkgK+a46Pz17lIfaFXRCUHfNo7W6ROlLQnl7ZtRav
	 T1vWPX8n9Wo+nKaqb8eb9NgDU8yfAiwskOv6Ew1zVwn3KPtKiPStrW3swDSxo7GaLp
	 WLo7J91Jx24piy4QlfO/md5Xwsm67kEBIwtb6PnE7359ylI06bObEW2QAwrVnAfPMf
	 upErO+cYi9COh7f8/TnHQPB0W8e+lVOv+HMfchxzWjxmbTa029cCLMWviZZjj/5xTo
	 h4wOG9QHZc9OCYgsUa8M4Cvget3vQKN7BZHIEberFOsj7OctycPAL3TYMrcoCvkcFr
	 As1eLKUvtr/Gg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 09/13] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Thu, 13 Mar 2025 14:41:42 +0100
Message-ID: <20250313134146.27087-10-kabel@kernel.org>
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

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
forgot to add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e67c24d960cf..aba22ce3df07 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5140,6 +5140,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5190,6 +5191,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.48.1


