Return-Path: <netdev+bounces-303833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fXN7E+qBRWpgBQsAu9opvQ
	(envelope-from <netdev+bounces-303833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23E6F1C03
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ChJZgRUr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C901E314FE96
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CF33A9E2;
	Wed,  1 Jul 2026 21:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EE3A9D90
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939797; cv=none; b=FfqX8rwQw/qtp5Z374KrnDsPh5cT0u3ZWWG96vysYkzLKQW9zlRXL+JQ0MpIRMpu7aYLVxpcjCvmjMmBDerMhSp/KotAKxwNn23bGDiCBEByJD69PpPO+v7U5uoSoZzKH4ebHohJOfjkGjCZMLzHWPkCQsZS+yPzk+e652Hn19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939797; c=relaxed/simple;
	bh=+puxbYvPgWKP+rEpz8CvQ8DQ22jA7zhyaftvo5+dG/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4acKT0FsVsYD5I6bfvL9iZoQ3u5ru2Bra+Ae+ubzBGcXAGgW/b5xLctwhR2u9uTFiOKsYmvVKxG5OOAJ3NTdRnfaHmaDsrPb9q81RMcOPo6Xaywwtnzrx+k4kVIBolQAp+21JayosHXbPv3YafVevsWJT5X13igDbEI7KCqHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChJZgRUr; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939794; x=1814475794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+puxbYvPgWKP+rEpz8CvQ8DQ22jA7zhyaftvo5+dG/4=;
  b=ChJZgRUrOVXxqELMcV0wQXkRWIXxdnp7Umgvcxr3Mqqu+YJ0vI49xWvs
   8zu+CbIuexYuBcTmWAWzHJBiSxj9in8l/2q4pihYTudXvNgAmhfbaYFmu
   69TtpYHHHAfAVikDQ/Qr6EOzsRK8SUOa9wszc3Pz/TvDnNGfjBlf/dOWl
   /RWhlgld/qZNZTqUFtK4ZH0l8AlM5gZGhZRsYHryXi4qBX3+Vm3UxFW4H
   VMpTvoVKr1OnXvRdXqkwqz9AhoMmPcyKf4c5ZjGkGu26n/NPAP3LH+5td
   iiPA3giINBuS9JzSvF2NjlgYoXf3CQoXXG5JgbM3SmQMax9MGxGxj2VV5
   g==;
X-CSE-ConnectionGUID: UyN8k/FZRmGrD0WKGMJ+zg==
X-CSE-MsgGUID: J8VYE+OyQgevsoKsbLFGig==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069131"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:12 -0700
X-CSE-ConnectionGUID: BlbRffSYQwqLoz1IKixYYQ==
X-CSE-MsgGUID: WKLfyAVaTvmKQqX8Q+LG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561422"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 07/11] igb: set skb hash type from RSS_TYPE
Date: Wed,  1 Jul 2026 14:02:56 -0700
Message-ID: <20260701210303.1745310-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303833-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:kohei@enjuk.jp,m:anthony.l.nguyen@intel.com,m:kohei.enju@gmail.com,m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:pmenzel@molgen.mpg.de,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,gmail.com,kernel.org,molgen.mpg.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C23E6F1C03

From: Kohei Enju <kohei@enjuk.jp>

igb always marks the RX hash as L3 regardless of RSS_TYPE in the
advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
trigger unnecessary SW hash recalculation and breaks toeplitz selftests.

Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*

Tested by toeplitz.py with the igb RSS key get/set patches applied as
they are required for toeplitz.py (see Link below).
 # ethtool -N $DEV rx-flow-hash udp4 sdfn
 # ethtool -N $DEV rx-flow-hash udp6 sdfn
 # python toeplitz.py | grep -E "^# Totals"

Without patch:
 # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0

With patch:
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-takkozu@amazon.com/
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.h | 21 ++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    | 17 ++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 63ec253ac788..9e696d55e512 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
+#define E1000_RSS_TYPE_NO_HASH		 0
+#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
+#define E1000_RSS_TYPE_HASH_IPV4	 2
+#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
+#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
+#define E1000_RSS_TYPE_HASH_IPV6	 5
+#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
+#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
+#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
+#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
+
+#define E1000_RSS_TYPE_MASK		GENMASK(3, 0)
+
+#define E1000_RSS_L4_TYPES_MASK	\
+	(BIT(E1000_RSS_TYPE_HASH_TCP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6_EX)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6_EX))
+
 #define E1000_RXDADV_HDRBUFLEN_MASK      0x7FE0
 #define E1000_RXDADV_HDRBUFLEN_SHIFT     5
 #define E1000_RXDADV_STAT_TS             0x10000 /* Pkt was time stamped */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b7d36dd0b8e4..d4a897a8c82c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8820,10 +8820,19 @@ static inline void igb_rx_hash(struct igb_ring *ring,
 			       union e1000_adv_rx_desc *rx_desc,
 			       struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb,
-			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+	u16 rss_type;
+
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.pkt_info) &
+		   E1000_RSS_TYPE_MASK;
+	if (!rss_type)
+		return;
+
+	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
+		     (E1000_RSS_L4_TYPES_MASK & BIT(rss_type)) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
 }
 
 /**
-- 
2.47.1


