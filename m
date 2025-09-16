Return-Path: <netdev+bounces-223606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA78B59ADA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1E7524131
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A73568FB;
	Tue, 16 Sep 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6KdmgCq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7012353368
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034150; cv=none; b=qkhXb5hQA5//+4u03DBgLgb/z1Xw04Hht/4/OzT3o/ppUY3GxZkgQcUdOcyO/n+8HBrahlQQMzMdCTk3tK2XoCnT/c12JByVmdJ8u5AVFnwftA5mv4/0bh0cCHaNNox4vDHW80nDur0WI/f3kpfQVt2OY3DnXReiyimUbDOQiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034150; c=relaxed/simple;
	bh=n9rM8ljiPsRxT7YZn7h7WqIGRhm9YB04I+dcXb6LrzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CByRGIn6VMVJ6NAIOOsHL0IL0Ye2auawY9vHKd5yIkh/hzAUDnxbTwXFZQsy63b5SiOuH5x488IJNUy1OLOxj9h2OH1Ia3vtSC4hIFondYS5nVWDykCLs5jqx8KTllkU/5MovuWoyn7eMYQ5so/q6R5ey3fj/I5dO1m+cAbYAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6KdmgCq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so17225045e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034147; x=1758638947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S71exjaAl1JrZ0u0sjWvFXMtqcyc8pfZy4GJ2KfrLs=;
        b=e6KdmgCqOpRzCJPbJixr0PhQX1fWhXzqyaSPMqF5WWVglYmfFs9pGLjjNgNAKrbR5z
         wmzc4wkY7VVCXW+aXOFpcDuSZR6ue5iGjV2ulOkqvielpFJexd1VyspdNrSQWpE2WHxA
         LeTM9cyUdx+lwPRgjGqPVkWQnugUbWhNogVfkOmpMPiMWd4XuIDNvz5mXrgyq2xdZ3Bu
         9oI+2zyfosx2noc0RA4JaLUDcOe6vUjkPkENKbPjhA0d1udmywFHoKhrCV8laF/005vr
         BFU17QqKBdJAuWfNsmZvfHaRPlcXuAqcloheubuhk3NccwIvXuusY32wMZR7O9gcKNZo
         AF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034147; x=1758638947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S71exjaAl1JrZ0u0sjWvFXMtqcyc8pfZy4GJ2KfrLs=;
        b=k7KVIo3FXvc1HyZY3Xe/T8otyJbqUWkBwzpe54lBCfjizquIR4Q42FU6A6zJLtT2AY
         /F+s6OqE4Mogm8xMDnfWtiHpdot0mtTB0qtiiYLbX9j5LQmJEEQQyPQCBet21ToGlWN/
         OFju13pyFn+g/c312ViEsYcG+q/vUOwanaJP9N76eWYVNUaSvRQQeVm46kulhbSl2Ils
         qVBRz0dsdghe80UbLXyqfPNyJ0ao8dEgkp3tsyk5IuG/x9tf6dS2uw0StZymw6YAdYXO
         VwBA8X/lCGqGk0Mkf7P9zU65VwQePWghb7ZxLGFSJH38ZTxK/qSZdNwXCus8RIoVmoDu
         kdRw==
X-Gm-Message-State: AOJu0Yw+JRTdsRlDegGYLiQfCyOcMWbg8RZ8UoHILBdXq1/96ot0lKN0
	PdDGwJgIOMWySNN9uhwblPMEmS8sxa4Kqe9PKgD2m6IYfmB7oAkHucqBIrd6PQ==
X-Gm-Gg: ASbGncviuIYZuYYtQKHdb5MUTpiGaWl+V/8JuoD60hPngWIHT4h5mNgDWyGxecrqO2q
	OzjVAJVcf8UEC8hIyTehqYhVEl+J+QS9dLsRKzdxBP228XgdehhWBpmJMxdQ4h2D15cig4VPJlr
	ipf88ocsoesr2EBLKFFBXVaRk5zph37BQXBcSafewOrANEvcgcO/UyI5zdMDsVsBvCiONN3NKH3
	N6wu71gMNb3ySe6K34mqPTj/++UsmNY/oRfSR9iIIZuSLY94Zv7B6sxg1i/i1CgrhAt10dgyFua
	sRFCL54ADdk9ljgHtObkNtD3xs62D5HhpjWzYVEfG57Gd/FgYMo4yWMHdmVsqN3xo5C89jms36q
	0Oasoy/gxyt+tAZ2HA26ND2kt5qQPxFhS6g==
X-Google-Smtp-Source: AGHT+IEuRtp53HHBV7e/TdSkBKO4QRmfGlmXG/SEkMDxYLN5hfOwisUiI79nk8Be7ExXoF3x0gPXTQ==
X-Received: by 2002:a05:6000:2081:b0:3dc:21a1:8a56 with SMTP id ffacd0b85a97d-3e765a07e5bmr15268954f8f.55.1758034146718;
        Tue, 16 Sep 2025 07:49:06 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a591a41csm11802062f8f.7.2025.09.16.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:49:06 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
Date: Tue, 16 Sep 2025 16:48:40 +0200
Message-Id: <20250916144841.4884-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916144841.4884-1-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. This restriction is unnecessary since
packets without the don't-fragment bit will be forwarded as-is even
if they were merged together. The merged packets will be segmented
into their original forms before being forwarded, either by GSO or
by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
is set, in which case the IDs can become incrementing, which is also fine.

Note that IP fragmentation is not an issue here, since packets are
segmented before being further fragmented. Fragmentation happens the
same way regardless of whether the packets were first merged together.

Clean up the code by removing the unnecessary don't-fragment checks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h                 | 5 ++---
 net/ipv4/af_inet.c                | 3 ---
 tools/testing/selftests/net/gro.c | 9 ++++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index e7997a9fb30b..e3affb2e2ca8 100644
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


