Return-Path: <netdev+bounces-190258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A3AB5E61
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23691B4589F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F5202983;
	Tue, 13 May 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hTHR6IpW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4C201262
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171371; cv=none; b=IK9ixTUIdJ/xQ68iOyhPXtSLBNhqJnL/11CyWwWhOBVH2Xo8OJNYDXcRwomMNYRFO/8bcWd7fHR0l0aFKIRz+Eb6+5D0RWA6xMACOkugl3gHF2C+fyjFAzOmwwi9Vp3CoQUfVYwUFTHsr0HhaEMSGnjZOaxY4Wf6hQVxRv4uTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171371; c=relaxed/simple;
	bh=uACsEngJrqtCiOncEs7leGd5W0ohwQ6ApDe5Jg0TgUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXS4MOxdcUalnD41GUfyFm3Cp4wmU4mCPiz4QCylQ9+qCeVfcT+m+Y8qMgwsUuX8oZoyJ51OtRyYDLl6kek4zTd0uEAawIP1Q/qZ2cEaaicJz8nRupm+M36WFsLOOrhKh8x8PZTd1NDaxwiT3xty5rN2KBoMW2panFwDa6UEXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hTHR6IpW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2093aef78dso6131440a12.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747171368; x=1747776168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYJ1UM4CvD2cHTAFq/UftrDftIf9OrX1HyqIqL+4MSE=;
        b=hTHR6IpWsd9VEgjiDSSl4jsZnkqgVi6ov52vHVIVylrq9vFLOXszVWAKc682r56SWE
         y88NzvMB1JpYVk6Hh9pegMNN7sKIfi2Owu5YCVMMF7O87HIhZkc7vXyT0VR99KaDYDU2
         6N5x4emVSzrtDqLhB8hztn60+D7hHCwjE2BXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747171368; x=1747776168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYJ1UM4CvD2cHTAFq/UftrDftIf9OrX1HyqIqL+4MSE=;
        b=VSOpxYW+EyjEKtrmhJs7WPA/u/Esqu5O3QZLwtTJj3sg7fPLmhLg/mXk5wZM6rp/88
         AvrpuciH9Br9xvwt4z8o6CNQpZXNU40T1oo+ydkb/uXhMgfnB7n4gAUjiHq1Df/mhexk
         fzYdA98cJefcoDWiZBU8j0sLTp2DxDIxe96aFP1wmsVPgXkcQ2k+ISeSAbV4oapT5XM5
         NvbIZGAdBLk+p/2eAOglht42rYRaZbfM4U2tJ0ixhubjbO6TpYPIYD5fI/Bo0SXi3hXU
         m39ssClIUj+PC65AGsS7bvd3h1sbT7ZYTCfkj0zrn3nS27GMxGFXMU9nn/PUCyJIgRfO
         1qXQ==
X-Gm-Message-State: AOJu0YzQWnW3lWVCji03Hnco9YvxVlmWjuf+O6IBX0z+WLwhFeWIcrIY
	Ycnk5zxJG4bXkiLZwUpBvjLBNtD8FbeDdbmdCKleV9edeyXvDbeDInIpel9JSdodle6oDwAkKV3
	uKUms+sBoTWvK89lALsYj/9LHycyDho+aUtF1rv44OSe6lByQ4mLVHiPFGAqJNCRWH7GUU738NO
	cJ1F9eBwEuHv4DMJSKq29f6tkGxPNIlrgLOU21nTM=
X-Gm-Gg: ASbGncuJHiKdR3RLOyCmf8TWtc7sZK/svUYw8ENehWswB0VpN8BMh8JIZjQM/rtKzat
	MWQTPwMpcfRz5wjkO0iNIitBAuFSf7H13a+SNAVrrRFhHOo4p7cOUR4EnFYoTVackixhQgHls36
	aamid6ptGWG0++nHC82xVozhEskUJOgDgmWj6Cv4Vo1hPTUYdivjaFdhBQlhEKla3jr1opgrMIi
	T10mFzWQPe7gITsefFzj5nXLkbCA3G3S3/R2aWCVSMNE7tw7wWtBZsbWJMp0H2/XmAVMEGHWHVO
	LIQbp6YG9SzNi7mI3jkEwja8TazMUf7fVphWYR4sftyWkncueUdxi9Vv/V+KjfDsZM/6HTP0Mrs
	Q
X-Google-Smtp-Source: AGHT+IECWEHoP0ArEiea9yxSR23+RdyDSwB3kxjTyLdrCRPcJ0E+5OYnGnHew40nur3xI3szP1Mg6w==
X-Received: by 2002:a17:90b:562b:b0:30a:dc08:d0fe with SMTP id 98e67ed59e1d1-30e2e5dc46bmr1627117a91.16.1747171368119;
        Tue, 13 May 2025 14:22:48 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334019b0sm68391a91.7.2025.05.13.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:22:47 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: netdev@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
Date: Tue, 13 May 2025 21:05:02 +0000
Message-ID: <20250513210504.1866-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
in a tunnel") added checks in linux stack to not accept non-tunnel
GRO packets landing in a tunnel. This exposed an issue in vmxnet3
which was not correctly reporting GRO packets for tunnel packets.

This patch fixes this issue by setting correct GSO type for the
tunnel packets.

Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 58027e82de88..9d84ad96ae54 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1452,6 +1452,7 @@ vmxnet3_rx_csum(struct vmxnet3_adapter *adapter,
 			if ((le32_to_cpu(gdesc->dword[0]) &
 				     (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))) {
 				skb->csum_level = 1;
+				skb->encapsulation = 1;
 			}
 			WARN_ON_ONCE(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
 				     !(le32_to_cpu(gdesc->dword[0]) &
@@ -1465,6 +1466,7 @@ vmxnet3_rx_csum(struct vmxnet3_adapter *adapter,
 			if ((le32_to_cpu(gdesc->dword[0]) &
 				     (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))) {
 				skb->csum_level = 1;
+				skb->encapsulation = 1;
 			}
 			WARN_ON_ONCE(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
 				     !(le32_to_cpu(gdesc->dword[0]) &
@@ -1568,6 +1570,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	return (hlen + (hdr.tcp->doff << 2));
 }
 
+static void
+vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
 static int
 vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		       struct vmxnet3_adapter *adapter, int quota)
@@ -1881,6 +1907,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			if (segCnt != 0 && mss != 0) {
 				skb_shinfo(skb)->gso_type = rcd->v4 ?
 					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+				if (encap_lro)
+					vmxnet3_lro_tunnel(skb, skb->protocol);
 				skb_shinfo(skb)->gso_size = mss;
 				skb_shinfo(skb)->gso_segs = segCnt;
 			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
-- 
2.45.2


