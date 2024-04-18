Return-Path: <netdev+bounces-89438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A432E8AA449
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2491F22C63
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC319DF5C;
	Thu, 18 Apr 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4JaIsLe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3F199E9A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473263; cv=none; b=h1DXBTQdIwx3Kbhqj/V3yiImQb486Z+hxbSOtLM4krkf9KHdqyeaDs2IZ5Xwq9XJtKOPMBxCjE7axF7YCoH6n6Gr5e2i9ZSUsz4wBT8EdBX1DyTLYhGV1p3NN4O0W+I98DCggItgYW2n0NQsWkGjEFYyEQwrlIsF031fLvO0s2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473263; c=relaxed/simple;
	bh=xghA/IKe2+zJPaTSn22evp4r7tz7T7gc2ns6uAWCT3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBqSN9hiPySnyVoTaSNsr2s2WxMqCKGEncHilEQlMIyUrO4Q206o5JFsoYuXYHsY0YPKKnuSD7z84nm2Uv9Cya3/NCcNmTOyiP822tENn2/ksHt+pSLR5hJCAQvLLFJtluAmhbVUf5Y49QY73Z6/N3qtv+qI3LlEbtN7GCOI3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4JaIsLe; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36b1774e453so4130125ab.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473261; x=1714078061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiHSwsewvF6JA/i3n1XYlFUoFzpIo8xMcAilX3ipKIk=;
        b=e4JaIsLeepF5UVLgjighmAWDK3ul/kn2UyM5P+jo5DdJOjcCi52Hk6dcfq37L6/JPy
         liwQci/qiRskQR/cs6cvXxeZc9HvIWUFww/J+7IV+x/MGkk+DR3xtBq4wo77klTbDAgf
         Ll/I8Lx//0EaxAVF8q5L/rgIlLsbRam4zFlQ9h21PiQyRPDx9HlBVKe8GfUf6Kx/OCLX
         eJK5Kf7j9Z1GmEoJulBVSjhWy9csUjgQs14MqkC/1/5Vkyzff2o6vZMF+C+tQ1rhILUZ
         Ih2gIoj0hEYu0BLSSBmXwjK9X931zXo8Rc3dUv42+pyKSVkWkfUzLji7J6/wwe6G1PUu
         v8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473261; x=1714078061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiHSwsewvF6JA/i3n1XYlFUoFzpIo8xMcAilX3ipKIk=;
        b=fxxe4/78WykMS9oNunHHogRyVo7tN4pURU4CDfGIzyTzHVPRrQIZA/p3skNa2z31i8
         a9MYWiZATBLjkDLZnHW656unDtPT0LNoj4FKJud25YrE30J7jRODfR5CTIicFVCQZfSu
         h9r1Dh8RWSKmNYxsAVGqfSojAYwtOJYM2hjFqU9fWiNfS2TsDIIydluZsoD+YwBQJQ2J
         0trSqfDXKH6ASrpjHvcNT0Td/2FMqL7PmN3fdcbVY4oFyIMw6Ts+1DKuzOwv6wy0nbr+
         aO6GAVeVFPWy+WPYGLIBbK0jQ8IvlvspG4vpXjXvh1ZAdi9Y2tHkvc/xbDBdhFBXmYWN
         ZRqg==
X-Forwarded-Encrypted: i=1; AJvYcCV5hMifql1lUD23L1OlQqXBX52z82Wgvje1N8TV+/jgbWsBzu6AtTZThfDFIQ183GneAZqzZxURYfCzTu7/S2HvZmaavAdb
X-Gm-Message-State: AOJu0YztJA1vPiYScw0VAsYnYHAfIsRx3LuV49MMHcDDwAsdQBrtM05U
	cMMg3gbfbIqgsXkVGNXDwoXt6kbZp2et2yz7AzKASt+loSZMjm4u59jrKObeVZo=
