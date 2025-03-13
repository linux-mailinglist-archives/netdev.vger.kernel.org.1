Return-Path: <netdev+bounces-174591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EEA5F62C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A88919C1234
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A734267B66;
	Thu, 13 Mar 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/+2v/0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16672267AE8
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873334; cv=none; b=EwQUuHgZW5KMNMgkoQxkZQpK9ipruoqAU2CmqHpwcQhpTLlSUL1Fga0vNzZYNIKXvxn1ghm5fbKnfbCkvBIyyUaX0HYqaJ6++Tpt6XjTR/CZ9P3Y+czxxhAMCNgWMde5hlQbxreqktMV+wm4DKtSEpq6PKA6q6TzzlXwZBsMEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873334; c=relaxed/simple;
	bh=Hd+Nc6jDCl3qrjRzq7ZKB1W5Ild9chlGlDzJiB+EIXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hjcpy7GTrnWGZUAa3tgWJdU5cWu0Ze8x6bFFejGLusa+117mB+KTEPHeQoTQE11dgzP0h9Gwe8fjwHOFgvYyRGAdQTNNeLUrt8TNVHGP8VtiIxMh0p/mTzQVvwr/4Cul9n38B+LHSnXmi1+JsSuj+mukxPJyHQXabWzyB5nU4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/+2v/0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D2EC4CEE5;
	Thu, 13 Mar 2025 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873333;
	bh=Hd+Nc6jDCl3qrjRzq7ZKB1W5Ild9chlGlDzJiB+EIXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/+2v/0hWxUrv016fJFYnHwn0XwaMuGOspWyLcTAqPc+Dn+xtGQGndUggZZGM3Ybh
	 fiAvOg1WhrMeVpyGwhTYpfaByOCFu6CqU0EXBm1q72P22QClwg+H57+gt+ob2VsH5J
	 e1X3Dcr4mW0fSDAvGSk3DA5pSfx80IlZ515FAszai8fYMfUjw+ZwxfoAnhiy9VRixJ
	 eGibiiapd49UXez+2fhvpyK4xMLdJCIcgaLgXaBkv08hUT+ILpN0viBuYx8IR+GlUJ
	 8eIXy2AV+2UL3jTB3K693qT6Xdrk++zDGmyBIvvPsHGetSOTT7KreXvRXqwKCdP/6n
	 m6XvrOLI+/Lrw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 10/13] net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
Date: Thu, 13 Mar 2025 14:41:43 +0100
Message-ID: <20250313134146.27087-11-kabel@kernel.org>
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

Commit 23e8b470c7788 ("net: dsa: mv88e6xxx: Add devlink param for ATU
hash algorithm.") introduced ATU hash algorithm access via devlink, but
did not enable it for the 6320 family. Fix it.

Fixes: 23e8b470c778 ("net: dsa: mv88e6xxx: Add devlink param for ATU hash algorithm.")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index aba22ce3df07..3b141631b680 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5166,6 +5166,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.atu_get_hash = mv88e6165_g1_atu_get_hash,
+	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -5217,6 +5219,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.atu_get_hash = mv88e6165_g1_atu_get_hash,
+	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
-- 
2.48.1


