Return-Path: <netdev+bounces-222697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28BB5572F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A580A03A31
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D1343D95;
	Fri, 12 Sep 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/yFJEa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223D340DAB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706849; cv=none; b=QeZ7S+wV5yz44ZGSjrABhK1KvB4W8tGbd5GQFA6pYWJ58q60xvUIZs0EeHinvvnf8YZb+KKNecEbmybk3LoA6XHLfCmc+LCMnxhxzJjCAMijUCvDoRHPn5Mp1vvEeI4f90kW9BNswklZULTsLfTRdoifwO00159TE0VuFCfarHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706849; c=relaxed/simple;
	bh=LDIDm6amXRvxKfZLhIo6Dy6odk1hkniA5SESLkBZmT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLr6h8TvSxexx7GnKUCGYWqaXKF+/WuMYgkCGB+FDq3FJ4g1ygGkStnZ4tk+AA70zr6gTZyEzZ/2fDP9NSSuV5xquzqKSZ64EVuoTJQX0h9OvBDTlpcSroEDDnB/XBi+T2qnTZMt5+ZlNyaKXVt6nw5WeGjG2d4zfg+9n1XTF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/yFJEa9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1852227f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706845; x=1758311645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNO8VaIq1C1v07zJmcrQFMbo3suLUEzGA3AO6uFPvqU=;
        b=U/yFJEa9QyP6eTJV8mu8QyeVy0eBH+jEjUVCT+MchegCc8Q3g1A+sQd6dT4Jy8NDZT
         2Z+0D2tlW+bH44P8TszE7mM2YOPrOS8B+Zp+NDi5KNw7/x+BxMwFk07ExIf6mJHtAAXT
         OpfAM1HNr52yDYEoePbxyRZ6Wn1cx0INRizGnaqj4q4AfTG1I6gSQQJriIjqOYcPhfO3
         wJlLaQp3QhubgXdTfG2DdfYQJlG0akWPEd/1cJi4tPar00JQ5CXpKSRJv/1IivCAwQ2D
         HYzSWAYPqrLvFwTc1LXEdKlEaSpakaJ+jJSqWFWk5PgN5B5YY2i7BYhyRan4HCqwyTkj
         p1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706845; x=1758311645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNO8VaIq1C1v07zJmcrQFMbo3suLUEzGA3AO6uFPvqU=;
        b=b4M532O4liE/T237Ps4zWWruYMCCbhGjzamMQlCVsD5vWfYTAM7VzM5k2Bj4N3s03x
         D6spZQ2FrHwD8tRnHMcDzGmMw7UGtQKq/cH68trJly7+/tq/C7SyHSmxZ/K43EbS5LCO
         M8aAKkExD+uHKVJuZ2QC3ORTWuKEMwhBvGq5mA0JCSH6vdEolVK60AdqTepX6WrGabtB
         8xEgpCOFpPjkNTZIML5Lr0SNZKNbvikZbMOL3LP4moF1Sd9OG2nFv0ntiVHMjVK7mw3E
         DiBFflsHeZkBjGOE01mZN4EHHforh4HLO7mw47zZC7rkJXqfy6gQecDsp3ZI3+q8Z2IZ
         x7wg==
X-Forwarded-Encrypted: i=1; AJvYcCVTEDHP1/pTs4mGxZwz9JXZqtQV4Z0/GVXFfONAtOsO2IBcygXcFOvq2HU3hKwEFgymeYhbY50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAhRPVBMcDBc2bAqTyCqsEYvDufi6MRH5xZfRdJyy3tRhh8aV
	EVJtimu2JDZ4+7h0zVT7zK/hOmUumddkjJu1bDUgb42dY5keEVxlWLrL