X-Google-Smtp-Source: AGHT+IGQ6BTpypWpACqqIEmHjce8/fc1/vHZDxgj0kcIec3Y2dkFk6ndzqZ7423P1OzFVdQi2pRFLg==
X-Received: by 2002:a05:6e02:1541:b0:36b:3a3b:b2c0 with SMTP id j1-20020a056e02154100b0036b3a3bb2c0mr318004ilu.32.1713473260872;
        Thu, 18 Apr 2024 13:47:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:40 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
Date: Thu, 18 Apr 2024 15:47:25 -0500
Message-Id: <20240418204729.1952353-5-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418204729.1952353-1-elder@linaro.org>
References: <20240418204729.1952353-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FILT_ROUT_HASH_EN register is only used for IPA v4.2.  There,
routing and filter table hashing are not supported, and so the
register must be written to disable the feature.  No other version
uses this register, so its definition can be removed.  If we need to
use these some day (for example, explicitly enable the feature) this
commit can be reverted.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/reg/ipa_reg-v3.1.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.11.c  | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.5.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.7.c   | 14 --------------
 drivers/net/ipa/reg/ipa_reg-v4.9.c   | 14 --------------
 6 files changed, 84 deletions(-)

diff --git a/drivers/net/ipa/reg/ipa_reg-v3.1.c b/drivers/net/ipa/reg/ipa_reg-v3.1.c
index 648dbfe1fce3a..df20f9194efb8 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.1.c
@@ -76,19 +76,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x000008c);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -403,7 +390,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[IPA_BCR]			= &reg_ipa_bcr,
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
index 78b1bf60cd024..1f8c0457529e1 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
@@ -81,19 +81,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x000008c);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -414,7 +401,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[IPA_BCR]			= &reg_ipa_bcr,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.11.c b/drivers/net/ipa/reg/ipa_reg-v4.11.c
index 29e71cce4a843..ba21a6c655c88 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.11.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.11.c
@@ -113,19 +113,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -470,7 +457,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.5.c b/drivers/net/ipa/reg/ipa_reg-v4.5.c
index 1c58f78851c21..90fd749b43eba 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.5.c
@@ -107,19 +107,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -489,7 +476,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.7.c b/drivers/net/ipa/reg/ipa_reg-v4.7.c
index 731824fce1d4a..ebae61d10eadb 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.7.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.7.c
@@ -107,19 +107,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -462,7 +449,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.9.c b/drivers/net/ipa/reg/ipa_reg-v4.9.c
index 01f87b5290e01..f488f68603d07 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.9.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.9.c
@@ -112,19 +112,6 @@ static const u32 reg_qsb_max_reads_fmask[] = {
 
 REG_FIELDS(QSB_MAX_READS, qsb_max_reads, 0x00000078);
 
-static const u32 reg_filt_rout_hash_en_fmask[] = {
-	[IPV6_ROUTER_HASH]				= BIT(0),
-						/* Bits 1-3 reserved */
-	[IPV6_FILTER_HASH]				= BIT(4),
-						/* Bits 5-7 reserved */
-	[IPV4_ROUTER_HASH]				= BIT(8),
-						/* Bits 9-11 reserved */
-	[IPV4_FILTER_HASH]				= BIT(12),
-						/* Bits 13-31 reserved */
-};
-
-REG_FIELDS(FILT_ROUT_HASH_EN, filt_rout_hash_en, 0x0000148);
-
 static const u32 reg_filt_rout_hash_flush_fmask[] = {
 	[IPV6_ROUTER_HASH]				= BIT(0),
 						/* Bits 1-3 reserved */
@@ -467,7 +454,6 @@ static const struct reg *reg_array[] = {
 	[SHARED_MEM_SIZE]		= &reg_shared_mem_size,
 	[QSB_MAX_WRITES]		= &reg_qsb_max_writes,
 	[QSB_MAX_READS]			= &reg_qsb_max_reads,
-	[FILT_ROUT_HASH_EN]		= &reg_filt_rout_hash_en,
 	[FILT_ROUT_HASH_FLUSH]		= &reg_filt_rout_hash_flush,
 	[STATE_AGGR_ACTIVE]		= &reg_state_aggr_active,
 	[LOCAL_PKT_PROC_CNTXT]		= &reg_local_pkt_proc_cntxt,
-- 
2.40.1


