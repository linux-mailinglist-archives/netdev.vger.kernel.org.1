Return-Path: <netdev+bounces-174592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95AEA5F62E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF55D189F260
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE7267AE8;
	Thu, 13 Mar 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuvXA/zN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF2267AF4
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873337; cv=none; b=KIQGKgsI8GZjLPKnjBcWDjPqvGf6OQz0tTTfS4b3zv4Q4HotyF+mtIJ3JISgTL83jkEMvrA8DBpaZVPN9f8I1IvVZTfNrzSyOlm9aGIlNtTHg9m1xt5FgEi242rTlpWrOUB2VFLjXFfUPDwNxrsVBiqJhzLuAotAiToFPy9kFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873337; c=relaxed/simple;
	bh=qQSVtpaZKOAVOOUa01ICfEcuE/MI/lYKniAWFQOKaAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPYtJ37cpE5BLD8gTHiKKIog1VRrV70p4VurFx216bMBvfn2yNc3EgoQDWE3GCFYEAuzKdQ5W3qvLuHC5jwzgn1iRhIYbbMnbqngBzmoV6yN3rgu/emgeXRqy8/IP1uQStQfP/eW+gpKdZnwCqRH5UeXaCwBYWvLpGXCQDgw1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuvXA/zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B83C4CEDD;
	Thu, 13 Mar 2025 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873335;
	bh=qQSVtpaZKOAVOOUa01ICfEcuE/MI/lYKniAWFQOKaAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuvXA/zNQrOf17/b+UF9EztL+gHFBYrlHNV39fgdmUGirG8ZnbaMQ60ubW+J9GmsR
	 Gl90xz3mc7yBbcGce1Q+OQSEeLHrxRIsXozoTiP+Y5jyeJjr6ei6LB+CRu4OZG36rX
	 5e3BlWwKFbJxzcpAlkbTO7cM1WhvNOYVCeeM/IaoNvB9Q9jZMn+AmOxX7wisg9P7UC
	 ygoROsOpD2t7xG82FeyGtAKCxB/7abVghjpF/+/wElLGcvljZ0R0zOX5oGafB8hi0v
	 Oj89+bFyPbTzv5wbXB7wTMqNN2vtWrCrLTU+d7BUimOjMnPxRfZbPBjD4BOPsqPzxt
	 Iq4gMuRhca6rw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 11/13] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Thu, 13 Mar 2025 14:41:44 +0100
Message-ID: <20250313134146.27087-12-kabel@kernel.org>
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

Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
supported chips") introduced STU methods but forgot to add it to the
6320 family. Fix it.

Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3b141631b680..3849b8d55fa9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5170,6 +5170,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5223,6 +5225,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6239,6 +6243,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6265,6 +6270,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.48.1


