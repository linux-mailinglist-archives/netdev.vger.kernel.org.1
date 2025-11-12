Return-Path: <netdev+bounces-237923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FAFC5191D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4018424D89
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFE3002A6;
	Wed, 12 Nov 2025 09:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0882FE59F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941029; cv=none; b=Yvyl4jdRHlA/X2nuQt2D2IDO9qpwG6e+ZwLQd/L06KPJEo5kyKnVkARwm3d5X1G2ampGjkseRmiKiu8gRAun4TWcDP5aPk3t/YjclXg5Qt66T6LWru06OLKmlOMMslZ2oXUyA7+QmQZly+HXhdaJGp32+LJ50Pi71stf5Pb0GJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941029; c=relaxed/simple;
	bh=beH0aNDGKuJ+32YpmQmMT5gL32xJIZYbDXbe936SAvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EeNJ0f4BV17Dg/STm/p9awsDgSjtg8Twr+UaaB/2cqdwyisHVQLSh/I3zcPLybR7K9esD4bEK7p/is4Q+z3/qY846Jx/++GyXzkMG2qEmZg3aTux+HK1urhpuptc5Entpm/JtJZT7xyJQxqj7Ss9pA2hukc2N8Lywsyzwztaub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4505b05e7b5so158529b6e.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941026; x=1763545826;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpXwwzHOaxXlBoIFLoYYIaNOb3AgpnrR/uWR9cK9DAI=;
        b=uX1Jo2tCtRoBXiqN8Gu3PCdeb5WVw1O9L/cjyjttjnhjFAxUssTyhGGk0CuvMFKXvh
         Q1eha/mz1ZTTaVSiMrr7rcGufCam/wXETOx0nJUD8cAf6p99S6FW2Zm7DQwqzNMo8CkI
         vrLmeUpIzRGOKszisde+LytZSaiNUqsaPF4T1HMB+hlk3+yTkDzCQW/HCJwQ7u9eodAI
         ZJXOoaDBZR0cUpuzC8H4cnGK9SG1h6jc2PTNC7Vh0VW738bcBi/N8me4y+A+kpL2uyFY
         lG77JChHeQazorWmN2gdi6cPV4DQ1SGha70KqqX9/FmrXuVwJEQ+GkPDa/jYvkzUzmNf
         c4XA==
X-Gm-Message-State: AOJu0YwxL32mAwMV7ZcjQIJi4U5BXHBWU4zIPvzkFfXk6amJojR1u5N7
	2oUI1byc6w9eK7NR3OvVDHnj9rd7N0sq5pUkQjWbUf6r4oVP9KZl4SrH
X-Gm-Gg: ASbGncssvtrv3TU2540WGl4Fi3UabaAWR36wL8oWXdnL+Ove/NeJXfkfy6g6buHYrse
	cibA47kcce7ns2bKX0Rs1aMdK0KwoYWjv0ScM+vmUh3njDRoTlZQcErRYtPdWaQxE7545RYhncd
	1sFW3C2EMjJB6JRfpGb3eq3zvMwGA2M8wLgpnNH8rEwLZ/VLHv/SIHm4qBO5YIR5U6FbR7/A9xa
	rwxSQYcVl4cUSxbBkwj4qbol7ohSTclvx6d4PC+43BDYxEKac3a9jSyYUAssdtPPLiFe91+YcPo
	bOOn/EJfCciCJIbjFk/VtWtHLjwgtFbVu4YOdUUtIQF95UOQRhPlZICOZJjWfFs7085MEzKewDr
	UVIa/zSb/7n628Kvww7Cyph/5y7O207Ch6yFgZrOWthx8hzufS1pM6AABMbxhY7v3/Zrley2UZC
	5Jq44=
X-Google-Smtp-Source: AGHT+IHtHCFbCH8j0aKNtBOwFbMViba6SRutkgYrQJRH1tU0LDhiR1WN8lt5sDOpUMv6IklQY4noQw==
X-Received: by 2002:a05:6808:22a6:b0:44d:af21:bf34 with SMTP id 5614622812f47-4507444e54fmr991030b6e.2.1762941025668;
        Wed, 12 Nov 2025 01:50:25 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500280856fsm8065047b6e.24.2025.11.12.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:50:25 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Nov 2025 01:50:23 -0800
Subject: [PATCH net-next] net: bnx2x: convert to use get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-bnx_grxrings-v1-1-1c2cb73979e2@debian.org>
X-B4-Tracking: v=1; b=H4sIAF5YFGkC/x3MUQrCMAwG4KuE/3mFNTqQXkVE1jareYmSDimM3
 V3wO8B3oIurdCQ64PLVrm9DojgRymu1JkErEoFnXmKMHLKNZ/Phaq2HOZdSr5zrjS+YCB+XTce
 /u8NkDyZjx+M8fx7dJm9oAAAA