X-Gm-Gg: ASbGncsXEb6mV9Y33iZuYTpYXH42cqn1x3Wc0UEr/T7sAckWjg77hnofstJF2odKUrB
	MeX6ZGoulIk0cn4x/bdfm5dYrCtfgyhnkzR30IjwEfdY65Rb7qYXr/3FhmIhkJvQzoQbyK1spK6
	30bgQwQrP8LrMlKf/rvOuzwNY628ftrPtz/knRybPjy6FilxSaVgiYYtw8z3DvWSMdcQCxGIkfl
	/fN2i27MYxqm4kscpt9fBrbqA4oWMFB4lekR7s1y/Ymw770+LbrVezj3S/KVC5r3CXxSwb32OUy
	yLzDFqKZRh0q2bEmXTvBA1cIZwrMbCrhs+/9p+eVqUnGBXNJHmTvOcpCUTUhm2F/xpT4omSZ2oG
	pLewK0ktyFIl6P1N4AM7JooFUDek3IyyRj7jG5Z2s1t7ZjGF9W/3bC37IzrBm5A==
X-Google-Smtp-Source: AGHT+IGz1qVTn0To3grwW4TfAfgqimwJnbIU2emM/F6SBm49eHIR3hDrHSQxK4zAZ9ajlAEeYcN81g==
X-Received: by 2002:a05:6000:208a:b0:3d7:eb95:b1e1 with SMTP id ffacd0b85a97d-3e7659eb4admr2844230f8f.32.1757706844710;
        Fri, 12 Sep 2025 12:54:04 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:04 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 09/15] genetlink: add LARGE_GENL stress test family
Date: Fri, 12 Sep 2025 22:53:32 +0300
Message-Id: <20250912195339.20635-10-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added new test family with 190+ multicast groups to verify:
- Handling of large number of multicast groups
- Family registration with many groups

The family serves as a stress test for Generic Netlink scalability.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 468 +++++++++++++++++-
 1 file changed, 467 insertions(+), 1 deletion(-)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index ad4228eda2d5..0023aeaf4d42 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1,4 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Netlink Test Module
+ *
+ * Implements test families for Generic Netlink functionality:
+ * - TEST_GENL: Basic commands with mutex protection
+ * - PARALLEL_GENL: Advanced ops with parallel dump support
+ * - THIRD_GENL: Simple message handling supporting many multicast groups
+ * - LARGE_GENL: Stress test with 190+ multicast groups
+ *
+ * Includes sysfs interfaces for manual testing and validation
+ * of error cases and edge conditions.
+ */
 
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -146,6 +158,7 @@ static struct kobj_attribute my_attr_str_third_genl =
 	__ATTR(message, 0664, show_third_genl_message, store_third_genl_message);
 
 static DEFINE_MUTEX(genl_mutex);
+static DEFINE_MUTEX(sysfs_mutex);
 
 #define MY_GENL_FAMILY_NAME "TEST_GENL"
 #define MY_GENL_VERSION 1
@@ -154,6 +167,8 @@ static DEFINE_MUTEX(genl_mutex);
 
 #define THIRD_GENL_FAMILY_NAME "THIRD_GENL"
 
+#define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
+
 #define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
 #define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
 #define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
@@ -920,6 +935,410 @@ static const struct genl_ops parallel_genl_ops[] = {
 	},
 };
 
