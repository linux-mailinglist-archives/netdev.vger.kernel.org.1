Return-Path: <netdev+bounces-144530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5089C7AC2
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB211F2181C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903B207213;
	Wed, 13 Nov 2024 18:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC855206E7B;
	Wed, 13 Nov 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521437; cv=none; b=AywFGSbSn0mjzHW1WX7cvHbOPTnw+KIyRAAm8wzNs6gUuuhdxICmu6EVgBEWHw6MGKtQFIwQCMCr5SFshuxPvVWD7XqjuuoPTBm0feIATVlNRoGyIzk0i3xe6gYz/QjZJxDPooU5QeyEzXBBIt8gcBTykrgSZjBxW7QCLcX3hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521437; c=relaxed/simple;
	bh=sxkYSzChD2KL7wXRjIQIdhlk+izDvva5zC1VGgqvZTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd91GzaOgWGKsALcoURyIob8KFTuAn35NGPbm24qcpCvfG9WzkJuEWxTul6p9UeSa6yxVQEdG7oL36jFqs5QFvdqQbrJacjd55kMIXDqVB3DcHyrmMcHGuBWs2KyKH6IwhrAwtfOC1bNCbVpgkRdgDVeCzgjK21yc8w3URu7Kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso5383657a12.3;
        Wed, 13 Nov 2024 10:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521434; x=1732126234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz0T9AbfZgbmKpprExlqT2DT5An0GqdvFLFyhhI41U0=;
        b=FjJQNeTsaXQUZel201htyoQjdafXzJ+V0C9pWeaoMskTSlfMRX1gdTANcnvK0p19AV
         Vm1JHwgNaz9snxI3KrKn5DhBS8lEWcoNtG6v/QW/wJ5gFC8ML43udV9Is54jd4c99+bV
         eYFBoXGAXogErf3zx7ahC4197Vded5uvYSbITcDaCFclse50okrwgF9a4xO7kZuHMmE+
         h/iLlviMdcN2lucGy3jtEKi/bQKA/YZKuNs3Y5tlYf6bGmF9QfR+8+YKm5WHi/OWjq7V
         n2gFPlJQDqRTPwBcqMzEMuAKfilx08izj4+uAFaOkL8kyWL+9N5vD9bMv1DP7GLmAkqP
         zUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3//Z+5hQiBBS1+P0WNgnCWFSPr7JOXlAuhMlcr25muIHfAPppJ7CHOawn/cW2hBBTeukH7xCLsJBfkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbmu76AkTRxuPzPDgTm1vQR/fHqcZrphKd0mJUzVuEMKzU7O5
	TlnHbKKG+AY+UAjww4Mef4e2F8Djim3fegktvdtJcQvuguwTQfW4aTtHBJo=
X-Google-Smtp-Source: AGHT+IEtrVG3hXaKBRK0DbNxb1Lvw6Q7m1cl95IxZfG7DsUiZpK3HPNH0ePZTipvlnqV8QpLWUxGog==
X-Received: by 2002:a17:90b:2248:b0:2cd:4593:2a8e with SMTP id 98e67ed59e1d1-2e9b171ff77mr27258984a91.15.1731521434531;
        Wed, 13 Nov 2024 10:10:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ea574dsm1775381a91.7.2024.11.13.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:34 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 7/7] ethtool: regenerate uapi header from the spec
Date: Wed, 13 Nov 2024 10:10:23 -0800
Message-ID: <20241113181023.2030098-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113181023.2030098-1-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes. Mostly the following formatting:
- extra docs
- extra enums
- XXX_MAX = __XXX_CNT - 1 -> XXX_MAX = (__XXX_CNT - 1)
- newlines

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../uapi/linux/ethtool_netlink_generated.h    | 89 ++++++++++++-------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index d5c95a115603..bf78c00ac76e 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -1,23 +1,43 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ethtool.yaml */
+/* YNL-GEN uapi header */
+
 #ifndef _UAPI_LINUX_ETHETOOL_NETLINK_GENERATED_H
 #define _UAPI_LINUX_ETHETOOL_NETLINK_GENERATED_H
 
