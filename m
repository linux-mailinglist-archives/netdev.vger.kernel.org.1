Return-Path: <netdev+bounces-273367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBHQHEsBy2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:03:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76B36237F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A03343010913
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E53BFE26;
	Mon, 30 Mar 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GW/gEXPn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315293B7B8B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911778; cv=none; b=V11a2hCBUL82rmcR0MjcZUzvsAzmuZ4aw1WqeyJIJyEZ/gmQVOUqqmtJMM/FdXOIq+FSeHpCuPB6N2b7+y+08JPEAp5HNWj6+dcQMv3rbQjk40d9Q3ILr4qE1LHbB6PiLKls7jZk8EjZrv04x+mXB3q2XQAh2We8o/svldXcu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911778; c=relaxed/simple;
	bh=XRCHTHONsT9sWfz1ZM40enneQgywFSHQp8+HjFh6URA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOcGEyme297dvpwsnvT/qEs7FJecLnoQtBWi+XQIc5I9i7Mfz4CUdh9mjFeglb+KJlogDiBithryigKp3CzIGwv1P+PIloQi9kdekcG02w8qmPpQy/7zGRkXK2Y14NnN8W285vosKdXNIa96Trm15VkyQsFWKnoafgsvIq0WWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GW/gEXPn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911777; x=1806447777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XRCHTHONsT9sWfz1ZM40enneQgywFSHQp8+HjFh6URA=;
  b=GW/gEXPn3Xp+I82cQ9Kengj6U1X1oBGk028X0mLwMlkhsM9Ij44e37YB
   pTUJgjWAfeYkUrH2koTKPt8zhhg660kSHfgMiLj6u9TbxW44+xkndxPMH
   /UwE+DGU7xiEj8wvz/f8KP5tGU/DpHbEeSTwsEWx0GCmv+UQE+kHNj5zg
   Se7Xznm7c4GqFXfmtlrJmejjhdDlxHdDokpfmpv4LmsL8Z+3oAAcJ1Hn9
   XUwiGfqUC7b5TIDkEYMxB9gQVBers7DI3b2cPObCs13rEOQo+MKJciZwI
   C+7Quz042dP3zLBUo3EqT1cKjbKvhmhn/jqTlEzoVzjONRu3X14ahf+a/
   w==;
X-CSE-ConnectionGUID: qxZEvwUJQOibdphfG/jnQA==
X-CSE-MsgGUID: 7BXKJjbnTUOtqtePm7xBnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297578"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:53 -0700
X-CSE-ConnectionGUID: 4PJ8bdafRuG6WK+ggjNB5A==
X-CSE-MsgGUID: PpKRsL0zSdaEeN2cB1piHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687717"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	kohei.enju@gmail.com,
	horms@kernel.org,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 05/15] igc: expose RSS key via ethtool get_rxfh
Date: Mon, 30 Mar 2026 16:02:34 -0700
Message-ID: <20260330230248.646900-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273367-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,enjuk.jp:email]
X-Rspamd-Queue-Id: 7B76B36237F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kohei Enju <kohei@enjuk.jp>

Implement igc_ethtool_get_rxfh_key_size() and extend
igc_ethtool_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index c2300232c8b1..abe8eb695c2a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1502,6 +1502,11 @@ void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 	}
 }
 
+static u32 igc_ethtool_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGC_RSS_KEY_SIZE;
+}
+
 static u32 igc_ethtool_get_rxfh_indir_size(struct net_device *netdev)
 {
 	return IGC_RETA_SIZE;
@@ -1514,10 +1519,13 @@ static int igc_ethtool_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->indir)
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 
 	return 0;
 }
@@ -2195,6 +2203,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_rxnfc		= igc_ethtool_get_rxnfc,
 	.set_rxnfc		= igc_ethtool_set_rxnfc,
 	.get_rx_ring_count	= igc_ethtool_get_rx_ring_count,
+	.get_rxfh_key_size	= igc_ethtool_get_rxfh_key_size,
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,
-- 
2.47.1


