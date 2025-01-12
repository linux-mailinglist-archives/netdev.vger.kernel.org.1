Return-Path: <netdev+bounces-157488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C146AA0A71C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE894164B4D
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEA1B808;
	Sun, 12 Jan 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J7n2eLYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF06FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736654937; cv=none; b=Y4IvqLImkj1YoA5REYqKSYC1R7VGI1BKdblHyr4Ee2j43ucVmNNw722gER47t+BIl2TlMaIFASq8VekzBMkpXcm/XUFv0zEIRiEzW9sKaR7JAQqVITtzAuu2hdtVbmM0fU5zjoUifx+q0YVlrMDo93IbxORAVg5vEQwg/7i4nJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736654937; c=relaxed/simple;
	bh=4zxWxSdxq5LjIMM1PjmSzSdckbS+zyZXXBZJjamGcY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgokqG8opByekfEhag7rADMJPRhLnYHx5uqNyXXffd05t0AT/rLrB2/qR8NQnHGIW6QtbuMGGO3DuIEp03eBYnLwTCy61ilUCWk3/2h2y/M5wit4VNpg7GU+wLsuzZp9BKUrRjhXLyZkv+m/FwKveWLsWdkf80FJ0jz+wujlGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J7n2eLYp; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736654936; x=1768190936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWFaiuQZMrgEqcBsf6VsdoSQyFOIKYV9KciZxBb54VA=;
  b=J7n2eLYpzSeyYUH+Xx+mjerjnKhyCu12snkvsy4zNMZAKipxPZAzFeuN
   kE2TjikK8pzgeiktGxpfb0N+LAzyKM5uzlZGUB9f1Hz9jsLL9C7/rxRnI
   epH7U3F1ILizMCyUMn9ZY4HN8YuNoGmGeoGmuXj2QC+Ywybd7dNNu98HX
   8=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="458171934"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:08:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:45550]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 6ac21fdf-1392-4f21-96c1-2026f128e608; Sun, 12 Jan 2025 04:08:51 +0000 (UTC)
X-Farcaster-Flow-ID: 6ac21fdf-1392-4f21-96c1-2026f128e608
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:08:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:08:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/11] net: dropreason: Gather SOCKET_ drop reasons.
Date: Sun, 12 Jan 2025 13:08:00 +0900
Message-ID: <20250112040810.14145-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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


