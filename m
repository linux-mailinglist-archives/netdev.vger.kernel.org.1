Return-Path: <netdev+bounces-214876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBCB2B986
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6987F585126
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716D26C39F;
	Tue, 19 Aug 2025 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii5m1Gut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872026AA88;
	Tue, 19 Aug 2025 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585191; cv=none; b=ayVNx+WBob8pRhi3UGjkmthXHXUaFaGFODdjWP0ltQEXeVEdXZXl4JDJT4WG1EGnsUg+wrwPjNykcXJqOAT5g6TxO8lI3AozlqgAmdu0x/gI7C3UinMHTdo8RUi5FOoGbcV/GY+UOI9hS42HcKJS1jkQsVifnClvMhELfjanwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585191; c=relaxed/simple;
	bh=3mc9d2A6u3r3oUg0hEgXlYh1GPhKCuMUPAX7+Fzff5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbJ7zimdMyKWS2IkW1j6T7eVPO/k8S+KG7xwEzHSOaWGbAmuagRPVLYzDFftrRIH34bKJSt/mPI5OCYUkZ+J4bMidYnsynHPsuoItk1UGW4cgbPOtYfT0PZjxmh1yG5oYMw7KGRYBgJsWMRaunRd6jPAlUAjlfGjuzdgJWKB/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii5m1Gut; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso32456835e9.0;
        Mon, 18 Aug 2025 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585188; x=1756189988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuRJoY3GNkyWfDlJezuldyXpAwYPVRBuFKt2MQIP7HE=;
        b=Ii5m1GutsgaRS1pnoz6nc8c7BkdVC8Kn6zxHtp7Dq68bupSadPRaceZFFLEezDJH/o
         ziYWqangE3pBLcGqJMaJgEMGrfdwv1zGu+yrOT3EXVfbGjbHd7MXmrQ6566g57QeD4CM
         ZWw7uebTzRxKlE1+sD8xG277MCoxXS9xcFpSpYnzC3dG8oTKgeoMPcj9eL6jD67lwWdV
         0yRx5TcNHVX9RSlSaLMdVqhIsds/YtQZXmYvh7onesDFsUFATh8fugSuCynwo6Gztrxo
         UJOXBp1L7li7+RyGp8HLE2Cmy+H5xNX6C9gKLPapNfv28UlqLQRxmwvzNfHzwEjBZaVd
         lC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585188; x=1756189988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuRJoY3GNkyWfDlJezuldyXpAwYPVRBuFKt2MQIP7HE=;
        b=rJarQNN7TJkxTXt5Fby97MTtU3TQ1c0XGX+uNxph+oDJip6iZrYmoJ5OQVL3bt4h7v
         mZU0hwP595YwAErkCRmkzW3cCdS3n4Jyhv/WRXrOMT9ZdDbe/LPfjbgS8Nxp33XCQiry
         DqH3hevGkCIdUSLWG/dAYoWEpOA8Mt4mMOeHMHa02+ghWm6+pW7Npcv60ztiEDt62tVB
         vPjpGIbEsQX24NRheebkP5TOnKUYd/iUXKM+NUfJf9+hUzcKZLWcxiI11WcGUiiQJ9QE
         2XQqykxxbh1eso95cv2NGd7ALwBdmmYd5SAzV4Ka7kLoaTYLdwY5hYz6z/inG0VB+pcN
         9a1g==
X-Forwarded-Encrypted: i=1; AJvYcCVmRGz3FCMm/PPw+DDxFF0bXSIg5SRisdMhe1zxXdwWqBV1kiDLvdYe1ukcC8P3H+slpBf+aBy3safyT0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEq/O9D4TExtLJzW1wd4Sb/Npu9Y8NXr+dGE/QfXAHjIhD665
	AZP/GtUYHGu9SNWuOaA9mBsKCAdAvxQgV6Z8/lH1EeHX9LNiGxXfK5SW/dXkS4gxbW4=
X-Gm-Gg: ASbGnctf79VwShr2geP/62zm9Jyom8iUNo2K4kvSYMx6mytTCqk+C33m3x6VQcVp2Kk
	anGlHFSztDEa94XYlnX7vxAdtJNlx0x1007XfOGGbLlbsTC+G9rZwbcUOktNzc0mmoWJfGZo5Wl
	Cd191/GTDSAnEoMfldtGhr87/uNAGL0clBGQBUBi++5ecXvNLdhxIvQj+A1wVAq7J1LqVqXs9b0
	YdAOLztJF3wNBzmG49nCW7n4OMZ+ZIlW33oAa7aeIOHuBIVJzDpYIuDIuqXgk6sSNfIhfyCMgVp
	ads/7Ibclxmg13o1rS9HSkkbUmApxw8fCXZ6IK8ej6zL8F3xgGk9J1RwirhwiRIULr5IpcI7CVh
	wP/Hy1q181k8SPmTk3pSuGTy8XGqUJilhiA==
X-Google-Smtp-Source: AGHT+IE+TDhp+9y/Zga0Mp5C1jmqV34Ag3mxyaG5ZBaBqiVPctxCCiamXOSO0Y0Mb5V9w9L97PamLg==
X-Received: by 2002:a05:600c:1392:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b43e152cfmr9077705e9.31.1755585187888;
        Mon, 18 Aug 2025 23:33:07 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b43f88e79sm7500065e9.3.2025.08.18.23.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:33:07 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
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
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 4/5] net: gro: remove unnecessary df checks
Date: Tue, 19 Aug 2025 08:32:22 +0200
Message-Id: <20250819063223.5239-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819063223.5239-1-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
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
index 7f29b485009d..b4052cabdfc4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	/* fixed ID is invalid if DF bit is not set */
 	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID_OUTER << encap));
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


