Return-Path: <netdev+bounces-109058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C750D926BEB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481CF1F22AFB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012919412C;
	Wed,  3 Jul 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HzGoGiN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD3191F6D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047022; cv=none; b=QA4XZhEjED0A8Oc3UQO4SNceyLL674zNvjZ4yN41TycbenJJZPYsFzTx0K4y87YEQ+CaqMV+2+yqFuzzVKdGhq8/SGRDCI0CepyYyBl5ZIr8pNjd2jQxmHMNZHe5GPUwVT9D/5J2fgR8rdoSdS9MRHxbqVrxGVJVEiLf/vPCbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047022; c=relaxed/simple;
	bh=Pi2M3jyyS7o7QkY6N5zKyeeNZDaFBAI+E5PAbFSIK6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClJx6TYyfLGiSwrzvo+Qrd0tWnKo1mraNBB8d1mNDHGef2Zuz/RJlJLLsqnVOmbubnmQII6/CcUQa/Xl4ZHOO93XNbavOmhkXxwgTVr7tPWx4lbAx0dmSqtlBHKC662k6m2XDx3ZOAKB+QqcMA1fLAjEl9RqDK0uiTInTsciGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HzGoGiN1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so12321765ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047020; x=1720651820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvdCJzTzksqtvShuKB6xdSGKXwmoxW8vC/dJBFK0TWU=;
        b=HzGoGiN1CUm0iDKNiciFaEuWwXoSlQucU5ClFx5S7zlhp1O4c9UGyAkKRZM7sz5sGw
         vB0piNLzQnKtVE4I0NNBbSehN/Ko9adH1XjzrSvEbSzTZB6CkC+SPpw9utVlsUf02U06
         algv6fB0RRLG9VAkf6f9Hl9VMiDJ4vhnQAk+jPbjEyKCFrvNrquXw54qXfzVFgHv8PtB
         0lRVBxDWhreF+maMmjTuYVHzttyWWcm9Z59E7xIxGRu+IG7MVF9HiD017Gob6OKhVlas
         81nacAp241QZhOGfewoCZ+44GZzPi6/lOw5+N/GgXyUNAuXdsq3kQm9DGDAie2ZN19jS
         7IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047020; x=1720651820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvdCJzTzksqtvShuKB6xdSGKXwmoxW8vC/dJBFK0TWU=;
        b=ln2CLTe6i6RzQs+oipD5kszHhEXeWjXkfxWxZD6MvCRkK+yNruYeHNnK0HIoyUT52X
         bHzxxzQgNH3PRfe4gEQHkWkAG9f6MRmCDQLwbubcQ36UfdoqQv9aQdNXrKt88UH9kLDG
         BKMNLoF9Ohf0Jt5PEO3f5jrugxsKAyt3QFcEQLSkbnqbDCMOvwuv6dQuIoazrcwpftun
         Q2HXPHy6ZjXnnD2N9edNLldudgYU+OHmGP3N6QVCpo39k1nmwSTZBm7OaxmRkS+wEDHt
         FN0HNqYWnG7dXMFZhqvM/XV57lXKQI4x3VZWph8vGm1nM1xakfRmSsAShOjYi2Hn7UAO
         RaeA==
X-Forwarded-Encrypted: i=1; AJvYcCXQhfy16yOcRGyM7MikDvtfpFMzMz7qOPKkLV7VV4X4nMxp9AhA91hAhbuI7sQIA57fahA7OwW3GcypW6hE6YixE+qk8Eb/
X-Gm-Message-State: AOJu0Yw2PvcuPEpojkwUSUkLwKMzwIyZFOET9ecry9xxxYsiklWdFBZ8
	cL//IdqXERxCpRA6yrkg++L3c9qQJYIh3AWLqgHi5rq87xIeZduv3u++1GlizQ==
X-Google-Smtp-Source: AGHT+IFCx2FFSzv0hxvckbKGzVBuA95+7V1Bwz1r7Y2da2RNkT53VkHEe5DZvgdB39uPtazNeIfYkg==
X-Received: by 2002:a17:903:24e:b0:1f8:6d9e:fa9c with SMTP id d9443c01a7336-1fb33e0543cmr228155ad.6.1720047019639;
        Wed, 03 Jul 2024 15:50:19 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:18 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 01/10] skbuff: Rename csum_not_inet to csum_is_crc32
Date: Wed,  3 Jul 2024 15:48:41 -0700
Message-Id: <20240703224850.1226697-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

