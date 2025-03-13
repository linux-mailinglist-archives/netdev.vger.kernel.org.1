Return-Path: <netdev+bounces-174587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1207A5F629
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B383BA106
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DE267AEA;
	Thu, 13 Mar 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd6dqDiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5375FB95
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873325; cv=none; b=pFzoTy3vB8zfREhVgt3ECQhlH/PkIT2mp97ENCK/9uL4knWt12aLYq6hsd8bGA5mDKREc9/fR9TTj+EYtMNW5JXDtAQ8u9V+1YB2ZH0Jcwf7JVZiBA76C8ov/IP+JHVgjCa9cTVJ7DHqMvtK52gqdACmRZKofIAwHeSNLoYWuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873325; c=relaxed/simple;
	bh=RRBGJ0Hv4SrXZf6PdhmPktGA0EwoKR9Xc1vgMJaL2Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMZbrI/YOa5Rm/2XVSJd2eBZgx6A4iKb+GVOeo6N8ZaCVX76kKVlfWYM/mgruM97lmD+pm3jviE35+qJQXdIns+tw4svxu9rsICYE1EMb65L/Vh++JHexuKOK9ZAmEUW8JGzTmjKCke1bKfI83CYH+hEyP4O1y8S2eEeckUQHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd6dqDiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D2C4CEDD;
	Thu, 13 Mar 2025 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873324;
	bh=RRBGJ0Hv4SrXZf6PdhmPktGA0EwoKR9Xc1vgMJaL2Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dd6dqDiIzNTJZiJ/dpxuackWdeADZ2D1NbGIxiXIRVUCNQNlKH4QIAC8WtdS5XZv8
	 FAV/GeirWcMB/7wgw1+Hgm1KnqNlb3dvZ0c6Hlk6XhDX9te1262J+cHFoYioMjFI5i
	 y2rcRz/EIrsXW3VZDCqf/QN3KGlD/vvdfVEzCdWkHqbi+rddc05CIckNViM2aNIYB+
	 PsBtTthmgawRz0MDawD1hSGKg9CKr+cMaCP0al5S/Yv2veqb7oKHYQONBDGbOfF5Z+
	 zN1vtXKew81KVltstWtZp/KWq9vi8jacfXSxHHd++S52QalcYI3bNenGOgCtZNn4sz
	 jOCdwXnuuJi9w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 06/13] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Thu, 13 Mar 2025 14:41:39 +0100
Message-ID: <20250313134146.27087-7-kabel@kernel.org>
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

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") forgot to enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cd351a7f4906..2f34cb1438b4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6265,6 +6265,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.48.1


