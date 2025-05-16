Return-Path: <netdev+bounces-190941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCFAB95E8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB291B68239
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114822541D;
	Fri, 16 May 2025 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fcpdEcBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49F223328
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376594; cv=none; b=hiyRrTwQG5phg/ZXknUUEQoxEae+3lBrAjiVMJbhDU/hYUo/SgPMHfKo1vQFnLgdlsDggtIfyjgACMg4mnzjMH9AErgaBVdfhwbO2NS3L9311v0rNmFdke9mSwLdMokX1Kbcc4yycwMB5MI4dYUun6C5dsCkdTIJFM3Vl9Fvmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376594; c=relaxed/simple;
	bh=7djLhBvRkeKVCMCJwc7CAWFlYXM/pr3zm3nApTBdIGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDg+FciKnGHBrC5zTtPJa/TuCpB2w0bbWGsJuos1ZwCvwpe7qDqITD9LcTUPywHfFIhYMOWdwuYvn3iOSYs142tKL3oyUpimab/RHkYtry913ShqzRleS9NQ6Ct2+wO6PoY9Zr/tsmnUyp+cWeR0FZZ5SiHR3PwTdDKDsFrucaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fcpdEcBC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399838db7fso1757134b3a.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747376592; x=1747981392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91sS53x9K40/gNlwhJVZ6vBGCpnRL10lMaDDn0jrpIo=;
        b=fcpdEcBCItuF7lzMZfO90wJoueY40PcSTvUu7MgehP0NlH4aUgVq66mkbkyuetW5dU
         PhenQXSMaK33KlaKvQ2KyQO65fs9SWIxbyUWJcmbUuPB82/L1ZoHr4l+aPetxkS6gtRs
         zjqlfXlr6/Ju0Hoh7yVkbY1OHIksdQSivmwb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747376592; x=1747981392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91sS53x9K40/gNlwhJVZ6vBGCpnRL10lMaDDn0jrpIo=;
        b=OP04fgHtlu1NVzwSuqb5WxRQ3UR4Zr4+VOV+W0Bl2t+3r7i5Gkrz/MSQ4g2iOZGN6g
         9LevFz9sYCWRl6kd+5SbQ7vP+xzE/6VGD+wjfyNIyoYJsdbF6w4bT0wDm5T/ejfV0kMu
         /zlFSIbxshCq7AFUrw93kB6yf8rG4i9ZNxnFOZFkaPMV0CX4lrHkIUBq6BGHq5+nf7HU
         n9o2WM3gurJSQ95Akb0nzHvQK4yxu2Fdxmm36pqvd63fOe8X2S7AdFLsmG/TiBFJUlvg
         DLSFSFDZ7qLMbzFMqYn44wcR9FflWdQXCqM7JGtUQKD9CzfKuBb3h2yVU9R9H0t0Eb7y
         YWag==
X-Gm-Message-State: AOJu0Yxh7wqJb3UK66Skh+l3uUgwmb90oOx55oWeqNJYsHFhJtTHj3+b
	NWOPzrAC0W0mLrP3hpHJzh1KKXjaVNamhVhgIRDbJYD/CfWsy4YLzHZUK2x675v3bkTYFChhzj6
	90EhBcl1vcOHjPcoX++HAgcGBfois6xpxwoDJP5qzfVZnNfTGMmmVEQzyBgdvybFUojUmJqORiY
	NoeWAFJgYaEKu1iF335YFIz9qefirxqPl7nOP23cggeqk=
X-Gm-Gg: ASbGncsDC04gpkl8zOwQDPYxFU0FcboZjfHlbOl1sdCv8PYAduQT5BKa4Y1edbQM3wJ
	+q2tCTS6nyQH8V16tY5ngSSHS8uuMT2eYI5iBfA6lbIX8aXjrQm72x9gNzUpBU/pf9ZviPDq69c
	vNlK+EPSWaI/l9Z+6j3A/FWd9fanNPyUxz4AOggXh8PDP+RBdu3THki/iH1dCJjorQux2t+gs7k
	Fw1KEf+IddnPLZ18HoQAw2vcq0W1/ypR3qztkBMmTDTdc3kHdLvS1RjxPYiMhvj6KIRlxbsCgOJ
	Y8mE7vJ5wRf4QAdVWjrTT249/NPhNbyA9jogCWmjUFxIEFWl25A0rqTyEREGBQwoiaxrun/bt97
	FHDg06rmC5Xo=
X-Google-Smtp-Source: AGHT+IEymG0Hs9Aj4aSM2JFAQrsi7mocElYcrPA68mKddL1UVULiRC5o/kM2Om+UQBQ6+bG24lIVPw==
X-Received: by 2002:a05:6a00:2885:b0:742:8cd7:740a with SMTP id d2e1a72fcca58-742a9a2b40emr2890027b3a.5.1747376591744;
        Thu, 15 May 2025 23:23:11 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96dfaa8sm824501b3a.6.2025.05.15.23.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 23:23:11 -0700 (PDT)
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
Subject: [PATCH net v2] vmxnet3: correctly report gso type for UDP tunnels
Date: Fri, 16 May 2025 06:05:22 +0000
Message-ID: <20250516060523.10352-1-ronak.doshi@broadcom.com>
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
Changes v1-->v2:
  Do not set encapsulation bit as inner fields are not updated
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index c676979c7ab9..287b7c20c0d6 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1568,6 +1568,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
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
@@ -1881,6 +1905,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
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


