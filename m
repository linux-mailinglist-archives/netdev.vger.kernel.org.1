Return-Path: <netdev+bounces-114636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986BE9434EA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A4E1F23553
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA71BD027;
	Wed, 31 Jul 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="UYeopeyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEC1BDC8
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446633; cv=none; b=MBLjhU/9avJOgdxRwsMmRrCUd1C0Npq7o/KnSTGfsFUlD/sk9Nh1kr/IBEzBj2lUwszgjz3OWyIv6JBfj14pBBWG/hFLLyhsP7KkVJYD6d6jGejiXMojfB2nnWBLdnz19e07xg69CFqBXD3SHG4Y/L4v6bXffwpgk67aXdrM6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446633; c=relaxed/simple;
	bh=GcVtObMKZKvCumwXVrLokDsxMWPVUBDmwxpMG8r26L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtPm7TQkNwVO7fyTkyNYVTkqL5Keo4OB/S1rTk6rX9ym+o6NiIdlt8mwBzZVtYgt/6Q11uoEQQKsqXggMMwrL+VfV9G+BZpG7f5jgQeCyEfpGZ4Q/6XMADxpdi4eY2sCYo85SEBkCxrpp6fSOE94NpycImxulNCVgYXzsTxR1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=UYeopeyK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db145c8010so3800889b6e.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446631; x=1723051431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6uStiK3aDF1mC90JSWDLW9NK1b0vERakNh1bTcVzv0=;
        b=UYeopeyKMgJquXqBHDkIeozqzcA84GYUbXf8umrTrJzvOxSlKDBTW1NgE2y6VZbY9D
         qHos5/Hetd0mDLxukRy3SFwevZtPybV3Up8mrpuFPnVuP5kctJl/fH7wg2Llw3jNK/nO
         lRrxQ+0eEuf2C5omsALOEx07FzlTFF22n7oXGXoN6j5fEjh4J/lMj1NTanAju1EAF2tp
         C2Ca7Kj86Xt/5MUICronlbhwtgAJ/Lgsue1T1mD0ronxQozCJ9Qr5oo+En4Kl9ptdG9v
         3NXbttN5hesB2+qjVM4uT7N8AdFWW+yGQ8yzkrpDnusb7gHPqdVHX1iIQTAHYuc2I6kx
         ZPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446631; x=1723051431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6uStiK3aDF1mC90JSWDLW9NK1b0vERakNh1bTcVzv0=;
        b=MIIPNsxuSAgcrK8Msz6C/sNcYH6oO6vsY5fEBix8D5wC7vAD6V2YDWi5sZ2zqhttdu
         6tz2V7wN9hOezEdV8NHLV7RSGgJt5hXB6fkpQ4Zlzm74SuYhHpVs5UdMQlV1ra82yL1c
         /l7jo/UARfEVjDOSp9GLIk1qMQL9+VVKVTmhL93Ers4nXQonbm2V6qFUTJmYZQ7hlHTz
         c84nfxSC0wK48BKOPtPGBzDB9BP5V9siTJ11r91ma6d9qnThSXQqoBjJ+al3tiB2gEzs
         XzoLydFXJm5bTKlmcwq4fdG5O6Tlq3mWVwfYcHUO4Idw6uzFjt+PjgOBKzOXxTatA2ts
         Mrmw==
X-Forwarded-Encrypted: i=1; AJvYcCVCNBD1xMoA5ht48/0BD8BV7UdcQFYzzOHm2+9TBwlgtKzqOFeMgLebqx3IwJGxonwLzwel/4xVICtKElJpYHJtKL5msckG
X-Gm-Message-State: AOJu0Yy5yhWlxpG/k/UGDPNNwAEPHCIUf0uIWRDoRdRJNuUlYARyuoSz
	wQgmsQj+6aDyIMVs04Suy5kL78JEbocd3pi+1rb+s7gVn1pk1a1xZzgn32MWTQ==
X-Google-Smtp-Source: AGHT+IH8TWPfAHmhwJZe+It6bVRS3JDs8ZkNw5U4+kXV2m3jd9sqcYs5EZTSzRidqzKISy3y80DARA==
X-Received: by 2002:a05:6871:4006:b0:261:2c4:f7a0 with SMTP id 586e51a60fabf-267d4f80cf9mr15117956fac.51.1722446631116;
        Wed, 31 Jul 2024 10:23:51 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:50 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 01/12] skbuff: Unconstantify struct net argument in flowdis functions
Date: Wed, 31 Jul 2024 10:23:21 -0700
Message-Id: <20240731172332.683815-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want __skb_flow_dissect to be able to call functions that
take a non-constant struct net argument (UDP socket lookup
functions for instance). Change the net argument of flow dissector
functions to not be const

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/linux/skbuff.h    | 10 +++++-----
 net/core/flow_dissector.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..a0b5687fa49c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1504,14 +1504,14 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
 	__skb_set_hash(skb, hash, true, is_l4);
 }
 
-u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb);
+u32 __skb_get_hash_symmetric_net(struct net *net, const struct sk_buff *skb);
 
 static inline u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 {
 	return __skb_get_hash_symmetric_net(NULL, skb);
 }
 
-void __skb_get_hash_net(const struct net *net, struct sk_buff *skb);
+void __skb_get_hash_net(struct net *net, struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 		   const struct flow_keys_basic *keys, int hlen);
@@ -1532,7 +1532,7 @@ struct bpf_flow_dissector;
 u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		     __be16 proto, int nhoff, int hlen, unsigned int flags);
 
-bool __skb_flow_dissect(const struct net *net,
+bool __skb_flow_dissect(struct net *net,
 			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container, const void *data,
@@ -1556,7 +1556,7 @@ static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
 }
 
 static inline bool
-skb_flow_dissect_flow_keys_basic(const struct net *net,
+skb_flow_dissect_flow_keys_basic(struct net *net,
 				 const struct sk_buff *skb,
 				 struct flow_keys_basic *flow,
 				 const void *data, __be16 proto,
@@ -1590,7 +1590,7 @@ void skb_flow_dissect_hash(const struct sk_buff *skb,
 			   struct flow_dissector *flow_dissector,
 			   void *target_container);
 
-static inline __u32 skb_get_hash_net(const struct net *net, struct sk_buff *skb)
+static inline __u32 skb_get_hash_net(struct net *net, struct sk_buff *skb)
 {
 	if (!skb->l4_hash && !skb->sw_hash)
 		__skb_get_hash_net(net, skb);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..e034e502ab49 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1045,7 +1045,7 @@ static bool is_pppoe_ses_hdr_valid(const struct pppoe_hdr *hdr)
  *
  * Caller must take care of zeroing target container memory.
  */
-bool __skb_flow_dissect(const struct net *net,
+bool __skb_flow_dissect(struct net *net,
 			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container, const void *data,
@@ -1854,7 +1854,7 @@ EXPORT_SYMBOL(make_flow_keys_digest);
 
 static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
 
-u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
+u32 __skb_get_hash_symmetric_net(struct net *net, const struct sk_buff *skb)
 {
 	struct flow_keys keys;
 
@@ -1878,7 +1878,7 @@ EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric_net);
  * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
  * if hash is a canonical 4-tuple hash over transport ports.
  */
-void __skb_get_hash_net(const struct net *net, struct sk_buff *skb)
+void __skb_get_hash_net(struct net *net, struct sk_buff *skb)
 {
 	struct flow_keys keys;
 	u32 hash;
-- 
2.34.1


