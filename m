Return-Path: <netdev+bounces-77473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A053871E46
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AF61F228B0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F558139;
	Tue,  5 Mar 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="mt+AoL3g"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AF56B8C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639498; cv=none; b=kgxZM7pEcZTVhFmF+1Ke8joJpFW/r6OD+qFdkIzuGZixaaVTylF9oZOSvfgRX0u8uf2RWskZN4qukiGLehNMypgMlPKbt4QRsdEnv8dssiKAEUDQEz5J10GzZoeyPD7NWaDg/YwSrA6EQWrKrT36uqOfVB9gJ7BGlyYjK0r/RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639498; c=relaxed/simple;
	bh=hdywCdU5QjczwDdNTGwSUDgQFAYHa3AYbs82AHxXLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk2EBEzqw/uYDxYumWuOJcga71N4r9vqPddbntWkPoFjWyUX6oqsGl8XNlBMtCSF9a5SR38PnWrjZW237yYGWdcT9U85qJgg3xjgp5E0nXQN/Sctb3lNxbr81r5Pfn9/NYzg6arikVDg10KRzsFv9aruZzT3Oyzb5faokT3rkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=mt+AoL3g; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202403051140585ceb1fc9ca56e92bc0
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:40:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qvtL3ayKKlSubrsdBpQ6nZ8JqPZ87pXDbD3rVFmwH4w=;
 b=mt+AoL3gz9GsjjMnD3EZ/eCRfXl5I/upx5Nhys8DqYc9x/T03VFyoA78SxqkwW1UgP38b3
 ubdkOzILPpkGrQzzsGLXCzi1jAEn48okFeoMnrf9OiAyKMybo5+ykJltyi4AqyrhUHzEuzhB
 R/klpwOLZMhqxUQrQOwIE24EUjjOY=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	danishanwar@ti.com,
	rogerq@kernel.org,
	vigneshr@ti.com
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v4 02/10] eth: Move IPv4/IPv6 multicast address bases to their own symbols
Date: Tue,  5 Mar 2024 11:40:22 +0000
Message-ID: <20240305114045.388893-3-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
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
2.44.0


