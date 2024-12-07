Return-Path: <netdev+bounces-149924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66A9E8237
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81C91884842
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482A15B984;
	Sat,  7 Dec 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sWjx1Tc2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE461917E7;
	Sat,  7 Dec 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606358; cv=none; b=A3L7EPF853lqx0D/V9yidhvCCoB0mgEdXhAhsyLKg5G1g+xSj+J71Y4L9+HP13nfuDV2/Ykw7Ah8Rx2yAeUmBHgg0/KZUbV0Tw/6PH1NrvUdtH4r/vbJE8C39pJf9a4+IAPWAwOsBEKCdq8sIlKGNeSV814h3zJZQDgOI8oD0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606358; c=relaxed/simple;
	bh=7QGpqUHRWPUiCkpx2LYqi43P2eqWVJI/VcZdA9njqo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBJDsaKyD8uhstOTJMHVNwYo1dIlGdDx4nK0q+283+0+9UGikhWgteVB4GExZqXJ9ar3L2O2CwNH9ZJEd6UBEAwJbXHJZXh5TvVe5QXW86qG1/HR30Pt4tvToxVVbJzyI0ms1w2PMNT/mn4kUTgAOCy+0TSKiMDdxSTCrb9BOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sWjx1Tc2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VhBcDAuJz6mff0yg2ePXy7mVllSAguIIbreUvrD7GYw=; b=sW
	jx1Tc28k+KJUbXqWvVMsnU2hOg/qOwjS4/D/bLgtf3w8xu1H1pkK7REom1z/5b7BIWud8059Ks1ah
	rmawI//qa1JLnjtPacQkOi5s0oELq7zqTw+H4X3EQV/aYk5/JEWUGpXP3TA+jkdQcsjce5UMVDJTk
	K+BxGX9lQexeZdw=;
Received: from c-68-46-73-62.hsd1.mn.comcast.net ([68.46.73.62] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK2Ca-00FVTF-5t; Sat, 07 Dec 2024 22:19:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 07 Dec 2024 15:18:45 -0600
Subject: [PATCH 2/2] dsa: mv88e6xxx: Centralise common statistics check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-2-b9960f839846@lunn.ch>
References: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
In-Reply-To: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=7QGpqUHRWPUiCkpx2LYqi43P2eqWVJI/VcZdA9njqo8=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnVLvGeieF0fuo4PXmHld+P2IYVVWPGIs8NZvSQ
 6fMFn9CMQ2JAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ1S7xgAKCRDmvw3LpmlM
 hF9BD/9A6pz5yjSBrYZFOnzUypErdME2iB+IKGgpMX68yuIaHtdWkBrPWzKhLT8OnQysEDBfHEF
 n/NYozdzpzX1Sl0SkEtwjy1800W5akViZkWwAse1FShd32JtMtmCdDMKPQH3k2QBwVtHsh9HVnJ
 eubbPfHOKYMriY+ldL2KDY1u5yS4gJu643uStu9ismaszzxHUGi8XlilYmkbWhjYcrH/WSEJ/ZQ
 Sp7HsqtBDdeMBLMO6NxpSXhwQ7a3fVJYVJ5ZmNjw4BKGkBWuQTG23r+JKVgmGWQSoHqonLSbJgc
 W4/nt68F98hY/58y3CoPgWf5xsy6Ze3EGQpjItDw8EnWenBPZ/Gv2WsaAwsdEHehWbYygy27X5s
 mKq+54zNUD9IGDco0FRQ+5mfuzN92OTFLf/NRXihylqFLjS0BvICcdLOMJLV+FU8cKKhF6Hy+08
 I7xaX1EwSU0gZKE9C/LybQplRnZ5U57sJFox9OI+aws+aBuDxlsnbDWhZtV491hMIrEbifs2P0L
 dJvjCxsFzoyvWbhE+P1pAUWhmCoSsXMUtvRnkAgmxAAnjrgt7tgMnOajxcgiJqk2cQApzjK0ii4
 CXtv5SkZXd4PURqApsi/r9EKMgIYcdI/P/3ltLF3fg3I96gRMSEkNor+fKKPNl5BMkQ7Tl0k8ym
 BmRAo/O9+Xfc8Hg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

With moving information about available statistics into the info
structure, the test becomes identical. Consolidate them into a single
test.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 794653b53bb5b822a6163d4f6076f3f9db8aa109..34708c739b0454e6ee435945bf77e3547739b0a3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1289,9 +1289,6 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1301,9 +1298,6 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1313,9 +1307,6 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
@@ -1326,9 +1317,6 @@ static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_10,
 					    0);
@@ -1341,6 +1329,9 @@ static size_t mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 {
 	int ret = 0;
 
+	if (!(stat->type & chip->info->stats_type))
+		return 0;
+
 	if (chip->info->ops->stats_get_stat) {
 		mv88e6xxx_reg_lock(chip);
 		ret = chip->info->ops->stats_get_stat(chip, port, stat, data);

-- 
2.45.2


