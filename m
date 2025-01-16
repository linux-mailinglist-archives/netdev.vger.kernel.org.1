Return-Path: <netdev+bounces-158734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95001A1318A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16F6163FF2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CF2744D;
	Thu, 16 Jan 2025 02:50:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AE1862;
	Thu, 16 Jan 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995807; cv=none; b=RfN/kXEiKMRQ8vX1M8fdIa2wDPBIzp1GXODR6xUH5HTsVErEpU3XN4kNWM3lBIUOYqZcQc1W/RXq11W66Nmvas4ASvyeKuspBrqantjDEiCUPUswWeavOzb2LnfzJhFWzzcw83xLG5I3wNx8x3lNiakGTzsM+AQMbnJzuA9jizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995807; c=relaxed/simple;
	bh=vXJPN5fkl5Edzzx788oumQZZKn0BfcPryAIxLhZ/bzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fsI3c0YapoKOaW4sAjBpek2ACtd0h8qN2y3NbxLkwh94HBjNaURRb5Fqm8gEGa51xOv2PlEHkIFtXf4Xsl38Kw47zL2T8IYRYA3T4KSGRMc92h8uLty0JQn/rSvcYZH5UsztV1n8+XgyFNN6+n3WzllrG76+nte7zQcONgJxugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:0.1690985996
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id 519309F5EB;
	Thu, 16 Jan 2025 10:40:39 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.9])
	by gateway-ssl-dep-84dfd8c7d7-bnxj5 with ESMTP id 15e972f1e60c426da08153c9f1bcac9e for linux-kernel@vger.kernel.org;
	Thu, 16 Jan 2025 10:40:45 CST
X-Transaction-ID: 15e972f1e60c426da08153c9f1bcac9e
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 36.111.140.9
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	liyonglong@chinatelecom.cn
Subject: [PATCH] seg6: inherit inner IPv4 TTL on ip4ip6 encapsulation
Date: Thu, 16 Jan 2025 10:40:36 +0800
Message-Id: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

inherit inner IPv4 TTL on ip4ip6 SHR encapsulation like as inherit 
inner hop_limit on ip6ip6 SHR encapsulation

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/ipv6/seg6_iptunnel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 098632a..2f1f9cf 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -160,7 +160,10 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 		hdr->hop_limit = inner_hdr->hop_limit;
 	} else {
 		ip6_flow_hdr(hdr, 0, flowlabel);
-		hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
+		if (skb->protocol == htons(ETH_P_IP))
+			hdr->hop_limit = ((struct iphdr *)inner_hdr)->ttl;
+		else
+			hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
 
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
@@ -249,7 +252,10 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 		hdr->hop_limit = inner_hdr->hop_limit;
 	} else {
 		ip6_flow_hdr(hdr, 0, flowlabel);
-		hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
+		if (skb->protocol == htons(ETH_P_IP))
+			hdr->hop_limit = ((struct iphdr *)inner_hdr)->ttl;
+		else
+			hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
 
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 		IP6CB(skb)->iif = skb->skb_iif;
-- 
1.8.3.1


