Return-Path: <netdev+bounces-211510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF0B19DAC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A4E3B89C2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8723909F;
	Mon,  4 Aug 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzEwJBn/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241419882B;
	Mon,  4 Aug 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296425; cv=none; b=JQh5TtJWFuFqNot8lGCTmHbW/FKgat53B0Sgl0gOSxXSCw4gg7lycdIcy61qLxcKFlQHZ33Mdribor3bZNmcRZocUYCW+f1ivDHBDSgCxpBgmwAHKIEYsItNfdJHfihBRWrJyr/i6Pc54nziu9bIwORDP78gXadGpruvJsT6O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296425; c=relaxed/simple;
	bh=MyAYeXMuSSdzhcmDVoZx6eeha2WqqeT4QnwnBX0F54Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lHyQcGMYtqmzlrqtHoLZKDdLBFhSAajvkQSaVAAS+ilVHeVZ+wubqKIqzty758sd8RAxBfXOzIWk/51I4PoqqLh8O4AoiEodRHilMDELKFVgZHPsZHiLp1pX6SuvNURG7we0IfQSrDK6ufnnZz/2Ew38q1hQtkjcYhD65JkFnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzEwJBn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088CFC4CEFD;
	Mon,  4 Aug 2025 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754296424;
	bh=MyAYeXMuSSdzhcmDVoZx6eeha2WqqeT4QnwnBX0F54Y=;
	h=From:To:Cc:Subject:Date:From;
	b=tzEwJBn/hUqRR5jrkBIyPZcCnbY2ytXIeDLRyof0WpOuwlNqziindSoQaZe0+kzh9
	 1Vhwh0mIffWDlNTlPZTEyn0U4rPFG0ith0s1mhxD1B1qONelGw31a6zWwMOniL/3wG
	 kjRpmvpuFz+muooRB2SyQhkMCJKjQO0J9AtFeoAC9nu58AJd+PQDFJGlRG01Wyyt2l
	 MVKd7P6mmRSm0yflQ3bYTnIdtypgYFASPzWcSEWCu3/Ni/phNhxPxShu/ET+gYZppg
	 0tHKBQd8l4zdgE/tvhBmeW85BFCUzbXRn46E0UgTxNa4DgGTcskN5/ghV+5DiKe4fc
	 88u1M3YZZ93hA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dpll: add back CONFIG_NET dependency
Date: Mon,  4 Aug 2025 10:33:33 +0200
Message-Id: <20250804083339.3200226-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Making the two bus specific front-ends the primary Kconfig symbol
results in a build failure when CONFIG_NET is disabled as this now
ignores the dependency:

WARNING: unmet direct dependencies detected for ZL3073X
  Depends on [n]: NET [=n]
  Selected by [y]:
  - ZL3073X_I2C [=y] && I2C [=y]

Make all of them depend on NET.

Fixes: a4f0866e3dbb ("dpll: Make ZL3073X invisible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dpll/zl3073x/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 9915f7423dea..95813c043f16 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -17,6 +17,7 @@ config ZL3073X
 config ZL3073X_I2C
 	tristate "I2C bus implementation for Microchip Azurite devices"
 	depends on I2C
+	depends on NET
 	select REGMAP_I2C
 	select ZL3073X
 	help
@@ -29,6 +30,7 @@ config ZL3073X_I2C
 config ZL3073X_SPI
 	tristate "SPI bus implementation for Microchip Azurite devices"
 	depends on SPI
+	depends on NET
 	select REGMAP_SPI
 	select ZL3073X
 	help
-- 
2.39.5


