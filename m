Return-Path: <netdev+bounces-51570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55E67FB324
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051101C20BE9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F814F9A;
	Tue, 28 Nov 2023 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2lCV8Mu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7H2cdiW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F50192
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:49:12 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701157751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6pxk/1AJpdk0UvXa9I/SEQk/kd1wn7KANNObjsQtAw=;
	b=j2lCV8MugqOnNP4gJ1Y3xqc7kUFeT0t3Hf0MxkJSjbDsAP/mV+1hOs2d2KzDCB90SmYQ06
	SuMKYoQCFXs45D8H6ucvlp+UEBmESLZB3yv6d1cz0xbWKF8dkRGUxfNo1F5Grj7NkusvkE
	6cS2O2r1yVVt1Wlg9OvXMY0V2OM5P2Q2JzRxGuK1YsVLYQqdnJHDV7M2fR4Fd+0LOSRRIB
	jnNitZXNc3k/bKzxFYydzfQe6sdqzcuyh9Nrg67u/WHx0XNj02e4b5maKy/v/v/bOAySmJ
	CpxdeAjBMxJ02jL2mlt5cRmXYXcu5nVWO1di1NRIDuZFMqBNZHb7Wtc6livONA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701157751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6pxk/1AJpdk0UvXa9I/SEQk/kd1wn7KANNObjsQtAw=;
	b=Q7H2cdiWcOE7rR045PKhVIa4CJLzPOLi1Q+HZxHjedTpsJvnBKVsjHwWwRkqtOGXigAWxP
	fQ3LTY+HXpkAPXDw==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 3/5] igc: Unify filtering rule fields
Date: Tue, 28 Nov 2023 08:48:47 +0100
Message-Id: <20231128074849.16863-4-kurt@linutronix.de>
In-Reply-To: <20231128074849.16863-1-kurt@linutronix.de>
References: <20231128074849.16863-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All filtering parameters such as EtherType and VLAN TCI are stored in host byte
order except for the VLAN EtherType. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c    | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index ac7c861e83a0..c783355f99be 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -585,7 +585,7 @@ enum igc_filter_match_flags {
 struct igc_nfc_filter {
 	u8 match_flags;
 	u16 etype;
-	__be16 vlan_etype;
+	u16 vlan_etype;
 	u16 vlan_tci;
 	u8 src_addr[ETH_ALEN];
 	u8 dst_addr[ETH_ALEN];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 785eaa8e0ba8..8e12ef362b23 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1243,7 +1243,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	/* VLAN etype matching */
 	if ((fsp->flow_type & FLOW_EXT) && fsp->h_ext.vlan_etype) {
-		rule->filter.vlan_etype = fsp->h_ext.vlan_etype;
+		rule->filter.vlan_etype = ntohs(fsp->h_ext.vlan_etype);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_ETYPE;
 	}
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4c562df0527d..c4dbb8c50a4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3614,10 +3614,12 @@ static int igc_add_flex_filter(struct igc_adapter *adapter,
 					  ETH_ALEN, NULL);
 
 	/* Add VLAN etype */
-	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE)
-		igc_flex_filter_add_field(&flex, &filter->vlan_etype, 12,
-					  sizeof(filter->vlan_etype),
-					  NULL);
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
+		__be16 vlan_etype = cpu_to_be16(filter->vlan_etype);
+
+		igc_flex_filter_add_field(&flex, &vlan_etype, 12,
+					  sizeof(vlan_etype), NULL);
+	}
 
 	/* Add VLAN TCI */
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI)
-- 
2.39.2


