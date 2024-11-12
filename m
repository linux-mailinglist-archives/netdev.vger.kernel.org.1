Return-Path: <netdev+bounces-144234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE699C6330
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF7C283BCE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC831219E58;
	Tue, 12 Nov 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdU1DPir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E67A14C59C;
	Tue, 12 Nov 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446235; cv=none; b=SxKDS1wKfTh/r7sto1ePB01V+U4m3otSrArKsvgrIG2TKDqdscGGX4txpEdnCHY6XFXvJDsHaJkmoRAKY5PuSLIfSdRBPZA+WLgk5RQo1apJLDG0UpGYS6GB1W6RH6UjRH6tPZlhGuSOYU4yoVtObPJ3Gcia4+j5Sl+eCqPkW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446235; c=relaxed/simple;
	bh=X0YWf+h8ieZGjRT5VJ1exWaIok1f7XU+3KsWePw0fpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnEH8wzWzyHnPektY7JvipEqphZgFLq4y19AxRxjsMSH8ZpFcFtiHQkAoaVinpAU3ITBkhgL8oLAKzW2GcaitDbPlvWohfQAiRVXh1/T68JyPyQAoArbZXDjGCRhJ0/p6wkDI+z8yUQXQn/qay7gMvIYdbcmHXcX0ZbLA47MM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdU1DPir; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so5247290b3a.0;
        Tue, 12 Nov 2024 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731446233; x=1732051033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOlSWhmTZoM9MfpTonHTxrwQOwk0sPOQ3zsW5uWb72I=;
        b=kdU1DPirKgxGmEj+VeL4ZVw+2itD00HD5gGUJVa9n/EfTyn5lfFvwDtpvcWRD4uvfM
         qSHkcBRKQgeTX0baS5EMwtFITExVVYnIzZ8YEBqriQFEelxQ5j3iin1vITR5Y/xxoV7u
         uL+wPhpkDNyp5yUlSJpiUMnANqSc5tsubWbMR0mFQ24zaTGdoQya2mDOVvAtapo/wM8K
         19EvMbps7JFKRRlUgT8s4u+F3/FG9lNWEZR3wquQ4o6uM3DeOUZ0GsB0JJpNeSYBfDeF
         5mEme3sioLyzTrqevTzGdTJCxVmNB29Huqxp+xAJUNz2P5xusU+bJW5gs70zIDKgDU9q
         Ddlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731446233; x=1732051033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOlSWhmTZoM9MfpTonHTxrwQOwk0sPOQ3zsW5uWb72I=;
        b=B/O2fSDOiMSS5fEFs2BBH5oQ1aHoSMoOa+/UBiedMYU62bPI0kbST0r+9yAuLsPJAn
         SUx2yq2+istC6hs2hT2pUKmNL3o20u35djQ1uSKDrRuG6lX2OC9BUbWub7SCvg4k/Y2O
         c3oRHiN9JdMemE0E+9Sob/kQEWLngbeUZL5SxNTmxgsdaT1H4WgTo4JrO46RPfHn//Kh
         pXX3K8ovopD/9nFJBK9RMEmMyuC3B/J9RQom/RMek8tinOUc+umGCsLXLK/eDZbmhD6f
         qeacGafvKpVShQTQnXA3tyXm/lfY+9t0N0OMlOCise+9xdUHBwvf4n3f4UpnOJE/rNq0
         9oIA==
X-Forwarded-Encrypted: i=1; AJvYcCVW/eVqaV0BlXqOGmJIs+4TRfp8t/StRuAxN17ejzGyyVoQU52ekq/f32rSaQx9e5sDidC5M0pDw74H/yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+XlkQNwe60QFW0uN45dzngdqU6OuIzPIcjC7gjuFi69pNeVs
	gmqUbnjmCQBm5j0hblI7ZCJ+DqS/6v36IZAc0Crv8bmSSXkUOxVhYxNVencw
X-Google-Smtp-Source: AGHT+IHufLR7aRIE9o/mLbdgiMqoUQ8y676iBucs7fAljSC02byrMUQMW6Gp35HITpVPJPXp5hstzw==
X-Received: by 2002:a05:6a00:a09:b0:71e:1b6d:5a94 with SMTP id d2e1a72fcca58-7241327662amr19585169b3a.5.1731446233478;
        Tue, 12 Nov 2024 13:17:13 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a41cfsm11866203b3a.41.2024.11.12.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:17:13 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 net-next] net: mellanox: use ethtool string helpers
Date: Tue, 12 Nov 2024 13:17:11 -0800
Message-ID: <20241112211711.7593-1-rosenp@gmail.com>
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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 v3: also convert memcpy.
 v2: rebase to make it apply.
 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  |  5 +-
 .../mellanox/mlxsw/spectrum_ethtool.c         | 83 +++++++------------
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  7 +-
 3 files changed, 33 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
index 8b63968bbee9..a430d35d4727 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
@@ -74,8 +74,9 @@ static void mlxbf_gige_get_strings(struct net_device *netdev, u32 stringset,
 {
 	if (stringset != ETH_SS_STATS)
 		return;
-	memcpy(buf, &mlxbf_gige_ethtool_stats_keys,
-	       sizeof(mlxbf_gige_ethtool_stats_keys));
+
+	for (int i = 0; i < ARRAY_SIZE(mlxbf_gige_ethtool_stats_keys); i++)
+		ethtool_puts(&buf, mlxbf_gige_ethtool_stats_keys[i].string);
 }
 
 static void mlxbf_gige_get_ethtool_stats(struct net_device *netdev,
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
index d94081c7658e..a8c0b84ffc28 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1327,11 +1327,8 @@ void mlxsw_sp1_get_stats_strings(u8 **p)
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


