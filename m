Return-Path: <netdev+bounces-225154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA8B8F9AF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE34B2A06B5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F472857FB;
	Mon, 22 Sep 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geQiTDOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF85278E63
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530495; cv=none; b=XurCh9cm9EBUNi2lXLPVa9KxfbnIoG36PTU1bpx+dHnEb13rHeNNOOrc7i02+ANW1OeB1t8O6vDONRDZA92x8LT4r43gNnrXn79yMJ3JLLRp1LsC7jlsRMGWCfWgDCBuLtUkPGS5RX3o76iZgfLl0QKI4Xu+L9lLqhfJ+cQ0OGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530495; c=relaxed/simple;
	bh=FnSCo1u0YAYhyXjCE72+PSsG+c5VoZXcmKImeHXt7po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWWahurxqEyCoK5kNJNBtr9ZJqmo0qTzMJjyHy8t3m3ZUhd4fFmws8oDL9jhx5A+4TVDQdxHPHEHILlThRNv+hufBRjWPPOfuHG2Dv1skoRFvSjDC9FAWNWuvlI03lm2D/cgp+P5JR9q9iy9Ln6NYBrdxmJXVVSSCfu4JewASY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geQiTDOM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso49564995e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530492; x=1759135292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbhWq7bacMfDhovko3bwV20Gk//EeQX7vpI4G5CW2zw=;
        b=geQiTDOMyvstNflXSSidKy9dQKkHoaALW5wbUeX5jzMak6xQvZpd5HNApLdhWyhVr6
         11n0IuIYPZgbpX95yty1qrm/utLodelZENLTLrfssj74mqJQ9Qxri32ofyzH8Vfusfgh
         o4y1vRrhC4DAER7oDfvgQmdFwz7eV0HhqEwgHMGX5t3kzWiGNp2c2myzHeS9hpzG975G
         YrSjlFhOXUNb+sWmrbZb14+xjgnhV5+Zvqo30/wpCIpDAfqW5iNwy36963I99hOQ48iZ
         p1wh7bUOB0JS02gwnrxAPI4yg/2SCezbFnyMFAw3PPLTFlaOx5fAFaFD1PDMGnw2X1Ne
         MBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530492; x=1759135292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbhWq7bacMfDhovko3bwV20Gk//EeQX7vpI4G5CW2zw=;
        b=IXoa+f6c9cJTcVIHF+Izdk/Y/Dk0EW/wNj+gfFYF3kWquLo88Pnb98QmCmtcDpo/py
         fxCelTHd1+V3u+lt4xJRd+TXSHlZJeZPnB7i2FGzvLMoqB4v1Dyzo+wkG8i0/zfAjm6Z
         8yH0AhQYVeqEEgSiWa45ITqWC0VsbFauJYTxVtmdaNEs56ts126Jnifn8f099MGAwX2i
         rHp0Z/v5czb9h+fXQfnj9jxClFwqIdn7mq7dDiXFtV0q8ZVCFqzp7n1HX7yymVEhLysq
         ba8BVLLQM7BVnfWjEdNpfAK5+rzvZVqoSvkExS1VKILWIHbXB8ixk4Scn+s1K68/Pn0d
         dn8g==
X-Gm-Message-State: AOJu0Yyc7GXek6SWmOAzO2pKYaRgjja59BF2I+md9jydW4OXXjbleqTo
	sjaJ47+rYh5IbtHWm/d5EXebRSJ5WdfrgpUX/poF0sxE0n3CQi+nDftjK6JGqA==
X-Gm-Gg: ASbGnctV64STN/8BHSqfksaoyXItzizJT0Ngm88N/yToPYlkigMeT6PJ7TOINjnrPuW
	DXK87EjvdlUopHaGBjF98J5JVOutkFlVESciZBAL2Ss39B66XWwBa8XLGm/GZLm1FIDxuZrXQDS
	9gOr9nGELDP9dGwEj1B3xmUe05rvuWoPlqQ5SIFK2ErAK5odN+t3PR7ZLaN7sWoCAxDF/b2rlm7
	/4b/jwnwDg2alkQTSArNf5EozjjjYpj2SDPVTobOHQRi6k3x7vCSzeF/9KUmf5PbbbdjXUOy1OH
	Cqpp2xxCfzebnQytTQt+b+dfBVMGaRc+A8BFQEFICN6V1v2dlx12FbaaWE+dQri+JXh/PsPSZMP
	Sebyk2wLN/EHRTC2KxQ2zmUngEGbjJssRFA==
X-Google-Smtp-Source: AGHT+IH3SbqIF/VHujV0kvfVrh1tmvGWN3BulB05/CGMB041QtTOt1ISeqjex9uogZEaAPqqprEmdQ==
X-Received: by 2002:a05:600c:c04b:20b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46886e0de83mr77577125e9.4.1758530492088;
        Mon, 22 Sep 2025 01:41:32 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46dea20f833sm13661605e9.10.2025.09.22.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:31 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/5] net: gro: remove unnecessary df checks
Date: Mon, 22 Sep 2025 10:41:02 +0200
Message-Id: <20250922084103.4764-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922084103.4764-1-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
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


