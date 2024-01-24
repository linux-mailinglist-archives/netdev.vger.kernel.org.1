Return-Path: <netdev+bounces-65385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3283A4A6
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1880C283BB8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD717BDD;
	Wed, 24 Jan 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFfhancB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="55cjuQvq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93517BBE
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086566; cv=none; b=AJPq2OswKYZnfddl/+h2oqIgBwYXkmydVYTdUsaVwjuMv4aeLP+2TMcd2eB501hG5PbKLtjIXTKJmyXeYW1Zv6jDSo1JiIKWyCxHBU4VXQQgAXNnNhgSnUlIKF6SFwiLinNm0CmgNsis/f2KIPU4Cu9u9/RDWcKzpCwK+sEcTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086566; c=relaxed/simple;
	bh=xkpkkpnHRvJA8bXt7lVbIbvKMVPaTud/waVaeW7Nd0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDvfHdrNQlqXGObdESM8oeC3OlGFiTnlaQFgUNzwiWY6fbPK3gJuzAiObTgtHliGKD9iA8r8rH9Cx0U2eibG6paYYrZ5TLhF+AntpIjZvtxq/gw1nF7u+1D3fxzsAtDS8mU6qPTy7inXd6awlva3CXT66VzBRsGiRpQhjuEGA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFfhancB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=55cjuQvq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706086563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPp/GAzZVwAUR9vHijxX4z+k+otb1xET3AboSXDsuRo=;
	b=uFfhancB2J/PFjmfaDHHf4LguVOx++PDLyn3pgraHfLAHnXIJcGpHtvceddr4AhXNcqCc0
	YjsTNh5kF8LQRlekotu5YswL6HhYFn9rYhSbirzhifpfZVkBflrXfpPga7DmFF46NN4CXQ
	PXLSAv3G9lKgcy/pDvc4H5jmsBO/gLkOgWZer3Q0xIwo+2akk+SVD48OCD/n+gMDaCwCWS
	on4tZsUOOXlvg6ABu0ou5NgfH5HIRdGvYzlf9ZT2QDDPaU3RdaV2iqMTv4RW9OHKHhah7+
	jJs41mT0t+2hH7RTjgsKoBkB3M8j5kXmYCQvjqb9ajbgq5BpegA9fzxSSqcYYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706086563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPp/GAzZVwAUR9vHijxX4z+k+otb1xET3AboSXDsuRo=;
	b=55cjuQvqOP2lMJedsCpYr0aIw73IUJWo4bHquqqrE8FxxIqkE6zF+1U655/ej6Ow3Tk4rV
	NYP6+Yw320iLXFCg==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 iwl-next 3/3] igc: Unify filtering rule fields
Date: Wed, 24 Jan 2024 09:55:32 +0100
Message-Id: <20240124085532.58841-4-kurt@linutronix.de>
In-Reply-To: <20240124085532.58841-1-kurt@linutronix.de>
References: <20240124085532.58841-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All filtering parameters such as EtherType and VLAN TCI are stored in host
byte order except for the VLAN EtherType. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 10 ++++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 45430e246e9c..158adb1594e9 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -585,7 +585,7 @@ enum igc_filter_match_flags {
 struct igc_nfc_filter {
 	u8 match_flags;
 	u16 etype;
-	__be16 vlan_etype;
+	u16 vlan_etype;
 	u16 vlan_tci;
 	u16 vlan_tci_mask;
 	u8 src_addr[ETH_ALEN];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index b95d2c86e803..d31a6f027c83 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -981,7 +981,7 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
 		fsp->flow_type |= FLOW_EXT;
-		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
+		fsp->h_ext.vlan_etype = htons(rule->filter.vlan_etype);
 		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
 	}
 
@@ -1249,7 +1249,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	/* VLAN etype matching */
 	if ((fsp->flow_type & FLOW_EXT) && fsp->h_ext.vlan_etype) {
-		rule->filter.vlan_etype = fsp->h_ext.vlan_etype;
+		rule->filter.vlan_etype = ntohs(fsp->h_ext.vlan_etype);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_ETYPE;
 	}
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 91297b561519..c3fe62813f43 100644
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


