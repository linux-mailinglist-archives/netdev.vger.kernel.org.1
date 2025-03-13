Return-Path: <netdev+bounces-174588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C8A5F62A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C7C17FD97
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D18267B1F;
	Thu, 13 Mar 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvX4clJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4A5FB95
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873327; cv=none; b=BP1kB8owf4RAzczwCRn+8hz6enFxlXYV+Xjd7OFfxuHlNb00kaoR5UKQsIjirN9xcqrPJRvx4xSDaNRQDWCc7w8ZPB171q1amaGzuSZ8M+QZJ2kev09JXUy4ZKzBYVxFsXJ6UoB6v/Hqz56Btq/BJCjvCvtjXc48WPPguh3nuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873327; c=relaxed/simple;
	bh=azKpCsWIgAGBPNx14li7ADhIDf9XH018umldh4P6+S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXtQxxaQ+3Z0EIXz0fKBUnU/vIHAq549tOnfk0VaPVIeoLMNvthQ3lUKtW9fqWSyFOcF/i695vSE/7brxfX887pXmdOvo8GTX87j116dX4LmvIKEsHhDf6qiQcRbFdDwqT+wrg4M9F3t18yUfmZHN7HQu2M21CC08FmsmFZ94Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvX4clJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDEFC4CEEB;
	Thu, 13 Mar 2025 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873326;
	bh=azKpCsWIgAGBPNx14li7ADhIDf9XH018umldh4P6+S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvX4clJd1Q9SeLMXjHRPMXFETONikcf//1H+cebe95VTncpkIlGKIx5AabtQqRw7A
	 Kv1kit46CT3dJP+H1l86z2/1+PQ9vHDr5x3WUWTQhxcYGBTcznSw4OPowWQQtNmw61
	 xRoyBjuNCW3inhnDfL/FNU9Byj/nKROIQiuRVRr1TgVUsxSYx0gN1N1iN89mZwXMGt
	 yHIs7V8z/Rl2NRiMReGNUQBaj0yC9StaQuQYMUhiIBS8RBusqq4o7Y8Xa0L2XnsSBk
	 cTm97lwSRI4G8lgWFggvac6vPFjR4/exw8aQLy8NSLRlqtomfdvrEJSXsaaQPxJawt
	 +SBvENrv1hT/Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 07/13] net: dsa: mv88e6xxx: define .pot_clear() for 6321
Date: Thu, 13 Mar 2025 14:41:40 +0100
Message-ID: <20250313134146.27087-8-kabel@kernel.org>
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

Commit 9e907d739cc3 ("net: dsa: mv88e6xxx: add POT operation") forgot to
add the .pot_clear() method to the 6321 switch operations structure. Fix
it.

Fixes: 9e907d739cc3 ("net: dsa: mv88e6xxx: add POT operation")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 2f34cb1438b4..734aee3500c8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5209,6 +5209,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-- 
2.48.1


