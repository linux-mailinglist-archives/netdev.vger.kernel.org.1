Return-Path: <netdev+bounces-237931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A236BC51A3C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FD618E1729
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79284303A2C;
	Wed, 12 Nov 2025 10:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95703019DF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943045; cv=none; b=XckxvMmUHR9HQz2TIHn6fD9ws8qcKvdN+tRlW25emNNECHy5ectoGzLCJgKstsr7pvMcfJf9qyHJMT6JbJJQxjsTcOaxDeVco51Dfs1KINqO7A28CZ0kCIrndVAb4To6dT1BIF+dTwYjsmDCf5RhjNgiExClnL4bGVeLJDLSL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943045; c=relaxed/simple;
	bh=7buZIml+vYNlKuOKSsFWE1hHtW5O4S3qAolR1oHcodI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L43sjnDGbSQHP288n4a5r+dNNoWdYM9ENhyn3oiRCoBLNq9ixXj7UuMybe7EQKb/YtciOztBANhNqpoPEJsTsFjzLxvXi5sJVCXrsnNa06tj+F+ILRNUSQGNjDBtcQWvCm9WvCrFzvWNLQNr16IBU2UH8KGkf23AXsFekFvIJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so412572fac.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943042; x=1763547842;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmjMGG+9uwYrdBaFaG40pgpWI5m/ssDILFCqYef0GKw=;
        b=TskS9QO1QZ2Aa43hSwGL5PSQuzf29icl2690F4run+wVbrCF4RBD6QPldGelg0N0Te
         vGNvkKRvEfX/YnpP7zDEhormDMmCfot2dKF2LprY0eqF3ABO8232fwct1kejWKBLHGOf
         W7ol3/wCkHClb+Cf74oKT6fAxXrdIDY/SLhOncI0zl04vcXdWHq7xwn2jMPtZTapR75z
         ofD4jZdRfz2kRMkBF48uh0hxWkZ4fA2yUvzmH49fMP29d+z6Fp150JXkjxchc1xoaHk2
         GJo9xrDOivrGEAYuO8QiNJAgEBc4XBls3C7YJKQAQl3WT3n2jEpyfoZbeaqXECN0zCDn
         iGtg==
X-Forwarded-Encrypted: i=1; AJvYcCWcsZVZyxyk4T5hSulDlyGtCDJR7Ir0TcSp5dqSzYQNJZSP2JIWWapdHK7v9hv381/ferN5JMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuR6q8IWfeIbFVIAZWElyJ9Nu/O3uqwjHRoe9JhScX3804r6zi
	hsi6PSNvJ0ASvcejg30zKpaeuXA3jAkz95JYJj/eDe03D63T3PrXjeAj
X-Gm-Gg: ASbGncuqi3nKZcevYNVhct8Wqy4KkVTxxjxpnHU0I77fkYhAFsKfe8dniuNE7Mh56CS
	fLIZzHYT3zpcXfAna4cmR6q5eX4BjPwz3sPW1BpG4jGO4lO7tb3JUjQZka8ZDfsVUfagztvqpW3
	LPodSCS3GAfjw6nmrO7yCNZ/qbrJ/ASA1HGnSxvK8ym/0qZr5wpImnFewvaElY3T1bvT3BkybqW
	eJ9Eu8/N7fPv/C6fdZeDFlCo+P6+wVIGN1DYjQA8zQPdN2XfFa4NxDN33yEKukL5lHWfuZbLUfo
	Yj6PVDLHdvgJneUrkKcq6LK/cjG8FBx6BpYUFK6j/zvdCZNemkfbq+s3zAswDAEQp9l2kZefPmt
	UkmpA8z/c9dmsecUULWaLOsuLrgt1Cff57wPiLN+Yo+tUHfccNb4I/ysVvYRYzGI94I/M8RnI0o
	Jf1Ms=
X-Google-Smtp-Source: AGHT+IFFIe5XwMM0YpIX3Lc90l+/3mxxUxY0eH6uX9Bidfv2T/GEpqWLRifC3V1aiew7ppov4DZUmA==
X-Received: by 2002:a05:6870:a913:b0:3d8:9e0d:17da with SMTP id 586e51a60fabf-3e833f7baadmr924714fac.7.1762943041721;
        Wed, 12 Nov 2025 02:24:01 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f1c5675sm9255065fac.17.2025.11.12.02.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:24:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Nov 2025 02:23:04 -0800
