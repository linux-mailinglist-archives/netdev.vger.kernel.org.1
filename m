Return-Path: <netdev+bounces-86210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854089E006
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9401F2417A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A713D880;
	Tue,  9 Apr 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="P8sCLLQl"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518B13A3F8
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678910; cv=none; b=Vq1JCngFiqG4o5arM8+ePcAMjx1W0+aXAQ98XtFxAwNWlySWTjsDp2UcKLcQ9kFsXRNkAQMXD44NBS4SX6UK8qofu6POi4uZhN6u7AtT3yfIdYogv4En+4rQwn0V1lrIGkl6NcyEW7BrEJY1gRvWZZTq9CyIThiwmrw0xAGIL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678910; c=relaxed/simple;
	bh=9wOZKcfYb1DHXSdbJBmLH4+aODCdlyhybGA03BNw6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgutzSR2fCojvRim2grSWkv5sxTFSvgFDFA/EY81B13zLcmIVHdQn3HTBNs/OWFOs/U6g0BlEO77d2CgR+xbLle0Lh8EcZhLIF/Luyz8SNFhMI3RH8eQZQeenTRTLK8QVgSkjWUSTHv0F0GRUgPy0bFIBOjCTiRPsuLuL0/Dlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=P8sCLLQl; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202404091608177845470ce10ca661c5
        for <netdev@vger.kernel.org>;
        Tue, 09 Apr 2024 18:08:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5bZRgZjFamHYpcfAWiC6iNhqiE1pqmA7ylXM2ybc0E0=;
 b=P8sCLLQl6eRPwtBVh87kSHrNQC7D9No3pKWdFkw6DJ60p4xAu4fSf308U/fxa4dV1apWM7
 HReP1ixUcKdbmSN1qFOSrgW4DUbqr/s/JN88Hq9ReOiaRn+OhiBZ4u1UzQVQUV7F2cmvsSdV
 eT4lFjlAd9z1b9FSP5BbMRwPfLCyQ=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next] net: ethernet: Move eth_*_addr_base to global symbols
Date: Tue,  9 Apr 2024 17:07:18 +0100
Message-ID: <20240409160720.154470-2-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Promote IPv4/6 and Ethernet reserved base addresses to global symbols
to avoid local copies being created when these addresses are referenced.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 include/linux/etherdevice.h | 10 +++-------
 net/ethernet/eth.c          | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 8d6daf828427..6002dabca0f8 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -67,15 +67,11 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb);
 int eth_gro_complete(struct sk_buff *skb, int nhoff);
 
 /* Reserved Ethernet Addresses per IEEE 802.1Q */
-static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
-{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
+extern const u8 eth_reserved_addr_base[ETH_ALEN];
 #define eth_stp_addr eth_reserved_addr_base
 
-static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
-{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
-
-static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
-{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
+extern const u8 eth_ipv4_mcast_addr_base[ETH_ALEN];
+extern const u8 eth_ipv6_mcast_addr_base[ETH_ALEN];
 
 /**
  * is_link_local_ether_addr - Determine if given Ethernet address is link-local
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2edc8b796a4e..8141e5c7e4f3 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -63,6 +63,21 @@
 #include <linux/uaccess.h>
 #include <net/pkt_sched.h>
 
+const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) = {
+	0x01, 0x80, 0xc2, 0x00, 0x00, 0x00
+};
+EXPORT_SYMBOL(eth_reserved_addr_base);
+
+const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) = {
+	0x01, 0x00, 0x5e, 0x00, 0x00, 0x00
+};
+EXPORT_SYMBOL(eth_ipv4_mcast_addr_base);
+
+const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) = {
+	0x33, 0x33, 0x00, 0x00, 0x00, 0x00
+};
+EXPORT_SYMBOL(eth_ipv6_mcast_addr_base);
+
 /**
  * eth_header - create the Ethernet header
  * @skb:	buffer to alter
-- 
2.44.0