+#define ETHTOOL_FAMILY_NAME	"ethtool"
+#define ETHTOOL_FAMILY_VERSION	1
+
 enum {
 	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
 	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
 	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN_GPE,
 
-	__ETHTOOL_UDP_TUNNEL_TYPE_CNT
+	/* private: */
+	__ETHTOOL_UDP_TUNNEL_TYPE_CNT,
+	ETHTOOL_UDP_TUNNEL_TYPE_MAX = (__ETHTOOL_UDP_TUNNEL_TYPE_CNT - 1)
 };
 
+/**
+ * enum ethtool_header_flags
+ * @ETHTOOL_FLAG_COMPACT_BITSETS: use compact bitsets in reply
+ * @ETHTOOL_FLAG_OMIT_REPLY: provide optional reply for SET or ACT requests
+ * @ETHTOOL_FLAG_STATS: request statistics, if supported by the driver
+ */
 enum ethtool_header_flags {
-	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
-	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
-	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
+	ETHTOOL_FLAG_COMPACT_BITSETS = 1,
+	ETHTOOL_FLAG_OMIT_REPLY = 2,
+	ETHTOOL_FLAG_STATS = 4,
 };
 
 enum {
-	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN = 0,
+	ETHTOOL_PHY_UPSTREAM_TYPE_MAC,
+	ETHTOOL_PHY_UPSTREAM_TYPE_PHY,
+};
+
+enum ethtool_tcp_data_split {
+	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN,
 	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
 	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
 };