Subject: [PATCH net-next] net: ixgbe: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-ixgbe_gxrings-v1-1-960e139697fa@debian.org>
X-B4-Tracking: v=1; b=H4sIAAdgFGkC/x3MSwqAMAwFwKuEt7ZgCir0KiLiJ9ZsorQiBfHug
 nOAeZAlqWQEepDk1qyHIRBXhGWfLIrTFYHga98ws3da4ixjLEktZtfy0m4drx37GRXhTLJp+b8
 eJpczKReG9/0A+T47lmkAAAA=
X-Change-ID: 20251112-ixgbe_gxrings-61c6f71d712b
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=leitao@debian.org;
 h=from:subject:message-id; bh=7buZIml+vYNlKuOKSsFWE1hHtW5O4S3qAolR1oHcodI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFGBAd+OmxF+aCLlLNOP1At7YER2YtTmmHxYWP
 s2PX5WCRp+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRRgQAAKCRA1o5Of/Hh3
 bZpgEACglF3dSw3Lu5l7IIR19b2hXkkRgxiqC8O+6j9IHaK989ZfaP+mdimCb3DPYCTp9bYYUbf
 3hGX8CS/H9UQaESFMunujdFlhXSEIs36x5YoLCrb3QxtEEEsmI7ZQBdr/Ld8lsS5i3BrlH+8U2M
 bYRRQaWrsb0rENrQrfiDTru9l3qZyE2TaXMoZUpvm63qOVmnSQv2vJVwxk+owSDyr8K5FVmUX+J
 EO08J/K2Up72F1ntL4BZf+Z1lcwaajZvD5mjbLTFOXYOrkbYlb1sfNHtYD/Gtq6GTwFVbvK8BTg
 nFR3Gmu7nRcKa9T3HioT0gh2OB5rNRre5OM2BMFH8eJlJfMBDwXe/QPrE+1PXlP+xLHDFNlUaZR
 OVlXIJ+JrCIo2Yg7+unJHVxJE3YfAiejGUPgBfsh/chHUjEIne9Sfeiq0d062XqeY9I+o0DuStl
 V6YVV/NJGXSVCR/OvAYJKEhbIpt5JR/iwWA1iEgPlDGqAmOHfCKCG1NrZ2oGTR4Hfd/XjxUAm1O
 WpepxzVqr1xmJM38mef+S4czustgWXbKuDsgqjdWIlWlmU8FrB4M7xHOYnBdgmXGMB8nCwMYNDv
 D4j4KpU5/WpDPOskzbn9i1CWn2Euk4IRm43n4LN2lDDgOKkJzpiG4cWkFFlZXAiHhSnp9PgEnr8
 ZkSISIkzrjDcTiw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the ixgbe driver to use the new .get_rx_ring_count ethtool
operation for handling ETHTOOL_GRXRINGS command. This simplifies the
code by extracting the ring count logic into a dedicated callback.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2d660e9edb80..2ad81f687a84 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2805,6 +2805,14 @@ static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
 		return 64;
 }
 
+static u32 ixgbe_get_rx_ring_count(struct net_device *dev)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+
+	return min_t(u32, adapter->num_rx_queues,
+		     ixgbe_rss_indir_tbl_max(adapter));
+}
+
 static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -2812,11 +2820,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = min_t(int, adapter->num_rx_queues,
-				  ixgbe_rss_indir_tbl_max(adapter));
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->fdir_filter_count;
 		ret = 0;
@@ -3743,6 +3746,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
 	.get_coalesce           = ixgbe_get_coalesce,
 	.set_coalesce           = ixgbe_set_coalesce,
+	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
 	.get_rxnfc		= ixgbe_get_rxnfc,
 	.set_rxnfc		= ixgbe_set_rxnfc,
 	.get_rxfh_indir_size	= ixgbe_rss_indir_size,
@@ -3791,6 +3795,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
 	.get_coalesce           = ixgbe_get_coalesce,
 	.set_coalesce           = ixgbe_set_coalesce,
+	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
 	.get_rxnfc		= ixgbe_get_rxnfc,
 	.set_rxnfc		= ixgbe_set_rxnfc,
 	.get_rxfh_indir_size	= ixgbe_rss_indir_size,

---
base-commit: bde974ef62569a7da12aa71d182a760cd6223c36
change-id: 20251112-ixgbe_gxrings-61c6f71d712b

Best regards,
--  
Breno Leitao <leitao@debian.org>


