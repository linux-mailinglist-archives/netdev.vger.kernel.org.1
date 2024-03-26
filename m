Return-Path: <netdev+bounces-81979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F988C02E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19011C2CC09
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08345022;
	Tue, 26 Mar 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="B+l9ondc"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32B18E25
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451242; cv=none; b=BnFKocHyQnkRZ8PB4gWakhsZoSVyHPWgZD4UgZ+dlH450TmkkskLRXT5uzib8kTGdCTKeo+vSyeQYc4in7yVxbtefbBr84AjxV7/n8gXTW4GJA3bDTyZqCk0cJ85cXRaD1X4DDBJHoauvdzAf+uE8rZkJblC50ZlQnjBg97jwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451242; c=relaxed/simple;
	bh=sRq2DV63g8St9HN/+BaL5vsWuTkHNN87v/Uifd/ch8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+RqQ26ha0SRORhUjP0ND+FT26LCA/NfpUYQzOYt1hVmqWhKnCTNSyT2JG7hqtFWSyEpB1enoMGJWkc8uQIO9aJKQvY6Aood6iBgh79yBTVLhRdKoRFv9ePxWhGctVIWjqj+ielEU/S1ISbY+zocjEO99GOykfctXurbe11c5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=B+l9ondc; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403261107157afea6b9ef19971e1a
        for <netdev@vger.kernel.org>;
        Tue, 26 Mar 2024 12:07:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HX64KQAsn7i4INPY97W+BvHbTmDo0Trf8ITYtWM3klM=;
 b=B+l9ondcpbuM5GXcQ/yt7zQqMt34RvPmYZonQBa+RbIvdlugw5ZvX0Okq6fe4le0KliuxW
 iblnrGO4uIlyz/l4lxHL2s3kpCoi2bEvsoxWcq0lNNREEbjXQ7h1acjqHQTIROSZadlagG/X
 7XGR0osErcN/V4m7Ng06wpngmsUbc=;
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
Subject: [PATCH net-next v5 02/10] eth: Move IPv4/IPv6 multicast address bases to their own symbols
Date: Tue, 26 Mar 2024 11:06:52 +0000
Message-ID: <20240326110709.26165-3-diogo.ivo@siemens.com>
In-Reply-To: <20240326110709.26165-1-diogo.ivo@siemens.com>
References: <20240326110709.26165-1-diogo.ivo@siemens.com>
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
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v5: 
 - Added Reviewed-by tag from Danish 

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


