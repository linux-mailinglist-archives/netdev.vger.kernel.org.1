Return-Path: <netdev+bounces-201677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BBAEA886
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943D53B7AC8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660F23B611;
	Thu, 26 Jun 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4aWMfyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B519ABC6;
	Thu, 26 Jun 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971565; cv=none; b=rfqerrIdScWFjEgtOjbei3eET7ZYMK/MWxOPoONg1L43w0mvQtUmpU9RqiCrHCpJuJk0uxVnDeImIO0m3HSfpKqSgGB7V0Iy41/X5kfcpPn2cqfVuE0jIoG+t04RYlD+zJz0FEWAZyKBreenVf0jDkJHVpHG9C8piTRJOKxyHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971565; c=relaxed/simple;
	bh=oeA4d7EODEzIWkKM3TcMAMDpx54akwrFFbGC60hvPls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8xFCn8MJVgz9LFvgetFGAlIUhJyi9XoxZmaGO3/fVSLtXtshsijQ/JIJmKv/i9kYU3QAvx/KDDJTJDR66E/PQQxE7t51/Tw/4dllHzPPOi3WHGyYYY4jZmxJuvaVqh3pMvOwkDw1coKO+/aFbq4B23kZ3PI7oDAJ1n8NUc8TOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4aWMfyO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso14398985e9.3;
        Thu, 26 Jun 2025 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750971562; x=1751576362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVmPantCtDPOS6GFpn4yZPRnoxHGou6dQYIpZExYYJ8=;
        b=h4aWMfyO2AkDI0WtkxS7/7pSYMvp9jyRXUD7NCSHgDN9kAJc4/BL+KfNpLp8ZaND5s
         O5KaVNDHSQMi7baEaH1uQioqvBuXuAvTxbsq7QRk0VwF97cxEb3wuR8FMe/sTxUEDux3
         k0EgUGme9ndQwcxoCDuu1BPTU5IE+0Q/VjCsl4xNXz5IO6dVcejcUSKPArk11ioplnYg
         JNW10JkbqqgmXjeGG2uA/HggOp5o6S6hUU3QwOWWJG/DHMopnYUXld6BliUBoFtlH/E9
         WPI49WOZ+jycOAY65xtuvx2wNt0D6ZJrXj3Jzc+ZodpRTmhW68bY8f16p+q312xyGXEm
         ktyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750971562; x=1751576362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVmPantCtDPOS6GFpn4yZPRnoxHGou6dQYIpZExYYJ8=;
        b=lcCBYy5gxOFs9o681xbITpla2i0+/JgE6TGtlpoXdXJwIyFhFJUSH3xd0hnFn/tT0R
         9l/eI9R5E9vHks9kP0n4IGUGjIOFAc5NimAKDJmds/FBextDSJctRZTzkaI8cniYR/4L
         LIhcmY0l/nvnk/DjUM0r2LcJmLjMSTQHICMuUxaXBK5heuXZFwHC1fydydyWBVZ9+SxB
         HVRAsHkF9uuUdUeBzbxvaq3LLnLh2yl8Ga/YsIUfQca7Pogn/P5IFtrBkzTKxF4S7I1x
         8jbm0KNojR/7bX0YkiIRnZnPosowxT8BWBnvHcnJa6FswXlh8Nx2Ck5u45BHBwBtlyFs
         7UEA==
X-Forwarded-Encrypted: i=1; AJvYcCUoDAnAIbPAudbJFn1fpP+UOLOVDLynW/PC+Qnt7oeTmFTBTVQXICQ9Sm53gJxLIrRBemTJgI+5InZUTi8=@vger.kernel.org, AJvYcCX+wqx9Yd9rpBdHDiH8bxDV+RbQJktEIKBe+zIRC0tCYWJiOoY2zukoOEJVL5zMFbqsJe0IOWmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUhnl+GGkp01Gxe7pwAhLgfmnKm4MxgG1ZmYlNdHLLV8rjSKo
	zbp+1Q24E8C2NvCAfUZvSSz1LXSPSj511yfpDFB/W9xv4LoCV+GcxasA
