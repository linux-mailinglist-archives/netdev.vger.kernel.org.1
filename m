Return-Path: <netdev+bounces-174586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A0A5F628
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE8F3BC378
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDA267B11;
	Thu, 13 Mar 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdlcOoBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F82267735
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873322; cv=none; b=Um+YeX1KW8eQ02OH+oD/Axg6RjL2mNsB4tDxj98pyFpZvbW83IyDJBZVqMNhbQi88Y+0yF/vyjhZmoQQuAy8moXVKNICRuY7Xr+LlDrD0h98iS0+juB0zya3LJ860PxmHJvnH4Zi8uZDOW0cdPfWdzzdIzzRKxlpGGYKirEnKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873322; c=relaxed/simple;
	bh=Vt7j7J0sBOJwNOw7IfKwlxRDExS0J95NEjJCHwgHE4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBuHguN+VGJvqHb40lsHizijONJfnkVb3x3Pt7IdDtLmJ+tLCFoffTt0aSRvqi4CTfHC56StCzdSkna7zm0nRYv2JMVeZLZq/7cNmy3jFLO+kt7DoU7Y6I/QWgl4lku0a00gAOVruBpWau8ZxaACcihh2/MtkU23CtzCTJN8OGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdlcOoBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF84C4CEEB;
	Thu, 13 Mar 2025 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873322;
	bh=Vt7j7J0sBOJwNOw7IfKwlxRDExS0J95NEjJCHwgHE4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdlcOoBL6vHWWzr5n92F4LJxIRIzIiHytg7DQ4NZONU688Evfy3I1T+oJClEtROHj
	 ZlqXk/jU1j5FTXGmggRsIhtYixCL+qOnr2DYuZzsMfhBZFb1Xqqw5yhY+MsZZUv/+3
	 3l1hSEqQe5DXjGUurdd5v3dtwq4QWd+qnlfwa3bgCR7bB6g+wOWi5Nnqp0yXWtIu9H
	 EKdVH8za1GVAP1lHewVY6w975VmdNR/ahrozeqYNv7GPCNUGAKQblyNwEkgn/U/uhO
	 6c6UjvuSAI+nTQppZxOuBWlMcXuM5YZ5Ab98kABkePdZTfr8uSPdPx8Irn/YnnOqEK
	 r22Z8dY4M104g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 05/13] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Thu, 13 Mar 2025 14:41:38 +0100
Message-ID: <20250313134146.27087-6-kabel@kernel.org>
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

The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7e4de1d347ec..cd351a7f4906 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5809,7 +5809,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
@@ -6287,7 +6287,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
-- 
2.48.1


