Return-Path: <netdev+bounces-145382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87899CF520
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B930AB2E924
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA061EF0A1;
	Fri, 15 Nov 2024 19:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB61E9070;
	Fri, 15 Nov 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699420; cv=none; b=IFOwDusYJindW9Zo83BIin4CIeM+/hoSvVZJJtW6R8pJfe8JT0Mh6uEP1Kn+/XqxGe1xp6FKkI3pCqUUU5/gINk8DFY7okClB8wcwbc5ZG7eYD00tGYC16rAVJvSF5UsC3qdawAW0cTaUPlehWeymWfIbT0/UTwDkf5mOHi5iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699420; c=relaxed/simple;
	bh=6khiq3yXTa9HM+YXzRRSDhDky+b64/R6gVvEZ8PFbXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b78cWuTYBdymyRlKAnJbFP76XHtpBuxBLRPR47l3qrTfjHKpmWXZNeGJSddE4n3/sM1LF6VovIJPOvfGH4vdgAtiWTP8ihjIYBlBdNsqzSx+NU6YyclUzYhczMtKXRBLg4KuXWwK56rmkVJ81sQBd0EBJo5TXP4cJZoI8MRUHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso18837585ad.0;
        Fri, 15 Nov 2024 11:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699418; x=1732304218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8BPg7KRGyJdIlqb8wJdyBcPIhFm57LQPp6Ued82Nok=;
        b=kdEpMnS7kR78IDGOyudqcX+OaHwOXz2cf0o84uZEqRALAOZ42O68VsFP/8IQLHMbnV
         BE/nj7MQxxwmrlN5kY7ZLO/VfA7tNmf/f0wYA1n966j+kMAANBmNUeDK7QIcWvfzIm2x
         hk0cNBZsaho/qCOLkw4upycPsbywUnAKVCQd2ob3rqFKZaeTYX5BhxNCciEDt8HfrLow
         JZygL/R/qrmx7I+0sAGZuO9nleyFNLZnJ/tF+ANyRoy6W7IYx9j0Sgcx/dMcsN97o0p9
         lVqVJlcYa0IuUI0XQt4MnRJMUf0ZzTDAqqU785bJZ+EYw7D2sQT84/q/dBaMWvTBmxD+
         1JUw==
X-Forwarded-Encrypted: i=1; AJvYcCVCHIg20k4j44m6oUg6S3gx9f2GsQUrIOCrIQJ+flg1C1KX3dQ0d8301aBqGGPSyzSUE8Li0GVBUeC0r7bk@vger.kernel.org, AJvYcCWMKq9I74vN5mZY+STGHHAEBJCnVNEypF4zcAepyQLAFyebHp0XWqtjEXzlLSMGQfNINkI3mTvUe4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+oyJpNQws9Sqbp1jdFP6JH8DDJ3Cu6GLoKfWofZbGOdZplk+
	nyIM6vaxE60zstOQU9ydPOCZ1vomn23gySgu+wONYr0JPOvExEBH90DtXbc=
X-Google-Smtp-Source: AGHT+IGbOf8VlOGEd8kW1RivI3s5HpVjnIcSCbKLnAGLRrMXvOrSWevphsDVMDE7iRMiBJ/iM9Uxeg==
X-Received: by 2002:a17:903:244b:b0:20c:c18f:c39e with SMTP id d9443c01a7336-211c0fab017mr127039225ad.21.1731699418053;
        Fri, 15 Nov 2024 11:36:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d5asm1792788b3a.126.2024.11.15.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:57 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net-next v2 8/8] ethtool: regenerate uapi header from the spec
Date: Fri, 15 Nov 2024 11:36:46 -0800
Message-ID: <20241115193646.1340825-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115193646.1340825-1-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
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
index 35a24d490efe..b37b73609a0f 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -1,23 +1,43 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ethtool.yaml */
+/* YNL-GEN uapi header */
+
 #ifndef _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
 #define _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
 
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
 
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
-- 
2.47.0


