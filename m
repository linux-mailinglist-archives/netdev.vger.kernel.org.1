Return-Path: <netdev+bounces-140555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2434D9B6E3C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87436B2189C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD571EF94E;
	Wed, 30 Oct 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl+WA3wy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422D1FF606;
	Wed, 30 Oct 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321909; cv=none; b=IhQfiqQGrml2bJJQn5uYA/sIRAIOXQPt7KRA1UV5y30kiYM5f9FOykGwWdKb4oaLNFZa4r4vaTiI5LVwIdtYOhSOM8WiZWbsxxW6KxS1Kflc22JRMM3dZbmZmOyqFljpFwHBG4GbAqIuOhKvZW9v4m5ML0gkS1DTOMYqrd1n9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321909; c=relaxed/simple;
	bh=OlvKS2bUJ7r/ZJgfIDvz8otcdxUz5EEhxEyCrGKXhag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfv3cSju0eZRuZlXXcyg9b46p0RFI2CsM6HglV0DnLM6FPom0InOSoDLsidQX7jAEI1c5IhHHD3TBcLB8rqPfDvjTZ0/AeKb6WVFyEUSm/p5bt0vP+B8ovrVSoYtw2tQuhZlKep1GaP3vh1R7yjsbIEPF+mgstixuQ1m6rEqpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl+WA3wy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so2808715ad.3;
        Wed, 30 Oct 2024 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321906; x=1730926706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRYYm8hMI3bj7Uwgo7AT5/wMKTZHng/kylBpdKw3Kfs=;
        b=Fl+WA3wyJYxChYn3hzsuvlq1bhncxr94J6Vv/NjMppqLOy7jwx2p1VRKL8t0D7dx/+
         vQmh00b9krIZ5bAU8vi2eGsLTvxj+2NVndzEjE9zuCW7TCJour50GHmoZG1k2Y5LZNdQ
         L3Ffj3adBci8Dlhw+BleQKc9qfmA0bbS96kYCwRhy80j4Rl4mJaYZvx8x+y1jZhCEU7K
         A6mQBVSFNuwem2bMT+ERI8SlarTXEZKyP0K7WxNUuTDeiHN6fyzzWtuhr40T6PeR4ea3
         yLXLMRpv7nGrLbsCATAW7jX2h4VIACGPY2eUbk5Qb0yICiU09I7Omf+PJmiSxSJa6B1n
         +qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321906; x=1730926706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRYYm8hMI3bj7Uwgo7AT5/wMKTZHng/kylBpdKw3Kfs=;
        b=Un6lZTtisJQor1trMlZp8iazP46QYVlZinEsF7i+KWqZTf6rulKB0ae9V2fYmq2the
         thjvsBiELbSoA6J335+DV5pqhwpaN9O4G8Up0tYKzG3mbNktTbQ5ZEeFZnipTQNSsdFg
         F2/FQfZ61p03ebqwGm4tATdRhlj1cvWSQjpkTh1Kwu8Sd+Vy3Yrg92JKb8FdcjMuixRF
         L4nMDGgBsVvBU6cHZNez/8VVSFDyV9cVE1YPu9xzd4Ix26ccFrk0ZRZW5a48DmSOgKqJ
         QfWdooHNlLx/D5j7F/PyMWAWc6uYHvdDg/FNSoK1T4BfPVurbsZkVA9m7pbs8Y+P4eM+
         CZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVshxKJSfU13h5JUUnZCTBHqz+tOKlo7vhNr5h+rbfC97Z6THOFeLGDTHklJW5UpzD6qW2O8wtz2BN3mQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKKY9bdYtc68VW0Pa+eshLg9a7/Q6ob61WCpwgzqQzuXZaVQd
	j+lq5xQTSXXFCTCMccYlFC4oF2j3z5JKRj0nQ0SCd2NRIUdDYKVXjyGMXLHZ