X-Gm-Gg: ASbGncv1nZXiHp5FKu78IVUG4adGZWjJSTCBVbSau8pJKL3w1mV8m+oUHJknpS5vY53
	geW24PMhdXG0kuq/nfThlkTW1tXzO1n/w8dSBDFR0vjPSUz1xDJPbSnHu9Y2YeW2IaA0PlZWzlb
	a3V2linPYCNgjNU8Gng/xlsEUcJAOuzgQhuEObEbmq/Wl9ggzxc4xm27Eio9GcM9gVRv2zehOtq
	wghZtNsW6SBBVKruML7awpKM3ZPGziiLJFEQ3oqGGeiy+ktKjj3pecWLV+iXWUGqEqapnu3lSoA
	0WjC0UCSFpDvRCIVIcq4W3NSJPFHE6w4FIpZ2zwIRMb7HsfoE2bgDmX8
X-Google-Smtp-Source: AGHT+IEDk4eBlMXE3pUkWz+HwvErPLeuCNFck050sW5ZJ/ttCAOlFCLEQ8A2df63sks7Tm7EAnmcJQ==
X-Received: by 2002:a05:600c:4f13:b0:453:2433:1c5b with SMTP id 5b1f17b1804b1-4538ee15a9emr8268495e9.5.1750971561373;
        Thu, 26 Jun 2025 13:59:21 -0700 (PDT)
Received: from i5 ([2a02:3037:2e0:433:84f4:5fa6:763d:2e1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b382sm60721435e9.9.2025.06.26.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:59:21 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH] net: ieee8021q: fix insufficient table-size assertion
Date: Thu, 26 Jun 2025 22:59:07 +0200
Message-ID: <20250626205907.1566384-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_Static_assert(ARRAY_SIZE(map) != IEEE8021Q_TT_MAX - 1) rejects only a
length of 7 and allows any other mismatch. Replace it with a strict
equality test via a helper macro so that every mapping table must have
exactly IEEE8021Q_TT_MAX (8) entries.

Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 net/core/ieee8021q_helpers.c | 44 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index 759a9b9f3f898..669b357b73b2d 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -7,6 +7,11 @@
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
 
+/* verify that table covers all 8 traffic types */
+#define TT_MAP_SIZE_OK(tbl)                                 \
+	compiletime_assert(ARRAY_SIZE(tbl) == IEEE8021Q_TT_MAX, \
+			   #tbl " size mismatch")
+
 /* The following arrays map Traffic Types (TT) to traffic classes (TC) for
  * different number of queues as shown in the example provided by
  * IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic class mapping" and
@@ -101,51 +106,28 @@ int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 
 	switch (num_queues) {
 	case 8:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_8queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_8queue_tt_tc_map != max - 1");
+		TT_MAP_SIZE_OK(ieee8021q_8queue_tt_tc_map);
 		return ieee8021q_8queue_tt_tc_map[tt];
 	case 7:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_7queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_7queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_7queue_tt_tc_map);
 		return ieee8021q_7queue_tt_tc_map[tt];
 	case 6:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_6queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_6queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_6queue_tt_tc_map);
 		return ieee8021q_6queue_tt_tc_map[tt];
 	case 5:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_5queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_5queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_5queue_tt_tc_map);
 		return ieee8021q_5queue_tt_tc_map[tt];
 	case 4:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_4queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_4queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_4queue_tt_tc_map);
 		return ieee8021q_4queue_tt_tc_map[tt];
 	case 3:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_3queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_3queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_3queue_tt_tc_map);
 		return ieee8021q_3queue_tt_tc_map[tt];
 	case 2:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_2queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_2queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_2queue_tt_tc_map);
 		return ieee8021q_2queue_tt_tc_map[tt];
 	case 1:
-		compiletime_assert(ARRAY_SIZE(ieee8021q_1queue_tt_tc_map) !=
-				   IEEE8021Q_TT_MAX - 1,
-				   "ieee8021q_1queue_tt_tc_map != max - 1");
-
+		TT_MAP_SIZE_OK(ieee8021q_1queue_tt_tc_map);
 		return ieee8021q_1queue_tt_tc_map[tt];
 	}
 
-- 
2.50.0


