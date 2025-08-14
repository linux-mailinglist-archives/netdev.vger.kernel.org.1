Return-Path: <netdev+bounces-213687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA3B26486
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC553AAC5A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B992FB976;
	Thu, 14 Aug 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFyPECct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49762FC873;
	Thu, 14 Aug 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171699; cv=none; b=fHgiQ/AqjLIuEoWut+7yUitCe/HVKyUYRMLwYSxGgRoDUQznVVh8JDyVs47a0PMsiA4fXvEwubZL+Ycqb4d/NY6mJxavh+R8PCSZtalHHmsy3zzsTkgQLMcQhvx9LliOFAKVhMZxb5+rT8DQY6vL5gsGqJkphudI9ZWzsfQ68L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171699; c=relaxed/simple;
	bh=3mc9d2A6u3r3oUg0hEgXlYh1GPhKCuMUPAX7+Fzff5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uz3qb4fIjV/Vq6RxBthmSgzaSa3eIfwPFsHIeUeMvXSZnSbu8iqCtOBtlzP4XlK+nnDPsJebEKF+aCRBbg8XPlAKuul5SioU3A1Ht9XCW7tU2bUeVvczDsCTWj2EtXgc46vzME0bcEeI3lMyyFwS3CI+sAP2YbxDkfSTmqf3eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFyPECct; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so426698f8f.0;
        Thu, 14 Aug 2025 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171696; x=1755776496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuRJoY3GNkyWfDlJezuldyXpAwYPVRBuFKt2MQIP7HE=;
        b=QFyPECctvNNXe01/MlDeo0xOMfrpHQwcoT0z41l95BXIZq7FUuMzHmfoGg+ClOZBM0
         pOKyEqSQFdIrYVRbcZNvIB4khlxArcsTOv2v+zzBjd/18DetnfZxNG5GfTstB4e1llP6
         1qTKtJSo3WDaHBVC4jwoJ7vFLg9Lcp+fZcqr6IsRnM6N9Pfw19seTgRuRpBGXHPf1cyu
         Py9oBbq4TufxkOw+adOM+/adlUBcc3thtVE81IksnU5cVcugLM3Tfwm61hMhavrWSyt3
         nmxis4WzJiSij7nlia2iRc7LuWwnYrfPgKlFtcdmXeF1XI6dsGWl/F41s1rlv/4nXASG
         lS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171696; x=1755776496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuRJoY3GNkyWfDlJezuldyXpAwYPVRBuFKt2MQIP7HE=;
        b=wrPBbGTXovUDPmQ0ILG/W/HgyYbIAi4yNGw7iCLgou3eIzNlyNxZpFphmt9BTfF3Q4
         5kTS+0DBuko/lRJjduobRdrIzNf02yWoSGRibrbGud5GOFR+v6y6MtigBbgAi+ZbzUqs
         bnfJVD31u0K5pzcxl9roh+28yG5V+M1CsH8Rj2TbWBG0noHFzNb31prBX1d2pJdshNqG
         VnIh33CQfEa7K72XnolsDfkTaXJD1qVqj7NxZ8hBeR+3zgMNIDkYOngzC4ejsUfwijdE
         5VwGSyNi0pYjCtwxwjraBwImeR1AjwMWb87QeGVXdFPSuTv1lebZ6/zgJhHQmcS2caXA
         FHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVmcfgx+bnyMd9JD9sqerCLbYWgrLn1KzgwbGgsk7cuZ2omWvVCROsaQsnhQcXj6RHF7gHHGanZxUE931M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeLF/F6EHs+snztxMmUkabbFMyrg4IworX2Es93sIcQ3dmkKZ
	cQ4Fgn7b/+bBqhvCw4NUB4Nj1O+eqtwjca9SP2XkSIQD7sr1nXjs4IutlaIRjo2ivbI=
X-Gm-Gg: ASbGnctNxKu1L4K1zk6TlZ7wmSkoHNriAar+VguX9MMVaa39egR3qGIKWRdap3wBiAr
	4AS8WgZIF3aB9wq1VYk4LdUH9Io0E8f0efU658Fg9it8LfB6LRsqKeBadThTzVpvzVx7yhDMt4x
	Qz64+jtnQZG0GWVMmeHwKU2tEc689Yh74UPnsL1b6MbpqAIhOrFJwBNRmupBsKyAxKnnEZpC0rK
	3U0xCrmUPbsNEbTzPn628T4L6ie7WbRJxbgZ5wjB8Ng3EWWWDkyf810X3kdgu0uleAmuVtvAqY5
	s4y+HrCBPi+hFar0oeAXWh4hC+NOtMsi7dKLbFWGF8qcYco+nWnUktGNJbzESAe10Scktg7u0SW
	S9PzJdolc+lkVOdOg3F/5blAvrwiJrWt4eQ==
X-Google-Smtp-Source: AGHT+IF7oqr/0z9KtKpnNJiknFXg8mQzZW6PfHLCQIpA5VO6sxuqD14q263bkHJfjz+SIbGAV1Qlbw==
X-Received: by 2002:a05:6000:24c2:b0:3b7:8d2a:b33c with SMTP id ffacd0b85a97d-3b9edf1e355mr1990613f8f.18.1755171695910;
        Thu, 14 Aug 2025 04:41:35 -0700 (PDT)
Received: from localhost ([45.10.155.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5d7deaasm29866827f8f.65.2025.08.14.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:41:35 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 4/5] net: gro: remove unnecessary df checks
Date: Thu, 14 Aug 2025 13:40:29 +0200
Message-Id: <20250814114030.7683-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814114030.7683-1-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
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


