Return-Path: <netdev+bounces-140195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F29B5814
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A621C237E7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462820CCE7;
	Tue, 29 Oct 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEop1uBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2120C007;
	Tue, 29 Oct 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246068; cv=none; b=vBd66lIIxVAiLlZat/7bQEkRWiYidkx7aIfQVJoDPSa1gcf/IG8F30gJtS2eaG5WA4IaBJc9/WPKoDMhpIBS05qIdlRLwed0+Jvbq97HROt+6seetM7Ju0eCBoa6KE1rBJJzomkewELmhuQlzcEarO3lXa/Fipx0T6P+7559QH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246068; c=relaxed/simple;
	bh=+jk1QMzOTZtBYMP/q2NTsPJzOgFOE9tEIAs05XzVySo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F20cXAuOvi0yo2IBeDaBF5eh+AV9f1YoP1DaliH2iXuUx+h1fQRv5QxR2xGR5MgxCJfUau4QSyzLJs39cw6s+nDdSb24Mn9LmFbp6/6pvMrVl+G/3n5XV0BBZuLcD5zpa50tpKaZxEJJcp9Q2dgoap0BfuhqgVfmVT/HZoxANkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEop1uBn; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5fb8a4e53so3193618b6e.1;
        Tue, 29 Oct 2024 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246065; x=1730850865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y70wMBiVAGL9fqgd1kG53Hy+fEJEd58QyxNQyN50KVM=;
        b=dEop1uBnKypP69t9iovz6hM7VEsJ+ei64etnDxxp2ipl3ybMj0JFUqiwG55Pwsobq8
         8jlkQ4jrIGHO8rcorQ/0dZ1XaRkZDakRA+S+WTq5dK/0Jjeo3rnXD5jM+ykuO/mP4Pvu
         irPIEL8tNDHXoL1a8LAudodBemB7t57/ert6h5SkUh8DBkp07TwPUvpliyWWHa1R0jLb
         v6BfrDKXWYl4mLw7e07nrYPeDzm2A8e2sSU0tYHKR7jBGp/5oJ4OpxK4jSouB69DYebu
         cMUgZgpSmQY1YAlePGn5finc+EZy2QL9YI0VstUuSQYN72GMC7QYQYrEmZwJz63twTAF
         tpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246065; x=1730850865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y70wMBiVAGL9fqgd1kG53Hy+fEJEd58QyxNQyN50KVM=;
        b=KHvArxZSbawTMnxSsehjs7ErHm/gIBwtYObJFn1KnNM1xvI3ACdd9Y7uzzGZpRT0lS
         MRAWs1+adsMXhOix3osR6Hc1e79p2eNZLVtWerSEf6LRvtkytCL8rw9DQlzNI87/l+0R
         aj3+NGUr775wydmO78qE8FD7WHWdd1D0MDKCUUlXRyxsub89DDVjeT7BUlTqtIueHGJH
         hc8YLP7hSGBTCf6td+uQ5kxGWXCmVuooySKU7x6PQotxiSy0qrUbEOeRGuB508UOVnXy
         7+qYezxRuvQQdY6SLCy6FvX3tIwTFC4YDT8LMcp+9FTtvNldl7Njkj61vHUJS7VQ4rnS
         +Bvw==
X-Forwarded-Encrypted: i=1; AJvYcCVWhDeJ0oyDbyJ9ExKESOEsMGofwy1WGkBe6EzFpG7XEtipFbQeuLhgg6kyTmmb532tquzlpxiwGmR3zZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaF23pKoMyX33b7j2oPhC7RMErrTyw+iw3oL3utLd5BZ3oRHl
	ADawJVfjHfOOf57dnczGWhsxA6nck6BEbVf5Ik49wofCgPmqOVvCEB946PGD
X-Google-Smtp-Source: AGHT+IG5jsW1ZIxd5A20Hy9uTS5baiO6/Icymaefvnasz6tRepiv8jsRGrr+Fak9c31k6PLdTCh76Q==
X-Received: by 2002:a05:6871:720:b0:278:25d:d473 with SMTP id 586e51a60fabf-29051b193f5mr12284231fac.1.1730246064845;
        Tue, 29 Oct 2024 16:54:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8660f82sm8192972a12.2.2024.10.29.16.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:54:24 -0700 (PDT)
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
Subject: [PATCH net-next] net: mellanox: use ethtool string helpers
Date: Tue, 29 Oct 2024 16:54:22 -0700
Message-ID: <20241029235422.101202-1-rosenp@gmail.com>
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
 .../mellanox/mlxsw/spectrum_ethtool.c         | 83 +++++++------------
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  7 +-
 2 files changed, 30 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 87a51e7d4390..5189af0da1f4 100644
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
-			mlxsw_sp_port_get_prio_strings(&data, i);
+	for (i = 0; i < MLXSW_SP_PORT_HW_DISCARD_STATS_LEN; i++)
+		ethtool_puts(&data, mlxsw_sp_port_hw_discard_stats[i].str);
 
-		for (i = 0; i < TC_MAX_QUEUE; i++)
-			mlxsw_sp_port_get_tc_strings(&data, i);
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
+		mlxsw_sp_port_get_prio_strings(&data, i);
 
-		mlxsw_sp_port->mlxsw_sp->ptp_ops->get_stats_strings(&data);
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


