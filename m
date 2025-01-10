Return-Path: <netdev+bounces-157022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E57A08C1B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E803AD2F9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993C20C038;
	Fri, 10 Jan 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="epu6HwkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DC209F27
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501247; cv=none; b=DqDIeYNXET72hD/EIibaSlP+jSe3Hx7hgq4N5NvVZdeUAWxPovfOUL/zcfiId6TA/pfcG3FrQ2npIep4jfrUgYDQM4/wVs1eWM64RJVSuMBecTEpk7t74g6ixNa3DubUMmYDH11iZgtiUPqoRYqHvmchuYODSu16GoVdju8HK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501247; c=relaxed/simple;
	bh=4zxWxSdxq5LjIMM1PjmSzSdckbS+zyZXXBZJjamGcY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLYCwpzDuVgNbqbhhAMFwQ4tFM4JjnBmL/nK/A9TJ7ewewTlvwMx5OENFsqmZR+vDuIpvjRN4Zyq/n/h0unfdWvky3jVXP1nzFcecjoXMvhZFgPezYEkOnyW4Y9aa2ShiYs7hoANMvr4CtKlF+/Fw5v1nPI8+dhsuQmNV6tfBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=epu6HwkU; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501246; x=1768037246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWFaiuQZMrgEqcBsf6VsdoSQyFOIKYV9KciZxBb54VA=;
  b=epu6HwkUPolo3Ze71lhgL98ZtCqzfbikaMAfHoxzhVDzQqmioDgtH8sv
   Gwz3+0CKF451R8B4cBmhaA7x8WSUYqoFDdFW0LUNcUXa2DFRXY3E/iBlI
   yflFQoYWhA041V2vEXTEG60ANJDtdLwHDp83UDoqE1S6xUDvRp4tMt/Al
   M=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="453215272"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:27:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:33497]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.12:2525] with esmtp (Farcaster)
 id a5410bb8-b721-49a4-8de6-abe57e0e4a50; Fri, 10 Jan 2025 09:27:23 +0000 (UTC)
X-Farcaster-Flow-ID: a5410bb8-b721-49a4-8de6-abe57e0e4a50
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:27:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:27:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/12] net: dropreason: Gather SOCKET_ drop reasons.
Date: Fri, 10 Jan 2025 18:26:30 +0900
Message-ID: <20250110092641.85905-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following patches add new drop reasons starting with
the SOCKET_ prefix.

Let's gather the existing SOCKET_ reasons.

Note that the order is not part of uAPI.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3a6602f37978..efeae9f0f956 100644
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
@@ -137,12 +137,14 @@ enum skb_drop_reason {
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
@@ -173,8 +175,6 @@ enum skb_drop_reason {
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


