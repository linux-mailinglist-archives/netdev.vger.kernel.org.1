Return-Path: <netdev+bounces-215527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC01B2EFB1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049297A8F44
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AE2E9EC8;
	Thu, 21 Aug 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClCVskLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF322E9EB1;
	Thu, 21 Aug 2025 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761485; cv=none; b=p4hJt7bv4U2Wr26+4fZAq7fQ8krjkxRKeBozbHI36K0d/dkC6Btmxpt74cePPQFGmuwv2LSdeGuq1OB9ulOhqiT62Va0xWvGv31ZVUDK/HL9jYBLVD0cGILrTaESIwziznyi9d29wbOWdXPrv3kRZEr86tIGvmhWElSdk3MW5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761485; c=relaxed/simple;
	bh=JZmagHQuKvSBsllZFiFSahRnJkw0V5p6muM8F//GSiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqAJVvFOctK/3gerHehQOjYJp/pYnDjzNfjp/PnwIWGk0RjJnfXFB1sWECU2tcKTrrfTZxXEDcpC3XYjXs/Z601h7eSaSv0M0iEQ1/l+VgWXeE8qi47dC/4I+CKHIaPx5hnVV3Z/eDdzXrhKdrigC24KHFVOsZE05WgOYWES2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClCVskLr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so5504665e9.1;
        Thu, 21 Aug 2025 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761482; x=1756366282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH7FpbAGQV6EaF+HQth94hPOIxRixOJNMnh4ewvx7qI=;
        b=ClCVskLrFZrlfgict8kpkq3qPAb5yCcqx4ru0y5576HVbp7LQ9E5Has1TVC1Sm+PM+
         0oq3g8TWpee8GXFgyD2spDtkZQrPP3RWulUOTH9sVlfEyr1bSZkBOFv7ysE/2WyuWwVT
         v0jLkrzDu3BaOOxv/ze9d6oL1S/yKUWxdz3NN/Wjy9m4hJpnOImCoGyNv83HfFSsXkrz
         q8TMQ6NUYybiarpjG18y8AzUJjDO/eDv8jV/toG9UJCnA03SUp6UYcM0TLPxcFnE5bIK
         oO3NdqcihbugctnOuyiYXDBS5ZjYpCtT024w88Vo6IFx+t6PS8jqvwjOqHuENfnQMCtm
         jnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761482; x=1756366282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH7FpbAGQV6EaF+HQth94hPOIxRixOJNMnh4ewvx7qI=;
        b=jm87il1kXzjGJki2XWcP9MGeYsCBK5a0pa6J1JxP06FkHlfABsWm22DwyMkQvHOzDX
         G4xWTTuUawW46D7SpaAnKll54yvZ6FSWLTt+cSedhwLGgcfxPfuPc7ZuBSsfTlC4P4in
         E3qDjHcyyleOhbhAcOAXMaFES4NNoQGUdeZlkylz+1u2KzUOSiwWwMmGW+SZXaXZaz2k
         b1GfmS8bpqceGXsDfuMlP3/eoAmVaYuCzrdOgcpvbrxCsfmphzDsRG6j4A8DEtWkJJ0X
         0dyin4psLsRdUhV8wUVBmh8dn+6NM4UmZ9RYaYSqIgIiQII+W25aikfHjxF7F4IQPqRM
         RBIA==
X-Forwarded-Encrypted: i=1; AJvYcCXBzTM9BFlsV9H0z0EhP3kor/o8aEDEUKVxAZwJIxPLQl0QWIndj6dj8n5k6yYXlF3ula956jo5bHzXGEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPnjYifA76qNrl/sTvnEeO76mp9B31FpYy7Fw03RqQxJf/SWZ
	nSJN5rAcNi1wgFsAHlHtTmkZCVL2WZtnUjgv3Dsu8RwagbQHgPYYetfZZd2rrA==
X-Gm-Gg: ASbGncv3s7yr4gngeB98cln5+4jW6RgrkUYFC8pLQcOX60KDwL6iQLa3UtnmCcUDBFg
	ikmRMGxN3jNHJ/Ac+QuzI6z6WWRahdHFnpBryBAkZlZ8r8MW0VI+FtvJc6QrJdKbl83FWGJFnAM
	6CXv7SFwMr5lmub+s72PPCId/QLruY036g2sXXtx1UJ5n1nGzZAbW/NDSZzdfPh3p/gFMtmIdeF
	h6dTGEyro5pqqF5L94lY52MbQDrzkjXAbynpHj3IX24Gn3EtaV3g9sPoAv6psVSpzPy97KJhBxv
	/R/y0DqA9ktO12+8xDb0RCH03v8Qif/UNbvyJCGDUrxmRvs7BljsuuiKtIw0U5lOT9X3NSWp4AS
	wDrE5Eu+mtUmEpw==
X-Google-Smtp-Source: AGHT+IG0OoLlsMYLQh2dpOrwH2RnOCXzXQ+QmZeWNtpXc3IPtluo+JMaU1Q5JBn99eDNvhM9P4Ffqw==
X-Received: by 2002:a05:600c:4ecf:b0:459:d4b5:623a with SMTP id 5b1f17b1804b1-45b4d7dcc65mr11225435e9.9.1755761481266;
        Thu, 21 Aug 2025 00:31:21 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1ba89sm15837805e9.3.2025.08.21.00.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:31:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/5] net: gro: remove unnecessary df checks
Date: Thu, 21 Aug 2025 09:30:46 +0200
Message-Id: <20250821073047.2091-5-richardbgobert@gmail.com>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
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
index 4307b68afda7..7b66fda5ad33 100644
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


