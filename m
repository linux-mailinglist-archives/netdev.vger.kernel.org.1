Return-Path: <netdev+bounces-175402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94958A65AD8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1977A5801
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6A19F40A;
	Mon, 17 Mar 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Tt/Xs7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC11ADC8F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232780; cv=none; b=YRKciujKyGhOuwxdCgdDCLLRTbtmQc9FofDpI8CqPadvazfbbXduw6Js3RIuI3GaN0mFwDyzzgf2Hh9onQyHBfeZwAlo3xNNb377Q4TTFl5J13JVCH1JpuuUz4kYRg0YOgBGkoFgJHb4Fy3XvH+/EnxDjoW4GjFAkF6pPll3VIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232780; c=relaxed/simple;
	bh=cQKuPMPAgi/f0AxZTtcKUmZ0QwCU/DG+A983QeIgaIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF6cGDn49Y8F7omTh31nV9JS8DCcnTQ31MlUyD2OUAvR3zMlj6+n3MEwJy8yvcBUxLxFt2U6m5JtMllcj36ccLvh4svm6Veq7tTEJoRAoNM1vmo56IQTvLSTg84CA+8f0p2Bj8r+Jat3jInosNtHVQF9+dpd3FGlPUKMZHXzIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Tt/Xs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09621C4CEEC;
	Mon, 17 Mar 2025 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232779;
	bh=cQKuPMPAgi/f0AxZTtcKUmZ0QwCU/DG+A983QeIgaIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0Tt/Xs7TCqUebwEc6inSZita40NP4fj1lk2fHvngGeiKz0qq22EAerL3fUKfwEQx
	 b2aefCCOJTCKlICAWerFQzce8q4UQYPJf7thSVKCIpX32/InFFmRQ74VyiXxG1ktRB
	 HCdfQr7OP3FUKM04L6arMigJeFIEYxgcnX0vpL1IbbHjI9XtxwxOMK6y6tFdSHriGD
	 DxBuVnlffRJSFWR5tiCDewWfh7Q12Evu1gSDMOupkSgdHRTQmVmQ2tm4mqUi6AwfWy
	 zZet+2s1kM45ru16eEFoJWijafM/4D/CH9S5aIQpLhW71j97BN4d7Rrc4aRzfsE4dL
	 /lF6DXM69DhgA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 2/7] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 17 Mar 2025 18:32:45 +0100
Message-ID: <20250317173250.28780-3-kabel@kernel.org>
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

The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 06b17c3b2205..b989123cdbeb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5818,7 +5818,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
@@ -6296,7 +6296,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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


