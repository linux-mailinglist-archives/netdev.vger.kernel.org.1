Return-Path: <netdev+bounces-219117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8BAB40034
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C371777C9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6F2D46B1;
	Tue,  2 Sep 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nMfmbIsD"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298D27E05E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815147; cv=none; b=SHyQfE5wzOrLHjeTe2PybFSMaG872ErLGwj2ScOdn7F0d1raGlbeeLiyb38WWOWGfI8WMZi3UvsWyyzOjLtxSfGGPyr/x3n8QCDVuXUtyFRCCWczJ+wPz3o9TaGYjoyyFvqJqUMQGRqbt/K+RUQdZVDye65ovQpTTBOkgOMyIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815147; c=relaxed/simple;
	bh=APRWmz2CVcVezecyObScoN4j6aNykKtVIFvh670t9TU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRI1Jk5yN5TROoczdgXPW/6qf5LEymuAuG5YptVH7JWkgnUUaCnflbS+mkEn5YzMxn17FUESOq6UNDjot6Uh5XaaZKQasT6oXQC06KRdmUn4TpVPXcQJT69ds91ViodXfoVlHaJ6QePgjGuS+xkTWrSU+G/Q5QThFGs62qNAS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nMfmbIsD; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756815146; x=1788351146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yGI699wuk6vHc/hrpmAbLfOQPpj7lgSk/hl7k3vQGlk=;
  b=nMfmbIsDvDXdOFHKZj5R8OV8JHee0yph8gl0WbBrW5rTdn0GOSNmUMlG
   DKcoBVCbgKKm08U8qRwGPru6JU5xbpV0HHWfOZL7lXkgm5T30WZzsgSzv
   g0Y9F+sSQ6m8MwcWTwpNB6LqbiH6YnbJ5sVLwyCiPyyWUNxhcEs39+3Xt
   w/2GvyTvQzTdGKo1GNCvduiT0NY64lcY8ooBYxOw5cMW/MdeG63Z6U9r5
   PwjSSIL2VKAzWR3mT7ZOCMlu8m0U9E4F5h4xHLIbgObau/HnoR7R5EgVk
   OzmzqWWzdUTZcdw40rqRmnewpRXFixpvpHZbs6p+EQbU7rV62Td+yV4Mm
   g==;
X-CSE-ConnectionGUID: wNqSDvI5T+6lwxCEfIoqJw==
X-CSE-MsgGUID: +1uQ2K26QiezJA+Djl82Dg==
X-IronPort-AV: E=Sophos;i="6.18,230,1751241600"; 
   d="scan'208";a="2094590"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 12:12:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:58078]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.142:2525] with esmtp (Farcaster)
 id 2bb55826-096f-4a1d-991c-5d36c4e28ae3; Tue, 2 Sep 2025 12:12:23 +0000 (UTC)
X-Farcaster-Flow-ID: 2bb55826-096f-4a1d-991c-5d36c4e28ae3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 12:12:22 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 12:12:20 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-next v3] ixgbe: preserve RSS indirection table across admin down/up
Date: Tue, 2 Sep 2025 21:11:16 +0900
Message-ID: <20250902121203.12454-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently, the RSS indirection table configured by user via ethtool is
reinitialized to default values during interface resets (e.g., admin
down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
Check for RSS key before setting value") made it persistent across
interface resets.

Adopt the same approach used in igc and igb drivers which reinitializes
the RSS indirection table only when the queue count changes. Since the
number of RETA entries can also change in ixgbe, let's make user
configuration persistent as long as both queue count and the number of
RETA entries remain unchanged.

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
Changes:
  v2->v3:
    - s/last_rss_i/last_rss_indices/ for clarity
    - use modulo instead of top-of-loop equality test
    - use ixgbe_rss_indir_tbl_entries() instead of magic number
  v1->v2: https://lore.kernel.org/intel-wired-lan/20250828160134.81286-1-enjuk@amazon.com/
    - remove pointless memset() in  ixgbe_setup_reta()
    - add check for reta_entries in addition to rss_i
    - update the commit message to reflect the additional check
  v1: https://lore.kernel.org/intel-wired-lan/20250824112037.32692-1-enjuk@amazon.com/
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 39 ++++++++++++-------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..3553bf659d42 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -838,6 +838,8 @@ struct ixgbe_adapter {
  */
 #define IXGBE_MAX_RETA_ENTRIES 512
 	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
+	u32 last_reta_entries;
+	u16 last_rss_indices;
 
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 27040076f068..395906cf7de6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4309,9 +4309,9 @@ static void ixgbe_store_vfreta(struct ixgbe_adapter *adapter)
 
 static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 {
-	u32 i, j;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
+	u32 i;
 
 	/* Program table for at least 4 queues w/ SR-IOV so that VFs can
 	 * make full use of any rings they may have.  We will use the
@@ -4323,14 +4323,17 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 	/* Fill out hash function seeds */
 	ixgbe_store_key(adapter);
 
-	/* Fill out redirection table */
-	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
-
-	for (i = 0, j = 0; i < reta_entries; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+	/* Update redirection table in memory on first init, queue count change,
+	 * or reta entries change, otherwise preserve user configurations. Then
+	 * always write to hardware.
+	 */
+	if (adapter->last_rss_indices != rss_i ||
+	    adapter->last_reta_entries != reta_entries) {
+		for (i = 0; i < reta_entries; i++)
+			adapter->rss_indir_tbl[i] = i % rss_i;
 
-		adapter->rss_indir_tbl[i] = j;
+		adapter->last_rss_indices = rss_i;
+		adapter->last_reta_entries = reta_entries;
 	}
 
 	ixgbe_store_reta(adapter);
@@ -4338,9 +4341,10 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 
 static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
-	int i, j;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
 
 	/* Fill out hash function seeds */
 	for (i = 0; i < 10; i++) {
@@ -4352,12 +4356,17 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 					*(adapter->rss_key + i));
 	}
 
-	/* Fill out the redirection table */
-	for (i = 0, j = 0; i < 64; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+	/* Update redirection table in memory on first init, queue count change,
+	 * or reta entries change, otherwise preserve user configurations. Then
+	 * always write to hardware.
+	 */
+	if (adapter->last_rss_indices != rss_i ||
+	    adapter->last_reta_entries != reta_entries) {
+		for (i = 0; i < reta_entries; i++)
+			adapter->rss_indir_tbl[i] = i % rss_i;
 
-		adapter->rss_indir_tbl[i] = j;
+		adapter->last_rss_indices = rss_i;
+		adapter->last_reta_entries = reta_entries;
 	}
 
 	ixgbe_store_vfreta(adapter);
-- 
2.51.0