X-Google-Smtp-Source: AGHT+IEpoEpLj67ThlPqsHmDjG3KCBfKEuKbfliF+BLlqdxNPnA4pyYR7S0sCJZf+iyIgESqcBqfew==
X-Received: by 2002:a17:903:943:b0:205:68a4:b2d8 with SMTP id d9443c01a7336-21103aaa063mr10535175ad.11.1730321906556;
        Wed, 30 Oct 2024 13:58:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8ae2sm114895ad.274.2024.10.30.13.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:58:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: mellanox: use ethtool string helpers
Date: Wed, 30 Oct 2024 13:58:24 -0700
Message-ID: <20241030205824.9061-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the preferred way to copy ethtool strings.

Avoids incrementing pointers all over the place.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: rebase to make it apply.
 .../mellanox/mlxsw/spectrum_ethtool.c         | 83 +++++++------------
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  7 +-
 2 files changed, 30 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 2bed8c86b7cf..5189af0da1f4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -607,84 +607,57 @@ static void mlxsw_sp_port_get_prio_strings(u8 **p, int prio)
 {
 	int i;
 
-	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
-			 mlxsw_sp_port_hw_prio_stats[i].str, prio);
-		*p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++)
+		ethtool_sprintf(p, "%.29s_%.1d",
+				mlxsw_sp_port_hw_prio_stats[i].str, prio);
 }
 
 static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 {
 	int i;
 
-	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%.28s_%d",
-			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
-		*p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++)
+		ethtool_sprintf(p, "%.28s_%d", mlxsw_sp_port_hw_tc_stats[i].str,
+				tc);
 }
 
 static void mlxsw_sp_port_get_strings(struct net_device *dev,
 				      u32 stringset, u8 *data)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
-	u8 *p = data;
 	int i;
 
-	switch (stringset) {
-	case ETH_SS_STATS:
-		for (i = 0; i < MLXSW_SP_PORT_HW_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	if (stringset != ETH_SS_STATS)
+		return;
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2863_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_rfc_2863_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	for (i = 0; i < MLXSW_SP_PORT_HW_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_stats[i].str);
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2819_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_rfc_2819_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2863_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_2863_stats[i].str);
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_3635_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_rfc_3635_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2819_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_2819_stats[i].str);
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_EXT_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_ext_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_3635_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_3635_stats[i].str);
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_DISCARD_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_hw_discard_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+	for (i = 0; i < MLXSW_SP_PORT_HW_EXT_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_ext_stats[i].str);
 
-		for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
-			mlxsw_sp_port_get_prio_strings(&p, i);
+	for (i = 0; i < MLXSW_SP_PORT_HW_DISCARD_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_discard_stats[i].str);
 
-		for (i = 0; i < TC_MAX_QUEUE; i++)
-			mlxsw_sp_port_get_tc_strings(&p, i);
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		mlxsw_sp_port_get_prio_strings(&data, i);
 
-		mlxsw_sp_port->mlxsw_sp->ptp_ops->get_stats_strings(&p);
+	for (i = 0; i < TC_MAX_QUEUE; i++)
+		mlxsw_sp_port_get_tc_strings(&data, i);
 
-		for (i = 0; i < MLXSW_SP_PORT_HW_TRANSCEIVER_STATS_LEN; i++) {
-			memcpy(p, mlxsw_sp_port_transceiver_stats[i].str,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-		break;
-	}
+	mlxsw_sp_port->mlxsw_sp->ptp_ops->get_stats_strings(&data);
+
+	for (i = 0; i < MLXSW_SP_PORT_HW_TRANSCEIVER_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_transceiver_stats[i].str);
 }
 
 static int mlxsw_sp_port_set_phys_id(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 5b174cb95eb8..72e925558061 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1326,11 +1326,8 @@ void mlxsw_sp1_get_stats_strings(u8 **p)
 {
 	int i;
 
-	for (i = 0; i < MLXSW_SP_PTP_PORT_STATS_LEN; i++) {
-		memcpy(*p, mlxsw_sp_ptp_port_stats[i].str,
-		       ETH_GSTRING_LEN);
-		*p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < MLXSW_SP_PTP_PORT_STATS_LEN; i++)
+		ethtool_puts(p, mlxsw_sp_ptp_port_stats[i].str);
 }
 
 void mlxsw_sp1_get_stats(struct mlxsw_sp_port *mlxsw_sp_port,
-- 
2.47.0