+enum my_multicast_many_groups_one {
+	MCGRP_1,
+	MCGRP_2,
+	MCGRP_3,
+	MCGRP_4,
+	MCGRP_5,
+	MCGRP_6,
+	MCGRP_7,
+	MCGRP_8,
+	MCGRP_9,
+	MCGRP_10,
+	MCGRP_11,
+	MCGRP_12,
+	MCGRP_13,
+	MCGRP_14,
+	MCGRP_15,
+	MCGRP_16,
+	MCGRP_17,
+	MCGRP_18,
+	MCGRP_19,
+	MCGRP_20,
+	MCGRP_21,
+	MCGRP_22,
+	MCGRP_23,
+	MCGRP_24,
+	MCGRP_25,
+	MCGRP_26,
+	MCGRP_27,
+	MCGRP_28,
+	MCGRP_29,
+	MCGRP_30,
+	MCGRP_31,
+	MCGRP_32,
+	MCGRP_33,
+	MCGRP_34,
+	MCGRP_35,
+	MCGRP_36,
+	MCGRP_37,
+	MCGRP_38,
+	MCGRP_39,
+	MCGRP_40,
+	MCGRP_41,
+	MCGRP_42,
+	MCGRP_43,
+	MCGRP_44,
+	MCGRP_45,
+	MCGRP_46,
+	MCGRP_47,
+	MCGRP_48,
+	MCGRP_49,
+	MCGRP_50,
+	MCGRP_51,
+	MCGRP_52,
+	MCGRP_53,
+	MCGRP_54,
+	MCGRP_55,
+	MCGRP_56,
+	MCGRP_57,
+	MCGRP_58,
+	MCGRP_59,
+	MCGRP_60,
+	MCGRP_61,
+	MCGRP_62,
+	MCGRP_63,
+	MCGRP_64,
+	MCGRP_65,
+	MCGRP_66,
+	MCGRP_67,
+	MCGRP_68,
+	MCGRP_69,
+	MCGRP_70,
+	MCGRP_71,
+	MCGRP_72,
+	MCGRP_73,
+	MCGRP_74,
+	MCGRP_75,
+	MCGRP_76,
+	MCGRP_77,
+	MCGRP_78,
+	MCGRP_79,
+	MCGRP_80,
+	MCGRP_81,
+	MCGRP_82,
+	MCGRP_83,
+	MCGRP_84,
+	MCGRP_85,
+	MCGRP_86,
+	MCGRP_87,
+	MCGRP_88,
+	MCGRP_89,
+	MCGRP_90,
+	MCGRP_91,
+	MCGRP_92,
+	MCGRP_93,
+	MCGRP_94,
+	MCGRP_95,
+	MCGRP_96,
+	MCGRP_97,
+	MCGRP_98,
+	MCGRP_99,
+	MCGRP_100,
+	MCGRP_101,
+	MCGRP_102,
+	MCGRP_103,
+	MCGRP_104,
+	MCGRP_105,
+	MCGRP_106,
+	MCGRP_107,
+	MCGRP_108,
+	MCGRP_109,
+	MCGRP_110,
+	MCGRP_111,
+	MCGRP_112,
+	MCGRP_113,
+	MCGRP_114,
+	MCGRP_115,
+	MCGRP_116,
+	MCGRP_117,
+	MCGRP_118,
+	MCGRP_119,
+	MCGRP_120,
+	MCGRP_121,
+	MCGRP_122,
+	MCGRP_123,
+	MCGRP_124,
+	MCGRP_125,
+	MCGRP_126,
+	MCGRP_127,
+	MCGRP_128,
+	MCGRP_129,
+	MCGRP_130,
+	MCGRP_131,
+	MCGRP_132,
+	MCGRP_133,
+	MCGRP_134,
+	MCGRP_135,
+	MCGRP_136,
+	MCGRP_137,
+	MCGRP_138,
+	MCGRP_139,
+	MCGRP_140,
+	MCGRP_141,
+	MCGRP_142,
+	MCGRP_143,
+	MCGRP_144,
+	MCGRP_145,
+	MCGRP_146,
+	MCGRP_147,
+	MCGRP_148,
+	MCGRP_149,
+	MCGRP_150,
+	MCGRP_151,
+	MCGRP_152,
+	MCGRP_153,
+	MCGRP_154,
+	MCGRP_155,
+	MCGRP_156,
+	MCGRP_157,
+	MCGRP_158,
+	MCGRP_159,
+	MCGRP_160,
+	MCGRP_161,
+	MCGRP_162,
+	MCGRP_163,
+	MCGRP_164,
+	MCGRP_165,
+	MCGRP_166,
+	MCGRP_167,
+	MCGRP_168,
+	MCGRP_169,
+	MCGRP_170,
+	MCGRP_171,
+	MCGRP_172,
+	MCGRP_173,
+	MCGRP_174,
+	MCGRP_175,
+	MCGRP_176,
+	MCGRP_177,
+	MCGRP_178,
+	MCGRP_179,
+	MCGRP_180,
+	MCGRP_181,
+	MCGRP_182,
+	MCGRP_183,
+	MCGRP_184,
+	MCGRP_185,
+	MCGRP_186,
+	MCGRP_187,
+	MCGRP_188,
+	MCGRP_189,
+	MCGRP_190,
+	MCGRP_191,
+	MCGRP_192,
+	MCGRP_193,
+	MCGRP_194,
+	MCGRP_195,
+	MCGRP_196,
+	MCGRP_197,
+	MCGRP_198,
+	MCGRP_199,
+};
+
+static const struct genl_multicast_group genl_many_mcgrps_one[] = {
+	[MCGRP_1] = { .name = "MCGRP_1", },
+	[MCGRP_2] = { .name = "MCGRP_2", },
+	[MCGRP_3] = { .name = "MCGRP_3", },
+	[MCGRP_4] = { .name = "MCGRP_4", },
+	[MCGRP_5] = { .name = "MCGRP_5", },
+	[MCGRP_6] = { .name = "MCGRP_6", },
+	[MCGRP_7] = { .name = "MCGRP_7", },
+	[MCGRP_8] = { .name = "MCGRP_8", },
+	[MCGRP_9] = { .name = "MCGRP_9", },
+	[MCGRP_10] = { .name = "MCGRP_10", },
+	[MCGRP_11] = { .name = "MCGRP_11", },
+	[MCGRP_12] = { .name = "MCGRP_12", },
+	[MCGRP_13] = { .name = "MCGRP_13", },
+	[MCGRP_14] = { .name = "MCGRP_14", },
+	[MCGRP_15] = { .name = "MCGRP_15", },
+	[MCGRP_16] = { .name = "MCGRP_16", },
+	[MCGRP_17] = { .name = "MCGRP_17", },
+	[MCGRP_18] = { .name = "MCGRP_18", },
+	[MCGRP_19] = { .name = "MCGRP_19", },
+	[MCGRP_20] = { .name = "MCGRP_20", },
+	[MCGRP_21] = { .name = "MCGRP_21", },
+	[MCGRP_22] = { .name = "MCGRP_22", },
+	[MCGRP_23] = { .name = "MCGRP_23", },
+	[MCGRP_24] = { .name = "MCGRP_24", },
+	[MCGRP_25] = { .name = "MCGRP_25", },
+	[MCGRP_26] = { .name = "MCGRP_26", },
+	[MCGRP_27] = { .name = "MCGRP_27", },
+	[MCGRP_28] = { .name = "MCGRP_28", },
+	[MCGRP_29] = { .name = "MCGRP_29", },
+	[MCGRP_30] = { .name = "MCGRP_30", },
+	[MCGRP_31] = { .name = "MCGRP_31", },
+	[MCGRP_32] = { .name = "MCGRP_32", },
+	[MCGRP_33] = { .name = "MCGRP_33", },
+	[MCGRP_34] = { .name = "MCGRP_34", },
+	[MCGRP_35] = { .name = "MCGRP_35", },
+	[MCGRP_36] = { .name = "MCGRP_36", },
+	[MCGRP_37] = { .name = "MCGRP_37", },
+	[MCGRP_38] = { .name = "MCGRP_38", },
+	[MCGRP_39] = { .name = "MCGRP_39", },
+	[MCGRP_40] = { .name = "MCGRP_40", },
+	[MCGRP_41] = { .name = "MCGRP_41", },
+	[MCGRP_42] = { .name = "MCGRP_42", },
+	[MCGRP_43] = { .name = "MCGRP_43", },
+	[MCGRP_44] = { .name = "MCGRP_44", },
+	[MCGRP_45] = { .name = "MCGRP_45", },
+	[MCGRP_46] = { .name = "MCGRP_46", },
+	[MCGRP_47] = { .name = "MCGRP_47", },
+	[MCGRP_48] = { .name = "MCGRP_48", },
+	[MCGRP_49] = { .name = "MCGRP_49", },
+	[MCGRP_50] = { .name = "MCGRP_50", },
+	[MCGRP_51] = { .name = "MCGRP_51", },
+	[MCGRP_52] = { .name = "MCGRP_52", },
+	[MCGRP_53] = { .name = "MCGRP_53", },
+	[MCGRP_54] = { .name = "MCGRP_54", },
+	[MCGRP_55] = { .name = "MCGRP_55", },
+	[MCGRP_56] = { .name = "MCGRP_56", },
+	[MCGRP_57] = { .name = "MCGRP_57", },
+	[MCGRP_58] = { .name = "MCGRP_58", },
+	[MCGRP_59] = { .name = "MCGRP_59", },
+	[MCGRP_60] = { .name = "MCGRP_60", },
+	[MCGRP_61] = { .name = "MCGRP_61", },
+	[MCGRP_62] = { .name = "MCGRP_62", },
+	[MCGRP_63] = { .name = "MCGRP_63", },
+	[MCGRP_64] = { .name = "MCGRP_64", },
+	[MCGRP_65] = { .name = "MCGRP_65", },
+	[MCGRP_66] = { .name = "MCGRP_66", },
+	[MCGRP_67] = { .name = "MCGRP_67", },
+	[MCGRP_68] = { .name = "MCGRP_68", },
+	[MCGRP_69] = { .name = "MCGRP_69", },
+	[MCGRP_70] = { .name = "MCGRP_70", },
+	[MCGRP_71] = { .name = "MCGRP_71", },
+	[MCGRP_72] = { .name = "MCGRP_72", },
+	[MCGRP_73] = { .name = "MCGRP_73", },
+	[MCGRP_74] = { .name = "MCGRP_74", },
+	[MCGRP_75] = { .name = "MCGRP_75", },
+	[MCGRP_76] = { .name = "MCGRP_76", },
+	[MCGRP_77] = { .name = "MCGRP_77", },
+	[MCGRP_78] = { .name = "MCGRP_78", },
+	[MCGRP_79] = { .name = "MCGRP_79", },
+	[MCGRP_80] = { .name = "MCGRP_80", },
+	[MCGRP_81] = { .name = "MCGRP_81", },
+	[MCGRP_82] = { .name = "MCGRP_82", },
+	[MCGRP_83] = { .name = "MCGRP_83", },
+	[MCGRP_84] = { .name = "MCGRP_84", },
+	[MCGRP_85] = { .name = "MCGRP_85", },
+	[MCGRP_86] = { .name = "MCGRP_86", },
+	[MCGRP_87] = { .name = "MCGRP_87", },
+	[MCGRP_88] = { .name = "MCGRP_88", },
+	[MCGRP_89] = { .name = "MCGRP_89", },
+	[MCGRP_90] = { .name = "MCGRP_90", },
+	[MCGRP_91] = { .name = "MCGRP_91", },
+	[MCGRP_92] = { .name = "MCGRP_92", },
+	[MCGRP_93] = { .name = "MCGRP_93", },
+	[MCGRP_94] = { .name = "MCGRP_94", },
+	[MCGRP_95] = { .name = "MCGRP_95", },
+	[MCGRP_96] = { .name = "MCGRP_96", },
+	[MCGRP_97] = { .name = "MCGRP_97", },
+	[MCGRP_98] = { .name = "MCGRP_98", },
+	[MCGRP_99] = { .name = "MCGRP_99", },
+	[MCGRP_100] = { .name = "MCGRP_100", },
+	[MCGRP_101] = { .name = "MCGRP_101", },
+	[MCGRP_102] = { .name = "MCGRP_102", },
+	[MCGRP_103] = { .name = "MCGRP_103", },
+	[MCGRP_104] = { .name = "MCGRP_104", },
+	[MCGRP_105] = { .name = "MCGRP_105", },
+	[MCGRP_106] = { .name = "MCGRP_106", },
+	[MCGRP_107] = { .name = "MCGRP_107", },
+	[MCGRP_108] = { .name = "MCGRP_108", },
+	[MCGRP_109] = { .name = "MCGRP_109", },
+	[MCGRP_110] = { .name = "MCGRP_100", },
+	[MCGRP_111] = { .name = "MCGRP_111", },
+	[MCGRP_112] = { .name = "MCGRP_112", },
+	[MCGRP_113] = { .name = "MCGRP_113", },
+	[MCGRP_114] = { .name = "MCGRP_114", },
+	[MCGRP_115] = { .name = "MCGRP_115", },
+	[MCGRP_116] = { .name = "MCGRP_116", },
+	[MCGRP_117] = { .name = "MCGRP_117", },
+	[MCGRP_118] = { .name = "MCGRP_118", },
+	[MCGRP_119] = { .name = "MCGRP_119", },
+	[MCGRP_120] = { .name = "MCGRP_120", },
+	[MCGRP_121] = { .name = "MCGRP_121", },
+	[MCGRP_122] = { .name = "MCGRP_122", },
+	[MCGRP_123] = { .name = "MCGRP_123", },
+	[MCGRP_124] = { .name = "MCGRP_124", },
+	[MCGRP_125] = { .name = "MCGRP_125", },
+	[MCGRP_126] = { .name = "MCGRP_126", },
+	[MCGRP_127] = { .name = "MCGRP_127", },
+	[MCGRP_128] = { .name = "MCGRP_128", },
+	[MCGRP_129] = { .name = "MCGRP_129", },
+	[MCGRP_130] = { .name = "MCGRP_130", },
+	[MCGRP_131] = { .name = "MCGRP_131", },
+	[MCGRP_132] = { .name = "MCGRP_132", },
+	[MCGRP_133] = { .name = "MCGRP_133", },
+	[MCGRP_134] = { .name = "MCGRP_134", },
+	[MCGRP_135] = { .name = "MCGRP_135", },
+	[MCGRP_136] = { .name = "MCGRP_136", },
+	[MCGRP_137] = { .name = "MCGRP_137", },
+	[MCGRP_138] = { .name = "MCGRP_138", },
+	[MCGRP_139] = { .name = "MCGRP_139", },
+	[MCGRP_140] = { .name = "MCGRP_140", },
+	[MCGRP_141] = { .name = "MCGRP_141", },
+	[MCGRP_142] = { .name = "MCGRP_142", },
+	[MCGRP_143] = { .name = "MCGRP_143", },
+	[MCGRP_144] = { .name = "MCGRP_144", },
+	[MCGRP_145] = { .name = "MCGRP_145", },
+	[MCGRP_146] = { .name = "MCGRP_146", },
+	[MCGRP_147] = { .name = "MCGRP_147", },
+	[MCGRP_148] = { .name = "MCGRP_148", },
+	[MCGRP_149] = { .name = "MCGRP_149", },
+	[MCGRP_150] = { .name = "MCGRP_150", },
+	[MCGRP_151] = { .name = "MCGRP_151", },
+	[MCGRP_152] = { .name = "MCGRP_152", },
+	[MCGRP_153] = { .name = "MCGRP_153", },
+	[MCGRP_154] = { .name = "MCGRP_154", },
+	[MCGRP_155] = { .name = "MCGRP_155", },
+	[MCGRP_156] = { .name = "MCGRP_156", },
+	[MCGRP_157] = { .name = "MCGRP_157", },
+	[MCGRP_158] = { .name = "MCGRP_158", },
+	[MCGRP_159] = { .name = "MCGRP_159", },
+	[MCGRP_160] = { .name = "MCGRP_160", },
+	[MCGRP_161] = { .name = "MCGRP_161", },
+	[MCGRP_162] = { .name = "MCGRP_162", },
+	[MCGRP_163] = { .name = "MCGRP_163", },
+	[MCGRP_164] = { .name = "MCGRP_164", },
+	[MCGRP_165] = { .name = "MCGRP_165", },
+	[MCGRP_166] = { .name = "MCGRP_166", },
+	[MCGRP_167] = { .name = "MCGRP_167", },
+	[MCGRP_168] = { .name = "MCGRP_168", },
+	[MCGRP_169] = { .name = "MCGRP_169", },
+	[MCGRP_170] = { .name = "MCGRP_170", },
+	[MCGRP_171] = { .name = "MCGRP_171", },
+	[MCGRP_172] = { .name = "MCGRP_172", },
+	[MCGRP_173] = { .name = "MCGRP_173", },
+	[MCGRP_174] = { .name = "MCGRP_174", },
+	[MCGRP_175] = { .name = "MCGRP_175", },
+	[MCGRP_176] = { .name = "MCGRP_176", },
+	[MCGRP_177] = { .name = "MCGRP_177", },
+	[MCGRP_178] = { .name = "MCGRP_178", },
+	[MCGRP_179] = { .name = "MCGRP_179", },
+	[MCGRP_180] = { .name = "MCGRP_180", },
+	[MCGRP_181] = { .name = "MCGRP_181", },
+	[MCGRP_182] = { .name = "MCGRP_182", },
+	[MCGRP_183] = { .name = "MCGRP_183", },
+	[MCGRP_184] = { .name = "MCGRP_184", },
+	[MCGRP_185] = { .name = "MCGRP_185", },
+	[MCGRP_186] = { .name = "MCGRP_186", },
+	[MCGRP_187] = { .name = "MCGRP_187", },
+	[MCGRP_188] = { .name = "MCGRP_188", },
+	[MCGRP_189] = { .name = "MCGRP_189", },
+	[MCGRP_190] = { .name = "MCGRP_190", },
+	[MCGRP_191] = { .name = "MCGRP_191", },
+	[MCGRP_192] = { .name = "MCGRP_192", },
+	[MCGRP_193] = { .name = "MCGRP_193", },
+	[MCGRP_194] = { .name = "MCGRP_194", },
+	[MCGRP_195] = { .name = "MCGRP_195", },
+	[MCGRP_196] = { .name = "MCGRP_196", },
+	[MCGRP_197] = { .name = "MCGRP_197", },
+	[MCGRP_198] = { .name = "MCGRP_198", },
+	[MCGRP_199] = { .name = "MCGRP_199", },
+};
+
 enum my_multicast_many_groups_two {
 	MCGRP_TWO_1,
 	MCGRP_TWO_2,
@@ -1170,6 +1589,43 @@ static struct genl_family third_genl_family = {
 	.policy = third_genl_policy,
 };
 
+// LARGE_GENL
+enum {
+	LARGE_GENL_CMD_UNSPEC,
+	LARGE_GENL_CMD_ECHO,
+	__LARGE_GENL_CMD_MAX,
+};
+
+#define LARGE_GENL_CMD_MAX (__LARGE_GENL_CMD_MAX - 1)
+
+static int large_genl_echo(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
+// Generic Netlink operations for LARGE_GENL family
+static const struct genl_ops large_genl_ops[] = {
+	{
+		.cmd = LARGE_GENL_CMD_ECHO,
+		.flags = 0,
+		.doit = large_genl_echo,
+		.dumpit = NULL,
+	},
+};
+
+// genl_family struct for LARGE_GENL family
+static struct genl_family large_genl_family = {
+	.hdrsize = 0,
+	.name = LARGE_GENL_FAMILY_NAME,
+	.version = 1,
+	.maxattr = 1,
+	.netnsok = true,
+	.ops = large_genl_ops,
+	.n_ops = ARRAY_SIZE(large_genl_ops),
+	.mcgrps = genl_many_mcgrps_one,
+	.n_mcgrps = ARRAY_SIZE(genl_many_mcgrps_one),
+};
+
 // genl_family struct with incorrect name
 static struct genl_family incorrect_genl_family = {
 	.hdrsize = 0,
@@ -1237,14 +1693,22 @@ static int __init init_netlink(void)
 		goto failure_2;
 	}
 
-	rc = genl_register_family(&third_genl_family);
+	rc = genl_register_family(&large_genl_family);
 	if (rc) {
 		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
 		goto failure_3;
 	}
 
+	rc = genl_register_family(&third_genl_family);
+	if (rc) {
+		pr_err("%s: Failed to register Generic Netlink family\n", __func__);
+		goto failure_4;
+	}
+
 	return 0;
 
+failure_4:
+	genl_unregister_family(&large_genl_family);
 failure_3:
 	genl_unregister_family(&my_genl_family_parallel);
 failure_2:
@@ -1417,6 +1881,7 @@ static int __init module_netlink_init(void)
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
 	genl_unregister_family(&third_genl_family);
+	genl_unregister_family(&large_genl_family);
 err_sysfs:
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
@@ -1437,6 +1902,7 @@ static void __exit module_netlink_exit(void)
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
 	genl_unregister_family(&third_genl_family);
+	genl_unregister_family(&large_genl_family);
 
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
-- 
2.34.1


