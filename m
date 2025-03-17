Return-Path: <netdev+bounces-175403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680BEA65ADE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A2C1899EC3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743B1ACEAD;
	Mon, 17 Mar 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOvOz8un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369A1ABEAC
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232782; cv=none; b=oFk80X2VmbULvng0BAtURfLjTCgK36sEC5trYnqr3V+Fj4Ty4g94Mi6nsnNNDYAgBCCWKiG+XmvhNZowCJUxL78f/MF4VGjJdKKf9j78wA7OZijyncwt+BCiVR2rzE82AVet8o7uMUUmesf43uLggU+Hdj7i0PxLWkRFQteMTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232782; c=relaxed/simple;
	bh=g9jmRCCIFuce0/70wk1Cz6e3ElFSPAQ1w2eKCGMF+B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El/soB0PZyaGLAJFpYk2dsy9Dvn3TXNVRj3DHFVJOvAW8v8q5zjzAoY/z4Fdff3f+N4a3FkEEPrkeSNEQjjOftBinqHEcWKrVlFLJpWeziY0g/Tdjfm0IT+iqw/LoIPYrsUf+oKLyAU+IpeqC6BUBmme10a7ZX+rpgoUR0JTPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOvOz8un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00CC4CEEF;
	Mon, 17 Mar 2025 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232782;
	bh=g9jmRCCIFuce0/70wk1Cz6e3ElFSPAQ1w2eKCGMF+B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOvOz8un17JfN9MWsgKHxzw+2I7O/JQtypQFgRPMuBsxabGrj/jN2v9qbFtUH7LoN
	 YFyEouRMNpAVEU/twzNIcoVRJiDEZ9I3ly5nSuW2eZig11cEDezCYDlvnIfpRg378d
	 ZiV9YEtrmu/QVGUUdSJNqS7W0avXd6ifSy4R+LXlu5qxwXkyRqf/rctEGNKzlds8ph
	 zAwZ0jRh8q6yDyiD0LgMyX0TYYE7JGx1IXIEACen/rcSM5EnAyLJB3NVy0IxFsYuwH
	 /Bi49NHvqoQLLhy9FEILZKNgUtf3zZdS8prPeVG3+NdE3V6AGGoJh7PaTgnzCHbWO6
	 x64xpuruEbGfg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 3/7] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 17 Mar 2025 18:32:46 +0100
Message-ID: <20250317173250.28780-4-kabel@kernel.org>
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

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b989123cdbeb..3cddc8f084b3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6274,6 +6274,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.48.1