@@ -30,7 +50,7 @@ enum {
 	ETHTOOL_A_HEADER_PHY_INDEX,
 
 	__ETHTOOL_A_HEADER_CNT,
-	ETHTOOL_A_HEADER_MAX = __ETHTOOL_A_HEADER_CNT - 1
+	ETHTOOL_A_HEADER_MAX = (__ETHTOOL_A_HEADER_CNT - 1)
 };
 
 enum {
@@ -40,7 +60,7 @@ enum {
 	ETHTOOL_A_BITSET_BIT_VALUE,
 
 	__ETHTOOL_A_BITSET_BIT_CNT,
-	ETHTOOL_A_BITSET_BIT_MAX = __ETHTOOL_A_BITSET_BIT_CNT - 1
+	ETHTOOL_A_BITSET_BIT_MAX = (__ETHTOOL_A_BITSET_BIT_CNT - 1)
 };
 
 enum {
@@ -48,7 +68,7 @@ enum {
 	ETHTOOL_A_BITSET_BITS_BIT,
 
 	__ETHTOOL_A_BITSET_BITS_CNT,
-	ETHTOOL_A_BITSET_BITS_MAX = __ETHTOOL_A_BITSET_BITS_CNT - 1
+	ETHTOOL_A_BITSET_BITS_MAX = (__ETHTOOL_A_BITSET_BITS_CNT - 1)
 };
 
 enum {
@@ -60,7 +80,7 @@ enum {
 	ETHTOOL_A_BITSET_MASK,
 
 	__ETHTOOL_A_BITSET_CNT,
-	ETHTOOL_A_BITSET_MAX = __ETHTOOL_A_BITSET_CNT - 1
+	ETHTOOL_A_BITSET_MAX = (__ETHTOOL_A_BITSET_CNT - 1)
 };
 
 enum {
@@ -69,7 +89,7 @@ enum {
 	ETHTOOL_A_STRING_VALUE,
 
 	__ETHTOOL_A_STRING_CNT,
-	ETHTOOL_A_STRING_MAX = __ETHTOOL_A_STRING_CNT - 1
+	ETHTOOL_A_STRING_MAX = (__ETHTOOL_A_STRING_CNT - 1)
 };
 
 enum {
@@ -77,7 +97,7 @@ enum {
 	ETHTOOL_A_STRINGS_STRING,
 
 	__ETHTOOL_A_STRINGS_CNT,
-	ETHTOOL_A_STRINGS_MAX = __ETHTOOL_A_STRINGS_CNT - 1
+	ETHTOOL_A_STRINGS_MAX = (__ETHTOOL_A_STRINGS_CNT - 1)
 };
 
 enum {
@@ -87,7 +107,7 @@ enum {
 	ETHTOOL_A_STRINGSET_STRINGS,
 
 	__ETHTOOL_A_STRINGSET_CNT,
-	ETHTOOL_A_STRINGSET_MAX = __ETHTOOL_A_STRINGSET_CNT - 1
+	ETHTOOL_A_STRINGSET_MAX = (__ETHTOOL_A_STRINGSET_CNT - 1)
 };
 
 enum {
@@ -95,7 +115,7 @@ enum {
 	ETHTOOL_A_STRINGSETS_STRINGSET,
 
 	__ETHTOOL_A_STRINGSETS_CNT,
-	ETHTOOL_A_STRINGSETS_MAX = __ETHTOOL_A_STRINGSETS_CNT - 1
+	ETHTOOL_A_STRINGSETS_MAX = (__ETHTOOL_A_STRINGSETS_CNT - 1)
 };
 
 enum {
@@ -105,7 +125,7 @@ enum {
 	ETHTOOL_A_STRSET_COUNTS_ONLY,
 
 	__ETHTOOL_A_STRSET_CNT,
-	ETHTOOL_A_STRSET_MAX = __ETHTOOL_A_STRSET_CNT - 1
+	ETHTOOL_A_STRSET_MAX = (__ETHTOOL_A_STRSET_CNT - 1)
 };
 
 enum {
@@ -114,7 +134,7 @@ enum {
 	ETHTOOL_A_PRIVFLAGS_FLAGS,
 
 	__ETHTOOL_A_PRIVFLAGS_CNT,
-	ETHTOOL_A_PRIVFLAGS_MAX = __ETHTOOL_A_PRIVFLAGS_CNT - 1
+	ETHTOOL_A_PRIVFLAGS_MAX = (__ETHTOOL_A_PRIVFLAGS_CNT - 1)
 };
 
 enum {
@@ -182,7 +202,7 @@ enum {
 	ETHTOOL_A_LINKINFO_TRANSCEIVER,
 
 	__ETHTOOL_A_LINKINFO_CNT,
-	ETHTOOL_A_LINKINFO_MAX = __ETHTOOL_A_LINKINFO_CNT - 1
+	ETHTOOL_A_LINKINFO_MAX = (__ETHTOOL_A_LINKINFO_CNT - 1)
 };
 
 enum {
@@ -199,7 +219,7 @@ enum {
 	ETHTOOL_A_LINKMODES_RATE_MATCHING,
 
 	__ETHTOOL_A_LINKMODES_CNT,
-	ETHTOOL_A_LINKMODES_MAX = __ETHTOOL_A_LINKMODES_CNT - 1
+	ETHTOOL_A_LINKMODES_MAX = (__ETHTOOL_A_LINKMODES_CNT - 1)
 };
 
 enum {
@@ -213,7 +233,7 @@ enum {
 	ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT,
 
 	__ETHTOOL_A_LINKSTATE_CNT,
-	ETHTOOL_A_LINKSTATE_MAX = __ETHTOOL_A_LINKSTATE_CNT - 1
+	ETHTOOL_A_LINKSTATE_MAX = (__ETHTOOL_A_LINKSTATE_CNT - 1)
 };
 
 enum {
@@ -222,7 +242,7 @@ enum {
 	ETHTOOL_A_DEBUG_MSGMASK,
 
 	__ETHTOOL_A_DEBUG_CNT,
-	ETHTOOL_A_DEBUG_MAX = __ETHTOOL_A_DEBUG_CNT - 1
+	ETHTOOL_A_DEBUG_MAX = (__ETHTOOL_A_DEBUG_CNT - 1)
 };
 
 enum {
@@ -232,7 +252,7 @@ enum {
 	ETHTOOL_A_WOL_SOPASS,
 
 	__ETHTOOL_A_WOL_CNT,
-	ETHTOOL_A_WOL_MAX = __ETHTOOL_A_WOL_CNT - 1
+	ETHTOOL_A_WOL_MAX = (__ETHTOOL_A_WOL_CNT - 1)
 };
 
 enum {
@@ -244,7 +264,7 @@ enum {
 	ETHTOOL_A_FEATURES_NOCHANGE,
 
 	__ETHTOOL_A_FEATURES_CNT,
-	ETHTOOL_A_FEATURES_MAX = __ETHTOOL_A_FEATURES_CNT - 1
+	ETHTOOL_A_FEATURES_MAX = (__ETHTOOL_A_FEATURES_CNT - 1)
 };
 
 enum {
@@ -276,6 +296,7 @@ enum {
 enum {
 	ETHTOOL_A_PROFILE_UNSPEC,
 	ETHTOOL_A_PROFILE_IRQ_MODERATION,
+
 	__ETHTOOL_A_PROFILE_CNT,
 	ETHTOOL_A_PROFILE_MAX = (__ETHTOOL_A_PROFILE_CNT - 1)
 };
@@ -362,7 +383,6 @@ enum {
 
 	__ETHTOOL_A_TS_STAT_CNT,
 	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
-
 };
 
 enum {
@@ -412,7 +432,7 @@ enum {
 	ETHTOOL_A_CABLE_TEST_HEADER,
 
 	__ETHTOOL_A_CABLE_TEST_CNT,
-	ETHTOOL_A_CABLE_TEST_MAX = __ETHTOOL_A_CABLE_TEST_CNT - 1
+	ETHTOOL_A_CABLE_TEST_MAX = (__ETHTOOL_A_CABLE_TEST_CNT - 1)
 };
 
 enum {
@@ -433,7 +453,7 @@ enum {
 	ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,
 
 	__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1
+	ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT - 1)
 };
 
 enum {
@@ -443,7 +463,7 @@ enum {
 	ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST,
 
 	__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = __ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1
+	ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT - 1)
 };
 
 enum {
@@ -452,7 +472,7 @@ enum {
 	ETHTOOL_A_CABLE_TEST_TDR_CFG,
 
 	__ETHTOOL_A_CABLE_TEST_TDR_CNT,
-	ETHTOOL_A_CABLE_TEST_TDR_MAX = __ETHTOOL_A_CABLE_TEST_TDR_CNT - 1
+	ETHTOOL_A_CABLE_TEST_TDR_MAX = (__ETHTOOL_A_CABLE_TEST_TDR_CNT - 1)
 };
 
 enum {
@@ -580,6 +600,9 @@ enum {
 	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,
+
+	__ETHTOOL_A_C33_PSE_PW_LIMIT_CNT,
+	__ETHTOOL_A_C33_PSE_PW_LIMIT_MAX = (__ETHTOOL_A_C33_PSE_PW_LIMIT_CNT - 1)
 };
 
 enum {
@@ -613,7 +636,7 @@ enum {
 	ETHTOOL_A_RSS_START_CONTEXT,
 
 	__ETHTOOL_A_RSS_CNT,
-	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
+	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1)
 };
 
 enum {
@@ -662,8 +685,8 @@ enum {
 };
 
 enum {
-	ETHTOOL_MSG_USER_NONE,
-	ETHTOOL_MSG_STRSET_GET,
+	ETHTOOL_MSG_USER_NONE = 0,
+	ETHTOOL_MSG_STRSET_GET = 1,
 	ETHTOOL_MSG_LINKINFO_GET,
 	ETHTOOL_MSG_LINKINFO_SET,
 	ETHTOOL_MSG_LINKMODES_GET,
@@ -710,12 +733,12 @@ enum {
 	ETHTOOL_MSG_PHY_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
-	ETHTOOL_MSG_USER_MAX = __ETHTOOL_MSG_USER_CNT - 1
+	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
 };
 
 enum {
-	ETHTOOL_MSG_KERNEL_NONE,
-	ETHTOOL_MSG_STRSET_GET_REPLY,
+	ETHTOOL_MSG_KERNEL_NONE = 0,
+	ETHTOOL_MSG_STRSET_GET_REPLY = 1,
 	ETHTOOL_MSG_LINKINFO_GET_REPLY,
 	ETHTOOL_MSG_LINKINFO_NTF,
 	ETHTOOL_MSG_LINKMODES_GET_REPLY,
@@ -763,7 +786,7 @@ enum {
 	ETHTOOL_MSG_PHY_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
-	ETHTOOL_MSG_KERNEL_MAX = __ETHTOOL_MSG_KERNEL_CNT - 1
+	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
 };
 
 #endif /* _UAPI_LINUX_ETHETOOL_NETLINK_GENERATED_H */
-- 
2.47.0


