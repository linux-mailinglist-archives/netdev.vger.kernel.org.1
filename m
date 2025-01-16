Return-Path: <netdev+bounces-158760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3D4A132A6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A9C1621C5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9B1487C8;
	Thu, 16 Jan 2025 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lEspPTH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2765661
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005740; cv=none; b=C1LXuDCwJfB8zsEnvHscU5JcVt3kNh0WbFBG+2Okrq46btgq+KfKLTj/8TY/v6nBIddt3nd1EAEsT8dluThM7AToEcCfp7DMM/B6cNhAXaDe0uBCSl/tarN83FrQoXcYLE0yHKY+fZXCsazpq3w1ld/N5l0x6pCTt01462r3gxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005740; c=relaxed/simple;
	bh=/AwykQYl6sfXeaa2EhMRIWztC9kW9ywYQ2XNNVhY/6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6j8c+DTeykv/ZjSdK2TpOEoHBQMu8hFAX0de0y0dYo9mXmp0IrSay8Oe4RsD4r91ZSiXefx3+B8uFp57qmQthHvuTMX0RHA9DRchLQjat07cJ8GgiEHFmO+4RsMhrQeiBmhLXXnVmi0pVE45bmQQaWQAv7McwBYZZJK45XPTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lEspPTH0; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005739; x=1768541739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZzifWng8skhj8xS0mlDR3O4v3gSKpOLde09A7rFAHw=;
  b=lEspPTH0Bd/OdmUwFrY9NM0C0kTFbw6ybckb4tkRWU2yw7Am245Eo1JN
   M/BkJUXCavDGsOwPHuMvvMoTEBFB8FBpx9URz0w9ntUlcdSbEt9tVokqQ
   6Zwf6PJjtiUMtGF8t35GqaZ2u//9ahQ3TN8qDM/lera+znPZxQJ03K52P
   M=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="689608649"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:35:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:5724]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.193:2525] with esmtp (Farcaster)
 id 3efcac21-47c4-4f4d-a8e0-ef3fe398e0ee; Thu, 16 Jan 2025 05:35:34 +0000 (UTC)
X-Farcaster-Flow-ID: 3efcac21-47c4-4f4d-a8e0-ef3fe398e0ee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:35:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:35:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 1/9] net: dropreason: Gather SOCKET_ drop reasons.
Date: Thu, 16 Jan 2025 14:34:34 +0900
Message-ID: <20250116053441.5758-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250116053441.5758-1-kuniyu@amazon.com>
References: <20250116053441.5758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following patch adds a new drop reason starting with
the SOCKET_ prefix.

Let's gather the existing SOCKET_ reasons.

Note that the order is not part of uAPI.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index ed864934e20b..f3714cbea50d 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,9 +6,10 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(SOCKET_FILTER)		\
+	FN(SOCKET_RCVBUFF)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
-	FN(SOCKET_FILTER)		\
 	FN(UDP_CSUM)			\
 	FN(NETFILTER_DROP)		\
 	FN(OTHERHOST)			\
@@ -18,7 +19,6 @@
 	FN(UNICAST_IN_L2_MULTICAST)	\
 	FN(XFRM_POLICY)			\
 	FN(IP_NOPROTO)			\
-	FN(SOCKET_RCVBUFF)		\
 	FN(PROTO_MEM)			\
 	FN(TCP_AUTH_HDR)		\
 	FN(TCP_MD5NOTFOUND)		\
@@ -138,12 +138,14 @@ enum skb_drop_reason {
 	 * 3) no valid child socket during 3WHS process
 	 */
 	SKB_DROP_REASON_NO_SOCKET,
+	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
+	SKB_DROP_REASON_SOCKET_FILTER,
+	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
+	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
 	SKB_DROP_REASON_TCP_CSUM,
-	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
-	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_UDP_CSUM: UDP checksum error */
 	SKB_DROP_REASON_UDP_CSUM,
 	/** @SKB_DROP_REASON_NETFILTER_DROP: dropped by netfilter */
@@ -174,8 +176,6 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_XFRM_POLICY,
 	/** @SKB_DROP_REASON_IP_NOPROTO: no support for IP protocol */
 	SKB_DROP_REASON_IP_NOPROTO,
-	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
-	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/**
 	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limitation, such as
 	 * udp packet drop out of udp_memory_allocated.
-- 
2.39.5 (Apple Git-154)


