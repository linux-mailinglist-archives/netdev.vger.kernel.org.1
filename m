Return-Path: <netdev+bounces-174589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A8A5F62B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96F5189EE81
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C4267B86;
	Thu, 13 Mar 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEzIOfGD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDD5FB95
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873329; cv=none; b=b2XbKEL4PuaQOvIyrwlzLCFwzuLAcUWWoMdCsbgAHWSZ4bj0p9FESg9erXNR5KtsBMSFXSADfIJRbcVLWekHA6ZUIoCrxy1+RWYYoZRbiM4UnI7sQXuOvoWk/HCA4w239+CoFz9A8X/EfYldcqvtSpm80FcWs292oGt/j2PyVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873329; c=relaxed/simple;
	bh=+caaU80un7KreAnFvUlXPqQew1Yd9pb0REMRMGW++1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpkpyUb1VBEXHOVdAcZ7fHWi/wEM5kC2SnVoQ1eCXfgVhFAurHgmSFKl752CH6HGQcgHO1UH0zVtILZRiincyJM/zvBORiiTLxRAJ/QzcBb3h/4668sxqeKcPhhJlJeBxKEaqGk+A1zgVphEIdU40NIKghCOV+SB4GEvwQ0vetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEzIOfGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C919C4CEE5;
	Thu, 13 Mar 2025 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873329;
	bh=+caaU80un7KreAnFvUlXPqQew1Yd9pb0REMRMGW++1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEzIOfGDeVSLbOGmqc5XfSdEE1vvVK9IqDNHy/1Q4MV741tno1Uwcu+pNr+YYOVCQ
	 BAcP3kw5IrGglfHh/zzMa76vl5AH5PrURsu6D3dyNXqmpGRGySleillZpsUAq6wWbd
	 W1TYvpIrqjEswHgiPKILGyqdYggl4yly+2D2duPgucfGiTstmsn+W9Z7WNwnobj7ro
	 jdVbQVMsBKkDSxzAgG5iKlKDSBwnZxpAUDfE1Hdf42eWMD9HfAw5Tcyo0a3pzeIC7y
	 2h/BgzxvXHYQp98rrOenT+bAPylhrCZFM1+V3HGmjzOPqCYRIldoVCSxd7aNM00q12
	 MIBXFCqGl2OQw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 08/13] net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
Date: Thu, 13 Mar 2025 14:41:41 +0100
Message-ID: <20250313134146.27087-9-kabel@kernel.org>
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

Commit 9e5baf9b3636 ("net: dsa: mv88e6xxx: add RMU disable op") forgot
to add the .rmu_disable() method for the 6320 family. Fix it.

Fixes: 9e5baf9b3636 ("net: dsa: mv88e6xxx: add RMU disable op")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 734aee3500c8..e67c24d960cf 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5164,6 +5164,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -5213,6 +5214,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
-- 
2.48.1


