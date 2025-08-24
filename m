Return-Path: <netdev+bounces-216302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA15B32F59
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3481B62BC0
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278F2D5432;
	Sun, 24 Aug 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RLklzLew"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62352D541B
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034455; cv=none; b=JSIcDEnrO7p6AfZmayoEuU9+Y82Ch2toFCDkjyBZ7FLTZl4fHxwkX60JeDy47kh5RMKiY3b/elKp+m1sKJtoeAOrMYbcUxwjBJ4GWpd5AosvboQ5lKCpisp3G9lZLHtO9Ow0IZ5ltC0BwE+L43NfO9Qt86Y3wDrNm5LiZVXbgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034455; c=relaxed/simple;
	bh=RLYd/H2YQiqleQ1J4Ut1KSoCEyu7WDfUVYLUbNshVoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YK2urMSl04ejeFrc0vCfAFwDGOYmCtmU3WkkSV78AKT6SUMVlO4eIXQR7UVqRZZZjtxerKQsK937zd888+cHap+tSDb/t0qY/X02f1NKP/Pwbdh5XRDZj2WROUKkXb01Dz7Ga5iDqc2JjseWytU+jotnhQ3B8gMpGOHDCAcwtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RLklzLew; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756034453; x=1787570453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gb69M0T15EPJVx+owA6vhctBWH7/cBrs83/BAzuq11k=;
  b=RLklzLew1dmiGnbr33p0FzREIicHx0mo1ZIF4iqrU2VBP6ga5nDkX9P8
   mFg0mL5OnHBvqfsjomN76CCelUASKCMkt4rTuByh31ZL2av9ZwVnRdX/i
   K8gJCQCkVcoAG+Vd0QFsaRktQC4QeUBm4hAo2Wa7yvmc7v3XFfIreqIsq
   YLlZ1oeHrMyep2wuawzRgNUWfhBcySVAzR73QM337FxrarRySMIE4K/v6
   0bmnAnvJfQb5T/0Wq+ce5RHHe74y3NhvyIVo2BiA6JJAXwCwCCbz3Pddi
   JddTQDBLbg7Hyi7iJ7U7LnpVD+0u0I4nAj2CLGSRGyC7Ru5buwwG67GK2
   A==;
X-CSE-ConnectionGUID: C9K3J4jhTPur8Fu5fp/OmA==
X-CSE-MsgGUID: fKoHJU7xSNODsEtJ9oCLlg==
X-IronPort-AV: E=Sophos;i="6.17,312,1747699200"; 
   d="scan'208";a="1577015"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 11:20:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:56130]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.170:2525] with esmtp (Farcaster)
 id ef90aa2d-468e-45c2-95c1-34c7315244a8; Sun, 24 Aug 2025 11:20:50 +0000 (UTC)
X-Farcaster-Flow-ID: ef90aa2d-468e-45c2-95c1-34c7315244a8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sun, 24 Aug 2025 11:20:49 +0000
Received: from b0be8375a521.amazon.com (10.37.244.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sun, 24 Aug 2025 11:20:47 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-next v1] ixgbe: preserve RSS indirection table across admin down/up
Date: Sun, 24 Aug 2025 20:20:01 +0900
Message-ID: <20250824112037.32692-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently, the RSS indirection table configured by user via ethtool is
reinitialized to default values during interface resets (e.g., admin
down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
Check for RSS key before setting value") made it persistent across
interface resets.

By adopting the same approach used in igc and igb drivers which
reinitializes the RSS indirection table only when the queue count
changes, let's make user configuration persistent as long as queue count
remains unchanged.

Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
Connection.

Test:
Set custom indirection table and check the value after interface down/up

  # ethtool --set-rxfh-indir ens5 equal 2
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     0     1     0     1     0     1
      8:      0     1     0     1     0     1     0     1
     16:      0     1     0     1     0     1     0     1
  # ip link set dev ens5 down && ip link set dev ens5 up

Without patch:
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     2     3     4     5     6     7
      8:      8     9    10    11     0     1     2     3
     16:      4     5     6     7     8     9    10    11

With patch:
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     0     1     0     1     0     1
      8:      0     1     0     1     0     1     0     1
     16:      0     1     0     1     0     1     0     1

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..d8b088c90b05 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -838,6 +838,7 @@ struct ixgbe_adapter {
  */
 #define IXGBE_MAX_RETA_ENTRIES 512
 	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
+	u16 last_rss_i;
 
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 80e6a2ef1350..dc5a8373b0c3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4318,14 +4318,22 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 	/* Fill out hash function seeds */
 	ixgbe_store_key(adapter);
 
-	/* Fill out redirection table */
-	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
+	/* Update redirection table in memory on first init or queue count
+	 * change, otherwise preserve user configurations. Then always
+	 * write to hardware.
+	 */
+	if (adapter->last_rss_i != rss_i) {
+		memset(adapter->rss_indir_tbl, 0,
+		       sizeof(adapter->rss_indir_tbl));
+
+		for (i = 0, j = 0; i < reta_entries; i++, j++) {
+			if (j == rss_i)
+				j = 0;
 
-	for (i = 0, j = 0; i < reta_entries; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+			adapter->rss_indir_tbl[i] = j;
+		}
 
-		adapter->rss_indir_tbl[i] = j;
+		adapter->last_rss_i = rss_i;
 	}
 
 	ixgbe_store_reta(adapter);
@@ -4347,12 +4355,19 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 					*(adapter->rss_key + i));
 	}
 
-	/* Fill out the redirection table */
-	for (i = 0, j = 0; i < 64; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+	/* Update redirection table in memory on first init or queue count
+	 * change, otherwise preserve user configurations. Then always
+	 * write to hardware.
+	 */
+	if (adapter->last_rss_i != rss_i) {
+		for (i = 0, j = 0; i < 64; i++, j++) {
+			if (j == rss_i)
+				j = 0;
+
+			adapter->rss_indir_tbl[i] = j;
+		}
 
-		adapter->rss_indir_tbl[i] = j;
+		adapter->last_rss_i = rss_i;
 	}
 
 	ixgbe_store_vfreta(adapter);
-- 
2.51.0