X-Change-ID: 20251112-bnx_grxrings-0bccd42bd823
To: Sudarsana Kalluru <skalluru@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=leitao@debian.org;
 h=from:subject:message-id; bh=beH0aNDGKuJ+32YpmQmMT5gL32xJIZYbDXbe936SAvg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFFhgjgMAx8QI7DUEZko2QkT4Y3jl+kfC2Jz2u
 e04QWGWqwqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRRYYAAKCRA1o5Of/Hh3
 bT3dD/0b4Mgi2kgPBK1La5cXRsiG7Nx78A+Bgs05IeE6ZcjjqvPEVpBLQD/yPu4p0Q7oT01yu1z
 riiUlyQdOTWf6AR3uOY+ggqqCfPH2wkbG3OoJL2FGSQ4GXNP7Tux7BIST2APfgTvvZcx0g7VfA4
 i2DeZr9s3GDUoQdyG5FWTj6uyQZT7W4Fbe+ejoJ7OClrXmSGu9fJ3W4aIvdS2tIBSf/BWTkjwyk
 eqfl4DMNZ1gvcNyDN6f1zDGphzp51lJp1hkXsXGAFNnFrp7KzCCUOW7Lm3cmDTqWYXaSKkylBbr
 VkIGJWD/tbrk+3XxnEJZmhWOAFcjXP/VXl8JAz4UfIBQkQRA3OeC3bSXeIVKppnkeIHlwovn037
 AT6PhYDx+ATjnaOqGIdbzbvh0XUDyxymJgdg3B2JzMTZLOlCDvmTxaQ+SGFbplHikUAwrUnErT6
 Zxn3ojkdt66fkHHg4uggDnXu1yCdFUvH/DXBzd9EgIadjLueNOmGzdqO7Hupn+fzcYceQkdLwyF
 UzITPv61FC43K+Q6fsnbLhHCYe02/SsRem8zSbg/YXvLw5q6SNuAuDBCIdJH5/wl64SkahEzleV
 YTFnWT2WD3uSGHkrWG8prq78P0s8tENIm9Fioehm33Dak2DwpFSx1Lb5k/TbY6oqRE60Orxgv+L
 CnOGj43T6BdmXsw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the bnx2x driver to use the new .get_rx_ring_count ethtool
operation instead of implementing .get_rxnfc solely for handling
ETHTOOL_GRXRINGS command. This simplifies the code by replacing the
switch statement with a direct return of the queue count.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index fc8dec37a9e4..3d853eeb976f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3355,19 +3355,11 @@ static int bnx2x_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
-static int bnx2x_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-			   u32 *rules __always_unused)
+static u32 bnx2x_get_rx_ring_count(struct net_device *dev)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = BNX2X_NUM_ETH_QUEUES(bp);
-		return 0;
-	default:
-		DP(BNX2X_MSG_ETHTOOL, "Command parameters not supported\n");
-		return -EOPNOTSUPP;
-	}
+	return BNX2X_NUM_ETH_QUEUES(bp);
 }
 
 static int bnx2x_set_rxfh_fields(struct net_device *dev,
@@ -3674,7 +3666,7 @@ static const struct ethtool_ops bnx2x_ethtool_ops = {
 	.get_strings		= bnx2x_get_strings,
 	.set_phys_id		= bnx2x_set_phys_id,
 	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
-	.get_rxnfc		= bnx2x_get_rxnfc,
+	.get_rx_ring_count	= bnx2x_get_rx_ring_count,
 	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
 	.get_rxfh		= bnx2x_get_rxfh,
 	.set_rxfh		= bnx2x_set_rxfh,
@@ -3702,7 +3694,7 @@ static const struct ethtool_ops bnx2x_vf_ethtool_ops = {
 	.get_sset_count		= bnx2x_get_sset_count,
 	.get_strings		= bnx2x_get_strings,
 	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
-	.get_rxnfc		= bnx2x_get_rxnfc,
+	.get_rx_ring_count	= bnx2x_get_rx_ring_count,
 	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
 	.get_rxfh		= bnx2x_get_rxfh,
 	.set_rxfh		= bnx2x_set_rxfh,

---
base-commit: 37eb4c8985f12ea1c5b62defc673346ac4a113cd
change-id: 20251112-bnx_grxrings-0bccd42bd823

Best regards,
--  
Breno Leitao <leitao@debian.org>


