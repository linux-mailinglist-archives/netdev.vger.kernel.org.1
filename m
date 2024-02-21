Return-Path: <netdev+bounces-73736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A798385E0F6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11561C22B37
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0180C0E;
	Wed, 21 Feb 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="QkSvcnwO"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DD80618
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529077; cv=none; b=DeQEbjuQHC96qP4MiGV8iiXlX6Q+UPfPf2qRDUDwVAFkBaGKfhEj+OqqY6HJ6AzCVrUNXXL+N4LhxqHPQ1P1gHZYF1KCcBsYC+TO9+lVmwq49lXpiPtwePvoikPhOKTeEXZDuoJOy5jV9qvXGMhkfk/euBH979fNQksj4k2POgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529077; c=relaxed/simple;
	bh=TQOb9Of8X1H3eqhPLYoRWQOc+hNXfESCZ6d7cVcd304=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvR9iJ83ugDe0VHj4AcGNgjEtHdTmCwb4bSGWX6ZUY9FSpwV4WtjHhEQt4xk9h/jr+BCqjZ5RIDV4jYwYfe1Ck+ijIIYmPD2R4K1S+FFunYBGNV5xLc9A2o1WYVRDFSDSJscTw0km7jJtI1uk4ixNXJCVevpO2G4gLMI7fkUKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=QkSvcnwO; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240221152427048cb162c016e594e1
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PH86O70n9PAo6m+9r0hGHKKq6MdodokMjWLF2BavK/U=;
 b=QkSvcnwO3UQVa/5vleGe39yu8xEeIyfj5A3IpdF33vPhlXQgDmv4peszUSiScaiedQvBWX
 7iWGB+Z6Vbe1FbjI6107+KbBFEF+MYiRVeND9JKh2QndbaOEbcqBLctKn2aleqUj5zBOxieD
 ht/mQLtjJJC2rRxPXNkMiETECQfI8=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v3 02/10] eth: Move IPv4/IPv6 multicast address bases to their own symbols
Date: Wed, 21 Feb 2024 15:24:08 +0000
Message-ID: <20240221152421.112324-3-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

As these addresses can be useful outside of checking if an address
is a multicast address (for example in device drivers) make them
accessible to users of etherdevice.h to avoid code duplication.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 include/linux/etherdevice.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 224645f17c33..8d6daf828427 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
 { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
 #define eth_stp_addr eth_reserved_addr_base
 
+static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
+{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
+
+static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
+{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
+
 /**
  * is_link_local_ether_addr - Determine if given Ethernet address is link-local
  * @addr: Pointer to a six-byte array containing the Ethernet address
@@ -430,18 +436,16 @@ static inline bool ether_addr_equal_masked(const u8 *addr1, const u8 *addr2,
 
 static inline bool ether_addr_is_ipv4_mcast(const u8 *addr)
 {
-	u8 base[ETH_ALEN] = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
 	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0x80, 0x00, 0x00 };
 
-	return ether_addr_equal_masked(addr, base, mask);
+	return ether_addr_equal_masked(addr, eth_ipv4_mcast_addr_base, mask);
 }
 
 static inline bool ether_addr_is_ipv6_mcast(const u8 *addr)
 {
-	u8 base[ETH_ALEN] = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
 	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0x00, 0x00, 0x00, 0x00 };
 
-	return ether_addr_equal_masked(addr, base, mask);
+	return ether_addr_equal_masked(addr, eth_ipv6_mcast_addr_base, mask);
 }
 
 static inline bool ether_addr_is_ip_mcast(const u8 *addr)
-- 
2.43.2