csum_not_inet really refers to SCTP or FCOE CRC. Rename
to be more precise

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/linux/skbuff.h | 18 +++++++++---------
 net/core/dev.c         |  2 +-
 net/sched/act_csum.c   |  2 +-
 net/sctp/offload.c     |  2 +-
 net/sctp/output.c      |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f4cda3fbdb75..7fd6ce4df0ec 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -185,7 +185,7 @@
  *   skb_csum_hwoffload_help() can be called to resolve %CHECKSUM_PARTIAL based
  *   on network device checksumming capabilities: if a packet does not match
  *   them, skb_checksum_help() or skb_crc32c_help() (depending on the value of
- *   &sk_buff.csum_not_inet, see :ref:`crc`)
+ *   &sk_buff.csum_is_crc32, see :ref:`crc`)
  *   is called to resolve the checksum.
  *
  * - %CHECKSUM_NONE
@@ -215,12 +215,12 @@
  *     - This feature indicates that a device is capable of
  *	 offloading the SCTP CRC in a packet. To perform this offload the stack
  *	 will set csum_start and csum_offset accordingly, set ip_summed to
- *	 %CHECKSUM_PARTIAL and set csum_not_inet to 1, to provide an indication
+ *	 %CHECKSUM_PARTIAL and set csum_is_crc32 to 1, to provide an indication
  *	 in the skbuff that the %CHECKSUM_PARTIAL refers to CRC32c.
  *	 A driver that supports both IP checksum offload and SCTP CRC32c offload
  *	 must verify which offload is configured for a packet by testing the
- *	 value of &sk_buff.csum_not_inet; skb_crc32c_csum_help() is provided to
- *	 resolve %CHECKSUM_PARTIAL on skbs where csum_not_inet is set to 1.
+ *	 value of &sk_buff.csum_is_crc32; skb_crc32c_csum_help() is provided to
+ *	 resolve %CHECKSUM_PARTIAL on skbs where csum_is_crc32 is set to 1.
  *
  *   * - %NETIF_F_FCOE_CRC
  *     - This feature indicates that a device is capable of offloading the FCOE
@@ -822,7 +822,7 @@ enum skb_tstamp_type {
  *	@encapsulation: indicates the inner headers in the skbuff are valid
  *	@encap_hdr_csum: software checksum is needed
  *	@csum_valid: checksum is already valid
- *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
+ *	@csum_is_crc32: use CRC32c to resolve CHECKSUM_PARTIAL
  *	@csum_complete_sw: checksum was completed by software
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
@@ -1006,7 +1006,7 @@ struct sk_buff {
 #endif
 	__u8			slow_gro:1;
 #if IS_ENABLED(CONFIG_IP_SCTP)
-	__u8			csum_not_inet:1;
+	__u8			csum_is_crc32:1;
 #endif
 
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
@@ -5098,17 +5098,17 @@ static inline void skb_set_redirected_noclear(struct sk_buff *skb,
 static inline bool skb_csum_is_sctp(struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IP_SCTP)
-	return skb->csum_not_inet;
+	return skb->csum_is_crc32;
 #else
 	return 0;
 #endif
 }
 
-static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
+static inline void skb_reset_csum_is_crc32(struct sk_buff *skb)
 {
 	skb->ip_summed = CHECKSUM_NONE;
 #if IS_ENABLED(CONFIG_IP_SCTP)
-	skb->csum_not_inet = 0;
+	skb->csum_is_crc32 = 0;
 #endif
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 385c4091aa77..f6a2b868e561 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3382,7 +3382,7 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 						  skb->len - start, ~(__u32)0,
 						  crc32c_csum_stub));
 	*(__le32 *)(skb->data + offset) = crc32c_csum;
-	skb_reset_csum_not_inet(skb);
+	skb_reset_csum_is_crc32(skb);
 out:
 	return ret;
 }
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5cc8e407e791..347622e690be 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -376,7 +376,7 @@ static int tcf_csum_sctp(struct sk_buff *skb, unsigned int ihl,
 
 	sctph->checksum = sctp_compute_cksum(skb,
 					     skb_network_offset(skb) + ihl);
-	skb_reset_csum_not_inet(skb);
+	skb_reset_csum_is_crc32(skb);
 
 	return 1;
 }
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index 502095173d88..b1a68f43b327 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -27,7 +27,7 @@
 static __le32 sctp_gso_make_checksum(struct sk_buff *skb)
 {
 	skb->ip_summed = CHECKSUM_NONE;
-	skb->csum_not_inet = 0;
+	skb->csum_is_crc32 = 0;
 	/* csum and csum_start in GSO CB may be needed to do the UDP
 	 * checksum when it's a UDP tunneling packet.
 	 */
diff --git a/net/sctp/output.c b/net/sctp/output.c
index a63df055ac57..1d81451cc654 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -553,7 +553,7 @@ static int sctp_packet_pack(struct sctp_packet *packet,
 	} else {
 chksum:
 		head->ip_summed = CHECKSUM_PARTIAL;
-		head->csum_not_inet = 1;
+		head->csum_is_crc32 = 1;
 		head->csum_start = skb_transport_header(head) - head->head;
 		head->csum_offset = offsetof(struct sctphdr, checksum);
 	}
-- 
2.34.1


