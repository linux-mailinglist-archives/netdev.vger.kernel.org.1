Return-Path: <netdev+bounces-218733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E38B3E1D2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C41E179D92
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486D321420;
	Mon,  1 Sep 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAyZxc2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563733218DC;
	Mon,  1 Sep 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726754; cv=none; b=WV+FR6t3PWS2mHac1h4N2pX4aYyyI9VxPPGgygO5M+zJ6DX+6MSjJQwyRnAcFw9FU6Fol33f9jAXJT1ORHeBxM9G064DMmcs4l8DOsY5rlMIZMPj0nQZ8Lsi5c17X2dIjwEguLFxkZdefhs0qmmXhhn58vVGRkSNBEm0b0kWBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726754; c=relaxed/simple;
	bh=Fg70UMDI0A/Ha4v15Rxc5kAR7mQw/d6wmMqZHv7HOes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSt3ZiZI7V6c7TAsBdAW/EPSBVTuKWYpQhrC3MAVr8pF1cfIIFW2XbsvWW1QcsaihaILScBwAi2bwp0KDI0dAeJ1NRSeUP6zmcren63EZUQkdvkzW5sOD5IkBQSEFI8B/ioRuoYkC+xCsjDWFmjeYPNvi/PTGEWLi/Y7d1XfXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAyZxc2u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso7966145e9.2;
        Mon, 01 Sep 2025 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726750; x=1757331550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AkeP/a1LY5B+ki1hcSlOOd//K3g6cXkwwIDhvsso44=;
        b=QAyZxc2upUNodC8VLefkowRMNYK2XV9JgR0HEKYV1hNHGFsa43nwU4nomr5r+l45WO
         PZgt+bSeHBN3+dlchVXm9KRS58/v2LXsN1BPQ1JnXdsdPHwIXq5Umr5IbkUlL6tKLXxm
         EjfbsGIXJbyPty01Tke9ttWmYOtf42++0WHFB7d8lmZPCWwjQUjRmbRsKDvHAmOsZi5S
         UZISPxaMLZwbN5DQK9utL1n6RhmL7DAdZqmwdJnxtqdBXUm846T0JwfhCLOpnD1xefIf
         9wZE5GFDkKxyG/4Y17BUy7KLZYTyrCmkOp/pRnXMWdv+cWbcbNpBlseGG/U6PfwG2bw+
         HnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726750; x=1757331550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AkeP/a1LY5B+ki1hcSlOOd//K3g6cXkwwIDhvsso44=;
        b=tU37gS+5D13rVKva6ADTTqHgFGRVgZG3AzaM2enb1jawox684kIxE9rgMEX9oHHpOa
         yz0Ra7g2hxKkKFbk4T7DulSf3RROD+77nzMDGWBv5nF1FTRQzcGAYX0D0nP96x7Mcq1l
         SDeCfxKitZm8tTQEvtVQd1Pze2n6sWIeUsEl+SyEn9QvplUgsUrfBGWJv2N7/zGcOb3W
         woLL+qgePo2GQxmSFwlihKzRy3DsISZWZdu4CEW9+qTRpEr+FpkCTEkPlp4VlqQrQan4
         Z4KkeRwwObz/oe3TcXW/ci536TVdnRzJc314a+QkM/6NEkjXK7M0THD+XZiOvpB+9tzq
         L/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDrjkLlYOCICnnVpKSE9CYhZmb+gthrNjnwc/k+sKOyWmvdGw8S9IHhBcAfh0dQAIo5wCCBIdfeeOlzxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKj8/bNv+XVcSf/7QhU2E5dYoYipPO7D2xoxLdwGuVh3V+8Vk6
	/MrjeQM5scPzumqpL/eX5V1ktpRVP6/qupcxhxGtsyFjc6C5ftSQGprr/MOBw+3Ew/g=
X-Gm-Gg: ASbGncsJ/yXRUMlIo0GKgIBCP15POVaX2VumTl0GOYj+hhU2ZB3mvhOTcXOnYGXtI6I
	M3HrA0jHqNe4QRPW3U3+LMxhXBMOyn+2OuHarMNZ2xULMuWMlYyGSQ7az/WuvZjHS+a2XvpAHR+
	0BHIgFK5Ttfd5skxBck5IGl3e02B9OZir02LVEMV/zzPGncaDsEnMY2pPjL2NSc7XWpU3K59gbk
	kVlx/r8gio5lFviFLM9zz51Tdfd//PZ14o/ph64TyOtA5D4jqEuCK2UJSunn0JqkFPPABS4dvLm
	eSuVmPjDv5pYqqOgSIEqucAs14+Vh/+0SfS7lHgRuVy4q+leDe1yREvGLzvMTnYZ4ltg3r5sPhq
	h3H5TdhmvgwTSrUfMFuUf3ulR44Ql6FG8RaMLHIP0sKfnkAx+
X-Google-Smtp-Source: AGHT+IFE8sE+12+BNRGOI9HmHzVnPVmTuEDICSBYnOdb2XNXHV5J2h3HrPsv7ZJevV5VPhBuHDiWMA==
X-Received: by 2002:a05:600c:46c6:b0:45b:84b1:b409 with SMTP id 5b1f17b1804b1-45b855ad0b0mr78570585e9.30.1756726750221;
        Mon, 01 Sep 2025 04:39:10 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d23b7sm152888205e9.1.2025.09.01.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:39:10 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v4 4/5] net: gro: remove unnecessary df checks
Date: Mon,  1 Sep 2025 13:38:25 +0200
Message-Id: <20250901113826.6508-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901113826.6508-1-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. Merged packets are re-split into segments
before being fragmented, so the result is the same as if the packets
weren't merged to begin with.

Remove unnecessary don't-fragment checks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h                 | 5 ++---
 net/ipv4/af_inet.c                | 3 ---
 tools/testing/selftests/net/gro.c | 9 ++++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 322c5517f508..691f267b3969 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
-	const u32 df = id & IP_DF;
 
 	/* All fields must match except length and checksum. */
-	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
 		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
-	if (count == 1 && df && !ipid_offset)
+	if (count == 1 && !ipid_offset)
 		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
 	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fc7a6955fa0a..c0542d9187e2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	/* fixed ID is invalid if DF bit is not set */
 	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
-		goto out;
 
 	if (!skb->encapsulation || encap)
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index d5824eadea10..3d4a82a2607c 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(9);
 		break;
 
-	case 3: /* DF=0, Fixed - should not coalesce */
+	case 3: /* DF=0, Fixed - should coalesce */
 		iph1->frag_off &= ~htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -1188,10 +1188,9 @@ static void gro_receiver(void)
 			correct_payload[0] = PAYLOAD_LEN * 2;
 			check_recv_pkts(rxfd, correct_payload, 1);
 
-			printf("DF=0, Fixed - should not coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
+			printf("DF=0, Fixed - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
 
 			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
 			correct_payload[0] = PAYLOAD_LEN * 2;
-- 
2.36.1


